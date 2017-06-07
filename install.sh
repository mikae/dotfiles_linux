#!/usr/bin/env bash

# Prerequisites check
# It works for Gentoo

DISTRIBUTION_NAME=unknown

if [ -f /etc/debian_version ]; then
    DISTRIBUTION_NAME="Debian"
elif [ -f /etc/gentoo-release ]; then
    DISTRIBUTION_NAME="Gentoo"
fi

if [ "$DISTRIBUTION_NAME" != "Gentoo" ]; then
    echo "$DISTRIBUTION_NAME is not Gentoo"
    exit 1
fi

export DISTRIBUTION_NAME

# Pretty echo functions

set_red_color() {
    tput setaf 1
}

set_green_color() {
    tput setaf 2
}

reset_color() {
    tput sgr0
}

echo_green() {
    set_green_color
    echo $@
    reset_color
}

echo_red() {
    set_red_color
    echo $@
    reset_color
}

# Export them to be visible in subscripts

export -f set_red_color
export -f set_green_color
export -f reset_color
export -f echo_green
export -f echo_red

# Start

echo_green Linux distribution: $DISTRIBUTION_NAME

bash ./generate_udev_rules.sh
bash ./generate_grub_config.sh
bash ./allow_users_to_poweroff.sh
bash ./change_dns_to_opendns.sh
bash ./copy_configs.sh
bash ./configure_iptables.sh

#bash ./install_packages.sh
bash ./install_vimpager.sh
