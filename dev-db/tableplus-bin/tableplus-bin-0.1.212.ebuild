# Copyright 2017-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop wrapper xdg

MY_PN="${PN/-bin/}"

DESCRIPTION="Modern, native, and friendly GUI tool for relational databases"
HOMEPAGE="https://tableplus.com"
SRC_URI="https://deb.tableplus.com/debian/22/pool/main/t/${MY_PN}/${MY_PN}_${PV}_amd64.deb
		http://archive.ubuntu.com/ubuntu/pool/main/c/cyrus-sasl2/libsasl2-2_2.1.28+dfsg-6ubuntu2_amd64.deb
		http://archive.ubuntu.com/ubuntu/pool/main/o/openldap/libldap-2.5-0_2.5.13+dfsg-1ubuntu1_amd64.deb
		https://archive.archlinux.org/packages/g/glib2/glib2-2.68.4-1-x86_64.pkg.tar.zst
"
RESTRICT="mirror"

LICENSE="tableplus-EULA"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="
	gnome-base/gnome-keyring
	x11-libs/gtksourceview:3.0
	dev-libs/libgee
"

S="${WORKDIR}"
QA_PREBUILT="*"

src_prepare() {
	default

	[[ -d "${S}"/opt/"${MY_PN}"/lib64 ]] || mkdir -p "${S}"/opt/"${MY_PN}"/lib64 || die
	mv "${S}/usr/lib/x86_64-linux-gnu/"{liblber-2.5.so.0,libldap-2.5.so.0,libsasl2.so.2} \
	   "${S}"/opt/"${MY_PN}"/lib64/ || die
	mv "${S}/usr/lib/libgio-2.0.so.0.6800.4" "${S}"/opt/"${MY_PN}"/lib64/ || die

	if [ -e "${S}"/opt/"${MY_PN}"/"${MY_PN}".desktop ]; then
		rm "${S}"/opt/"${MY_PN}"/"${MY_PN}".desktop || die
	fi
}

src_install() {
	local dir="/opt/${MY_PN}"
	local _dir="opt/${MY_PN}"

	insinto "/opt"
	doins -r "${_dir}"

	fperms 0755 "${dir}/${MY_PN}"

	make_wrapper "${PN}" "${dir}/${MY_PN}" "" "${dir}/lib64" ""
	newicon -s 128 "${_dir}"/resource/image/logo.png "${MY_PN}".png
	make_desktop_entry "${PN}" "${MY_PN}" "${MY_PN}" "Development;IDE"
}
