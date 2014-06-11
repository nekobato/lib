BOWER = ./node_modules/.bin/bower
GRUNT = ./node_modules/.bin/grunt

QUERY = "CREATE TABLE archive (id TEXT PRIMARY KEY, date TEXT, title TEXT);"

install:
	@echo "\ninstall node modules...\n"
	@npm install
	@echo "bower install...\n"
	@$(BOWER) install
	@echo "grunt build...\n"
	@$(GRUNT) build
	@echo "sqlite3 setup...\n"
	@echo $(QUERY) | sqlite3 ./db.sqlite3

.PHONY: install
