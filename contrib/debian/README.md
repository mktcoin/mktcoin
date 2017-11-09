
Debian
====================
This directory contains files used to package mktcoind/mktcoin-qt
for Debian-based Linux systems. If you compile mktcoind/mktcoin-qt yourself, there are some useful files here.

## mktcoin: URI support ##


mktcoin-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install mktcoin-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your mktcoin-qt binary to `/usr/bin`
and the `../../share/pixmaps/mktcoin128.png` to `/usr/share/pixmaps`

mktcoin-qt.protocol (KDE)

