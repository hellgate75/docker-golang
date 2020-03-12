FROM ubuntu:19.10

ENV GOINST=/usr/share/go/bin\
	GOPATH=/root/go\
    PATH=${PATH}:${GOPATH}/bin:${GOINST}\
    GOVER=go1.14\
    OS=linux\
    ARCH=amd64\
	GO_CMD=\
	GO_ARGS=

#RUN export GOVER="$(wget -q -O - https://golang.org/doc/devel/release.html | grep "<h2 id=\"go" | awk 'BEGIN {FS=OFS=" "}{print $2}' | awk 'BEGIN {FS=OFS="\""}{print $2}'|head -1)" &&\
WORKDIR /root
COPY ./install-golang.sh /root
COPY ./docker-entrypoint.sh /
RUN chmod +x  /root/install-golang.sh &&\
chmod +x  /docker-entrypoint.sh &&\
sh /root/install-golang.sh
COPY ~/.ssh/id_rsa /root/.ssh
COPY ~/.ssh/id_rsa.pub /root/.ssh
RUN wget -Lq https://dl.google.com/go/go${GOVER}.${OS}-${ARCH}.tar.gz -O /root/go${GOVER}.${OS}-${ARCH}.tar.gz &&\
	tar -xzf /root/go${GOVER}.${OS}-${ARCH}.tar.gz -C /usr/share/ &&\
	rm -Rf /root/go${GOVER}.${OS}-${ARCH}.tar.gz &&\
	go get -u  github.com/mdempsky/gocode > /dev/null 2>&1 &&\
	go get -u golang.org/x/tools/... > /dev/null 2>&1 &&\
	go get -u github.com/golang/dep/cmd/dep > /dev/null 2>&1 &&\
	go get -u golang.org/x/lint github.com/golang/lint github.com/golang/lint/golint > /dev/null 2>&1 &&\
	go version

ENTRYPOINT ["/docker-entrypoint.sh"]
 
