#!/bin/sh

#------------------------------------------------------------------------------
# Dependencies go here.
#------------------------------------------------------------------------------
if [ "latest" = "$GOVER" ]; then
  export GOVER="$(wget -q -O - https://golang.org/doc/devel/release.html | grep "<h2 id=\"go" | awk 'BEGIN {FS=OFS=" "}{print $2}' | awk 'BEGIN {FS=OFS="\""}{print $2}'|head -1|awk 'BEGIN {FS=OFS="go"}{print $2}')"
  echo "Lastest detected Go Language version is $GOVER"
fi

echo "Setup Go language version $GOVER."
	echo "Installing Go Language version: $GOVER"
	echo "Go Language installation started ..."
	wget -Lq https://dl.google.com/go/go${GOVER}.${OS}-${ARCH}.tar.gz -O /root/go${GOVER}.${OS}-${ARCH}.tar.gz
	tar -xzf /root/go${GOVER}.${OS}-${ARCH}.tar.gz -C /usr/share/
	rm -Rf /root/go${GOVER}.${OS}-${ARCH}.tar.gz
	chmod 777 ${GOINST}/bin/*
	echo "Go Language v. ${GOVER} installation complete||"
	echo "Go Language version:"
	go version
	echo "Go Language tools installation started ..."
	/root/scripts/install-golang-deps.sh
	echo "Go Language tools complete!!"

echo "Setup complete."
