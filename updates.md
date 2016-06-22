#### 6/22

Major refactoring just to better organize the code in better directories. Putting executables in the 'bin' folder. Moving the native extensions in the proper 'ext' folder with 'extconf.rb' and configure the project as a gem.

#### 6/21 @038cca8

* Makefile compiles on Ubuntu ([@akitaonrails](https://github.com/akitaonrails))
* String#blank? even faster now ([@kostya](https://github.com/kostya))
* Updated test inflector benchmarking
* Since this project has gotten a little bit of attention, I'll be adding some docs about contributing/developing/etc. 

#### 6/3 @ 5937f4b

1. Inflectors are completely working
2. Regular expressions work, converting both directions (ruby -> crystal and vice versa)

#### 5/30 @ 182f5fb

This is now using an external shard for inflectors ([github/phoffer/inflector.cr](https://github.com/phoffer/inflector.cr)). It is not quite perfect but it's mostly working, please see that repo for more info. 

#### 5/27 @ 5790cbe

* Set up benchmarking to compare the Ruby-ActiveSupport with the Crystal implementation. Results are very strong for Crystal.
* Realized I forgot to add a bunch of files to the repo. Those are all added and the instructions below should work now.

#### 5/26 @ 65e1d26

I've ported over all the relevant parts of ActiveSupport::Inflector. Basically everything except the two methods for constantizing and also the i18n stuff. To run:

```
rake clean
rake compile
rake test
bin/benchmark
bin/benchmark_inflector
```

The only thing that's BROKEN is pluralize. It works except for words that are already plural, ending in 's', like "posts"/"words"

There's a benchmarking script for all this, and the results are pretty good. See `active_support/results.txt`
