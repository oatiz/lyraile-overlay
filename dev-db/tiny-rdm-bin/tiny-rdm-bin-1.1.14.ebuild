# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop

MY_PN="${PN/-bin/}"

DESCRIPTION="A Modern Redis GUI Client"
HOMEPAGE="https://redis.tinycraft.cc"
SRC_URI="https://github.com/tiny-craft/tiny-rdm/releases/download/v${PV}/tiny-rdm_${PV}_linux_amd64.deb"

S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror"

RDEPEND="
	dev-libs/glib:2
	net-libs/webkit-gtk:4
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
"

src_install() {
	dobin "usr/local/bin/${MY_PN}"

	insinto /usr/share/icons/hicolor
	doins -r "usr/share/icons/hicolor"

	make_desktop_entry "/usr/bin/${MY_PN}" "${MY_PN}" "${MY_PN}" "Application;"
}
