# Start tmux if not started yet
# We do this at the beginning so that not all stuff is loaded, because it will be loaded by the shell in tmux
#if [[ -z $TMUX && -z $TMUX_DISABLE ]]; then
    # tmux new
    # exit
# fi

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

# Other oh-my-zsh plugins
ZSH_AUTOSUGGESTIONS="/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
[[ -f $ZSH_AUTOSUGGESTIONS ]] && source $ZSH_AUTOSUGGESTIONS
ZSH_SYNTAX_HIGHLIGHTING="/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[[ -f $ZSH_SYNTAX_HIGHLIGHTING ]] && source $ZSH_SYNTAX_HIGHLIGHTING

# User configuration

# Fix ZSH keys; stolen from https://github.com/m-ou-se/config
# typeset -A key

# bindkey -e
# bindkey '^[[Z' reverse-menu-complete
# bindkey '^[[1;5C' emacs-forward-word
# bindkey '^[[1;5D' emacs-backward-word
# bindkey '^[[H' beginning-of-line
# bindkey '^[[F' end-of-line
# bindkey -s '^[Oo' '/'
# bindkey -s '^[Oj' '*'
# bindkey -s '^[Om' '-'
# bindkey -s '^[Ok' '+'

# key[Home]=${terminfo[khome]}
# key[End]=${terminfo[kend]}
# key[Insert]=${terminfo[kich1]}
# key[Delete]=${terminfo[kdch1]}
# key[Up]=${terminfo[kcuu1]}
# key[Down]=${terminfo[kcud1]}
# key[Left]=${terminfo[kcub1]}
# key[Right]=${terminfo[kcuf1]}
# key[PageUp]=${terminfo[kpp]}
# key[PageDown]=${terminfo[knp]}

# [[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
# [[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
# [[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
# [[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
# [[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
# [[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
# [[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
# [[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char
#####


export MANPATH="/usr/local/man:$MANPATH"

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
        # Only display first character of username
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
export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="vim ~/.zshrc"
alias vimconfig="vim ~/.vimrc"
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

# Show message of the day
cat /etc/motd

# wttr.in weather application
weather () {
    if [[ -z $1 ]]; then
        PLACE="Delft"
    else
        PLACE="$1"
    fi
	curl "wttr.in/$PLACE"
}

dotfiles_setup() {
    # List of all installed needed for this setup
    echo "Please turn on Community repository if on Arch"

    PKGLIST="\
        alacritty alacritty-terminfo \
        vim vim-spell-en vim-spell-nl \
        neovim python-neovim \
        mosh \
        rustup \
        zsh-syntax-highlighting zsh-autosuggestions \
        firefox powertop \
        exa ripgrep\
        xclip \
        zathura zathura-pdf-mupdf zathura-ps xdotool \
        "

    sudo pacman -S --needed `echo $PKGLIST` 


    # Install oh-my-zsh
    echo "Installing oh-my-zsh"
    OMZSH_DIR="$HOME/.oh-my-zsh" 
    [[ -d $OMZSH_DIR ]] || \
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    echo "Installing plugins for oh-my-zsh.."
    # Install command-time plugin for oh-my-zsh
    CMD_TIME_DIR="$HOME/.oh-my-zsh/custom/plugins/command-time"
    [[ -d $CMD_TIME_DIR ]] || \
        git clone https://github.com/popstas/zsh-command-time.git $CMD_TIME_DIR

    # Setup Rust
    echo 'Installing rust stable, nightly'
    rustup install stable nightly
    rustup default stable
    
    echo 'Installing cargo-update'
    cargo install cargo-update 
    
    echo 'Generating completions'
    mkdir -p ~/.zfunc
    rustup completions zsh cargo > $HOME/.zfunc/_cargo

    # Install vim-plug
    VIMPLUG="$HOME/.local/share/nvim/site/autoload/plug.vim"
    [[ -f $VIMPLUG ]] || \
        curl -fLo $VIMPLUG --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    # Setup Plug and install plugins
    nvim +PlugUpgrade +qa!
    nvim +PlugInstall +PlugUpdate +qa!
}


# Upgrade system and all relevant plugins / packages / applications / things
upgrade() {
    # Cache sudo password, such that `pacman` and `aurget` don't ask for one
    # Which may go unnoticed
    sudo true

    # Export dconf settings to a backup
    DCONF_FILE="$HOME/.dconf.org.dump"
    mv $DCONF_FILE{,-.bak} >/dev/null 2>&1
    dconf dump /org/ > $DCONF_FILE


    # Check whether packages are actually installed
    #

    echo 'Updating rustup'
    rustup self upgrade-data >/dev/null 2>&1

    echo 'Updating rust'
    rustup update >/dev/null 2>&1

    echo 'Recompiling all rust binaries'
    cargo install-update -a >/dev/null 2>&1

    echo 'Updating vim Plug plugin and Plugged packages'
    nvim +PlugUpgrade +qa! >/dev/null 2>&1
    nvim +PlugUpdate +qa! >/dev/null 2>&1

    echo 'Updating oh-my-zsh'
    upgrade_oh_my_zsh >/dev/null 2>&1

    echo 'Upgrading system packages'
    sudo pacman -Syu

    echo 'Upgrading foreign system packages'
    aurget -Syu firefox-nightly
}


# Create dir and cd to it
mkcd() { mkdir -p "$@" && cd "$@"; }

# Keychain for caching (gpg and) ssh keys
eval $(keychain --eval  --quiet id_ed25519 --noask --timeout 10)

# Wegwezen met je stomme beep
setterm -blength 0 >/dev/null 2>&1

# Command-line fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

############################
# Exports
############################

export GOPATH=~/go
export GOBIN=$GOPATH/bin
export PATH=~/.npm-global/bin:~/.cargo/bin:$GOBIN:~/opt/bin:/opt/xilinx/Vivado/2018.2/bin:~/.cabal/bin:~/intelFPGA_lite/18.0/quartus/bin:~/.local/bin:$HOME/esp/xtensa-esp32-elf/bin:$PATH

export EDITOR=nvim

# LEGACY: May be redundant.
export MOZILLA_FIVE_HOME=/usr/lib/mozilla
export LD_LIBRARY_PATH=${MOZILLA_FIVE_HOME}:${LD_LIBRARY_PATH}

# License file for Xilinx proprietary toolchain
export XILINXD_LICENSE_FILE=/home/gregory/Downloads/Xilinx.lic

# ESP IDF development toolchain
export IDF_PATH=~/esp/esp-idf

# ssh key
export SSH_KEY_PATH="$HOME/.ssh/id_ed25519"



############################
## Aliases ##
############################
alias rpi='ssh gregory@192.168.2.42' 
alias chk='ping -c3 -i0.2 1.1' 
alias vpsander='ssh kevin@papegaai.vps.inthout.me'
alias s='ssh kevinhill.nl -p 22002'
alias m='ssh kevinh.nl -p 22002'
alias force_max_brightness='cat /sys/class/backlight/intel_backlight/max_brightness | sudo tee /sys/class/backlight/intel_backlight/brightness'
alias batcap='cat /sys/class/power_supply/BAT0/capacity'
alias firefox='firefox-nightly'
alias ptop='sudo powertop' # Needs sudo rights
alias wttr="weather"

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

# If the end of an alias is a space, try to resolve next word as well as an alias
alias sudo="sudo " 

# For my dotfiles repo
alias dotgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Cargo stuff
alias b="cargo build"
alias bb="cargo build --release"
alias r="cargo run"
alias rr="cargo run --release"

# gheghe
alias pieton='/usr/bin/env python3'

