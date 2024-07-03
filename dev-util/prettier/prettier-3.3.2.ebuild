# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nodejs-r1

DESCRIPTION="Prettier is an opinionated code formatter."
HOMEPAGE="https://github.com/prettier/prettier"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

# Note that this metadata derives from the "packages/prettier/package.json" file.
NODEJS_BINSCRIPTS='
	bin/prettier.cjs:prettier
'
NODEJS_MIN_VERSION='12.0.0'
QA_PREBUILT="*"
