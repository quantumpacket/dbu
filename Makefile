#!/usr/bin/make -f

#############
## config - firefox/thunderbird addons location

# firefox 45+ (backports/testing) default addons for new profiles
addonsdir=config/includes.chroot/usr/share/firefox/distribution/extensions/
#addonsdir=config/includes.chroot/usr/share/firefox-esr/distribution/extensions/

# firefox/esr system-wide addons installation
#addonsdir="/usr/lib/firefox/browser/extensions/"

# deprecated, legacy iceweasel addons path
# addonsdir="config/includes.chroot/etc/iceweasel/profile/extensions/" 

#thunderbird/icedove addons path
tbaddonsdir="config/includes.chroot/etc/icedove/extensions/"

#############

all: buildenv clean update xpi documentation lbbuild

update: ffaddons tbaddons packageschroot purpleplugins themes dotfiles

buildenv:
	aptitude install live-build make build-essential wget git xmlstarlet unzip

clean:
	-rm $(tbaddonsdir)/*
	-rm $(addonsdir)/*
	-rm config/packages.chroot/*
	-rm -r config/includes.chroot/usr/lib/purple-2/*.so
	
#update firefox addons
ffaddons:
	# Security / privacy addons
	#https://addons.mozilla.org/en-US/firefox/addon/https-everywhere/
	wget -N --directory-prefix=$(addonsdir) https://addons.mozilla.org/firefox/downloads/latest/229918/addon-229918-latest.xpi
	#https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/
	wget -N --directory-prefix=$(addonsdir) https://addons.mozilla.org/firefox/downloads/latest/607454/addon-607454-latest.xpi
	#https://addons.mozilla.org/en-US/firefox/addon/canvasblocker/
	wget -N --directory-prefix=$(addonsdir) https://addons.mozilla.org/firefox/downloads/file/399286/canvasblocker-0.3.0-Release-fx.xpi
	#https://addons.mozilla.org/en-US/firefox/addon/clean-links/
	wget -N --directory-prefix=$(addonsdir) https://addons.mozilla.org/firefox/downloads/latest/317263/addon-317263-latest.xpi
	#https://addons.mozilla.org/en-US/firefox/addon/self-destructing-cookies/
	wget -N --directory-prefix=$(addonsdir) https://addons.mozilla.org/firefox/downloads/latest/415846/addon-415846-latest.xpi
	#https://addons.mozilla.org/en-US/firefox/addon/decentraleyes/
	wget -N --directory-prefix=$(addonsdir) https://addons.mozilla.org/firefox/downloads/latest/521554/addon-521554-latest.xpi
	#https://addons.mozilla.org/fr/firefox/addon/no-resource-uri-leak/
	wget -N --directory-prefix=$(addonsdir) https://addons.mozilla.org/firefox/downloads/latest/no-resource-uri-leak/addon-706000-latest.xpi
	#
	# UI-related / utility addons
	#https://addons.mozilla.org/en-US/firefox/addon/add-to-search-bar/
	wget -N --directory-prefix=$(addonsdir) https://addons.mozilla.org/firefox/downloads/latest/3682/addon-3682-latest.xpi
	#https://addons.mozilla.org/en-us/firefox/addon/yet-another-context-search/
	wget -N --directory-prefix=$(addonsdir) https://addons.mozilla.org/firefox/downloads/latest/392483/addon-392483-latest.xpi
	#
	# more addons (disabled):
	# https://addons.mozilla.org/en-US/firefox/addon/greasemonkey/
	# https://addons.mozilla.org/en-US/firefox/addon/scrapbook-x/
	# https://addons.mozilla.org/en-US/firefox/addon/scrapbook-copypageinfo/
	# https://addons.mozilla.org/en-US/firefox/addon/scrapbookx-autosave/
	# https://addons.mozilla.org/en-US/firefox/addon/scrapbookx-maf-creator/
	# https://addons.mozilla.org/en-US/firefox/addon/scrapbookx-converter/
	# https://addons.mozilla.org/en-US/firefox/addon/downthemall/
	#
	# https://addons.mozilla.org/en-US/firefox/addon/new-tab-bookmarks/
	# https://addons.mozilla.org/en-US/firefox/addon/password-exporter/
	# https://addons.mozilla.org/en-US/firefox/addon/watch-with-mpv/
	# https://addons.mozilla.org/en-US/firefox/addon/about-addons-memory/
	# https://addons.mozilla.org/en-us/firefox/addon/auto-refresh-for-twitter/
	# https://addons.mozilla.org/en-US/firefox/addon/bookmark-autohider/
	# https://addons.mozilla.org/en-US/firefox/addon/bookmark-deduplicator/
	# https://addons.mozilla.org/en-US/firefox/addon/bookrect/
	# https://addons.mozilla.org/en-US/firefox/addon/certificate-patrol/
	# https://addons.mozilla.org/en-US/firefox/addon/floatnotes/
	# https://addons.mozilla.org/en-US/firefox/addon/gnotifier/
	# https://addons.mozilla.org/en-us/firefox/addon/http-nowhere/
	# https://addons.mozilla.org/en-US/firefox/addon/lightbeam/
	# https://addons.mozilla.org/en-US/firefox/addon/link-visitor-3/
	# https://addons.mozilla.org/en-US/firefox/addon/markdown-viewer/
	# https://addons.mozilla.org/en-US/firefox/addon/mind-the-time/
	# https://addons.mozilla.org/en-US/firefox/addon/mozilla-archive-format/
	# https://addons.mozilla.org/en-US/firefox/addon/multifox/
	# https://addons.mozilla.org/en-US/firefox/addon/new-tab-tools/
	# https://addons.mozilla.org/en-US/firefox/addon/noscript/
	# https://addons.mozilla.org/en-US/firefox/addon/password-reuse-visualizer/
	# https://addons.mozilla.org/en-US/firefox/addon/perspectives/
	# https://addons.mozilla.org/en-US/firefox/addon/print-edit/
	# https://addons.mozilla.org/en-US/firefox/addon/random-agent-spoofer/
	# https://addons.mozilla.org/en-US/firefox/addon/reddit-enhancement-suite/
	# https://addons.mozilla.org/en-US/firefox/addon/requestpolicy-continued/
	# https://addons.mozilla.org/en-US/firefox/addon/simple-mail/
	# https://addons.mozilla.org/en-us/firefox/addon/ssleuth/
	# https://addons.mozilla.org/en-US/firefox/addon/tab-badge/
	# https://addons.mozilla.org/en-US/firefox/addon/tab-scope/
	# https://addons.mozilla.org/en-US/firefox/addon/tamper-data/
	# https://addons.mozilla.org/en-US/firefox/addon/terms-of-service-didnt-read/
	# https://addons.mozilla.org/en-US/firefox/addon/toggle-js/
	# https://addons.mozilla.org/en-US/firefox/addon/tree-style-tab/
	# https://addons.mozilla.org/en-US/firefox/addon/turn-off-the-lights/
	# https://addons.mozilla.org/en-US/firefox/addon/umatrix/
	# https://addons.mozilla.org/en-us/firefox/addon/unloadtab/
	# https://addons.mozilla.org/en-US/firefox/addon/update-scanner/
	# https://addons.mozilla.org/en-US/firefox/addon/user-agent-switcher/
	# https://addons.mozilla.org/en-US/firefox/addon/yesscript/
	# https://addons.mozilla.org/en-us/firefox/addon/copy-as-markdown/
	# https://addons.mozilla.org/en-US/firefox/addon/open-livestreamer/
	# https://addons.mozilla.org/en-US/firefox/addon/rss-icon-in-url-bar/


#rename xpis from their id
xpi:
	mv $(addonsdir)/addon-3682-latest.xpi $(addonsdir)/add-to-searchbox@maltekraus.de #workaround, script doesn't work on this addon
	@for xpi in $$(find $(addonsdir) -name '*.xpi'); do \
	extid=$$(./scripts/get-xul-extension-id.sh "$$xpi"); echo "$$xpi - $$extid"; \
	mv "$$xpi" $(addonsdir)/"$$extid".xpi ; \
	done
	mv $(addonsdir)/add-to-searchbox@maltekraus.de $(addonsdir)/add-to-searchbox@maltekraus.de.xpi #workaround, 2nd part

#update thunderbird addons TODO
tbaddons:
	#https://addons.mozilla.org/en-US/thunderbird/addon/gmail-conversation-view/
	wget -N --directory-prefix=$(tbaddonsdir) https://addons.mozilla.org/thunderbird/downloads/latest/54035/addon-54035-latest.xpi
	#https://addons.mozilla.org/fr/thunderbird/addon/importexporttools/
	wget -N --directory-prefix=$(tbaddonsdir) https://addons.mozilla.org/thunderbird/downloads/file/348080/addon-348080-latest.xpi
	#https://addons.mozilla.org/en-US/thunderbird/addon/lightning/
	wget -N --directory-prefix=$(tbaddonsdir) https://addons.mozilla.org/thunderbird/downloads/latest/2313/platform:2/addon-2313-latest.xpi
	#https://addons.mozilla.org/en-US/thunderbird/addon/quote-colors/
	wget -N --directory-prefix=$(tbaddonsdir) https://addons.mozilla.org/thunderbird/downloads/latest/170/addon-170-latest.xpi
	#https://addons.mozilla.org/en-US/thunderbird/addon/enigmail/
	wget -N --directory-prefix=$(tbaddonsdir) https://addons.mozilla.org/thunderbird/downloads/latest/71/addon-71-latest.xpi
	#http://sogo.nu/download.html#/frontends
	wget -N --directory-prefix=$(tbaddonsdir) http://www.sogo.nu/files/downloads/SOGo/Thunderbird/sogo-connector-31.0.3.xpi
	#https://addons.mozilla.org/fr/thunderbird/addon/categorymanager/
	wget -N --directory-prefix=$(tbaddonsdir) https://addons.mozilla.org/thunderbird/downloads/latest/472193/addon-472193-latest.xpi
	#https://addons.mozilla.org/en-US/thunderbird/addon/duplicate-contact-manager/
	wget -N --directory-prefix=$(tbaddonsdir)  https://addons.mozilla.org/thunderbird/downloads/latest/2505/addon-2505-latest.xpi
	#https://addons.mozilla.org/en-US/thunderbird/addon/contact-tabs/
	wget -N --directory-prefix=$(tbaddonsdir) https://addons.mozilla.org/thunderbird/downloads/latest/306600/addon-306600-latest.xpi
	#https://addons.mozilla.org/en-US/thunderbird/addon/send-later-3/
	wget -N --directory-prefix=$(tbaddonsdir) https://addons.mozilla.org/thunderbird/downloads/file/423919/addon-423919-latest.xpi
	#https://addons.mozilla.org/fr/thunderbird/addon/todotxt-extension/
	wget -N --directory-prefix=$(tbaddonsdir) https://addons.mozilla.org/thunderbird/downloads/latest/650068/platform:2/addon-650068-latest.xpi
	#
	# more addons:
	# https://addons.mozilla.org/en-US/thunderbird/addon/printingtools/
	# https://addons.mozilla.org/fr/firefox/addon/minimizetotray-revived/
	# https://addons.mozilla.org/fr/thunderbird/addon/gmailui/
	# https://addons.mozilla.org/fr/thunderbird/addon/contact-photos/
	# https://addons.mozilla.org/en-us/thunderbird/addon/webdav-for-filelink/


# download non-debian chroot packages
# needs to be updated manually when upstream versions change
# see https://github.com/nodiscc/scriptz for more software
packageschroot:
	-mkdir -pv config/packages.chroot
	
	# https://launchpad.net/light-locker-settings
	wget -N --directory-prefix=config/packages.chroot/ http://cz.archive.ubuntu.com/ubuntu/pool/universe/l/light-locker-settings/light-locker-settings_1.5.0-0ubuntu1.debian.tar.xz
	wget -N --directory-prefix=config/packages.chroot/ http://cz.archive.ubuntu.com/ubuntu/pool/universe/l/light-locker-settings/light-locker-settings_1.5.0-0ubuntu1.dsc
	wget -N --directory-prefix=config/packages.chroot/ http://cz.archive.ubuntu.com/ubuntu/pool/universe/l/light-locker-settings/light-locker-settings_1.5.0-0ubuntu1_all.deb
	wget -N --directory-prefix=config/packages.chroot/ http://cz.archive.ubuntu.com/ubuntu/pool/universe/l/light-locker-settings/light-locker-settings_1.5.0.orig.tar.bz2
	
	# https://github.com/dequis/purple-facebook/wiki
	wget -N --directory-prefix=config/packages.chroot/ http://download.opensuse.org/repositories/home:/jgeboski/Debian_8.0/i386/purple-facebook_20161121~a157645~c9b74a765767~117_i386.deb
	wget -N --directory-prefix=config/packages.chroot/ http://download.opensuse.org/repositories/home:/jgeboski/Debian_8.0/amd64/purple-facebook_20161121~a157645~c9b74a765767~117_amd64.deb
	wget -N --directory-prefix=config/packages.chroot/ http://download.opensuse.org/repositories/home:/jgeboski/Debian_8.0/purple-facebook_20161121~a157645~c9b74a765767~117.tar.gz
	wget -N --directory-prefix=config/packages.chroot/ http://download.opensuse.org/repositories/home:/jgeboski/Debian_8.0/purple-facebook_20161121~a157645~c9b74a765767~117.dsc
	
	# https://github.com/MrS0m30n3/youtube-dl-gui/releases
	wget -N --directory-prefix=config/packages.chroot/ http://ppa.launchpad.net/nilarimogard/webupd8/ubuntu/pool/main/y/youtube-dlg/youtube-dlg_0.3.8-1~webupd8~xenial3.debian.tar.xz
	wget -N --directory-prefix=config/packages.chroot/ http://ppa.launchpad.net/nilarimogard/webupd8/ubuntu/pool/main/y/youtube-dlg/youtube-dlg_0.3.8-1~webupd8~xenial3.dsc
	wget -N --directory-prefix=config/packages.chroot/ http://ppa.launchpad.net/nilarimogard/webupd8/ubuntu/pool/main/y/youtube-dlg/youtube-dlg_0.3.8-1~webupd8~xenial3_all.deb
	wget -N --directory-prefix=config/packages.chroot/ http://ppa.launchpad.net/nilarimogard/webupd8/ubuntu/pool/main/y/youtube-dlg/youtube-dlg_0.3.8.orig.tar.gz
	
	# https://github.com/nicklan/pnmixer (jessie only, on wheezy use xfce4-pulseaudio-plugin)
	wget -N --directory-prefix=config/packages.chroot/ http://ftp.fr.debian.org/debian/pool/main/p/pnmixer/pnmixer_0.6.1-1.debian.tar.xz
	wget -N --directory-prefix=config/packages.chroot/ http://ftp.fr.debian.org/debian/pool/main/p/pnmixer/pnmixer_0.6.1-1_amd64.deb
	wget -N --directory-prefix=config/packages.chroot/ http://ftp.fr.debian.org/debian/pool/main/p/pnmixer/pnmixer_0.6.1-1_i386.deb
	wget -N --directory-prefix=config/packages.chroot/ http://ftp.fr.debian.org/debian/pool/main/p/pnmixer/pnmixer_0.6.1-1.dsc
	wget -N --directory-prefix=config/packages.chroot/ http://ftp.fr.debian.org/debian/pool/main/p/pnmixer/pnmixer_0.6.1.orig.tar.gz
	
	# https://github.com/feross/webtorrent-desktop/
	#ignore errors because host prevents getting content-length and cause subsequent downloads to fail.
	-wget -N --directory-prefix=config/packages.chroot/ https://github.com/feross/webtorrent-desktop/releases/download/v0.17.0/webtorrent-desktop_0.17.0-1_amd64.deb
	-wget -N --directory-prefix=config/packages.chroot/ https://github.com/feross/webtorrent-desktop/releases/download/v0.17.0/webtorrent-desktop_0.17.0-1_i386.deb

	### THEMES ###
	# https://numixproject.org/
	wget -N --directory-prefix=config/packages.chroot/ http://ppa.launchpad.net/numix/ppa/ubuntu/pool/main/n/numix-gtk-theme/numix-gtk-theme_2.6.6+626~201611150117~ubuntu16.10.1.dsc
	wget -N --directory-prefix=config/packages.chroot/ http://ppa.launchpad.net/numix/ppa/ubuntu/pool/main/n/numix-gtk-theme/numix-gtk-theme_2.6.6+626~201611150117~ubuntu16.10.1.tar.xz
	wget -N --directory-prefix=config/packages.chroot/ http://ppa.launchpad.net/numix/ppa/ubuntu/pool/main/n/numix-gtk-theme/numix-gtk-theme_2.6.6+626~201611150117~ubuntu16.10.1_all.deb
	wget -N --directory-prefix=config/packages.chroot/ http://ppa.launchpad.net/numix/ppa/ubuntu/pool/main/n/numix-icon-theme-bevel/numix-icon-theme-bevel_1.0+201410212340~8~ubuntu14.10.1.dsc
	wget -N --directory-prefix=config/packages.chroot/ http://ppa.launchpad.net/numix/ppa/ubuntu/pool/main/n/numix-icon-theme-bevel/numix-icon-theme-bevel_1.0+201410212340~8~ubuntu14.10.1.tar.xz
	wget -N --directory-prefix=config/packages.chroot/ http://ppa.launchpad.net/numix/ppa/ubuntu/pool/main/n/numix-icon-theme-bevel/numix-icon-theme-bevel_1.0+201410212340~8~ubuntu14.10.1_all.deb
	wget -N --directory-prefix=config/packages.chroot/ http://ppa.launchpad.net/numix/ppa/ubuntu/pool/main/n/numix-icon-theme-circle/numix-icon-theme-circle_2.0.3+13~201611240401~ubuntu17.04.1.dsc
	wget -N --directory-prefix=config/packages.chroot/ http://ppa.launchpad.net/numix/ppa/ubuntu/pool/main/n/numix-icon-theme-circle/numix-icon-theme-circle_2.0.3+13~201611240401~ubuntu17.04.1.tar.xz
	wget -N --directory-prefix=config/packages.chroot/ http://ppa.launchpad.net/numix/ppa/ubuntu/pool/main/n/numix-icon-theme-circle/numix-icon-theme-circle_2.0.3+13~201611240401~ubuntu17.04.1_all.deb
	wget -N --directory-prefix=config/packages.chroot/ http://ppa.launchpad.net/numix/ppa/ubuntu/pool/main/n/numix-icon-theme/numix-icon-theme_0.3+875~201701252032~ubuntu17.04.1.dsc
	wget -N --directory-prefix=config/packages.chroot/ http://ppa.launchpad.net/numix/ppa/ubuntu/pool/main/n/numix-icon-theme/numix-icon-theme_0.3+875~201701252032~ubuntu17.04.1.tar.xz
	wget -N --directory-prefix=config/packages.chroot/ http://ppa.launchpad.net/numix/ppa/ubuntu/pool/main/n/numix-icon-theme/numix-icon-theme_0.3+875~201701252032~ubuntu17.04.1_all.deb
	
	# https://github.com/snwh/paper-gtk-theme
	wget -N --directory-prefix=config/packages.chroot/ http://ppa.launchpad.net/snwh/pulp/ubuntu/pool/main/p/paper-gtk-theme/paper-gtk-theme_2.1+r265~daily~ubuntu16.04.1.dsc
	wget -N --directory-prefix=config/packages.chroot/ http://ppa.launchpad.net/snwh/pulp/ubuntu/pool/main/p/paper-gtk-theme/paper-gtk-theme_2.1+r265~daily~ubuntu16.04.1.tar.gz
	wget -N --directory-prefix=config/packages.chroot/ http://ppa.launchpad.net/snwh/pulp/ubuntu/pool/main/p/paper-gtk-theme/paper-gtk-theme_2.1+r265~daily~ubuntu16.04.1_all.deb
	
	# https://github.com/snwh/paper-cursor-theme
	# https://github.com/snwh/paper-icon-theme
	wget -N --directory-prefix=config/packages.chroot/ http://ppa.launchpad.net/snwh/pulp/ubuntu/pool/main/p/paper-icon-theme/paper-cursor-theme_1.3+r672~daily~ubuntu15.10.1_all.deb
	wget -N --directory-prefix=config/packages.chroot/ http://ppa.launchpad.net/snwh/pulp/ubuntu/pool/main/p/paper-icon-theme/paper-icon-theme_1.3+r672~daily~ubuntu15.10.1.dsc
	wget -N --directory-prefix=config/packages.chroot/ http://ppa.launchpad.net/snwh/pulp/ubuntu/pool/main/p/paper-icon-theme/paper-icon-theme_1.3+r672~daily~ubuntu15.10.1.tar.xz
	wget -N --directory-prefix=config/packages.chroot/ http://ppa.launchpad.net/snwh/pulp/ubuntu/pool/main/p/paper-icon-theme/paper-icon-theme_1.3+r672~daily~ubuntu15.10.1_all.deb
	
	# https://github.com/horst3180/Arc-theme
	# variants, conflict with each other
	wget -N --directory-prefix=config/packages.chroot/ http://download.opensuse.org/repositories/home:/Horst3180/Debian_8.0/all/arc-theme_1488477732.766ae1a-0_all.deb
	#wget -N --directory-prefix=config/packages.chroot/ http://download.opensuse.org/repositories/home:/Horst3180/Debian_8.0/all/arc-theme-solid_1488477732.766ae1a-0_all.deb
	
	# https://github.com/horst3180/Ceti-2-theme
	wget -N --directory-prefix=config/packages.chroot/ http://download.opensuse.org/repositories/home:/Horst3180/Debian_8.0/all/ceti-2-theme_1442961272.9fe3d9f_all.deb
	
	# https://github.com/horst3180/Vertex-theme
	wget -N --directory-prefix=config/packages.chroot/ http://download.opensuse.org/repositories/home:/Horst3180/Debian_8.0/all/vertex-theme_1459280359.d828032_all.deb

# download pidgin plugins
purpleplugins:
	mkdir -pv config/includes.chroot/usr/lib/purple-2/
	wget -N --directory-prefix=config/includes.chroot/usr/lib/purple-2/ \
		https://github.com/EionRobb/pidgin-opensteamworks/releases/download/1.6.1/libsteam64-1.6.1.so \
		https://github.com/EionRobb/pidgin-opensteamworks/releases/download/1.6.1/libsteam-1.6.1.so

# download gtk/wm themes
themes:
	-rm -rf config/includes.chroot/usr/share/themes/
	mkdir -pv config/includes.chroot/usr/share/themes/
	git clone --depth=1 https://github.com/shimmerproject/Albatross config/includes.chroot/usr/share/themes/Albatross
	git clone --depth=1 https://github.com/shimmerproject/Blackbird config/includes.chroot/usr/share/themes/Blackbird
	git clone --depth=1 https://github.com/shimmerproject/Bluebird config/includes.chroot/usr/share/themes/Bluebird
	git clone --depth=1 https://github.com/shimmerproject/Greybird config/includes.chroot/usr/share/themes/Greybird
	git clone --depth=1 https://github.com/shimmerproject/Numix config/includes.chroot/usr/share/themes/Numix
	git clone --depth=1 https://github.com/shimmerproject/Orion config/includes.chroot/usr/share/themes/Orion
	git clone --depth=1 https://github.com/satya164/Evolve config/includes.chroot/usr/share/themes/Evolve
	git clone --depth=1 https://github.com/xyl0n/iris config/includes.chroot/usr/share/themes/iris
	git clone --depth=1 https://github.com/xyl0n/iris-light config/includes.chroot/usr/share/themes/iris-light
	git clone --depth=1 https://github.com/BunsenLabs/deb8-theme config/includes.chroot/usr/share/themes/deb8

	git clone --depth=1 https://github.com/lassekongo83/zuki-themes tmp-zuki-themes
	mv tmp-zuki-themes/Zukitre tmp-zuki-themes/Zukitwo config/includes.chroot/usr/share/themes/
	rm -rf tmp-zuki-themes

# download misc configuration files
dotfiles:
	-rm -rf config/includes.chroot/etc/skel/.nano config/includes.chroot/etc/skel/.conky config/includes.chroot/usr/share/fonts/
	-mkdir -pv config/includes.chroot/etc/skel/ config/includes.chroot/etc/firefox/
	git clone --depth=1 https://github.com/serialhex/nano-highlight config/includes.chroot/etc/skel/.nano
	git clone --depth=1 --recursive https://github.com/nodiscc/conkyselect config/includes.chroot/etc/skel/.conky 
	git clone --depth=1 https://github.com/nodiscc/fonts config/includes.chroot/usr/share/fonts/
	git clone --depth=1 https://github.com/nodiscc/ohmpage config/includes.chroot/usr/share/ohmpage
	
	git clone --depth=1 https://github.com/az0/cleanerml/ tmp-cleanerml
	-rm -rf config/includes.chroot/usr/share/bleachbit/
	mkdir -p config/includes.chroot/usr/share/bleachbit/
	mv tmp-cleanerml/release config/includes.chroot/usr/share/bleachbit/cleaners
	rm -rf tmp-cleanerml

	git clone -b dbu --depth=1 https://github.com/nodiscc/user.js tmp-userjs
	-rm -rf config/includes.chroot/etc/firefox/
	mkdir -p config/includes.chroot/etc/firefox/
	mv tmp-userjs/firefox.js config/includes.chroot/etc/firefox/firefox.js
	rm -rf tmp-userjs

documentation:
	-rm -r doc/packages/*.md
	./scripts/doc-generator.sh
	-rm doc/packages/00-*

lbbuild:
	sudo lb clean --all
	#sudo lb clean --purge #only necessary when changing the mirrors/architecture config
	sudo lb config
	sudo lb build


#TODO https://greasyfork.org/en/scripts/1190-flickr-original-link?
#TODO https://greasyfork.org/en/scripts/494-youtube-auto-buffer-auto-hd?
#TODO https://openuserjs.org/scripts/elundmark/Torrentz_All-in-One?
