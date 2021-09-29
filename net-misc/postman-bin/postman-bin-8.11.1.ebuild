# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop eutils xdg

MY_PN="${PN/-bin/}"

DESCRIPTION="Supercharge your API workflow"
HOMEPAGE="https://www.getpostman.com"
SRC_URI="https://dl.pstmn.io/download/version/${PV}/linux64 -> ${P}-amd64.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror strip"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN^}/app"

src_prepare() {
    mv _Postman Postman
    default
}

src_install() {
    local dir="/opt/${PN}"

    insinto "${dir}"
    doins -r *
    fperms 755 "${dir}"/postman
    fperms 755 "${dir}"/Postman

    make_wrapper "${PN}" "${dir}/Postman"
    newicon "resources/app/assets/icon.png" "${PN}.png"
    make_desktop_entry "${PN}" "Postman" "${PN}" "Development;IDE;"
}

pkg_postinst() {
    xdg_desktop_database_update
    xdg_icon_cache_update
}

pkg_postrm() {
    xdg_desktop_database_update
    xdg_icon_cache_update
}
