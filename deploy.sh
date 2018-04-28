#!/bin/sh
git config --global user.name "${GIT_USER_NAME}"
git config --global user.email "${GIT_USER_EMAIL}"
cp .travis.settings.xml $HOME/.m2/settings.xml && git config -l &&  mvn clean install deploy scm:tag -Drevision=$(git rev-parse --short HEAD)
