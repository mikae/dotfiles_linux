#!/usr/bin/env bash

PREFIX=/tmp/vimpager
VIMPAGER_EXECUTABLE_PATH=/usr/local/bin/vimpager
VIMPAGER_SOURCE=https://github.com/rkitover/vimpager

echo_green "Checking if vimpager installed"
if hash vimpager 2>/dev/null; then
    echo_green "vimpager is installed"
    exit
else
    echo_green "vimpager is not installed"
fi

echo_green "Cleaning $PREFIX"
rm -rfv $PREFIX
git clone $VIMPAGER_SOURCE $PREFIX
cd $PREFIX

echo_green "Making"
make && echo_green "Maked"
echo_green "Installing"
sudo make install && echo_green "Installed"
