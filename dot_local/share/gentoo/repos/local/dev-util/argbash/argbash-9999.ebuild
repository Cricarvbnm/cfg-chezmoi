EAPI=8

inherit git-r3

DESCRIPTION="Bash argument parsing code generator"
HOMEPAGE="https://argbash.dev"
EGIT_REPO_URI="https://github.com/matejak/argbash.git"

LICENSE="BSD"
SLOT="0"

BDEPEND="
	>=dev-build/autoconf-2.63
	>=dev-python/docutils-0.16
"

RDEPEND=">=app-shells/bash-3.0"

S="${WORKDIR}/${P}/resources"

src_prepare() {
	default

	# Fix m4dir path: make install hardcodes prefix, use EROOT
	sed -Ei 's#m4dir=/\$\(PREFIXED_LIBDIR\)#m4dir=/\$(EROOT)usr/lib#' Makefile ||
		die "sed m4dir failed"

	# Gentoo installs docutils' rst2man as rst2man.py
	sed -Ei 's#rst2man #rst2man.py #' Makefile ||
		die "sed rst2man.py failed"
}

src_install() {
	emake ROOT="${ED}" PREFIX="/usr" altinstall

	cd "${WORKDIR}/${P}" || die
	einstalldocs
}
