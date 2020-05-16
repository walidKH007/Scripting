#¡/bin/bash

# destruction de container 

oldIFS=$IFS

exp=$(echo $1|grep \*)
echo $exp
if [ $exp ]
then
	echo " tentative de supression de " ${var} 
	list_container=$(lxc-ls)
	mot_sans_etoil=$(echo $1 | tr -d "*")
		
	list_final=$(echo $list_container | grep $mot_sans_etoil)

	echo $list_final
	IFS=' '
	for i in $list_final
	do
		echo $i
		lxc-destroy -n $i
		if [ $? -ne 0 ]
		then
			echo " la destruction a echoue ! " 
			exit 1
		fi
		echo "la destruction de :" $i " : ok"
	done
	IFS=$oldIFS
else  

	lxc-destroy -n $1
	if [ $? -ne 0 ]
	then
		echo " le destruction a echoue ! "
		exit 1
	fi
	echo " destruction du container en arg: " $i " : ok !" 
fi
echo "/----- Etat des containers -----/"
lxc-ls --fancy

echo "-------------------------------"
