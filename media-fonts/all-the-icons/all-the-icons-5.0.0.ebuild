# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

MY_PV="LigaBlexMonoNerd"
MY_PN="fd4857a8226ff3f539e3f2e538fc6968c3e1b8c8"

DESCRIPTION="A utility package to collect various Icon Fonts and propertize them within Emacs"
HOMEPAGE="https://github.com/domtronn/all-the-icons.el"
SRC_URI="https://github.com/domtronn/all-the-icons.el/archive/refs/tags/${PV}.tar.gz"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64"

# Has to fall back to distdir until author offers tarball
S="${WORKDIR}/${PN}.el-${PV}/fonts"
FONT_SUFFIX="ttf"
