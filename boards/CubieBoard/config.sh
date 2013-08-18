BUILD_CONFIG="${ARMSTRAP_CONFIG,,}"
BUILD_CPU="a10"
BUILD_ARCH="arm"

if [ -z "${ARMSTRAP_LANG}" ]; then
  BUILD_LANG="${LANG}"
else
  BUILD_LANG="${ARMSTRAP_LANG}"
fi

if [ -z "${ARMSTRAP_LANGUAGE}" ]; then
  BUILD_LANGUAGE="${LANGUAGE}"
else
  BUILD_LANGUAGE="${ARMSTRAP_LANGUAGE}"
fi

BUILD_LANG_EXTRA="${ARMSTRAP_LANG_EXTRA}"
 
if [ -z "${ARMSTRAP_TIMEZONE}" ]; then
  BUILD_TIMEZONE="America/Montreal"
else
  BUILD_TIMEZONE="${ARMSTRAP_TIMEZONE}"
fi

BUILD_ARMBIAN_ROOTFS_LIST="debian ubuntu"

case "${ARMSTRAP_OS}" in
  "ubuntu")  
    BUILD_ARMBIAN_ROOTFS="http://armstrap.vls.beaupre.biz/rootfs/ubuntu-13.04-armv7l-hf.txz"
    BUILD_ARMBIAN_SUITE="rarring"
    BUILD_ARMBIAN_RECONFIG="${ARMSTRAP_DPKG_RECONFIG}"
    ;;
  *)
    BUILD_ARMBIAN_ROOTFS="http://armstrap.vls.beaupre.biz/rootfs/debian-wheezy-armv7l-hf.txz"
    BUILD_ARMBIAN_SUITE="wheezy"
    BUILD_ARMBIAN_RECONFIG="${ARMSTRAP_DPKG_RECONFIG}"
    ;;
esac
  
BUILD_MNT_ROOT="${ARMSTRAP_MNT}"
  
# Not all packages can be install this way.
BUILD_DPKG_EXTRAPACKAGES="${ARMSTRAP_DEBIAN_EXTRAPACKAGES}"
  
# Theses are packages included with or generated by the script. The script will automatically include .deb files in the dpkg directory
BUILD_DPKG_LOCALPACKAGES=""
  
BUILD_SERIALCON_ID="T0"
BUILD_SERIALCON_RUNLEVEL="2345"
BUILD_SERIALCON_TERM="ttyS0"
BUILD_SERIALCON_SPEED="115200"
BUILD_SERIALCON_TYPE="vt100"

BUILD_FSTAB_ROOTDEV="/dev/root"
BUILD_FSTAB_ROOTMNT="/"
BUILD_FSTAB_ROOTFST="ext4"
BUILD_FSTAB_ROOTOPT="defaults"
BUILD_FSTAB_ROOTDMP="0"
BUILD_FSTAB_ROOTPSS="1"
 
BUILD_KERNEL_MODULES="sw_ahci_platform lcd hdmi ump disp mali mali_drm"
  
if [ -z ${ARMSTRAP_ROOT_DEV} ]; then
  BUILD_ROOT_DEV="/dev/mmcblk0p1"
else
  BUILD_ROOT_DEV="${ARMSTRAP_ROOT_DEV}"
fi

BUILD_MAC_VENDOR=0x000246
  
BUILD_BOOT_CMD="${BUILD_MNT_ROOT}/boot/boot.cmd"
BUILD_BOOT_SCR="${BUILD_MNT_ROOT}/boot/boot.scr"
  
BUILD_CONFIG_CMDLINE="console=tty0 console=${BUILD_SERIALCON_TERM},${BUILD_SERIALCON_SPEED} hdmi.audio=EDID:0 disp.screen0_output_mode=EDID:1280x720p60 root=${BUILD_ROOT_DEV} rootwait panic=10"
  
BUILD_KERNEL_NAME="uImage"

BUILD_BOOT_FEX="${BUILD_MNT_ROOT}/boot/${BUILD_CONFIG}.fex"
BUILD_BOOT_BIN="${BUILD_MNT_ROOT}/boot/script.bin"

BUILD_BOOT_BIN_LOAD="mmc 0 0x43000000 boot/script.bin"
BUILD_BOOT_KERNEL_LOAD="mmc 0 0x48000000 boot/${BUILD_KERNEL_NAME}"
BUILD_BOOT_KERNEL_ADDR="0x48000000"

BUILD_BOOT_SPL="${BUILD_MNT_ROOT}/boot/sunxi-spl.bin"
BUILD_BOOT_SPL_SIZE="1024"
BUILD_BOOT_SPL_SEEK="8"

BUILD_BOOT_UBOOT="${BUILD_MNT_ROOT}/boot/u-boot.bin"
BUILD_BOOT_UBOOT_SIZE="1024"
BUILD_BOOT_UBOOT_SEEK="32"
  
BUILD_DISK_LAYOUT=("1:/:ext4:-1")

#############################################################################
#
# Kernel builder stuff
#
BUILD_KBUILDER_TYPE="sun4i"
if [ -z "${ARMSTRAP_KBUILDER_CONF}" ]; then
  BUILD_KBUILDER_CONF="desktop"
else
  BUILD_KBUILDER_CONF="${ARMSTRAP_KBUILDER_CONF}"
fi
BUILD_KBUILDER_ARCH="${BUILD_ARCH}"
BUILD_KBUILDER_FAMILLY="${BUILD_CONFIG}"
BUILD_KBUILDER_SOURCE="${ARMSTRAP_SRC}/${BUILD_CONFIG}/linux-sunxi"
BUILD_KBUILDER_CONFIG="${ARMSTRAP_BOARDS}/${ARMSTRAP_CONFIG}/kernel"
BUILD_KBUILDER_GITSRC="https://github.com/linux-sunxi/linux-sunxi.git"
BUILD_KBUILDER_GITBRN="sunxi-3.4"

#############################################################################
#
# U-Boot Stuff
#
BUILD_UBUILDER_FAMILLY="${BUILD_CONFIG}"
BUILD_UBUILDER_GITSRC="https://github.com/hno/u-boot.git"
BUILD_UBUILDER_GITBRN="sunxi-current"
BUILD_UBUILDER_SOURCE=""${ARMSTRAP_SRC}/${BUILD_CONFIG}/uboot-hno
#
# Theses are defaults values that can be overwritten by uEnv.txt
#
BUILD_UBUILDER_BOOTCMD=("bootargs=${BUILD_CONFIG_CMDLINE}" "root=${BUILD_ROOT_DEV} rootwait" "kernel=/boot/${BUILD_KERNEL_NAME}")

#############################################################################
#
# Sunxi-Boards Stuff
#
BUILD_SBUILDER_FAMILLY="${BUILD_CONFIG}"
BUILD_SBUILDER_GITSRC="https://github.com/linux-sunxi/sunxi-boards.git"
BUILD_SBUILDER_GITBRN=""
BUILD_SBUILDER_SOURCE="${ARMSTRAP_SRC}/${BUILD_CONFIG}/sunxi-boards"

if [ -f "${ARMSTRAP_BOARDS}/${ARMSTRAP_CONFIG}/sunxi-boards/sys_config/${BUILD_CPU}/${BUILD_SBUILDER_FAMILLY}.fex" ]; then
  BUILD_SBUILDER_CONFIG="${ARMSTRAP_BOARDS}/${ARMSTRAP_CONFIG}/sunxi-boards/sys_config/${BUILD_CPU}/${BUILD_SBUILDER_FAMILLY}.fex"
else
  BUILD_SBUILDER_CONFIG="${BUILD_SBUILDER_SOURCE}/sys_config/${BUILD_CPU}/${BUILD_SBUILDER_FAMILLY}.fex"
fi

#############################################################################
#
# Sunxi-Tools Stuff
#
BUILD_TBUILDER_FAMILLY="${BUILD_CONFIG}"
BUILD_TBUILDER_GITSRC="https://github.com/linux-sunxi/sunxi-tools.git"
BUILD_TBUILDER_GITBRN=""
BUILD_TBUILDER_SOURCE="${ARMSTRAP_SRC}/${BUILD_CONFIG}/sunxi-tools"

BUILD_ARMBIAN_EXTRACT="tar -xJ"
BUILD_ARMBIAN_COMPRESS="tar -cJvf"
BUILD_ARMBIAN_KERNEL="http://armstrap.vls.beaupre.biz/kernel/${BUILD_CONFIG}/install-${BUILD_CONFIG}-linux-${BUILD_KBUILDER_CONF}-kernel-3.4.43+_3.4.43+-1_armhf.sh"
BUILD_ARMBIAN_UBOOT="http://armstrap.vls.beaupre.biz/uboot/${BUILD_CONFIG}-u-boot.txz"

BUILD_SCRIPTS="installOS.sh"
BUILD_PREREQ="u-boot-tools qemu qemu-user-static parted kpartx lvm2 binfmt-support libusb-1.0-0-dev dosfstools libncurses5-dev"
