#!/bin/sh
FOLDER="$(realpath "$(dirname "$0")")"
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
	if [ ! -e ${VOLUME_PATH}/${APP_NAME} ]; then
		if [ "" != "${SVN_REPO}" ]; then
			echo "Cloning git repo ${SVN_REPO} in volume path"
			cd ${VOLUME_PATH}
			git clone ${SVN_REPO}
			cd ${APP_NAME}
			git checkout ${SVN_BRANCH:-master}
		else
			echo "No git repo to clone (variable \$SVN_BRANCH) ..."
		fi
	else
		cd ${VOLUME_PATH}/${APP_NAME}
		echo "pulling from branch: ${SVN_BRANCH:-master} ..."
		git fetch
		git pull origin ${SVN_BRANCH:-master}
	fi
	if [ ! -e ${GOPATH}/src/${APP_REPO}/${APP_USER} ]; then
		mkdir -p "${GOPATH}/src/${APP_REPO}/${APP_USER}"
	fi
	GO_PROJECT_FOLDER="${GOPATH}/src/${APP_REPO}/${APP_USER}/${APP_NAME}"
	if [ ! -e ${GO_PROJECT_FOLDER} ]; then
		echo "Creating link in go sources path: ${GO_PROJECT_FOLDER} ..."
		ln -s -T ${VOLUME_PATH}/${APP_NAME} ${GO_PROJECT_FOLDER}
	fi
fi

if [ 0 -eq $# ]; then
    if [ "" != "$GO_CMD" ]; then
		if [ "" != "${APP_REPO}" ] && [ "" != "${APP_USER}" ] && [ "" != "${APP_NAME}" ]; then
			GO_PROJECT_FOLDER="${GOPATH}/src/${APP_REPO}/${APP_USER}/${APP_NAME}"
			if [ -e $GO_PROJECT_FOLDER ]; then
				cd $GO_PROJECT_FOLDER
			else
				if [ -e ${VOLUME_PATH}/${APP_NAME} ]; then
					cd ${VOLUME_PATH}/${APP_NAME}
				else
					cd ${VOLUME_PATH}
				fi
			fi
		fi
		echo "Running provided command: ${GO_CMD} ${GO_ARGS} in folder $(pwd)"
		sh -c "${GO_CMD} ${GO_ARGS}" 
	else
		echo "Executing shell command: $@"
		sh -c "$@"
    fi
else
	echo "Executing shell command: $@"
	sh -c "$@"
fi
