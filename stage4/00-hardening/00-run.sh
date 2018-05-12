#!/bin/bash

# Disable password for user pi
on_chroot << EOF
usermod --pass='*' pi
EOF

rm -f ${ROOTFS_DIR}/etc/sudoers.d/010_pi-nopasswd

# Iptables - no incoming conns, limit outgoing conns
# Disable USB ports
