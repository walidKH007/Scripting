#!/bin/bash
##################C2#######################
####### add_files.sh###########
echo " The files/directories that you want to add for synchronization are : $* "

for i in $*
do
	cp $i dossier2/
done

echo " le dossier est pour pour se synchronizer "

####### file_update.sh#####
#!/bin/bash

var=`rsync -avun /root/dossier2 root@10.0.2.17:/root/sync | grep -v sent | grep -v total | grep -v sending | sed 1d`
if [ $? -eq 0 ]; then

   echo -e "les fichiers qui sont mise a jour sont : \n$var "
else
   echo "pas de modifs "
fi

#### sync_files.sh (with log) ########
rsync -av --update --progress --log-file=C2.log /root/dossier2 root@10.0.2.17:/root/sync

if [ $? -eq 0 ]; then

   echo "Files are synced successfully "

else

   echo "Error while running the command"

fi

#########################C3###########################
####### add_files.sh###########
echo " The files/directories that you want to add for synchronization are : $* "

for i in $*
do
	cp $i dossier3/
done

echo " le dossier est pour pour se synchronizer "

####### file_update.sh#####
#!/bin/bash

var=`rsync -avun /root/dossier3 root@10.0.2.17:/root/sync | grep -v sent | grep -v total | grep -v sending | sed 1d`
if [ $? -eq 0 ]; then

   echo -e "les fichiers qui sont mise a jour sont : \n$var "
else
   echo "pas de modifs "
fi

#### sync_files.sh (with log) ########
rsync -av --update --progress --log-file=C3.log /root/dossier3 root@10.0.2.17:/root/sync

###################### Host Script ##########################
###### Add_files_sync.sh####
#!/bin/bash
#### Adding file for syncing in C2 And C3 ###########

echo "Files to add to sync repository in C2 :"

#lxc-attach -n C2 -- /root/./add_files.sh f1

lxc-attach -n C2 -- bash /root/add_files.sh /root/f1

echo "Files to add to sync repository in C3 :"

#lxc-attach -n C3 -- /root/./add_files.sh file1


lxc-attach -n C3 -- bash /root/add_files.sh /root/file1

echo "Files are Added successfuly to sync repository"
######## files_sync.sh #########

#!/bin/bash

echo "*******Sync process in C2*******"

lxc-attach -n C2 -- /root/./sync_files.sh

echo "*******Sync process in C3*******"

lxc-attach -n C3 -- /root/./sync_files.sh

#######version_files_sync.sh#########

#!/bin/bash

##### Testing the version of Files in C1,C2 and C3

echo "****** In C2 *******"

lxc-attach -n C2 -- /root/./file_update.sh

echo "****** In C3 *******"

lxc-attach -n C3 -- /root/./file_update.sh
