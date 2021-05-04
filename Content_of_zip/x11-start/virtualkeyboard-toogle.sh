#/bin/bash
test=`pgrep xvkbd`

if [ $test -eq $zero ]; then
	xvkbd &
else
	kill -9 $test
fi

exit

