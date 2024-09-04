#!/bin/bash


# Install pnpm
echo "Installing pnpm..."
curl -fsSL https://get.pnpm.io/install.sh | sh -

# Add pnpm to PATH in .bashrc
echo "Adding pnpm to PATH..."
echo 'export PATH="$HOME/.local/share/pnpm:$PATH"' >> ~/.bashrc

# Reload shell configuration
echo "Reloading shell configuration..."
source ~/.bashrc

# Verify pnpm installation
echo "Verifying pnpm installation..."
pnpm -v && echo "pnpm installed successfully!" || echo "pnpm installation failed."

