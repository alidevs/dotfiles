if status is-interactive
    and not set -q TMUX
    if tmux has-session -t home
        exec tmux attach-session -t home
    else
        tmux new-session -s home
    end
end

starship init fish | source
zoxide init fish | source
direnv hook fish | source

alias cd="z"
alias lg="lazygit"
alias ld="lazydocker"
alias cat="bat"

alias nv="neovide --fork --frame=none --no-idle"
alias vim="nvim"
alias tmux="tmux -f ~/.config/tmux/tmux.conf"

alias ls="eza"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias l="ls -l"
alias lt="ls --tree --level=2"
alias lat="ls -la --tree --level=2"

alias run="docker compose run"
alias runrm="docker compose run --rm"
alias up="docker compose up"
alias build="docker compose build"
alias down="docker compose down"
alias dps="docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.Ports}}'"

fish_config theme choose Rosé\ Pine
set -Ux DOTNET_ROOT /usr/share/dotnet
fish_add_path /usr/share/dotnet
fish_add_path $HOME/.dotnet/tools

function fish_user_key_bindings
    fish_vi_key_bindings

    bind -M insert \cs pet-select
    bind -M insert \eq push-line
    bind yy fish_clipboard_copy
    bind Y fish_clipboard_copy
    bind p fish_clipboard_paste
end
