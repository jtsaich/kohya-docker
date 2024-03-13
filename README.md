# Docker image for Kohya_ss

## Installs

* Ubuntu 22.04 LTS
* CUDA 11.8
* Python 3.10.12
* Torch 2.1.2
* xformers 0.0.23.post1
* Jupyter Lab
* [Kohya_ss](https://github.com/bmaltais/kohya_ss) v23.0.8
* [runpodctl](https://github.com/runpod/runpodctl)
* [OhMyRunPod](https://github.com/kodxana/OhMyRunPod)
* [RunPod File Uploader](https://github.com/kodxana/RunPod-FilleUploader)
* [rclone](https://rclone.org/)
* sd_xl_base_1.0.safetensors

## Available on RunPod

This image is designed to work on [RunPod](https://runpod.io?ref=2xxro4sy).
You can use my custom [RunPod template](
https://runpod.io/gsc?template=51q837fywe&ref=2xxro4sy)
to launch it on RunPod.

## Building the Docker image

> [!NOTE]
> You will need to edit the `docker-bake.hcl` file and update `RELEASE`,
> and `tags`.  You can obviously edit the other values too, but these
> are the most important ones.

```bash
# Clone the repo
git clone https://github.com/ashleykleynhans/kohya-docker.git

# Download the models
cd kohya-docker
wget https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors

# Log in to Docker Hub
docker login

# Build the image, tag the image, and push the image to Docker Hub
docker buildx bake -f docker-bake.hcl --push
```

## Running Locally

### Install Nvidia CUDA Driver

- [Linux](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html)
- [Windows](https://docs.nvidia.com/cuda/cuda-installation-guide-microsoft-windows/index.html)

### Start the Docker container

```bash
docker run -d \
  --gpus all \
  -v /workspace \
  -p 3000:3001 \
  -p 8888:8888 \
  -p 2999:2999 \
  ashleykza/kohya:latest
```

You can obviously substitute the image name and tag with your own.

## Ports

| Connect Port | Internal Port | Description          |
|--------------|---------------|----------------------|
| 3000         | 3001          | Kohya_ss             |
| 8888         | 8888          | Jupyter Lab          |
| 2999         | 2999          | RunPod File Uploader |

## Environment Variables

| Variable           | Description                                   | Default   |
|--------------------|-----------------------------------------------|-----------|
| DISABLE_AUTOLAUNCH | Disable Kohya_ss from launching automatically | (not set) |

## Logs

Kohya_ss creates a log file, and you can tail the log instead of
killing the service to view the logs.

| Application | Log file                     |
|-------------|------------------------------|
| Kohya_ss    | /workspace/logs/kohya_ss.log |

For example:

```bash
tail -f /workspace/logs/kohya_ss.log
```

## Acknowledgements

1. [RunPod](https://runpod.io?ref=2xxro4sy) for providing most
   of the [container](https://github.com/runpod/containers) code.
2. [Bernard Maltais](https://github.com/bmaltais) (core developer of Kohya_ss)
   for assisting with optimizing the Docker image.

## Community and Contributing

Pull requests and issues on [GitHub](https://github.com/ashleykleynhans/kohya-docker)
are welcome. Bug fixes and new features are encouraged.

You can contact me and get help with deploying your container
to RunPod on the RunPod Discord Server below,
my username is **ashleyk**.

<a target="_blank" href="https://discord.gg/pJ3P2DbUUq">![Discord Banner 2](https://discordapp.com/api/guilds/912829806415085598/widget.png?style=banner2)</a>

## Appreciate my work?

<a href="https://www.buymeacoffee.com/ashleyk" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>
