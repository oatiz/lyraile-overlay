# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg

MY_PN="${PN/-bin/}"
MY_PR="${PR/r/}"
MY_P="${MY_PN}-${PVR}"

DESCRIPTION="API 文档、调试、Mock、测试一体化协作平台"
HOMEPAGE="https://www.apifox.cn"
SRC_URI="https://github.com/oatiz/lyraile-overlay/releases/download/tempfile/${MY_P}_amd64.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

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
	chrome-sandbox
	chrome_crashpad_handler
	libEGL.so
	libffmpeg.so
	libGLESv2.so
	libvk_swiftshader.so
	libvulkan.so.1
	${MY_PN}
"

S="${WORKDIR}"

src_install() {
	insinto /opt/"${MY_PN}"
	doins -r opt/Apifox/*

	doicon -s 512 usr/share/icons/hicolor/512x512/apps/"${MY_PN}".png

        make_desktop_entry "/opt/${MY_PN}/${MY_PN}" "${MY_PN}" "${MY_PN}" "Utility;"

	local f
	for f in ${QA_PREBUILT}; do
		fperms +x "/opt/${MY_PN}/${f}"
	done

	fperms u+s /opt/"${MY_PN}"/chrome-sandbox
}
