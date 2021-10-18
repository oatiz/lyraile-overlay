# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

DESCRIPTION="Deepin Version of Wine"
HOMEPAGE="https://www.deepin.org"

COMMON_URI="https://github.com/oatiz/lyraile-overlay/releases/download/tempfile"
SRC_URI="${COMMON_URI}/${PN}-i386_${PV}-1_i386.deb"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
RDEPEND="${DEPEND}
	app-arch/p7zip
	dev-db/unixODBC[abi_x86_32]
	>=media-libs/alsa-lib-1.0.16[abi_x86_32]
	>=media-libs/lcms-2.2[abi_x86_32]
	>=net-nds/openldap-2.4.7[abi_x86_32]
	>=media-sound/mpg123-1.13.7[abi_x86_32]
	>=media-libs/openal-1.14[abi_x86_32]
	>=net-libs/libpcap-0.9.8[abi_x86_32]
	net-libs/gnutls[abi_x86_32]
	net-print/cups[abi_x86_32]
	media-sound/pulseaudio[abi_x86_32]
	media-libs/glu[abi_x86_32]
	media-libs/mesa[abi_x86_32,osmesa]
	media-libs/freetype[abi_x86_32]
	media-libs/libv4l[abi_x86_32]
	media-libs/libpng[abi_x86_32]
	media-libs/tiff[abi_x86_32]
	media-sound/gsm[abi_x86_32]
	dev-libs/udis86[abi_x86_32]
	dev-libs/libxml2[abi_x86_32]
	dev-libs/libxslt[abi_x86_32]
	media-libs/fontconfig[abi_x86_32]
	x11-libs/libXcursor[abi_x86_32]
	x11-libs/libXrandr[abi_x86_32]
	x11-libs/libXinerama[abi_x86_32]
	x11-libs/libXcomposite[abi_x86_32]
	sys-apps/dbus[abi_x86_32]
	sys-devel/gettext[abi_x86_32]
	virtual/jpeg[abi_x86_32]
	virtual/opencl[abi_x86_32]
	virtual/libusb:1[abi_x86_32]
	|| ( sys-libs/ncurses:5[abi_x86_32] sys-libs/ncurses-compat:5[abi_x86_32] )
	sys-libs/zlib[abi_x86_32]"

S=${WORKDIR}

src_install() {
	insinto /
	doins -r usr

	fperms 755 -R /usr/bin/
	fperms 755 -R /usr/lib/
}
