PYTHON := env/bin/python
PIP := env/bin/pip

NPM := $(shell which npm)
GULP := $(shell which gulp)

TEMPLATE := https://github.com/creimers/djangocms_scaffold/archive/master.zip

all: install-common npm

develop: install-development npm

production: install-production npm

$(PYTHON):
	virtualenv env

$(PIP): $(PYTHON)

startapp: $(PIP)
	$(PIP) install django==1.8.9
	env/bin/django-admin startproject --template=$(TEMPLATE) djangocms_project .

init: startapp develop

install-common: $(PIP)
	$(PIP) install -r requirements/common.txt

install-development: install-common
	$(PIP) install -r requirements/development.txt

install-production: install-common
	$(PIP) install -r requirements/production.txt

clean:
	git clean -xfd

npm:
	cd src/ && $(NPM) install

gulp: npm
	cd src/ && gulp develop
