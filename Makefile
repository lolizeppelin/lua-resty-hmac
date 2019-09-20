PREFIX ?=          /usr/local
LUA_INCLUDE_DIR ?= $(PREFIX)/include
LUA_LIB_DIR ?=     $(PREFIX)/lib/lua/$(LUA_VERSION)
INSTALL		?= install
VALGRIND	?= 0
CHECK_LEAK	?= 0
MODULES		?=


.PHONY: all test install

all: ;

install: all
	$(INSTALL) -d $(DESTDIR)/$(LUA_LIB_DIR)/resty
	$(INSTALL) resty_modules/lualib/resty/*.lua $(DESTDIR)/$(LUA_LIB_DIR)/resty
	$(INSTALL) lib/resty/*.lua $(DESTDIR)/$(LUA_LIB_DIR)/resty

test: install
	LUA_PATH="$(LUA_LIB_DIR)/?.lua;;" TEST_NGINX_USE_VALGRIND=$(VALGRIND) TEST_NGINX_CHECK_LEAK=$(CHECK_LEAK) TEST_NGINX_LOAD_MODULES="$(MODULES)" prove -I../test-nginx/lib -r t
