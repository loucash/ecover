ECOVER = $(CURDIR)/deps/ecover

cover-instrument-release:
	@$(ECOVER)/utils/cover-instrument-release enable

cover-deinstrument-release:
	@$(ECOVER)/utils/cover-instrument-release disable

cover-compile:
	@echo "Cover compiling release modules"
ifdef ECOVER_NAME
	@escript $(ECOVER)/utils/nodetool -name $(ECOVER_NAME) -setcookie $(ECOVER_COOKIE) rpc ecover compile
else
	@escript $(ECOVER)/utils/nodetool -sname $(ECOVER_SNAME) -setcookie $(ECOVER_COOKIE) rpc ecover compile
endif

cover-analyse:
	@echo "Cover analysing release modules"
ifdef ECOVER_NAME
	@escript $(ECOVER)/utils/nodetool -name $(ECOVER_NAME) -setcookie $(ECOVER_COOKIE) rpc ecover analyse
else
	@escript $(ECOVER)/utils/nodetool -sname $(ECOVER_SNAME) -setcookie $(ECOVER_COOKIE) rpc ecover analyse
endif
	@echo "For acceptance coverage report look at _rel/log/cover/index.html"
	@echo "To produce unit+acceptance merged code coverage run 'make cover-merge'"

cover-merge:
	@echo "Merging unit and acceptance tests coverage data"
ifdef ECOVER_NAME
	@escript $(ECOVER)/utils/nodetool -name $(ECOVER_NAME) -setcookie $(ECOVER_COOKIE) rpc ecover merge
else
	@escript $(ECOVER)/utils/nodetool -sname $(ECOVER_SNAME) -setcookie $(ECOVER_COOKIE) rpc ecover merge
endif
	@echo "For total coverage report look at: _rel/log/cover/total/index.html"

cover-check:
	@$(ECOVER)/utils/check-coverage $(ECOVER_THRESHOLDS)

cover-cobertura:
	@$(ECOVER)/utils/cobertura
