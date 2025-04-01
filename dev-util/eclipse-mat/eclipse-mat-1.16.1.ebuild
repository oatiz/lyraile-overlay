# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

MY_PN="MemoryAnalyzer"

DESCRIPTION="The stand-alone Memory Analyzer is based on Eclipse RCP"
HOMEPAGE="https://eclipse.dev/mat"
SRC_URI="https://eclipse.mirror.rafal.ca/mat/1.16.1/rcp/MemoryAnalyzer-1.16.1.20250109-linux.gtk.x86_64.zip -> ${P}.zip"

S="${WORKDIR}/mat"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""


src_install() {
	insinto /opt/eclipse-mat
	doins -r *

	make_desktop_entry "/opt/eclipse-mat/${MY_PN}" "${MY_PN}" "${MY_PN}" "Utility;"

	fperms +x "/opt/eclipse-mat/${MY_PN}"
	find "${ED}/opt/eclipse-mat/" -name '*.a' -exec chmod 644 '{}' + || die
	find "${ED}/opt/eclipse-mat/" -name '*.so' -exec chmod 644 '{}' + || die
}
