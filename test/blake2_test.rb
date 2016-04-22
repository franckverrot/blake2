require 'test_helper'

class Blake2Test < MiniTest::Test
  def setup
    out_len = 32
    key     = Blake2::Key.from_string('foo bar baz') # or `Key.none`, or `Key.from_hex("0xDEADBEAF")`

    @digestor = Blake2.new(out_len, key)

    @input    = 'hello world'
    @expected = '95670379036532875f58bf23fbcb549675b656bd639a6124a614ccd8a980b180'
  end

  def test_to_hex
    res = @digestor.digest(@input, :to_hex) # => 9567...b180
    assert_kind_of String, res
    assert_equal   @expected, res
  end

  def to_bytes
    res = @digestor.digest(@input, :to_bytes) # => [0x95, 0x67, <28 bytes later...>, 0xb1, 0x80]
    assert_kind_of Array, res
    assert_equal   @expected.pack('H*').bytes, res
  end
end
