FROM ubuntu:19.10

ARG GO_GIT_USER
ARG GO_GIT_EMAIL
ARG GO_SVN_REPO
ARG GO_SVN_BRANCH
ARG GO_APP_REPO
ARG GO_APP_USER
ARG GO_APP_NAME
ARG GO_VERSION=latest

ENV GOINST=/usr/share/go\
	GOPATH=/root/go
ENV PATH=${PATH}:${GOPATH}/bin:${GOINST}/bin\
    GOVER=${GO_VERSION}\
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
RUN chmod +x /root/install-golang.sh &&\
 mv /docker-entrypoint.sh /entrypoint.sh &&\
 chmod +x /entrypoint.sh &&\
 sh /root/install-golang.sh
RUN rm -f /root/install-golang.sh
RUN echo -e "\n\n" | ssh-keygen -t rsa -f /root/.ssh/id_rsa
RUN git config --global user.name "${GIT_USER}" &&\
 git config --global user.email "${GIT_EMAIL}" &&\
 mkdir -p /usr/shared/app

VOLUME /usr/shared/app

ENTRYPOINT ["/docker-entrypoint.sh"]
 
