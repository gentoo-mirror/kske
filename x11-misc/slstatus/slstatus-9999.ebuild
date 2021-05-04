# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit desktop multilib savedconfig toolchain-funcs git-r3 autotools

DESCRIPTION="Suckless Status Tool"
HOMEPAGE="https://tools.suckless.org/slstatus/"
EGIT_REPO_URI="https://git.suckless.org/slstatus"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc64 ~x86"
IUSE="savedconfig"

RDEPEND="
	x11-libs/libX11
	x11-libs/libXft
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	x11-base/xorg-proto
"

src_prepare() {
	default
	restore_config config.h
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install

	dodoc README

	save_config config.h
}
