#!/usr/bin/env bash

settruecolor (){
    if [[ -z "$1" ]]; then
        echo "USAGE: settruecolor RED GREEN BLUE";
        echo "  Ex: \$ > echo \"\$(settruecolor 100 200 50)Hello\"";
        printf "         \x1b[38;2;100;200;50mHello\n";
        return 1;
    fi;
    red="$1";
    green="$2";
    blue="$3";
    printf "\x1b[38;2;%d;%d;%dm" "$red" "$green" "$blue"
}

resettruecolor (){
    printf "\x1b[0m"
}

if [[ "z$1" == "z" ]]; then
  # no param
  IFS= read -r fname;
else
  fname="$1";
fi;
tmpf=$(gmktemp)
pdf2txt.py -o "$tmpf" "$fname"
inputline="$(head -n1 "$tmpf")"
chapno="$(echo "$inputline" | awk '{print $1}')";
chname="$(echo "$inputline" |  perl -p -e 's/.*\W*//g' | tr A-Z\  a-z_ )"
newname="ch_${chapno}_${chname}.pdf";
mv "$fname" "$newname"
rm "$tmpf"
echo "Moved $(settruecolor 200 50 100)${fname} to $(settruecolor 100 200 50)${newname}$(resettruecolor)"




