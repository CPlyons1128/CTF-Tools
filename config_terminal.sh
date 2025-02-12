#!/bin/bash

echo "🚀 Starting Terminal Customization for Kali Linux..."

# Update system
echo "🔄 Updating system..."
sudo apt update && sudo apt upgrade -y

# Install required dependencies
echo "📦 Installing dependencies..."
sudo apt install -y zsh git curl wget fonts-powerline neofetch exa fzf bat

# Install Oh My Zsh
echo "💻 Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || { echo "Oh My Zsh install failed!"; exit 1; }

# Set Zsh as default shell
echo "🔄 Changing default shell to Zsh..."
chsh -s $(which zsh)

# Install Powerlevel10k theme
echo "🎨 Installing Powerlevel10k theme..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

# Configure Zsh theme
sed -i 's/ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc

# Install Syntax Highlighting & Autosuggestions
echo "✨ Adding syntax highlighting and autosuggestions..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# Install fzf for fuzzy search & auto-completion
echo "🔍 Installing fzf (fuzzy finder)..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# Enable Plugins
echo "🔧 Configuring Zsh plugins..."
sed -i 's/plugins=(.*)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions fzf)/g' ~/.zshrc

# Install exa for modern 'ls' replacement
echo "📂 Installing exa (better ls)..."
echo "alias ls='exa --icons --color=always'" >> ~/.zshrc

# Install bat (better cat)
echo "🐱 Installing bat (better cat command)..."
echo "alias cat='bat --style=plain'" >> ~/.zshrc

# Add useful aliases
echo "📝 Adding custom aliases..."
cat <<EOL >> ~/.zshrc

# Custom Aliases
alias ll='exa -lh --icons'    # Long format with icons
alias la='exa -lah --icons'   # List all, long format
alias grep='grep --color=auto'
alias update='sudo apt update && sudo apt upgrade -y'
alias cls='clear'

# Enable command auto-completion
autoload -Uz compinit
compinit

# Neofetch on startup
neofetch
EOL

# Reload Zsh configuration
echo "🔄 Reloading Zsh..."
source ~/.zshrc

echo "✅ Terminal customization complete! Restart your terminal or run 'zsh' to see changes."
