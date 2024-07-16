@echo off
echo Checking for Python installation...

python --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Python is not installed. Please install Python and try again.
    exit /b 1
)

echo Checking for pip installation...

pip --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Pip is not installed. Please install pip and try again.
    exit /b 1
)

echo Installing dependencies...

pip install torch
if %ERRORLEVEL% NEQ 0 (
    echo Failed to install torch.
    exit /b 1
)

pip install pycuda
if %ERRORLEVEL% NEQ 0 (
    echo Failed to install pycuda.
    exit /b 1
)

pip install numpy
if %ERRORLEVEL% NEQ 0 (
    echo Failed to install numpy.
    exit /b 1
)

pip install tensorrt
if %ERRORLEVEL% NEQ 0 (
    echo Failed to install tensorrt.
    exit /b 1
)

echo Dependencies installed successfully.
