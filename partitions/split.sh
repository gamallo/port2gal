split -l $2 -d $1
rm run
files="./x*"
i=0
for  file in $files
do	
   echo "cat $file |../port2gal.perl > ./translit/$i" >> run
   i=`expr $i + 1`
done
echo "wait" >> run
