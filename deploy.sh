#!/bin/sh
git config --global user.name "${GIT_USER_NAME}"
git config --global user.email "${GIT_USER_EMAIL}"
git config -l
cp .travis.settings.xml $HOME/.m2/settings.xml && mvn -e -X clean install deploy scm:tag -Drevision=$(git rev-parse --short HEAD)
