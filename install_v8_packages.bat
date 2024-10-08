@echo off
setlocal

REM Function to check and handle errors
:check_error
if %errorlevel% neq 0 (
    echo Error occurred: %1
    call :cleanup
    exit /b %errorlevel%
)

REM Function to clean up in case of failure
:cleanup
if exist venv_v8 (
    echo Cleaning up...
    rmdir /s /q venv_v8
)
goto :EOF

REM Check if Python is installed
echo Checking Python installation...
python --version >nul 2>&1
call :check_error "Python is not installed. Please install Python 3.11."

REM Create a virtual environment
echo Creating virtual environment for YOLO v8...
python -m venv venv_v8
call :check_error "Failed to create virtual environment."

REM Activate the virtual environment
echo Activating virtual environment...
call venv_v8\Scripts\activate.bat
call :check_error "Failed to activate virtual environment."

REM Upgrade pip
echo Upgrading pip...
python -m pip install --upgrade pip
call :check_error "Failed to upgrade pip."
echo [###-------] 20%% pip upgraded.

REM Install torch
echo Installing torch...
pip install torch
call :check_error "Failed to install torch."
echo [#####-----] 40%% Torch installed.

REM Install tensorrt
echo Installing tensorrt...
pip install tensorrt
call :check_error "Failed to install tensorrt."
echo [#######---] 60%% TensorRT installed.

REM Install pycuda
echo Installing pycuda...
pip install pycuda
call :check_error "Failed to install pycuda."
echo [#########-] 80%% PyCUDA installed.

REM Install numpy
echo Installing numpy...
pip install numpy
call :check_error "Failed to install numpy."
echo [##########] 100%% Numpy installed.

REM Deactivate the virtual environment
echo Deactivating virtual environment...
deactivate
call :check_error "Failed to deactivate virtual environment."

echo YOLO v8 packages installed successfully.

pause
echo Press any key to exit.
endlocal
exit /b 0
