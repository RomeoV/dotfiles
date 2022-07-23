#
# ~/.bashrc
#

# Follow the guide here to use this:
# https://www.atlassian.com/git/tutorials/dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

if [ -f ~/.profile ]; then
  . ~/.profile
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# don't put duplicate lines or lines starting with space in the history.
# see bash(1) for more options
HISTCONTROL=ignoreboth

# append to history file, don't overwrite it
shopt -s histappend

HISTSIZE=-1
HISTFILESIZE=-1

# connect to ssh-agent (launched by systemd)
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

export EDITOR="nvim"
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.emacs.d/bin
export PATH=$PATH:$HOME/.local/bin


source ~/Documents/github/skim/shell/completion.bash
source ~/Documents/github/skim/shell/key-bindings.bash

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/romeo/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/romeo/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/romeo/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/romeo/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
