# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3

DESCRIPTION="CLI to help change the wallpaper in a more comfortable way."
HOMEPAGE="https://git.kske.dev/DieGurke/paperchanger/"
EGIT_REPO_URI="https://git.kske.dev/DieGurke/paperchanger"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	x11-misc/xwallpaper
	gnome-extra/zenity
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	newbin paperchanger.sh paperchanger
	doman paperchanger.1
}
