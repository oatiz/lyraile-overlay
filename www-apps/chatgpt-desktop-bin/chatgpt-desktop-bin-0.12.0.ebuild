# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg

MY_PN="ChatGPT"

DESCRIPTION="${MY_PN} Desktop Application"
HOMEPAGE="https://github.com/lencx/${MY_PN}"
SRC_URI="https://github.com/lencx/${MY_PN}/releases/download/v${PV}/${MY_PN}_${PV}_linux_x86_64.deb"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"

IUSE=""

RDEPEND="
	dev-dependency/tauri-requirements
	dev-libs/openssl
	dev-libs/libayatana-appindicator
"

RESTRICT="mirror strip"

S="${WORKDIR}"

src_install() {
	doins -r *

	fperms +x /usr/bin/chat-gpt
}
