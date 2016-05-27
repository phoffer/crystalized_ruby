inflector.bundle: inflector.cr
	crystal inflector.cr --release --link-flags "-dynamic -bundle -Wl,-undefined,dynamic_lookup" -o inflector.bundle

irb: inflector.bundle
	irb -rinflector -I.

clean:
	rm -f inflector.bundle
