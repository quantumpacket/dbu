# Change Log

All notable changes to this project will be documented in this file.  
The format is based on [Keep a Changelog](http://keepachangelog.com/).

## [v1.6](https://github.com/nodiscc/dbu/releases/tag/1.6) - 2018-09-09

### Added
 * Add libpam-tmpdir package (per-user temporary directories)
 * Virtualization: add virt-top and netcat-openbsd packages

### Changed

 * Replace gnome-system-log with gnome-logs (gnome-system-tools are deprecated)
 * Replace livestreamer with streamlink (active fork)
 * Replace gnome-search-tool with catfish
 * Disable autostarting xfce4-notes
 * Simplify and document sysctl settings
 * Update documentation
 * Improve Makefile download/caching/installation mechanisms
 * Remove conky configuration from the main repository, download/install it from the Makefile

### Removed
 * Desktop utilities: Remove screenruler package (removes dependency on rake/ruby stack)
 * Development/utilities: Remove ranger and pypi2deb package


### Fixed
 * Fix broken XFCE keyboard shortcuts
 * Fix debian installer asking for the mirror directory


## [v1.5.1](https://github.com/nodiscc/dbu/releases/tag/1.5.1) - 2018-06-06

### Added
 * Auto-generate documentation/links to installed Firefox addons pages.

### Removed
 * Remove unused packages at-spi2-core, apparmor-notify, apmd

### Changed
 * Don't disable bluetooth service by default, but boot with bluetooth devices powered down.
 * Various build tools optimizations/improvements/cleanup.
 * Cleanup obsolete desktop session autostart entries.

### Fixed
 * Add missing packages for working virt-manager/KVM virtualization stack
 * Fix broken selection of Firefox default search engine (revert back to Google), add 15 engines to search engines menu.


## [v1.5](https://github.com/nodiscc/dbu/releases/tag/1.5) - 2018-05-22

### Added

 * Packages: add traceroute, localepurge (remove unused translations), manpages, manpages-dev, transmission-cli, poedit
 * Transmission: on download completion, copy the original .torrent file to the download directory (script in /usr/share/transmission/)
 * Add default configuration for liferea, xfce4-notes, update retext default config
 * Add 2 bash aliases: `sortclipboard` (sort the X clipboard), `alert <command>` (display a red/green block on command success/error)

### Changed

 * Replace xfce applications menu with whiskermenu plugins, update default configuration
 * Replace virtualbox with KVM/libvirt/virt-manager based setup (level 1 hypervisor, much better performance)
 * Replace gtk-recordmydesktop with vokoscreen screencast recorder
 * Firewall policies "Low" and "High" are available in GUFW
   * "Low" policy allows any output, and incoming samba/avahi connections from LAN 192.168.1.0/24
   * "High" policy only allows output on secure protocols + DNS, and blocks the rest
 * Update documentation
 * Force https downloads for APT where possible
 * Cleanup, reordering, improve build tools, Makefile, caching, automation, error handling and output

### Removed

 * Packages: Remove less-used packages to save disk space / ISO file size: 
   * All game console emulators except pcsxr and zsnes
   * 11 fonts, font-manager
   * Openshot video editor (use blender)
   * network-manager-iodine, wxhexeditor, tdfsb, sqlitebrowser, asciio
 * Remove 3rd party package download (webtorrent) (see branch `extras/webtorrent`)
 * Remove WIP thunderbird addons download/installation (see branch `extras/wip/thunderbird-addons`)
 * Remove gdebi, removes dependency on gksu (unmaintained)

### Fixed

 * Fixed qemu-utils package name
 * Fixed iso signing procedure
 * Fix boot menu submenus not working
 * Fix live-build hooks
 * Fix bootloader menu templates
 * Fix some bash aliases
 * Fix custom application launchers icons/categories

## [v1.4](https://github.com/nodiscc/dbu/releases/tag/1.4) - 2018-03-05

### Added

Build an ISO image using live-build:
 - build an iso-hybrid image suitable for removable drives and/or CD/DVD
 - add an option to permanenty install the live system to disk, using the graphical installer
 - build from Debian 9 Strech repositories (using main, contrib and non-free archive sections)
 - support the amd64 CPU architecture, enable support for i386 packages (multiarch)
 - enable Debian backports, security and updates repositories
 - disable installation of 'recommended' packages
 - include device firmwares in the ISO image and the live system
 - include memtest86+ in the ISO image
 - include an installer launcher for Windows computers in the ISO image
 - other build options: HTTPS apt transport, SHA256 checksums, no separate image for source packages, boot parameters, debconf options, logging, cleanup
 - pre-answer (preseed) some installer questions
 - rewrite the git history/changelog to get a readable log. An [archive of the old changelog](https://github.com/dbu/blob/master/doc/changelog-archive.md) is available.

Include ~600 packages by default:
 - desktop environment based on Xfce
 - office utilities, document reading and editing
 - web browsing, file transfer, download and synchronisation, messaging
 - audio/video playback, creation and editing tools
 - base hardware, display and audio systems, apparmor
 - file management, system, hardware and network configuration/diagnostic utilities
 - various graphical and command line utilities for common tasks
 - Virtualization/other platforms support (Virtualbox, WINE)
 - remove a few unwanted default Debian packages from the system, disable some services by default
 - add documentation for general usage, installation and default packages. See the [README](https:/github.com/nodiscc/dbu/blob/master/README.md).

Other changes to default Debian installation:
 - add a few .desktop launchers, better integration for the Send to... menu, default file associations, 
 - add default configuration for terminal, desktop, boot splash, syntax highlighting, conky, and many other utilities.
 - configure touchpad scrolling, file indexing, sudo behavior, sysctl, localization, power saving, package management, GRUB boot options, keyboard, UFW firewall
 - add a local caching DNS resolver (dnsmasq-base) for NetworkManager
 - enable AppArmor mandatory access control system
 - see the [commit log](https://github.com/nodiscc/dbu/commits) and git repository contents for more details.

<!--
### Added
### Changed
### Removed
### Fixed
### Security
### Deprecated
-->
