if status is-interactive
    # Commands to run in interactive sessions can go here
end

export PATH="$PATH:/opt/nvim/"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/leite/miniconda3/bin/conda "shell.fish" hook $argv | source
# <<< conda initialize <<<

starship init fish | source
