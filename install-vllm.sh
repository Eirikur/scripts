#!/bin/bash
mkdir -p ~/Applications/vllm; cd ~/Applications/vllm


rm -rf .venv &> /dev/null
cd ~/Applications/vllm/ 
uv venv  --python 3.11
echo 'activate...'
source .venv/bin/activate
# uv pip install llvmlite 
uv pip install vllm --extra-index-url https://wheels.vllm.ai/0.15.1/cpu --torch-backend cpu
cd -
