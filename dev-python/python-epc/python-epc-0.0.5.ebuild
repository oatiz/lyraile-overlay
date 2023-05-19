# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )
inherit distutils-r1

DESCRIPTION=""
HOMEPAGE="
	https://pypi.org/project/python-epc/
"
SRC_URI="https://github.com/tkf/python-epc/archive/refs/tags/v0.0.5.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="test"

RDEPEND="
	dev-python/sexpdata[$PYTHON_USEDEP]
"
BDEPEND=""

distutils_enable_tests pytest
