!/bin/bash
# Freki S3 Backup Script
# Purpose = Backup of Important Data to Amazon S3/Glacier
# Rewrite by nwgat.ninja, orginal by Hafiz Haider
# Required packages
# curl (pushover) https://curl.haxx.se/
# s3put (s3/gcs) https://github.com/surma/s3put/releases

# Pushover Settings
pusht=0000 # token
pushu=0000 # user

# Source and Dest
SRCDIR=/home/user/importantstuff          # Location of Important Data Directory (Source of backup).
DESDIR=/home/user/backup/folder           # Destination of backup file.

# S3/GCS Setttings
BUCKET=backups.domain.ninja # s3 bucket name
AWSK=0000 # AWS/GCS Access Key
AWSS=0000 # AWS/GCS Secret Key
SERV=s3 # S3 or GCS
REG=https://s3.amazonaws.com # region

# other stuff
TIME=`date +%d-%m-%Y_%H-%M-%S`            # This Command will add date in Backup File Name.
FILENAME=Backup-$TIME.tar.gz    # Here i define Backup file name format.

# magic
echo "Compressing files.."
tar -cpzf $DESDIR/$FILENAME $SRCDIR
echo "Backing up to S3/GCS"
./s3put -c 5 $SERV -k $AWSK -s $AWSS -b https://s3.amazonaws.com/$BUCKET put $DESDIR/$FILENAME
curl -s -F "token=$pusht" -F "user=$pushu" -F "message=$FILENAME uploaded" https://api.pushover.net/1/messages
echo ""
echo "done"
echo ""

#END
