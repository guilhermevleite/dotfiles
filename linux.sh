# Updating and installing the repo updates
sudo apt-get update -y
sudo apt-get upgrade -y

# Installing new stuff
sudo apt-get install htop -y
sudo apt-get install python3-neovim -y
sudo apt-get install git -y
sudo apt-get install zsh -y
sudo apt-get install curl -y
sudo apt-get install fonts-powerline -y
sudo apt-get install psensor -y
sudo apt-get install ctags -y
sudo apt-get install net-tools -y
sudo apt-get install mysql-server -y
sudo apt-get install openjdk-8-jdk -y
sudo apt-get install latexmk -y
sudo apt-get install texlive-fonts-recommended -y
sudo apt-get install xzdec -y

# Making BASH case insensitive, just in case
# if [ ! -a /home/leite/.inputrc ]; then echo '$include /etc/inputrc' > /home/leite/.inputrc; fi
# echo 'set completion-ignore-case On' >> /home/leite/.inputrc

cd /home/leite/Workspace/

# Toggling Fn keys

# sudo bash -c "echo 2 > /sys/module/hid_apple/parameters/fnmode"

# or

# echo options hid_apple fnmode=2 | sudo tee -a /etc/modprobe.d/hid_apple.conf
# sudo update-initramfs -u -k all
# sudo reboot # optional

# Setting Powerlevel9k theme for ZSH
mkdir -p /home/leite/.oh-my-zsh/custom/themes
git clone https://github.com/bhilburn/powerlevel9k.git /home/leite/.oh-my-zsh/custom/themes/powerlevel9k

# Installing powerfonts
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf

mkdir -p /home/leite/.local/share/fonts
sudo mv PowerlineSymbols.otf /home/leite/.local/share/fonts/

fc-cache -vf /home/leite/.local/share/fonts/

mkdir -p /home/leite/.config/fontconfig/conf.d
sudo mv 10-powerline-symbols.conf /home/leite/.config/fontconfig/conf.d/

# Must install this too: https://github.com/gabrielelana/awesome-terminal-fonts
git clone https://github.com/gabrielelana/awesome-terminal-fonts /tmp/awesome-fonts

mkdir -p /home/leite/.fonts
sudo mv /tmp/awesome-fonts/build/* /home/leite/.fonts/

fc-cache -fv /home/leite/.fonts
sudo mv /tmp/awesome-fonts/config/10-symbols.conf /home/leite/.config/fontconfig/conf.d/

# Setting up VIM environment
# git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# ln -s /home/leite/workspace/dotfiles/vim/vimrc /home/leite/.vimrc
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Conda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh
sudo chmod +x /tmp/miniconda.sh
/tmp/miniconda.sh

# rm -rf miniconda.sh

# Install dracula for gnome terminal
sudo apt-get install dconf-cli -y
git clone https://github.com/GalaticStryder/gnome-terminal-colors-dracula /tmp/dracula-terminal
cd /tmp/dracula-terminal
./install.sh

# Setting up ZSH
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -s /home/leite/Workspace/dotfiles/zsh/zshrc_linux /home/leite/.zshrc
