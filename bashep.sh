#!/usr/bin/env bash

bashep_check_cmd()
{
	command -v ${1} > /dev/null 2>&1 || { echo >&2 "Command ${1} required, but not found."; exit 1; }
	echo "${1} command available"
}

# TODO, add support for the apt-less systems
bashep_check_package()
{
	if [ ! `dpkg-query --show --showformat='${db:Status-Status}\n' "${1}"` = "installed" ]; then
#	dpky -l ${1} > /dev/null  2>&1 || {
		PACKAGES="${PACKAGES} ${1}"
	fi;
#	}	
}

bashep_check_targetenv()
{
	PACKAGES=""
	bashep_check_package ckermit
	bashep_check_package isc-dhcp-server
        MISSING_TARGET_ENV_PACKAGES=${PACKAGES}
}

bashep_check_devenv() {
        PACKAGES=""
        bashep_check_package dos2unix
	bashep_check_package libncurses5-dev
	bashep_check_package flex
	MISSING_DEV_ENV_PACKAGES=${PACKAGES}
}


bashep_check_buildenv() 
{
	PACKAGES=""
	bashep_check_package ssh
	bashep_check_package libncurses-dev
	bashep_check_package build-essential
	bashep_check_package cmake
	bashep_check_package gcc-arm-none-eabi
	bashep_check_package gdb-multiarch
	bashep_check_package gcc-aarch64-linux-gnu
	bashep_check_package net-tools
	bashep_check_package repo
	bashep_check_package meld
	MISSING_BUILD_ENV_PACKAGES=${PACKAGES}
}

bashep_check_yoctoenv()
{
	PACKAGES=""
        bashep_check_package chrpath
	bashep_check_package diffstat
	bashep_check_package gawk
	bashep_check_package texinfo
	bashep_check_package bison
	bashep_check_package python3-distutils
	MISSING_YOCTO_ENV_PACKAGES=${PACKAGES}
}

bashep_check_virtenv()
{
	PACKAGES=""
	bashep_check_package qemu-kvm 
	bashep_check_package qemu-system-arm
	bashep_check_package libvirt-daemon-system 
	bashep_check_package libvirt-dev
	bashep_check_package virt-manager
	MISSING_VIRT_ENV_PACKAGES=${PACKAGES}
}
