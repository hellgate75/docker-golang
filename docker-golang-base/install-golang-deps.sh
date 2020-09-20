#!/bin/bash

# safeGoGet will get the go tool, checking to see if it exists first and doing
# a little additional messaging
function safeGoGet() {
  binname=$(basename $1)
  echo "Checking for ${binname} on the path..."
  if [ ! -x "$(command -v ${binname})" ]; then 
    echo -n "Getting ${binname} from $1..."
    go get -u $1
    echo "Done."
  fi
}


export GO111MODULE=on


#------------------------------------------------------------------------------
# Dependencies go here.
#------------------------------------------------------------------------------

echo "Setup Go tools."


# go-junit-report is used by the test scripts to generate report output readable
# by CI tools that can read JUnit reports
safeGoGet github.com/jstemmer/go-junit-report

# gcov is used to generate coverage information in a report that can be read
# by CI tools
safeGoGet github.com/axw/gocov/gocov
safeGoGet github.com/AlekSi/gocov-xml
safeGoGet github.com/matm/gocov-html

# golangci-lint is a lint aggregator used in the lint.sh script to lint the
# go and terraform code.
safeGoGet github.com/golangci/golangci-lint/cmd/golangci-lint

# gosec is used for checking the code for security problems
safeGoGet github.com/securego/gosec/cmd/gosec

# gosec is used for checking the code for security problems
safeGoGet github.com/securego/gosec/cmd/gosec

safeGoGet golang.org/x/tools/...

ln -s -T /root/go/bin/golangci-lint /root/go/bin/golint

echo "Setup complete."
