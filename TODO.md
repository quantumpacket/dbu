## dbu - TODO

 * [enh] do not require passwords for package upgrades (see `org.freedesktop.packagekit.system-update` policykit policy)
 * [enh] Enable IPv6 support (sysctl, firewall, apt config...)
 * [enh] installer: preseed "domain name" installer question to None, preseed "full user name" question to match the unix username
 * [enh] thunderbird: add default addons
 * [enh] [tools] add master switch in makefile to build without non-debian program dependencies
 * [enh] [tools] improve caching of dependencies (makefile)
 * [enh] [tools] keyboard-configuration interrupts unattended build (see `debconf-get-selections  | grep keybo | grep d-i`)
 * [enh] firefox: disaply the personal toolboar by default (requires including custom `xulstore.json` in profile defaults
 * [enh] [doc] find packages without descriptions in documentation: `cd doc/packages/ && egrep "^ \* .* $$" *.md`


### Upstream

 * [bug] [upstream] xfce4-notes does not remember window position https://bugzilla.xfce.org/show_bug.cgi?id=11158

### Unpackaged

 * [ceti-2-theme](https://github.com/horst3180/Ceti-2-theme) [RFP](http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=862402) [PPA](http://download.opensuse.org/repositories/home:/Horst3180/Debian_8.0/all/)
 * [go-for-it](https://github.com/mank319/Go-For-It)
 * [grammalecte](https://www.dicollecte.org/grammalecte/telecharger.php) [RFP](http://bugs.debian.org/860579)
 * [light-locker-settings](https://launchpad.net/light-locker-settings) [PPA](http://archive.ubuntu.com/ubuntu/pool/universe/l/light-locker-settings/)
 * [paper-cursor-theme](https://github.com/snwh/paper-cursor-theme) [PPA](http://ppa.launchpad.net/snwh/pulp/ubuntu/pool/main/p/)
 * [paper-gtk-theme](https://github.com/snwh/paper-gtk-theme) [RFP](http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=862403) [PPA](http://ppa.launchpad.net/snwh/pulp/ubuntu/pool/main/p/)
 * [paperwork](https://github.com/openpaperwork/paperwork/) [Issue](https://github.com/openpaperwork/paperwork/issues/466) [RFP](https://bugs.debian.org/721287)
 * [purple-facebook](https://github.com/dequis/purple-facebook/wiki) [PPA](http://download.opensuse.org/repositories/home:/jgeboski/Debian_9.0/amd64/)
 * [qwinff](https://qwinff.github.io/) [Issue](https://github.com/qwinff/qwinff/issues/18) [PPA](http://ppa.launchpad.net/lzh9102/qwinff/ubuntu/pool/main/q/)
 * [vertex-theme](https://github.com/horst3180/Vertex-theme) [PPA](http://download.opensuse.org/repositories/home:/Horst3180/Debian_8.0/all/)
 * [youtube-dl-gui](https://github.com/MrS0m30n3/youtube-dl-gui/releases)


RFP QownNotes



### Backlog

 * [backlog] use plymouth during live boot
 * [backlog] add a package list for audio workstations (see `desktop-audio-editor-audacity.list.chroot`, https://github.com/nodiscc/awesome-linuxaudio), linux-image-rt-amd64?, branch `feature/audio-workstation`; set CPU governor to 'performance', install jackd, gladish? laditools?, download/install https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos_9.4.1~kxstudio1_all.deb, install libglibmm-2.4-1v5, download/install https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos-gcc5_9.4.1~kxstudio1_all.deb, setup rtprio=95 memlock=unlimited nice=-19 for '@audio' group in `/etc/limits/audio.conf`, add the main user to group audio, run https://github.com/raboof/realtimeconfigquickscan, disable CPU throttling in laptop-mode-cools config, configure rtirq? https://bitbucket.org/thismaechler/ubuntustudio-14.04-realtimeaudio/src/master/cfg/rtirq http://subversion.ffado.org/wiki/IrqPriorities http://alsa.opensrc.org/Rtirq, install rt-preempt kernel? config/optimize jack http://wiki.linuxaudio.org/wiki/list_of_jack_frame_period_settings_ideal_for_usb_interface http://wiki.linuxaudio.org/wiki/optimize_jack, tweak PCI latencies? https://www.mythtv.org/wiki/PCI_Latency, switch CPU scheduler to BFS? https://en.wikipedia.org/wiki/Brain_Fuck_Scheduler, customize CPU affinity? https://www.cyberciti.biz/tips/setting-processor-affinity-certain-task-or-process.html, autostart ladi-system-tray ? https://bitbucket.org/thismaechler/ubuntustudio-14.04-realtimeaudio http://kxstudio.linuxaudio.org/Repositories; download soundfonts from http://freepats.zenvoid.org/
 * [backlog] disable non-free repositories, fetch firmware with wget/makefile target before build (branch no-nonfree)
 * [backlog] add persistence http://live.debian.net/manual/stable/html/live-manual/customizing-run-time-behaviours#persistence
 * [backlog] Display more items in xfce4-settings-manager: `blueman-manager.desktop dbu-software-properties-gtk.desktop exo-preferred-applications.desktop gparted.desktop light-locker-settings.desktop menulibre.desktop network.desktop nm-connection-editor.desktop org.gnome.DiskUtility.desktop org.gnome.Packages.desktop org.gnome.FontManager.desktop org.gnome.PackageUpdater.desktop org.gnome.Software.desktop panel-preferences.desktop paprefs.desktop qtconfig-qt4.desktop seahorse.desktop services.desktop shares.desktop software-properties-drivers.desktop software-properties-gnome.desktop software-properties-gtk.desktop steam.desktop backintime-qt4.desktop backintime-qt4-root.desktop synaptic.desktop system-config-printer.desktop time.desktop users.desktop pavucontrol.desktop`
 * [backlog] [doc] add icons to main package list/sublists (parse .list; find #Icon: field, or use first package name , copy/embed /usr/share/icons/$theme/$size/apps/$icon.png)
 * [backlog] [tools] Makefile: automate torrent creation: transmission-create dbu-0.9n-debian-stretch-amd64.hybrid.iso -o dbu-0.9n-debian-stretch-amd64.hybrid.iso.torrent -t  udp://tracker.opentrackr.org:1337 -t  udp://tracker.coppersurfer.tk:6969   -t udp://tracker.leechers-paradise.org:6969 -t  udp://zer0day.ch:1337 -t  udp://explodie.org:6969
 * [backlog] Improve apparmor sandboxing (run `aa-unconfined --paranoid` to see unconfined processes). enable more apparmor profiles by default, create new profiles `aa-unconfined --paranoid -> find profiles -> set to complain -> aa-notify -> set to enforce -> (ps auxZ) -> dbu`
 * [backlog] [tools] add travis config for tests/automated builds, add KVM/QEMU settings to run resulting ISO in KVM/QEMU
 * [backlog] voice recognition/control/dictation (pocketsphinx?)