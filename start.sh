#!/bin/bash

echo "[INFO] Pod run-comfyui-ollama started"

# ssh scp ftp on (TCP port 22)

if [[ $PUBLIC_KEY ]]
then
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    cd ~/.ssh
    echo $PUBLIC_KEY >> authorized_keys
    chmod 700 -R ~/.ssh
    cd /
    service ssh start
fi

# Move necessary files to workspace
for script in comfyui-on-workspace.sh readme-on-workspace.sh provisioning-on-workspace.sh; do
    if [ -f "/$script" ]; then
        echo "Executing $script..."
        "/$script"
    else
        echo "Skipping $script (not found)"
    fi
done

# Start Servers
if [[ ${RUNPOD_GPU_COUNT:-0} -gt 0 ]]; then
    # Start code-server (HTTP port 9000)
    if [[ -n "$PASSWORD" ]]; then
        code-server /workspace --auth password --disable-telemetry --host 0.0.0.0 --bind-addr 0.0.0.0:9000 &
    else
        echo "WARNING: PASSWORD is not set as an environment variable"
        code-server /workspace --disable-telemetry --host 0.0.0.0 --bind-addr 0.0.0.0:9000 &
    fi

    # Start ComfyUI (HTTP port 8188)
    python3 /workspace/ComfyUI/main.py ${COMFYUI_EXTRA_ARGUMENTS:---listen} &
	
	# Start ollama Server (http://127.0.0.1:11434)
    ollama serve &
else
    echo "WARNING: No GPU available, servers not started to limit memory use"
fi
	
# Login to Hugging Face if token is provided
if [[ -n "$HF_TOKEN" ]]; then
    huggingface-cli login --token "$HF_TOKEN"
else
	echo "WARNING: HF_TOKEN is not set as an environment variable"
fi

# Downloads

if [[ -n $OLLAMA_MODEL1 ]]
then
   ollama pull $OLLAMA_MODEL1
fi

if [[ -n $OLLAMA_MODEL2 ]]
then
   ollama pull $OLLAMA_MODEL2
fi

if [[ -n $OLLAMA_MODEL3 ]]
then
   ollama pull $OLLAMA_MODEL3
fi

if [[ -n $OLLAMA_MODEL4 ]]
then
   ollama pull $OLLAMA_MODEL4
fi

# Final message
echo "[INFO] Provisioning done end"

# Keep the container running
exec sleep infinity
