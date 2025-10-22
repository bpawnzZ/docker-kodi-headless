#!/bin/bash

# Build script for Kodi X11 Docker image

echo "Building Kodi X11 Docker image..."

# Build the image
docker build -f Dockerfile.x11 -t kodi-x11:latest .

if [ $? -eq 0 ]; then
    echo ""
    echo "Build successful!"
    echo ""
    echo "To run the container:"
    echo "  docker run -d --name kodi-x11 --privileged \\"
    echo "    -v /dev/dri:/dev/dri \\"
    echo "    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \\"
    echo "    -p 8080:8080 -p 9090:9090 \\"
    echo "    kodi-x11:latest"
    echo ""
    echo "Or use Docker Compose:"
    echo "  docker-compose -f docker-compose.x11.yml up -d"
    echo ""
    echo "Web interface: http://localhost:8080"
    echo "Default credentials: kodi/kodi"
else
    echo "Build failed!"
    exit 1
fi