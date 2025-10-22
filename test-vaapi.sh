#!/bin/bash
# Test VAAPI in Docker container

echo "Testing VAAPI permissions..."

# Check if renderD128 exists
if [ -c /dev/dri/renderD128 ]; then
    echo "✓ /dev/dri/renderD128 exists"
    
    # Check permissions
    echo "Permissions:"
    ls -la /dev/dri/renderD128
    
    # Check groups
    echo "Current user groups:"
    groups
    
    # Test VAAPI
    echo "Testing VAAPI with vainfo..."
    if command -v vainfo &> /dev/null; then
        vainfo --display drm --device /dev/dri/renderD128
    else
        echo "vainfo not available"
    fi
else
    echo "✗ /dev/dri/renderD128 not found"
fi

echo "VAAPI test complete"