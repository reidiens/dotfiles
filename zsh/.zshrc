export ZSH="$HOME/.oh-my-zsh"
export MANPAGER='nvim +Man!'

ZSH_THEME="random"
ZSH_THEME_RANDOM_IGNORED=(humza emotty apple agnoster)

# CASE_SENSITIVE="true"

# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# DISABLE_AUTO_TITLE="true"

# ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git sudo)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8
export EDITOR='nvim'

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/ruby/.zshrc'

autoload -Uz compinit
compinit

HISTFILE=~/.histfile
HISTSIZE=500
SAVEHIST=1000
setopt nomatch
unsetopt autocd beep
bindkey -e

alias zrcedit="nvim $HOME/.zshrc"
alias zclear="clear; source $HOME/.zshrc"
alias re="source $HOME/.zshrc"

alias nv="nvim"
alias neovim="nvim"

alias ls="ls --color=auto"
alias l="ls"
alias la="ls -a"

alias pacman="sudo pacman"
alias pamcan="sudo pacman"
alias update="pacman -Syyu && paru -Syyu"
alias udpate="pacman -Syyu && paru -Syyu"
alias upd="pacman -Syyu && paru -Syyu"
alias upqate="pacman -Syyu --noconfirm && paru -Syyu noconfirm"
alias upq="pacman -Syyu --noconfirm && paru -Syyu noconfirm"
alias upbt="pacman -Syyu --noconfirm && sudo systemctl reboot"
alias updn="pacman -Syyu --noconfirm && sudo systemctl poweroff"

alias sps="sudo pacman -S"
alias sprnscu="sudo pacman -Rnscu"
alias spr="sudo pacman -R"
alias sprn="sudo pacman -Rn"
alias cleanup="sudo pacman -Rns $(pacman -Qqtd)"

alias rbt="sudo systemctl reboot"
alias dwn="sudo systemctl poweroff"

alias vsc="vscodium"

alias kitheme="kitty +kitten themes"

alias gcc="gcc -Wall"
alias valgrind="valgrind -s --leak-check=full --show-leak-kinds=all"

alias mount="sudo mount"
alias umount="sudo umount"
alias eject="sudo eject"

alias bright="xrandr --output eDP --brightness"

alias yt-mp3="yt-dlp --extract-audio --audio-format mp3"

alias pvpn="sudo openvpn /etc/openvpn/client/is-10.protonvpn.udp.ovpn"

alias steamdir="cd ~/.var/app/com.valvesoftware.Steam/.local/share/Steam/steamapps"

alias sz='function f() { du -hs "$1" | grep "$1" }; f'
alias zs='function f() { du -hs "$1" | grep "$1" }; f'

alias sudo="sudo "

alias cd..="cd .."

alias lp="lilypond"

alias waybar="hyprctl dispatch exec waybar"

#
#----------------------
neofetch
source /home/ruby/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
