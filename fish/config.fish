if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias latex="latexmk -pvc -f -pdf"

export PATH="$PATH:/opt/nvim/"

starship init fish | source

pokemon -r {kanto,johto,hoenn} -l 0.8

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/leite/miniconda3/bin/conda
    eval /home/leite/miniconda3/bin/conda "shell.fish" hook $argv | source
else
    if test -f "/home/leite/miniconda3/etc/fish/conf.d/conda.fish"
        . "/home/leite/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH /home/leite/miniconda3/bin $PATH
    end
end
# <<< conda initialize <<<
