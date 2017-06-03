#!/usr/bin/env bash

echo_green $LOL
echo_green 'Updating grub configuration'

sudo su -c 'cat > /etc/grub.d/41_custom << EOFTOP
#!/bin/sh
cat <<EOF
if [ -f  \${config_directory}/custom.cfg ]; then
  source \${config_directory}/custom.cfg
elif [ -z "\${config_directory}" -a -f  \$prefix/custom.cfg ]; then
  source \$prefix/custom.cfg;
fi
set color_normal=red/black
set color_highlight=white/red
EOF

EOFTOP'
sudo chmod a+x /etc/grub.d/41_custom

sudo su -c "cat > /etc/default/grub << EOF
GRUB_DISTRIBUTOR=\"$DISTRIBUTION_NAME\"
GRUB_CMDLINE_LINUX=\"rw init=/usr/lib/systemd/systemd rtl8723be.fwlps=0\"
EOF"

echo_green 'Making configuration'
sudo grub-mkconfig -o /boot/grub/grub.cfg
