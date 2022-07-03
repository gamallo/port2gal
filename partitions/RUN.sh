#!/bin/bash
#cat $1 |iconv -f utf-8 -t utf-8 -c > entry.txt
cat $1 |./tirar-palavras-asteriscos.perl | sort |uniq > __x ;
sh run_partitions.sh __x ;
sh juntar.sh ;
paste __x juntado.txt > __xx ;
cat $1  |./colocar-palavras-asteriscos.perl __xx > output.txt
 
##rm -r translit
#rm x*
#rm __x*
#rm juntado.txt


