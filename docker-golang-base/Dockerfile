FROM ubuntu:19.10

ENV GOINST=/usr/share/go\
	GOPATH=/root/go
ENV PATH=${PATH}:${GOPATH}/bin:${GOINST}/bin\
    GOVER=1.14\
    OS=linux\
    ARCH=amd64\
	GO_CMD=\
	GIT_USER=${GO_GIT_USER}\
	GIT_EMAIL=${GO_GIT_EMAIL}\
	VOLUME_PATH=/usr/shared/app\
	SVN_REPO=${GO_SVN_REPO}\
	SVN_BRANCH=${GO_SVN_BRANCH}\
	APP_REPO=${GO_APP_REPO}\
	APP_USER=${GO_APP_USER}\
	APP_NAME=${GO_APP_NAME}

WORKDIR /root
COPY ./install-golang.sh /root
COPY ./docker-entrypoint.sh /
RUN chmod 777  /root/install-golang.sh &&\
 chmod 777  /docker-entrypoint.sh &&\
 sh /root/install-golang.sh
RUN rm -f /root/install-golang.sh &&\
 wget -Lq https://dl.google.com/go/go${GOVER}.${OS}-${ARCH}.tar.gz -O /root/go${GOVER}.${OS}-${ARCH}.tar.gz &&\
 tar -xzf /root/go${GOVER}.${OS}-${ARCH}.tar.gz -C /usr/share/ &&\
 rm -Rf /root/go${GOVER}.${OS}-${ARCH}.tar.gz &&\
 chmod 777 ${GOINST}/bin/*
RUN echo -e "\n\n" | ssh-keygen -t rsa -f /root/.ssh/id_rsa
RUN git config --global user.name "${GIT_USER}" &&\
 git config --global user.email "${GIT_EMAIL}" &&\
 go get -u  github.com/mdempsky/gocode &&\
 go get -u golang.org/x/tools/... &&\
 go get -u github.com/golang/dep/cmd/dep &&\
 go version &&\
mkdir -p /usr/shared/app

VOLUME /usr/shared/app

ENTRYPOINT ["/docker-entrypoint.sh"]
 
