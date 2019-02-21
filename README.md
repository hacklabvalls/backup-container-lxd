# backup-container-lxd

Bash script to generete backups of Linux Containers with LXD. 

Create snapshot, publish image of snapshot and export image tar.gz compressed file. If backup success, delete previous spanshot, image and compressed backup. Ideal for daily cron

* Add execution permission:

`chmod +x backup-container.sh`

* Execution:

`./backup-container.sh <container-name>`

[Wiki hacklab](https://wiki.hacklabvalls.org/index.php?title=Script_per_fer_backups_dels_linux_containers_amb_LXD)
