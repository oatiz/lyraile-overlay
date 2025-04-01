# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit rpm

MY_PN=${PN/-bin}
S_DIR="usr/lib/oracle/11.2/client64"

DESCRIPTION="Oracle Database Programming Interface for Drivers and Applications"
HOMEPAGE="https://github.com/oracle/odpi"
SRC_URI="
	oracle-instantclient11.2-basic-11.2.0.4.0-1.x86_64.rpm
	oracle-instantclient11.2-sqlplus-11.2.0.4.0-1.x86_64.rpm
"

S="${WORKDIR}"

LICENSE="OTN"
SLOT="0"
KEYWORDS="~amd64"

QA_PREBUILT="*"

pkg_nofetch() {
	ewarn "\e[1;33m# Please download 'x64 Compressed Archive' file from following url:		                                                # \e[0m"
	ewarn "\e[1;33m# https://download.oracle.com/otn/linux/instantclient/11204/oracle-instantclient11.2-basic-11.2.0.4.0-1.x86_64.rpm		# \e[0m"
	ewarn "\e[1;33m# https://download.oracle.com/otn/linux/instantclient/11204/oracle-instantclient11.2-sqlplus-11.2.0.4.0-1.x86_64.rpm		# \e[0m"
}

src_prepare() {
	default

	local so_files=(
		"libclntsh.so.11.1"
		"libnnz11.so"
		"libocci.so.11.1"
		"libociei.so"
		"libocijdbc11.so"
		"libsqlplus.so"
		"libsqlplusic.so"
	)

	for file in "${so_files[@]}"; do
		patchelf --set-rpath '$ORIGIN' "${S}/${S_DIR}/lib/${file}" || die
	done

	find "${S}/${S_DIR}/bin" -type f | xargs -I {} patchelf --set-rpath '$ORIGIN:$ORIGIN/../lib' {} || die
}

src_install() {
	insinto "/opt/${MY_PN}"
	doins -r "${S_DIR}/lib"
	doins -r "${S_DIR}/bin"

	dosym -r "/opt/${MY_PN}/lib/libclntsh.so.11.1" "/opt/${MY_PN}/lib/libclntsh.so"

	fperms +x "/opt/${MY_PN}/bin/adrci" "/opt/${MY_PN}/bin/genezi" "/opt/${MY_PN}/bin/sqlplus"

	dosym -r "/opt/${MY_PN}/bin/sqlplus" /usr/bin/sqlplus
}
