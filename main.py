import torch
import torch.onnx
import tensorrt as trt
import pycuda.driver as cuda
import pycuda.autoinit
import numpy as np
import logging

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

TRT_LOGGER = trt.Logger(trt.Logger.WARNING)

def export_pytorch_to_onnx(model, dummy_input, onnx_file_path):
    torch.onnx.export(
        model, 
        dummy_input, 
        onnx_file_path, 
        export_params=True, 
        opset_version=11, 
        do_constant_folding=True, 
        input_names=['images'], 
        output_names=['output']
    )
    logger.info(f"ONNX model exported to {onnx_file_path}")

def build_engine(onnx_file_path, engine_file_path):
    with trt.Builder(TRT_LOGGER) as builder, builder.create_network(1) as network, trt.OnnxParser(network, TRT_LOGGER) as parser:
        builder.max_workspace_size = 1 << 30  # 1GB
        builder.max_batch_size = 1

        with open(onnx_file_path, 'rb') as model:
            if not parser.parse(model.read()):
                logger.error('Failed to parse the ONNX file.')
                for error in range(parser.num_errors):
                    logger.error(parser.get_error(error))
                return None

        engine = builder.build_cuda_engine(network)
        if engine is None:
            logger.error('Failed to build the engine.')
            return None

        with open(engine_file_path, 'wb') as f:
            f.write(engine.serialize())
        logger.info(f"TensorRT engine saved to {engine_file_path}")
        return engine

class HostDeviceMem:
    def __init__(self, host_mem, device_mem):
        self.host = host_mem
        self.device = device_mem

    def __str__(self):
        return "Host:\n" + str(self.host) + "\nDevice:\n" + str(self.device)

    def __repr__(self):
        return self.__str__()

def allocate_buffers(engine):
    inputs = []
    outputs = []
    bindings = []
    stream = cuda.Stream()

    for binding in engine:
        size = trt.volume(engine.get_binding_shape(binding)) * engine.max_batch_size
        dtype = trt.nptype(engine.get_binding_dtype(binding))
        host_mem = cuda.pagelocked_empty(size, dtype)
        device_mem = cuda.mem_alloc(host_mem.nbytes)
        bindings.append(int(device_mem))
        if engine.binding_is_input(binding):
            inputs.append(HostDeviceMem(host_mem, device_mem))
        else:
            outputs.append(HostDeviceMem(host_mem, device_mem))
    return inputs, outputs, bindings, stream

def do_inference(context, bindings, inputs, outputs, stream):
    [cuda.memcpy_htod_async(inp.device, inp.host, stream) for inp in inputs]
    context.execute_async_v2(bindings=bindings, stream_handle=stream.handle)
    [cuda.memcpy_dtoh_async(out.host, out.device, stream) for out in outputs]
    stream.synchronize()
    return [out.host for out in outputs]

def main():
    # Load your YOLO PyTorch model from a .pt file
    model = torch.load('yolov5s.pt')  # or 'yolov8s.pt'
    model.eval()

    # Dummy input for the YOLO model (replace with the appropriate input shape)
    dummy_input = torch.randn(1, 3, 640, 640)  # Typical input size for YOLO models
    # File paths
    onnx_file_path = 'yolo_model.onnx'
    engine_file_path = 'yolo_model.trt'

    # Export PyTorch model to ONNX
    export_pytorch_to_onnx(model, dummy_input, onnx_file_path)

    # Convert ONNX model to TensorRT engine
    engine = build_engine(onnx_file_path, engine_file_path)
    if engine is None:
        return

    # Load the TensorRT engine and perform inference
    with open(engine_file_path, 'rb') as f, trt.Runtime(TRT_LOGGER) as runtime:
        engine = runtime.deserialize_cuda_engine(f.read())

    context = engine.create_execution_context()
    inputs, outputs, bindings, stream = allocate_buffers(engine)

    # Example input data
    data = np.random.random((1, 3, 640, 640)).astype(np.float32)
    np.copyto(inputs[0].host, data.ravel())

    output = do_inference(context, bindings=bindings, inputs=inputs, outputs=outputs, stream=stream)
    logger.info("Inference output: %s", output)

if __name__ == "__main__":
    main()
