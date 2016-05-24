crystal_ext.bundle: init.cr
	crystal init.cr --release --link-flags "-dynamic -bundle -Wl,-undefined,dynamic_lookup" -o crystal_ext.bundle

irb: crystal_ext.bundle
	irb -rcrystal_ext -I.

clean:
	rm -f crystal_ext.bundle
