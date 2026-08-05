EAPI=8

inherit git-r3

DESCRIPTION="Symlink-based file tagging system with AND/OR/NOT query support"
HOMEPAGE="https://github.com/alec/tag"
EGIT_REPO_URI="https://codeberg.org/Alechron/tag.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="
	app-shells/fish
	sys-apps/coreutils
	sys-apps/findutils
	app-text/tree
"

src_compile() {
	:
}

src_install() {
	emake DESTDIR="${ED}" PREFIX=/usr install
}
