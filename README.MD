# Pytorch to Tensorrt Model Converter

This project provides a comprehensive Python script to convert a PyTorch model to an ONNX model and then to a TensorRT engine for NVIDIA GPUs, followed by performing inference using the TensorRT engine. This script is designed to handle the entire conversion process seamlessly.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

# FOR NVIDIA GPU ONLY 

### Prerequisites

What things you need to install the software and how to install them.
- Python 3.11.6 or later
- PyTorch 1.6 or later
- TensorRT 7.0 or later
- CUDA Toolkit 10.2 or later

# YOLO PyTorch to TensorRT Conversion Logging

This script converts a YOLO PyTorch model to an ONNX model and then to a TensorRT engine. It also performs inference using the TensorRT engine. The logging setup helps track the execution process and outputs important information and errors.

## Logging Configuration

The script uses the Python `logging` module to log events. The logging is configured to output messages to the console with the following format:

Where:
- `YYYY-MM-DD HH:MM:SS,sss` is the timestamp
- `LEVEL` is the logging level (e.g., INFO, ERROR)
- `Message` is the log message

The logging level is set to `INFO`, meaning it will log messages with a severity of `INFO` and higher (e.g., `INFO`, `WARNING`, `ERROR`).

## What is Logged

### ONNX Model Export

1. **Exporting ONNX Model:**
   - **Message:** `ONNX model exported to {onnx_file_path}`
   - **Level:** INFO
   - **Description:** This logs the successful export of the PyTorch model to ONNX format.

### TensorRT Engine Building

2. **Parsing ONNX File:**
   - **Message:** `Failed to parse the ONNX file.`
   - **Level:** ERROR
   - **Description:** This logs an error if the ONNX parser fails to parse the ONNX file.

3. **ONNX Parsing Errors:**
   - **Message:** Details of the ONNX parsing errors.
   - **Level:** ERROR
   - **Description:** This logs specific errors encountered during the ONNX file parsing.

4. **Building TensorRT Engine:**
   - **Message:** `Failed to build the engine.`
   - **Level:** ERROR
   - **Description:** This logs an error if the TensorRT engine fails to build.

5. **Saving TensorRT Engine:**
   - **Message:** `TensorRT engine saved to {engine_file_path}`
   - **Level:** INFO
   - **Description:** This logs the successful saving of the TensorRT engine to a file.

### Inference

6. **Inference Output:**
   - **Message:** `Inference output: {output}`
   - **Level:** INFO
   - **Description:** This logs the output from performing inference with the TensorRT engine.

- You will see the log messages in the console, providing information about the execution process and any issues encountered.

## Example Output

- Here is an example of what the log output might look like:

```
[2024-07-17 12:34:56,789] - INFO - ONNX model exported to yolo_model.onnx
[2024-07-17 12:35:00,123] - INFO - TensorRT engine saved to yolo_model.trt
[2024-07-17 12:35:05,456] - INFO - Inference output: [array([[[...]]])]
```

### Installing

A step-by-step series of examples that tell you how to get a development environment running.

### For Users Familiar with Pipfile and Pipenv

If you are familiar with Pipfile and wish to use `pipenv` for managing dependencies, ensure you have Python `3.11.6`

- If you do not have `Pet Python` Recommended **Python 3.11.6** [Python 3.11.6](https://github.com/KernFerm/Py3.11.6installer)

1. **Install pipenv if you haven't already:**

```
pip install pipenv
```

2. Clone the Repository:

```
git clone https://www.github.com/kernferm/pytorch-to-tensorrt-model-converter
cd pytorch-to-tensorrt-model-converter
```

3. Install Dependencies:

```
pipenv install
```

4. Activate the Virtual Environment:

```
pipenv shell
```

## For Users Not Using Pipenv

- If you prefer not to use pipenv, follow these instructions:

1. Clone the Repository:

```
git clone https://www.github.com/kernferm/pytorch-to-tensorrt-model-converter
cd pytorch-to-tensorrt-model-converter
```

2. Create and Activate a Virtual Environment:

- On Windows:

```
python -m venv venv
.\venv\Scripts\activate
```

- On Unix or MacOS:

```
python3 -m venv venv
source venv/bin/activate
```

3. Install Dependencies:

```
pip install torch torchvision tensorrt pycuda numpy
```
or you can use the `requirements.bat` or the `requirements.txt`

## Running the Program

After setting up your environment, you can run the program as follows:

1. **Activate the Virtual Environment:**

   If you're using `pipenv`, ensure your virtual environment is activated:

   ```bash
   pipenv shell
   ```

   If you're using a traditional virtual environment:

   - On Windows:

     ```cmd
     .\venv\Scripts\activate
     ```

   - On Unix or MacOS:

     ```bash
     source venv/bin/activate
     ```

2. **Run the Program:**

   Replace `main.py` with the name of your program file if it's different.

   ```bash
   python main.py
   ```

   Follow any program-specific instructions or command line arguments as detailed in your project's documentation.

