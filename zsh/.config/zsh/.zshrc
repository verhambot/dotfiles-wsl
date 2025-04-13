setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt SHARE_HISTORY
HISTFILE="$HOME/.config/zsh/.histfile"
HISTSIZE=1000
SAVEHIST=1000


autoload -Uz compinit
compinit

setopt GLOB_DOTS

zstyle :compinstall filename "$HOME/.config/zsh/.zshrc"

zstyle ":completion:*" menu select
zstyle ":completion::complete:*" gain-privileges 1
zstyle ":completion:*" rehash true
zstyle ":completion:*" matcher-list "m:{a-zA-Z-_}={A-Za-z_-}" "r:|=*" "l:|=* r:|=*"


bindkey -e


typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

autoload -U edit-command-line
zle -N edit-command-line

bindkey "${key[Home]}"           beginning-of-line
bindkey "${key[End]}"            end-of-line
bindkey "${key[Insert]}"         overwrite-mode
bindkey "${key[Backspace]}"      backward-delete-char
bindkey "${key[Delete]}"         delete-char
bindkey "${key[Up]}"             up-line-or-beginning-search
bindkey "${key[Down]}"           down-line-or-beginning-search
bindkey "${key[Left]}"           backward-char
bindkey "${key[Right]}"          forward-char
bindkey "${key[PageUp]}"         beginning-of-buffer-or-history
bindkey "${key[PageDown]}"       end-of-buffer-or-history
bindkey "${key[Shift-Tab]}"      reverse-menu-complete
bindkey "${key[Control-Left]}"   backward-word
bindkey "${key[Control-Right]}"  forward-word
bindkey "\C-x\C-e"               edit-command-line

if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi


autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt PROMPT_SUBST

function __parse_git_dirty() {
    local ret=$?;
    if [[ -n $(GIT_OPTIONAL_LOCKS=0 git status --porcelain --untracked-files=no 2> /dev/null | tail -n 1) ]]
    then
        echo "*"
    fi
    return ret
}

function __conda_env_version() {
    local ret=$?;
    if [ -n "${CONDA_DEFAULT_ENV}" ]
    then
        echo -n " %F{yellow}py:(%F{white}${CONDA_DEFAULT_ENV##*/}%F{yellow})%f"
    fi
    return ret
}

function __nvm_get_node_version() {
    local ret=$?;
    if [[ -n "$NVM_BIN" ]]; then
        echo " %F{cyan}nvm:(%F{white}$(basename $(dirname "$NVM_BIN"))%F{cyan})%f"
    fi
    return ret
}

zstyle ":vcs_info:git:*" formats " %F{magenta}%s:(%F{white}%b%F{magenta})%f"

precmd() { echo }
PROMPT=$'%B%F{blue}%(5~|.../%4~|%d)%f%b'
PROMPT+=$'%B%F{red}%(1j. ↓%j.)%f%b'

PROMPT+=$'%B${vcs_info_msg_0_}%b'
PROMPT+=$'%B%F{white}$(__parse_git_dirty)%f%b'
PROMPT+=$'%B$(__conda_env_version)%b'
PROMPT+=$'%B$(__nvm_get_node_version)%b'

PROMPT+=$'\n%F{white}%(!.#.$)%f '


# source "$NVM_DIR/nvm.sh" --no-use
# source "$NVM_DIR/bash_completion"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/amoghsk/.local/share/miniconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/amoghsk/.local/share/miniconda/etc/profile.d/conda.sh" ]; then
        . "/home/amoghsk/.local/share/miniconda/etc/profile.d/conda.sh"
    else
        export PATH="/home/amoghsk/.local/share/miniconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


source "$HOME/.config/zsh/.zsh_aliases"
