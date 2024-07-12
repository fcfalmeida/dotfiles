# If you come from bash you might have to change your $PATH.
#export PATH=$HOME/bin:/usr/local/bin:$PATH

export PATH=$PATH:$HOME/.local/bin

# chimtools binary
export PATH=$PATH:$HOME/projects/Chimera/engine/build/bin/debug

export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.local/share/bob/v0.10.0/nvim-linux64/bin
export PATH=$PATH:/usr/local/texlive/2024/bin/x86_64-linux

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Aliases
alias vi="nvim"
alias vim="nvim"
alias bat="batcat"
alias plantuml="java -jar $HOME/software/plantuml.jar"

function docker_build() {
    docker build -t $1 . --rm
}

function docker_run() {
    docker run -it --mount type=bind,source=$HOME/.ssh,target=/root/.ssh --mount type=bind,source=${PWD},target=/src --rm $1 bash
}

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="hyperzsh"

plugins=(
	git
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
fpath+=${ZDOTDIR:-~}/.zsh_functions
#
# Custom aliases
alias ssh="kitty +kitten ssh"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/franciscoalmeida/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/franciscoalmeida/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/franciscoalmeida/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/franciscoalmeida/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
