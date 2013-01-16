# Mark's Bashrc
# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# This function unashamedly stolen from http://github.com/icco
bash_prompt_command() {
    # How many characters of the $PWD should be kept
    local pwdmaxlen=23
    # Indicate that there has been dir truncation
    local trunc_symbol="..."
    local dir=${PWD##*/}
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
    NEW_PWD=${PWD/#$HOME/\~}
    local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
    if [ ${pwdoffset} -gt "0" ]
    then
        NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
        NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
    fi
}
PROMPT_COMMAND=bash_prompt_command

function parse_git_branch {
  ref=$(/usr/lib/git-core/git-symbolic-ref HEAD 2> /dev/null) || return
    echo "("${ref#refs/heads/}")"
}

source ~/.bash_colors

PS1="\[$BBlue\]\u@\h:\[$BRed\]\${NEW_PWD} \[$BYellow\]\$(parse_git_branch)\[$BGreen\]\$ \[$Color_Off\]"

# Above colorscheme is deadly on white backgrounds.  Nuke it sometimes
function unset_ps1_colors {
   export PS1="\u@\h:\${NEW_PWD} \$(parse_git_branch)\$ "
}


# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

export EDITOR="/usr/bin/vim"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# For certain machines add an additional bashrc
if [ -f ~/.bashrc.`hostname` ]; then
   . ~/.bashrc.`hostname`
   echo "===> Loaded .bashrc.`hostname`";
elif [ -f ~/.mybashrc ]; then
   . ~/.mybashrc
fi

# If I have a bin in my user directory, check there for commands.
# We do this late in the file so it takes priority.
[ -d ~/.local/bin ] && PATH=~/.local/bin:$PATH
[ -d ~/bin ] && PATH=~/bin:$PATH

export PATH=$PATH:/sbin/:/usr/sbin/

alias pygrep='grep -P -R --include="*.py" --exclude-dir="*-venv"'

export BASE_BRANCH='master'
alias git_pep8='vim $(pep8 -q $(git diff --name-only $BASE_BRANCH | grep "py$") | uniq)'
alias git_edit_changed='git diff --name-only $BASE_BRANCH | xargs -n 10 vim; stty sane'

export PYTHONSTARTUP=~/src/dotFiles/pystartup.py
