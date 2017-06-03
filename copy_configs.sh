#!/usr/bin/env bash

echo_green "Copying configuration"
sudo cp -Rv ./etc/* /etc
sudo cp -Rv ./usr/* /usr
