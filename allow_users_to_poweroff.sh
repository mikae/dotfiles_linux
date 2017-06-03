#!/usr/bin/env bash

if [ "$DISTRIBUTION_NAME" == "Gentoo" ]; then
    echo_green "Checking shutdown group exists"
    if ! grep -q shutdown /etc/group
    then
        echo_red "Group shutdown doesn\'t exist"
        sudo groupadd shutdown
    else
        echo_green "Group shutdown exists"
    fi

    echo_green "Changing group of /sbin/poweroff to shutdown"
    sudo chown -v :shutdown /sbin/poweroff

    echo_green "Changing group of /sbin/reboot to shutdown"
    sudo chown -v :shutdown /sbin/reboot

    sudo chmod -v 4754 /sbin/poweroff
    sudo chmod -v 4754 /sbin/reboot

    [ -L /sbin/poweroff ] || sudo ln -s -v /sbin/poweroff /bin/poweroff
    [ -L /sbin/reboot ] || sudo ln -s -v /sbin/reboot /bin/reboot
else
    echo_green "There is no need to specifically allow regular users to shutdown"
fi
