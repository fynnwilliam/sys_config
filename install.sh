#!/usr/bin/env bash

raw_user_content="https://raw.githubusercontent.com/fynnwilliam/sys_config/main"

echo "$(curl -fsSL ${raw_user_content}/install_apis)" > /tmp/install_apis &&
	source /tmp/install_apis

[ $(command -v brew) ] || _install_homebrew_and_configure_path || exit 1

_brew "install" "$(curl -fsSL ${raw_user_content}/formulae)"
_brew "tap" "$(curl -fsSL ${raw_user_content}/taps)"
_brew "install --cask" "$(curl -fsSL ${raw_user_content}/casks)"

_enable_better_commit_message # && _install_oh_my_zsh
