backup() {
	target=$1
	if [ -e "$target" ]; then       # Does the config file already exist?
		if [ ! -L "$target" ]; then    # as a pure file?
			mv "$target" "$target.backup" # Then backup it
			echo "-----> Moved your old $target config file to $target.backup"
		fi
	fi
}

#!/bin/zsh
for name in *; do
	if [ ! -d "$name" ]; then
		target="$HOME/.$name"
		if [[ ! "$name" =~ \.sh$ ]]; then
			backup "$target"
			echo "$name"

			if [ ! -e "$target" ]; then
				echo "-----> Symlinking your new $target"
				ln -s "$PWD/$name" "$target"
			fi
		fi
	fi
done

# brew
brew list zsh-syntax-highlighting >/dev/null || brew install zsh-syntax-highlighting
brew list watchman >/dev/null || brew watchman
brew list neovim >/dev/null || brew neovim
brew list ripgrep >/dev/null || brew ripgrep
brew list gnu-sed >/dev/null || brew gnu-sed
brew list fzf >/dev/null || brew fzf
brew list eza >/dev/null || brew eza
brew list font-jetbrains-mono-nerd-font >/dev/null || brew install --cask font-jetbrains-mono-nerd-font

git config --global core.editor "vim"

zsh ~/.zshrc

echo "done!"
