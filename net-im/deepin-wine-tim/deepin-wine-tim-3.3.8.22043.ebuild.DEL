# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

WECHAT_INSTALLER="WeChatSetup"
DP_TIM_VER="9.3.2deepin20"
DEB_PN="com.qq.im.deepin"
TIM_PN="com.qq.office.deepin"

DESCRIPTION="Tencent TIM on Deepin Wine6(${TIM_PN}) For Gentoo"
HOMEPAGE="https://tim.qq.com/"

_MIRROR="https://cdn-package-store6.deepin.com"
SRC_URI="${_MIRROR}/appstore/pool/appstore/c/${DEB_PN}/${DEB_PN}_${DP_TIM_VER}_i386.deb
		https://dldir1.qq.com/qqfile/qq/PCTIM/TIM3.3.8/TIM${PV}.exe
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
	net-libs/gnutls[abi_x86_32]
	app-emulation/deepin-wine6-stable
	app-emulation/deepin-wine-helper
	"

S=${WORKDIR}

src_prepare() {
	elog "Extracting Deepin Wine QQ archive ..."
	7z x -aoa "${S}/opt/apps/${DEB_PN}/files/files.7z" -o"${S}/deepintimdir"

	elog "Cleaning up the original package directory ..."
	rm -r "${S}/deepintimdir/drive_c/Program Files/Tencent/QQ"

	elog "Creating font file link ..."
	ln -sf "/usr/share/fonts/wenquanyi/wqy-microhei/wqy-microhei.ttc" "${S}/deepintimdir/drive_c/windows/Fonts/wqy-microhei.ttc"

	elog "Copying latest TIM installer to ${S}/deepintimdir/drive_c/Program Files/Tencent/ ..."
	install -m644 "${DISTDIR}/TIM${PV}.exe" "${S}/deepintimdir/drive_c/Program Files/Tencent/"

	elog "Repackaging app archive ..."
	7z a -t7z -r "${S}/files.7z" "${S}/deepintimdir/*"

	elog "Preparing icons ..."
	install -d "${S}/usr/share"
	7z x -aoa "${FILESDIR}/share.7z" -o"${S}/"
	cp -a ${S}/share/* "${S}/usr/share/"

	elog "Copying deepin files ..."
	rm -r "${S}/opt/apps/${DEB_PN}"
	install -d "${S}/opt/apps/${TIM_PN}/files"
	install -m644 "${S}/files.7z" "${S}/opt/apps/${TIM_PN}/files/"
	install -m755 "${FILESDIR}/run.sh" "${S}/opt/apps/${TIM_PN}/files/"
	md5sum "${S}/files.7z" | awk '{ print $1 }' > "${S}/opt/apps/${TIM_PN}/files/files.md5sum"

	eapply_user
}

src_install() {
	elog "Install Tim..."
	insinto /
	doins -r opt usr

	fperms -R 755 /opt/apps/${TIM_PN}/files/run.sh
}

