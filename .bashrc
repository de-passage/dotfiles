
if [ $(uname) = "Linux" ];
then
  # Linux specific stuff
  :
elif [ $(uname) = "SunOS" ]; then
  # Solaris specific stuff
  :
fi

# Fix for terminfo without italics. Requires installaction of xterm-256color-italics
# Solaris is excluded because it didn't work on old versions I think. 
if [ $(uname) = "SunOS" ]; then
   export TERM=xtermc
else
   export TERM=xterm-256color-italics
fi

export TMOUT=0

# Stuff I had to change Java version. To switch: export JAVA_HOME='/new/jdk'; export PATH="$JAVA_HOME/bin:$PATH"
#export JAVA_HOME="/free/misc/jdk1.8.0_161"
export JAVA_HOME="/free/misc/jdk-17.0.1"

# This is a nasty fix for machines where I can't chsh to zsh (yes, it happened). It checks whether we're in an interactive session 
# and zsh is installed in some non-standard location and we're not already in zsh (when I first installed zsh, I sourced the bashrc 
# from its configuration to preserve most of my setup. It's ugly but worked)
case $- in
  *i*)
    if [ -e /free/local/bin/zsh ] && [ -z $ZSH ] && [ "$NO_ZSH" != "true" ]; then
      exec zsh
      return
    fi
    ;;
  *) ;;
esac

alias lvim='vim -c "normal '\''0" -c "bw#"'

set -o vi

# Starship on Linux, custom prompt on the rest.
if [ $(uname) = "Linux" ]; then
    eval "$(starship init bash)"
else 
  __git_ps1 "[%s]" > /dev/null
  if (( $? )); then
      export PS1="[\u@\h:\w]\$ "
  fi
fi

# Replace with the appropriate editor
export EDITOR=$HOME/bin/nvim
