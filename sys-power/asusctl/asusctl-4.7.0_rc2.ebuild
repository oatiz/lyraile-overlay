# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

CRATES=" "
inherit systemd cargo linux-info udev xdg desktop

_PV=${PV//_rc/-RC}
_PVV=`[[ ${_PV} =~ .*"RC".* ]] && echo || echo ${_PV}`
_PN="asusd"

DESCRIPTION="A utility for Linux to control many aspects of various ASUS laptops."
HOMEPAGE="https://asus-linux.org"
SRC_URI="
	https://gitlab.com/asus-linux/${PN}/-/archive/${_PV}/${PN}-${_PV}.tar.bz2
	https://gitlab.com/asus-linux/${PN}/uploads/9b2269a1984a42b6e14c19be06de4a76/vendor_${PN}.tar.xz ->
vendor_${PN}_${_PV}.tar.xz
	${CARGO_CRATE_URIS}
"
LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"
IUSE="+acpi systemd"

RDEPEND="
	acpi? ( sys-power/acpi_call )
	dev-libs/libappindicator:3
	>=sys-power/power-profiles-daemon-0.10.0
"
DEPEND="${RDEPEND}
	>=virtual/rust-1.51.0
	>=sys-devel/llvm-10.0.1
	>=sys-devel/clang-runtime-10.0.1
	dev-libs/libusb:1
	systemd? ( sys-apps/systemd:0= )
	sys-apps/dbus
	media-libs/sdl2-gfx
"
S="${WORKDIR}/${PN}-${_PV/_/-}"

src_unpack() {
	cargo_src_unpack
	unpack "${PN}"-"${_PV/_/.}".tar.bz2
	sed -i "1s/.*/Version=\"${_PV}\"/" "${S}"/Makefile

	# adding vendor-package
	cd "${S}" && unpack vendor_"${PN}"_"${_PV%%_*}".tar.xz
}

src_prepare() {
	require_configured_kernel

	# checking for touchpad dependencies
	k_wrn_touch=""
	linux_chkconfig_present I2C_HID_CORE || \
		k_wrn_touch="${k_wrn_touch}> CONFIG_I2C_HID_CORE not found, should be either builtin or build as module\n"
	linux_chkconfig_present I2C_HID_ACPI || \
		k_wrn_touch="${k_wrn_touch}> CONFIG_I2C_HID_ACPI not found, should be either builtin or build as module\n"
	linux_chkconfig_present HID_ASUS || \
		k_wrn_touch="${k_wrn_touch}> CONFIG_HID_ASUS not found, should be either builtin or build as module\n"
	linux_chkconfig_builtin PINCTRL_AMD || \
		k_wrn_touch="${k_wrn_touch}> CONFIG_PINCTRL_AMD not found, must be builtin\n"
	[[ ${k_wrn_touch} != "" ]] && \
		ewarn "\nKernel configuration issue(s), needed for touchpad support:\n\n${k_wrn_touch}"

	# adding vendor package config
	mkdir -p "${S}"/.cargo && cp "${FILESDIR}"/"${P}"-vendor_config "${S}"/.cargo/config

	default
}

src_compile() {
	cargo_gen_config
	cargo_src_compile
}

src_install() {
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

	systemd_dounit data/${_PN}.service
	systemd_douserunit data/${_PN}-user.service
	newinitd "${FILESDIR}"/openrc/${_PN}.initd ${_PN}

	if use acpi; then
		insinto /etc/modules-load.d
		doins "${FILESDIR}"/90-acpi_call.conf
	fi

	insinto /usr/share/icons/hicolor/512x512/apps/
	doins rog-control-center/data/rog-control-center.png
	domenu rog-control-center/data/rog-control-center.desktop
	dobin target/release/rog-control-center

	insinto /usr/share/rog-gui/layouts/
	find "${S}/rog-aura/data/layouts" -type f -name "*.ron" -exec doins '{}' +

	# animes (apps)
	insinto /usr/share/asusd/
	find "rog-anime/data/anime" -type f -exec doins "{}" +

	# binary
	dobin "target/release/"{asusd,asusd-user,asusctl}
}

pkg_postinst() {
	xdg_icon_cache_update
	udev_reload
}

pkg_postrm() {
	xdg_icon_cache_update
	udev_reload
}
