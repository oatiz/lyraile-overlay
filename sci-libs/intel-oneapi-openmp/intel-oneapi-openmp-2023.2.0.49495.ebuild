# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

PREV_P="2023.1.0.46305"

DESCRIPTION="Intel oneAPI OpenMP runtime library"
HOMEPAGE="https://software.intel.com/content/www/us/en/develop/tools/oneapi.html"

SRC_URI="
	https://apt.repos.intel.com/oneapi/pool/main/${PN}-$(ver_cut 1-3)-$(ver_cut 4)_amd64.deb
	https://apt.repos.intel.com/oneapi/pool/main/${PN}-$(ver_cut 1-3)-$(ver_cut 1-3)-$(ver_cut 4)_amd64.deb
	https://apt.repos.intel.com/oneapi/pool/main/${PN}-common-$(ver_cut 1-3)-$(ver_cut 1-3)-$(ver_cut 4)_all.deb
	https://apt.repos.intel.com/oneapi/pool/main/intel-oneapi-runtime-openmp-$(ver_cut 1-3)-$(ver_cut 4)_amd64.deb
	https://apt.repos.intel.com/oneapi/pool/main/intel-oneapi-runtime-openmp-common-2023.1.0-46305_all.deb
"

S="${WORKDIR}"

LICENSE="ISSL"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"

QA_PREBUILT="*"
QA_TEXTRELS="*"
QA_SONAME="*"

src_prepare() {
	default
	# Drop conda stuff
	rm -r opt/intel/oneapi/conda_channel || die
}

src_install() {
	# Symlink pkgconfig and cmake files
	pushd "opt/intel/oneapi/compiler/$(ver_cut 1-3)/lib/pkgconfig" || die
	for file in *.pc; do
		dosym "../../../opt/intel/oneapi/compiler/$(ver_cut 1-3)/lib/pkgconfig/${file}" "/usr/share/pkgconfig/${file}"
	done
	popd || die

	insinto "/opt/intel/oneapi"
	doins -r "opt/intel/oneapi/compiler"

	# Create convenience symlink that does not include the version number
	dosym "$(ver_cut 1-3)" /opt/intel/oneapi/compiler/latest

	find "${ED}"/opt/intel/oneapi/compiler/$(ver_cut 1-3) -name '*.so' -exec chmod 755 '{}' + || die

	newenvd - "70intel-openmp" <<-_EOF_
			 LDPATH="${EPREFIX}/opt/intel/oneapi/compiler/$(ver_cut 1-3)/linux/compiler/lib/intel64_lin"
_EOF_
}
