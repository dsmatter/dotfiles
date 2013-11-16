backup_duplicity() {
	local old_ulimit="$(ulimit -n)"
  local pass="$(getpw Duplicity)"
	ulimit -n 2048
	echo Backing up...
	if PASSPHRASE=${pass} duplicity ~/dev scp://smatter@smattr.de:2222//safe/Backup/daniel/duplicity/dev; then
		#notify_libnotify "dev synced"
	else
		notify_libnotify "sync failed!"
		return 1
	fi
	if PASSPHRASE=${pass} duplicity ~/Documents scp://smatter@smattr.de:2222//safe/Backup/daniel/duplicity/Documents; then
		#notify_libnotify "docs synced"
	else
		notify_libnotify "sync failed!"
		return 1
	fi
  notify_libnotify "sync complete"
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
