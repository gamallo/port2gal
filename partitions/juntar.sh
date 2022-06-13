
files="./translit/*"
rm juntado.txt
for  file in $(ls -1v $files)
do
    echo $file	
    cat $file >> juntado.txt
done
