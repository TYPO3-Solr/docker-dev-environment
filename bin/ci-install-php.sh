cd /home/travis/
wget  https://s3.amazonaws.com/travis-php-archives/binaries/ubuntu/14.04/x86_64/php-${CI_PHP_VERSION}.tar.bz2
tar xjf php-${CI_PHP_VERSION}.tar.bz2 --directory /
/home/travis/.phpenv/bin/phpenv global $CI_PHP_VERSION