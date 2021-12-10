#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='lsd'
alias cat='lolcat'
alias la='lsd -A'
alias ll='lsd -lA'
alias tree='tree -a'
alias r='ranger'

PS1='[\u@\h \W]\$ '

function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

export VISUAL=nvim
export EDITOR=nvim

co() { du -a ~/.config ~/valfiles| awk '{print $2}' | fzf | xargs -r $EDITOR; }

neofetch

alias luamake=/home/spff/gitimport/lua-language-server/3rd/luamake/luamake
