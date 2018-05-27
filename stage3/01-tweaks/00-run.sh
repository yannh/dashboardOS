#!/bin/bash -e

rm -f "${ROOTFS_DIR}/etc/systemd/system/dhcpcd.service.d/wait.conf"

# Autologin
sed ${ROOTFS_DIR}/etc/systemd/system/autologin@.service -i -e "s#^ExecStart=-/sbin/agetty --autologin [^[:space:]]*#ExecStart=-/sbin/agetty --autologin pi#"
sed ${ROOTFS_DIR}/etc/systemd/system/autologin@.service -i -e "s#^After=rc-local.service[^[:space:]]*#After=rc-local.service openntpd.service#"
on_chroot << EOF
ln -snf /etc/systemd/system/autologin@.service "/etc/systemd/system/getty.target.wants/getty@tty1.service"
EOF

# Disable overscan
sed -i '/disable_overscan/s/.*/disable_overscan=1/' ${ROOTFS_DIR}/boot/config.txt

# Autostart chromium
install -m 0644 files/xsessionrc "${ROOTFS_DIR}/home/pi/.xsessionrc"
install -m 0644 files/dashboard.txt "${ROOTFS_DIR}/boot/dashboard.txt"

install -m 0644 files/openntpd "${ROOTFS_DIR}/etc/default/openntpd"

# Disable timesyncd, since we ll use openntpd
on_chroot << EOF
systemctl disable systemd-timesyncd
EOF

# Link wpa-supplicant conf to /boot
on_chroot << EOF
rm -f /etc/wpa_supplicant/wpa_supplicant.conf
ln -sf /boot/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
EOF
install -m 0644 files/wpa_supplicant.conf "${ROOTFS_DIR}/boot/wpa_supplicant.conf"
