#!/usr/bin/env bash

set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable

export JAVA_HOME=/usr/lib/jvm/java-8-oracle

export TYPO3_DATABASE_NAME=$CI_DB_NAME
export TYPO3_DATABASE_HOST=$CI_DB_HOST
export TYPO3_DATABASE_USERNAME=$CI_DB_USER
export TYPO3_DATABASE_PASSWORD=$CI_DB_PASSWORD
export PHP_CS_FIXER_VERSION=$CI_PHP_CS_FIXER_VERSION
export TYPO3_VERSION=$CI_TYPO3_VERSION

cd /app/web/typo3conf/ext/solr
./Build/Test/cibuild.sh