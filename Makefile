#!/usr/bin/make -f

all: install_buildenv tests clean update_deps install_firefox_addons build

update_deps: download_firefox_addons download_binaries download_dotfiles

release: documentation tests checksums sign_checksums

tests: test_shellcheck test_doc_emptylinks

#########################################

install_buildenv:
	# Install packages required to build the image
	sudo apt install live-build make build-essential wget git xmlstarlet unzip colordiff shellcheck apt-transport-https

test_shellcheck:
	#Check scripts syntax
	shellcheck --exclude=SC2016,SC2086,SC1001 scripts/*.sh

test_doc_emptylinks:
	#Empty links in documentation:
	@cd doc/packages/ && grep -r '()' && echo "WARNING invalid markdown links found"

test_kvm:
	# Run the resulting image in KVM/virt-manager
	# virt-manager must be installed, a VM using the correct ISO file must be configured
	virt-manager --connect qemu:///system --show-domain-console dbu-test

documentation:
	# Generate package documentation pages and index
	./scripts/doc-generator.sh

clean:
	git clean -df config/includes.chroot/

build:
	# Build the live system/ISO image
	#sudo lb clean --purge #only required when changing the mirrors/architecture config
	sudo lb clean --all
	sudo lb config
	sudo lb build

#########################################

checksums:
	# Generate checksums of the resulting ISO image
	@if [ ! -d iso/ ]; then mkdir -p iso/; fi
	mv *.iso iso/
	last_tag=$$(git tag | tail -n1); \
	cd iso/; \
	rename "s/live-image/dbu-$$last_tag-debian-stretch/" *; \
	sha512sum *.iso  > SHA512SUMS; \

sign_checksums:
	# SIgn checksums with a GPG private key
	cd iso; \
	gpg --detach-sign --armor SHA512SUMS; \
	mv SHA512SUMS.asc SHA512SUMS.sign

#########################################
# Functions

# A function to git clone/pull a repository in a target directory
# Usage: $(call git_download,http://url,path/to/target)
define git_download
	@if [ ! -d $(2) ]; then \
	git clone --depth=1 $(1) $(2); \
	else cd $(2) && git pull && cd ..; fi
endef

#########################################
# Download Firefox addons
download_firefox_addons:
	@if [ ! -d cache/downloads/firefox_addons/ ]; then mkdir -p cache/downloads/firefox_addons/; fi
	#https://addons.mozilla.org/en-US/firefox/addon/https-everywhere/ [e10s] [security] [installed]
	wget -N -nv --show-progress -P cache/downloads/firefox_addons/ https://addons.mozilla.org/firefox/downloads/latest/229918/addon-229918-latest.xpi
	#https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/ [e10s] [security] [installed]
	wget -N -nv --show-progress -P cache/downloads/firefox_addons/ https://addons.mozilla.org/firefox/downloads/latest/607454/addon-607454-latest.xpi
	#https://addons.mozilla.org/en-US/firefox/addon/canvasblocker/ [e10s] [security] [installed]
	wget -N -nv --show-progress -P cache/downloads/firefox_addons/ https://addons.mozilla.org/firefox/downloads/file/399286/canvasblocker-0.3.0-Release-fx.xpi
	#https://addons.mozilla.org/en-US/firefox/addon/decentraleyes/ [e10s] [security] [FF52ESR]
	wget -N -nv --show-progress -P cache/downloads/firefox_addons/ https://addons.mozilla.org/firefox/downloads/file/710414/decentraleyes-1.3.10-an+fx+sm.xpi
	#https://addons.mozilla.org/en-US/firefox/addon/no-resource-uri-leak/ [security] [installed]
	wget -N -nv --show-progress -P cache/downloads/firefox_addons/ https://addons.mozilla.org/firefox/downloads/latest/no-resource-uri-leak/addon-706000-latest.xpi
	#https://addons.mozilla.org/en-US/firefox/addon/cookie-autodelete/ [security] [FF52ESR] [installed]
	wget -N -nv --show-progress -P cache/downloads/firefox_addons/ https://addons.mozilla.org/firefox/downloads/file/717459/cookie_autodelete-1.4.4-an+fx.xpi

# Rename downloaded XPIs from their ID, install them to distribution directory
# Addons installation path (Firefox ESR)
firefox_addons_dir=config/includes.chroot/usr/share/firefox-esr/distribution/extensions/
# Addons installation path (release/nightly)
#firefox_addons_dir=config/includes.chroot/usr/share/firefox/distribution/extensions/
install_firefox_addons:
	@-rm $(firefox_addons_dir)/*.xpi
	@if [ ! -d $(firefox_addons_dir) ]; then mkdir -p $(firefox_addons_dir); fi
	@for xpi in $$(find cache/downloads/firefox_addons/ -name '*.xpi'); do \
		extid=$$(./scripts/get-xul-extension-id.sh "$$xpi"); \
		echo "$$xpi - $$extid"; \
		cp "$$xpi" $(firefox_addons_dir)/"$$extid".xpi ; \
	done

##################################################################

download_binaries:
	# Download prebuilt binaries for unpackaged software
	@if [ ! -d cache/downloads/ ]; then mkdir -p cache/downloads/; fi
	# https://github.com/EionRobb/pidgin-opensteamworks/
	wget -N -nv --show-progress -P cache/downloads/ https://github.com/EionRobb/pidgin-opensteamworks/releases/download/1.6.1/libsteam64-1.6.1.so

install_binaries:
	# Install unpackaged binaries to the live config tree
	@if [ ! -d config/includes.chroot/usr/lib/purple-2/ ]; then mkdir -p config/includes.chroot/usr/lib/purple-2/; fi
	cp cache/downloads/libsteam64-1.6.1.so config/includes.chroot/usr/lib/purple-2/

##################################################################

# Download dotfiles/themes/...
DOTFILES_CACHE_DIR := "cache/downloads/dotfiles"
download_dotfiles:
	if [ ! -d $(DOTFILES_CACHE_DIR) ]; then mkdir -p $(DOTFILES_CACHE_DIR); fi

	# https://github.com/serialhex/nano-highlight
	$(call git_download,https://github.com/serialhex/nano-highlight,$(DOTFILES_CACHE_DIR)/nano-highlight)
	if [ -d config/includes.chroot/etc/skel/.nano ] ; then rm -rf config/includes.chroot/etc/skel/.nano; fi
	cp -r $(DOTFILES_CACHE_DIR)/nano-highlight config/includes.chroot/etc/skel/.nano
	rm -rf config/includes.chroot/etc/skel/.nano/.git
	
	# https://github.com/nodiscc/fonts
	$(call git_download,https://github.com/nodiscc/fonts,$(DOTFILES_CACHE_DIR)/fonts)
	if [ -d config/includes.chroot/usr/share/fonts ] ; then rm -rf config/includes.chroot/usr/share/fonts; fi
	cp -r $(DOTFILES_CACHE_DIR)/fonts config/includes.chroot/usr/share/fonts
	rm -rf config/includes.chroot/usr/share/fonts/.git

	# https://github.com/az0/cleanerml
	$(call git_download,https://github.com/az0/cleanerml,$(DOTFILES_CACHE_DIR)/cleanerml)
	if [ -d config/includes.chroot/usr/share/bleachbit/cleaners ] ; then rm -rf config/includes.chroot/usr/share/bleachbit/cleaners; fi
	-mkdir -p config/includes.chroot/usr/share/bleachbit/
	cp -r $(DOTFILES_CACHE_DIR)/cleanerml/release config/includes.chroot/usr/share/bleachbit/cleanerml

	# https://github.com/nodiscc/user.js
	$(call git_download,https://github.com/nodiscc/user.js,$(DOTFILES_CACHE_DIR)/user.js)
	-mkdir -p config/includes.chroot/etc/firefox-esr/
	-mkdir -p config/includes.chroot/usr/lib/firefox-esr/defaults/pref/
	-rm $(DOTFILES_CACHE_DIR)/user.js/systemwide_user.js
	cd $(DOTFILES_CACHE_DIR)/user.js && make systemwide_user.js
	cp $(DOTFILES_CACHE_DIR)/user.js/systemwide_user.js config/includes.chroot/etc/firefox-esr/firefox-esr.js
	cp $(DOTFILES_CACHE_DIR)/user.js/autoconfig.js config/includes.chroot/usr/lib/firefox-esr/defaults/pref/autoconfig.js
	cp $(DOTFILES_CACHE_DIR)/user.js/mozilla.cfg config/includes.chroot/usr/lib/firefox-esr/mozilla.cfg

    # icon themes
	-mkdir -pv config/includes.chroot/usr/share/icons/	
	# https://github.com/snwh/paper-icon-theme
	$(call git_download,https://github.com/snwh/paper-icon-theme,$(DOTFILES_CACHE_DIR)/paper-icon-theme)
	-mkdir -p config/includes.chroot/usr/share/icons/
	cp -r $(DOTFILES_CACHE_DIR)/paper-icon-theme/Paper $(DOTFILES_CACHE_DIR)/paper-icon-theme/Paper-Mono-Dark config/includes.chroot/usr/share/icons/

	@# Example: add extra files to the live file system
	@# git clone --recursive https://github.com/nodiscc/toolbox config/includes.chroot/usr/share/dbu/toolbox
	@# git clone https://github.com/nodiscc/dbu config/includes.chroot/usr/share/dbu/src
	@# git clone https://github.com/nodiscc/ohmpage config/includes.chroot/usr/share/ohmpage

	@# Example: include files in the root directory of the live ISO
	@# mkdir -pv config/includes.binary/extra/
	@# cp /path/to/intro.html config/includes.binary/intro.html

	@# For examples of how to download/include custom packages, dotfiles, themes, libraries,
	@# check git branches extras/gtk-themes, extras/pidgin-opensteamworks, extras/webtorrent...

