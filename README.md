# BLAKE2 for Ruby

## SUMMARY

This gem is a C-extension for using BLAKE2 in Ruby.

For a detailed explanation about BLAKE2, [here's the offical website](https://blake2.net/).

## INSTALL

    gem install blake2


## USAGE

    out_len = 32
    input   = "hello world"
    key     = Key.from_string("foo bar baz") # or `Key.none`, or `Key.from_hex("0xDEADBEAF")`

    digestor = Blake2.new(out_len, key)

    digestor.digest(input, :to_hex) # => 9567...b180
    digestor.digest(input, :to_bytes) # => [0x95, 0x67, <28 bytes later...>, 0xb1, 0x80]


## API

TODO

## TODO

* [ ] Documentation
* [ ] Improve controls/type checks in the `digest` methods

## CONTRIBUTE

1. Fork it ( https://github.com/franckverrot/blake2/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## LICENSE

Franck Verrot, Copyright 2014. See LICENSE.txt.
