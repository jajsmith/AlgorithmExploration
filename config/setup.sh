# From https://gist.github.com/kevin-smets/8568070
# and https://coderwall.com/p/yiot4q/setup-vim-powerline-and-iterm2-on-mac-os-x
# and https://github.com/VundleVim/Vundle.vim

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install vim
brew install vim --with-python --with-ruby --with-perl

# Install Vundler for vim plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone git@github.com:vim-airline/vim-airline.git ~/.vim/bundle/vim-airline
git clone git@github.com:tpope/vim-fugitive.git ~/.vim/bundle/vim-fugitive
git clone git@github.com:vim-syntastic/syntastic.git ~/.vim/bundle/syntastic


# Install iterm2
brew cask install iterm2

# Install ZSH
brew install zsh zsh-completions
chsh -s $(which zsh)

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


echo "Thanks for configuring!"
echo "Remember: change iterm2 colour scheme and fonts"
echo "Remember: run 'vim +PluginInstall +qall'"
