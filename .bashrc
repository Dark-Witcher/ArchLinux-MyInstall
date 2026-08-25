#
# ~/.bashrc
#

# Only run in interactive shells
[[ $- != *i* ]] && return

# -----------------------------------------------------------------------------
# History
# -----------------------------------------------------------------------------

HISTSIZE=100000
HISTFILESIZE=200000
shopt -s histappend

PROMPT_COMMAND+=("history -a")

# -----------------------------------------------------------------------------
# Shell behavior
# -----------------------------------------------------------------------------

alias ls='ls --color=auto'
alias grep='grep --color=auto'

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

# -----------------------------------------------------------------------------
# Aliases and completion
# -----------------------------------------------------------------------------

[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"

[ -f /usr/share/bash-completion/bash_completion ] &&
    source /usr/share/bash-completion/bash_completion

[ -f /usr/share/fzf/key-bindings.bash ] &&
    source /usr/share/fzf/key-bindings.bash

[ -f /usr/share/fzf/completion.bash ] &&
    source /usr/share/fzf/completion.bash

# -----------------------------------------------------------------------------
# Prompt and directory jumping
# -----------------------------------------------------------------------------

if command -v oh-my-posh >/dev/null 2>&1 &&
   [ -f "$HOME/.config/oh-my-posh/Themes/kali.omp.json" ]; then
    eval "$(oh-my-posh init bash \
        --config "$HOME/.config/oh-my-posh/Themes/kali.omp.json")"
fi

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash)"
fi
