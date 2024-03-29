# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )

inherit distutils-r1

DESCRIPTION="Automatic CPU speed & power optimizer for Linux"
HOMEPAGE="https://github.com/AdnanHodzic/auto-cpufreq"

SRC_URI="https://github.com/AdnanHodzic/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

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

src_prepare() {
	default

	sed -i 's/\/usr\/local\/bin\/auto-cpufreq/auto-cpufreq/g' "${S}"/scripts/"${PN}"-openrc || die
}

python_install_all() {
	distutils-r1_python_install_all
	doinitd "${FILESDIR}"/"${PN}"

	local dir="/usr/local/share/"${PN}"/scripts"
	insinto "${dir}"
	doins "${S}"/scripts/cpufreqctl.sh

	fperms 0755 "${dir}"/cpufreqctl.sh
}
