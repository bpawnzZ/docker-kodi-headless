# Kodi with Wayland and VAAPI Support

This is a modified version of the Docker Kodi Headless project that runs Kodi with Wayland display server and hardware acceleration via VAAPI.

## Features

- **Wayland Windowing System**: Modern display server protocol
- **VAAPI Hardware Acceleration**: Hardware-accelerated video decoding
- **NVIDIA GPU Support**: Compatible with nvidia-docker runtime
- **Weston Compositor**: Built-in Wayland compositor
- **Hardware Video Decoding**: Supports Intel, AMD, and NVIDIA GPUs

## Prerequisites

- Docker with NVIDIA Container Toolkit installed
- NVIDIA drivers on the host system
- Wayland-compatible system (optional, uses built-in Weston)

## Quick Start

### Build the Image

```bash
./build-wayland.sh
```

Or manually:

```bash
docker build -f Dockerfile.wayland -t kodi-wayland .
```

### Run with NVIDIA Support

```bash
docker run -d \
  --name kodi-wayland \
  --runtime=nvidia \
  --privileged \
  -v /dev/dri:/dev/dri \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -e NVIDIA_VISIBLE_DEVICES=all \
  -e NVIDIA_DRIVER_CAPABILITIES=all \
  -p 8080:8080 \
  -p 9090:9090 \
  kodi-wayland
```

### Using Docker Compose

```bash
docker-compose -f docker-compose.wayland.yml up -d
```

## Configuration

### GPU Device Access

The container needs access to GPU devices:
- `/dev/dri` - Direct Rendering Infrastructure devices
- NVIDIA runtime via `--runtime=nvidia`

### Environment Variables

- `NVIDIA_VISIBLE_DEVICES=all` - Make all GPUs visible
- `NVIDIA_DRIVER_CAPABILITIES=all` - Enable all driver capabilities
- `WAYLAND_DISPLAY=wayland-0` - Wayland display socket
- `XDG_RUNTIME_DIR=/tmp` - Runtime directory for Wayland

### Volumes

- `/config/.kodi` - Kodi configuration and data
- `/dev/dri` - GPU device access
- `/tmp/.X11-unix` - X11 socket (for compatibility)

## Hardware Acceleration

### VAAPI Support

The container includes:
- Mesa VAAPI drivers
- libva libraries
- VAAPI support in Kodi

### NVIDIA Support

When using nvidia-docker:
- NVIDIA drivers are shared from host
- VAAPI via NVIDIA's implementation
- Hardware video decoding

## Troubleshooting

### Check GPU Access

```bash
docker exec -it kodi-wayland ls -la /dev/dri/
```

### Test VAAPI

```bash
docker exec -it kodi-wayland vainfo
```

### Check Kodi Logs

```bash
docker logs kodi-wayland
```

### Verify Wayland

```bash
docker exec -it kodi-wayland weston-info
```

## Performance Tips

1. **Use SSD Storage**: For better media loading performance
2. **Allocate Sufficient RAM**: Kodi benefits from adequate memory
3. **Enable GPU Sharing**: Ensure `/dev/dri` devices are properly mounted
4. **Monitor GPU Usage**: Use `nvidia-smi` to check GPU utilization

## Limitations

- Kodi version is fixed to Leia (18.5)
- Requires NVIDIA Container Toolkit for GPU acceleration
- Wayland support may vary by GPU driver
- Some older GPUs may have limited VAAPI support