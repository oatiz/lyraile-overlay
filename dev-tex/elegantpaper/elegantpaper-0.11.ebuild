# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit latex-package

MY_PN="ElegantPaper"

DESCRIPTION="Elegant LaTeX Template for Working Papers"
HOMEPAGE="https://github.com/ElegantLaTeX/ElegantPaper"
SRC_URI="https://github.com/ElegantLaTeX/ElegantPaper/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="|| ( BSD LPPL-1.3 )"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/pygments
	dev-texlive/texlive-latexextra
"

DOCS=( ../README.md )

S="${WORKDIR}"/"${MY_PN}-${PV}"
src_install() {
	LATEX_DOC_ARGUMENTS="-shell-escape"

	latex-package_src_doinstall cls
}

