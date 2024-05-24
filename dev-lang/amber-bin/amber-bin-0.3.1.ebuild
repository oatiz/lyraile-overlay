# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN=${PN/-bin/}

DESCRIPTION="The programming language compiled to bash"
HOMEPAGE="https://github.com/Ph0enixKM/Amber"
SRC_URI="https://github.com/Ph0enixKM/Amber/releases/download/${PV}-alpha/${MY_PN}_linux_x86_64 -> ${P}_linux_x86_64"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror"

RDEPEND="${DEPEND}"

QA_PREBUILT="*"

S="${WORKDIR}"

src_install() {
	newbin "${DISTDIR}/${P}_linux_x86_64" "${MY_PN}"
}
