# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Latin Modern Fonts"
HOMEPAGE="https://www.gust.org.pl/"
SRC_URI="https://github.com/oatiz/lyraile-overlay/releases/download/tempfile/${P}.tar.xz"

RESTRICT="mirror"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64"

# Has to fall back to distdir until author offers tarball
S="${WORKDIR}/${P}"

FONT_SUFFIX="otf"
