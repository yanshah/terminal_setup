#!/bin/bash

echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Installing iTerm2..."
brew install --cask iterm2

echo "Adding Zsh to allowed shells..."
sudo sh -c "echo $(which zsh) >> /etc/shells"

echo "Changing default shell to Zsh..."
chsh -s $(which zsh)

echo "Copying iTerm2 settings..."
cp com.googlecode.iterm2.plist ~/Library/Preferences/

echo "Copying Zsh configuration..."
cp .zshrc ~/

echo "Copying Zsh plugins and themes..."
cp -r zsh_plugins ~/.zsh

echo "Sourcing .zshrc..."
source ~/.zshrc

echo "Installation complete. Please restart iTerm2."
