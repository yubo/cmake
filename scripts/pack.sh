#!/bin/bash
if ! [[ "$0" =~ "scripts/pack.sh" ]]; then
	echo "must be run from repository root"
	exit 255
fi
work_dir=${PWD}

# sys arch src_dir
cmake_rebuild_dir() {
	sys=$1
	arch=$2
	src_dir=$3
	dst_dir=${src_dir}/build/${sys}.${arch}

	cd ${dst_dir}
	make package
	cd -
}

cmake_build() {
	for sys in ${SYS}; do
		for arch in ${ARCH}; do
			cmake_build_dir ${sys} ${arch} ${work_dir}
		done
	done
}

#SYS="Linux Darwin"
SYS="Linux"
ARCH="x86_64" 

#set -eux
cmake_build

rpm_file=hello1-0.1.2-1.Linux.x86_64.rpm
rpm -qp --info ${rpm_file}

