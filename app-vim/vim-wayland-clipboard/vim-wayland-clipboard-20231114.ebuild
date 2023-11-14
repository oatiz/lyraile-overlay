# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit vim-plugin

DESCRIPTION="vim plugin: soothing pastel theme for Vim "
HOMEPAGE="https://github.com/catppuccin/vim"

EGIT_COMMIT="6d0c9f8e7deac8a90c51d4c1e69068cb86361933"
SRC_URI="https://github.com/jasonccox/vim-wayland-clipboard/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror"

LICENSE="MIT"
KEYWORDS="~amd64"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"
