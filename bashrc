#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

eval "$(oh-my-posh init bash --config ~/.config/oh-my-posh/Themes/catppuccin.omp.json)"

if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
