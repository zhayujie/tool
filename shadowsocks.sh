#! /bin/bash
function printHelp() {
  echo "Usage: "
  echo "shadowsocks.sh"
  echo "	-p <pac>      Start ss in PAC mode"
  echo "  	-g <global>   Start ss in global mode"			
  echo "    	down          Stop shadowsocks"                          
}

function startSs() {
	screen -ls >/dev/null
	if [ $? -eq 1 ]; then
		screen -L -S ss sslocal -c /etc/shadowsocks/config.json 
		echo "Start shadowsocks"
	fi
}

function checkoutPac() {
	startSs
	m=$(gsettings get org.gnome.system.proxy mode)
	if [ "$m" != "auto" ]; then
		gsettings set org.gnome.system.proxy mode 'auto'
	 	gsettings set org.gnome.system.proxy autoconfig-url file:///etc/shadowsocks/autoproxy.pac
	fi
	echo "Now in PAC mode"
}

function checkoutGlobal() {
	startSs
	m=$(gsettings get org.gnome.system.proxy mode)
	if [ "$m" != "manual" ]; then
		gsettings set org.gnome.system.proxy mode 'manual'
		gsettings set org.gnome.system.proxy.socks host '127.0.0.1'
		gsettings set org.gnome.system.proxy.socks port 1080
	fi
	echo "Now in global mode"
}

function closeSs() {
	gsettings set org.gnome.system.proxy mode 'none'
	screen -S ss -X quit
	echo "Stop shadowsocks"
}


if [[ "$1" == "-p" || -z $1 ]]; then
	checkoutPac
elif [ "$1" == "-g" ]; then
	checkoutGlobal
elif [ "$1" == "down" ]; then
	closeSs
else
	printHelp
fi