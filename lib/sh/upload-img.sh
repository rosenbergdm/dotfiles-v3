#!/opt/homebrew/bin/bash

upload-img() {
	local fname
	local bfname
	fname="$(gmktemp --suffix=.png)"
	rm -f "$fname"
	/Users/dmr/.nvm/versions/node/v16.10.0/bin/pbimage "$fname"
	bfname="$(basename "$fname")"
	scp "$fname" "gollum@euler.davidrosenberg.me:/home/gollum/wiki.davidrosenberg.me/uploads/$bfname"
	echo "cd wiki.davidrosenberg.me/uploads && git add $bfname && git commit -m imgcopy && git push" | ssh gollum@euler.davidrosenberg.me
	echo "https://wiki.davidrosenberg.me/uploads/$bfname" | pbcopy
	rm $fname
	open "$(pbpaste)"
}
