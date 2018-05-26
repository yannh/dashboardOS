# DashboardOS for Raspberry PI

DashboardOS is a linux distribution for Raspberry PI optimised for digital signage. It uses Chromium in full screen to display your dashboards, videos, webpages. 

It is designed to be:

 * **Reliable** DashboardOS uses a read-only root partition. No writes occur on the microSD card, making it suitable to regular, ad-hoc power-cyclings.
 * **Secure** It is built from scratch and ships with only the bare minimum - no SSH, VNC, or even user account to log in with.
 * **Easy-to-use** Just configure the address of your dashboard in the "dashboard.txt" file in the boot partition, and you're good to go.

## Download

You can download the latest version [here](https://github.com/yannh/dashboardOS/releases). Download the latest zip file, extract it, and burn it to a microSD card using dd or bmaptool.

## Configure WIFI

Open the file "wpa\_supplicant.conf" in the boot partition, uncomment all lines and fill in your SSID and password.

## How to build

Being a fork of Raspberry Pi's [Pi-Gen](https://github.com/RPi-Distro/pi-gen), it uses the same build system. Stages 0-2 have been slightly adapted, and:

 * stage3: everything that is required to get DashboardOS to work. Will install Chromium, and all required configuration and scripts to have a fully working system. This stage produces a build that is used during development.
 * stage4: additional security hardening. Firewall rules, reduced privileges for the main user. This stage produces the release build.

## Credits

The project is inspired from [FullPageOS]([ttps://github.com/guysoft/FullPageOS) by @GuySoft.
