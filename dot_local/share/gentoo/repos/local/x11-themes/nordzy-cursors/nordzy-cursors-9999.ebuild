EAPI=8

inherit git-r3

DESCRIPTION="Cursor theme using the Nord color palette and based on Vimix and cz-Viator."
HOMEPAGE="https://gitlab.com/gboehm/Nordzy-cursors"
EGIT_REPO_URI="https://gitlab.com/gboehm/Nordzy-cursors.git"

LICENSE="GPL-3"
SLOT="0"

BACKEND="+xcursor +hyprcursor"
PALETTE=$(echo +catppuccin-{latte,frappe,macchiato,mocha} +white)
COLOR="+dark +light \
+rosewater +flamingo \
+pink +mauve \
+red +marron +peach +yellow \
+green +teal +sky +sapphire +blue +lavender"
HAND="lefthand +righthand"
IUSE="${BACKEND} \
${PALETTE} +black \
${COLOR} \
${HAND}"

src_install() {
	__should_install() {
		# Backend
		if ! use hyprcursor; then
			if [[ $1 == *hyprcursors/* ]]; then
				return 1
			fi
		fi
		if ! use xcursor; then
			if [[ $1 == *xcursors/* ]]; then
				return 1
			fi
		fi

		# Hand
		if ! use lefthand; then
			if [[ $1 == *lefthand* ]]; then
				return 1
			fi
		fi
		if ! use righthand; then
			if [[ $1 != *lefthand ]]; then
				return 1
			fi
		fi

		# Pallette
		for x in ${PALETTE}; do
			t=${x#+}
			if ! use "${t}"; then
				if [[ $1 == *"${t}"* ]]; then
					return 1
				fi
			fi
		done
		if ! use black; then
			if [[ $1 == *cursors || $1 == *cursors-lefthand ]]; then
				return 1
			fi
		fi

		# Color
		for x in ${COLOR}; do
			t=${x#+}
			if ! use "${t}"; then
				if [[ $1 == *"${t}"* ]]; then
					return 1
				fi
			fi
		done
	}

	target_dir="${ED}"/usr/share/icons
	mkdir -p "${target_dir}" || die
	find "${S}"/{xcursors,hyprcursors/themes} -type d -mindepth 1 -maxdepth 1 | while read theme_path; do
		if __should_install "${theme_path}"; then
			cp -r "${theme_path}" "${target_dir}" || die
		fi
	done
}
