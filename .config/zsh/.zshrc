# ============================================================
# INSTANT PROMPT (must be near top)
# ============================================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet


# ============================================================
# SHELL CORE
# ============================================================
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export PATH="$PATH:/home/christophe/.local/bin"
export EDITOR=nvim

# Theme
source "${XDG_CONFIG_HOME:-$HOME/.config}/p10k/p10k.zsh" \
  || echo "Powerlevel10k not yet installed. Re-source or restart shell after completion."

# Auto-cd when typing a bare path
setopt auto_cd


# ============================================================
# COMPLETION
# ============================================================
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
fpath=(~/.local/share/zsh/completions $fpath)


# ============================================================
# HISTORY
# ============================================================
export HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zsh_history"
HISTSIZE=5000
SAVEHIST=5000

setopt appendhistory
setopt sharehistory          # share history across sessions (replaces incappendhistory)
setopt hist_ignore_all_dups  # don't record duplicate commands
setopt hist_save_no_dups     # don't write duplicates to file
setopt hist_ignore_dups      # don't record if same as previous
setopt hist_find_no_dups     # skip duplicates when searching


# ============================================================
# PLUGINS (antidote)
# ============================================================
# vi-mode workaround — must be set before plugin load
export ZVM_INIT_MODE=sourcing

export ADOTDIR="${XDG_DATA_HOME:-$HOME/.local/share}/antidote"
[[ -d $ADOTDIR ]] || git clone https://github.com/mattmc3/antidote.git "$ADOTDIR"
source "${ADOTDIR}/antidote.zsh"

# Generate plugin file if missing, then source it
[[ -e "${ZDOTDIR}/.zsh_plugins.zsh" ]] || antidote bundle < "${ZDOTDIR}/.zsh_plugins.txt" > "${ZDOTDIR}/.zsh_plugins.zsh"
source "${ZDOTDIR}/.zsh_plugins.zsh"


# ============================================================
# GUI
# ============================================================
export QT_QPA_PLATFORMTHEME=qt5ct


# ============================================================
# XDG COMPLIANCE (uncluttering $HOME)
# ============================================================
# Task / CLI tools
export TASKRC="${XDG_CONFIG_HOME:-$HOME/.config}/task/taskrc"
export LPASS_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/lpass"
export LESSHISTFILE="${XDG_CONFIG_HOME:-$HOME/.config}/less/history"
export LESSKEY="${XDG_CONFIG_HOME:-$HOME/.config}/less/keys"
export MPLAYER_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/mplayer"
export ICEAUTHORITY="${XDG_CONFIG_HOME:-$HOME/.config}/ICEauthority"
export GNUPGHOME="${XDG_CONFIG_HOME:-$HOME/.config}/gnupg"
export PYLINTHOME="${XDG_CONFIG_HOME:-$HOME/.config}/pylint"
export OMNISHARPHOME="${XDG_CONFIG_HOME:-$HOME/.config}/omnisharp"
export GAMCFGDIR="${XDG_CONFIG_HOME:-$HOME/.config}/gam"

# Dev / infrastructure
export DOTFILES_REPO_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles"
export VAGRANT_DEFAULT_PROVIDER=libvirt
export VAGRANT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/vagrant"
export ANSIBLE_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/ansible"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/ansible/ansible.cfg"
export AZURE_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/azure"
export DOCKER_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/docker"
export GEM_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/gem"
export ANDROID_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/android"
export ANDROID_USER_HOME=$ANDROID_HOME
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="${XDG_CONFIG_HOME:-$HOME/.config}/java"

# Google Cloud
export CLOUDSDK_PYTHON_SITEPACKAGES=1


# ============================================================
# FZF
# ============================================================
export FZF_DEFAULT_COMMAND="fd ."
export FZF_DIR_COMMAND="fd --type d ."
export FZF_CTRL_T_COMMAND=$FZF_DIR_COMMAND
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

_fzf_compgen_path() { fd --follow . "$1" }
_fzf_compgen_dir()  { fd --type d --follow . "$1" }


# ============================================================
# ALIASES
# ============================================================

# Taskwarrior
alias ts='task sync'
alias tlap='task rc.list.all.projects=1 projects'
alias tlat='task rc.list.all.tags=1 tags'
alias tlday='task end.after:today-60hr completed'
alias tal='task list'
alias tui='taskwarrior-tui'

# Shell utilities
alias drm='rm -rf'
alias zdate='date --utc +%FT%T.%3NZ'
alias chx='chmod +x'
alias cpwd='pwd | xclip -selection clipboard'  # renamed from 'pwd' to avoid shadowing builtin
alias clip='xclip -selection clipboard'

# Tmux
alias tns='tmux new-session -s'
alias tls='tmux list-session'
alias tas='tmux attach-session -t'

# Docker
alias dex='docker exec -it'

# Google Cloud / SSH
alias gssh='OPENSSL_CONF=/dev/null gcloud compute ssh --ssh-key-file=~/.ssh/id_rsa_work --ssh-flag="-A"'
alias gtssh='OPENSSL_CONF=/dev/null gcloud compute ssh --ssh-key-file=~/.ssh/id_rsa_work --ssh-flag="-A" --tunnel-through-iap'

# GAM (Google Workspace)
alias gamoc='gam oauth create christophe.bahin@catercare.com.au'

# ADB
alias adb='HOME=$ANDROID_HOME adb'

# Dotfiles bare-repo management
alias config='/usr/bin/git --git-dir=$DOTFILES_REPO_DIR --work-tree=$HOME'
