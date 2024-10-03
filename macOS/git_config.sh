#!/bin/bash

# Script for automatic Git configuration
echo "Welcome to the Git configuration script"

# Request information from the user
read -p "Enter your full name: " git_name
read -p "Enter your email address: " git_email
read -p "Enter your preferred code editor (e.g., code, vim, nano): " git_editor

# Configure Git
git config --global user.name "$git_name"
git config --global user.email "$git_email"
git config --global core.editor "$git_editor --wait"
git config --global init.defaultBranch main
git config --global push.default current
git config --global color.ui auto

echo "Git configuration completed. Here's your current configuration:"
git config --list

echo "Git configuration script finished.
