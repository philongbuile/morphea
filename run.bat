@echo off
rem Launch FaceFusion from .venv, the NVIDIA pip DLLs go on PATH so onnxruntime-gpu finds CUDA and cuDNN
setlocal
cd /d "%~dp0"
set "NVIDIA_PATH=%~dp0.venv\Lib\site-packages\nvidia"
set "PATH=%NVIDIA_PATH%\cu13\bin\x86_64;%NVIDIA_PATH%\cudnn\bin;%PATH%"
.venv\Scripts\python.exe facefusion.py run --open-browser %*
if errorlevel 1 pause
