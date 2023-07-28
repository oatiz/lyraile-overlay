# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )

inherit distutils-r1 pypi

DESCRIPTION="Run your *raw* PyTorch training script on any kind of device"
HOMEPAGE="https://github.com/huggingface/accelerate"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="test mirror"
