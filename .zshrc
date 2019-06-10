# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="false"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
DISABLE_LS_COLORS="false"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="false"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  common-aliases
  gpg-agent
#  gradle
#  python
  tmux
  ssh-agent
  sudo
  systemd
  wd
  archlinux
  command-time
  shrink-path  
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Prompt stuff
# Make sure the path in prompt does not get too long
prompt_dir() { 
    prompt_segment blue black "$(shrink_path -l -t -s)"
}

export DEFAULT_USER='gregory' # for a shortened username

arch() {echo "x86_64"}

prompt_context () {
	if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]
	then
		prompt_segment black default "%(!.%{%F{yellow}%}.)$USER@%m"
    else 
        prompt_segment black default "%(!.%{%F{yellow}%}.)${USER:0:1}@%m"
    fi
}

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/id_ed25519"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="vim ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

# Useful functions
hex() {
    emulate -L zsh
    if [[ -n "$1" ]]; then
        printf "%x\n" $1
    else
        print 'Usage: hex <number-to-convert>'
        return 1
    fi
}

function texbibpdf() {
    latexmk -bibtex -silent -e '$pdflatex=q/xelatex -synctex=1 -interaction=nonstopmode/' -pdf %
    makeglossaries "${1%%.*}"
    bibtex "${$1%%.*}"
    latexmk -bibtex -silent -e '$pdflatex=q/xelatex -synctex=1 -interaction=nonstopmode/' -pdf %
    latexmk -bibtex -silent -e '$pdflatex=q/xelatex -synctex=1 -interaction=nonstopmode/' -pdf %
    latexmk -bibtex -silent -e '$pdflatex=q/xelatex -synctex=1 -interaction=nonstopmode/' -pdf %
    latexmk -bibtex -silent -e '$pdflatex=q/xelatex -synctex=1 -interaction=nonstopmode/' -pdf %
    latexmk -bibtex -silent -e '$pdflatex=q/xelatex -synctex=1 -interaction=nonstopmode/' -pdf %
}

# Show message of the day
cat /etc/motd

weather () {
	curl "wttr.in/"$1
}

alias wttr="weather"

upgrade() {
	vim
}


# Create dir and cd to it
mkcd() { mkdir -p "$@" && cd "$@"; }

# Eval useful things
eval $(keychain --eval  --quiet id_ed25519 --noask --timeout 10)

# Wegwezen met je stomme beep
setterm -blength 0 >/dev/null 2>&1


########################################################################
# Path meuk && Exports

export GOPATH=~/go
export GOBIN=$GOPATH/bin
export PATH=~/.npm-global/bin:~/.cargo/bin:$GOBIN:~/opt/bin:/opt/xilinx/Vivado/2018.2/bin:~/.cabal/bin:~/intelFPGA_lite/18.0/quartus/bin:~/.local/bin:$HOME/esp/xtensa-esp32-elf/bin:$PATH

export EDITOR=nvim

# Handy aliases
alias rpi='ssh gregory@192.168.2.42' 
alias chk='ping -c3 -i0.2 1.1' 
alias vpsander='ssh kevin@vps.inthout.eu'
alias s='ssh kevinhill.nl -p 22002'
alias m='ssh kevinh.nl -p 22002'
alias force_max_brightness='cat /sys/class/backlight/intel_backlight/max_brightness | sudo tee /sys/class/backlight/intel_backlight/brightness'
alias batcap='cat /sys/class/power_supply/BAT0/capacity'
alias firefox='firefox-nightly'
alias ptop='sudo powertop' # Needs sudo rights

# CPU frequency, only work on ZBook (I hope)
alias savepower="sudo cpupower frequency-set -u 2GHz"
alias maxpower="sudo cpupower frequency-set -u 4.1GHz"
alias ls='exa'
alias vim='nvim'
alias das="ssh ihpc1855@fs3.das4.tudelft.nl"
alias t='/home/gregory/Documents/Gregorius/Uni/CE/Thesis'
alias note='vim $(date +"%Y-%m-%d.txt")'

alias :q="exit"
alias :wq="exit"
alias :x="exit"

# Typos
alias sl="ls"
alias gti="git"
alias mn="man"
alias clc="clear"

alias sudo="sudo " 
# If the end of an alias is a space, try to resolve next word as well as an alias

alias dotgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias b="cargo build"
alias bb="cargo build --release"
alias r="cargo run"
alias rr="cargo run --release"

# ESP IDF development toolchain
export IDF_PATH=~/esp/esp-idf

alias pieton='/usr/bin/env python3'

export MOZILLA_FIVE_HOME=/usr/lib/mozilla
export LD_LIBRARY_PATH=${MOZILLA_FIVE_HOME}:${LD_LIBRARY_PATH}
export XILINXD_LICENSE_FILE=/home/gregory/Downloads/Xilinx.lic


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh