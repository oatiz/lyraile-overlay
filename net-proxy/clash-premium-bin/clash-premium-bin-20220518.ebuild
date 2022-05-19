# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker udev

MY_P="clash-linux-amd64-2022.05.18"

DESCRIPTION="A rule-based tunnel in Go."
HOMEPAGE="https://github.com/Dreamacro/clash"
SRC_URI="https://github.com/Dreamacro/clash/releases/download/premium/${MY_P}.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+geoip"

RESTRICT="mirror"

QA_PRESTRIPPED="*"
QA_PREBUILT="*"

RDEPEND="
	virtual/udev
	geoip? ( net-misc/geoipupdate )"

S="${WORKDIR}"

src_configure() {
	mv "${S}/${MY_P}" "${S}/clash-linux"
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
