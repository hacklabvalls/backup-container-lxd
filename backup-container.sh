#!/bin/bash
# exec: ./backup-container.sh <container-name>
PATH=$PATH:/snap/bin

echo "creating snapshot..."
lxc snapshot $1 bkp-$1-`date +\%Y-\%m-\%d`
lxc list $1
echo "Snapshot created. Publishing image of snapshot..."
lxc publish $1/bkp-$1-`date +\%Y-\%m-\%d` --alias bkp-$1-`date +\%Y-\%m-\%d`
echo "Image published. Exporting image to bkp-"$1"-"`date +\%Y-\%m-\%d`".tar.gz ..."


EXPORT=$(lxc image export bkp-$1-`date +\%Y-\%m-\%d` /var/lib/backups/bkp-$1-`date +\%Y-\%m-\%d`)

#verify export result is success
if [[ $EXPORT = *"Image exported successfully"* ]]; then
        echo "Backup tarball Finished"
        #if success, clean yesterday backup
        ##delete yesterday snapshot and backup
        echo "Delete yesterday image, snapshot and backup..."
        lxc image delete bkp-$1-`date +\%Y-\%m-\%d -d "yesterday"`
        lxc delete $1/bkp-$1-`date +\%Y-\%m-\%d -d "yesterday"`
        file=/var/lib/backups/bkp-$1-`date +\%Y-\%m-\%d -d "yesterday"`.tar.gz
        if [ -f $file ] ; then
                rm $file
        fi
        echo "Clean done!"
else
        echo "Error exporting image to tarball"
fi
