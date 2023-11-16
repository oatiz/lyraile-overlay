# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit latex-package

MY_PN="ElegantBook"

DESCRIPTION="Elegant LaTeX Template for Books"
HOMEPAGE="https://github.com/ElegantLaTeX/ElegantBook"
SRC_URI="https://github.com/ElegantLaTeX/ElegantBook/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="|| ( BSD LPPL-1.3 )"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/pygments
	dev-texlive/texlive-latexextra
	dev-tex/biblatex
"

DOCS=( ../README.md )

S="${WORKDIR}"/"${MY_PN}-${PV}"
src_install() {
	insinto /usr/share/texmf-site/"${PN}"

	doins figure/*

	latex-package_src_doinstall cls
}

