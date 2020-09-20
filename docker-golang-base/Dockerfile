FROM ubuntu:19.10

ARG GO_GIT_USER
ARG GO_GIT_EMAIL
ARG GO_SVN_REPO
ARG GO_SVN_BRANCH
ARG GO_APP_REPO
ARG GO_APP_USER
ARG GO_APP_NAME
ARG GO_VERSION=1.15

ENV GOINST=/usr/share/go\
	GOPATH=/root/go
ENV PATH=${PATH}:${GOPATH}/bin:${GOINST}/bin\
    GOVER=${GO_VERSION}\
    OS=linux\
    ARCH=amd64\
	GO_CMD=\
	GIT_SERVER=${GO_GIT_SERVER}\
	GIT_USER=${GO_GIT_USER}\
	GIT_EMAIL=${GO_GIT_EMAIL}\
	VOLUME_PATH=/usr/shared/app\
	SVN_REPO=${GO_SVN_REPO}\
	SVN_BRANCH=${GO_SVN_BRANCH}\
	APP_REPO=${GO_APP_REPO}\
	APP_USER=${GO_APP_USER}\
	APP_NAME=${GO_APP_NAME}

WORKDIR /root
RUN mkdir /root/scripts
COPY ./install-golang-precond.sh /root/scripts
COPY ./install-golang-deps.sh /root/scripts
COPY ./install-golang-version.sh /root/scripts
COPY ./clone-app-repository.sh /root/scripts
COPY ./run-golang-app.sh /root/scripts
COPY ./docker-entrypoint.sh /
RUN chmod +x /root/scripts/install-golang-precond.sh &&\
 chmod +x /docker-entrypoint.sh &&\
 chmod +x /root/scripts/install-golang-version.sh &&\
 chmod +x /root/scripts/clone-app-repository.sh &&\
 chmod +x /root/scripts/run-golang-app.sh &&\
 sh -c /root/scripts/install-golang-precond.sh &&\
 sh -c /root/scripts/install-golang-version.sh &&\
 rm -f /root/scripts/install-golang-*
RUN echo -e "\n\n" | ssh-keygen -t rsa -f /root/.ssh/id_rsa
RUN git config --global user.name "${GIT_USER}" &&\
 git config --global user.email "${GIT_EMAIL}" &&\
 mkdir -p /usr/shared/app

VOLUME /usr/shared/app

ENTRYPOINT ["/docker-entrypoint.sh"]
 
