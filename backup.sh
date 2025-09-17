backup() {
	target=$1
	if [ -e "$target" ]; then       # Does the config file already exist?
		if [ ! -L "$target" ]; then    # as a pure file?
			mv "$target" "$target.backup" # Then backup it
			echo "-----> Moved your old $target config file to $target.backup"
		fi
	fi
}
