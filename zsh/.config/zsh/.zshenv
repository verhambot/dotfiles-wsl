export EDITOR="nvim"


export NVM_DIR="$HOME/.local/share/nvm"


export GOPATH="$HOME/.local/share/go"
export GOBIN="$GOPATH/bin"


export RUSTUP_HOME="$HOME/.local/share/rustup"
export CARGO_HOME="$HOME/.local/share/cargo"
source "$CARGO_HOME/env"


export ZIG_HOME="/opt/zig-x86_64-linux-0.15.0-dev.1380+e98aeeb73"


# export PLATFORMIO_CORE_DIR="$HOME/.local/share/platformio"
# export PLATFORMIO_SETTING_PROJECTS_DIR="$HOME/projects"


typeset -U path PATH

path=("$HOME/.local/bin" $path)

path=("/usr/local/go/bin" $path)
path=($GOBIN $path)

path=("/usr/local/cuda/bin" $path)

path=($ZIG_HOME $path)

export PATH
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"
