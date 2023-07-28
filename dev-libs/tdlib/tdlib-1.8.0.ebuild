# Copyright 2019-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Cross-platform library for building Telegram clients"
HOMEPAGE="https://core.telegram.org/tdlib"
SRC_URI="https://github.com/tdlib/td/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSL-1.0"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="sys-devel/gcc
	dev-libs/openssl
	sys-libs/zlib
	dev-util/gperf
	dev-util/cmake
"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/td-${PV}"
