# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit vim-plugin

DESCRIPTION="vim plugin: soothing pastel theme for Vim "
HOMEPAGE="https://github.com/catppuccin/vim"

EGIT_COMMIT="be4725cfc3fb6ed96f706d9d1bd5baa24d2b048c"
SRC_URI="https://github.com/catppuccin/vim/archive/${EGIT_COMMIT}.tar.gz -> ${P}-vim.tar.gz"

RESTRICT="mirror"

LICENSE="MIT"
KEYWORDS="~amd64"

VIM_PLUGIN_HELPFILES="catppuccin"
S="${WORKDIR}/vim-${EGIT_COMMIT}"
