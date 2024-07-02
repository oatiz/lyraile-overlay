# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN=${PN/-cli-bin/}

DESCRIPTION="A Powerful and All-in-One MQTT 5.0 client toolbox."
HOMEPAGE="https://github.com/emqx/MQTTX"
SRC_URI="https://www.emqx.com/en/downloads/MQTTX/v${PV}/mqttx-cli-linux-x64 -> ${P}-linux-x64"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror strip"

QA_PREBUILT="*"

S="${WORKDIR}"

src_install() {
	newbin "${DISTDIR}/${P}-linux-x64" "${MY_PN}"
}

