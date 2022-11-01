# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin/}"

inherit unpacker xdg desktop

DESCRIPTION="A matrix client based on Element with a more instant messaging experience."
HOMEPAGE="https://schildi.chat"
SRC_URI="https://github.com/SchildiChat/${MY_PN}/releases/download/v${PV}-sc.1/${MY_PN}_${PV}-sc.1_amd64.deb"
RESTRICT="mirror"

LICENSE="Apache"
SLOT="0"
KEYWORDS="-* ~amd64"

DEPEND=""
RDEPEND="${DEPEND}
	dev-db/sqlcipher
"
BDEPEND=""

S="${WORKDIR}"
src_install() {
	insinto /
	doins -r opt usr

	fperms 0755 /opt/SchildiChat/"${MY_PN}"
}
