CMD_PREFIX=bundle exec
CONTAINER_NAME=mahout_pg
TEST_FILES_PATTERN ?=

# You want latexmk to *always* run, because make does not have all the info.
# Also, include non-file targets in .PHONY so they are run regardless of any
# file of the given name existing.
.PHONY: all test lint clean setup ruby packages preprocess run

# The first rule in a Makefile is the one executed by default ("make"). It
# should always be the "all" rule, so that "make" and "make all" are identical.
all: test lint
# CUSTOM BUILD RULES
db:
	make _docker-install || make _docker-start
	make _wait
	make _db-setup
	make seed

#test: export RAILS_ENV=test
test:
	$(CMD_PREFIX) rails test $(TEST_FILES_PATTERN)
	$(CMD_PREFIX) rails test:system $(TEST_FILES_PATTERN)
lint:
	$(CMD_PREFIX) rubocop

clean:
	docker stop $(CONTAINER_NAME)
	docker rm $(CONTAINER_NAME)

run:
	$(CMD_PREFIX) rails server

seed:
	$(CMD_PREFIX) rails db:seed

_docker-start:
	@if [ -z $(docker ps --no-trunc | grep $(CONTAINER_NAME)) ]; then docker start $(CONTAINER_NAME); fi

_db-setup:
	$(CMD_PREFIX) rake db:create
	$(CMD_PREFIX) rake db:event_store
	$(CMD_PREFIX) rake db:projections
	@if [ $(APP_ENV) = 'test' ]; then ./bin/seedaddr < test/fixtures/address_sample.csv; fi

_wait:
	sleep 5

##
# Set up the project for building
setup: _ruby _packages _docker-install

_docker-install:
	docker run -p 5432:5432 --name $(CONTAINER_NAME) -e POSTGRES_PASSWORD=$(DB_PASSWORD) -d mdillon/postgis

_ruby:
	bundle install

_packages:
	sudo apt install ruby
