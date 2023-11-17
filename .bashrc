EXTRA_BIN_DIRECTORY="$HOME/.local/bin"
export PATH="$EXTRA_BIN_DIRECTORY:$PATH"
export EDITOR=vim

EXTRA_MAN_PAGES="$HOME/.local/share/man"
export MANPATH="$EXTRA_MAN_PAGES:$MANPATH"

stty -ixon
set -o vi

COMPLETION_DIRECTORY="$HOME/.bash_completion.d/" 

while IFS= read file; do 

	owner=$(stat -c "%U" "$file")
	permissions=$(stat -c "%a" "$file")
	if [[ "$permissions" == "600" ]] && [[ "$owner" == "$(whoami)" ]]; then 
		source "$file"
	else
		echo "$file has incorrect ownership/permission (actual/expected: $owner/$(whoami) | $permissions/600)" >&2
	fi

done < <(find "$COMPLETION_DIRECTORY" -type f)

tmp_func_file="
function install_bash_completion_file() {
	mkdir -p \"$COMPLETION_DIRECTORY\"
	if [[ -z \"\$1\" ]]; then 
		echo \"You must specify a file name\" >&2 
	elif ! [[ -f \"\$1\" ]]; then 
		echo \"\$1: not a valid file name\" >&2
	else 
		cp \"\$1\" \"$COMPLETION_DIRECTORY\" 
		chmod 600 \"$COMPLETION_DIRECTORY/\$(basename \$1)\"
	fi
}

function install_man_page() {
	mkdir -p \"$EXTRA_MAN_PAGES/man1\"
	if [[ -z \"\$1\" ]]; then 
		echo \"You must specify a file name\" >&2 
	elif ! [[ -f \"\$1\" ]]; then 
		echo \"\$1: not a valid file name\" >&2
	else 
		cp \"\$1\" \"$EXTRA_MAN_PAGES/man1/\"
	fi
}

function install_bin() {
	mkdir -p \"$EXTRA_BIN_DIRECTORY/\"
	if [[ -z \"\$1\" ]]; then 
		echo \"You must specify a file name\" >&2 
	elif ! [[ -x \"\$1\" ]]; then 
		echo \"\$1: not an executable file name\" >&2
	else 
		cp \"\$1\" \"$EXTRA_BIN_DIRECTORY/\"
	fi
}
"

eval "$tmp_func_file"
unset tmp_func_file
unset COMPLETION_DIRECTORY
unset EXTRA_MAN_PAGES
unset EXTRA_BIN_DIRECTORY

. "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
