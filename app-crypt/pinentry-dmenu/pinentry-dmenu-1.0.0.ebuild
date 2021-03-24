# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Passphrase entry dialog based on dmenu"
HOMEPAGE="https://git.kske.dev/kske/gentoo-overlay"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=app-eselect/eselect-pinentry-0.7.2
	x11-misc/dmenu"

S="${FILESDIR}"

src_install() {
	newbin pinentry-dmenu-${PV} pinentry-dmenu
}
