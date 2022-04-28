# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9,10} )
inherit distutils-r1


DESCRIPTION="Automatic CPU speed & power optimizer for Linux"
HOMEPAGE="https://github.com/AdnanHodzic/auto-cpufreq"

if [[ "${PV}" == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/AdnanHodzic/${PN}.git"
else
	SRC_URI="https://github.com/AdnanHodzic/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-3"
KEYWORDS="~amd64"
SLOT="0"
IUSE=""

RDEPEND="dev-python/psutil
	dev-python/click
	dev-python/distro"

DEPEND="${RDEPEND}"

RESTRICT="mirror"

DOCS=( README.md )

python_install_all() {
	distutils-r1_python_install_all
}
