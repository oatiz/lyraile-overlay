# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 ecm

DESCRIPTION="Core control application."
HOMEPAGE="https://gitlab.com/corectrl/corectrl"

EGIT_REPO_URI="https://gitlab.com/${PN}/${PN}.git"
KEYWORDS="~amd64 ~x86"

LICENSE="MIT"
SLOT="0/9999"
IUSE=""
REQUIRED_USE=""

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtcharts:5
	dev-qt/qtdbus:5
	dev-qt/qtnetwork:5
	dev-qt/qtquickcontrols2:5
	dev-qt/qtwidgets:5
	dev-qt/linguist-tools:5
	kde-frameworks/kauth
	kde-frameworks/karchive
	dev-libs/botan:2
	sys-apps/hwdata
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/${PN}-install.patch"
)
