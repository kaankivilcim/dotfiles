#!/bin/sh

export BORG_REPO=/backup
export BORG_PASSCOMMAND="cat /root/.borg_passphrase"

borg create --verbose --filter AME --list --stats --show-rc --one-file-system \
  --exclude-caches --exclude '/dev/*' --exclude '/proc/*' --exclude '/run/*' \
  --exclude '/sys/*' --exclude '/tmp/*' ::'{hostname}-{now}'
backup_exit=$?

borg prune --list --prefix '{hostname}-' --show-rc --keep-daily 7 --keep-weekly 4 --keep-monthly 6
prune_exit=$?

global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

if [ ${global_exit} -eq 0 ]; then
    echo "Backup and prune finished successfully"
elif [ ${global_exit} -eq 1 ]; then
    echo "Backup and/or prune finished with warnings"
else
    echo "Backup and/or prune finished with errors"
fi

exit ${global_exit}
