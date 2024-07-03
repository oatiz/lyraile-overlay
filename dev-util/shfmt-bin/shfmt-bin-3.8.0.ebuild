# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN=${PN/-bin/}

DESCRIPTION="A shell parser, formatter, and interpreter with bash support"
HOMEPAGE="https://github.com/mvdan/sh"
SRC_URI="https://www.emqx.com/en/downloads/MQTTX/v${PV}/mqttx-cli-linux-x64 -> ${P}-linux-x64"
SRC_URI="https://github.com/mvdan/sh/releases/download/v${PV}/${MY_PN}_v${PV}_linux_amd64"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror strip"

QA_PREBUILT="*"

S="${WORKDIR}"

src_install() {
	newbin "${DISTDIR}/${MY_PN}_v${PV}_linux_amd64" "${MY_PN}"
}
