@echo off
rem Windows installer: creates .venv and installs FaceFusion, on GPU (CUDA 13) when an NVIDIA driver is found
setlocal
cd /d "%~dp0"

where python >nul 2>&1 || (echo python not found, install Python 3 and add it to PATH & pause & exit /b 1)
if not exist .venv\Scripts\python.exe python -m venv .venv || (echo venv creation failed & pause & exit /b 1)
call .venv\Scripts\activate.bat

rem ponytail: CUDA 13 only, needs NVIDIA driver 580+, add a cuda@12 branch if older drivers matter
where nvidia-smi >nul 2>&1 && set "ONNXRUNTIME=cuda@13" || set "ONNXRUNTIME=default"
python install.py %ONNXRUNTIME% --skip-conda
if %ONNXRUNTIME%==cuda@13 python -m pip install "onnxruntime-gpu[cuda,cudnn]"

python -c "import gradio, onnxruntime" || (echo installation failed & pause & exit /b 1)
echo installation done with %ONNXRUNTIME%, start with run.bat
pause
