inflector.bundle: init.cr
	crystal init.cr --release --link-flags "-dynamic -bundle -Wl,-undefined,dynamic_lookup" -o inflector.bundle

benchmark:
	ruby benchmark.rb >> results.txt 2>&1

irb: inflector.bundle
	irb -rinflector -I.

clean:
	rm -f inflector.bundle
