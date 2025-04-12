#!/bin/zsh

./backup-dotfiles.sh

# brew

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
  "watchman"
  "neovim"
  "ripgrep"
  "gnu-sed"
  "fzf"
  "eza"
  "lazygit"
  "ast-grep"
  "fish"
  "fd"
  "lua-language-server"
  "font-jetbrains-mono-nerd-font"
  "ghostty"
  "raycast"
  "arc"
  "dbeaver-community"
  "docker"
  "github"
  "slack"
  "spotify"
  "visual-studio-code"
)

for package in "${packages[@]}"; do
  install_package "$package"
done


# lazyvim
if [[ -e ~/.config/nvim/ ]]; then
	echo "Neovim config exists would you like to overwrite with Lazyvim starter? y/n"
	read -r addLazyvim
	[ "$addLazyvim" = "y" ] && ./install-lazy-git.sh
else
	echo "Skipping Lazyvim installation"
fi

# git
git config --global core.editor "neovim"

zsh ~/.zshrc

echo "done!"
