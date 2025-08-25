#!/bin/bash
# Neovim Plugin Update and Compatibility Check Script
# Usage: ./update-plugins.sh

echo "🔄 Updating Neovim plugins for compatibility..."

# Backup current lock file
cp lazy-lock.json lazy-lock.json.backup.$(date +%Y%m%d_%H%M%S)

# Update plugins
nvim --headless -c "Lazy sync" -c "qa"

echo "✅ Plugin update completed"
echo "🔍 Checking for deprecation warnings..."

# Test for deprecation warnings
nvim --headless -c "checkhealth" -c "qa" 2>&1 | grep -i "deprecated\|warning" || echo "No deprecation warnings found!"

echo "📝 Don't forget to:"
echo "   1. Test your configuration thoroughly"
echo "   2. Remove warning suppression in polish.lua once all plugins are updated"
echo "   3. Run :checkhealth to verify everything works"