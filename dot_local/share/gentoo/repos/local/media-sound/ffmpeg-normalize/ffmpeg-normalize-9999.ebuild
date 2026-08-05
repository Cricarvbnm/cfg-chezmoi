EAPI=8

PYTHON_COMPAT=(python3_{10..14})
DISTUTILS_USE_PEP517="uv-build"
inherit distutils-r1 git-r3

DESCRIPTION="Normalize audio via ffmpeg"
HOMEPAGE="https://github.com/slhck/ffmpeg-normalize"
EGIT_REPO_URI="https://github.com/slhck/ffmpeg-normalize.git"

LICENSE="MIT"
SLOT="0"

RESTRICT="test" # tests require ffmpeg binary and media fixtures

RDEPEND="
	media-video/ffmpeg
	>=dev-python/tqdm-4.64.1[${PYTHON_USEDEP}]
	>=dev-python/ffmpeg-progress-yield-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/colorlog-6.7.0[${PYTHON_USEDEP}]
	>=media-libs/mutagen-1.47.0[${PYTHON_USEDEP}]
"
