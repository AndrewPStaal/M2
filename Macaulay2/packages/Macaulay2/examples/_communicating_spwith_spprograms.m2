run "uname -a"
peek get "!uname -a"
f = openInOut "!egrep '^in'"
scan(keys Macaulay2Core.Dictionary, key -> f << key << endl)
f << closeOut
get f
f = openIn "!sleep 5; echo -n the answer is 4"
isReady f
while not isReady f do (sleep 1; << "." << flush)
read f
isReady f
atEndOfFile f
close f
