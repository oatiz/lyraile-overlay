# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )

inherit distutils-r1 pypi

DESCRIPTION="EPC (RPC stack for Emacs Lisp) for Python"
HOMEPAGE="https://github.com/fbcotter/py3nvml.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="test"
