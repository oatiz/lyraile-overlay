# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="Python wrapper for evaluating summarization quality by ROUGE package"
HOMEPAGE="https://github.com/tagucci/pythonrouge"

SRC_URI="https://github.com/tagucci/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror test"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
