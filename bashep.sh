#!/usr/bin/env bash

bashep_check_cmd()
{
	command -v ${1} > /dev/null 2>&1 || { echo >&2 "Command ${1} required, but not found."; exit 1; }
	echo "${1} command available"
}

# TODO, add support for the apt-less systems
bashep_check_package()
{
	dpkg -l ${1} > /dev/null  2>&1 || {
		PACKAGES="${PACKAGES} ${1}"
	}	
}

bashep_check_buildenv() 
{
	PACKAGES=""
	bashep_check_package build-essential
	bashep_check_package cmake
	bashep_check_package gcc-arm-none-eabi
	bashep_check_package net-tools
	MISSING_BUILD_ENV_PACKAGES=${PACKAGES}
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
