# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg

DESCRIPTION="YouTube Music bundled by pake"
HOMEPAGE="https://music.youtube.com"
SRC_URI="https://github.com/oatiz/lyraile-overlay/releases/download/tempfile/${PN}_${PV}_amd64.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
S="${WORKDIR}"

RDEPEND="
	dev-dependency/tauri-requirements
"

RESTRICT="mirror strip"

QA_PREBUILT="*"

src_install() {
  dobin "usr/bin/${PN}"
  domenu "usr/share/applications/${PN}.desktop"
}
