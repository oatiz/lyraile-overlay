# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit java-vm-2

MY_PV=${PV/./u}
SLOT=$(ver_cut 1)

SRC_URI="https://github.com/oatiz/lyraile-overlay/releases/download/tempfile/jdk-${MY_PV}-linux-x64.tar.gz"

DESCRIPTION="Oracle's Java SE Development Kit"
HOMEPAGE="http://www.oracle.com/technetwork/java/javase/"
LICENSE="OTN"
KEYWORDS="-* ~amd64"
IUSE="alsa cups headless-awt selinux +source"
QA_PREBUILT="*"

RDEPEND="
	>=sys-apps/baselayout-java-0.1.0-r1
	kernel_linux? (
		media-libs/fontconfig:1.0
		media-libs/freetype:2
		media-libs/harfbuzz
		elibc_glibc? ( >=sys-libs/glibc-2.2.5:* )
		elibc_musl? ( sys-libs/musl )
		sys-libs/zlib
		alsa? ( media-libs/alsa-lib )
		cups? ( net-print/cups )
		selinux? ( sec-policy/selinux-java )
		!headless-awt? (
			x11-libs/libX11
			x11-libs/libXext
			x11-libs/libXi
			x11-libs/libXrender
			x11-libs/libXtst
		)
	)"

RESTRICT="preserve-libs splitdebug mirror"
QA_PREBUILT="*"

S="${WORKDIR}/jdk1.8.0_${PV/8./}"

src_install() {
	local dest="/opt/${P}"
	local ddest="${ED}/${dest#/}"

	# on macOS if they would exist they would be called .dylib, but most
	# importantly, there are no different providers, so everything
	# that's shipped works.
	if [[ ${A} != *_mac_* ]] ; then
		# this does not exist on arm64 hence -f
		rm -fv jre/lib/*/libfreetype.so* || die

		if ! use alsa ; then
			rm -v jre/lib/*/libjsoundalsa.so* || die
		fi

		if use headless-awt ; then
			rm -fvr {,jre/}lib/*/lib*{[jx]awt,splashscreen}* \
				{,jre/}bin/policytool bin/appletviewer || die
		fi
	fi

	if ! use source ; then
		rm -v src.zip || die
	fi

	rm -v jre/lib/security/cacerts || die
	dosym ../../../../../etc/ssl/certs/java/cacerts \
		"${dest}"/jre/lib/security/cacerts

	dodir "${dest}"
	cp -pPR * "${ddest}" || die

	# provide stable symlink
	dosym "${P}" "/opt/${PN}-${SLOT}"

	java-vm_install-env "${FILESDIR}"/${PN}-${SLOT}.env.sh
	java-vm_set-pax-markings "${ddest}"
	java-vm_revdep-mask
	java-vm_sandbox-predict /dev/random /proc/self/coredump_filter
}

pkg_postinst() {
	java-vm-2_pkg_postinst
}