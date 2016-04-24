# BLAKE2s for Ruby

## SUMMARY

This gem is a C-extension for using BLAKE2s in Ruby.

>BLAKE2 comes in two basic flavors:
>
>BLAKE2b (or just BLAKE2) is optimized for 64-bit platforms and
>produces digests of any size between 1 and 64 bytes.
>
>BLAKE2s is optimized for 8- to 32-bit platforms and produces
>digests of any size between 1 and 32 bytes.
>
>Both BLAKE2b and BLAKE2s are believed to be highly secure and perform
>well on any platform, software, or hardware.  BLAKE2 does not require
>a special "HMAC" (Hashed Message Authentication Code) construction
>for keyed message authentication as it has a built-in keying
>mechanism.
>
>[https://tools.ietf.org/html/rfc7693#page-3](https://tools.ietf.org/html/rfc7693#page-3)

This implementation supports the BLAKE2s variant with 32 Bytes of output.

The C code for this gem is taken from the [official reference C implementation](https://github.com/BLAKE2/BLAKE2)
as of commit `02bf34f3d49c205812c34dfce9123a7c74509605`.

For a detailed explanation about BLAKE2s, [here's the offical website](https://blake2.net/).

## INSTALL

```
gem install blake2
```

## USAGE

``` ruby
require 'blake2'

# The UTF-8 String (Required) that you want to digest.
input   = 'abc'

# The main application of keyed BLAKE2 is as a message authentication code (MAC)
# By default `Blake2::Key.none` is used.
key = Blake2::Key.none
# key = Blake2::Key.from_string("foo bar baz")
# key = Blake2::Key.from_hex('DEADBEAF')
# key = Blake2::Key.from_bytes([222, 173, 190, 175])

# The output length in Bytes of the Hash, Max and Default is 32.
out_len = 32

# HEX OUTPUT
############

Blake2.hex(input)
=> "508c5e8c327c14e2e1a72ba34eeb452f37458b209ed63a294d999b4c86675982"

Blake2.hex(input, key)
=> "508c5e8c327c14e2e1a72ba34eeb452f37458b209ed63a294d999b4c86675982"

Blake2.hex(input, key, out_len)
=> "508c5e8c327c14e2e1a72ba34eeb452f37458b209ed63a294d999b4c86675982"

# BYTES OUTPUT
##############

Blake2.bytes(input)
=> [80, 140, 94, ...]

Blake2.bytes(input, key)
=> [80, 140, 94, ...]

Blake2.bytes(input, key, out_len)
=> [80, 140, 94, ...]

```

## DEVELOPMENT

After checking out the repo, run `bin/setup` to install dependencies. Then,
run `rake full` to build and test, or `rake test` to only run the tests.
You can also run `bin/console` for an interactive prompt that will allow you
to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## CONTRIBUTE

1. Fork it ( https://github.com/franckverrot/blake2/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## LICENSE

Franck Verrot, Copyright 2014. See LICENSE.txt.
