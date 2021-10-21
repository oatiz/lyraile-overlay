# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop eutils xdg

DESCRIPTION="Netease Cloud Music, converted from .deb package"
HOMEPAGE="https://music.163.com"
SRC_URI="https://d1.music.126.net/dmusic/${PN}_${PV}_amd64_ubuntu_20190428.deb"

LICENSE="WTFPL"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}
    app-arch/tar
    sys-devel/binutils
    x11-libs/gtk+:3
    media-video/vlc
    net-dns/avahi
    sys-auth/nss-mdns
    net-libs/libgssglue
"
S="${WORKDIR}"

src_unpack() {
    ar x ${DISTDIR}/${PN}_${PV}_amd64_ubuntu_20190428.deb
    tar -xf data.tar.xz --exclude-from=${FILESDIR}/exclude.list
}

src_prepare() {
    cc -O2 -fPIC -shared -I /usr/include/vlc/plugins/ -o libnetease-patch.so ${FILESDIR}/patch.c
    install -D -m644 libnetease-patch.so ${S}/opt/netease/${PN}/libnetease-patch.so
    install -D -m755 ${FILESDIR}/${PN}.bash ${S}/opt/netease/${PN}/${PN}.bash

    default
}

src_install() {
    insinto /
    doins -r usr opt

    fperms 755 /opt/netease/${PN}/${PN}
    fperms 755 /opt/netease/${PN}/${PN}.bash
}

pkg_postinst() {
    xdg_desktop_database_update
    xdg_icon_cache_update
}

pkg_postrm() {
    xdg_desktop_database_update
    xdg_icon_cache_update
}
