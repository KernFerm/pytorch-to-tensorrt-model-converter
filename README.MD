# Pytorch to TensorRT Model Converter

This project provides a comprehensive Python script to convert a PyTorch model to an ONNX model and then to a TensorRT engine for NVIDIA GPUs, followed by performing inference using the TensorRT engine. The script handles the entire conversion process seamlessly.

## How to Download the Repo for First-Time Users

To get started with this repository, please refer to the detailed instructions available [here](https://www.gitprojects.fnbubbles420.org/how-to-download-repos).

## Getting Started

These instructions will help you set up the project on your local machine for development and testing purposes.

### NVIDIA GPU Required

**Note:** This script is specifically designed to work with NVIDIA GPUs.

### Prerequisites

Before running the script, ensure you have the following software installed:

- **Python Version:** You only need one of the following versions installed:
  - [Python 3.11.6](https://github.com/KernFerm/Py3.11.6installer)
  - [Python 3.11.9](https://github.com/KernFerm/Py3.11.9installer)
  - [Python 3.12.1](https://github.com/KernFerm/Py3.12.1-installer-batch)
- **Frameworks & Libraries:**
  - PyTorch 1.6 or later
  - TensorRT 7.0 or later
  - CUDA Toolkit 10.2 or later

## Logging

The script includes a logging configuration to track the execution process and outputs important information and errors.

### Logging Configuration

- The script logs messages to the console in the following format: `YYYY-MM-DD HH:MM:SS,sss - LEVEL - Message`
- The logging level is set to `INFO`, capturing messages of severity `INFO` and higher.

### What is Logged

- **ONNX Model Export:**
  - Logs successful export of the PyTorch model to ONNX format.
- **TensorRT Engine Building:**
  - Logs errors during ONNX file parsing and engine building.
  - Logs successful saving of the TensorRT engine.
- **Inference:**
  - Logs the output from performing inference with the TensorRT engine.

### Example Log Output

```plaintext
[2024-07-17 12:34:56,789] - INFO - ONNX model exported to yolo_model.onnx
[2024-07-17 12:35:00,123] - INFO - TensorRT engine saved to yolo_model.trt
[2024-07-17 12:35:05,456] - INFO - Inference output: [array([[[...]]])]
```

### Installation
- Follow these steps to set up your development environment:

## For Users Familiar with `Pipfile` and `Pipenv`

- If you're familiar with pipenv and prefer to manage dependencies using a `Pipfile`:

1. Install pipenv if you haven't already:
```
pip install pipenv
```

2. Clone the Repository:
  - make sure to make a folder on `Desktop` then `CD` it in `CMD.exe` then do the `Git Clone`.
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
- If you prefer not to use `pipenv`, follow these instructions:

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
- **You can also use the provided `requirements.bat` or `requirements.txt` files.**

## Running the Program

- After setting up your environment, you can run the program as follows:


### Step 1: Place Your PyTorch Model

- **Model Location:** Place the PyTorch model you wish to convert in the root directory of the cloned repository.
- **Supported Formats:** The script expects the model to be in `.pt` format. `Example: yolov5s.pt.`

### Step 2: Update the Script

- **File to Update:** Edit the `main.py` script to point to your model file.
- **Code to Update:** 
Replace the following line in `main.py`:
```
model = torch.load('yolov5s.pt')  # or 'yolov8s.pt'
```
- with the path to your model:
```
model = torch.load('your_model_file.pt')
```

### Step 3: Activate the Virtual Environment
- If you're using `pipenv`, ensure your virtual environment is activated:
```
pipenv shell
```

- If you're using a traditional virtual environment:
- On Windows:
```
.\venv\Scripts\activate
```
- On Unix or MacOS:
```
source venv/bin/activate
```

### Step 4: Run the Program
- Run the script using the following command:

```
python main.py
```

### Step 5: Check Outputs

- **ONNX Model:** The ONNX model will be saved in the root directory with a `.onnx` extension.
- **TensorRT Engine:** The TensorRT engine will be saved in the root directory with a `.trt` extension.


## Contributions
- Feel free to contribute to this project by creating pull requests, submitting issues, or providing feedback.

## License
- This project is licensed under the [Apache License](https://github.com/KernFerm/pytorch-to-tensorrt-model-converter/blob/main/LICENSE)
