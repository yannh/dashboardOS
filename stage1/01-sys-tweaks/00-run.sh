#!/bin/bash -e

install -d "${ROOTFS_DIR}/etc/systemd/system/getty@tty1.service.d"
install -m 644 files/noclear.conf "${ROOTFS_DIR}/etc/systemd/system/getty@tty1.service.d/noclear.conf"
install -d "${ROOTFS_DIR}/etc/systemd/system/local-fs.target.wants"
install -m 644 files/populate-overlay.service "${ROOTFS_DIR}/etc/systemd/system/populate-overlay.service"
install -v -m 644 files/fstab "${ROOTFS_DIR}/etc/fstab"

rm -rf ${ROOTFS_DIR}/var/tmp
ln -s /tmp ${ROOTFS_DIR}/var/tmp

on_chroot << EOF
if ! id -u pi >/dev/null 2>&1; then
	adduser --disabled-password --gecos "" pi
fi
echo "pi:raspberry" | chpasswd
echo "root:root" | chpasswd
ln -sf /etc/systemd/system/populate-overlay.service /etc/systemd/system/local-fs.target.wants/
EOF
