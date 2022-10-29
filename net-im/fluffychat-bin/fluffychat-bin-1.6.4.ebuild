# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin/}"

inherit unpacker xdg desktop

DESCRIPTION="Chat with your friends"
HOMEPAGE="https://fluffychat.im/"
SRC_URI="https://gitlab.com/api/v4/projects/16112282/packages/generic/${MY_PN}/${PV}/${MY_PN}-linux-x86.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="AGPL3"
SLOT="0"
KEYWORDS="-* ~amd64"

IUSE="hidpi"

DEPEND=""
RDEPEND="${DEPEND}
	gui-libs/gtk
	dev-libs/jsoncpp
	app-crypt/libsecret
"
BDEPEND=""

S="${WORKDIR}"
src_install() {
	local dir="/opt/${MY_PN}"
	insinto "${dir}"

	doins -r data lib

	doins ${MY_PN}
	fperms 0755 "${dir}"/"${MY_PN}"

	newicon "${S}"/data/flutter_assets/assets/favicon.png "${MY_PN}".png

	if use hidpi; then
		local start="env GDK_SCALE=2 ${dir}/${MY_PN}"
		make_desktop_entry "${start}" "${MY_PN}" "${MY_PN}" "Chat;IRCClient"
	else
		make_desktop_entry "${dir}/${MY_PN}" "${MY_PN}" "${MY_PN}" "Chat;IRCClient"
	fi
}
