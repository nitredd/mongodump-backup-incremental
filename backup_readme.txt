
Deployment

* Install Database Tools for getting mongodump
* Get a user account with read permission on the source collection
* Ensure the execute permissions are set with: chmod +x *.sh
* Create directories for the scripts and the backups
* Modify the backup_full.sh and backup_incremental.sh to set the MongoDB URI, database name, collection name etc.
* Schedule the scripts with "crontab -e"
* Ensure indices created on the createdAt date-time (if your field name is different, change it in the backup_incremental.sh script)

Restoring

* Restore full with drop option ( mongorestore --drop followed by the other options used for the mongodump )
* Restore incremental to temporary collection ( mongorestore with --nsFrom=coll_name --nsTo=tmp_coll_name )
* Run aggregation on the temporary collection with merge to the actual collection ( db.tmp_coll_name.aggregate([{$merge: "coll_name"}]) )

