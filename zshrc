export ZSH=/home/USER/.oh-my-zsh
ZSH_THEME="alanpeabody"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# HIST_STAMPS="dd.mm.yyyy"

LD_LIBRARY_PATH=/usr/lib
PATH="$HOME/.local/bin/:$PATH"

alias showip="curl ifconfig.co/ip"

alias sublime="~/documents/sublime_text_3/sublime_text"
alias notebook="jupyter notebook --no-browser"

alias cs="xclip -selection clipboard"

alias large="resize -s 42 182; clear"
alias small="resize -s 34 146; clear"

setopt RM_STAR_WAIT

plugins=(git)

source $ZSH/oh-my-zsh.sh

export EDITOR=vim

termscreensaver() {
	opts=("pipes.sh" "asciiquarium")
	screensaver=${opts[$RANDOM % ${#opts[@]}]}
	$screensaver
}

vpn() {
	evpn=$(ls ~/documents/vpn/evpn/ | shuf -n 1)
	echo $evpn
	sudo openvpn ~/documents/vpn/evpn/$evpn
}

ssh() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
        tmux rename-window "$(echo $* | cut -d . -f 1,2)"
        command ssh "$@"
        tmux set-window-option automatic-rename "on" 1>/dev/null
    else
        command ssh "$@"
    fi
}

