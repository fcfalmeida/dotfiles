fish_add_path ~/.local/bin
fish_add_path ~/go/bin/
fish_add_path ~/software/nvim/bin
fish_add_path /usr/local/texlive/2024/bin/x86_64-linux
fish_add_path ~/software/vcpkg

set -Ux VCPKG_ROOT ~/software/vcpkg
set -Ux EDITOR nvim
set -Ux VISUAL nvim

alias vi nvim
alias vim nvim
alias 7z 7zz

set -U fish_greeting

# Load user-specific configs
test -f $__fish_config_dir/user.fish; and source $__fish_config_dir/user.fish

if type -q nvm
    nvm use latest &> /dev/null
end
