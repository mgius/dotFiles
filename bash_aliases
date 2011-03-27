## Handy file for aliases, keep them seperate you hear?

## enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    #eval "dircolors -b"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias dir='ls --color=auto --format=vertical'
    alias vdir='ls --color=auto --format=long'   
fi
  
## some more ls aliases
alias ll='ls -lh'
alias la='ls -A'
alias l='ls -CF'

## nice for gnome based systems.
alias go='gnome-open'
