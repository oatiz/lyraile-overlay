# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg

MY_PN="Z-Library"

DESCRIPTION="Z-Library launcher for desktop"
HOMEPAGE="https://go-to-zlibrary.se"
SRC_URI="https://go-to-zlibrary.se/soft/zlibrary-setup-latest.deb"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"
S="${WORKDIR}"

RDEPEND="
	app-accessibility/at-spi2-core:2
	app-crypt/libsecret
	dev-libs/nss
	x11-misc/xdg-utils
	x11-libs/gtk+:3
	x11-libs/libnotify
	x11-libs/libXtst
"

RESTRICT="mirror strip"

QA_PREBUILT="
	opt/${MY_PN}/chrome-sandbox
	opt/${MY_PN}/chrome_crashpad_handler
	opt/${MY_PN}/libEGL.so
	opt/${MY_PN}/libffmpeg.so
	opt/${MY_PN}/libGLESv2.so
	opt/${MY_PN}/libvk_swiftshader.so
	opt/${MY_PN}/libvulkan.so.1
	opt/${MY_PN}/${PN}
"

src_install() {
	doins -r opt usr

	local f
	for f in ${QA_PREBUILT}; do
		fperms +x "/${f}"
	done
}
