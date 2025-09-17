path_append() {
	if ! echo "$PATH" | grep -Eq "(^|:)$1($|:)"; then
		if [ "$2" = "before" ]; then
			PATH="$1:$PATH"
		else
			PATH="$PATH:$1"
		fi
	fi
}
