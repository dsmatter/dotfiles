local LOCAL_MEDIA="$MEDIA_HOME/"
local LOCAL_DOCUMENTS="$DOC_HOME/"
local LOCAL_DEV="$DEVEL_HOME/"

local REMOTE_MEDIA='smServer:/media/christmas/backups/daniel/media/'
local REMOTE_DOCUMENTS='smServer:/media/christmas/backups/daniel/Documents/'
local REMOTE_DEV='smServer:/media/christmas/backups/daniel/dev/'

sync_pull() {
  #rsync -auvr --delete $REMOTE_MEDIA $LOCAL_MEDIA
  rsync -auvr --delete $REMOTE_DOCUMENTS $LOCAL_DOCUMENTS
  rsync -auvr --delete --exclude="git" $REMOTE_DEV $LOCAL_DEV
}

sync_pull_nodelete() {
  #rsync -auvr $REMOTE_MEDIA $LOCAL_MEDIA
  rsync -auvr $REMOTE_DOCUMENTS $LOCAL_DOCUMENTS
  rsync -auvr --exclude="git" $REMOTE_DEV $LOCAL_DEV
}

sync_push_once() {
  rsync -auvr $LOCAL_MEDIA $REMOTE_MEDIA
  rsync -auvr $LOCAL_DOCUMENTS $REMOTE_DOCUMENTS
  rsync -auvr $LOCAL_DEV $REMOTE_DEV
}

sync_push() {
  lsyncd  /etc/lsyncd/media.conf
  lsyncd  /etc/lsyncd/docs.conf
  lsyncd  /etc/lsyncd/dev.conf
  lsyncd  /etc/lsyncd/maildir.conf
  lsyncd  /etc/lsyncd/maildir-intum.conf
  lsyncd  /etc/lsyncd/sup.conf
}

sync_pushit() {
  rsync -auvr $LOCAL_MEDIA $REMOTE_MEDIA
  rsync -auvr --delete $LOCAL_DOCUMENTS $REMOTE_DOCUMENTS
  rsync -auvr --delete --exclude="git" $LOCAL_DEV $REMOTE_DEV
}

syncs() {
  if [[ "$1" == "pull" ]]; then
    echo "Pulling"
    sync_pull
  elif [[ "$1" == "push" ]]; then
    echo "Pushing"
    sync_push
  elif [[ "$1" == "pushit" ]]; then
    echo "Pushing it"
    sync_pushit
  elif [[ "$1" == "both" ]]; then
    echo "Pulling"
    sync_pull
    echo "Pushing"
    sync_push
  elif [[ "$1" == "bothonce" ]]; then
    echo "Pulling"
    sync_pull
    echo "Pushing"
    sync_push_once
  else
    echo "Please provide pull push or both as first argument"
  fi
}

backup_duplicity() {
	local old_ulimit="$(ulimit -n)"
	local pass
	ulimit -n 2048
	echo -n "Enter GPG passphrase: "
	read -s pass
	echo Backing up...
	if PASSPHRASE=${pass} duplicity ~/dev scp://smatter@smattr.de:2222//safe/Backup/daniel/duplicity/dev; then
		notify_libnotify "dev synced"
	else
		notify_libnotify "sync failed!"
		return 1
	fi
	if PASSPHRASE=${pass} duplicity ~/Documents scp://smatter@smattr.de:2222//safe/Backup/daniel/duplicity/Documents; then
		notify_libnotify "docs synced"
	else
		notify_libnotify "sync failed!"
		return 1
	fi
	if PASSPHRASE=${pass} duplicity ~/dl/media scp://smatter@smattr.de:2222//safe/Backup/daniel/duplicity/media; then
		notify_libnotify "media synced"
	else
		notify_libnotify "sync failed!"
		return 1
	fi
	ulimit -n $old_ulimit
}

backup_dbs() {
	ssh smt 'cd /srv/db && tar cz *.db *.sqlite3' | gpg -er high > $HOME/Dropbox/backups/dbs-$(date +"%Y%m%d%H%M").tar.gz.gpg
  ssh smt 'cd /var/lib && sudo -u couchdb tar cz couchdb' | gpg -er high > $HOME/Dropbox/backups/couchdb-$(date +"%Y%m%d%H%M").tar.gz.gpg
}

backup_podcasts() {
	ssh smserver 'cd /heaven/podcasts && ./export_tar.sh' > $HOME/Dropbox/backups/podcasts-$(date +"%Y%m%d%H%M").tar
}

sync_mails() {
  local sparkle_dir="$HOME/SparkleShare/Maildir/"
	if offlineimap; then
    echo 'Rsync to SparkleShare'
    rsync -r ~/Maildir-daniel-strittmatter/* $sparkle_dir
    (cd $sparkle_dir && sleep 10 && git push smserver master) &
		notify_libnotify Mails synced
	else
		notify_libnotify Mail sync failed
	fi
}
