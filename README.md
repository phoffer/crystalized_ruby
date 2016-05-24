# Native Ruby extensions written in Crystal

Proof of concept (and more work coming!) for writing a Ruby extension in Crystal. This doesn't use FFI. There's some problems, and it's pretty rough for now, but it's going to keep improving. 

I'd like to get this to a point that it's incredibly simple and quick to write something and have it functional.

# How to get this working

Minimum crystal version: 0.16.0

Make sure Crystal is installed (Homebrew on OSX is fine)

Test and benchmark scripts both require [fast_blank](https://github.com/SamSaffron/fast_blank) and [active_support](https://github.com/rails/rails/tree/master/activesupport), mainly for comparison. Test script also uses [descriptive_statistics](https://github.com/thirtysixthspan/descriptive_statistics). None of these are required to get this up and running, I'm just using them in those scripts for some comparisons. I should add a Gemfile but I'm just playing around for now. 

```
make
ruby test.rb
ruby benchmark.rb
```

# Problems

* I am having trouble with defining methods with various parameter counts. There's additional Crystal libs just for defining methods with zero or two parameters. This is obnoxious and the biggest annoyance I have right now, so I'd love to fix that soon.
* Also, it's just pretty rough. I want to clean it up, add some helpers for defining methods in a simpler manner, etc.
* I haven't done anything with Arrays or Hashes yet. I'd like to but right now I've just been trying to get a lot of this to work correctly.

# Thanks and influences

There's three main projects that I've gained knowledge from to get this fully working:

- [manastech/crystal_ruby](https://github.com/manastech/crystal_ruby)
- [notozeki/crystal_example_ext](https://gist.github.com/notozeki/7159a9d9ab9707a22129)
- [gaar4ica/ruby_ext_in_crystal_math](https://github.com/gaar4ica/ruby_ext_in_crystal_math)

These have all been incredibly helpful, and this is very closely modeled after the last two sources. @gaar4ica's also includes a PDF from a talk she gave at Fosdem, which was highly informative.

# Future Ideas + Contributing

I'd like to get this more fully fleshed out, more functional, and get it usable. There is some question as to whether or not writing a native Ruby extension in Crystal is a useful idea, and I'd love to learn more about both why it _would_ and would _not_ be worthwhile, from people out there who are far more knowledgeable than I am.

If anyone is interested in this concept, please reach out to me either on this repo or on Twitter (@phoffer8). I'd love to collaborate with anyone interested, and just learn more in general.
