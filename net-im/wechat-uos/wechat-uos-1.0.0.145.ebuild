# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop

DESCRIPTION="WeChat Testing with bwrap sandbox"
HOMEPAGE="https://aur.archlinux.org/packages/wechat-uos-bwrap"

SRC_URI="
	https://cdn4.cnxclm.com/uploads/2024/03/05/3VDyAc0x_wechat-beta_${PV}_amd64.deb?attname=wechat-beta_${PV}_amd64.deb -> ${P}.deb
	https://home-store-packages.uniontech.com/appstore/pool/appstore/c/com.qq.weixin/com.tencent.weixin_2.1.8_amd64.deb
"

LICENSE="custom"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror strip"

RDEPEND="
	sys-apps/bubblewrap
	sys-apps/lsb-release
	x11-libs/libnotify
"

S="${WORKDIR}"

QA_FLAGS_IGNORED=".*"
QA_PREBUILT="*"
QA_SONAME="*"
QA_TEXTRELS="*"

src_install() {
	insinto /opt/wechat-beta
	doins -r opt/wechat-beta/*
	doins "${FILESDIR}/wechat.sh"

	insinto /opt/wechat-beta/crap
	doins "${FILESDIR}"/uos-{lsb,release}

	insinto /opt/wechat-beta/crap/usr/lib/license
	doins "${S}/usr/lib/license/libuosdevicea.so"
	keepdir /usr/lib/license

	insinto /opt/wechat-beta/crap/var/uos
	newins "${FILESDIR}/license.key" .license.key

	insinto /opt/wechat-beta/crap/var/lib/uos-license
	newins "${FILESDIR}/license.json" .license.json

	domenu "${FILESDIR}/wechat-uos-beta.desktop"
	doicon -s scalable "${FILESDIR}/wechat-uos-beta.svg"

	find "${ED}"/opt/wechat-beta -name '*.so' -exec chmod 755 '{}' + || die
	fperms +x /opt/wechat-beta/wechat{,.sh}
}
