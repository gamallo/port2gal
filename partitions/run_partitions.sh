##create temporal folder
mkdir translit
##make partitions:
sh split.sh $1 100000
##execute all partitions in parallel:
sh run
##join all files in a single one (juntados.txt):
sh juntar.sh

##cat juntado.txt |sh postranslit > juntado_limpo.txt

rm -r translit
rm x*
