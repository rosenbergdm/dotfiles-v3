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

mvfile() {
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
}



for chapter in 01 02 03 04 05 06 07 08 09 $(seq 10 72); do
  case "$chapter" in
    01 | 02 | 03 | 04 | 05 | 06 | 07 | 08 | 09 | 10)
      partn=01
      ;;
    11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 | 19)
      partn=02
      ;;
    20 | 21 | 22)
      partn=03
      ;;
    23 | 24 | 25 | 26)
      partn=04
      ;;
    27 | 28 | 29 | 30 | 31)
      partn=05
      ;;
    32 | 33 | 34 | 35 | 36 | 37 | 38)
      partn=06
      ;;
    39 | 40 | 41 | 42 | 43 | 44 | 45 | 46)
      partn=07
      ;;
    47 | 48 | 49 | 50)
      partn=08
      ;;
    51 | 52 | 53 | 54)
      partn=09
      ;;
    55)
      partn=10
      ;;
    56 | 57 | 58 | 59 | 60 | 61 | 62 | 63 | 64 | 65)
      partn=11
      ;;

    66 | 67 | 68 | 69 | 70 | 71)
      partn=12
      ;;
    72)
      partn=13
      ;;
  esac

  chapterpage="https://connect.springerpub.com/content/book/978-0-8261-6909-9/part/part${partn}/chapter/ch${chapter}"
  pdfurl=$(curl --cookie ~/Downloads/cookies-connect-springerpub-com.txt "$chapterpage" | grep binary | head -n1  | sed -e 's/ /\n/g' | grep content= | sed -e 's/content=.//g' | sed -e 's/"//g')
  outfile="9780826169099_00${chapter}.pdf"

  curl \
    --cookie ~/Downloads/cookies-connect-springerpub-com.txt \
    "$pdfurl" \
    -o "$outfile"

  mvfile "$outfile"

done
