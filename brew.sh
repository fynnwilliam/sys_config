#!/usr/bin/env bash

_install_homebrew() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}


# this block implements a function to configure $PATH for homebrew.
_perform_next_steps() {
  grep -qs 'eval "$('$1')"'  ~/.zprofile || echo 'eval "$('$1')"' >> ~/.zprofile
  eval "$($1)"
}


# the next line implements a function for executing homebrew commands.
_brew() { while read line; do brew $1 $line; done < $2; }


[ $(command -v brew) ] || _install_homebrew


[ $(arch)  == "arm64" ] && _perform_next_steps '/opt/homebrew/bin/brew shellenv' ||
[ $(uname) == "Linux" ] && _perform_next_steps '/home/linuxbrew/.linuxbrew/bin/brew shellenv'


_brew "install" formulae
_brew "tap" taps
_brew "install --cask" casks


# configure vim to help in writting better git commit messages.
echo "autocmd Filetype gitcommit setlocal spell textwidth=72" >> ~/.vimrc


# the next line install oh-my-zsh.
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
