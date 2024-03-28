if status is-interactive
    # Commands to run in interactive sessions can go here
end
starship init fish | source
direnv hook fish | source
pyenv init - | source
neofetch
status is-login; and source (jenv init -|psub)
zoxide init fish | source

# Aliases
alias ls=lsd
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias l="ls -l"
alias lt="ls --tree"
alias lat="ls -la --tree"

alias cat=bat

alias cd="z"
alias lg="lazygit"
