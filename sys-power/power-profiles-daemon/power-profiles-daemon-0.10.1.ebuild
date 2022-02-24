# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson systemd

DESCRIPTION="Makes power profiles handling available over D-Bus."
HOMEPAGE="https://gitlab.freedesktop.org/hadess/power-profiles-daemon"
SRC_URI="https://gitlab.freedesktop.org/hadess/${PN}/-/archive/${PV}/${PN}-${PV}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
IUSE="doc +systemd"

KEYWORDS="~amd64"

BDEPEND=">=dev-libs/libgudev-234
	>=sys-auth/polkit-0.114
	sys-power/upower
"
DEPEND="${BDEPEND}"

src_configure() {
	local emesonargs=(
		$(meson_use doc gtk_doc)
	)
	if use systemd ; then
		meson_src_configure
	else
		meson_src_configure -Dsystemdsystemunitdir=disable
	fi
}

src_install() {
	meson_src_install
	if use systemd ; then
		systemd_enable_service multi-user.target ${PN}.service
	else
		doinitd ${FILESDIR}/${PN}
	fi
}

pkg_postinst() {
	ewarn "Don't forget to enable \"${PN}\" service, by runnning:"
	ewarn "systemctl daemon-reload && systemctl enable --now ${PN}"
}
