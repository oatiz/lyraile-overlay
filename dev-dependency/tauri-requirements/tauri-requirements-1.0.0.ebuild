# Copyright 2017-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Tauri System Dependencies"
HOMEPAGE="https://tauri.app/v1/guides/getting-started/prerequisites#setting-up-linux"

SRC_URI=""
RESTRICT="mirror"

LICENSE="custom"
SLOT="0"
KEYWORDS="-* ~amd64"

IUSE=""
REQUIRED_USE=""

DEPEND=""
RDEPEND="
	${DEPEND}
	net-libs/webkit-gtk
	x11-misc/appmenu-gtk-module
	x11-libs/gtk+:3
	dev-libs/libappindicator:3
	gnome-base/librsvg
	media-libs/vips
"
QA_PREBUILT="*"
