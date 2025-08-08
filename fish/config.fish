fish_add_path ~/software/nvim/bin
fish_add_path /usr/local/texlive/2024/bin/x86_64-linux
fish_add_path ~/software/vcpkg

set -gx VCPKG_ROOT ~/software/vcpkg
set -gx EDITOR nvim
set -gx VISUAL nvim

alias vi nvim
alias vim nvim
alias 7z 7zz

set -U fish_greeting

# Load user-specific configs
test -f $__fish_config_dir/user.fish; and source $__fish_config_dir/user.fish

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/franciscoalmeida/miniconda3/bin/conda
    eval /home/franciscoalmeida/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/home/franciscoalmeida/miniconda3/etc/fish/conf.d/conda.fish"
        . "/home/franciscoalmeida/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/home/franciscoalmeida/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<
