#!/bin/zsh

./backup-dotfiles.sh

# brew
brew list zsh-syntax-highlighting >/dev/null || brew install zsh-syntax-highlighting
brew list watchman >/dev/null || brew install watchman
brew list neovim >/dev/null || brew install neovim
brew list ripgrep >/dev/null || brew install ripgrep
brew list gnu-sed >/dev/null || brew install gnu-sed
brew list fzf >/dev/null || brew install fzf
brew list eza >/dev/null || brew install eza
brew list thefuck >/dev/null || brew install thefuck
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
