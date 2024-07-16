# Nvidia Converter

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
git clone https://www.github.com/kernferm/nvidia-converter
cd nvidia-converter
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
git clone https://www.github.com/kernferm/nvidia-converter
cd nvidia-converter
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

