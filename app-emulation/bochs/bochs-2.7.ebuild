# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="LGPL-ed pc emulator"
HOMEPAGE="http://bochs.sourceforge.net/"

SRC_URI="mirror://sourceforge/bochs/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""

IUSE=""
REQUIRED_USE=""

RDEPEND="
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXpm
	x11-base/xorg-proto
	sys-libs/readline:=
	sys-libs/ncurses:=
	sys-apps/sed
	>=app-text/opensp-1.5
"

DEPEND="${RDEPEND}
"

src_prepare() {
	default
	sed -i "s:^docdir.*:docdir = ${EPREFIX}/usr/share/doc/${PF}:" \
		Makefile.in || die
	sed -i 's/^LIBS = /LIBS = -lpthread/g' Makefile.in || die
	sed -i 's/2\.6\*|3\.\*)/2.6*|3.*|4.*)/' configure*
}

src_configure() {
	econf \
		--prefix=/usr \
		--without-wx \
		--with-x11 \
		--with-x \
		--with-term \
		--disable-docbook \
		--enable-cpu-level=6 \
		--enable-fpu \
		--enable-3dnow \
		--enable-disasm \
		--enable-smp \
		--enable-x86-64 \
		--enable-avx \
		--enable-evex \
		--enable-long-phy-address \
		--enable-disasm \
		--enable-pcidev \
		--enable-usb \
		--enable-debugger
		#--with-sdl
		#--enable-x86-debugger
		#--enable-all-optimizations
		#--enable-plugins

}
