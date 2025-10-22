#!/bin/bash

# Build Kodi with Wayland and VAAPI support
echo "Building Kodi with Wayland and VAAPI support..."

docker build -f Dockerfile.wayland -t kodi-wayland .

echo "Build complete!"
echo ""
echo "To run with NVIDIA support:"
echo "  docker run --rm --runtime=nvidia --privileged \\"
echo "    -v /dev/dri:/dev/dri \\"
echo "    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \\"
echo "    -e NVIDIA_VISIBLE_DEVICES=all \\"
echo "    -e NVIDIA_DRIVER_CAPABILITIES=all \\"
echo "    kodi-wayland"
echo ""
echo "Or use docker-compose:"
echo "  docker-compose -f docker-compose.wayland.yml up"