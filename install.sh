#!/bin/zsh

./backup-dotfiles.sh

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

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
        ./install-lazy-git.sh
    else
        echo "Skipping Lazyvim installation"
    fi
else
    ./install-lazy-git.sh
fi

# cargo
curl https://sh.rustup.rs -sSf | sh

# zellij
cargo install --locked zellij

# git
git config --global core.editor "neovim"

zsh ~/.zshrc

echo "done!"
