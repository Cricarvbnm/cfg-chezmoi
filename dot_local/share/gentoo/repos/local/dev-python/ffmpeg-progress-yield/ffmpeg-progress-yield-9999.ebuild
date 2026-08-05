EAPI=8

PYTHON_COMPAT=(python3_{9..14})
DISTUTILS_USE_PEP517="uv-build"
inherit distutils-r1 git-r3

DESCRIPTION="Run an ffmpeg command and report its progress via tqdm"
HOMEPAGE="https://github.com/slhck/ffmpeg-progress-yield"
EGIT_REPO_URI="https://github.com/slhck/ffmpeg-progress-yield.git"

LICENSE="MIT"
SLOT="0"

RESTRICT="test" # tests require ffmpeg binary

RDEPEND="
	media-video/ffmpeg
	>=dev-python/tqdm-4.38.0[${PYTHON_USEDEP}]
"
