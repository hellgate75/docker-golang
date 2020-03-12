#!/bin/sh
git config --global user.name "${GIT_USER}"
git config --global user.email "${GIT_EMAIL}"
if [ "" = "$(which go)" ]; then
	echo "Installing Go Language version: $GOVER"
	if [ "latest" = "$GOVER" ]; then
		export GOVER="$(wget -q -O - https://golang.org/doc/devel/release.html | grep "<h2 id=\"go" | awk 'BEGIN {FS=OFS=" "}{print $2}' | awk 'BEGIN {FS=OFS="\""}{print $2}'|head -1|awk 'BEGIN {FS=OFS="go"}{print $2}')"
		echo "Lastest detected Go Language version is $GOVER"
	fi
	echo "Go Language installation started ..."
	wget -Lq https://dl.google.com/go/go${GOVER}.${OS}-${ARCH}.tar.gz -O /root/go${GOVER}.${OS}-${ARCH}.tar.gz
	tar -xzf /root/go${GOVER}.${OS}-${ARCH}.tar.gz -C /usr/share/
	rm -Rf /root/go${GOVER}.${OS}-${ARCH}.tar.gz
	echo "Go Language v. ${GOVER} installation complete||"
	echo "Go Language version:"
	go version
	echo "Go Language tools installation started ..."
	go get -u  github.com/mdempsky/gocode > /dev/null 2>&1 &&\
	go get -u golang.org/x/tools/... > /dev/null 2>&1 &&\
	go get -u github.com/golang/dep/cmd/dep > /dev/null 2>&1 &&\
	go get -u golang.org/x/lint github.com/golang/lint github.com/golang/lint/golint > /dev/null 2>&1
	echo "Go Language tools complete!!"
fi
if [ 0 -eq $# ]; then
    if [ "" != "$GO_CMD" ] && [ "" != "$GO_ARGS" ]; then
		echo "Running provided command: ${GO_CMD} ${GO_ARGS}"
		sh -c "${GO_CMD} ${GO_ARGS}" 
	else
		echo "Executing shell command: $@"
		sh -c "$@"
    fi
else
	echo "Executing shell command: $@"
	sh -c "$@"
fi
