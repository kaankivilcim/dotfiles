# Ignore this file if we're in non-interactive execution
case $- in
    *i*) ;;
      *) return;;
esac

# Check the window size after each command
shopt -s checkwinsize

# Aliases
alias cp='cp -Rv'
alias grep='grep --color=auto'
alias grepw='grep --color=auto -Hrnwi'
alias ll='ls --color=auto -alF'
alias ls='ls --color=auto'
alias mkdir='mkdir -pv'
alias mv='mv -v'
alias xclip='/usr/bin/xclip -selection clipboard'

# History control
HISTCONTROL=ignoreboth  # Ignore lines starting with spaces and duplicate lines
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend  # Append to the history file

# Vim
export EDITOR=/usr/bin/vim

# Prompt colors
txtblk='\[\e[0;30m\]' # Black - Regular
txtred='\[\e[0;31m\]' # Red
txtgrn='\[\e[0;32m\]' # Green
txtylw='\[\e[0;93m\]' # Yellow
txtblu='\[\e[0;34m\]' # Blue
txtpur='\[\e[0;35m\]' # Purple
txtcyn='\[\e[0;96m\]' # Cyan
txtwht='\[\e[0;37m\]' # White
bldblk='\[\e[1;30m\]' # Black - Bold
bldred='\[\e[1;31m\]' # Red
bldgrn='\[\e[1;32m\]' # Green
bldylw='\[\e[1;33m\]' # Yellow
bldblu='\[\e[1;34m\]' # Blue
bldpur='\[\e[1;35m\]' # Purple
bldcyn='\[\e[1;36m\]' # Cyan
bldwht='\[\e[1;37m\]' # White
unkblk='\[\e[4;30m\]' # Black - Underline
undred='\[\e[4;31m\]' # Red
undgrn='\[\e[4;32m\]' # Green
undylw='\[\e[4;33m\]' # Yellow
undblu='\[\e[4;34m\]' # Blue
undpur='\[\e[4;35m\]' # Purple
undcyn='\[\e[4;36m\]' # Cyan
undwht='\[\e[4;37m\]' # White
bakblk='\[\e[40m\]'   # Black - Background
bakred='\[\e[41m\]'   # Red
badgrn='\[\e[42m\]'   # Green
bakylw='\[\e[43m\]'   # Yellow
bakblu='\[\e[44m\]'   # Blue
bakpur='\[\e[45m\]'   # Purple
bakcyn='\[\e[46m\]'   # Cyan
bakwht='\[\e[47m\]'   # White
txtrst='\[\e[0m\]'    # Text Reset

export TERM=xterm-256color
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

BASE16_SHELL="${HOME}/.config/base16-shell"
[ -n "$PS1" ] && [ -s "${BASE16_SHELL}/profile_helper.sh" ] && eval "$(${BASE16_SHELL}/profile_helper.sh)"

# Man page colors
export LESS_TERMCAP_mb=$'\e[1;31m'     # Begin bold.
export LESS_TERMCAP_md=$'\e[1;33m'     # Begin blink.
export LESS_TERMCAP_so=$'\e[01;44;37m' # Begin reverse video.
export LESS_TERMCAP_us=$'\e[01;37m'    # Begin underline.
export LESS_TERMCAP_me=$'\e[0m'        # Reset bold/blink.
export LESS_TERMCAP_se=$'\e[0m'        # Reset reverse video.
export LESS_TERMCAP_ue=$'\e[0m'        # Reset underline.
export GROFF_NO_SGR=1
