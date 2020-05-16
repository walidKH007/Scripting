#¡/bin/bash

# stop de container 

oldIFS=$IFS

exp=$(echo $1|grep \*)
echo $exp
if [ $exp ]
then
	echo " tentative de stoppage de " ${var} 
	list_container=$(lxc-ls)
	mot_sans_etoil=$(echo $1 | tr -d "*")
		
	list_final=$(echo $list_container | grep $mot_sans_etoil)

	echo $list_final
	IFS=' '
	for i in $list_final
	do
		echo $i
		lxc-stop -n $i
		if [ $? -ne 0 ]
		then
			echo " le stop a echoue ! " 
			exit 1
		fi
		echo "le stop de :" $i " : ok"
	done
	IFS=$oldIFS
else  

	lxc-stop -n $1
	if [ $? -ne 0 ]
	then
		echo " le stop a echoue ! "
		exit 1
	fi
	echo " stop du container en arg: " $1 " : ok !" 
fi
echo "---- etat des container ----" 
lxc-ls --fancy

echo "----------------------------"
