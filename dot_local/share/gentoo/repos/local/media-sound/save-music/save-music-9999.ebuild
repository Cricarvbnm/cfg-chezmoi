EAPI=8

inherit git-r3

DESCRIPTION="Download music and LRC lyrics from URLs/paths with optional normalization and MP3 ID3 tagging"
HOMEPAGE="https://codeberg.org/Alechron/save-music"
EGIT_REPO_URI="https://codeberg.org/Alechron/save-music.git"

LICENSE="MIT"
SLOT="0"

BDEPEND="
	dev-util/argbash
	dev-util/pkgconf
"

RDEPEND="
	app-shells/bash
	net-misc/curl
	media-video/ffmpeg
	media-sound/ffmpeg-normalize
	media-sound/kid3
"

src_install() {
	emake DESTDIR="${ED}" PREFIX="/usr" install
}
