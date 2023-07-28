# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )
inherit distutils-r1

DESCRIPTION="Easy GPU switching for Nvidia Optimus laptops under Linux"
HOMEPAGE="https://github.com/bayasdev/envycontrol"
SRC_URI="https://github.com/bayasdev/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="test"
