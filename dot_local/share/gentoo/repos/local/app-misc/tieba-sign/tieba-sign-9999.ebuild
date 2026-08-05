EAPI=8

inherit git-r3 go-module systemd

DESCRIPTION="Baidu Tieba auto sign-in tool"
HOMEPAGE="https://codeberg.org/Alechron/tieba-sign-go"
EGIT_REPO_URI="https://codeberg.org/Alechron/tieba-sign-go.git"

LICENSE="MIT"
SLOT="0"
IUSE="systemd"

RESTRICT="network-sandbox"
BDEPEND=">=dev-lang/go-1.24.1"

S="${WORKDIR}/${P}/src"

src_install() {
	dobin tieba-sign

	if use systemd; then
		systemd_douserunit "${WORKDIR}/${P}/packaging/common/systemd/tieba-sign.service"
		systemd_douserunit "${WORKDIR}/${P}/packaging/common/systemd/tieba-sign.timer"
	fi
}

pkg_postinst() {
	if use systemd; then
		elog "Enable and start the user timer:"
		elog "  systemctl --user enable tieba-sign.timer"
		elog "  systemctl --user start tieba-sign.timer"
	else
		elog "To schedule automatic sign-in, add a cron job, e.g.:"
		elog "  crontab -e"
		elog "  @hourly /usr/bin/tieba-sign"
	fi
	elog
	elog "Config file: ~/.config/tieba-sign/config.toml"
}
