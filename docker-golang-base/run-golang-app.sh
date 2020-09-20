#!/bin/sh


#------------------------------------------------------------------------------
# Cloning app repository ready to go.
#------------------------------------------------------------------------------

echo "Running Go application: ${APP_NAME}"


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


echo "Application: ${APP_NAME} exited!!"
