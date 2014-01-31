echo `vboxmanage list vms | gsort -R | head -1 | sed 's/.*"\(.*\)"[^"]*$/\1/'`
