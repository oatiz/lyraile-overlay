# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

DESCRIPTION="Android system image used by uengine android container"
HOMEPAGE="https://anbox.io/"

COMMON_URI="https://github.com/oatiz/lyraile-overlay/releases/download/tempfile"
SRC_URI="${COMMON_URI}/${PN/-bin/}_${PV}_amd64.deb"

KEYWORDS="~amd64"

LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}

src_prepare() {
	default

	mv ${S}/usr/share/uengine/android.img ${S}/usr/share/uengine/.android.img
}

src_install() {
	insinto /

	doins -r usr

	fperms 644 /usr/share/uengine/.android.img
}
