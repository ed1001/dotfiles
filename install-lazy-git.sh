echo "installing Lazyvim..."

mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}

git clone https://github.com/ed1001/lazyvim.git ~/.config/nvim
rm -rf ~/.config/nvim/.git
