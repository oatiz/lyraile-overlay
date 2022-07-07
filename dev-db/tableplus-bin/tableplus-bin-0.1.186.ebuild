# Copyright 2017-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop wrapper xdg

_PN="${PN/-bin/}"

DESCRIPTION="Modern, native, and friendly GUI tool for relational databases (Alpha)"
HOMEPAGE="https://tableplus.com"
SRC_URI="https://deb.tableplus.com/debian/21/pool/main/t/${_PN}/${_PN}_${PV}_amd64.deb
		http://archive.ubuntu.com/ubuntu/pool/main/o/openldap/libldap-2.5-0_2.5.6+dfsg-1~exp1ubuntu1_amd64.deb
		http://archive.ubuntu.com/ubuntu/pool/main/c/cyrus-sasl2/libsasl2-2_2.1.27+dfsg-2.1build1_amd64.deb
		https://archive.archlinux.org/packages/g/glib2/glib2-2.68.4-1-x86_64.pkg.tar.zst
"
RESTRICT="mirror"

LICENSE="custom"
SLOT="0"
KEYWORDS="-* ~amd64"

IUSE=""
REQUIRED_USE=""

DEPEND=""
RDEPEND="
	${DEPEND}
"

S="${WORKDIR}"
QA_PREBUILT="*"

src_prepare() {
	default

	rm -rf "${S}"/usr/share || die

	[[ -d "${S}"/opt/"${_PN}"/lib64 ]] || mkdir -p "${S}"/opt/"${_PN}"/lib64 || die
	mv "${S}"/usr/lib/x86_64-linux-gnu/* "${S}"/opt/"${_PN}"/lib64/ || die
	mv "${S}"/usr/lib/libgio-2.0.so* "${S}"/opt/"${_PN}"/lib64/ || die

	[[ -e "${S}"/opt/"${_PN}"/"${_PN}".desktop ]] && rm "${S}"/opt/"${_PN}"/"${_PN}".desktop
}

src_install() {
	local dir="/opt/${_PN}"
	local _dir="opt/${_PN}"

	insinto "/opt"
	doins -r "${_dir}"

	fperms 0755 "${dir}"/${_PN}

	make_wrapper "${PN}" "${dir}/${_PN}" "" "${dir}/lib64" ""
	newicon -s 128 "${_dir}"/resource/image/logo.png "${_PN}".png
	make_desktop_entry "${PN}" "${_PN}" "${_PN}" "Development;IDE"
}
