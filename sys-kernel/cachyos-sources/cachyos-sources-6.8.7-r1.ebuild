# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI="8"
ETYPE="sources"
EXTRAVERSION="-cachyos"
K_EXP_GENPATCHES_NOUSE="1"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="10"

inherit kernel-2 optfeature

detect_version

DESCRIPTION="CachyOS kernel sources"
HOMEPAGE="https://github.com/CachyOS/linux-cachyos"

CACHY_OS_KERNEL_PATCHES_COMMIT_HASH="4cf1f88d73f7743a4e99c253224105a2ab86324b"
CACHY_OS_PKGBUILD_COMMIT_HASH="b47828feffdd60e7d478cc2ab2d603f17dc6ae3e"

SRC_URI="
	${KERNEL_URI}
	${GENPATCHES_URI}
	https://github.com/CachyOS/kernel-patches/archive/${CACHY_OS_KERNEL_PATCHES_COMMIT_HASH}.tar.gz -> ${P}-patches.tar.gz
	https://github.com/CachyOS/linux-cachyos/archive/${CACHY_OS_PKGBUILD_COMMIT_HASH}.tar.gz -> ${P}-config.tar.gz
"

LICENSE="GPL-3"
KEYWORDS="~amd64"
IUSE="sched-ext +bore intel amd-hdr vmap ntsync spadfs v4l2-loopback le9uo"
REQUIRED_USE=""

src_unpack() {
	kernel-2_src_unpack

	mkdir "${WORKDIR}/cachyos" || die
	cd "${WORKDIR}/cachyos" || die

	unpack "${P}-patches.tar.gz"
	unpack "${P}-config.tar.gz"
}

src_prepare() {
	CACHY_OS_PATCHES_DIR="${WORKDIR}/cachyos/kernel-patches-${CACHY_OS_KERNEL_PATCHES_COMMIT_HASH}/${KV_MAJOR}.${KV_MINOR}"
	CACHY_OS_CONFIG_DIR="${WORKDIR}/cachyos/linux-cachyos-${CACHY_OS_PKGBUILD_COMMIT_HASH}"

	eapply "${CACHY_OS_PATCHES_DIR}/all/0001-cachyos-base-all.patch"

	# Apply scheduler patches
	use sched-ext && eapply "${CACHY_OS_PATCHES_DIR}/sched/0001-sched-ext.patch"
	use bore && eapply "${CACHY_OS_PATCHES_DIR}/sched/0001-bore-cachy.patch"

	if use sched-ext; then
		if use bore; then
			CACHY_OS_PROFILE="linux-cachyos"
		else
			CACHY_OS_PROFILE="linux-cachyos-sched-ext"
		fi
	else
		if use bore; then
			CACHY_OS_PROFILE="linux-cachyos-bore"
		else
			CACHY_OS_PROFILE="linux-cachyos-eevdf"
		fi
	fi

	cp "${CACHY_OS_CONFIG_DIR}/${CACHY_OS_PROFILE}/config" .config || die
	sh "${CACHY_OS_CONFIG_DIR}/${CACHY_OS_PROFILE}/auto-cpu-optimization.sh" || die

	if use intel; then
		eapply "${CACHY_OS_PATCHES_DIR}/intel/0001-intel-thread-director.patch"
	fi

	if use amd-hdr; then
		eapply "${CACHY_OS_PATCHES_DIR}/misc/0001-amd-hdr.patch"
	fi

	if use le9uo; then
		eapply "${CACHY_OS_PATCHES_DIR}/misc/0001-le9uo.patch"
	fi

	if use vmap; then
		eapply "${CACHY_OS_PATCHES_DIR}/misc/0001-mm-Mitigate-a-vmap-lock-contention-v3.patch"
	fi

	if use ntsync; then
		eapply "${CACHY_OS_PATCHES_DIR}/misc/0001-ntsync.patch"
	fi

	if use v4l2-loopback; then
		eapply "${CACHY_OS_PATCHES_DIR}/misc/v4l2loopback.patch"
	fi

	if use spadfs; then
		eapply "${CACHY_OS_PATCHES_DIR}/misc/0001-spadfs-6.7-merge-v1.0.18.patch"
	fi

	eapply_user

	# Remove CachyOS's localversion
	find . -name "localversion*" -delete || die
	scripts/config -u LOCALVERSION || die

	# Enable CachyOS tweaks
	scripts/config -e CACHY || die

	# Enable SCX
	if use sched-ext; then
		scripts/config -e SCHED_CLASS_EXT || die
	fi

	# Enable BORE
	if use bore; then
		scripts/config -e SCHED_BORE || die
	fi

	# Change hostname
	scripts/config --set-str DEFAULT_HOSTNAME "gentoo" || die

	# LTO
	scripts/config -e LTO_NONE || die

	# 500 Hz
	scripts/config -d HZ_300 -e HZ_500 --set-val HZ 500 || die

	# Setting NR_CPUS
	scripts/config --set-val NR_CPUS 320 || die

	# Setting full dynamic tick
	scripts/config -d HZ_PERIODIC -d NO_HZ_IDLE -d CONTEXT_TRACKING_FORCE \
		-e NO_HZ_FULL_NODEF -e NO_HZ_FULL -e NO_HZ -e NO_HZ_COMMON -e CONTEXT_TRACKING || die

	# Setting full preempt
	scripts/config -e PREEMPT_BUILD -d PREEMPT_NONE -d PREEMPT_VOLUNTARY \
		-e PREEMPT -e PREEMPT_COUNT -e PREEMPTION -e PREEMPT_DYNAMIC || die

	# Enable O3
	scripts/config -d CC_OPTIMIZE_FOR_PERFORMANCE -e CC_OPTIMIZE_FOR_PERFORMANCE_O3 || die

	# Enable bbr3
	scripts/config -m TCP_CONG_CUBIC \
		-d DEFAULT_CUBIC \
		-e TCP_CONG_BBR \
		-e DEFAULT_BBR \
		--set-str DEFAULT_TCP_CONG bbr || die

	# Enable MultiGen LRU
	scripts/config -e LRU_GEN -e LRU_GEN_ENABLED -d LRU_GEN_STATS || die

	# Enable VMA
	scripts/config -e PER_VMA_LOCK -d PER_VMA_LOCK_STATS || die

	# Enable Always THP
	scripts/config -d TRANSPARENT_HUGEPAGE_MADVISE -e TRANSPARENT_HUGEPAGE_ALWAYS || die

	# Enable DAMON
	scripts/config -e DAMON \
		-e DAMON_VADDR \
		-e DAMON_DBGFS \
		-e DAMON_SYSFS \
		-e DAMON_PADDR \
		-e DAMON_RECLAIM \
		-e DAMON_LRU_SORT || die

	if ! use sched-ext; then
		scripts/config -d DEBUG_INFO \
			-d DEBUG_INFO_BTF \
			-d DEBUG_INFO_DWARF4 \
			-d DEBUG_INFO_DWARF5 \
			-d PAHOLE_HAS_SPLIT_BTF \
			-d DEBUG_INFO_BTF_MODULES \
			-d SLUB_DEBUG \
			-d PM_DEBUG \
			-d PM_ADVANCED_DEBUG \
			-d PM_SLEEP_DEBUG \
			-d ACPI_DEBUG \
			-d SCHED_DEBUG \
			-d LATENCYTOP \
			-d DEBUG_PREEMPT || die
	fi

	# Enable USER_NS_UNPRIVILEGED
	scripts/config -e USER_NS || die

	mv .config cachyos-config || die
}

pkg_postinst() {
	kernel-2_pkg_postinst

	optfeature "userspace KSM helper" sys-process/uksmd
	#optfeature "auto nice daemon" app-admin/ananicy-cpp
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
