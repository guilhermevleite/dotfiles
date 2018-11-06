# Updating and installing the repo updates
sudo apt-get update -y
sudo apt-get upgrade -y

# Installing new stuff
sudo apt-get install htop -y
sudo apt-get install vim-gnome -y
sudo apt-get install git -y
sudo apt-get install zsh -y
sudo apt-get install curl -y
sudo apt-get install fonts-powerline -y
sudo apt-get install psensor -y
sudo apt-get install ctags -y

# Making BASH case insensitive, just in case
if [ ! -a /home/leite/.inputrc ]; then echo '$include /etc/inputrc' > /home/leite/.inputrc; fi
echo 'set completion-ignore-case On' >> /home/leite/.inputrc

# Toggling Fn keys

# sudo bash -c "echo 2 > /sys/module/hid_apple/parameters/fnmode"

# or

# echo options hid_apple fnmode=2 | sudo tee -a /etc/modprobe.d/hid_apple.conf
# sudo update-initramfs -u -k all
# sudo reboot # optional

# Setting up ZSH
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -s /home/leite/workspace/dotfiles/zsh/zshrc_linux /home/leite/.zshrc

# Setting Powerlevel9k theme for ZSH
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# Setting up VIM environment
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ln -s /home/leite/workspace/dotfiles/vim/vimrc /home/leite/.vimrc
