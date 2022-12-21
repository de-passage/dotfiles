# Nothing else should go in this file.
# Session-wide config goes to .profile, Bash configuration goes to .bashrc
if [ -f ~.profile]; then 
  . ~/.profile
fi
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
