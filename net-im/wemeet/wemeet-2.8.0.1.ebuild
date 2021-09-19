# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

DESCRIPTION="Tencent Video Conferencing, tencent meeting"
HOMEPAGE="https://source.meeting.qq.com/download-center.html"

PLATFORM="x86_64"

SRC_URI="https://updatecdn.meeting.qq.com/cos/196cdf1a3336d5dca56142398818545f/TencentMeeting_0300000000_${PV}_${PLATFORM}.publish.deb -> ${P}-${PLATFORM}.deb"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}
	dev-qt/qtx11extras:5
	x11-themes/hicolor-icon-theme
	dev-libs/libbsd
	x11-libs/libXrandr
	dev-qt/qtwebkit:5
	x11-libs/libXinerama
	media-sound/pulseaudio
	sys-apps/bubblewrap
"
BDEPEND=""

S=${WORKDIR}

src_prepare() {
	sed -i '3c Exec=wemeet %u ' ${S}/usr/share/applications/${PN}app.desktop
	sed -i 'N;2aName[zh_CN]=腾讯会议\nComment=Tencent Meeting Linux Client\nComment[zh_CN]=腾讯会议Linux客户端\nKeywords=wemeet;tencent;meeting;' "${S}/usr/share/applications/wemeetapp.desktop"
	sed -i '4c Prefix = /usr/lib64/qt5' ${S}/opt/${PN}/bin/qt.conf

	elog "Preparing icons"
	for res in {16,32,64,128,256}
	do
	    mkdir -p ${S}/usr/share/icons/hicolor/${res}x${res}/apps
	    install -m644 ${S}/opt/${PN}/icons/hicolor/${res}x${res}/mimetypes/${PN}app.png ${S}/usr/share/icons/hicolor/${res}x${res}/apps/${PN}app.png
	done

	elog "Preparing libs"
	mkdir -p ${S}/usr/lib/${PN}
	install -m644 ${S}/opt/${PN}/lib/{libwemeet*,libxcast.so,libxnn*,libtquic.so} ${S}/usr/lib/${PN}/

	mkdir -p ${S}/usr/bin
	install -m755 ${FILESDIR}/${PN} ${S}/usr/bin/

	eapply_user
}

src_install() {
	elog "Install wemeet..."
	insinto /
	doins -r opt usr

	fperms -R 755 /usr/bin/${PN}
	fperms -R 755 /opt/${PN}/bin/${PN}app
	fperms -R 755 /opt/${PN}/bin/crashpad_handler
}
