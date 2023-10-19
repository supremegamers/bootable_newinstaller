# List of updated components in newinstaller, including initrd & install

Most of the libraries & programs are taken from Debian 13 (trixie), some are taken elsewhere.

## initrd

- bin/busybox

busybox i386 (1.36.1)

https://github.com/docker-library/busybox/tree/dist-i386/latest/glibc

- bin/ld-linux.so.2 (symlink lib/ld-linux.so.2)
- lib/libc.so.6
- lib/libdl.so.2
- lib/libm.so.6
- lib/libpthread.so.0
- lib/libresolv.so.2
- lib/librt.so.1

libc6 i386 (2.37-12)

https://packages.debian.org/trixie/i386/libc6

- sbin/mount.ntfs-3g

ntfs-3g i386 (1:2022.10.3-1 and others)

https://packages.debian.org/trixie/i386/ntfs-3g

- lib/libntfs-3g.so.89

libntfs-3g89 i386 (1:2022.10.3-1 and others)

https://packages.debian.org/trixie/i386/libntfs-3g89

## install

- bin/fdisk
- bin/cfdisk
- bin/sfdisk

fdisk i386 (2.39.2)

https://packages.debian.org/trixie/i386/fdisk

- bin/dialog

dialog i386 (1.3-20230209)

https://packages.debian.org/trixie/i386/dialog

- bin/gdisk
- bin/cgdisk
- bin/sgdisk

gdisk i386 (1.0.9-2.1)

https://packages.debian.org/trixie/i386/gdisk

- bin/iconv

libc-bin i386 (2.37-12)

https://packages.debian.org/trixie/i386/libc-bin

- bin/mksquashfs

squashfs-tools i386 (4.6.1-1)

https://packages.debian.org/trixie/i386/squashfs-tools

- bin/pv

pv i386 (1.7.24-1)

https://packages.debian.org/trixie/pv/i386

- sbin/grub-install

grub2-common i386 (2.06-13)

https://packages.debian.org/trixie/i386/grub2-common

- sbin/grub-mkimage

grub-common i386 (2.06-13)

https://packages.debian.org/trixie/i386/grub-common

- lib/terminfo/l/linux
- lib/terminfo/l/linux3.0

ncurses-term all (6.4+20230625-2)

https://packages.debian.org/trixie/all/ncurses-term

- lib/libncursesw.so.6

libncursesw6 i386 (6.4+20230625-2)

https://packages.debian.org/trixie/i386/libncursesw6

- lib/libtinfo.so.6

libtinfo6 i386 (6.4+20230625-2)

https://packages.debian.org/trixie/i386/libtinfo6 

- lib/libsmartcols.so.1

libsmartcols1 i386 (2.39.2-1)

https://packages.debian.org/trixie/i386/libsmartcols1

- lib/libfdisk.so.1

libfdisk1 i386 (2.39.2-1)

https://packages.debian.org/trixie/i386/libfdisk1

- lib/libblkid.so.1

libblkid1 i386 (2.39.2-1)

https://packages.debian.org/trixie/i386/libblkid1

- lib/libuuid.so.1

libuuid1 i386 (2.39.2-1)

https://packages.debian.org/trixie/i386/libuuid1

- lib/libmount.so.1

libmount1 i386 (2.39.2-1)

https://packages.debian.org/trixie/i386/libmount1

- lib/libselinux.so.1

libselinux1 i386 (3.5-1)

https://packages.debian.org/trixie/i386/libselinux1

- lib/libreadline.so.8

libreadline8 i386 (8.2-1.3)

https://packages.debian.org/trixie/i386/libreadline8

- lib/libpcre2-8.so.0

libpcre2-8-0 i386 (10.42-4)

https://packages.debian.org/trixie/i386/libpcre2-8-0

- lib/libpopt.so.0

libpopt0 i386 (1.19+dfsg-1)

https://packages.debian.org/trixie/i386/libpopt0

- lib/libstdc++.so.6

libstdc++6 i386 (13.2.0-3)

https://packages.debian.org/trixie/i386/libstdc++6

- lib/libgcc_s.so.1

libgcc_s1 i386 (13.2.0-3)

https://packages.debian.org/trixie/i386/libgcc-s1

- lib/grub/i386-pc/*

grub-pc-bin i386 (2.06-13)

https://packages.debian.org/trixie/i386/grub-pc-bin

- lib/grub/i386-efi/*

grub-efi-ia32-bin i386 (2.06-13)

https://packages.debian.org/trixie/i386/grub-efi-ia32-bin

- lib/grub/x86_64-efi/*

grub-efi-amd64-bin i386 (2.06-13)

https://packages.debian.org/trixie/i386/grub-efi-amd64-bin

- lib/liblzma.so.5

liblzma5 i386 (5.4.4-0.1)

https://packages.debian.org/trixie/i386/liblzma5

- lib/libdevmapper.so.1.02.1

libdevmapper1.02.1 i386 (2:1.02.185-2)

https://packages.debian.org/trixie/i386/libdevmapper1.02.1

- lib/libudev.so.1

libudev1 i386 (254.1-3)

https://packages.debian.org/trixie/i386/libudev1

- lib/libcap.so.2

libcap2 i386 (1:2.66-4)

https://packages.debian.org/trixie/i386/libcap2

- lib/libefiboot.so.1

libefiboot1 i386 (37-6)

https://packages.debian.org/trixie/i386/libefiboot1

- lib/libefivar.so.1

libefivar1 i386 (37-6)

https://packages.debian.org/trixie/i386/libefivar1

- lib/liblz4.so.1

liblz4 i386 (1_1.9.4-1)

https://packages.debian.org/trixie/i386/liblz4-1

- lib/liblzo2.so.2

liblzo2-2 i386 (2.10-2)

https://packages.debian.org/trixie/i386/liblzo2-2

- lib/libzstd.so.1

libzstd1 i386 (1.5.5+dfsg2-2)

https://packages.debian.org/trixie/i386/libzstd1

- lib/libz.so.1

zlib1g i386 (1:1.2.13.dfsg-3)

https://packages.debian.org/trixie/i386/zlib1g

- grub2/efi/boot/BOOTx64.EFI (rename shimx64.efi)

shim-signed amd64 (1.40+15.7-1)

https://packages.debian.org/trixie/amd64/shim-signed

- grub2/efi/boot/bootia32.efi (rename shimia32.efi)

shim-signed i386 (1.40+15.7-1)

- grub2/efi/boot/mmia32.efi

shim-helpers-i386-signed i386 (1+15.7+1)

https://packages.debian.org/trixie/i386/shim-helpers-i386-signed

- grub2/efi/boot/mmx64.efi

shim-helpers-amd64-signed amd64 (1+15.7+1)

https://packages.debian.org/trixie/amd64/shim-helpers-amd64-signed

- grub2/efi/boot/grubx64.efi

grub-efi-amd64-bin i386 (2.06-13)

https://packages.debian.org/trixie/i386/grub-efi-amd64-bin

- grub2/efi/boot/grubia32.efi

grub-efi-ia32-bin i386 (2.06-13)

https://packages.debian.org/trixie/i386/grub-efi-ia32-bin

- refind/

refind-bin all (0.14.0.2) (zip)

https://sourceforge.net/projects/refind/files/

- refind/themes/refind-theme-regular

refind-theme-regular all (fb58a79)

https://github.com/bobafetthotmail/refind-theme-regular

- refind/refind/drivers_ia32/exfat_ia32.efi
- refind/refind/drivers_ia32/f2fs_ia32.efi
- refind/refind/drivers_ia32/fat_ia32.efi
- refind/refind/drivers_ia32/ntfs_ia32.efi

efifs ia32 (1.9)

https://efi.akeo.ie/downloads/efifs-1.9/ia32/

- refind/refind/drivers_x64/exfat_x64.efi
- refind/refind/drivers_x64/f2fs_x64.efi
- refind/refind/drivers_x64/fat_x64.efi
- refind/refind/drivers_x64/ntfs_x64.efi

efifs x86_64 (1.9)

https://efi.akeo.ie/downloads/efifs-1.9/x64/

## iso

- isolinux/isolinux.bin

isolinux all (3:6.04~git20190206.bf6db5b4+dfsg1-3)

- isolinux/*.c32

syslinux-common all (3:6.04~git20190206.bf6db5b4+dfsg1-3)
