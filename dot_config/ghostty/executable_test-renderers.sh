#!/bin/bash

# Ghostty Image Rendering Test Script
# Tests different GSK renderers to fix image corruption

echo "=== Ghostty Image Rendering Fix Script ==="
echo "This script will test different graphics renderers to fix image corruption."
echo ""

# Function to test a renderer
test_renderer() {
    local renderer=$1
    local description=$2
    
    echo "Testing $description renderer ($renderer)..."
    echo "Press Ctrl+C to stop and try next renderer"
    echo ""
    
    # Set the renderer and launch Ghostty
    GSK_RENDERER=$renderer ghostty &
    local ghostty_pid=$!
    
    # Wait for user input or timeout
    echo "Ghostty launched with $description renderer."
    echo "Test your image display, then close Ghostty to continue to next renderer."
    echo ""
    
    wait $ghostty_pid
    echo "$description renderer test completed."
    echo ""
}

# Test OpenGL renderer (most common, should work best)
test_renderer "gl" "OpenGL"

# Test Vulkan renderer (if available)
test_renderer "vulkan" "Vulkan"

# Test Cairo renderer (software fallback, most compatible)
test_renderer "cairo" "Cairo (Software)"

# Test Broadway renderer (another fallback)
test_renderer "broadway" "Broadway"

echo "=== Testing Complete ==="
echo ""
echo "If image display is now working, the issue was with the graphics renderer."
echo "You can set the working renderer permanently by adding this to your shell profile:"
echo ""
echo "export GSK_RENDERER=gl    # (or whichever renderer worked)"
echo ""
echo "Or create a Ghostty launcher script with the working renderer."