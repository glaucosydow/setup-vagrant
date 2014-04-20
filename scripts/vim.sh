#!/usr/bin/env bash

#
# Program: vim.sh
# Author: Vitor Britto
#
# Description:
# Setup VIM
#

# Declaring variables
GFILE=".gvimrc"
FILE=".vimrc"
DIR="/home/vagrant/.vim"

# Scaffolding
echo " → Installing VIM"

if [ -d "$DIR" ]; then
    mv /home/vagrant/.vim /home/vagrant/.vim_bkp
fi

if [ -f "$FILE" ]; then
    mv /home/vagrant/.vimrc /home/vagrant/.vimrc_bkp
fi

if [ -f "$GFILE" ]; then
    mv /home/vagrant/.gvimrc /home/vagrant/.gvimrc_bkp
fi

git clone --recursive http://github.com/vitorbritto/setup-vim.git $DIR
ln -s /home/vagrant/.vim/vimrc $FILE
rm -rf /home/vagrant/.vim/init.sh
