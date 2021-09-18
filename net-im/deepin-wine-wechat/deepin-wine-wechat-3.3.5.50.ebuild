# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

WECHAT_INSTALLER="WeChatSetup"
DP_WECHAT_VER="3.2.1.154deepin13"
DEB_PN="com.qq.weixin.deepin"

DESCRIPTION="Tencent WeChat on Deepin Wine(${DEB_PN}) For Gentoo"
HOMEPAGE="https://weixin.qq.com"

_MIRROR="https://com-store-packages.uniontech.com"
SRC_URI="${_MIRROR}/appstore/pool/appstore/c/${DEB_PN}/${DEB_PN}_${DP_WECHAT_VER}_i386.deb
		https://dldir1.qq.com/weixin/Windows/${WECHAT_INSTALLER}.exe -> ${P}-${WECHAT_INSTALLER}.exe
"

LICENSE="Tencent"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	app-arch/p7zip
	x11-apps/xwininfo
	media-fonts/wqy-microhei
	app-emulation/deepin-wine6-stable
	app-emulation/deepin-wine-helper"

S=${WORKDIR}

src_prepare() {
	sed "s/\(Categories.*$\)/\1Network;/" -i "${S}/opt/apps/${DEB_PN}/entries/applications/${DEB_PN}.desktop"
	sed "13s/WeChat.exe/wechat.exe/" -i "${S}/opt/apps/${DEB_PN}/entries/applications/${DEB_PN}.desktop"
	sed "s/run.sh\".*/run.sh\"/" -i "${S}/opt/apps/${DEB_PN}/entries/applications/${DEB_PN}.desktop"

	elog "Extracting Deepin Wine WeChat archive ..."
	7z x -aoa "${S}/opt/apps/${DEB_PN}/files/files.7z" -o"${S}/deepinwechatdir"

	elog "Cleaning up the original package directory ..."
	rm -r "${S}/deepinwechatdir/drive_c/Program Files/Tencent/WeChat"

	elog "Patching reg files ..."
	patch -p1 -d "${S}/deepinwechatdir/" < "${FILESDIR}/reg.patch"

	elog "Creating font file link ..."
	ln -sf "/usr/share/fonts/wqy-microhei/wqy-microhei.ttc" "${S}/deepinwechatdir/drive_c/windows/Fonts/wqy-microhei.ttc"

	elog "Copying latest WeChat installer to ${S}/deepinwechatdir/drive_c/Program Files/Tencent/ ..."
	install -m644 "${DISTDIR}/${P}-${WECHAT_INSTALLER}.exe" "${S}/deepinwechatdir/drive_c/Program Files/Tencent/${WECHAT_INSTALLER}-${PV}.exe"

	#find -L "${srcdir}/deepinwechatdir/dosdevices" -maxdepth 1 -type l -delete
	elog "Repackaging app archive ..."
	7z a -t7z -r "${S}/files.7z" "${S}/deepinwechatdir/*"

	eapply_user	
}

src_install() {
	elog "Install wechat ..."
	insinto /
	doins -r opt

	elog "Preparing icons ..."
	# cp -r "${S}/opt/apps/${DEB_PN}/entries/icons/" "/usr/share/"
	insinto /usr/share/icons
	doins -r opt/apps/${DEB_PN}/entries/icons/hicolor

	# install -Dm644 "${S}/opt/apps/${DEB_PN}/entries/applications/${DEB_PN}.desktop" "/usr/share/applications/${DEB_PN}.desktop"
	insinto /usr/share/applications/
	doins "${S}/opt/apps/${DEB_PN}/entries/applications/${DEB_PN}.desktop"

	elog "Copying deepin files ..."
	#cp -r "${S}/opt/apps/${DEB_PN}/files/dlls" "/opt/apps/${DEB_PN}/files/"
	insinto /opt/apps/${DEB_PN}/files
	doins -r opt/apps/${DEB_PN}/files/dlls

	#install -m644 "${S}/files.7z" "/opt/apps/${DEB_PN}/files/"
	doins "${S}/files.7z"
	doins "${FILESDIR}/run.sh"
	fperms -R 755 /opt/apps/${DEB_PN}/files/run.sh

	md5sum "${S}/files.7z" | awk '{ print $1 }' > "${S}/files.md5sum" 
	doins "${S}/files.md5sum"

}

