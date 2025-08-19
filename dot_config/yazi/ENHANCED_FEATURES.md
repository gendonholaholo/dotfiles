# Enhanced Yazi Configuration - Feature Guide

## 🚀 New Advanced Features

Your Yazi configuration has been significantly enhanced with powerful plugins and improved functionality.

### 🔥 Quick Navigation & Jumping

| Keybinding | Feature | Description |
|------------|---------|-------------|
| `J` | **EasyJump** | Quick jump to any line (like hop.nvim) |
| `f` | **Zoxide** | Smart directory jumping based on frequency |
| `z` | **FZF** | Fuzzy finder for files and directories |
| `gp` | **Quick Go** | Jump to ~/Projects |
| `gt` | **Quick Go** | Jump to /tmp |

### 📑 Advanced Bookmark Management

| Keybinding | Feature | Description |
|------------|---------|-------------|
| `ba` | **Add Bookmark** | Bookmark current directory |
| `bj` | **Jump to Bookmark** | Fuzzy search and jump to bookmarks |
| `bl` | **List Bookmarks** | Show all saved bookmarks |
| `bd` | **Delete Bookmark** | Remove a bookmark |

### 🔍 Enhanced Search & Analysis

| Keybinding | Feature | Description |
|------------|---------|-------------|
| `Ft` | **Full-Text Search** | Search inside file contents |
| `Fn` | **Filename Search** | Search by filename with find |
| `s` | **FD Search** | Fast file search with fd |
| `S` | **Ripgrep Search** | Content search with ripgrep |
| `As` | **Directory Analysis** | Show directory sizes and statistics |

### 🎬 Media & Archive Operations

| Keybinding | Feature | Description |
|------------|---------|-------------|
| `Mi` | **Media Info** | Show detailed media file information |
| `Me` | **EXIF/Audio** | Show EXIF data for images, metadata for audio |
| `Ar` | **Archive Preview** | View contents of zip/tar/7z files |
| `Ax` | **Extract Archive** | Extract archive to current directory |

### 📊 Data File Operations

| Keybinding | Feature | Description |
|------------|---------|-------------|
| `Dv` | **Data Preview** | Preview CSV, JSON, Parquet files with DuckDB |
| `Dq` | **Data Query** | Run SQL queries on data files |

### ⚙️ System & File Operations

| Keybinding | Feature | Description |
|------------|---------|-------------|
| `Ch` | **Change Permissions** | Modify file permissions |
| `Co` | **Change Owner** | Modify file ownership |
| `Ss` | **System Status** | Show system information with Starship |

## 🎨 Visual Enhancements

### Enhanced Theme Features
- **Modern Color Scheme**: Improved file type colors and icons
- **Better Visual Hierarchy**: Enhanced status line and borders
- **File Type Icons**: Emoji icons for different file types (requires Nerd Font)
- **Syntax Highlighting**: Better preview colors for code files

### Layout Improvements
- **Better Ratios**: Optimized panel ratios (1:3:4)
- **Borders**: Visual borders for better separation
- **Enhanced Status**: Rich status line with git integration

## 📁 Enhanced File Previews

Your configuration now supports rich previews for:

### Text & Code Files
- **Markdown**: Beautiful rendering with Glow
- **JSON**: Formatted with syntax highlighting
- **YAML/TOML**: Proper syntax highlighting
- **Source Code**: Enhanced highlighting for all major languages

### Data Files
- **CSV/TSV**: Structured table view with DuckDB
- **JSON**: Pretty-printed with data analysis
- **Parquet**: Column information and sample data
- **Excel**: Basic structure preview

### Media Files
- **Images**: EXIF data, dimensions, file info
- **Videos**: Codec, resolution, duration, bitrate
- **Audio**: Metadata, format, quality information

### Archives
- **ZIP/TAR/7Z**: Full content listing with file sizes
- **Tree View**: Hierarchical display of archive contents

## 🔧 Performance Optimizations

- **Async Operations**: All I/O operations are non-blocking
- **Smart Caching**: Intelligent preview caching for faster navigation
- **Lazy Loading**: Plugins load only when needed
- **Optimized Ratios**: Better screen space utilization

## 🚦 Git Integration

Enhanced git features throughout the interface:
- **File Status**: Git status indicators in file list
- **Branch Info**: Current branch display in status line
- **Diff Preview**: See changes in modified files
- **Ignore Awareness**: Proper handling of .gitignore

## 🔄 Installation & Updates

### Initial Setup
```bash
# Install plugins and dependencies
./install_plugins.sh

# Or manually install plugins
ya pack -i
```

### Updating Plugins
```bash
# Update all plugins to latest versions
ya pack -u

# Force reinstall if needed
ya pack -i --force
```

### Dependencies
Make sure you have these tools installed for full functionality:
- `bat` - Enhanced file preview
- `jq` - JSON processing
- `fd` - Fast file finding
- `rg` (ripgrep) - Content search
- `fzf` - Fuzzy finder
- `glow` - Markdown rendering
- `unar` / `7z` - Archive extraction
- `mpv` - Media playback
- `duckdb` - Data file analysis

## 📚 Learning More

- **Help System**: Press `~` or `F1` for interactive help
- **Plugin Docs**: Check individual plugin repositories for advanced features
- **Yazi Docs**: Visit https://yazi-rs.github.io/docs/ for comprehensive documentation
- **Awesome Yazi**: https://github.com/AnirudhG07/awesome-yazi for more plugins

## 🐛 Troubleshooting

### Plugin Not Working
1. Check if plugin is installed: `ya pack -l`
2. Verify dependencies are installed
3. Check Yazi version compatibility
4. Review error logs: `yazi --debug`

### Performance Issues
1. Disable unnecessary plugins in `package.toml`
2. Reduce preview cache size
3. Check available system resources
4. Update to latest Yazi version

### Configuration Issues
1. Backup is in `~/.config/yazi/backup-*`
2. Reset to defaults by removing config files
3. Check syntax in TOML/Lua files
4. Verify file permissions

---

**Enjoy your enhanced Yazi experience! 🎉**

This configuration transforms Yazi from a basic file manager into a powerful, feature-rich productivity tool. Take time to explore the new capabilities and customize further to match your workflow.