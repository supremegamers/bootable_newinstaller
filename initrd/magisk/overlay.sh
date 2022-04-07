#!MAGISK_BASE_FILES/busybox sh

export PATH=/sbin:/system/bin:/system/xbin


mnt_tmpfs(){ (
# MOUNT TMPFS ON A DIRECTORY
MOUNTPOINT="$1"
mkdir -p "$MOUNTPOINT"
mount -t tmpfs -o "mode=0755" tmpfs "$MOUNTPOINT" 2>/dev/null
) }



mnt_bind(){ (
# SHORTCUT BY BIND MOUNT
FROM="$1"; TO="$2"
if [ -L "$FROM" ]; then
SOFTLN="$(readlink "$FROM")"
ln -s "$SOFTLN" "$TO"
elif [ -d "$FROM" ]; then
mkdir -p "$TO" 2>/dev/null
mount --bind "$FROM" "$TO"
else
echo -n 2>/dev/null >"$TO"
mount --bind "$FROM" "$TO"
fi
) }


exit_magisk(){
umount -l MAGISKTMP_PLACEHOLDER
echo -n >/dev/.magisk_unblock
}


API=$(getprop ro.build.version.sdk)
  ABI=$(getprop ro.product.cpu.abi)
  if [ "$ABI" = "x86" ]; then
    ARCH=x86
    ABI32=x86
    IS64BIT=false
  elif [ "$ABI" = "arm64-v8a" ]; then
    ARCH=arm64
    ABI32=armeabi-v7a
    IS64BIT=true
  elif [ "$ABI" = "x86_64" ]; then
    ARCH=x64
    ABI32=x86
    IS64BIT=true
  else
    ARCH=arm
    ABI=armeabi-v7a
    ABI32=armeabi-v7a
    IS64BIT=false
  fi

magisk_name="magisk32"
[ "$IS64BIT" == true ] && magisk_name="magisk64"

# umount previous /sbin tmpfs overlay

count=0
( magisk --stop ) &

# force umount /sbin tmpfs

until ! mount | grep -q " /sbin "; do
[  -gt 10 ] && break
umount -l /sbin 2>/dev/null
sleep 0.1
count=1
test ! -d /sbin && break
done

# mount magisk tmpfs path

mkdir -p "MAGISKTMP_PLACEHOLDER"
mnt_tmpfs "MAGISKTMP_PLACEHOLDER"
chmod 755 "MAGISKTMP_PLACEHOLDER"

MAGISKTMP=MAGISKTMP_PLACEHOLDER
chmod 755 "$MAGISKTMP"
set -x
mkdir -p $MAGISKTMP/.magisk
mkdir -p $MAGISKTMP/emu
exec 2>>$MAGISKTMP/emu/record_logs.txt
exec >>$MAGISKTMP/emu/record_logs.txt

cd  

test ! -f "./$magisk_name" && { echo -n >/dev/.overlay_unblock; exit_magisk; exit 0; }


MAGISKBIN=/data/adb/magisk
mkdir /data/unencrypted
for mdir in modules post-fs-data.d service.d magisk; do
test ! -d /data/adb/$mdir && rm -rf /data/adb/$mdir
mkdir /data/adb/$mdir 2>/dev/null
done
for file in magisk32 magisk64 magiskinit magiskpolicy; do
  cp -af ./$file $MAGISKTMP/$file 2>/dev/null
  chmod 755 $MAGISKTMP/$file
  cp -af ./$file $MAGISKBIN/$file 2>/dev/null
  chmod 755 $MAGISKBIN/$file
done
cp -af ./magiskboot $MAGISKBIN/magiskboot
cp -af ./magisk.apk $MAGISKTMP/.magisk
cp -af ./busybox $MAGISKBIN/busybox
cp -af ./busybox $MAGISKTMP
chmod 755 $MAGISKTMP/busybox
$MAGISKTMP/busybox --install -s $MAGISKTMP
cp -af ./assets/* $MAGISKBIN

# create symlink / applet

ln -s ./$magisk_name $MAGISKTMP/magisk 2>/dev/null
ln -s ./magisk $MAGISKTMP/su 2>/dev/null
ln -s ./magisk $MAGISKTMP/resetprop 2>/dev/null
ln -s ./magisk $MAGISKTMP/magiskhide 2>/dev/null
[ ! -f "$MAGISKTMP/magiskpolicy" ] && ln -s ./magiskinit $MAGISKTMP/magiskpolicy 2>/dev/null
ln -s ./magiskpolicy $MAGISKTMP/supolicy 2>/dev/null

mkdir -p $MAGISKTMP/.magisk/mirror
mkdir $MAGISKTMP/.magisk/block

touch $MAGISKTMP/.magisk/config


#remount system read-only to fix Magisk fail to mount mirror

if mount -t rootfs | grep -q " / " || mount -t tmpfs | grep -q " / "; then
rm -rf /magisk
fi


mount -o ro,remount /
mount -o ro,remount /system
mount -o ro,remount /vendor
mount -o ro,remount /product
mount -o ro,remount /system_ext

restorecon -R /data/adb/magisk

( # addition script
rm -rf /data/adb/post-fs-data.d/fix_mirror_mount.sh
rm -rf /data/adb/service.d/fix_modules_not_show.sh


# additional script to deal with bullshit faulty design of emulator
# that close built-in root will remove magisk's /system/bin/su

echo "
export PATH=\"$MAGISKTMP:\$PATH\"

if mount | grep -q \" /system/bin \" && [ -f \"/system/bin/magisk\" ]; then
    umount -l /system/bin/su
    rm -rf /system/bin/su
    ln -fs ./magisk /system/bin/su
    mount -o ro,remount /system/bin
    umount -l /system/bin/magisk
    mount --bind \"$MAGISKTMP/magisk\" /system/bin/magisk
fi

install_app(){
MAGISK_STUB=\$(strings /data/adb/magisk.db | grep -oE 'requester..*' | cut -c10-)
if [ ! -z \"\$MAGISK_STUB\" ]; then
/system/bin/pm path \"\$MAGISK_STUB\" || /system/bin/pm install \"$MAGISKTMP/.magisk/magisk.apk\"
else
/system/bin/pm install \"$MAGISKTMP/.magisk/magisk.apk\"
fi
}

install_app &

" >$MAGISKTMP/emu/magisksu_survival.sh

# additional script to deal with bullshit faulty design of Bluestacks
# that /system is a bind mountpoint

echo "
SCRIPT=\"\$0\"
MAGISKTMP=\$(magisk --path) || MAGISKTMP=/sbin
( #fix bluestacks
MIRROR_SYSTEM=\"\$MAGISKTMP/.magisk/mirror/system\"
test ! -d \"\$MIRROR_SYSTEM/android/system\" && exit
test \"\$(cd /system; ls)\" == \"\$(cd \"\$MIRROR_SYSTEM\"; ls)\" && exit
mount --bind \"\$MIRROR_SYSTEM/android/system\" \"\$MIRROR_SYSTEM\" )
( #fix mount data mirror
function cmdline() { 
awk -F\"\${1}=\" '{print \$2}' < /proc/cmdline | cut -d' ' -f1 2> /dev/null
}

# additional script to deal with bullshit faulty design of Android-x86
# that data is a bind mount from /data on ext4 partition


SRC=\"\$(cmdline SRC)\"
test -z \"\$SRC\" && exit
LIST_TEST=\"
/data
/data/adb
/data/adb/magisk
/data/adb/modules
\"
count=0
for folder in \$LIST_TEST; do
test \"\$(ls -A \$MAGISKTMP/.magisk/mirror/\$folder 2>/dev/null)\" == \"\$(ls -A \$folder 2>/dev/null)\" && count=\$((\$count + 1))
done
test \"\$count\" == 4 && exit
count=0
for folder in \$LIST_TEST; do
test \"\$(ls -A \$MAGISKTMP/.magisk/mirror/data/\$SRC/\$folder 2>/dev/null)\" == \"\$(ls -A \$folder 2>/dev/null)\" && count=\$((\$count + 1))
done
if [ \"\$count\" == 4 ]; then
mount --bind \"\$MAGISKTMP/.magisk/mirror/data/\$SRC/data\" \"\$MAGISKTMP/.magisk/mirror/data\"
fi )
rm -rf \"\$SCRIPT\"
" >/data/adb/post-fs-data.d/fix_mirror_mount.sh
echo "
SCRIPT=\"\$0\"
MAGISKTMP=\$(magisk --path) || MAGISKTMP=/sbin
CHECK=\"/data/adb/modules/.mk_\$RANDOM\$RANDOM\"
touch \"\$CHECK\"
test \"\$(ls -A \$MAGISKTMP/.magisk/modules 2>/dev/null)\" != \"\$(ls -A /data/adb/modules 2>/dev/null)\" && mount --bind \$MAGISKTMP/.magisk/mirror/data/adb/modules \$MAGISKTMP/.magisk/modules
rm -rf \"\$CHECK\"
rm -rf \"\$SCRIPT\"" >/data/adb/service.d/fix_modules_not_show.sh
chmod 755 /data/adb/service.d/fix_modules_not_show.sh
chmod 755 /data/adb/post-fs-data.d/fix_mirror_mount.sh; )

[ ! -f "$MAGISKTMP/magisk" ] && exit_magisk

# unmount patched files

umount -l /system/etc/init
umount -l /init.rc
umount -l /system/etc/init/hw/init.rc
umount -l /sepolicy
umount -l /system/vendor/etc/selinux/precompiled_sepolicy

