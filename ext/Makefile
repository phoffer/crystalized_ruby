ifeq "$(PLATFORM)" ""
PLATFORM := $(shell uname)
endif

ifeq "$(PLATFORM)" "Linux"
UNAME = "$(shell llvm-config --host-target)"
CRYSTAL_BIN = $(shell readlink -f `which crystal`)
LIBRARY_PATH = $(shell dirname $(CRYSTAL_BIN))/../embedded/lib
LIBCRYSTAL = $(shell dirname $(CRYSTAL_BIN) )/../src/ext/libcrystal.a
LIBRUBY = $(shell ruby -e "puts RbConfig::CONFIG['libdir']")
LIBS = -levent -lpcre -lgc -lpthread -lruby -ldl -lm -lc
LDFLAGS = -L. -fstack-protector -rdynamic -Wl,-export-dynamic,-undefined,dynamic_lookup

install: all

all: shards crystalized_ruby.so inflector.so

shards:
	crystal deps

crystalized_ruby.so: crystalized_ruby.o
	$(CC) -shared $^ -o $@ $(LIBCRYSTAL) -L$(LIBRARY_PATH) -L$(LIBRUBY) $(LIBS) $(LDFLAGS)

crystalized_ruby.o: crystalized_ruby.cr
	crystal compile --cross-compile --target $(UNAME) $<

inflector.so: inflector.o
	$(CC) -shared $^ -o $@ $(LIBCRYSTAL) -L$(LIBRARY_PATH) -L$(LIBRUBY) $(LIBS) $(LDFLAGS)

inflector.o: inflector.cr
	crystal compile --cross-compile --target $(UNAME) $<

.PHONY: clean
clean:
	rm -f bc_flags
	rm -f *.o
	rm -f *.so
endif

ifeq "$(PLATFORM)" "Darwin"
CRYSTAL_FLAGS = -dynamic -bundle -Wl,-undefined,dynamic_lookup

all: shards crystalized_ruby.bundle inflector.bundle

shards:
	crystal deps

crystalized_ruby.bundle: crystalized_ruby.cr
	crystal $^ --release --link-flags "$(CRYSTAL_FLAGS)" -o $@

inflector.bundle: inflector.cr
	crystal $^ --release --link-flags "$(CRYSTAL_FLAGS)" -o $@

clean:
	rm -f *.bundle
endif
