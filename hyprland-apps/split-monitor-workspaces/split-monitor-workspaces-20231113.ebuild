# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

EGIT_2023_11_13_COMMIT="2b1abdbf9e9de9ee660540167c8f51903fa3d959"

DESCRIPTION="A plugin to provide awesome-like workspace behavior"
HOMEPAGE="https://github.com/Duckonaut/split-monitor-workspaces"
SRC_URI="https://github.com/Duckonaut/split-monitor-workspaces/archive/${EGIT_2023_11_13_COMMIT}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	gui-wm/hyprland
	x11-libs/pixman
	x11-libs/libdrm
"

S="${WORKDIR}/${PN}-${EGIT_2023_11_13_COMMIT}"

src_configure() {
	meson_src_configure --wipe
}
