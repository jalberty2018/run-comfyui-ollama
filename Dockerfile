# Base image
FROM ls250824/comfyui-runtime:17032025 AS base

# Set working directory
WORKDIR /

# Copy scripts and make them executable (755)
COPY --chmod=755 start.sh /start.sh
COPY --chmod=755 onworkspace/ /onworkspace/

# Copy documentation with appropriate permissions
COPY --chmod=644 documentation/README.md /README.md
COPY --chmod=640 provisioning/provisioning.md /provisioning.md

# Copy workflows with read-only permissions (644)
COPY --chmod=644 workflows/ /ComfyUI/user/default/workflows/

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# Install required Python packages and clone custom ComfyUI nodes
RUN pip3 install --no-cache-dir opencv-python diffusers && \
    cd /ComfyUI/custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git && \
    git clone https://github.com/rgthree/rgthree-comfy.git && \
    git clone https://github.com/liusida/ComfyUI-Login.git && \
    git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git && \
    git clone https://github.com/DoctorDiffusion/ComfyUI-MediaMixer.git && \
    git clone https://github.com/kijai/ComfyUI-KJNodes.git && \
    git clone https://github.com/pydn/ComfyUI-to-Python-Extension.git && \
    git clone https://github.com/stavsap/comfyui-ollama.git && \
    git clone https://github.com/kijai/ComfyUI-Florence2.git && \
    \
    # Install requirements for each relevant custom node
    pip3 install --no-cache-dir -r ComfyUI-Login/requirements.txt && \
    pip3 install --no-cache-dir -r ComfyUI-VideoHelperSuite/requirements.txt && \
    pip3 install --no-cache-dir -r ComfyUI-KJNodes/requirements.txt && \
    pip3 install --no-cache-dir -r ComfyUI-Florence2/requirements.txt && \
    pip3 install --no-cache-dir -r comfyui-ollama/requirements.txt && \
    pip3 install --no-cache-dir -r ComfyUI-MediaMixer/requirements.txt

# Copy default configuration
COPY --chmod=755 comfy.settings.json /ComfyUI/user/default/comfy.settings.json

# Set workspace directory
WORKDIR /workspace

# Expose ports for ComfyUI and code-server
EXPOSE 8188 9000

# Start script
CMD [ "/start.sh" ]