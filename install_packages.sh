#!/usr/bin/env bash

echo_green "Installing gentoo packages"

TARGETS="sharutils gentoolkit"
sudo emerge --ask $TARGETS

echo_green "Packages are installed"
