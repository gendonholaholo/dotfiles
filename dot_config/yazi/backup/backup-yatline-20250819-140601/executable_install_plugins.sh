#!/bin/bash
# Enhanced Yazi Plugin Installation Script
# Installs all advanced plugins for powerful file management

echo "🚀 Installing enhanced Yazi plugins..."

# Function to check if ya command exists
check_ya_command() {
    if ! command -v ya &> /dev/null; then
        echo "❌ Error: 'ya' command not found. Please install yazi first."
        echo "   Visit: https://yazi-rs.github.io/docs/installation"
        exit 1
    fi
}

# Function to install dependencies
install_dependencies() {
    echo "📦 Checking system dependencies..."
    
    # Check for common tools
    local deps=("bat" "jq" "fd" "rg" "fzf" "glow" "unar" "7z")
    local missing_deps=()
    
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            missing_deps+=("$dep")
        fi
    done
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        echo "⚠️  Missing dependencies: ${missing_deps[*]}"
        echo "   Install them with your package manager:"
        echo "   - Ubuntu/Debian: sudo apt install ${missing_deps[*]}"
        echo "   - Fedora: sudo dnf install ${missing_deps[*]}"
        echo "   - Arch: sudo pacman -S ${missing_deps[*]}"
        echo "   - macOS: brew install ${missing_deps[*]}"
        echo ""
        read -p "Continue anyway? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    else
        echo "✅ All dependencies found!"
    fi
}

# Function to backup existing configuration
backup_config() {
    local backup_dir="$HOME/.config/yazi/backup-$(date +%Y%m%d-%H%M%S)"
    
    if [ -f "$HOME/.config/yazi/yazi.toml" ] || [ -f "$HOME/.config/yazi/keymap.toml" ]; then
        echo "💾 Creating backup at $backup_dir"
        mkdir -p "$backup_dir"
        
        [ -f "$HOME/.config/yazi/yazi.toml" ] && cp "$HOME/.config/yazi/yazi.toml" "$backup_dir/"
        [ -f "$HOME/.config/yazi/keymap.toml" ] && cp "$HOME/.config/yazi/keymap.toml" "$backup_dir/"
        [ -f "$HOME/.config/yazi/init.lua" ] && cp "$HOME/.config/yazi/init.lua" "$backup_dir/"
        [ -f "$HOME/.config/yazi/theme.toml" ] && cp "$HOME/.config/yazi/theme.toml" "$backup_dir/"
        
        echo "✅ Backup created successfully!"
    fi
}

# Function to install plugins
install_plugins() {
    echo "🔌 Installing Yazi plugins..."
    
    # Install all plugins from package.toml
    ya pack -i
    
    if [ $? -eq 0 ]; then
        echo "✅ Plugins installed successfully!"
    else
        echo "❌ Error installing plugins. Check your package.toml configuration."
        exit 1
    fi
}

# Function to verify installation
verify_installation() {
    echo "🔍 Verifying installation..."
    
    # Check if plugins directory exists and has content
    if [ -d "$HOME/.config/yazi/plugins" ] && [ "$(ls -A "$HOME/.config/yazi/plugins" 2>/dev/null)" ]; then
        echo "✅ Plugins directory populated"
        echo "📁 Installed plugins:"
        ls -1 "$HOME/.config/yazi/plugins" | grep -E '\.(yazi|lua)$' | head -10
    else
        echo "⚠️  Plugins directory seems empty"
    fi
    
    # Check configuration files
    local config_files=("yazi.toml" "keymap.toml" "init.lua" "theme.toml")
    for file in "${config_files[@]}"; do
        if [ -f "$HOME/.config/yazi/$file" ]; then
            echo "✅ $file found"
        else
            echo "❌ $file missing"
        fi
    done
}

# Function to show usage instructions
show_usage() {
    echo ""
    echo "🎉 Enhanced Yazi configuration installed successfully!"
    echo ""
    echo "🚀 New Features Available:"
    echo "  • Press 'J' for quick jump navigation (easyjump)"
    echo "  • Press 'ba' to add bookmark, 'bj' to jump to bookmark"
    echo "  • Press 'Ft' for full-text search in files"
    echo "  • Press 'Mi' to view media file information"
    echo "  • Press 'Dv' to preview CSV/JSON/Parquet files"
    echo "  • Press 'Ar' to view archive contents"
    echo "  • Press 'Ch' to change file permissions"
    echo "  • Press 'As' for directory size analysis"
    echo ""
    echo "📚 Enhanced Navigation:"
    echo "  • 'gp' → Go to ~/Projects"
    echo "  • 'gt' → Go to /tmp"
    echo "  • 'f'  → Jump with zoxide"
    echo "  • 'z'  → Jump with fzf"
    echo ""
    echo "🔧 Configuration Files:"
    echo "  • Main config: ~/.config/yazi/yazi.toml"
    echo "  • Keybindings: ~/.config/yazi/keymap.toml"
    echo "  • Plugins: ~/.config/yazi/init.lua"
    echo "  • Theme: ~/.config/yazi/theme.toml"
    echo ""
    echo "📖 Get help anytime by pressing '~' or F1 in Yazi"
    echo ""
    echo "🔄 To update plugins later, run: ya pack -u"
}

# Main execution
main() {
    echo "🎯 Enhanced Yazi Configuration Installer"
    echo "========================================"
    
    check_ya_command
    install_dependencies
    backup_config
    install_plugins
    verify_installation
    show_usage
    
    echo ""
    echo "✨ Ready to go! Launch yazi to experience the enhanced features."
}

# Run main function
main "$@"