# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8
CRATES="vendor"

inherit systemd cargo git-r3 linux-info xdg desktop

_PN="asusd"

DESCRIPTION="${PN} (${_PN}) is a utility for Linux to control many aspects of various ASUS laptops."
HOMEPAGE="https://asus-linux.org"
SRC_URI="
	https://gitlab.com/asus-linux/${PN}/-/archive/${PV}/${PN}-${PV}.tar.gz
	https://vendors.retarded.farm/${PN}/vendor_${PN}_${PV%%_*}.tar.xz
"

LICENSE="MPL-2.0"
SLOT="0/4"
KEYWORDS="-* ~amd64"
IUSE="+acpi gfx gnome gui notify systemd"
REQUIRED_USE="gnome? ( gfx )"

RESTRICT="mirror"


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
S="${WORKDIR}/${PN}-${PV}"

src_unpack() {
	unpack "${PN}-${PV}".tar.gz
	# adding vendor-package
	cd "${S}" && unpack vendor_"${PN}_${PV%%_*}".tar.xz
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

	# adding vendor package config
	mkdir -p "${S}"/.cargo && cp "${FILESDIR}/${PN}"-4.3-vendor_config "${S}"/.cargo/config

	# fixing wrong relative path in asusctl/Cargo.toml
	sed -i "s~../../supergfx~../vendor/supergfx~g" "${S}"/*/Cargo.toml

	# only build rog-control-center when "gui" flag is set
	! use gui && eapply "${FILESDIR}/${PN}-${PV%%_*}"-disable_rog-cc.patch

	default
}

src_compile() {
	cargo_gen_config
	default
}

src_install() {
	insinto /etc/${_PN}
	doins data/${_PN}-ledmodes.toml

	# icons (apps)
	insinto /usr/share/icons/hicolor/512x512/apps/
	doins data/icons/*.png

	# icons (status/notify)
	insinto /usr/share/icons/hicolor/scalable/status/
	doins data/icons/scalable/*.svg

	insinto /lib/udev/rules.d/
	doins "${FILESDIR}"/*.rules

	if [ -f data/_asusctl ] && [ -d /usr/share/zsh/site-functions ]; then
		insinto /usr/share/zsh/site-functions
		doins data/_asusctl
	fi

	insinto /usr/share/dbus-1/system.d/
	doins data/${_PN}.conf

	if use systemd ; then
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
		insinto /usr/share/rog-gui/layouts
		doins rog-aura/data/layouts/*.toml

		insinto /usr/share/icons/hicolor/512x512/apps/
		doins rog-control-center/data/rog-control-center.png

		domenu rog-control-center/data/rog-control-center.desktop
		dobin target/release/rog-control-center
	fi

	# animes (apps)
	insinto /usr/share/${_PN}
	doins -r rog-anime/data/anime

	# binary
	dobin "target/release/"{asusd,asusd-user,asusctl,asus-notify}
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
