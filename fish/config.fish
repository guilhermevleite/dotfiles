if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias latex="latexmk -pvc -f -pdf"

export PATH="$PATH:/opt/nvim/"

starship init fish | source
