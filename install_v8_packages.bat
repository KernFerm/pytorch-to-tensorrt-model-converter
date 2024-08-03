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

REM Install required packages
echo Installing required packages for YOLO v8...
pip install torch tensorrt pycuda numpy
call :check_error "Failed to install one or more packages."

REM Deactivate the virtual environment
echo Deactivating virtual environment...
deactivate
call :check_error "Failed to deactivate virtual environment."

echo YOLO v8 packages installed successfully.

endlocal
exit /b 0
