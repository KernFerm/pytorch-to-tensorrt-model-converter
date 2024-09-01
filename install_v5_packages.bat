@echo off
setlocal

REM Check if Python is installed
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python is not installed. Please install Python before running this script.
    pause
    exit /b 1
)

REM Create a virtual environment
echo Creating a virtual environment...
python -m venv venv_v5
if %errorlevel% neq 0 (
    echo Failed to create a virtual environment.
    pause
    exit /b 1
)

REM Activate the virtual environment
echo Activating the virtual environment...
call venv_v5\Scripts\activate
if %errorlevel% neq 0 (
    echo Failed to activate the virtual environment.
    pause
    exit /b 1
)

REM Upgrade pip
echo Upgrading pip...
python -m pip install --upgrade pip
if %errorlevel% neq 0 (
    echo Failed to upgrade pip.
    pause
    exit /b 1
)

REM Install required packages individually with progress
echo [----------] Installing packages: 0%%
pip install torch
if %errorlevel% neq 0 (
    echo Failed to install torch.
    pause
    exit /b 1
)
echo [##--------] 25%% Torch installed.

pip install tensorrt
if %errorlevel% neq 0 (
    echo Failed to install tensorrt.
    pause
    exit /b 1
)
echo [####------] 50%% TensorRT installed.

pip install pycuda
if %errorlevel% neq 0 (
    echo Failed to install pycuda.
    pause
    exit /b 1
)
echo [######----] 75%% PyCUDA installed.

pip install numpy
if %errorlevel% neq 0 (
    echo Failed to install numpy.
    pause
    exit /b 1
)
echo [##########] 100%% Numpy installed.

REM Completion message
echo All packages installed successfully. Close this window to exit.
pause
exit /b 0
