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
	chmod 777 ${GOINST}/bin/*
	echo "Go Language v. ${GOVER} installation complete||"
	echo "Go Language version:"
	go version
	echo "Go Language tools installation started ..."
	go get -u  github.com/mdempsky/gocode &&\
	go get -u golang.org/x/tools/...  &&\
	go get -u github.com/golang/dep/cmd/dep &&\
	go get -u github.com/golangci/golangci-lint/cmd/golangci-lint &&\
	ln -s -T /root/go/bin/golangci-lint /root/go/bin/golint
	echo "Go Language tools complete!!"
fi
# 	APP_REPO=github.com\
# 	APP_USER=\
# 	APP_NAME=

if [ "" != "${APP_REPO}" ] && [ "" != "${APP_USER}" ] && [ "" != "${APP_NAME}" ]; then
	if [ "" = "$(ls ${VOLUME_PATH}/)" ]; then
		if [ "" != "${SVN_REPO}" ]; then
			echo "Cloning git repo ${SVN_REPO} in volume path"
			git clone ${SVN_REPO} ${VOLUME_PATH}
			git checkout ${SVN_BRANCH:-master}
		else
			echo "No git repo to clone (variable \$SVN_BRANCH) ..."
		fi
	else
		echo "pulling from branch: ${SVN_BRANCH:-master} ..."
		git fetch
		git pull origin ${SVN_BRANCH:-master}
	fi
	GO_PROJECT_FOLDER="${GOPATH}/src/${APP_REPO}/${APP_USER}/${APP_NAME}"
	if [ "" = "$(ls ${GO_PROJECT_FOLDER}/)" ]; then
		echo "Creating link in go sources path: ${GO_PROJECT_FOLDER} ..."
		ln -s -T ${VOLUME_PATH} ${GO_PROJECT_FOLDER}
	fi
fi
if [ 0 -eq $# ]; then
    if [ "" != "$GO_CMD" ] && [ "" != "$GO_ARGS" ]; then
		echo "Running provided command: ${GO_CMD} ${GO_ARGS}"
		sh -c "${GO_CMD}" 
	else
		echo "Executing shell command: $@"
		sh -c "$@"
    fi
else
	echo "Executing shell command: $@"
	sh -c "$@"
fi
