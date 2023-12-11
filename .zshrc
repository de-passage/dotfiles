#value If you come from bash you might have to change your $PATH.
export PATH=$(echo "$PATH" | sed 's!\(/mnt[^:]*:\)\|\(:/mnt[^:]*\)!!g')
export PATH="$HOME/.local/usr/bin:$HOME/.local/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export ZSH_DISABLE_COMPFIX="true"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

COMPLETION_WAITING_DOTS="true"

if [ -z "$SSH_CONNECTION" ]; then
  ZSH_TMUX_AUTOSTART=${ZSH_TMUX_AUTOSTART:-"true"}
else
  ZSH_TMUX_AUTOSTART="false"
fi
ZSH_TMUX_AUTOQUIT="false"
ZSH_TMUX_DEFAULT_SESSION_NAME="main"

fpath+=$HOME/.local/completion
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
LOCAL_CONFIG="$HOME/.config/zsh"
plugins=(git tmux nvm fd golang ripgrep zsh-completions zsh-autopair zsh-autosuggestions zsh-syntax-highlighting)
[[ -f "$LOCAL_CONFIG/oh-my-zsh-plugins" ]] && plugins+=($(cat $LOCAL_CONFIG/oh-my-zsh-plugins))

source $ZSH/oh-my-zsh.sh

# User configuration

export MANPATH="$HOME/.local/share/man:/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
unsetopt BEEP
bindkey -v

# Ctrl+n
bindkey "" history-beginning-search-forward
# Ctrl+p
bindkey "" history-beginning-search-backward
# Ctrl+u
bindkey "" kill-whole-line
# Ctrl+q
bindkey "" vi-cmd-mode

export CXX=clang++
export CC=clang
export EDITOR=nvim

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Created by `pipx` on 2022-12-24 12:45:07
#
export PATH="/home/depassage/.local/bin:$HOME/go/bin/:/usr/local/go/bin/:$HOME/.cargo/bin:$HOME/.go/bin:$PATH"
eval "$(starship init zsh)"

[[ -d "$HOME/.lua-language-server/" ]] && export PATH="$HOME/.lua-language-server/bin:$PATH"

source $HOME/.config/lscolors/lscolors.sh

if command -v fzf &>/dev/null; then

_fzf-file-explorer() {
  local FILES="$(fb | sed -n "$ ! H; $ { H; x; s/^\n//; s/\([^\n]*\)\(\n\|$\)/'\1' /g; p }" )"
  zle -U "$FILES"
  zle reset-prompt
}

zle -N _fzf-file-explorer
bindkey '^f' _fzf-file-explorer

# _fh - look through history
_fh() {
  local saved_buffer=$BUFFER
  local v=$( fc -l 1 | fzf --height '40%' --layout=reverse +s --tac --bind="start:put($BUFFER)" | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
  if [ $? -eq 0 ] && [[ "$v" != '' ]]; then
    BUFFER=$v
    CURSOR=$#BUFFER
  else
    BUFFER=$saved_buffer
    CURSOR=$#BUFFER
  fi
  zle reset-prompt
}

zle -N _fh
bindkey '^r' _fh

fi

if [[ -d "$LOCAL_CONFIG" ]]; then
  if [[ -r "$LOCAL_CONFIG" ]]; then
    for config_file ($LOCAL_CONFIG/*.zsh(N)); do
      source $config_file
    done
  else
    echo "WARNING: Cannot read $LOCAL_CONFIG, check permissions" >&2
  fi
fi

[ -f "/home/sii/.ghcup/env" ] && source "/home/sii/.ghcup/env" # ghcup-env
