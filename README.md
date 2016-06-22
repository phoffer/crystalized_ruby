# Native Ruby extensions written in Crystal

Proof of concept (and more work coming!) for writing a Ruby extension in Crystal. This doesn't use FFI. There's some problems, and it's pretty rough for now, but it's going to keep improving. 

I'd like to get this to a point that it's incredibly simple and quick to write something and have it functional.

## Class conversion status

| Ruby class  | Ruby => Crystal | Crystal => Ruby |
| ----------- | :-------------: | :-------------: |
| String      | :white_check_mark: | :white_check_mark: |
| Symbol      | :x:                | :white_check_mark: |
| Integer     | :white_check_mark: | :white_check_mark: |
| Hash        | :x:                | :white_check_mark: |
| Array       | :white_check_mark: | :white_check_mark: |
| Regexp      | :white_check_mark: | :white_check_mark: |
| Nil         | :white_check_mark: | :white_check_mark: |
| True        | :white_check_mark: | :white_check_mark: |
| False       | :white_check_mark: | :white_check_mark: |

## Updates

#### 6/22

Major refactoring just to better organize the code in better directories. Putting executables in the 'bin' folder. Moving the native extensions in the proper 'ext' folder with 'extconf.rb' and configure the project as a gem.

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
bin/benchmark_inflector
```

The only thing that's BROKEN is pluralize. It works except for words that are already plural, ending in 's', like "posts"/"words"

There's a benchmarking script for all this, and the results are pretty good. See `active_support/results.txt`

# How to get this working

Minimum crystal version: 0.16.0

Make sure Crystal is installed (Homebrew on OSX is fine)

Test and benchmark scripts both require [fast_blank](https://github.com/SamSaffron/fast_blank) and [active_support](https://github.com/rails/rails/tree/master/activesupport), mainly for comparison. Test script also uses [descriptive_statistics](https://github.com/thirtysixthspan/descriptive_statistics), and the benchmark script uses [benchmark-ips](https://github.com/evanphx/benchmark-ips). None of these are required, except to run those two Ruby scripts. There's a Gemfile to install them if desired.

```
rake clean
rake compile
rake test
bin/test
bin/benchmark
```

# Problems

* I am having trouble with defining methods with various parameter counts. There's additional Crystal libs just for defining methods with zero or two parameters. This is obnoxious and the biggest annoyance I have right now, so I'd love to fix that soon.
* Also, it's just pretty rough. I want to clean it up, add some helpers for defining methods in a simpler manner, etc.
* I can't get a proc as a C callback working. There's some broken code commented out. Would love assistance from someone more knowledgeable. Right now this is for converting a Ruby hash to a Crystal hash. 
* Once it can read Ruby hashes/arrays, it will need to be able to check the ruby type for conversion to Crystal. There are some C APIs for this, just gotta figure them out.

# Benchmarking

There is a benchmark script that compares a few things. The methods replicating ActiveSupport methods are copy-pasted, not even re-implemented from scratch. This uses the improved String#blank? method from AS 5.0, but it's not a hard requirement.

Some highlights (see results.txt for more):

```
Comparison:
        cr fibonacci:    22743.9 i/s
        rb fibonacci:      923.2 i/s - 24.63x slower

Comparison:
     empty string rb:  7591363.0 i/s
empty string crystal:  6973264.7 i/s - same-ish: difference falls within error

Comparison:
     CR blank string:  2393668.6 i/s
     AS blank string:   923967.3 i/s - 2.59x slower

Comparison:
           cr squish:   691693.1 i/s
           AS squish:   202554.1 i/s - 3.41x slower

Comparison:
          cr ordinal:  5044785.3 i/s
          AS ordinal:  1775271.7 i/s - 2.84x slower

Comparison:
       fast_blank rb:  6599201.8 i/s
       blank crystal:  2199386.4 i/s - 3.00x slower
```


# Thanks and influences

There's three main projects that I've gained knowledge from to get this fully working:

- [manastech/crystal_ruby](https://github.com/manastech/crystal_ruby)
- [notozeki/crystal_example_ext](https://gist.github.com/notozeki/7159a9d9ab9707a22129)
- [gaar4ica/ruby_ext_in_crystal_math](https://github.com/gaar4ica/ruby_ext_in_crystal_math)

These have all been incredibly helpful, and this is very closely modeled after the last two sources. @gaar4ica's also includes a PDF from a talk she gave at Fosdem, which was highly informative.

# Future Ideas + Contributing

I'd like to get this more fully fleshed out, more functional, and get it usable. There is some question as to whether or not writing a native Ruby extension in Crystal is a useful idea, and I'd love to learn more about both why it _would_ and would _not_ be worthwhile, from people out there who are far more knowledgeable than I am.

If anyone is interested in this concept, please reach out to me either on this repo or on Twitter (@phoffer8). I'd love to collaborate with anyone interested, and just learn more in general.

# Wish List

* Complete the LibRuby wrapper for ruby.h and possibly a way to automate extracting the signatures from ruby.h into Crystal
* Create a series of macros to create the wrappers of the Crystal methods (to convert input and output type between Crystal and CRuby)
* Separate the LibRuby part into a separate gem/shard to make it reusable
* If it was possible to create the aforementioned macros, then it would be great to create a generator to create the template of a Ruby gem with the native extension bits (libruby, extconf, makefile, etc)

Goal: to make it as easy as possible to create Ruby gems with Crystal-based native extensions where we could start with a "slow" Ruby source, tweak it quickly into a Crystal source file, wrap it up with LibRuby and compile it back as a native extension. No having to resort to C, Rust or other low level - and ugly - options.
