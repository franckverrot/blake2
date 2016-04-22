require 'test_helper'

class Blake2Test < MiniTest::Test
  def setup
    out_len = 32
    key     = Blake2::Key.from_string('foo bar baz')

    @digestor = Blake2.new(out_len, key)

    @input    = 'hello world'
    @expected = '95670379036532875f58bf23fbcb549675b656bd639a6124a614ccd8a980b180'
  end

  def test_to_hex
    res = @digestor.digest(@input, :to_hex)
    assert_kind_of String, res
    assert_equal @expected, res
  end

  def test_to_bytes
    res = @digestor.digest(@input, :to_bytes)
    assert_kind_of Array, res
    assert_equal [@expected].pack('H*').bytes, res
  end
end
