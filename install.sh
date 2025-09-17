#!/bin/zsh

./sync-dotfiles.sh
./sync-bin.sh

# Oh My Zsh
if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh My Zsh is already installed. Skipping."
else
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Homebrew
if command -v brew >/dev/null 2>&1; then
  echo "Homebrew is already installed. Skipping."
else
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# homebrew packages

install_package() {
  local package="$1"

  if brew info --formula "$package" &>/dev/null; then
    echo "Installing formula: $package"
    brew list "$package" &>/dev/null || brew install "$package"
  elif brew info --cask "$package" &>/dev/null; then
    echo "Installing cask: $package"
    brew list --cask "$package" &>/dev/null || brew install --cask "$package"
  else
    echo "Package $package not found in Homebrew."
  fi
}

packages=(
  "zsh-syntax-highlighting"
  "zsh-history-substring-search"
  "zsh-autosuggestions"
  "watchman"
  "neovim"
  "ripgrep"
  "gnu-sed"
  "fzf"
  "eza"
  "zoxide"
  "lazygit"
  "ast-grep"
  "fish"
  "fd"
  "lua-language-server"
  "font-jetbrains-mono-nerd-font"
  "ghostty"
  "raycast"
  "dbeaver-community"
  "docker"
  "github"
  "git-lfs"
  "slack"
  "spotify"
  "visual-studio-code"
  "zen"
)

for package in "${packages[@]}"; do
  install_package "$package"
done


# lazyvim
if [[ -e ~/.config/nvim/ ]]; then
    echo "Neovim config exists. Would you like to overwrite with Ed's lazyvim setup? y/n"
    read -r addLazyvim
    if [ "$addLazyvim" = "y" ]; then
        ./install-lazyvim.sh
    else
        echo "Skipping Lazyvim installation"
    fi
else
    ./install-lazyvim.sh
fi


# Check and install Rust (cargo)
if ! command -v cargo >/dev/null 2>&1; then
  echo "Installing Rust (cargo)..."
  curl https://sh.rustup.rs -sSf | sh -s -- -y
  [ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
else
  echo "Rust (cargo) is already installed."
fi

# Check and install zellij
if ! command -v zellij >/dev/null 2>&1; then
  echo "Installing zellij via cargo..."
  cargo install --locked zellij
else
  echo "zellij is already installed."
fi

# Zellij config
if [ -d "$HOME/.config/zellij" ]; then
    echo "Zellij config exists. Would you like to overwrite with Ed's zellij setup? y/n"
  read -r confirm
  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo "Removing existing ~/.config/zellij..."
    rm -rf "$HOME/.config/zellij"
    echo "Cloning zellij config..."
    git clone https://github.com/ed1001/zellij-config.git "$HOME/.config/zellij"
  else
    echo "Skipping zellij config replacement."
  fi
else
  echo "Cloning zellij config..."
  git clone https://github.com/ed1001/zellij-config.git "$HOME/.config/zellij"
fi

# Check and install NVM
if ! command -v nvm >/dev/null 2>&1; then
  echo "Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
else
  echo "NVM is already installed."
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

# Check and install Node LTS
if ! command -v node >/dev/null 2>&1; then
  echo "Installing latest Node.js LTS..."
  nvm install --lts
else
  echo "Node.js is already installed."
fi

# Check and update npm
if ! command -v npm >/dev/null 2>&1; then
  echo "Installing npm globally..."
  npm install -g npm
else
  echo "npm is already installed."
fi


zsh ~/.zshrc

echo "done!"
