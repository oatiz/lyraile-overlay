# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN=${PN/-bin/}

DESCRIPTION="A package management and workflow tool"
HOMEPAGE="https://pixi.sh/ https://github.com/prefix-dev/pixi/"
SRC_URI="https://github.com/prefix-dev/pixi/releases/download/v${PV}/pixi-x86_64-unknown-linux-musl.tar.gz"

S=${WORKDIR}

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}
	!dev-util/pixi"
BDEPEND=""

src_install() {	
	dobin ${MY_PN}
}
