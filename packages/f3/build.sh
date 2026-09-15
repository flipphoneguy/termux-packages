TERMUX_PKG_HOMEPAGE=https://github.com/AltraMayor/f3
TERMUX_PKG_DESCRIPTION="Test the actual capacity of flash cards and USB drives"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=10.0
TERMUX_PKG_SRCURL=https://github.com/AltraMayor/f3/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=ce54275b7793f97391583ede33c1d87590901d8da20cce604b1f07a029aefc67
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_UPDATE_TAG_TYPE="newest-tag"
TERMUX_PKG_DEPENDS="argp"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_MAKE_ARGS="PREFIX=$TERMUX_PREFIX"

termux_step_pre_configure() {
	# Bionic lacks argp, so link against the standalone implementation.
	LDFLAGS+=" -largp"
	# aligned_alloc is only declared on API level 28 and above.
	if [[ "$TERMUX_PKG_API_LEVEL" -lt 28 ]]; then
		CFLAGS+=" -Daligned_alloc=memalign"
	fi
}
