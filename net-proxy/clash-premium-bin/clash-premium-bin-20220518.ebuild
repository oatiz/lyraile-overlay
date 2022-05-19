# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker udev

MY_PN="clash-linux"
# convert "yyyyMMdd" to "yyyy.MM.dd"
MY_PV="${PV:0:4}.${PV:4:2}.${PV:(-2)}"

DESCRIPTION="A rule-based tunnel in Go."
HOMEPAGE="https://github.com/Dreamacro/clash"
COMMON_URI="https://release.dreamacro.workers.dev"
SRC_URI="
	v1? ( ${COMMON_URI}/${MY_PV}/${MY_PN}-amd64-${MY_PV}.gz )
	v3? ( ${COMMON_URI}/${MY_PV}/${MY_PN}-amd64-v3-${MY_PV}.gz )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+geoip +v1 v3"
REQUIRED_USE="
	v1? ( !v3 )
	|| ( v1 v3 )"

RESTRICT="mirror"

QA_PRESTRIPPED="*"
QA_PREBUILT="*"

RDEPEND="
	virtual/udev
	app-misc/yq
	geoip? ( net-misc/geoipupdate )"

S="${WORKDIR}"

src_configure() {
	if use v1 ; then
		mv "${S}/${MY_PN}-amd64-${MY_PV}" "${S}/${MY_PN}" || die
	elif use v3 ; then
		mv "${S}/${MY_PN}-amd64-v3-${MY_PV}" "${S}/${MY_PN}" || die
	fi
}

src_install() {
	udev_dorules ${FILESDIR}/99-clash.rules

	insinto /opt/clash
	doins ${FILESDIR}/clash-default "${FILESDIR}/"{setup-cgroup,setup-tun,clean-tun}.sh
	fperms 0755 "/opt/clash/"{setup-cgroup,setup-tun,clean-tun}.sh

	doinitd ${FILESDIR}/clash
	dobin clash-linux "${FILESDIR}/bypass-proxy"{,-pid}
}

pkg_postinst() {
	ewarn "To use TUN mode, net-firewall/nftables is required."
}
