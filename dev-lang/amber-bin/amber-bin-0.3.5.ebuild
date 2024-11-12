# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN=${PN/-bin/}

DESCRIPTION="The programming language compiled to bash"
HOMEPAGE="https://github.com/Ph0enixKM/Amber"
SRC_URI="https://github.com/Ph0enixKM/Amber/releases/download/${PV}-alpha/${MY_PN}-x86_64-unknown-linux-gnu.tar.xz -> ${P}-x86_64-unknown-linux-gnu.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${MY_PN}-x86_64-unknown-linux-gnu"

RESTRICT="mirror"

QA_PREBUILT="*"

src_install() {
	dobin "${MY_PN}"
}
