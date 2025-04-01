# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

LIBOCTAGRAM_GIT_REVISION="bd12863f45fbbd5c7db06d5ec8be8987b10253bf"

DESCRIPTION="RIME〖八股文〗語法插件"
HOMEPAGE="https://github.com/lotem/librime-octagram"
SRC_URI="https://github.com/lotem/${PN}/archive/${LIBOCTAGRAM_GIT_REVISION}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

DEPEND=">=app-i18n/librime-1.6:0=
	dev-libs/utfcpp
	dev-cpp/glog"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${LIBOCTAGRAM_GIT_REVISION}"

src_prepare() {
	sed \
		-e "s/ PARENT_SCOPE//" \
		-e "\$a\\\n" \
		-e "\$aadd_library(\${plugin_modules} MODULE \${plugin_objs})" \
		-e "\$aset_target_properties(\${plugin_modules} PROPERTIES PREFIX \"\")" \
		-e "\$atarget_link_libraries(\${plugin_modules} \${plugin_deps})" \
		-e "\$ainstall(TARGETS \${plugin_modules} DESTINATION $(get_libdir)/rime-plugins)" \
		-i CMakeLists.txt || die

	sed -e "s/<utf8.h>/<utf8cpp\/utf8.h>/" -i src/*.cc || die

	cmake_src_prepare
}
