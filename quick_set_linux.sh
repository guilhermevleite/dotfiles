mkdir ~/Workspace

# SSH
mkdir ~/.ssh
ln -sfn ~/.dotfiles/ssh_config ~/.ssh/config

# VIM
ln -sfn ~/.dotfiles/neovim/lazyvim/init.lua ~/.config/nvim/init.lua
ln -sfn ~/.dotfiles/neovim/lazyvim/keymaps.lua ~/.config/nvim/lua/config/keymaps.lua

sudo apt-get update -y
sudo apt-get install git curl htop psensor -y
