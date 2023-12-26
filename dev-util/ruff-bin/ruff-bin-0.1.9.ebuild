# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

MY_PN=${PN/-bin/}

DESCRIPTION="An extremely fast Python linter, written in Rust"
HOMEPAGE="
	https://beta.ruff.rs/docs
	https://github.com/charliermarsh/ruff
"

SRC_URI="https://github.com/astral-sh/ruff/releases/download/v${PV}/${MY_PN}-${PV}-x86_64-unknown-linux-gnu.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror"

RDEPEND="!dev-util/ruff"

S="${WORKDIR}"

QA_PREBUILT="*"

src_install() {
	dobin ${MY_PN}
}
