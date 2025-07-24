# FISH - LOGOUT REQUIRED
ln -sfn ~/.dotfiles/fish/config.fish ~/.config/fish/config.fish
chsh -sh /usr/bin/fish

# KITTY
ln -sfn ~/.dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf

# STARSHIP
ln -sfn ~/.dotfiles/starship/starship.toml ~/.config/starship/starship.toml

# CASE INSENSITIVE
ln -sfn ~/.dotfiles/inputrc ~/.inputrc

# GIT
ln -sfn ~/.dotfiles/gitconfig ~/.gitconfig
