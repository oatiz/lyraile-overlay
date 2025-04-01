# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="LXGW WenKai for Screen Reading"
HOMEPAGE="https://github.com/lxgw/LxgwWenKai-Screen"
SRC_URI="https://github.com/lxgw/LxgwWenKai-Screen/releases/download/v${PV}/LXGWWenKaiMonoScreen.ttf -> ${P}.ttf"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64"

# Has to fall back to distdir until author offers tarball
S="${DISTDIR}"
FONT_SUFFIX="ttf"
FONT_S="${DISTDIR}"
