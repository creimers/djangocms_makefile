PYTHON := env/bin/python
PIP := env/bin/pip
TEMPLATE := https://github.com/creimers/djangocms_scaffold/archive/djangocms.zip

all: startapp install-common 

develop: startapp install-development

production: startapp install-production

$(PYTHON):
	virtualenv env

$(PIP): $(PYTHON)

startapp: $(PIP)
	env/bin/pip install django==1.7
	env/bin/django-admin startproject --template=$(TEMPLATE) djangocms_project .

install-common: $(PIP)
	$(PIP) install -r requirements/common.txt

install-development: install-common
	$(PIP) install -r requirements/development.txt

install-production: install-common
	$(PIP) install -r requirements/production.txt

syncdb: install-common
	$(PYTHON) manage.py syncdb

clean:
	git clean -xfd
