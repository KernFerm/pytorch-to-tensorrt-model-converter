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
if exist venv_v5 (
    echo Cleaning up...
    rmdir /s /q venv_v5
)
goto :EOF

REM Check if Python is installed
echo Checking Python installation...
python --version >nul 2>&1
call :check_error "Python is not installed. Please install Python 3.11."

REM Create a virtual environment
echo Creating virtual environment for YOLO v5...
python -m venv venv_v5
call :check_error "Failed to create virtual environment."

REM Activate the virtual environment
echo Activating virtual environment...
call venv_v5\Scripts\activate
call :check_error "Failed to activate virtual environment."

REM Upgrade pip
echo Upgrading pip...
python -m pip install --upgrade pip
call :check_error "Failed to upgrade pip."

REM Install torch
echo Installing torch...
pip install torch
call :check_error "Failed to install torch."

REM Install tensorrt
echo Installing tensorrt...
pip install tensorrt
call :check_error "Failed to install tensorrt."

REM Install pycuda
echo Installing pycuda...
pip install pycuda
call :check_error "Failed to install pycuda."

REM Install numpy
echo Installing numpy...
pip install numpy
call :check_error "Failed to install numpy."

REM Deactivate the virtual environment
echo Deactivating virtual environment...
call deactivate
call :check_error "Failed to deactivate virtual environment."

echo YOLO v5 packages installed successfully.

endlocal
exit /b 0
