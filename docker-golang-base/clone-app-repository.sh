#!/bin/sh


#------------------------------------------------------------------------------
# Cloning app repository ready to go.
#------------------------------------------------------------------------------

echo "Setup APP repository."


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

echo "Setup complete."
