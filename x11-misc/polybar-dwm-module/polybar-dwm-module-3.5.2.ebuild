# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )
POLYBAR_DWM_MODULE_COMMIT="0c3e139ac54e081c06ef60548927e679d80d4297"
XPP_COMMIT="044e69d05db7f89339bda1ccd1efe0263b01c8f6"
I3IPCPP_COMMIT="cb008b30fc5f3febfe467884cb0211ee3c16386b"
DWMIPCPP_COMMIT="6b6947fd63845c8239f0a895be695bf206eaae6d"

inherit cmake python-single-r1

DESCRIPTION="A fast and easy-to-use tool for creating status bars"
HOMEPAGE="https://github.com/mihirlad55/polybar-dwm-module"
SRC_URI="https://github.com/mihirlad55/${PN}/archive/${POLYBAR_DWM_MODULE_COMMIT}.tar.gz -> ${P}.tar.gz
	https://github.com/polybar/xpp/archive/${XPP_COMMIT}.tar.gz -> xpp-${XPP_COMMIT}.tar.gz
	https://github.com/polybar/i3ipcpp/archive/${I3IPCPP_COMMIT}.tar.gz -> i3ipcpp-${I3IPCPP_COMMIT}.tar.gz
	https://github.com/mihirlad55/dwmipcpp/archive/${DWMIPCPP_COMMIT}.tar.gz -> dwmipcpp-${DWMIPCPP_COMMIT}.tar.gz"

KEYWORDS="amd64 x86"
LICENSE="MIT"
SLOT="0"
IUSE="alsa curl doc i3wm dwm ipc mpd network pulseaudio"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep 'x11-base/xcb-proto[${PYTHON_USEDEP}]')
	x11-libs/cairo[X,xcb(+)]
	x11-libs/libxcb[xkb]
	x11-libs/xcb-util-image
	x11-libs/xcb-util-wm
	x11-libs/xcb-util-xrm
	alsa? ( media-libs/alsa-lib )
	curl? ( net-misc/curl )
	doc? ( dev-python/sphinx )
	i3wm? (
		dev-libs/jsoncpp:=
		|| ( x11-wm/i3 x11-wm/i3-gaps )
	)
	mpd? ( media-libs/libmpdclient )
	network? ( net-wireless/wireless-tools )
	pulseaudio? ( media-sound/pulseaudio )
"

RDEPEND="${DEPEND}"

src_unpack() {
	if [[ -n ${A} ]]; then
		unpack ${A}
	fi

	# commit version package rename to real version package
	mv "${WORKDIR}/${PN}-${POLYBAR_DWM_MODULE_COMMIT}" "${S}" || die
}

src_prepare() {

	rmdir "${S}/lib/xpp" || die
	mv "${WORKDIR}/xpp-${XPP_COMMIT}" "${S}/lib/xpp" || die

	rmdir "${S}/lib/i3ipcpp" || die
	mv "${WORKDIR}/i3ipcpp-${I3IPCPP_COMMIT}" "${S}/lib/i3ipcpp" || die

	rmdir "${S}/lib/dwmipcpp" || die
	mv "${WORKDIR}/dwmipcpp-${DWMIPCPP_COMMIT}" "${S}/lib/dwmipcpp" || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_ALSA="$(usex alsa)"
		-DENABLE_CURL="$(usex curl)"
		-DBUILD_DOC="$(usex doc)"
		-DENABLE_I3="$(usex i3wm)"
		-DENABLE_DWM="$(usex dwm)"
		-DBUILD_IPC_MSG="$(usex ipc)"
		-DENABLE_MPD="$(usex mpd)"
		-DENABLE_NETWORK="$(usex network)"
		-DENABLE_PULSEAUDIO="$(usex pulseaudio)"
		# Bug 767949
		-DENABLE_CCACHE="OFF"
	)

	cmake_src_configure
}
