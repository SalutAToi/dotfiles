# SHELL CONFIGURATIONS (sourcing, env vars, functions)
## Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
## set p10k instant prompt to be quiet
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
## enabling vim mode
# bindkey -v
## source theme
source "${XDG_CONFIG_HOME:-$HOME/.config}/p10k/p10k.zsh"
## path : ajout au path de .bin (for user binaries)
export PATH=$PATH:/home/christophe/.local/bin
# plugin manager
## where to store plugin manager files
export ADOTDIR=${XDG_DATA_HOME:-$HOME/.local/share}/antigen
## where to store plugin manager cache
export ANTIGEN_CACHE=${XDG_CACHE_HOME:-$HOME/.cache}/antigen/init.zsh
source /usr/share/zsh-antigen/antigen.zsh
# autocompletion
autoload -Uz compinit
## setting completion file path
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}"/zsh/zcompdump-"$ZSH_VERSION"
## case insensitive autocompletion style
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
## cd to a path when typed
setopt auto_cd

# PLUGINS
## workaround vi-mode keybinding issue (before loading plugin)
### see https://github.com/jeffreytse/zsh-vi-mode/blob/master/README.md
export ZVM_INIT_MODE=sourcing
antigen bundles <<EOBUNDLES
    jeffreytse/zsh-vi-mode
    ohmyzsh/ohmyzsh plugins/sudo
    ohmyzsh/ohmyzsh plugins/taskwarrior
    ohmyzsh/ohmyzsh plugins/command-not-found
    ael-code/zsh-colored-man-pages
    ohmyzsh/ohmyzsh plugins/gcloud
    ohmyzsh/ohmyzsh plugins/terraform
    ohmyzsh/ohmyzsh plugins/vagrant
    zsh-users/zsh-syntax-highlighting
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-completions
    ohmyzsh/ohmyzsh plugins/fzf
EOBUNDLES
## theme
antigen theme romkatv/powerlevel10k
antigen apply



# HISTORY CONFIGURATION
## setting histfile location
export HISTFILE=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zsh_history
## size limits
HISTSIZE=5000
SAVEHIST=5000
# erase and avoid duplicates when searching through the history
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# GUI CONFIGURATIONS
## qt theme designation
export QT_QPA_PLATFORMTHEME=qt5ct

# PROGRAM CONFIGURATIONS (sourcing, env vars, functions, uncluttering $HOME)
## Taskwarrior
export TASKRC=${XDG_CONFIG_HOME:-$HOME/.config}/task/taskrc
## Vagrant
export VAGRANT_DEFAULT_PROVIDER=libvirt
export VAGRANT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"/vagrant
## GAM
export GAMCFGDIR=${XDG_CONFIG_HOME:-$HOME/.config}/gamadv-xtd3
## gcloud
export CLOUDSDK_PYTHON_SITEPACKAGES=1 # allows usage of external (non gcloud) py packages
## FZF
### exclusions 
### function for filepath ** completion (vim)
_fzf_compgen_path() {
    fdfind --follow . "$1"
}
### FZF function for dir ** completion (cd)
_fzf_compgen_dir() {
    fdfind --type d --follow . "$1"
}
export FZF_DEFAULT_COMMAND="fdfind ."
export FZF_DIR_COMMAND="fdfind --type d ."
export FZF_CTRL_T_COMMAND=$FZF_DIR_COMMAND
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
alias gamoc='gam oauth create christophe.bahin@¢atercare.com.au'
## Docker
alias dex='docker exec -it'
## clipboard
alias clip='xclip -selection clipboard'
## config management (git and dotfile repo)
alias config='/usr/bin/git --git-dir=$DOTFILES_REPO_DIR --work-tree=$HOME'
## ADB
alias adb='HOME=$ANDROID_HOME adb'
## aliasing vim to lunarvim
alias vim='lvim'
