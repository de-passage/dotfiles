# Beating the sysadmins
export TMOUT=0

if [ $(uname) = "Linux" ]; then
  export LD_LIBRARY_PATH="" # Put stuff here to break the system
elif [[ $(uname) == "SunOS" ]]; then
# Just an old exemple
  export PATH="$PATH"
fi


## Uncomment the following to activate pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init --path)"

# Adjust this to add to the man page search path
export MANPATH="$MANPATH:$HOME/.local/share/man"

# When compiling a lot of things with dependencies on non standard locations, these 
# lines may be usefull. In order compiler include path, linker library path, pkgconfig search path
export CPPFLAGS="-I/free/local/include"
export LDFLAGS="-L/free/local/lib"
export PKG_CONFIG_PATH="/free/local/lib/pkgconfig:/free/local/lib64/pkgconfig"
