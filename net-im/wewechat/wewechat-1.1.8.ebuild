# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker xdg

DESCRIPTION="Unofficial WeChat client built with React, MobX and Electron."
HOMEPAGE="https://github.com/trazyn/weweChat"
SRC_URI="https://gitee.com/songrendong/weweChat/attach_files/871810/download/${P}-linux-amd64.deb"

SLOT="0"
RESTRICT="strip mirror"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"

IUSE="guise"

DEPEND=""
RDEPEND="${DEPEND}
    x11-libs/gtk+
    x11-libs/libXScrnSaver
    dev-libs/nss
    gnome-base/gconf
    dev-libs/libappindicator
    x11-libs/libnotify
    x11-libs/libXtst
    guise? (
        sys-apps/bubblewrap
        sys-apps/lsb-release
    )
"
BDEPEND=""


S="${WORKDIR}"

src_install() {
    if use guise; then
        sed -i '4c Exec=/usr/bin/'${PN}' %U' ${S}/usr/share/applications/${PN}.desktop
    fi

	doins -r usr opt
	fperms 0755 /opt/${PN}/${PN}

    if use guise; then
       insinto /opt/${PN}
       doins ${FILESDIR}/uos-lsb ${FILESDIR}/uos-release

       exeinto /usr/bin
       exeopts -m0755
       doexe ${FILESDIR}/${PN}
    fi
}

pkg_postinst() {
    xdg_desktop_database_update
    xdg_icon_cache_update
}

pkg_postrm() {
    xdg_desktop_database_update
    xdg_icon_cache_update
}
