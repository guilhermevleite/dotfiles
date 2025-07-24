ln -sfn ~/.dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -sfn ~/.dotfiles/fish/config.fish ~/.config/fish/config.fish
ln -sfn ~/.dotfiles/neovim/lazyvim/init.lua ~/.config/nvim/init.lua
ln -sfn ~/.dotfiles/starship/starship.toml ~/.config/startship.toml
ln -sfn ~/.dotfiles/inputrc ~/.inputrc
ln -sfn ~/.dotfiles/gitconfig ~/.gitconfig

chsh -s /usr/bin/fish
