# script to upload local files to s3
aws s3 cp ./7days.service "s3://8dot3/7days/7days.service"
aws s3 cp ./init.sh "s3://8dot3/7days/init.sh"
aws s3 cp ./backup-to-s3.sh "s3://8dot3/7days/backup-to-s3.sh"
aws s3 cp ./restore-from-s3.sh "s3://8dot3/7days/restore-from-s3.sh"
aws s3 cp ./serverconfig_a20.xml "s3://8dot3/7days/serverconfig_a20.xml"
aws s3 cp ./check-players.sh  "s3://8dot3/7days/check-players.sh"
