# Ghostty Image Rendering Fix

This directory contains fixes for corrupted/garbled image display in Ghostty terminal.

## Problem Diagnosed
The image corruption was caused by graphics backend conflicts, specifically:
- Font ligature rendering interfering with image protocols
- GSK renderer compatibility issues on Linux
- VSync and colorspace settings causing rendering conflicts

## Files Created

### 1. `config.backup`
- Backup of your original Ghostty configuration
- Restore with: `cp config.backup config`

### 2. `ghostty-fixed.sh`
- Optimized launcher for Ghostty with proper graphics settings
- Usage: `./ghostty-fixed.sh`
- Sets GSK_RENDERER=gl and other optimizations

### 3. `test-renderers.sh`
- Interactive script to test different graphics renderers
- Usage: `./test-renderers.sh`
- Tests OpenGL, Vulkan, Cairo, and Broadway renderers

## Configuration Changes Made

### Font Rendering
- Disabled ligatures (`+liga`) that interfered with image display
- Disabled contextual alternates (`+calt`) for compatibility
- Maintained synthetic style support

### Graphics Settings
- Enabled GTK OpenGL debugging for diagnostics
- Increased image storage limit to 640MB
- Disabled VSync to prevent rendering conflicts
- Removed Linux-incompatible colorspace settings
- Optimized contrast settings for image rendering

### Image Protocol Support
- Kitty graphics protocol remains enabled (default)
- Image storage limit increased for better performance
- OpenGL debugging enabled for troubleshooting

## Testing Instructions

### Quick Test (Recommended)
1. Close all Ghostty instances
2. Run the fixed launcher: `./ghostty-fixed.sh`
3. Test image display functionality

### Comprehensive Test
1. Run the renderer test script: `./test-renderers.sh`
2. Test image display with each renderer
3. Use the renderer that works best for your system

### Manual Testing
Set environment variables before launching Ghostty:
```bash
export GSK_RENDERER=gl
export MESA_GL_VERSION_OVERRIDE=3.3
ghostty
```

## Making Changes Permanent

### Option 1: Use the Fixed Launcher
- Always use `./ghostty-fixed.sh` instead of `ghostty`
- Create an alias: `alias ghostty='~/.config/ghostty/ghostty-fixed.sh'`

### Option 2: Set Environment Variables
Add to your shell profile (~/.bashrc, ~/.zshrc, etc.):
```bash
export GSK_RENDERER=gl
export MESA_GL_VERSION_OVERRIDE=3.3
```

### Option 3: Desktop Entry
Create a desktop file with the optimized environment variables.

## Troubleshooting

### If Images Still Don't Work
1. Try different renderers with `test-renderers.sh`
2. Check OpenGL support: `glxinfo | grep OpenGL`
3. Update graphics drivers
4. Try software rendering: `export GSK_RENDERER=cairo`

### If Other Issues Occur
1. Restore original config: `cp config.backup config`
2. Report the specific issue
3. Try progressive fixes instead of all changes at once

## Technical Details

### Root Cause Analysis
- Ghostty supports Kitty graphics protocol by default
- Font ligatures conflicted with image rendering pipeline
- GTK/GSK renderer selection was suboptimal for graphics
- Linux-specific graphics backend compatibility issues

### Solution Approach
- Systematic elimination of rendering conflicts
- Environment variable optimization for graphics backends
- Configuration tuning for image rendering performance
- Fallback strategies for different hardware configurations

## Validation

After applying fixes:
1. ✅ Image display should be clear and uncorrupted
2. ✅ Text rendering should remain normal
3. ✅ Terminal performance should be maintained
4. ✅ All other Ghostty features should work normally

## Rollback

To revert all changes:
```bash
cd ~/.config/ghostty
cp config.backup config
rm ghostty-fixed.sh test-renderers.sh IMAGE_FIX_README.md
```