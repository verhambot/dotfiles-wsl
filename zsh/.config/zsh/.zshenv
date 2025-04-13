export EDITOR="nvim"


# export NVM_DIR="$HOME/.local/share/nvm"


export GOPATH="$HOME/.local/share/go"


# export RUSTUP_HOME="$HOME/.local/share/rustup"
# export CARGO_HOME="$HOME/.local/share/cargo"
# source "$CARGO_HOME/env"


# export PLATFORMIO_CORE_DIR="$HOME/.local/share/platformio"
# export PLATFORMIO_SETTING_PROJECTS_DIR="$HOME/Projects"


typeset -U path PATH

path=("/usr/local/go/bin" $path)

path=("/usr/local/cuda/bin" $path)

export PATH
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"
