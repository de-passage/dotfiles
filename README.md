# dotfiles

Not useful if you're not me. Barely useful if you are

## Installation options

```bash
export DOTFILES="$HOME/workspace/dotfiles"
```

### Using $HOME as a git work tree

Create a bare repository to host the git files: 
```bash
git clone --bare git@github.com:de-passage/dotfiles.git "$DOTFILES"
```

Checkout the branch matching the desired configuration directly: 
```bash 
git --work-dir="$HOME" --git-dir="$DOTFILES" checkout wsl_zsh --force # Needed if files already exist
```

### Using a separate git repo and symlinks 

Clone the directory on the desired branch:
```bash
git clone git@github.com:de-passage/dotfiles.git -b wsl_zsh "$DOTFILES"
```

Create the symlinks (not tested but looks ok):
```bash 
find workspace -maxdepth 1 -exec ln -s "${PWD}"/{} "$HOME" \;
```

### Additional steps

Change the file permissions if needed:
```bash
git --work-dir="$HOME" --git-dir="$DOTFILES" ls-files | xargs -n1 chmod 600
# or 
git -C "$DOTFILES" ls-files | xargs -n1 chmod 600
```

Restart the shell
```bash 
exec "$SHELL"
```
