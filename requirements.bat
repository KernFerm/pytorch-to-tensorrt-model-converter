@echo off
echo Installing dependencies...

pip install torch
pip install pycuda
pip install numpy
pip install tensorrt

echo Dependencies installed successfully.