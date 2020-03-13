<p align="center">
<image width="120" height="90" src="../images/101-docker-logo.png"></image>&nbsp;
<image width="350" height="550" src="../images/golang-logo.png">
&nbsp;<image width="120" height="90" src="../images/docker-logo.png"></image>
</p><br/>

# Docker Go-language base image
Go Language docker base image



## Characteristics

Docker image exposes or declares or exposes:


Variables:

* GOVER -> Go Language version
* GO_CMD -> Go language custom command, for testing, bulding and running the application
* GIT_USER -> Argument GO_GIT_USER -> svn configured user name
* GIT_EMAIL -> Argument GO_GIT_EMAIL -> svn configured user email
* SVN_REPO -> Argument GO_SVN_REPO -> svn project repository (clone and/or pull on container start-up) 
* SVN_BRANCH -> Argument GO_SVN_BRANCH -> Working svn repository branch
* APP_REPO -> Argument GO_APP_REPO -> repository as defined in $GOPATH/src [e.g.: github.com]
* APP_USER -> Argument GO_APP_USER -> repository as defined in $GOPATH/src/$GO_APP_REPO [e.g.: my-svn-user]
* APP_NAME -> Argument GO_APP_NAME -> repository name defined in $GOPATH/src/$GO_APP_REPO/$GO_APP_USER

Latest 3 variables defines the path under the GOPATH for the project source, related to automate build, and link sources inside the GOPATH.


Ports:

* (none)


Volumes:

* /usr/shared/app - containiing eventually svn repository base folder


Commands:

* (none)


Emtry Points:

* [docker-entry-point.sh](./docker-entry-point.sh) - compute multiple functions: install/reintall go language, clone or pull svn repository, execute container command line commands


## Build

We provide [build-docker0image.sh](./build-docker0image.sh) script file, that belongd to the [golang.env](./golang.env) arguments file. 

It's parsed by the shell script in the build command.

Note important 


## License

The library is licensed with [LGPL v. 3.0](/LICENSE) clauses, with prior authorization of author before any production or commercial use. Use of this library or any extension is prohibited due to high risk of damages due to improper use. No warranty is provided for improper or unauthorized use of this library or any implementation.

Any request can be prompted to the author [Fabrizio Torelli](https://www.linkedin.com/in/fabriziotorelli) at the follwoing email address:

[hellgate75@gmail.com](mailto:hellgate75@gmail.com)