#!/usr/bin/env bash

set -o errexit
set -o pipefail

MY_EPIC_EDITOR="${EDITOR:-vim}"

source bashep.sh

# Make sure we have a "sane" editor
if [ "${VISUAL}" != "${MY_EPIC_EDITOR}" ]; then
	echo "VISUAL environement variable not set to the the correct editor, fix it or be annoyed"
fi;

if [ "${EDITOR}" != "${MY_EPIC_EDITOR}" ]; then
	echo "EDITOR environement variable not set to the the correct editor, fix it or be annoyed"
fi;

# It would also be nice if our preferred editor is actally available
bashep_check_cmd "${MY_EPIC_EDITOR}"

#ssh keys: 
#ssh-keygen -t ed25519

# Check if git is available
bashep_check_cmd "git"

# Make sure git is configured with the most basic stuff
if ! git config --global user.name > /dev/null; then
	echo "Git username not configured. set it using: git config --global user.name \"Jan Doedel\""
fi

if ! git config --global user.email > /dev/null; then
        echo "Git user mail not configured. set it using: git config --global user.email \"jan.doedel@gizmosys.nl\""
fi

# Check if tmux is available
bashep_check_cmd "tmux"

# Check if a tmux config is present
if [ ! -f ~/.tmux.conf ]; then
	echo "tmux config not found, copying default config";
	cp configs/tmux.conf ~/.tmux.conf
else
	cmp --silent  configs/tmux.conf ~/.tmux.conf || echo "Difference in CM and local tmux config detected."
fi

if [ ! -d ~/bin ]; then
	echo "User bin directory not present, creating it"
	mkdir ~/bin
fi;

if [ ! -f ~/bin/serport ]; then
	echo "kermit helper script \"serport\" not found, copying it to ~/bin"
	cp tools/serport ~/bin
fi;

groups | grep dialout > /dev/null || echo "user not part of the dialout group, you probably want to change that (sudo usermod -a -G dialout ${USER})"
groups | grep vboxusers > /dev/null || echo "user not part of the vboxusers group, change this if using virtualbox (sudo usermod -a -G vboxusers ${USER})"

bashep_check_buildenv
echo "Missing build packages: ${MISSING_BUILD_ENV_PACKAGES}"

bashep_check_devenv
echo "Missing Development packages: ${MISSING_DEV_ENV_PACKAGES}"

bashep_check_yoctoenv
echo "Missing yocto packagees: ${MISSING_YOCTO_ENV_PACKAGES}"

bashep_check_virtenv
echo "Missing virtualisation packages: ${MISSING_VIRT_ENV_PACKAGES}"

bashep_check_targetenv
echo "Missing target packages: ${MISSING_TARGET_ENV_PACKAGES}"
