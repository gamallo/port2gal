#!/usr/bin/perl -w

# Script baseado no trabalho de Alberto Garcia: http://por2gal.elpiso.org/
# Modificações feitas por Pablo Gamallo
# Para usar este script desde um shell, deves respeitar a seguinte sintaxe:
# cat  input-file  | port2gal.perl  >  output-file
##versão UTF-8

use strict;

binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
binmode STDERR, ':utf8';
use utf8;


#print "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n";
#print " TRANSLITERAÇÃO AUTOMÁTICA AO GALEGO DO ILG-RAG (excusas pelos erros)  \n";
#print "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n";
#print "\n";
#print "\n";

my $vogal =  "AEIOUaeiou";
my $consAll = "bBdDtTpPkKvVfFcCçÇzZkKlLrRnNmMpPjJxXsShHqQgGñÑ";

my $vogalacentuada =  "\[áàéíóúÁÀÉÍÓÚâêîôûüãÃõÕ\]";
my $symbol = "\[\?\!\¿\¡\%\&\/\(\)\+\*\"\=\.\,\;\:\]";
my $WChar = "(\[a-zA-ZñÑáàéíóúÁÀÉÍÓÚçÇâêîôûüãÃõÕ\])";
my $NaoChar = "(\[ \?\!\¿\¡\%\&\/\(\)\+\*\"\'\=\.\,\;\:\])";
my $cons =  "(\[bBdDtTpPkKvVfFcCçÇzZkKlLrRnNmMpPjJxXsShHñÑ\])"; ##faltam q e g
my $crecente =  "(ia|ie|io|ue|ua|uo|gua|guo)";
my $decrecente = "(iu|eu|ei|oi|ou|ai|au)";
my $w = "a-zA-ZñÑáàéíóúÁÀÉÍÓÚçÇâêîôûüãÃõÕäÄëËïÏöÖüÜ";

my $GR = "|cr|br|pr|tr|dr|fr|cl|bl|fl";
my $pronComposto = "|no-lo|no-los|no-la|no-las|vo-lo|vo-los|vo-la|vo-las|se-me|se-te|se-che|se-lle|se-lles|se-nos|se-vos";
my $pron = "|me|te|mos|mas|mo|ma|tos|tas|to|ta|che|cho|cha|chas|chos|lo|los|o|os|la|las|a|as|lle|lles|llo|lla|llos|llas|llelo|llela|se|no|vo|nos|vos|nolo|nolos|nola|nolas|volo|volos|vola|volas|seme|sete|seche|selle|selles|senos|sevos";

#my $sufixV "((?:-m|-lh|-t)?)(e?);


 my @l = qw(
([eE])uropeu(s?) uropeo
((?:[dD]es)?)([nN])ível ivel
((?:[dD]es)?)([nN])íveis iveis
(f)acto(s?) eito
(a)tor(e?s?) ctor
(a)tri(z)(e?s?) ctri
([sS])im i
([aA])té ta
([aA])li lí
([aA])i í
([aA])dvogad- vogad
[aA]çúcar zucre
([aA])ssassínio sasinato
([aA])ssassi- sasi
([aA]nali)s- z
([bB]isa|[aA])vô(s?) bó
([bB]isa|[aA])vó(s?) boa
([aA]ce)it- pt
Adiciona(r|[aáãeéeíoóuú])- Engadi
adiciona(r|[aáãeéeíoóuú])- engadi
Adicion(a|[ms]) Engade
adiciona(a|[ms]) engade
Apresent- Present
apresent- present
([aA])rrast([aáãeéeíoóuú])- rrastr
([aA])ssim sí
([oO])bjet- bject
((?:[rR]e|[dD]es)?)([aA])to(s?) cto
((?:[rR]e|[dD]es)?)([aA])ç(ão|ões) cç
((?:[rR]e|[dD]es)?)([aA])cion- ccion
((?:[rR]e|[dD]es)?)([aA])tiv- ctiv
((?:[rR]e|[dD]es)?)([aA])tua(l|i|idade)(s?) ctua
((?:[rR]e|[dD])?)([eE])strutur- structur
((?:[aA]uto|[rR]e|[dD]es)?)([cC])arreg- arg
([pP]ro)v- b
((?:[dD]es)?)([aA]pro)v- b
([rR]ec)ebe([sm]?) ibe
([rR]ec)eb[ée]- ibi
([rR]ec)eb- ib
ecrã(s?) pantalla
Ecrã(s?) Pantalla
([eE]le)i(ç)- c
([fF])undo(s?) ondo
Frango(s?) Polo
frango(s?) polo
([hH])omem ome
([oO])ntem nte
Mãe(s?) Nai
mãe(s?) nai
Já Xa
já xa
([oO])ntem nte
Cena(s?) Escena
cena(s?) escena
Cenário(s?) Escenário
cenário(s?) escenário
([oO]rd)em e
([oO]rd)ens es
([cC])oluna(s?) olumna
([cC])ristão(s?) ristián
([cC])ristã(s?) ristiá
([dD])ê ea
([dD])ois ous
([dD])ívida(s?) ébeda
([dD])isponív- ispoñíb 
([fF])aculdade(s?) acultade
([fF])ormatação ormato
([fF])ormatações ormatos
([fF]r)ut([ao])(s?) oit
([cC]h)uva(s?) oiva
([lL])uta(s?) oita
Item(s?) Elemento
item(s?) elemento
([oO])xig[êé]nio(s?) síxeno
([tT])u i
((?:d|n|d?aqu)?)ele el
([vV])ocê(s?) ostede
([pP])el([oa]s?) ol
((?:sobre)?)tudo(s?) todo
([cC])ampeã(s?) ampiona
([cC])ampe(ão|ões) ampi
((?:[cC]apit|[eE]st|[iI]rm|[aA]lem|[cC]rist)?)ão(s?) án
((?:[cC]ora|[dD]oa|[hH]iperliga|[lL]iga)?)ção zón
((?:[cC]ora|[dD]oa|[hH]iperliga|[lL]iga)?)ções zóns
((?:[cC]apit|[iI]rm|[aA]lem|[cC]rist)?)ã(s?) á
([Ll])has hela
([Ll])hos helo
([nN])em in
([cC])onteúdo(s?) ontido
([cC])ontrole(s?) ontrol
([qQ])uais ales
([dD])ireit- ereit
([rR]e?)([eE])leit([oa])(s?) lect
Fech- Pech
fech- pech
([gG])uard- ard
([gG])rau(s?)- rao
([hHjJ]o[mv])ens es
Hierarqui- Xerarqui
hierarqui- xerarqui
Hierárquico(s?) Xerárquico
hierárquico(s?) xerárquico
([jJ])ovem ove
([mM])uçulmano(s?) usulmán
([mM])uçulmana(s?) usulmá
([pP])ont(o?|os?|u?)- unt
([pP])ropriedade(s?) ropiedade
([pP])rópri- rópi
([aA]p)ropri- ropi
Pasta Cartafol
Pastas Cartafoles
pasta cartafol
pastas cartafoles
([pP])aine(l|is) ane
Qualquer Calquera
Quaisquer Calquera
qualquer calquera
quaisquer calquera
Quase Case
quase case
Sob Baixo
sob baixo
([tT])rês res
([dD])epois espois
([mM])ais áis
([mM])as ais
([mM])eio édio
([nN])ível ivel
([mM])ui oi
([mM])uit([oa]s?) oit
([pP])essoa([ls]?|is?) ersoa
?(ór)([bpdtkvgfcçzkjxslmnr])ão(s?) ao
((?:[cCdDhHmMpPtTvV])?)ão(s?) an
((?:[cCdDhHmMpPtTvV])?)ães ans
([cC]h)ão(s?) an
([nsNS])ão on
([tT])ambém amén
([aA])ssim s
([eEoO])xig([ei)- six
Enquanto Mentres
enquanto mentres
([cC]re)sc- c
([nN]a)sc- c
([cC]orr|[eE]l)e([gj])- i
([cC]orri|[eE]li)ge- gi
([cC]orri|[eE]li)gê- gí
([cC]on|[dD]i)vir([gj])- ver
([cC]onver|[dD]iver)gi- ge
([cC]onver|[dD]iver)gí- g
([cC]r)i(ação|ações) e
([dD])ormi- urmi
([dD])ormi urmi
([cC]|[eE]nc|[dD]esc)obri- ubri
([cC]|[eE]nc|[dD]esc)obri ubri
([eE]|[sS]obre)stej- ste
?screver scribir
?screver- scribir
?screveu((?:-m|-lh|-t|-ch|-v|-n|-o|-a)?([eoa]?(s?))) scribiu
?screv- scrib
?([vV])iver ivir
?([vV])iver- ivir
?([vV])iveu((?:-m|-lh|-t|-ch|-v|-n|-o|-a)?([eoa]?(s?))) iviu
([cC])onceber oncibir
([cC])onceber- oncibir
([cC])oncebeu((?:-m|-lh|-t|-ch|-v|-n|-o|-a)?([eoa]?(s?))) oncibiu
([cC])onceb- oncib
([rR])ecever ecibir
([rR])ecever- ecibir
([rR])eceveu((?:-m|-lh|-t|-ch|-v|-n|-o|-a)?([eoa]?(s?))) ecibiu
([rR])ecev- ecib
([sS])ou((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) on
([fF])ui((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) un
([fF])oste((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) uches
((?:[aA]|[aA]bs|[eE]s|[cC]on|[dD]e|[mM]an|[oO]b)?)[tT]eve((?:-m|-lh|-t|-ch|-v|-n|-o|-a)?([eoa]?(s?))) tivo
((?:[aA]|[aA]bs|[eE]s|[cC]on|[dD]e|[mM]an|[oO]b)?)[tT]ive((?:-m|-lh|-t|-ch|-v|-n|-o|-a)?([eoa]?(s?))) tivem
([tT])ens((?:-m|-lh|-t|-ch|-v|-n|-o|-a)?([eoa]?(s?))) es
((?:[aA]|[aA]bs|[eE]s|[cC]on|[dD]e|[mM]an|[oO]b)?)téns((?:-m|-lh|-t|-ch|-v|-n|-o|-a)?([eoa]?(s?))) tés
((?:[fF]|[sS]atisf|[lL]iqüef|[dD]esf|[cC]ontraf|[rR]aref|[rR]ef))aç((?:o|a|as|amos|am|ais)?)((?:-m|-lh|-t|-ch|-v|-n|-o|-a)?([eoa]?(s?))) ag
([fF])azem((?:-m|-lh|-t|-ch|-v|-n|-s|o|-a)?([eoa]?(s?))) an
([fF])azes((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) as
([fF])azê-lo(s?) acé-lo
((?:[sS]atisf|[lL]iqüef|[dD]esf|[cC]ontraf|[rR]aref|[rR]ef))azem((?:-m|-lh|-t|-ch|-v|-n|-s|o|-a)?([eoa]?(s?))) án
((?:[sS]atisf|[lL]iqüef|[dD]esf|[cC]ontraf|[rR]aref|[rR]ef))azes((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) ás
((?:[fF]|[sS]atisf|[lL]iqüef|[dD]esf|[cC]ontraf|[rR]aref|[rR]ef))aze((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) ai
((?:[fF]|[sS]atisf|[lL]iqüef|[dD]esf|[cC]ontraf|[rR]aref|[rR]ef))iz((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) ixen
((?:[fF]|[sS]atisf|[lL]iqüef|[dD]esf|[cC]ontraf|[rR]aref|[rR]ef))ez((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) ixo
((?:[fF]|[sS]atisf|[lL]iqüef|[dD]esf|[cC]ontraf|[rR]aref|[rR]ef))iz((?:este|emo(s?)|eram|éreis|ésseis|esse(m|s?)|éssemo(s?)|era(m|s?)|éramo(s?)|er|eres|erdes|erem)?)((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) ix
([hH])á((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) ai
([hH])ás((?:-m|-lh|-t|-ch|-v|-n|-s)?([eoa]?(s?))) as
([hH])á-l([oa](s?)) a-l
((?:[pP]|[aA]ntep|[dD]ep|[dD]ecomp|[Dd]isp|[pP]rop|[Dd]ep|[sS]uperp|[sS]up))ôs((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) uxo
((?:[pP]|[aA]ntep|[dD]ep|[dD]ecomp|[Dd]isp|[pP]rop|[Dd]ep|[sS]uperp|[sS]up))us((?:este|emos|eram|era(s?)|éramos|esse(s?)|éssemos|essem|er|eres|erdes|erem|éreis|ésseis)?)((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) ux
((?:[pP]|[aA]ntep|[dD]ep|[dD]ecomp|[Dd]isp|[pP]rop|[Dd]ep|[sS]uperp|[sS]up))ux uxem
([pP])erc((?:o|a|as|amos|am|ais)?)((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) erd
((?:[eE]s|[cC]on|[dD]e|[mM]an|[oO]b)?)[tT]êm((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) teñen
([vV])êm((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) eñen
((?:[aA]ntev|[pP]rev|[rR]ev|[rR]el|[dD]escr|[eE]ntrev))êem((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) én
((?:[aA]ntev|[pP]rev|[rR]ev|[rR]el|[dD]escr|[eE]ntrev))ê((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) é
((?:[vV]|[lL]|[cC]r))êem((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) en
((?:[vV]|[lL]|[cC]r))ê((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) e
((?:[lL]|[cC]r))ei((?:amos|ais)?)((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) e
((?:[vV]|[lL]|[cC]r))i((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) in
([dD])êem eam
((?:[pP]oss|[eE]vol|[cC]onstr|[dD]estr|[rR]econstr|[aAtrib]|[oO]bstr|[cC]oncl|[dD]istrib|[iI]ncl))uis((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) úes
((?:[pP]oss|[eE]vol|[cC]onstr|[dD]estr|[rR]econstr|[aAtrib]|[oO]bstr|[cC]oncl|[dD]istrib|[iI]ncl))ui((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) úe
((?:[cC]ons|[dD]es|[rR]econs))tróis((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) trúes
([cC]ons|[dD]es|[rR]econs)trói((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) trúe
((?:[cC]ons|[dD]es|[rR]econs))troem((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) trúem
((?:[cC]onstr|[dD]estr|[rR]econstr|[aAtribtr]|[oO]bstr|[cC]oncl|[dD]istrib|[iI]ncl))ui((?:mos|ram|ra(s?)|esse(s?)|essem|res|rdes|rem|u|stes)?)((?:-m[eoa](s?)|-lh[eoa](s?)|-t[eoa](s?)|-ch[eoa](s?)|-vos|-nos|-vo-lo|-no-lo|-se|-o(s?)|-a(s?))?) uí
([vV])ais((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) as
([vV])á((?:s)?)((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) aia
((?:[aA]dv|[cC]onv|[iI]nterv|[pP]rov|[dD]esav|[sS]obrev))ais((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) ás
((?:[vV]|[aA]dv|[cC]onv|[iI]nterv|[pP]rov|[dD]esav|[sS]obrev))ens((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) és
([vV])eio((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) eu
((?:[vV]|[aA]dv|[cC]onv|[iI]nterv|[pP]rov|[dD]esav|[sS]obrev))i(emos|este(s?)|eram|era(s?)|éramos|esse(s?)|éssemos|essem|er|eres|erdes|erem|éreis|ésseis)((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) iñ
([vV])iñeste iñeches
ansei((?:o|a(s?)|[ea]m|e(s?))?) ánsi
ansei((?:o-|a(s?)-|am-)?) ánsi
([aA])nsei(amo|[aá]v|[aá]r|ast)- nsi
([iI])ncendei((?:o|a(s?)|[ea]m|e(s?))?) ncéndi
([iI])ncendei((?:o-|a(s?)-|am-)?) ncéndi
([iI])ncendei(amo|[aá]v|[aá]r|ast)- ncendi
odei((?:o|a(s?)|[ea]m|e(s?))?) ódi
odei((?:o-|a(s?)-|am-)?) ódi
([oO])dei(amo|[aá]v|[aá]r|ast)- di
((?:[mM]|[rR]em))edei((?:o|a(s?)|[ea]m|e(s?))?) édi
((?:[mM]|[rR]em))edei((?:o-|a(s?)-|am-)?) édi
((?:[mM]|[rR]em))edei(amo|[aá]v|[aá]r|ast)- edi
([pP])ro([ií]b)- roh
([pP])ôde((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) uido
([pP])ude((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) uidem
([pP])osso((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) odo
([pP])oss(a(s?)|mo(s?)|m|ais)((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) oid
([pP])ude- uide
([pP])udé- uidé
((?:[pP]|[dD]esp|[iI]mp|[eE]exp||[dD]esimp|[rR]eexp|[mM]|[dD]esm))eç(|a(s?)amo(s?)|am|ais)((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) id
((?:[pP]|[dD]esp|[iI]mp|[eE]exp||[dD]esimp|[rR]eexp|[mM]|[dD]esm))eço((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) ido
((?:[pP]|[aA]nte|[dE]e|[dD]ecom|[iI]dis|[pP]rop|[pP]os|[sS]uperp|[sS]up))ões((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) os
((?:[pP]|[aA]nte|[dE]e|[dD]ecom|[iI]dis|[pP]rop|[pP]os|[sS]uperp|[sS]up))õem((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) oñen
((?:[pP]|[aA]nte|[dE]e|[dD]ecom|[iI]dis|[pP]rop|[pP]os|[sS]uperp|[sS]up))õe((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) on
((?:[dD]|[bB]end|[cC]ond|[cC]ontrad|[pP]re|[mM]ald|[dD]esd))izei(s?) icide
((?:[dD]|[bB]end|[cC]ond|[cC]ontrad|[pP]re|[mM]ald|[dD]esd))izemos icimos
([dD])izes((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) is
([dD])iz((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) i
([dD])izem((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) in
((?:[bB]end|[cC]ond|[cC]ontrad|[pP]re|[mM]ald|[dD]esd))izes((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) ís
((?:[bB]end|[cC]ond|[cC]ontrad|[pP]re|[mM]ald|[dD]esd))iz((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) í
((?:[bB]end|[cC]ond|[cC]ontrad|[pP]re|[mM]ald|[dD]esd))izem((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) ín
((?:[dD]|[bB]end|[cC]ond|[cC]ontrad|[pP]re|[mM]ald|[dD]esd))ize- ici
([eE])scut- scoit
([pP])ergunt- regunt
([dD])iss((?:e|este|emo(s?)|eram|éreis|ésseis|esse(m|s?)|éssemo(s?)|era(m|s?)|éramo(s?))?)((?:-m[eoa]?(s?)|-lh[eoa]?(s?)|-t[e]?(s?)|-ch[eoa]?(s?)|-v[o]?(s?)|-n[o]?(s?)|-s|(s?)-o(s?)|-a(s?))?) ix
([dD])ixe((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) ixo
((?:[qQ]|[rR]eq))uer((?:-m[eoa](s?)|-lh[eoa](s?)|-t[eoa](s?)|-ch[eoa](s?)|-vos|-nos|-vo-lo|-no-lo|-se|-o(s?)|-a(s?))?) uere
((?:[qQ]|[rR]eq))uis((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) uixo
((?:[qQ]|[rR]eq))uis((?:este|emo(s?)|eram|éreis|ésseis|esse(m|s?)|éssemo(s?)|era(m|s?)|éramo(s?)|er|eres|erdes|ermos|erem)?)((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) uix
([tT])raz((?:-m[eoa](s?)|-lh[eoa](s?)|-t[eoa](s?)|-ch[eoa](s?)|-vos|-nos|-vo-lo|-no-lo|-se|-o(s?)|-a(s?))?) rae
([tT])raz([íe])- ra
([tT])raz([ê]-)- ra
([tT])razi- raí
([tT])rag((?:o|a|as|amos|am|ais)?)((?:-m|-lh|-t|-ch|-v|-n|-o|-a)?([eoa]?(s?))) rai
([tT])rouxe((?:-m[eoa](s?)|-lh[eoa](s?)|-t[eoa](s?)|-ch[eoa](s?)|-vos|-nos|-vo-lo|-no-lo|-se|-o(s?)|-a(s?))?) rouxem
((?:[tT]roux|[pP]ux))este((?:-m[eoa](s?)|-lh[eoa](s?)|-t[eoa](s?)|-ch[eoa](s?)|-vos|-nos|-vo-lo|-no-lo|-se|-o(s?)|-a(s?))?) eches
([fF])azem((?:-m|-lh|-t|-ch|-v|-n|-s|o|-a)?([eoa]?(s?))) an
([fF])azes((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) as
((?:[sS]atisf|[lL]iqüef|[dD]esf|[cC]ontraf|[rR]aref|[rR]ef))azem((?:-m|-lh|-t|-ch|-v|-n|-s|o|-a)?([eoa]?(s?))) án
((?:[sS]atisf|[lL]iqüef|[dD]esf|[cC]ontraf|[rR]aref|[rR]ef))azes((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) ás
((?:[fF]|[sS]atisf|[lL]iqüef|[dD]esf|[cC]ontraf|[rR]aref|[rR]ef))az((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) ai
((?:[fF]|[sS]atisf|[lL]iqüef|[dD]esf|[cC]ontraf|[rR]aref|[rR]ef))iz((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) ixen
((?:[fF]|[sS]atisf|[lL]iqüef|[dD]esf|[cC]ontraf|[rR]aref|[rR]ef))ez((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) ixo
((?:[fF]|[sS]atisf|[lL]iqüef|[dD]esf|[cC]ontraf|[rR]aref|[rR]ef))iz((?:este|emo(s?)|eram|éreis|ésseis|esse(m|s?)|éssemo(s?)|era(m|s?)|éramo(s?)|er|eres|erdes|erem|ermos)?)((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) ix
-duz((?:-m|-lh|-t|-ch|-v|-n|-s|-o|-a)?([eoa]?(s?))) uce
((?:[cC]a|[aA]tra|[sS]a|[sS]obresa|[dD]istra))i(s?)((?:-m[eoa](s?)|-lh[eoa](s?)|-t[eoa](s?)|-ch[eoa](s?)|-vos|-nos|-vo-lo|-no-lo|-se|-o(s?)|-a(s?))?) e 
((?:[sS]a|[sS]obresa))iu((?:-m[eoa](s?)|-lh[eoa](s?)|-t[eoa](s?)|-ch[eoa](s?)|-vos|-nos|-vo-lo|-no-lo|-se|-o(s?)|-a(s?))?) íu
((?:[cC]a|[eE]sva|[aA]tra|[dD]istra))iu((?:-m[eoa](s?)|-lh[eoa](s?)|-t[eoa](s?)|-ch[eoa](s?)|-vos|-nos|-vo-lo|-no-lo|-se|-o(s?)|-a(s?))?) eu
((?:[sS]a|[sS]obresa))i((?:sse(m|s?)|ra(m|s?)|res|rem|rmos)?)((?:-m[eoa](s?)|-lh[eoa](s?)|-t[eoa](s?)|-ch[eoa](s?)|-vos|-nos|-vo-lo|-no-lo|-se|-o(s?)|-a(s?))?) í
((?:[cC]a|[eE]sva|[aA]tra|[dD]istra|[dD]escontra))i((?:res|rem|rmos|rdes)?)((?:-m[eoa](s?)|-lh[eoa](s?)|-t[eoa](s?)|-ch[eoa](s?)|-vos|-nos|-vo-lo|-no-lo|-se|-o(s?)|-a(s?))?) e
((?:[cC]a|[eE]sva|[aA]tra|[dD]istra|[dD]escontra))í((?:sse(m|s?)|r|ra(m|s?)|res|rem|rmos|rdes))((?:-m[eoa](s?)|-lh[eoa](s?)|-t[eoa](s?)|-ch[eoa](s?)|-vos|-nos|-vo-lo|-no-lo|-se|-o(s?)|-a(s?))?) e
((?:[cC]a|[eE]sva|[aA]tra|[dD]istra|[dD]escontra))í((?:sse(m|s?)|r|ra(m|s?)|res|rem|ssemos|sseis|ramos|rais))((?:-m[eoa](s?)|-lh[eoa](s?)|-t[eoa](s?)|-ch[eoa](s?)|-vos|-nos|-vo-lo|-no-lo|-se|-o(s?)|-a(s?))?) é
((?:[cC]a|[eE]sva|[aA]tra|[dD]istra|[dD]escontra))ís((?:sse(m|s?)|ra(m|s?)|res|rem|rmos)?)((?:-m[eoa](s?)|-lh[eoa](s?)|-t[eoa](s?)|-ch[eoa](s?)|-vos|-nos|-vo-lo|-no-lo|-se|-o(s?)|-a(s?))?) edes
((?:[dD]|[mM]|[rR]|[rR]em))ôo((?:sse(m|s?)|ra(m|s?)|res|rem|rmos)?)((?:-m[eoa](s?)|-lh[eoa](s?)|-t[eoa](s?)|-ch[eoa](s?)|-vos|-nos|-vo-lo|-no-lo|-se|-o(s?)|-a(s?))?) oio
((?:[dD]|[mM]|[rR]|[rR]em))ói((?:-m[eoa](s?)|-lh[eoa](s?)|-t[eoa](s?)|-ch[eoa](s?)|-vos|-nos|-vo-lo|-no-lo|-se|-o(s?)|-a(s?))?) oe
((?:[mM]|[rR]))o((?:a(m|s?)|amos|ais))((?:-m[eoa](s?)|-lh[eoa](s?)|-t[eoa](s?)|-ch[eoa](s?)|-vos|-nos|-vo-lo|-no-lo|-se|-o(s?)|-a(s?))?) oi
?scer((?:ia(m|s?)|íamo(s?)|íeis|a(m|s?)|es|em|mos)?)((?:-m[eoa](s?)|-lh[eoa](s?)|-t[eoa](s?)|-ch[eoa](s?)|-vos|-nos|-vo-lo|-no-lo|-se|-o(s?)|-a(s?))?) cer
?sc((?:este|ia(m|s?)|íamo(s?)|emo(s?)|ésseis|esse(m|s?)|éssemo(s?))?)((?:-m[eoa](s?)|-lh[eoa](s?)|-t[eoa](s?)|-ch[eoa](s?)|-vos|-nos|-vo-lo|-no-lo|-se|-o(s?)|-a(s?))?) c
([aA])rgúi((?:s)?)((?:-m[eoa](s?)|-lh[eoa](s?)|-t[eoa](s?)|-ch[eoa](s?)|-vos|-nos|-vo-lo|-no-lo|-se|-o(s?)|-a(s?))?) rgüe
((?:[aA]d|[aA]dv|[dD]iv|[cC]onf|[dD]if|[iI]nf|[pP]ref|[pP]rof|[rR]ef|[tT]ransf|[cC]omp|[rR]ep|[cC]onc|[dD]isc|[dD]ig|[iI]ng|[sS]ug|[iI]ns|[rR]efl|[mM]|[pP]|[vV]|[iI]nv|[rR]ev|[rR]equ))e((?:re|rte|te|cte|ste|rne|de))((?:s|m)?)((?:-m[eoa](s?)|-lh[eoa](s?)|-t[eoa](s?)|-ch[eoa](s?)|-vos|-nos|-vo-lo|-no-lo|-se|-o(s?)|-a(s?))?) i
espe((?:s|m)?)((?:-m[eoa](s?)|-lh[eoa](s?)|-t[eoa](s?)|-ch[eoa](s?)|-vos|-nos|-vo-lo|-no-lo|-se|-o(s?)|-a(s?))?) ispe
Espe((?:s|m)?)((?:-m[eoa](s?)|-lh[eoa](s?)|-t[eoa](s?)|-ch[eoa](s?)|-vos|-nos|-vo-lo|-no-lo|-se|-o(s?)|-a(s?))?) Ispe
?([cC]onstit)ui([sm]?) úe
?([lL])ingue(s?) ingüe
?([lL])inguis- ingüis
?([lL])inguís- ingüís
?([pP])rópr- róp
([mM])uit- oit
([cC])oisa(s?) ousa
([mM])au(s?) alo
([mM])á(s?) ala
Relatório(s?) Informe 
relatório(s?) informe
([rR])epto(s?) eto 
([tT])abela(s?) áboa 
([sS])om(a|ar|a-) um
([uU])tente(s?) suário
([jJ])uiz(es|a|as?) uíz
Qua- Ca
qua- ca
Quo- Co
quo- co
([gG]est)ão ón
Gest- Xesti
gest- xesti
([qQ]uest)ão ión
Questi?- Cuesti
questi?- cuesti
([fF])requ(ên|en)- recu
([gG])ov- ob
([hH]a|[dD]e)v- b
([hH]ou)v- b
([dD])ebolv- evolv
([AaEeOoUu])i([lrnm])([bpdtkvgfcçzkjxs])- í
?([bBdDtTpPkKvVfFcCçÇzZkKlLrRnNmMjJxXsShH])([aeou])i([lrnm])([bpdtkvgfcçzkjxs])- í
-([aeou])id([oa])(s?) íd
?([AaEeOoIi])u([lrnm])([bpdtkvgfcçzkjxs])- ú
?([uU]ni)ão ón
([rR]az)ão ón
-(u)ição ción
-(u)ições cións
-([çs])ão ión
-([çs])ões ións
-õe(s?) ón
-ães áns
-([j])ão(s?) ón
-(ch)ão(s?) ón
-rrão rrón
-rão rán
-ão(s?) án
-ã(s?) á
-eio(s?) eo
-eia(s?) ea
-eia(m?) ea
-eie(s?) ee
-eie(m?) ee
-imento(s?) emento
-ói([oa])(s?) oi
-([aei])ram ron
-(g)em e
-(g)ens es
-([áéíóú])vel bel
-([áéíóú])veis beis
-(a|á)va((?:s|mo(s?)|m)?) ba
-(a|á)va((?:s|mo(s?)|m)?-)- ba
-ámos amos
-éu eu
-m n
-nh- ñ
-ss- s
-vr- br
-[ei]ste((?:-m[eoa](s?)|-lh[eoa](s?)|-t[eoa](s?)|-ch[eoa](s?)|-vos|-nos|-vo-lo|-no-lo|-se|-o(s?)|-a(s?))?) iches
-aste((?:-m[eoa](s?)|-lh[eoa](s?)|-t[eoa](s?)|-ch[eoa](s?)|-vos|-nos|-vo-lo|-no-lo|-se|-o(s?)|-a(s?))?) aches
-(g)ens es
?lh- ll
?[çz]([eiéí])? c
?g([eiéíêî])? x
?[ÇZ]([ei])? C
?G([eiéíêî])? X
([nN])eñun ingún
([nN])eñuma ingunha
((?:[nN]|[dD]|[cC]|[dD]?alg)?)[uU]mh?a(s?) unha
([Ss])ão-([\w]+)- om-
([Ss])ou-([\w]*)- om-
([dDvV])ão-([\w]+)- am-
-rão-([\w]+)- rám-
-m-n(o|a|as|os) n-
-m-([\w]*)- n-
-i-l(o|a|as|os) í-l
-([bBdDtTpPkKvVfFcCçÇzZkKlLrRnNmMjJxXsShH])i(-m[eoa](s?)|-ll[eoa](s?)|-ll[eoa](s?)|-t[eoa](s?)|-ch[eoa](s?)|-vos|-nos|-vo-lo|-no-lo|-se|-o(s?)|-a(s?)) ín
-([gq]u)i(-m[eoa](s?)|-ll[eoa](s?)|-ll[eoa](s?)|-t[eoa](s?)|-ch[eoa](s?)|-vos|-nos|-vo-lo|-no-lo|-se|-o(s?)|-a(s?)) ín
pós-- post
);



my $line;
while ($line = <>) {

    chomp $line;
    $line = " $line ";
    $line =~ s/ /  /g;
    $line =~ s/\. / \. /g;
    $line =~ s/\.$/ \. /g;
    $line =~ s/\, / \, /g;
    $line =~ s/\; / \; /g;
    $line =~ s/\?/ \? /g;
    $line =~ s/\!/ \! /g;
    $line =~ s/\[/\[ /g;
    $line =~ s/\]/ \] /g;
    $line =~ s/\(/\( /g;
    $line =~ s/\)/ \) /g;
    $line =~ s/\"/ \" /g;
    
    #print STDERR "$line\n";

    #trocas da lista de pares irregulares $l:
    my $i;
    for ($i=0;$i<$#l;$i+=2) {
      my ($a,$b) = ($l[$i],$l[$i+1]);
      #print STDERR "$a $b\n";
     #$a =~ s/^([^\?-])/(\\W)$1/;
     #$a =~ s/([^\?-])$/$1(\\W)/;
      $a =~ s/^([^\?-])/$NaoChar$1/;
      $a =~ s/([^\?-])$/$1$NaoChar/;

      #$a =~ s/(^-|-$)/(\\w)/g;
      $a =~ s/(^-|-$)/$WChar/gi;
      $a =~ s/(^\?|\?$)/(.)/gi;
      $a =~ s/\)\(//gi;
      #print STDERR "$a $b\n";
      $line =~ s/$a/$1$b$2/g;
      

      #print STDERR "$line\n";
    }
    
    #trocas de mais duma palavra (contracções prep+art e outros...)
    $line =~ s/ con  a(s?) /coa$1 /gi;
    $line =~ s/ con  o(s?) /co$1 /gi;
    $line =~ s/ con  unha(s?) /cunha$1 /gi;
    $line =~ s/ con  un(s?) /cun$1 /gi;
    $line =~ s/ de  unha(s?) /dunha$1 /gi;
    $line =~ s/ de  un(s?) /dun$1 /gi;
    $line =~ s/ en  unha(s?) /nunha$1 /gi;
    $line =~ s/ en  un(s?) /nun$1 /gi;
  #  $line =~ s/(v(o)u|v(as)|v(a)i|v(amos)|v(ades)|v(an))  embora/march$2$3$4$5$6$7/gi;
    

    $line =~ s/ através /a través /gi;
    $line =~ s/ (de|polo)[ ]+fato /$1 feito /gi;
    
    $line =~ s/ (o|um|algum|este|esse|aquel)[ ]+([$w]*)?[ ]+(da)do /$1 $2 $3to /gi;
    $line =~ s/ (os|uns|alguns|estes|esses|aqueles)[ ]+([$w]*)?[ ]+(da)dos /$1 $2 $3tos /gi;
    $line =~ s/ (d|n|pol)(o|um|algum|este|esse|aquel)[ ]+([$w]*)?[ ]+(da)do /$1$2 $3 $4to /gi;
    $line =~ s/ (d|n|pol)(os|uns|alguns|estes|esses|aqueles)[ ]+([$w]*)?[ ]+(da)dos /$1$2 $3 $4tos /gi;


    #trocas de grafias especiais
    $line =~ y/çàãõâêôûjÇÀÃÕÂÊÔÛJ/záaoáéóúxZÁAOÁÉÓÚX/;
         #print STDERR "temp: $line\n";
  
  #troca os futuros com pronomes proclíticos: dar-lhes-emos por daremoslhes.
    
     $line =~  s/á-(l[oa]s?)-([$w]+)/a-$1-$2/i ;
     $line =~  s/é-(l[oa]s?)-([$w]+)/e-$1-$2/i ;
     $line =~  s/í-(l[oa]s?)-([$w]+)/i-$1-$2/i ;     
     $line =~  s/ó-(l[oa]s?)-([$w]+)/o-$1-$2/i ;
     $line =~  s/ú-(l[oa]s?)-([$w]+)/u-$1-$2/i ;
     #print STDERR "inter: temp: $line\n";

     $line =~  s/-l([oa]s?)-eis/rédel-$1/gi;  
     $line =~  s/-l([oa]s?)-íeis/riédel-$1/gi;  
     $line =~  s/-(l[oa]s?)-(ás|emos|ias|íamos)/r$2-$1/gi;
     $line =~  s/-l([oa]s?)-(ei|án|á|ian?)/r$2-$1/gi;   
     
     $line =~  s/s-l([oa]s?)/-l$1/gi;
      
     $line =~  s/-([$w]+)-eis/rédel-$1/gi;  
     $line =~  s/-([$w]+)-íeis/riédel-$1/gi;  
     $line =~  s/-([$w]+)-(ás|emos|ias|íamos)/$2-$1/gi;
     $line =~  s/-([$w]+)-(ei|án|á|emos|ian?)/$2-$1/gi;

	 #print STDERR "temp: $line\n";
    #tira os guioes: 
    # $line =~ s/(?<=\w)á-(?=\w{0,4}$NaoChar)/a/gi;
   # $line =~ s/(?<=\w)-(?=\w{0,4}$NaoChar)//gi;

    $line =~ s/  / /g;
    $line =~ s/^ //g;
    $line =~ s/ $//g;
    #print STDERR "$line\n" ;

    #regras de acentuação:
    my @listPals;
    my $p;
    (@listPals) = split (" ", $line);
    $line="";

    foreach $p (@listPals) {

       ##comia, tio, ...
       if ( ($p !~ /$vogalacentuada/) && 
           ( ($p =~ /$cons(i[aoe])([ns]?)($symbol?)$/i) ||
             ($p =~ /[qg](ui[aoe])([ns]?)($symbol?)$/i) ) )   {

           $p =~ s/i([aoe])([ns]?)($symbol?)$/í$1$2$3/i;

      }
       ##sua, possuo, crua, ...
       elsif (($p !~ /$vogalacentuada/) && 
           ($p =~ /$cons(u[aoe])([ns]?)($symbol?)$/i) ) {

           $p =~ s/u([aoe])([ns]?)($symbol?)$/ú$1$2$3/i

      }

       ## aqui/latim/tabu, ...
       elsif (($p !~ /$vogalacentuada/) && 
           (length($p) >= 4) && 
           ($p !~ /(tui|$decrecente)(s?)($symbol?)$/i) &&
           ($p !~ /^($GR)[aeiou]([nmsx]?)(s?)($symbol?)$/i) ) {

           $p =~ s/i([nmsx]?)($symbol?)$/í$1$2/i;
           $p =~ s/u([nmsx]?)($symbol?)$/ú$1$2/i;
           

      }
       
       ##táxi/júri/bônus
       elsif (($p =~ /$vogalacentuada/) && 
           (length($p) >= 4) && 
           ($p =~ /$cons(i|u)(s?)($symbol?)$/i) ) {
          
	   
           $p =~ y/áéíóú/aeiou/;
       }


        ##/tênue/régua (ditongo crecente...)
       elsif ( ($p =~ /$vogalacentuada/) && 
               ( ($p =~ /$cons($crecente)([sn]?)($symbol?)$/i) ||
                 ($p =~ /[qg]ui[ao]([sn]?)($symbol?)$/i) ) ) {

            $p =~ y/áéíóú/aeiou/;

      }

        ##/espanhóis/caracóis
      elsif ($p =~ /óis($symbol?)$/i) {
          
           $p =~ s/óis($symbol?)$/ois$1/i;
           

      } 

        ##/sair/constituir
      if (($p !~ /$vogalacentuada/) 
           && ($p =~ /$cons(ui|ai|ei)([rln])($symbol?)$/i)  ) {
          
           $p =~ s/i([rln])($symbol?)$/í$1$2/i;
           $p =~ s/u([rln])($symbol?)$/ú$1$2/i;
	   

      }

     


       my $des="";
       my $raiz="";
       my $v="";
       my $first="";
       my $last="";

 ##pronomes compostos: no-las, se-me
       if (($p =~ /[$w]+\-[$w]+\-[$w]+/i) && ($p !~ /[0-9]+\-[0-9]+\-[0-9]+/i) ) {
	   ($raiz, $des) = ($p =~ /([$w]+)-([^ ]+)/i);
           #print STDERR "$raiz - $des\n";
           if ( ($raiz ne "") && ($des ne "")) {	    

               if (pertence ($des, $pronComposto)) {
                 $des =~ s/-//i;
                 $p = $raiz . "-" . $des;
	       } 
            }  
       }
       elsif (pertence ($p, $pronComposto )) {
             $p  =~ s/-//;
       }


        ## acentos de verbos com pronomes: chamo-me > chámome
       if (($p =~ /[$w]+\-[$w]+$/i) && ($p !~ /[0-9]+\-[0-9]+/i) && ($p !~ /[$w]+\-[$w]+\-[$w]+/i)) {
	   ($raiz, $des) = ($p =~ /([$w]+)-([$w]+)/i);
           #print STDERR "$raiz - $des\n";

          ##comiches + o/os
          if ( ($raiz =~ /s$/) && ($des =~ /^[ao]/)) {
              ($raiz =~ s/s$//); 
              ($des =~ s/([oa]s?)/l$1/);
           } 
           #print STDERR "2: $raiz - $des\n";
           if ( ($raiz ne "") && ($des ne "")) {
              ($des =~ s/llos/llelo/i); 
              ($des =~ s/llas/llela/i); 



             if (pertence ($des ,$pron)) {


              if ( ($raiz !~ /$vogalacentuada/) && ($raiz =~ /[$w]*[$consAll][$vogal][$consAll]+[$vogal]([ns]?)$/i) ) {     
                   #print STDERR "OKKK\n";   
                   ($first, $v, $last) = ($raiz =~ /([$w]*)([$vogal])([$consAll]+[$vogal]([ns]?))$/i);

                   if ($v ne "") {
		       $v = PorAcento($v);
                       $p = $first . $v .  $last . $des;
                       #print STDERR "regra1: $v - $raiz\n";
                    }
               }
              elsif ( ($raiz !~ /$vogalacentuada/) && ($raiz =~ /([$w]*)${decrecente}[$w]*[$vogal]([ns]?)$/i) ) {     
                   #print STDERR "OKKK\n";   
                   ($first, $v, $last) = ($raiz =~ /([$w]*)([$vogal])([$vogal][$w]*[$vogal]([ns]?))$/i);

                   if ($v ne "") {
		       $v = PorAcento($v);
                       $p = $first . $v .  $last . $des;
                       #print STDERR "regra1: $v - $raiz\n";
                    }
               }
              elsif ( ($raiz !~ /$vogalacentuada/) && ($raiz =~ /([^ ]+)[qg]u[$vogal]$/i) ) {        
                   ($first, $v, $last) = ($raiz =~ /([^ ]*)([$vogal])(([$consAll]?)[qg]u[$vogal])$/i);

                   if ($v ne "") {
		       $v = PorAcento($v);
                       $p = $first . $v .  $last . $des;
                       #print STDERR "regra1b: $v\n";
                    }
               }

              elsif ( ($raiz !~ /$vogalacentuada/) && ($raiz =~ /[$vogal][$vogal]$/i) &&
                      ($raiz !~ /$decrecente$/) && ($raiz !~ /oio|aio$/) &&
                       ($raiz !~ /[qg]u[$vogal]$/i) )  {        
                     ($first, $v, $last) = ($raiz =~ /([^ ]*)([$vogal])([$vogal])$/i);

                   if ($v ne "") {
		       $v = PorAcento($v);
                       $p = $first . $v .  $last . $des;
                       #print STDERR "regra1b: $v\n";
                    }
               }



	      elsif  ( ($raiz =~ /$vogalacentuada([ns]?)$/) && ($raiz !~ /^é|^dá([ns]?)$/i) ) {
                   ($first, $v, $last) = ($raiz =~ /([$w]*)($vogalacentuada)([ns]?)$/i);
                   if ($v ne "")  {
		       $v = TirarAcento($v);
                       $p = $first . $v . $last . $des;
                       #print STDERR "$first  $v  $last\n";
                    }
	     }
             elsif ($raiz =~ /$vogalacentuada/) {
                      $p = $raiz . $des;
                      #print STDERR "regra3\n";
	     
             }
             ##raiz acaba em ditongo crecente : por acento na primeira vogal
	     elsif ( ($raiz =~ /$crecente[ns]?$/) && ($raiz !~ /que$|gue$/i) &&
                     ($raiz !~ /oio|aio$/) ) {
                ($raiz =~ s/([$w]+)i([aeo][ns]?$)/$1í$2/i);
                ($raiz =~ s/([$w]+)u([aeo][ns]?$)/$1ú$2/i);
                 $p = $raiz . $des;
                 #print STDERR "regra IA\n";
	    }
            elsif ( ($raiz =~ /$decrecente$/) &&  ($des =~ /^[oa]/i) ){
                      $p = $raiz . "n" . $des;
                      #print STDERR "regra3\n";
	     
             }
            
            else {
		  $p = $raiz . $des;
		 # print STDERR "$p..\n";
	      }
           }
	}
       }



    ## corrigir acentos verbos:

      $p =~ s/á(bamos|bades|bamol|badel)/a$1/;
      $p =~ s/á(ramos|rades|ramol|radel)/a$1/;
      $p =~ s/á(semos|sedes|semol|sedel)/a$1/;
      $p =~ s/í(amos|ades|amol|adel)/i$1/;
      $p =~ s/é(semos|sedes|semol|sedel)/e$1/;
      $p =~ s/é(ramos|rades|ramol|radel)/e$1/;
      $p =~ s/í(ramos|rades|ramol|radel)/i$1/;
      $p =~ s/í(semos|sedes|semol|sedel)/i$1/;
      $p =~ s/ú(ñamos|ñades|ñamol|ñadel)/u$1/;
      $p =~ s/í(ñamos|ñades|ñamol|ñadel)/i$1/;
      $p =~ s/ó(semos|sedes|semol|sedel)/o$1/;
      
  
     ## Metacorrecções:

      $p =~ s/^([cC])ontrache/$1ontraste/i;
      $p =~ s/^([nNdDlL])iches$/$1este/i;
      $p =~ s/^([eE])xiches$/$1xiste/i;
      $p =~ s/^([lL])inúx/$1inux/i;
      $p =~ s/^([xX])aba/Java/i;
      $p =~ s/^([mM])aíl/$1ail/i;
      $p =~ s/^([cC])orpús/$1orpus/i;
      $p =~ s/^([pP])lug-ín/$1lug-in/i;
      $p =~ s/^([fF])unctíon/$1unction/i;
      $p =~ s/^([aA])rraches/$1rrastre/i;
      $p =~ s/^([óÓ])rgao/$1rgano/i;
      $p =~ s/^([pP])oída/$1oida/i;
      $p =~ s/bolución/volución/i;
   ##reíntrodr
      $p =~ s/^([Rr])eín/$1ein/i;
      $p =~ s/^([qQ])ueiron/$1ueiran/i;
      $p =~ s/^([fF])iron/$1iran/i;
      $p =~ s/^([sS])orrín/$1orrí/i;
      $p =~ s/^([sS])entencía/$1entencia/i;
      $p =~ s/^([cC])oíncid/$1oicind/i;
       


   ## problemas sintaticos : eu quixo ; son paulo....

    ### so para textos de INFO. 
      #$p =~ s/^clique/prema/;
      #$p =~ s/^Clique/Prema/;
      #$p =~ s/^([cC])élula(s?)/$1ela$2/;

      $line .= $p . " ";
    }

my $SpecialChar = "\?\!\¿\¡\%\&\/\(\)\\\+\*\'\=\.\,\;\:";
    
    $line =~ s/ \. /\. /g;
    $line =~ s/ \; /\; /g;
    $line =~ s/ \, /\, /g;
    $line =~ s/ \? /\? /g;
    $line =~ s/ \! /\! /g;
    $line =~ s/\[ /\[/g;
    $line =~ s/ \] /\] /g;
    $line =~ s/\( /\(/g;
    $line =~ s/ \) /\) /g;
           
    #$line =~ s/\" ([$w]+[$SpecialChar]*) \"/\"$1\"/g;
   # $line =~ s/ ([\]\)\"])($SpecialChar)/$1$2/g;
   
    $line =~ s/\" ([\w ]+) \"/\"$1\"/g;
 #colocar esta na web: 
 #$line =~ s/\" ([$w ]+) \"/\"$1\"/g;
    $line =~ s/ ([\]\)\"])([\W])/$1$2/g;


    
    print "$line\n";
}


sub PorAcento {
    my $result;
    my $x;

    ($x) = $_[0];
    
    
    if ($x eq "a") {$result = "á"};
    if ($x eq "e") {$result = "é"};
    if ($x eq "i") {$result = "í"};
    if ($x eq "o") {$result = "ó"};
    if ($x eq "u") {$result = "ú"};
    if ($x eq "A") {$result = "Á"};
    if ($x eq "E") {$result = "É"};
    if ($x eq "I") {$result = "Í"};
    if ($x eq "O") {$result = "Ó"};
    if ($x eq "U") {$result = "Ú"};
    return $result;

}

sub TirarAcento {
    my $result;
    my $x;

    ($x) = $_[0];
    
    
    if ($x eq "á") {$result = "a"};
    if ($x eq "é") {$result = "e"};
    if ($x eq "í") {$result = "i"};
    if ($x eq "ó") {$result = "o"};
    if ($x eq "ú") {$result = "u"};
    if ($x eq "Á") {$result = "A"};
    if ($x eq "É") {$result = "E"};
    if ($x eq "Í") {$result = "I"};
    if ($x eq "Ó") {$result = "O"};
    if ($x eq "Ú") {$result = "U"};
    return $result;

}


sub pertence {
    my $subcadeia;
    my $cadeia;
    my $temp;

    ($subcadeia) = $_[0];
    ($cadeia) = $_[1];

    $temp = "|" . $subcadeia . "|";
    if (index ($cadeia, $temp) ==-1) {
        return 0;
    }
    else {
        return 1;
    }
}








