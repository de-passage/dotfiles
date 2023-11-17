# dotfiles

Not useful if you're not me. Barely useful if you are

## Installation options

```bash
mkdir -p "$HOME/workspace"
export DOTFILES="$HOME/workspace/dotfiles"
```
**Do NOT use ~ instead of $HOME here!!! I've had issues with it on some systems (ending up with an extra '~' folder)**

### Using $HOME as a git work tree

Create a bare repository to host the git files: 
```bash
git clone --bare git@github.com:de-passage/dotfiles.git "$DOTFILES"
```

Checkout the branch matching the desired configuration directly: 
```bash 
git --work-dir="$HOME" --git-dir="$DOTFILES" checkout wsl_zsh --force # Needed if files already exist
```
I keep the actual files in separate branches to avoid having the README around on my machines. Not great but it works.

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
git --work-tree="$HOME" --git-dir="$DOTFILES" ls-files | xargs -n1 chmod 600
# or 
git -C "$DOTFILES" ls-files | xargs -n1 chmod 600
```

Restart the shell
```bash 
exec "$SHELL"
```

#### Install starship 
Just download it and drop it in a PATH directory: https://github.com/starship/starship/releases  

#### Install tmux-powerline
Clone the directory
```bash
git clone https://github.com/erikw/tmux-powerline.git ~/workspace/tmux-powerline
```
Edit `themes/default.sh` don't try to mess with different filenames it's not worth the trouble, you'll forget about it all after 5 minutes anyway.  
Then run `generater_rc.sh` and rename the resulting file
```bash
cd ~/workspace/tmux-powerline && ./generate_rc.sh && mv ~/tmux-powerlinerc.default ~/tmux-powerlinerc
```

### Install bat, fd, rg, delta from release page or official repo
#### Delta 
The package is named `git-delta` on some package managers. Otherwise dl it from https://github.com/dandavison/delta/releases  
There's a musl version if the system is too old (req libc > 2.32 or something similar).
#### Bat
There is a `bat` package on most systems. Otherwise get it from the release page : https://github.com/sharkdp/bat/releases
#### Rg
The package is named `ripgrep`. The musl package needs to be installed manually. Put the binary in `~/.local/.bin`, the completion files in `~/.bash_completion.d/` and the doc in `~/.local/share/man/man1/`. 
#### fd
The package is named `fd-find. Release page at https://github.com/sharkdp/fd/releases. There is a package for old versions of Debian, don't use it and go for the musl.deb one. 
