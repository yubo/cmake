#!/bin/bash
if ! [[ "$0" =~ "scripts/make.sh" ]]; then
	echo "must be run from repository root"
	exit 255
fi
work_dir=${PWD}

# sys arch src_dir app_name
cmake_build_dir() {
	sys=$1
	arch=$2
	src_dir=$3
	app=$4
	dst_dir=${src_dir}/build/${app}.${sys}.${arch}

	test -d ${dst_dir} || mkdir -p ${dst_dir}
	cd ${dst_dir}
	cmake -DCPACK_GENERATOR="${PKG}" -DAPP_NAME=${app} -DCGO_ENABLE=0 -DCMAKE_SYSTEM_NAME=${sys} -DCMAKE_SYSTEM_PROCESSOR=${arch} ${src_dir}
	make
	make package
	rpm -qlp *.rpm
	cd - >/dev/null
}

cmake_build() {
	rm -rf ./build
	for sys in ${SYS}; do
		for arch in ${ARCH}; do
			for app in ${APP}; do
				cmake_build_dir ${sys} ${arch} ${work_dir} ${app}
			done
		done
	done
}

#SYS="Linux Darwin"
SYS="Linux"
ARCH="x86_64" 
APP="hello1" 
PKG="RPM"

#set -eux
cmake_build
