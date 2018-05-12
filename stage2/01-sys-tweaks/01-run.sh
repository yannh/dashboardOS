#!/bin/bash -e
set -x

install -d				"${ROOTFS_DIR}/etc/systemd/system/rc-local.service.d"
install -m 644 files/ttyoutput.conf	"${ROOTFS_DIR}/etc/systemd/system/rc-local.service.d/"
install -m 644 files/50raspi		"${ROOTFS_DIR}/etc/apt/apt.conf.d/"
install -m 644 files/console-setup   	"${ROOTFS_DIR}/etc/default/"
install -m 755 files/rc.local		"${ROOTFS_DIR}/etc/"

on_chroot << \EOF
for GRP in input spi i2c gpio; do
	groupadd -f -r "$GRP"
done
for GRP in dialout cdrom audio users video games plugdev input gpio spi i2c netdev; do
  adduser pi $GRP
done
EOF

on_chroot << EOF
setupcon --force --save-only -v
EOF

on_chroot << EOF
usermod --pass='*' root
EOF
