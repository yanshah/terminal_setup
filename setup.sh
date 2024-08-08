#!/bin/bash

echo "Starting setup..."

# Install Homebrew if not installed
if ! command -v brew &> /dev/null
then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed"
fi

# Install iTerm2
if ! brew list --cask | grep -q "iterm2"; then
    echo "Installing iTerm2..."
    brew install --cask iterm2
else
    echo "iTerm2 is already installed"
fi

# Ensure zsh is the default shell
echo "Setting Zsh as default shell..."
chsh -s $(which zsh)

# Copy iTerm2 settings
echo "Copying iTerm2 settings..."
cp com.googlecode.iterm2.plist ~/Library/Preferences/

# Copy Zsh configuration
echo "Copying Zsh configuration..."
cp .zshrc ~/

# Create directory for Zsh plugins if it doesn't exist
ZSH_PLUGIN_DIR=~/.zsh
mkdir -p $ZSH_PLUGIN_DIR

# Clone Zsh plugins
echo "Cloning Zsh plugins..."

# zsh-syntax-highlighting
if [ -d "$ZSH_PLUGIN_DIR/zsh-syntax-highlighting" ]; then
    echo "Updating zsh-syntax-highlighting..."
    cd $ZSH_PLUGIN_DIR/zsh-syntax-highlighting && git pull
else
    echo "Cloning zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_PLUGIN_DIR/zsh-syntax-highlighting
fi

# zsh-autosuggestions
if [ -d "$ZSH_PLUGIN_DIR/zsh-autosuggestions" ]; then
    echo "Updating zsh-autosuggestions..."
    cd $ZSH_PLUGIN_DIR/zsh-autosuggestions && git pull
else
    echo "Cloning zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_PLUGIN_DIR/zsh-autosuggestions
fi

# powerlevel10k
if [ -d "$ZSH_PLUGIN_DIR/powerlevel10k" ]; then
    echo "Updating powerlevel10k..."
    cd $ZSH_PLUGIN_DIR/powerlevel10k && git pull
else
    echo "Cloning powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_PLUGIN_DIR/powerlevel10k
fi

# Source the .zshrc file
echo "Sourcing .zshrc..."
source ~/.zshrc

echo "Setup complete. Please restart iTerm2."
