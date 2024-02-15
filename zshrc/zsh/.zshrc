# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/spff/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

eval "$(oh-my-posh --init --shell zsh --config '~/zsh/.conf.omp.json')"

export ZDOTDIR=$HOME/zsh

setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef		# Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
# compinit
_comp_options+=(globdots)		# Include hidden files.

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# colors
autoload -Uz colors && colors

# Useful Functions
source "$ZDOTDIR/zsh-functions"

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"

alias ls='lsd'
alias cat='lolcat'
alias la='lsd -A'
alias l='lsd -lA'
alias tree='tree -a'
alias r='ranger'
alias grep='grep --color=auto'
alias v='nvim'
alias vcpp='clang++ -std=c++2b -stdlib=libc++ -fmodules -fbuiltin-module-map -fsanitize=address,leak,undefined'
alias vgpp='g++ -std=c++23 -Wall -Wextra -Wpedantic -Wconversion -fmodules-ts -fsanitize=address,leak,undefined'
alias vgc='gcc -std=c2x -Wall -Wextra -Wpedantic -Wconversion -fsanitize=address,leak,undefined'
alias vcc='clang -std=c2x -Wall -Wextra -Wpedantic -Wconversion -fsanitize=address,leak,undefined'

alias tk='cat ~/valetoriy/TOKEN.txt | xclip -sel clip'
alias gs='git status'
alias gl='git log'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gp='tk; git push'
alias gu='git pull'

alias p='yay -Syyuu'
alias f='yay -Ss'
alias i='yay -S'
alias d='yay -Rns'
alias q='yay -Qs'

export VISUAL=nvim
export EDITOR=nvim

co() { du -a ~/.config ~/valfiles| awk '{print $2}' | fzf | xargs -r $EDITOR; }

alias luamake=/home/spff/gitimport/lua-language-server/3rd/luamake/luamake

export PATH=/home/spff/.cargo/bin/:/home/spff/.ghcup/ghc/9.4.7/bin/:$PATH
export QSYS_ROOTDIR="/home/spff/.cache/yay/quartus-free/pkg/quartus-free-quartus/opt/intelFPGA/21.1/quartus/sopc_builder/bin"
