CURRENT_DIRECTORY := $(shell pwd)

DCMP = docker-compose
DCMP_EXEC_APP = ${DCMP} exec app
DCMP_EXEC_MONGO = ${DCMP} exec mongo

build:
	${DCMP} build
	${DCMP} run app bash -c "bundle install && yarn install && \
				 bundle exec rails db:create && \
				 bundle exec rails db:migrate && \
				 bundle exec rails db:seed"

run:
	${DCMP} up

bash:
	${DCMP} run app bash

console:
	${DCMP_EXEC_MONGO} bundle exec rails c

rebuild:
	${DCMP} build --no-cache

rubocop:
	${DCMP} run app rubocop

test:
	${DCMP} run app bash -c "RAILS_ENV=test bundle exec rspec"

development:
	rm -f tmp/pids/server.pid
	bundle exec rails s -b 0.0.0.0
