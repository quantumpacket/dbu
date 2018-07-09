# Lightdm display manager

__simple display manager__

```

An X display manager that:
 * Has a lightweight codebase
 * Is standards compliant (PAM, ConsoleKit, etc)
 * Has a well defined interface between the server and user interface
 * Fully themeable
 * Cross-desktop (greeters can be written in any toolkit)

Additional software can be useful along with LightDM:
 * xserver-xephyr can be used to add a nested X display by calling
  'dm-tool add-nested-seat`
 * upower can be used to suspend the computer from the display manager
 * accountsservice is used to populate a user list with addition information.

```

[![](https://screenshots.debian.net/thumbnail-with-version/lightdm/9001)](https://screenshots.debian.net/screenshot-with-version/lightdm/9001)



**[Homepage](https://launchpad.net/lightdm)**

### Installed packages

* [lightdm](https://packages.debian.org/stretch/lightdm) `1.18.3-1` - simple display manager
* [lightdm-gtk-greeter](https://packages.debian.org/stretch/lightdm-gtk-greeter) `2.0.2-1` - simple display manager (GTK+ greeter)

### Related packages

 * [slim](https://packages.debian.org/stretch/slim) desktop-independent graphical login manager for X11
 * [gdm3](https://packages.debian.org/stretch/gdm3) GNOME Display Manager
 * [arctica-greeter](https://packages.debian.org/stretch/arctica-greeter) LightDM Arctica Greeter
