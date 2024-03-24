#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
export _JAVA_AWT_WM_NONREPARENTING=1
PS1='[\u@\h \W]\$ '
