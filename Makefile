ARGS = $(filter-out $@,$(MAKECMDGOALS))
MAKEFLAGS += --silent

list:
	sh -c "echo; $(MAKE) -p no_targets__ | awk -F':' '/^[a-zA-Z0-9][^\$$#\/\\t=]*:([^=]|$$)/ {split(\$$1,A,/ /);for(i in A)print A[i]}' | grep -v '__\$$' | grep -v 'Makefile'| sort"

#############################
# Setup
#############################

setup: new wait build

#############################
# Docker machine states
#############################

new:
	docker-compose pull
	docker-compose rm --force app
	docker-compose build --no-cache --pull
	docker-compose up -d --force-recreate

up:
	docker-compose up -d

start:
	docker-compose start

stop:
	docker-compose stop

down:
	docker-compose down --remove-orphans --volumes

state:
	docker-compose ps

rebuild:
	docker-compose stop
	docker-compose pull
	docker-compose rm --force app
	docker-compose build --no-cache --pull
	docker-compose up -d --force-recreate

#############################
# MySQL
#############################

mysql-backup:
	bash ./bin/backup.sh mysql

mysql-restore:
	bash ./bin/restore.sh mysql

mysql-rm:
	docker-compose rm mysql

#############################
# Solr
#############################

solr-backup:
	bash ./bin/backup.sh solr

solr-restore:
	bash ./bin/restore.sh solr

#############################
# General
#############################

backup:  mysql-backup  solr-backup
restore: mysql-restore solr-restore

build:
	bash bin/build.sh

test:
	bash bin/test.sh

clean:
	docker-compose down --remove-orphans --volumes
	test -d app/vendor & rm -rf app/vendor
	test -d app/web & rm -rf app/web

bash: shell

shell:
	docker-compose exec --user application app /bin/bash -i

root:
	docker-compose exec --user root app /bin/bash -i

wait:
	sleep 10

#############################
# Docker
#############################

docker-prune:
	docker system prune --all

#############################
# Composer
#############################

composer:
	docker-compose exec --user application app composer $(ARGS)

#############################
# TYPO3
#############################

cli:
	docker-compose run --rm --user application app cli $(ARGS)

scheduler:
	# TODO: remove the workaround "; (exit $?)" when https://github.com/docker/compose/issues/3379 has been fixed
	docker-compose exec --user application app /bin/bash -c '"$$WEB_DOCUMENT_ROOT"typo3/cli_dispatch.psh scheduler $(ARGS); (exit $$?)'

#############################
# Apache Solr for TYPO3
#############################

composer-use-dkd-packagist:
	docker-compose exec --user application app composer config --global --auth http-basic.repo.packagist.com $(ARGS)
	docker-compose exec --user application app composer config repositories.dkd-private-packagist '{"type": "composer", "url": "https://repo.packagist.com/dkd-internet-service/"}'
	make composer update mirrors

composer-require-solrfal:
	make composer require "apache-solr-for-typo3/solrfal:5.0.0"

composer-require-solrfluidgrouping:
	make composer require "apache-solr-for-typo3/solrfluidgrouping:1.0.0"

composer-require-solr-source:
	test -d app/web/typo3conf/ext/solr & rm -rf app/web/typo3conf/ext/solr
	docker-compose exec --user application app composer require --prefer-source "apache-solr-for-typo3/solr:dev-release-8.0.x"

#############################
# CI Testing
#############################

ci-bash:
	docker-compose exec --user travis ci /bin/bash -i

ci-solr-bootstrap:
	make composer-require-solr-source
	docker-compose exec --user travis ci /bin/bash -i /opt/scripts/ci-bootstrap.sh

ci-solr-test:
	docker-compose exec --user travis ci /bin/bash -i /opt/scripts/ci-test.sh

#############################
# Argument fix workaround
#############################
%:
	@:
