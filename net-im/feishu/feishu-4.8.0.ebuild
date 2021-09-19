# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker


DESCRIPTION="Linux client of Feishu (Lark) from Bytedance."
HOMEPAGE="https://www.feishu.cn/"

SRC_URI="https://sf3-cn.feishucdn.com/obj/suite-public-file-cn/b4f6bd/bytedance-feishu-beta_${PV}-24_amd64.deb"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}
	x11-themes/hicolor-icon-theme
	app-misc/ca-certificates
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXtst
	dev-libs/nss
	x11-misc/xdg-utils
"
BDEPEND=""


S=${WORKDIR}

src_prepare() {
	sed -i "s/bytedance-feishu-beta/feishu/g" "${S}/usr/share/applications/bytedance-feishu.desktop"
	sed -i '17c Icon=feishu' "${S}/usr/share/applications/bytedance-feishu.desktop"
	sed -i "s/bytedance-feishu/feishu/g" "${S}/usr/share/menu/bytedance-feishu.menu"
	sed -i 's/bytedance-feishu/feishu/g' "${S}/usr/share/appdata/bytedance-feishu.appdata.xml"
	mv "${S}"/usr/share/menu/{bytedance-,}feishu.menu
	mv "${S}"/usr/share/applications/{bytedance-,}feishu.desktop
	mv "${S}"/usr/share/appdata/{bytedance-,}feishu.appdata.xml
	mv "${S}"/usr/share/man/man1/{bytedance-feishu,feishu}.1.gz
	mv "${S}"/usr/share/doc/{bytedance-feishu-beta,feishu}
	mv "${S}"/usr/bin/{bytedance-feishu-beta,feishu}

	elog "Preparing icons"
	rename product_logo ${PN} ${S}/opt/bytedance/${PN}/product_logo_*
	for res in {16,24,32,48,64,128,256}
	do
	    mkdir -p ${S}/usr/share/icons/hicolor/${res}x${res}/apps
	    mv ${S}/opt/bytedance/${PN}/${PN}_${res}.* ${S}/usr/share/icons/hicolor/${res}x${res}/apps/
		rename ${PN}_${res} ${PN} ${S}/usr/share/icons/hicolor/${res}x${res}/apps/${PN}*
	done

	eapply_user
}

src_install() {
	elog "Install feishu..."
	insinto /
	doins -r opt usr

	fperms -R 755 /opt/bytedance/${PN}/bytedance-${PN}
	fperms -R 755 /opt/bytedance/${PN}/lark
}
