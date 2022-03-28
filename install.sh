#!/usr/bin/env bash

_install_homebrew() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || exit 1
}

_configure_path() {
  [ $SHELL == "/bin/zsh" ] && shell_profile=~/.zprofile || shell_profile=~/.profile
  
  grep -qs 'eval "$('$1')"'  $shell_profile || echo 'eval "$('$1')"' >> $shell_profile
  eval "$($1)"
}

# the next line implements a function for executing homebrew commands.
_brew() { for line in $2; do brew $1 $line; done; }

_enable_better_commit_message() {
  echo "autocmd Filetype gitcommit setlocal spell textwidth=72" >> ~/.vimrc
}

_install_oh_my_zsh() {
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

[ $(command -v brew) ] || _install_homebrew

[ $(arch)  == "arm64" ] && _configure_path'/opt/homebrew/bin/brew shellenv' ||
[ $(uname) == "Linux" ] && _configure_path'/home/linuxbrew/.linuxbrew/bin/brew shellenv'

raw_user_content="https://raw.githubusercontent.com/fynnwilliam/sys_config/main"

_brew "install" "$(curl -fsSL ${raw_user_content}/formulae)"
_brew "tap" "$(curl -fsSL ${raw_user_content}/taps)"
_brew "install --cask" "$(curl -fsSL ${raw_user_content}/casks)"

_enable_better_commit_message # && _install_oh_my_zsh
