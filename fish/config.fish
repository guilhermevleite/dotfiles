if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias latex="latexmk -pvc -f -pdf"
alias lt="du -sh * | sort -h"

export PATH="$PATH:/opt/nvim/"

starship init fish | source

pokemon
