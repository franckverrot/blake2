require 'test_helper'

class KeyTest < MiniTest::Test
  def test_from_string
    key = Blake2::Key.from_string("foo bar baz")
    assert_equal [102, 111, 111, 32, 98, 97, 114, 32, 98, 97, 122], key.bytes
  end

  def test_none
    key = Blake2::Key.none
    assert_equal [], key.bytes
  end

  def test_from_hex
    key = Blake2::Key.from_hex("DEADBEAF")
    assert_equal [0XDE, 0xAD, 0xBE, 0xAF], key.bytes
  end
end
