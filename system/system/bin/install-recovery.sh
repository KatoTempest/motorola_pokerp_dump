#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/platform/bootdevice/by-name/recovery:33554432:ffd77da0d0b2810a533618d84099ab88a21e6620; then
  applypatch  EMMC:/dev/block/platform/bootdevice/by-name/boot:33554432:e5528db6bf49274caade4c81f500549fa3e5d39a EMMC:/dev/block/platform/bootdevice/by-name/recovery ffd77da0d0b2810a533618d84099ab88a21e6620 33554432 e5528db6bf49274caade4c81f500549fa3e5d39a:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
