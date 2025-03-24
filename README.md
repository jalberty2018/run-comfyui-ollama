# Run ComfyUI Ollama with Custom nodes on [RunPod.io](https://runpod.io?ref=se4tkc5o)

## Synopsis

A streamlined setup for running **ComfyUI** with **Ollama**.  
This pod downloads models as specified in the **environment variables** set in the [RunPod.io template](https://runpod.io/console/deploy?template=hx0q4csn2c&ref=se4tkc5o).  

- Models are automatically downloaded based on the specified paths in the environment configuration.  
- Authentication credentials can be set via secrets for:  
  - **Code server** authentication (not possible to switch off) 
  - **Hugging Face** tokens for model access.  

Ensure that the required environment variables and secrets are correctly set before running the pod.
See below for options.

## Templates available in ComfyUI (left folder icon)

![t2t simple](images/ollama-simple.JPG)

![i2t simple](images/ollama-vision-simple.JPG)

![i2t advanced](images/ollama-vision-advanced.JPG)

## Hardware Requirements  
 
- **Recommended GPUs**: L4, A40
- **Storage**:  
  - **Volume**: 20GB (`/workspace`)  
  - **Pod Volume**: 70Gb  

## Template [RunPod.io](https://runpod.io?ref=se4tkc5o)

- [template](https://runpod.io/console/deploy?template=hx0q4csn2c&ref=se4tkc5o)

## Hardware provisioning example

- [Runpod.io](https://runpod.io/)
- GPU L4, A40
- Volume: 20Gb (/workspace)
- Pod volume: 70Gb

## Environment Variables  

### **ComfyUI Arguments**  

| Token        | Environment Variable     |
|--------------|--------------------------|
| Arguments    | `COMFYUI_EXTRA_ARGUMENTS`|

### **Authentication Tokens**  

| Token        | Environment Variable |
|--------------|----------------------|
| Huggingface  | `HF_TOKEN`           |
| Code Server  | `PASSWORD`           |

### **Diffusion Lora Setup Huggingface**  

| Model Type        | URL (Huggingface or Ollama) |
|-------------------|-----------------------------|
| Ollama model      | `OLLAMA_MODEL[1-4]`         |

## Connection options 

### Services

| Service         | Port          |
|-----------------|---------------| 
| **ComfyUI**     | `8188` (HTTP) |
| **Code Server** | `9000` (HTTP) |
| **SSH/SCP**     | `22`   (TCP)  |

## Website models

- [Huggingface](https://huggingface.co/)

## Websites software Github

- [ComfyUI](https://github.com/comfyanonymous/ComfyUI)
- [Code server](https://github.com/coder/code-server)
- [Ollama](https://github.com/ollama/ollama)

## Website custom_nodes

- [rgthree](https://github.com/rgthree/rgthree-comfy)
- [login](https://github.com/liusida/ComfyUI-Login)
- [manager](https://github.com/ltdrdata/ComfyUI-Manager)
- [KJNodes](https://github.com/kijai/ComfyUI-KJNodes)
- [Python](https://github.com/pydn/ComfyUI-to-Python-Extension)
- [Ollama](https://github.com/stavsap/comfyui-ollama)
- [Florence2](https://github.com/kijai/ComfyUI-Florence2)
- [MediaMixer](https://github.com/DoctorDiffusion/ComfyUI-MediaMixer)

## Manual provisioning

[provisioning](provisioning/provisioning.md)

## Utilites

```bash
nvtop
htop
mc
nano
```




