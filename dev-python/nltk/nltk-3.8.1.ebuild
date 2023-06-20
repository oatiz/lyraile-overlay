# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_11 )
PYTHON_REQ_USE="sqlite,tk?,xml(+)"

inherit distutils-r1 pypi

DESCRIPTION="Natural Language Toolkit"
HOMEPAGE="https://www.nltk.org"

SRC_URI="$(pypi_sdist_url "${PN}" "${PV}" .zip)"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="tk"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/joblib[${PYTHON_USEDEP}]
	dev-python/regex[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
"
BDEPEND="app-arch/unzip"
PDEPEND="dev-python/nltk-data"
