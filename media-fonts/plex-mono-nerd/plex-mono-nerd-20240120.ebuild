# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

MY_PV="LigaBlexMonoNerd"
MY_PN="fd4857a8226ff3f539e3f2e538fc6968c3e1b8c8"

DESCRIPTION="IBM Plex Mono Nerd Fonts with Ligatures"
HOMEPAGE="https://github.com/ayamir/LigaBlexMonoNerd"
SRC_URI="https://codeload.github.com/ayamir/LigaBlexMonoNerd/zip/${MY_PN} -> ${P}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64"

BDEPEND="app-arch/unzip"

# Has to fall back to distdir until author offers tarball
S="${WORKDIR}/${MY_PV}-${MY_PN}"
FONT_SUFFIX="otf"
