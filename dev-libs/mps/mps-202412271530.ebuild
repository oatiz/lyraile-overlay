# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="9fd0577cf1231e61c9801c81499e5d16d0743806"

# inherit gnuconfig

DESCRIPTION="The Memory Pool System"
HOMEPAGE="http://www.ravenbrook.com/project/mps"
SRC_URI="https://github.com/Ravenbrook/mps/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${MY_PV}"

src_compile() {
	pushd code || die
	gcc -O2 -c mps.c || die
	ar rvs libmps.a mps.o || die
	popd || die
}

src_install() {
	insinto /usr/include/mps
	doins code/mps*.h

	insinto /usr/lib64/mps
	doins code/libmps.a code/mps.o 
}
