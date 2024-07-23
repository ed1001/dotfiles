#!/bin/zsh

./backup-dotfiles.sh

# brew
brew list zsh-syntax-highlighting >/dev/null || brew install zsh-syntax-highlighting
brew list watchman >/dev/null || brew watchman
brew list neovim >/dev/null || brew neovim
brew list ripgrep >/dev/null || brew ripgrep
brew list gnu-sed >/dev/null || brew gnu-sed
brew list fzf >/dev/null || brew fzf
brew list eza >/dev/null || brew eza
brew list font-jetbrains-mono-nerd-font >/dev/null || brew install --cask font-jetbrains-mono-nerd-font

# kitty
kitty -v >/dev/null || curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

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
