VENV?=.venv
ifeq ($(OS), Windows_NT)
	BIN?=$(VENV)\Scripts
else
	BIN?=$(VENV)/bin
endif
PYTHON?=$(BIN)/python
PIP?=$(BIN)/pip
PYTEST?=$(BIN)/pytest

.PHONY: default
default: venv
	$(PYTEST) -vv tests/

.PHONY: venv
venv:
	pip install virtualenv
ifeq ($(OS), Windows_NT)
	if NOT exist $(VENV) virtualenv $(VENV)
else
	[ -d $(VENV) ] || virtualenv $(VENV)
endif
	$(PIP) install -r requirements.txt
	$(PYTHON) setup.py install

.PHONY: install
install:
	pip install .

.PHONY: clean
clean:
	python setup.py clean
	rm -fr $(VENV)
