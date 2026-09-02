# ~/.bashrc
# Deployed to GCP VMs (OS Login). Ports the non-plugin, non-GUI, non-cloud
# parts of ~/.zshrc so a plain bash session (no zsh installed, or a bash
# session started deliberately from zsh) is still comfortable to use.

# ============================================================
# ZSH AUTO-SWITCH (must stay first)
# ============================================================
# If zsh is installed and this is a real interactive session, hand off to it.
# Guarded so scripts/scp/ansible/`ssh host cmd` are untouched, and so running
# `bash` from inside zsh gives you a real bash instead of bouncing back.
case $- in
*i*) ;;
*) return ;;
esac

# Skip entirely if zsh is already this account's actual login shell (e.g. a
# personal machine, as opposed to a server whose login shell is forced to
# bash by OS Login) - then any `bash` you run here is deliberate and should
# never bounce back to zsh. $SHELL reflects the OS-assigned login shell and
# isn't touched by merely running a different shell binary, so it stays
# accurate even nested inside another shell (e.g. bash -> zsh -> bash).
if [ "$(basename "${SHELL:-bash}")" != "zsh" ] &&
  [ -z "$NO_ZSH_SWITCH" ] &&
  [ -z "$__ZSH_AUTOSWITCH" ] &&
  [ -t 1 ] &&
  command -v zsh >/dev/null 2>&1; then
  export __ZSH_AUTOSWITCH=1
  exec zsh
fi

# Everything below only runs when zsh isn't available, when $SHELL is
# already zsh, or when NO_ZSH_SWITCH/a nested `bash` skipped the switch above.

# ============================================================
# SHELL CORE
# ============================================================
export PATH="$HOME/.local/bin:$PATH"
export EDITOR=nvim
export VISUAL="$EDITOR"

# `cd` into a bare path just by typing it (bash >=4 only)
if ((BASH_VERSINFO[0] >= 4)); then
  shopt -s autocd
  shopt -s globstar # ** recursive glob, same as zsh's default behaviour
fi

# ============================================================
# COMPLETION
# ============================================================
# bash-completion package: same install location on Debian/Ubuntu and
# RHEL/CentOS derivatives when the `bash-completion` package is present.
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# bash-completion v2 auto-loads per-command scripts from
# ${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion/completions/<command>
# on demand, no manual sourcing needed (equivalent to the zsh fpath entry).

bind "set completion-ignore-case on" # equivalent to zstyle matcher-list
bind "set show-all-if-ambiguous on"  # show matches after one <Tab>

# ============================================================
# FZF (fuzzy history search + fuzzy cd, like the zsh setup)
# ============================================================
# Entirely optional: everything below is a no-op if fzf isn't installed, so
# it's safe to keep in the fleet-wide bashrc even on VMs without it yet.
# Install via apt/dnf/yum (Debian/Ubuntu and RHEL/CentOS via EPEL both carry
# it) or the official installer (github.com/junegunn/fzf), same result
# either way. Once loaded: Ctrl-R fuzzy-searches history, Ctrl-T fuzzy-finds
# a path to insert, Alt-C fuzzy-cd's into a subdirectory.
if command -v fzf >/dev/null 2>&1; then
  # fzf >=0.48 prints its own shell integration; older installs (incl. the
  # git-clone installer) drop a ~/.fzf.bash instead.
  if out=$(fzf --bash 2>/dev/null); then
    eval "$out"
  elif [ -f "$HOME/.fzf.bash" ]; then
    source "$HOME/.fzf.bash"
  else
    # even older distro packages ship the two scripts separately, at
    # different paths depending on the package (Debian/Ubuntu vs Fedora/RHEL)
    for f in \
      /usr/share/doc/fzf/examples/key-bindings.bash \
      /usr/share/doc/fzf/examples/completion.bash \
      /usr/share/fzf/shell/key-bindings.bash \
      /usr/share/fzf/shell/completion.bash; do
      [ -f "$f" ] && source "$f"
    done
  fi

  # fd is optional: fzf falls back to `find` on its own without it.
  if command -v fd >/dev/null 2>&1; then
    export FZF_CTRL_T_COMMAND="fd --type f --follow"
    export FZF_ALT_C_COMMAND="fd --type d --follow"
  fi
fi

# ============================================================
# HISTORY
# ============================================================
export HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/bash/bash_history"
mkdir -p "$(dirname "$HISTFILE")"

HISTSIZE=5000                    # in-memory entries, equivalent to zsh's HISTSIZE
HISTFILESIZE=5000                # on-disk entries, equivalent to zsh's SAVEHIST
HISTCONTROL=ignoreboth:erasedups # ignoreboth = ignorespace + ignoredups

shopt -s histappend # append rather than overwrite HISTFILE (== appendhistory)

# Bash has no native shared-history option like zsh's `sharehistory`; this
# PROMPT_COMMAND hook approximates it by writing then reloading history
# before every prompt. Appended (not overwritten) so it composes with
# anything else that sets PROMPT_COMMAND.
__bashrc_sync_history() {
  history -a
  history -c
  history -r
}
PROMPT_COMMAND="__bashrc_sync_history${PROMPT_COMMAND:+; $PROMPT_COMMAND}"

# ============================================================
# XDG COMPLIANCE (uncluttering $HOME)
# ============================================================
# Excludes: task, dev-infra (vagrant/ansible/docker/gem/android/java),
# google cloud, and graphical-only vars (ICEAUTHORITY, QT_QPA_PLATFORMTHEME)
export LPASS_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/lpass"
export LESSHISTFILE="${XDG_CONFIG_HOME:-$HOME/.config}/less/history"
export LESSKEY="${XDG_CONFIG_HOME:-$HOME/.config}/less/keys"
export GNUPGHOME="${XDG_CONFIG_HOME:-$HOME/.config}/gnupg"
export GPG_TTY=$(tty) # needed by gpg for prompts when GNUPGHOME is set

# ============================================================
# COMFORT DEFAULTS FOR AN INTERACTIVE SERVER SHELL
# ============================================================
shopt -s checkwinsize            # keep LINES/COLUMNS correct after resize
shopt -s no_empty_cmd_completion # don't complete on an empty line
if ((BASH_VERSINFO[0] >= 4)); then
  shopt -s cdspell  # fix minor typos in `cd` arguments
  shopt -s dirspell # ditto during completion
fi

# Colour support for common tools
if command -v dircolors >/dev/null 2>&1; then
  eval "$(dircolors -b)"
fi
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

export LESS='-R -F -X' # raw colour codes, don't page short output, no clear-on-exit

# --- prompt / "status line" -------------------------------------------
# No plugin/theme dependency: exit status, user@host, cwd, git branch.
__bashrc_set_prompt() {
  local exit_status=$1

  local reset='\[\e[0m\]' bold='\[\e[1m\]'
  local red='\[\e[31m\]' green='\[\e[32m\]'
  local yellow='\[\e[33m\]' blue='\[\e[34m\]'

  local exit_part=""
  [ "$exit_status" -ne 0 ] && exit_part="${red}[${exit_status}]${reset} "

  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
  local git_part=""
  [ -n "$branch" ] && git_part=" ${yellow}(${branch})${reset}"

  PS1="${exit_part}${bold}${green}\u@\h${reset}:${bold}${blue}\w${reset}${git_part}\n\$ "
}
__bashrc_precmd() {
  local exit_status=$? # capture before anything else touches $?
  __bashrc_sync_history
  __bashrc_set_prompt "$exit_status"
}
PROMPT_COMMAND="__bashrc_precmd"

# Keep the terminal-emulator tab/window title in sync with cwd, harmless
# no-op on terminals that don't understand the escape sequence.
case "$TERM" in
xterm* | rxvt* | screen* | tmux*)
  __bashrc_precmd() {
    local exit_status=$?
    __bashrc_sync_history
    __bashrc_set_prompt "$exit_status"
    printf '\033]0;%s@%s: %s\007' "$USER" "$HOSTNAME" "$PWD"
  }
  ;;
esac

# ============================================================
# ALIASES
# ============================================================
# Excludes: taskwarrior, gcloud/gssh, gam, adb

# Shell utilities
alias drm='rm -rf'
alias zdate='date --utc +%FT%T.%3NZ'
alias chx='chmod +x'

# Tmux
alias tns='tmux new-session -s'
alias tls='tmux list-session'
alias tas='tmux attach-session -t'

# Docker
alias dex='docker exec -it'

# Dotfiles bare-repo management (path inlined: DOTFILES_REPO_DIR itself is
# one of the excluded dev-infra vars)
alias config='/usr/bin/git --git-dir="${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles" --work-tree=$HOME'
