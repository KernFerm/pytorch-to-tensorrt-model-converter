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

REM Function to ask user if they want to close the window
:ask_to_continue
set /p continue=Do you want to continue? (Y/N): 
if /I "%continue%"=="N" exit /b 0
if /I not "%continue%"=="Y" goto ask_to_continue

REM Check if Python is installed
echo Checking Python installation...
python --version >nul 2>&1
call :check_error "Python is not installed. Please install Python 3.11."
call :ask_to_continue

REM Create a virtual environment
echo Creating virtual environment for YOLO v5...
python -m venv venv_v5
call :check_error "Failed to create virtual environment."
call :ask_to_continue

REM Activate the virtual environment
echo Activating virtual environment...
call venv_v5\Scripts\activate
call :check_error "Failed to activate virtual environment."
call :ask_to_continue

REM Upgrade pip
echo Upgrading pip...
python -m pip install --upgrade pip
call :check_error "Failed to upgrade pip."
call :ask_to_continue

REM Install torch
echo Installing torch...
pip install torch
call :check_error "Failed to install torch."
call :ask_to_continue

REM Install tensorrt
echo Installing tensorrt...
pip install tensorrt
call :check_error "Failed to install tensorrt."
call :ask_to_continue

REM Install pycuda
echo Installing pycuda...
pip install pycuda
call :check_error "Failed to install pycuda."
call :ask_to_continue

REM Install numpy
echo Installing numpy...
pip install numpy
call :check_error "Failed to install numpy."
call :ask_to_continue

REM Deactivate the virtual environment
echo Deactivating virtual environment...
call deactivate
call :check_error "Failed to deactivate virtual environment."

echo YOLO v5 packages installed successfully.

pause

endlocal
exit /b 0
