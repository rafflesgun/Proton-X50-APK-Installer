## This version were made based on muncheno@LYN's idea and script. Huge thanks to him! ##
# log output of shell to a file on USB
exec > /mnt/media_rw/udisk1/log.txt 2>&1
#!/system/bin/sh
export PATH=/sbin:/system/sbin:/system/xbin:/system/bin
# mount /data partition in RW mode
mount -o remount,rw /data /data
# rename file name with space, replace space with underscore. Source: https://superuser.com/a/300714
cd /mnt/media_rw/udisk1/APK/
for f in *\ *; do mv "$f" "${f// /_}"; done
echo -e $(date)": Renamed file with spaces in USB, if any.\n"
# Start installation with PackageInstaller
echo -e $(date)": Batch installation started.\n"
# for all apps in /APK folder in USB, run "pm install -rtdg --user 0 appname.apk". Source: https://stackoverflow.com/a/10523501
for app in /mnt/media_rw/udisk1/APK/*.apk; do pm install -rtdg --user 0 $app; done
echo -e $(date)": Batch installation ended.\n"
# Rename folder to prevent re-run bash script after reboot. Great idea from muncheno. 
mv /mnt/media_rw/udisk1/b832bc61472727635baffcf25dd28e9f239273e2 /mnt/media_rw/udisk1/b832bc61472727635baffcf25dd28e9f239273e2_done
echo -e $(date)": Folder renamed installation ended.\n"
sync
sleep 5
reboot
