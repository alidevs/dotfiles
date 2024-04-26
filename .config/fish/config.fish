if status is-interactive
    # Commands to run in interactive sessions can go here
end
starship init fish | source
direnv hook fish | source
pyenv init - | source
# neofetch
status is-login; and source (jenv init -|psub)
zoxide init fish | source

# Aliases
alias ls=lsd
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias l="ls -l"
alias lt="ls --tree --depth=2"
alias lat="ls -la --tree --depth=2"

alias cat=bat

alias cd="z"
alias lg="lazygit"

alias nv="neovide"
alias vim="nvim"
