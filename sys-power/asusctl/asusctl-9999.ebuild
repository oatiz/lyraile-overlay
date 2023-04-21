# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

inherit cargo systemd git-r3 linux-info xdg desktop

_PN="asusd"

DESCRIPTION="${PN} (${_PN}) is a utility for Linux to control many aspects of various ASUS laptops."
HOMEPAGE="https://asus-linux.org"

EGIT_REPO_URI="https://gitlab.com/asus-linux/${PN}.git"

LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD BSD-2 Boost-1.0 ISC LicenseRef-UFL-1.0 MIT MPL-2.0 OFL-1.1 Unicode-DFS-2016 Unlicense ZLIB"
SLOT="9999"
KEYWORDS="-* ~amd64"
IUSE="+acpi gfx gnome gui notify systemd"
REQUIRED_USE="gnome? ( gfx )"

RESTRICT="mirror strip"

RDEPEND="!!sys-power/rog-core
	!!sys-power/asus-nb-ctrl
	acpi? ( sys-power/acpi_call )
	>=sys-power/power-profiles-daemon-0.10.0
"

DEPEND="${RDEPEND}
	>=virtual/rust-1.51.0
	>=sys-devel/llvm-10.0.1
	>=sys-devel/clang-runtime-10.0.1
	dev-libs/libusb:1
	gfx? (
		!sys-kernel/gentoo-g14-next
		>=sys-power/supergfxctl-2.0.0[gnome?]
	)
	gnome? ( gnome-extra/gnome-shell-extension-asusctl-gex:0/4 )
	systemd? ( sys-apps/systemd:0= )
	sys-apps/dbus
"

src_unpack() {
	default
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_prepare() {
	require_configured_kernel

	# checking for touchpad dependencies
	k_wrn_touch=""
	linux_chkconfig_present I2C_HID_CORE || k_wrn_touch="${k_wrn_touch}> CONFIG_I2C_HID_CORE not found, should be either builtin or build as module\n"
	linux_chkconfig_present I2C_HID_ACPI || k_wrn_touch="${k_wrn_touch}> CONFIG_I2C_HID_ACPI not found, should be either builtin or build as module\n"
	linux_chkconfig_present HID_ASUS || k_wrn_touch="${k_wrn_touch}> CONFIG_HID_ASUS not found, should be either builtin or build as module\n"
	linux_chkconfig_present PINCTRL_AMD || k_wrn_touch="${k_wrn_touch}> CONFIG_PINCTRL_AMD not found, should be either builtin or build as module\n"
	[[ ${k_wrn_touch} != "" ]] && ewarn "\nKernel configuration issue(s), needed for touchpad support:\n\n${k_wrn_touch}"

	default
}

src_compile() {
	cargo_gen_config
	default
}

src_install() {
	keepdir /etc/asusd/
	keepdir /usr/share/asusd

	# icons (apps)
	insinto /usr/share/icons/hicolor/512x512/apps/
	doins data/icons/*.png

	# icons (status/notify)
	insinto /usr/share/icons/hicolor/scalable/status/
	doins data/icons/scalable/*.svg

	insinto /lib/udev/rules.d/
	doins "${FILESDIR}"/*.rules

	# LED config
	insinto /usr/share/asusd/
	doins rog-aura/data/aura_support.ron

	if [ -f data/_asusctl ] && [ -d /usr/share/zsh/site-functions ]; then
		insinto /usr/share/zsh/site-functions
		doins data/_asusctl
	fi

	insinto /usr/share/dbus-1/system.d/
	doins data/${_PN}.conf

	if use systemd; then
		systemd_dounit data/${_PN}.service
		systemd_douserunit data/${_PN}-user.service
		use notify && systemd_douserunit data/asus-notify.service
	else
		doinitd "${FILESDIR}"/openrc/${_PN}
		doinitd "${FILESDIR}"/openrc/${_PN}-user
		use notify && doinitd "${FILESDIR}"/openrc/asus-notify
	fi

	if use acpi; then
		insinto /etc/modules-load.d
		doins "${FILESDIR}"/90-acpi_call.conf
	fi

	if use gui; then
		insinto /usr/share/rog-gui/layouts/
		find "${S}/rog-aura/data/layouts" -type f -name "*.ron" -exec doins '{}' +

		insinto /usr/share/icons/hicolor/512x512/apps/
		doins rog-control-center/data/rog-control-center.png

		domenu rog-control-center/data/rog-control-center.desktop
		dobin target/release/rog-control-center
	fi

	# animes (apps)
	insinto /usr/share/asusd/anime
	find "rog-anime/data/anime" -type f -exec doins "{}" +

	# binary
	dobin "target/release/"{asusd,asusd-user,asusctl}
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
