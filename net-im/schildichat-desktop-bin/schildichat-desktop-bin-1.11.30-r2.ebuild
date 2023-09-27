# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin/}"
MY_PR="${PR/r/}"

inherit unpacker xdg

DESCRIPTION="A matrix client based on Element with a more instant messaging experience."
HOMEPAGE="https://schildi.chat"
SRC_URI="https://github.com/SchildiChat/${MY_PN}/releases/download/v${PV}-sc.${MY_PR}/${MY_PN}_${PV}-sc.${MY_PR}_amd64.deb"
RESTRICT="mirror"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64"

DEPEND=""
RDEPEND="${DEPEND}
	dev-db/sqlcipher
	dev-libs/openssl
"
BDEPEND=""

S="${WORKDIR}"
src_install() {
	insinto /
	doins -r opt usr

	fperms 0755 /opt/SchildiChat/"${MY_PN}"
}
