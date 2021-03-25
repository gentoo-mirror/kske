# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN/-bin/}"

inherit pax-utils unpacker xdg

DESCRIPTION="Desktop application for Jitsi Meet built with Electron"
HOMEPAGE="https://github.com/jitsi/jitsi-meet-electron"
SRC_URI="https://github.com/jitsi/jitsi-meet-electron/releases/download/v${PV}/jitsi-meet-amd64.deb -> ${P}.deb"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="
	app-accessibility/at-spi2-atk
	app-accessibility/at-spi2-core
	dev-libs/atk
	dev-libs/expat
	dev-libs/glib
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa[X(+)]
	net-print/cups
	sys-apps/dbus[X]
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3[X]
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-libs/pango
	|| (
		media-sound/pulseaudio
		media-sound/apulse
	)
"

S="${WORKDIR}"

src_prepare() {
	default
	sed -e 's| --no-sandbox||g' \
		-i usr/share/applications/jitsi-meet.desktop || die
	unpack usr/share/doc/jitsi-meet-electron/changelog.gz
}

src_install() {
	insinto /
	dodoc changelog
	doins -r opt
	insinto /usr/share

	if has_version media-sound/apulse[-sdk] && ! has_version media-sound/pulseaudio; then
		sed -i 's/Exec=/Exec=apulse /g' usr/share/applications/jitsi-meet.desktop || die
	fi

	doins -r usr/share/applications
	doins -r usr/share/icons
	fperms +x "/opt/Jitsi Meet/jitsi-meet" "/opt/Jitsi Meet/chrome-sandbox"
	fperms u+s "/opt/Jitsi Meet/chrome-sandbox"
	pax-mark m "/opt/Jitsi Meet/jitsi-meet" "/opt/Jitsi Meet/chrome-sandbox"

	dosym "../../opt/Jitsi Meet/${MY_PN}" "/usr/bin/${MY_PN}"
}
