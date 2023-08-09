# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="emacs lsp-bridge dependencies"
HOMEPAGE="https://github.com/manateelazycat/lsp-bridge"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"

DEPEND="
	dev-python/epc
	dev-python/orjson
	dev-python/sexpdata
	dev-python/six
	dev-python/paramiko
"
