# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker xdg-utils

DESCRIPTION="开源游戏平台，帮您在UOS/Linux系统中运行Windows游戏"
HOMEPAGE="https://winegame.net/"
SRC_URI="https://file.winegame.net/packages/archlinux/${PV}/net.winegame.client-${PV}-${PR/r/}-x86_64.pkg.tar.zst"
LICENSE="GPL3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

RDEPEND="${DEPEND}
    dev-python/pygobject
	dev-python/pyyaml
	dev-python/python-evdev
	dev-python/pillow
	dev-python/requests
	dev-python/pydbus
	dev-python/distro
	x11-libs/gtk+:3
	sys-libs/glibc
	sys-process/psmisc
	app-arch/cabextract
	app-arch/unzip
	app-arch/p7zip
	app-arch/tar
	net-misc/curl
	net-misc/wget
	net-misc/aria2
	x11-apps/xrandr
	gnome-base/gnome-desktop
	gnome-extra/zenity
	net-libs/webkit-gtk
	x11-apps/mesa-progs
	app-emulation/wine-staging[abi_x86_32]
	media-libs/vulkan-loader[abi_x86_32]
	dev-util/vulkan-tools[abi_x86_32]
"

S=${WORKDIR}

src_install() {
    insinto /
    doins -r usr opt

    fperms -R 755 /opt/apps/net.winegame.client/files/bin/*
    fperms -R 755 /opt/apps/net.winegame.client/files/share/lutris/bin/*
}
pkg_postinst() {
    xdg_desktop_database_update
    xdg_icon_cache_update
}

pkg_postrm() {
    xdg_desktop_database_update
    xdg_icon_cache_update
}
