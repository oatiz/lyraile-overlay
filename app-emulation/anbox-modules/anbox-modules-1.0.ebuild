# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

DESCRIPTION="Android kernel driver (binder, ashmem) in DKMS format"
HOMEPAGE="https://anbox.io/"

SRC_URI="https://github.com/choff/anbox-modules/archive/8148a162755bf5500a07cf41a65a02c8f3eb0af9.zip -> ${P}.zip"

KEYWORDS="~amd64"
LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
	>=sys-kernel/dkms-2.1.0
"
BDEPEND=""

# PATCHES=( "${FILESDIR}/v1.patch" )

S="${WORKDIR}/${PN}-8148a162755bf5500a07cf41a65a02c8f3eb0af9"

src_install() {
	local dir="/opt/${PN}"
	insinto ${dir}

	doins -r *

	fperms 0755 ${dir}/INSTALL.sh
}

pkg_postinst() {
	elog ""
	elog "Please run INSTALL.sh in /opt/anbox-modules"
	elog ""
	# elog "dkms add -m anbox -v 1"
	# elog "dkms build -m anbox -v 1"
	# elog "dkms install -m anbox -v 1"
}
