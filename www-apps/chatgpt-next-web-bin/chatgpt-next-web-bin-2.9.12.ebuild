# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg

MY_PN="chat-gpt-next-web"

DESCRIPTION="A well-designed cross-platform ChatGPT UI"
HOMEPAGE="https://github.com/Yidadaa/ChatGPT-Next-Web"
SRC_URI="https://github.com/Yidadaa/ChatGPT-Next-Web/releases/download/v${PV}/${MY_PN}_${PV}_amd64.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
S="${WORKDIR}"

RESTRICT="mirror strip"

QA_PREBUILT="*"

src_install() {
	doins -r usr

	fperms +x "/usr/bin/${MY_PN}"
}
