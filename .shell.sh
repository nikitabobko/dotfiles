#############################
### Environment variables ###
#############################

export JAVA_HOME="/usr/lib/jvm/java-8-openjdk"
export VISUAL="v"
export EDITOR="v"
# export PAGER="vimpager"
export CP="CHERRY_PICK_HEAD"
# respect gitignore by default (and I am not sure but probably fd is faster than find then this export also speed ups the fzf)
export FZF_DEFAULT_COMMAND='fd --type f --hidden'
export PATH="$HOME/.bin:$PATH"
export ANDROID_HOME="$HOME/.android/sdk"
# export FZF_DEFAULT_OPTS="\
# --height 60% --layout=reverse --multi \
# --bind 'ctrl-y:execute-silent(echo {} | xclip -selection clipboard)' \
# --bind 'ctrl-o:execute-silent(o {})'"
export NNN_PLUG='p:preview-tui'
export NNN_FIFO=/tmp/nnn.fifo # reuiqred for nnn-preview plugin
#export LESS="-i"

if isMacOs; then
    # https://gist.github.com/skyzyx/3438280b18e4f7c490db8a2a2ca0b9da
    BREW_BIN="/usr/local/bin/brew"
    if [ -f "/opt/homebrew/bin/brew" ]; then
        BREW_BIN="/opt/homebrew/bin/brew"
    fi

    if type "${BREW_BIN}" &> /dev/null; then
        export BREW_PREFIX="$("${BREW_BIN}" --prefix)"
        for bindir in "${BREW_PREFIX}/opt/"*"/libexec/gnubin"; do export PATH=$bindir:$PATH; done
        for bindir in "${BREW_PREFIX}/opt/"*"/bin"; do export PATH=$bindir:$PATH; done
        for mandir in "${BREW_PREFIX}/opt/"*"/libexec/gnuman"; do export MANPATH=$mandir:$MANPATH; done
        for mandir in "${BREW_PREFIX}/opt/"*"/share/man/man1"; do export MANPATH=$mandir:$MANPATH; done
    fi

    export PATH="$HOME/.bin-macos:$PATH"
fi

if [ -d $ANDROID_HOME ]; then
    export PATH="$PATH:$ANDROID_HOME/platform-tools"
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

simplified_mode() {
    test -z "$DISPLAY" && ! isMacOs
}

CURRENT_SHELL=$1
if [ -z $CURRENT_SHELL ]; then
    echo_red "Current shell is unknown. Pass it parameter to ~/.shell.sh"
fi
is_zsh() {
    test $CURRENT_SHELL = "zsh"
    return $?
}

echo_red() {
    echo -e "\e[1;31m$@\e[0m"
}

xdotool_available() {
    if simplified_mode; then
        return 1
    fi
    return $(command -v xdotool > /dev/null)
}

join_to_string() { local IFS="$1"; shift; echo "$*"; }

########################
### General settings ###
########################

if ! isMacOs && [[ "$(sysctl kernel.sysrq)" != *"= 1" ]]; then
    echo_red "sysrq kernel option is off. Enter the sudo password to turn it on"
    sudo sysctl kernel.sysrq=1
fi

if ! simplified_mode; then
    if ! xdotool_available; then
        echo_red "xdotool isn't available. GUI notifications won't work"
    fi

    if ! command -v notify-send > /dev/null; then
        echo_red "notify-send isn't installed. GUI notifications won't work"
    fi
fi

if is_zsh; then
    # Lines configured by ZSH setup wizard
    HISTFILE=~/.zsh_history
    HISTSIZE=5000
    SAVEHIST=1000

    # 0ms for key sequences (I did it for removing delay for ESC key)
    export KEYTIMEOUT=0

    source_package() {
        for it in $@; do
            if [ -f $it ]; then
                source $it
            else
                echo_red "Cannot find $it"
            fi
        done
    }

    if isMacOs; then
        source $(brew --prefix)/Cellar/antigen/*/share/antigen/antigen.zsh
    else
        source /usr/share/zsh/share/antigen.zsh
    fi

    # vim mode
    # bindkey -v
    antigen bundle jeffreytse/zsh-vi-mode
    antigen bundle zsh-users/zsh-autosuggestions

    antigen apply

    zvm_after_init() {
        if isMacOs; then
            source_package $(brew --prefix)/Cellar/fzf/*/shell/key-bindings.zsh
            source_package $(brew --prefix)/Cellar/fzf/*/shell/completion.zsh
            # source_package $(brew --prefix)/Cellar/fzf/*/shell/fzf-extras.zsh
        else
            source_package /usr/share/fzf/key-bindings.zsh
            source_package /usr/share/fzf/completion.zsh
            source_package /usr/share/fzf/fzf-extras.zsh
        fi
        zvm_bindkey viins '^H' backward-kill-word
        zvm_bindkey vicmd 'H' zle vi-first-non-blank
        zvm_bindkey vicmd 'L' zle vi-end-of-line

        # Disable because I used to press tab when I know that the first match
        # will be ok. fzf-tab prompts unnecessary fuzzy search in such case
        # source_package ~/.app/fzf-tab/fzf-tab.plugin.zsh
    }
    zvm_after_init

    zvm_vi_yank() { # Hack from https://github.com/jeffreytse/zsh-vi-mode/issues/19
        zvm_yank
        printf %s "${CUTBUFFER}" | cl
        zvm_exit_visual_mode
    }

    # source_package ~/.app/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh # Disable because comments are not visible

    # Starts the completion system
    if type brew &>/dev/null; then
        FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"
        FPATH="$(brew --prefix)/share/zsh/site-functions:$FPATH"
    fi
    autoload -Uz compinit
    compinit
    # Initialize colors
    autoload -U colors
    colors

    # Use run-help for help for builtin commands like `zle`, `setopt`
    unalias run-help
    autoload run-help

    # If globbing expression don't match anything then
    # ZSH will pass it "as it is". (e.g. asterisk expansion)
    setopt +o nomatch

    # Enable comments in interactive shell
    setopt INTERACTIVE_COMMENTS

    # File completion after '=' character in args
    setopt MAGIC_EQUAL_SUBST

    # setopt MENU_COMPLETE
    # Turn off additional zsh verification for rm smt/*
    setopt rm_star_silent

    # Share history between different instances of zsh
    # setopt share_history

    # Turn on case insensetive in completion
    zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'

    # Discard autosuggest with Escape
    # bindkey '\e' autosuggest-clear # why do I need it? 
fi

###############
### aliases ###
###############

# bookmarks
alias bk='cd ~/jb/kotlin'
alias bi='cd ~/jb/intellij'
alias bn='cd ~/a/notes'
alias jb='cd ~/jb'
alias a='cd ~/a'
alias sb='subl'

alias xdot='detach xdot'
alias vlc='detach vlc'

v-sh() { nvim "+source ~/.v/vim-sh.vim" "$@"; }
alias mount='udisksctl mount -b'
alias umount='udisksctl unmount -b'
alias gw='./gradlew'
alias gwDebug='./gradlew --stop && ./gradlew -Dkotlin.daemon.jvm.options="-agentlib:jdwp=transport=dt_socket\\,server=y\\,suspend=y\\,address=5005" '
alias ls='ls -F --color=auto'
alias diff='diff -us --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
zd() { cd "$(interactive-cd)"; }
alias egrep='egrep --color=auto'
alias ll='ls -alFh'
alias cp='cp -r'
alias scp='scp -r'
alias mkdir='mkdir -p'
alias gs='echo fucking ghostscript'
alias fd='fd --hidden'
alias vanila-vim='vim -u NONE'
vanila-tmux() { tmux -L "$RANDOM" -f /dev/null "$@"; }
alias lf='ls | fzf'
alias cal='cal -y'
alias i='idea-bobko'
alias help='run-help' # For shell built-ins
tmp() { cd $(mktemp -d); }
killvlc() {
    # It freezes so often that it deserves a separate alias
    ps -A | grep vlc | awk '{print$1}' | while read it; do kill -9 $it; done
}
alias n='nnn -p /tmp/nnn-select && ! test -s /tmp/nnn-select || v /tmp/nnn-select'
alias ta='tmux attach || tmux new-session -s MMM'
alias tmux-source='tmux source ~/.tmux.conf'
alias rm='rm-trash'
alias cg='cd "$(git rev-parse --show-toplevel)"'

if is_zsh; then
    true # empty then cannot be parsed in bash
    # compdef git d
    # compadd d _path_files
    # compdef '_dispatch git git' d

else
    # complete -o bashdefault -o default -o nospace -F __git_wrap__git_main dotfiles
    _completion_loader git
fi

if ! isMacOs && [[ "$(tty)" == "/dev/tty"* ]]; then
    alias x='startx'
    alias p='poweroff'
    alias r='reboot'
fi

##############
### Prompt ###
##############

if is_zsh; then
    # Enable $(cmd) in $PS1 etc.
    setopt prompt_subst
fi

displaytime() {
    local T=$1
    local D=$((T/60/60/24))
    local H=$((T/60/60%24))
    local M=$((T/60%60))
    local S=$((T%60))
    (( $D > 0 )) && printf '%d days ' $D
    (( $H > 0 )) && printf '%d hours ' $H
    (( $M > 0 )) && printf '%d minutes ' $M
    (( $D > 0 || $H > 0 || $M > 0 )) && printf 'and '
    printf '%d seconds\n' $S
}

LAST_CMD_START_SECONDS=0
LAST_EXECUTED_CMD=""
CURRENT_SESSION_WINDOW_ID=""

update_terminal_title() {
    echo -ne "\033]0;${PWD} 🚀 ${LAST_EXECUTED_CMD}\007"
    # In tmux window too (see allow-rename in `man tmux`)
    if ! [ -z "$TMUX" ]; then
        # echo -ne "\ek${PWD} 🚀 ${LAST_EXECUTED_CMD}\e\\"
        true
    fi
}

# Before executig command (ZSH only)
preexec() {
    LAST_CMD_START_SECONDS="$SECONDS"
    LAST_EXECUTED_CMD="$1"
    update_terminal_title
    if [ -z "$CURRENT_SESSION_WINDOW_ID" ] && xdotool_available; then
        CURRENT_SESSION_WINDOW_ID=$(xdotool getwindowfocus)
    fi
}

prompt_green() {
    if is_zsh; then
        echo "%F{green}$@%f"
    else
        echo -e "\e[1;32m$@\e[0m"
    fi
}

prompt_red() {
    if is_zsh; then
        echo "%F{red}$@%f"
    else
        echo -e "\e[1;31m$@\e[0m"
    fi
}

prompt_blue() {
    if is_zsh; then
        echo "%F{blue}$@%f"
    else
        echo -e "\e[1;34m$@\e[0m"
    fi
}

# Before showing PROMPT
precmd() {
    # Capture exit code of last command
    local ex=$?
    update_terminal_title

    local spent_time_in_seconds=$(expr $SECONDS - $LAST_CMD_START_SECONDS)
    local spent_time_if_too_long=""
    if is_zsh && [ $spent_time_in_seconds -gt 5 ] && ! [ -z $LAST_EXECUTED_CMD ]; then
        spent_time_if_too_long="\"${LAST_EXECUTED_CMD}\" took $(displaytime $spent_time_in_seconds)"
    fi
    if is_zsh &&
            xdotool_available &&
            ! [ -z "$LAST_EXECUTED_CMD" ] &&
            [ "$(xdotool getwindowfocus)" -ne "$CURRENT_SESSION_WINDOW_ID" ] &&
            command -v notify-send > /dev/null; then
        local notif_body="Finished successfully"
        if [ "$ex" -ne 0 ]; then
            local notif_body="Exited with exit code: $ex"
        fi
        # notify-send "$LAST_EXECUTED_CMD" "$notif_body"
    fi
    LAST_EXECUTED_CMD=""

    local prev_exit_command=""
    if [ "$ex" -ne 0 ]; then
        prev_exit_command=$(prompt_red "Exit Code: $ex ")
    fi

    if is_zsh; then
        local current_path="%~"
        local spent_time_prompt=$(prompt_green $spent_time_if_too_long)
        if [ "$ex" -ne 0 ]; then
            local spent_time_prompt=$(prompt_red $spent_time_if_too_long)
        fi
        RPROMPT=$(join_to_string " " $spent_time_prompt)
    else
        local current_path="\w"
    fi
    if [ ! -z "$VIRTUAL_ENV" ]; then
        local python_env="($(realpath --relative-to=$PWD $VIRTUAL_ENV)) "
    fi
    tmux_status=$([ -z "$TMUX" ] && prompt_red "NOT A TMUX SESSION " || prompt_blue "$(tmux display-message -p '#S') ")
    PS1="${PROMPT_LABEL}${python_env}${prev_exit_command}$(prompt_green "${current_path} \$") "
}
if ! is_zsh; then
    export PROMPT_COMMAND=precmd
fi

