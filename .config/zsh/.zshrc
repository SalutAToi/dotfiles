# SOURCING
## sourcing oh-my-zsh.sh (and setting theme) required before instant prompt as may require prompt from user
ZSH_THEME="powerlevel10k/powerlevel10k"
export ZSH="${XDG_DATA_HOME:-$HOME/.local/share}/oh-my-zsh" # required to source
source $ZSH/oh-my-zsh.sh
## p10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
## sourcing p10k
[[ ! -f ${XDG_CONFIG_HOME:-$HOME/.config}/p10k/p10k.zsh ]] || source ${XDG_CONFIG_HOME:-$HOME/.config}/p10k/p10k.zsh
## fzf
### add fzf fuzzy completion
source /usr/share/doc/fzf/examples/completion.zsh
#### add fzf keybindings
source /usr/share/doc/fzf/examples/key-bindings.zsh

# SHELL SPECIFIC VARIABLES
export HISTFILE=${XDG_CACHE_HOME:-$HOME/.config}/zsh/zsh_history
## ZSH plugin
plugins=(vi-mode git taskwarrior copyfile sudo colored-man-pages docker docker-compose gcloud terraform)
## enabling vim mode (keybinding, not zsh specific)
bindkey -v

# SYSTEM/TERM VARIABLES
## path : ajout au path de .bin (for user binaries)
export PATH=$PATH:/home/christophe/.local/bin

# GUI VARIABLES
## qt theme designation
export QT_QPA_PLATFORMTHEME=qt5ct

# PROGRAM CONFIGURATION VARIABLES
## VIM
### legacy
###export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC' # not used with neovim
## Taskwarrior
export TASKRC=${XDG_CONFIG_HOME:-$HOME/.config}/task/taskrc
## Vagrant
export VAGRANT_DEFAULT_PROVIDER=libvirt
export VAGRANT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"/vagrant
## GAM
export GAMCFGDIR=/home/christophe/.config/gamadv-xtd3
## gcloud
export CLOUDSDK_PYTHON_SITEPACKAGES=1 # allows usage of external (non gcloud) py packages
## FZF
### exclusions 
export FDFIND_EXCLUSIONS="'__pycache__','.git','site-packages'"
export FZF_DEFAULT_COMMAND="fdfind --exclude $FDFIND_EXCLUSIONS ."
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
### default layouts and options
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
## LASTPASS CLI
export LPASS_HOME=${XDG_CONFIG_HOME:-$HOME/.config}/lpass
## DOTFILES
export DOTFILES_REPO_DIR=${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles
## GNUPG HOME
export GNUPGHOME=${XDG_CONFIG_HOME:-$HOME/.config}/gnupg
## LESS
export LESSHISTFILE="${XDG_CONFIG_HOME:-$HOME/.config}/less/history"
export LESSKEY="${XDG_CONFIG_HOME:-$HOME/.config}/less/keys"
## MPLAYER
export MPLAYER_HOME=${XDG_CONFIG_HOME:-$HOME/.config}/mplayer
## ICEAUTHORITY
export ICEAUTHORITY=${XDG_CONFIG_HOME:-$HOME/.config}/ICEauthority
## ANDROID TOOLS
export ANDROID_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"/android
export ANDROID_USER_HOME=$ANDROID_HOME
## ANSIBLE
export ANSIBLE_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"/ansible
## AZURE CLI
export AZURE_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"/azure
## DOCKER
export DOCKER_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"/docker
## GEM (ruby ?)
export GEM_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"/gem
## OMNISHARP (dotnet)
export OMNISHARPHOME="${XDG_CONFIG_HOME:-$HOME/.config}"/omnisharp
## OPENJDK
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="${XDG_CONFIG_HOME:-$HOME/.config}"/java
## PYLINT
export PYLINTHOME="${XDG_CONFIG_HOME:-$HOME/.config}"/pylint


# Alias utilisateur
## Taskwarrior
alias ts='task sync'
alias tlap='task rc.list.all.projects=1 projects'
alias tlat='task rc.list.all.tags=1 tags'
alias tlday='task end.after:today-60hr completed'
alias tal='task list'
alias tui='taskwarrior-tui'
## Alias raccourcis commande
alias drm='rm -rf'
alias zdate='date --utc +%FT%T.%3NZ'
alias chx='chmod +x'
## GAM
#unalias gam # unaliasing as can be set by other programs
alias gam='/home/christophe/.config/gamadv-xtd3/gam'
alias gamoc='gam oauth create christophe.bahin@¢atercare.com.au'
## Docker
alias dex='docker exec -it'
## clipboard
alias clip='xclip -selection clipboard'
## config management (git and dotfile repo)
alias config='/usr/bin/git --git-dir=$DOTFILES_REPO_DIR --work-tree=$HOME'
## ADB
alias adb='HOME=$ANDROID_HOME adb'

# FUNCTIONS AND CODE
## FZF
### function for filepath ** completion (vim)
_fzf_compgen_path() {
  fdfind  --exclude '.var' --exclude '__pycache__' --exclude '.git' --exclude 'site-packages' --hidden --follow . "$1"
}
### FZF function for dir ** completion (cd)
_fzf_compgen_dir() {
  fdfind --type d --exclude '.var' --exclude '__pycache__' --exclude '.git' --exclude 'site-packages' --hidden --follow . "$1"
}
## SCRIPT MANAGED CONFIGURATION
# >>>> Vagrant command completion (start)
fpath=(/usr/share/rubygems-integration/all/gems/vagrant-2.2.19/contrib/zsh $fpath)
compinit
# <<<<  Vagrant command completion (end)

# >>>> Terraform command completion (start)
complete -o nospace -C /usr/bin/terraform terraform
# <<<<  Terraform command completion (end)
# something bash ?
autoload -U +X bashcompinit && bashcompinit
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}"/zsh/zcompdump-"$ZSH_VERSION"
