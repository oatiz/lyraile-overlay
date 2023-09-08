# Copyright 2023 Avishek Sen
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit go-module

DESCRIPTION="Wayland clipboard manager"
HOMEPAGE="https://github.com/sentriz/cliphist"

LICENSE="GPL-3"
SLOT="0"
IUSE="+pie"

KEYWORDS="-* ~amd64"
RESTRICT="mirror"

RDEPEND="gui-apps/wl-clipboard
		x11-misc/xdg-utils"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

SRC_URI="https://github.com/sentriz/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
		 https://github.com/oatiz/gentoo-go-deps/releases/download/${P}/${P}-deps.tar.xz
		 https://github.com/oatiz/gentoo-go-deps/releases/download/${P}/${P}-vendor.tar.xz
"
DOCS="readme.md LICENSE"

src_compile () {
	export CGO_CFLAGS="${CFLAGS}"
	export CGO_CPPFLAGS="${CXXFLAGS}"
	export CGO_CXXFLAGS="${CXXFLAGS}"
	export CGO_LDFLAGS="${LDFLAGS}"

	if use pie ; then
		ego build \
		--buildmode=pie \
		-trimpath \
		-mod=readonly \
		-modcacherw \
		-ldflags "-s -w -linkmode external -X main.version=${PV}" \
		-o "${PN}" .
	else
		ego build \
		-trimpath \
		-mod=readonly \
		-modcacherw \
		-ldflags "-s -w -linkmode external -X main.version=${PV}" \
		-o "${PN}" .
	fi
}

src_install() {
	einstalldocs
	dobin "${PN}"
}
