# Ghostty Configuration

This directory contains a fully configured Ghostty terminal emulator setup with image rendering fixes.

## Files

- **`config`** - Main Ghostty configuration file with all settings and optimizations
- **`ghostty-launcher`** - Permanent launcher script with image rendering fixes
- **`setup-alias`** - Script to configure shell alias for automatic use of the launcher

## Image Rendering Fix

The image corruption issue has been permanently resolved using environment variables that are automatically applied when launching Ghostty through the configured launcher.

### Environment Variables Applied
- `GSK_RENDERER=gl` - Use OpenGL for GTK rendering
- `MESA_GL_VERSION_OVERRIDE=3.3` - Force OpenGL 3.3 compatibility  
- `MESA_GLSL_VERSION_OVERRIDE=330` - Force GLSL 3.30 compatibility
- Unsets `GTK_THEME` and `GTK_USE_PORTAL` to prevent conflicts

### Usage

The `ghostty` command is now aliased to use the fixed launcher automatically. Simply run:

```bash
ghostty
```

### Manual Launch (if needed)

To launch with fixes manually:

```bash
~/.config/ghostty/ghostty-launcher
```

### Configuration Reload

To reload configuration: `Ctrl+Shift+,` (or `Cmd+Shift+,` on macOS)

## Features

- **Theme**: Homebrew (high contrast, development-friendly)
- **Font**: Fira Code with ligatures optimized for images
- **Image Support**: Optimized with 640MB storage limit
- **Shell Integration**: Enhanced bash/tmux compatibility
- **Performance**: Optimized for development workflows
- **Quality**: 8-step validation with evidence-based improvements

The configuration is designed for seamless tmux integration and development workflows while maintaining proper image rendering capabilities.