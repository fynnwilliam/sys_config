#!/usr/bin/env bash

_install_homebrew() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}


# this block implements a function to configure $PATH for homebrew.
_perform_next_steps() {
  [ $SHELL == "/bin/zsh" ] && shell_profile=~/.zprofile || shell_profile=~/.profile
  
  grep -qs 'eval "$('$1')"'  $shell_profile || echo 'eval "$('$1')"' >> $shell_profile
  eval "$($1)"
}


# the next line implements a function for executing homebrew commands.
_brew() { for line in $2; do brew $1 $line; done; }


[ $(command -v brew) ] || _install_homebrew

[ $(arch)  == "arm64" ] && _perform_next_steps '/opt/homebrew/bin/brew shellenv' ||
[ $(uname) == "Linux" ] && _perform_next_steps '/home/linuxbrew/.linuxbrew/bin/brew shellenv'


raw_user_content="https://raw.githubusercontent.com/fynnwilliam/sys_config/main"

_brew "install" "$(curl -fsSL ${raw_user_content}/formulae)"
_brew "tap" "$(curl -fsSL ${raw_user_content}/taps)"
_brew "install --cask" "$(curl -fsSL ${raw_user_content}/casks)"


# configure vim to help in writting better git commit messages.
echo "autocmd Filetype gitcommit setlocal spell textwidth=72" >> ~/.vimrc


# the next line install oh-my-zsh.
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
