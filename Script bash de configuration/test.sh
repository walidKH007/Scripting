#STR=$(ls *$walid*)

#echo $STR | cut -d'-' -f 3

#filename=$(ls *$walid*)

#number=$(ls *walid* | awk -F - '{ print $3 }')

#echo $number

name=walid-info
if [[ -e $name || -L $name ]] ; then
    i=0
    while [[ -e $name-$i || -L $name-$i ]] ; do
        let i++
    done
    name=$name-$i
fi
touch -- "$name"
