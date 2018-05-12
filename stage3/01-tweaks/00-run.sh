#!/bin/bash -e

rm -f "${ROOTFS_DIR}/etc/systemd/system/dhcpcd.service.d/wait.conf"

# Autologin
sed ${ROOTFS_DIR}/etc/systemd/system/autologin@.service -i -e "s#^ExecStart=-/sbin/agetty --autologin [^[:space:]]*#ExecStart=-/sbin/agetty --autologin pi#"
on_chroot << EOF
ln -snf /etc/systemd/system/autologin@.service "/etc/systemd/system/getty.target.wants/getty@tty1.service"
EOF

# Disable overscan
sed -i '/disable_overscan/s/.*/disable_overscan=1/' ${ROOTFS_DIR}/boot/config.txt

# Autostart chromium
install -m 0644 files/xsessionrc "${ROOTFS_DIR}/home/pi/.xsessionrc"
install -m 0644 files/dashboard.txt "${ROOTFS_DIR}/boot/dashboard.txt"

# Disable timesyncd, since we ll use openntpd
systemctl disable systemd-timesyncd
