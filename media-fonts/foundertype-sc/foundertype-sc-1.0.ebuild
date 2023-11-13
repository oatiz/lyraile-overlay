# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker font

DESCRIPTION="FounderType Free Fonts."
HOMEPAGE="https://github.com/wordshub/free-font"
SRC_URI="https://github.com/oatiz/lyraile-overlay/releases/download/tempfile/${P}.tar.xz"

RESRICT="mirror"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64"

S="${WORKDIR}"
FONT_SUFFIX="ttf"
