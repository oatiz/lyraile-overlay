# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg

DEB_PN="com.qq.weixin.deepin"

DESCRIPTION="Tencent WeChat on Deepin Wine For Gentoo"
HOMEPAGE="https://aur.archlinux.org/packages/deepin-wine-wechat"

SRC_URI="
	https://github.com/vufa/deepin-wine-wechat-arch/releases/download/v${PV}-3/${P}-3-x86_64.pkg.tar.zst
	https://github.com/oatiz/lyraile-overlay/releases/download/tempfile/fake_simsun.ttc
"

RESTRICT="mirror strip"

LICENSE="Tencent"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
QA_PREBUILT="*"

RDEPEND="
	app-emulation/deepin-wine-helper
	app-emulation/deepin-wine6-stable
	media-libs/alsa-lib[abi_x86_32]
	media-libs/libpulse[abi_x86_32]
	media-libs/openal[abi_x86_32]
	media-plugins/alsa-plugins[abi_x86_32]
	media-sound/mpg123[abi_x86_32]
	>=net-nds/openldap-2.4.0[abi_x86_32]
	x11-apps/xwininfo
"

DEPEND="${RDEPEND}"

BDEPEND="
	app-arch/p7zip
	sys-apps/coreutils
	app-alternatives/awk
"

S=${WORKDIR}

src_prepare() {
	7z x -aoa "${S}/opt/apps/${DEB_PN}/files/files.7z" -o"${S}/deepinwechatdir" || die
	cp "${DISTDIR}/fake_simsun.ttc" "${S}/deepinwechatdir/drive_c/windows/Fonts/" || die
	unlink "${S}/deepinwechatdir/drive_c/windows/Fonts/wqy-microhei.ttc" || die
	7z a -t7z -r "${S}"/files.7z "${S}"/deepinwechatdir/* || die
	md5sum "${S}/files.7z" | awk '{ print $1 }' >  "${S}/opt/apps/${DEB_PN}/files/files.md5sum" || die
	mv "${S}/files.7z" "${S}/opt/apps/${DEB_PN}/files/files.7z" || die
	default
}

src_install() {
	doins -r opt usr
	fperms +x /opt/apps/com.qq.weixin.deepin/files/run.sh
}

pkg_postinst() {
	ewarn "Because deepin changed DeployApp, WeChat will be reinstalled after"
	ewarn "upgrading from the old version."
	find /home -maxdepth 2 -name ".deepinwine" -exec rm -f "{}/Deepin-WeChat/reinstalled" \; || die
}

pkg_prerm() {
	find /home -maxdepth 2 -name ".deepinwine" -exec rm -rf "{}/Deepin-WeChat/" \; || die
}
