#!/usr/bin/env bash

set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

isHTTP200 ()
{
  response=$(curl --write-out %{http_code} --silent --output /dev/null "${1}")
  if [ $response -eq "200" ] ; then
     return 0
  fi

  return 1
}

isHTTP200 "http://127.0.0.1:8000/typo3/" || { echo "Backend not available" ; exit 1; }

echo "All fine";
exit 0;