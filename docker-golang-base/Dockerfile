FROM ubuntu:19.10

ENV GOINST=/usr/share/go/bin\
	GOPATH=/root/go\
    PATH=${PATH}:/root/go/bin:/usr/share/go/bin\
    GOVER=1.14\
    OS=linux\
    ARCH=amd64\
	GO_CMD=\
	GO_ARGS=\
	GIT_USER=hellgate75\
	GIT_EMAIL=hellgate75@gmail.com

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
 chmod 777 ${GOINST}/*
RUN echo -e "\n\n" | ssh-keygen -t rsa -f /root/.ssh/id_rsa
RUN git config --global user.name "${GIT_USER}" &&\
git config --global user.email "${GIT_EMAIL}" &&\
go get -u  github.com/mdempsky/gocode &&\
go get -u golang.org/x/tools/... &&\
go get -u github.com/golang/dep/cmd/dep &&\
go get -u golang.org/x/lint github.com/golang/lint github.com/golang/lint/golint &&\
go version

ENTRYPOINT ["/docker-entrypoint.sh"]
 
