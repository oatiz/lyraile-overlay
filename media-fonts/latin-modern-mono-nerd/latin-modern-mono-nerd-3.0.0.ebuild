# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Latin Modern Mono Nerd Fonts"
HOMEPAGE="https://github.com/oatiz/LatinModernMono10NerdFont"
SRC_URI="https://github.com/oatiz/LatinModernMono10NerdFont/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64"

# Has to fall back to distdir until author offers tarball
S="${WORKDIR}/LatinModernMono10NerdFont-${PV}"

FONT_CONF=( "${FILESDIR}/49-lm10-mono-nerd-spacing.conf" ) 
FONT_SUFFIX="otf"
