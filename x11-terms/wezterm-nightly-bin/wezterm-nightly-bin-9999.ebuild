# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg

MY_PN="${PN/-bin/}"

DESCRIPTION="Bleeding edge builds of a GPU-accelerated cross-platform terminal emulator and multiplexer implemented in Rust"
HOMEPAGE="https://wezfurlong.org/wezterm"
SRC_URI="https://github.com/wez/wezterm/releases/download/nightly/${MY_PN}.Ubuntu20.04.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}
    sys-apps/dbus
    media-libs/fontconfig
    x11-themes/hicolor-icon-theme
    x11-libs/libX11
    x11-libs/libxkbcommon[X]
    x11-libs/xcb-util-image
    x11-libs/xcb-util-keysyms
    x11-libs/xcb-util-wm
"

S="${WORKDIR}"

src_install() {
    insinto /
    doins -r etc usr

    fperms 755 /usr/bin/strip-ansi-escapes
    fperms 755 /usr/bin/wezterm
    fperms 755 /usr/bin/wezterm-gui
    fperms 755 /usr/bin/wezterm-mux-server
}

