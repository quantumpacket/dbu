### Customize/Build your own

**Building with the default configuration**

 * Install Debian.
 * You must build from the same distribution as the target distribution (build *stable* systems on a build machine running Debian *stable*, *testing* systems on a machine running Debian *testing*...)
 * [`live-build`](https://www.debian.org/devel/debian-live/) is used to build the live system/installer/ISO image.
 * Run `apt install make git sudo live-build`
 * Run `git clone https://github.com/nodiscc/dbu`
 * To run the build process with the default configuration, run `make all`.

The full live-build documentation can be found at `/usr/share/doc/live-manual/pdf/live-manual.portrait.en.a4.pdf.gz` or https://debian-live.alioth.debian.org/live-manual/unstable/manual/html/live-manual.en.html

**Building with a custom configuration**

#### Build configuration


```
.
├── auto                        #main live-build configuration
├── config
│   ├── archives                #package mirrors/repositories
│   ├── hooks                   #extra scripts to run during build
│   ├── includes.binary         #files to include on the ISO filesystem
│   ├── includes.chroot         #files to include in the live system's filesystem
│   ├── includes.installer      #files to include in the installer's filesystem
│   ├── package-lists
│   │   └── *.list.chroot		#packages to install on the live system
│   │   └── *.list.binary		#packages to place in the APT repository on the ISO image
│   ├── packages.chroot         #standalone .deb packages to install on the live system
│   └── task-lists              #tasksel tasks to install on the live system
├── doc			#user documentation
├── Makefile	#main automation, dependencies management, ...
└── scripts		#extra automation scripts

```

* [Live Systems manual](https://debian-live.alioth.debian.org/live-manual/stable/manual/html/live-manual.en.html)
* [`man lb config`](https://manpages.debian.org/cgi-bin/man.cgi?query=lb_config&sektion=1&apropos=0&manpath=Debian+8+jessie&locale=)
* [`man lb build`](https://manpages.debian.org/cgi-bin/man.cgi?query=lb_build&sektion=1&apropos=0&manpath=Debian+8+jessie&locale=)
* [`man lb clean`](https://manpages.debian.org/cgi-bin/man.cgi?query=lb_clean&sektion=1&apropos=0&manpath=Debian+8+jessie&locale=)

#### Makefile

[`Makefile`](../Makefile) automates most of the build steps. In the default configuration it is 
used to update and build dependencies not packaged for Debian, run basic tests, automate ISO 
image build, checksums and signing, documentation generation...

Type `make <TAB><TAB>` to see available make targets.

See branches named `extra/...` for examples of how to include downloaded 3 party software, packages,
libraries, configuration files... (https://github.com/nodiscc/dbu/branches)

Caution: running `make all` or `make clean` will erase any files not tracked by git in `config/includes/chroot/`

##### config/includes.chroot/

Files and directories placed here will be copied to the live system. This is useful if 
you need to include modified configuration or data files (`etc/, opt/, usr/, ...`).

Scripts and data that do not belong to an existing Debian package should preferably be 
distributed as a custom package. Debian packages can also handle custom configuration 
files (see `dpkg-divert`).

##### config/package-lists/

 * `*.chroot`: lists of packages to install on the resulting image/system (live or installed)
 * `*.binary`: lists of additional packages to add to the ISO image `pool/` directory (to use as an offline repository/mirror) (not required for the live system to work)

If you want some packages to be installed to the live system AND placed in the `pool/`
ISO image directory, just use the `.list` extension.

Lines commented out with `#` will be ignored, except a few keywords (`#if...`), or used 
for documentation generation (see below).

**Adding/removing packages:** Look at the commented out packages in 
`config/package-lists/*.list.chroot` and uncomment packages you want to include, 
comment out packages you don't need, or write your own lists to that directory.

##### config/packages.chroot

Place any custom .deb package here to install it on the live system. 
This is useful if a package 1. is not available in Debian (see requests for
packaging  at http://wnpp.debian.net/) and 2. you don't want to add a third-party
repository to your APT sources list (security/stability reasons).

Keep in mind that packages placed here will _not_ receive upgrades through APT,
unless someone packages it and uploads it under the same name to Debian archives.

Currently all custom packages are downloaded from the Makefile.
Putting binary .deb packages under git version control should be avoided.
 
##### config/includes.installer

`preseed.cfg`: used to preconfigure the _installer_ using [preseeding](https://www.debian.org/releases/stable/i386/apb.html).

##### config/preseed

`*.chroot.cfg`: used to preseed debconf values for the resulting live system.


### Documentation generator

Include one of the following fields in your package list to configure automatic
generation of package documentation pages in [doc/packages](packages/), [doc/packages.md](packages.md):

 * `#Name`: Name for the package list (eg. Libreoffice office suite)
 * `#Screenshot`: package name to link to on screenshots.debian.net
 * `#Cat`: Category for the package list (eg Office)
 * `#Desc`: Package name to use for the description. If this is omitted, the description for first package in the list is used.
 * `#Alt`: name of an alternative package, or other package related to this list
 * `#Res`: URL to a resource/help link to add on the package doc page (using the target webpage title)
 * `#NoDescription`: putting this line in any package list will remove the long/short description from the resulting markdown file
 * `#ChrootPkg`: When this points to a package, package information will be fetched from the corresponding .deb in config/packages.chroot/ instead of the APT database
 * `#Replace`: When this field is present at least once, replace the package list description with its value (can be used more than once for multiline descriptions)

`doc/packages/*, doc/packages.md` should not be edited manually.
Update package lists, then run `make documentation`

### Setting the locale/language

Currently only 2 locales (english and french) are pre-generated, other languages have 
to be manually added to the build configuration, and the ISO rebuilt.

### See also

 * https://wiki.debian.org/DebianPureBlends
