#!/usr/bin/env bash

set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable

source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.config.sh"

sectionHeader "Run composer install"
runOnAppServer "composer install --no-interaction"

sectionHeader "Run install:setup"
runOnAppServer "vendor/bin/typo3cms install:setup --no-interaction --database-user-name=root --database-user-password=dev --database-host-name=mysql --database-port=3306 --database-name=typo3 --admin-user-name=admin --admin-password=supersecret --use-existing-database --site-name=TYPO3"

sectionHeader "Add additional configuration"
runOnAppServer "ln -s /app/configuration/AdditionalConfiguration.php /app/private/typo3conf/AdditionalConfiguration.php"

sectionHeader "Clear the cache"
runOnAppServer "vendor/bin/typo3cms cache:flush"

sectionHeader "Initialize solr connections"
runOnAppServer "vendor/bin/typo3cms solr:updateconnections"
