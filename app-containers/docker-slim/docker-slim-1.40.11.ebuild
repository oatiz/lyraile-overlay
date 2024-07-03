# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Make Your Containers Better, Smaller, More Secure and Do Less to Get There"
HOMEPAGE="https://github.com/slimtoolkit/slim"
SRC_URI="https://github.com/slimtoolkit/slim/releases/download/1.40.11/dist_linux.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}"

src_install() {
	dobin dist_linux/*
}
