require 'test_helper'

class KeyTest < MiniTest::Test
  def test_none
    key = Blake2::Key.none
    assert_equal [], key.bytes
  end

  def test_from_string
    key = Blake2::Key.from_string('foo bar baz')
    assert_equal [102, 111, 111, 32, 98, 97, 114, 32, 98, 97, 122], key.bytes
  end

  def test_from_string_raises_on_non_ascii_string
    assert_raises(ArgumentError) { Blake2::Key.from_string('💩') }
  end

  def test_from_hex
    key = Blake2::Key.from_hex('DEADBEAF')
    assert_equal [222, 173, 190, 175], key.bytes
  end

  def test_from_hex_raises_on_non_hex_string
    assert_raises(ArgumentError) { Blake2::Key.from_hex('DEADBEAFZZ') }
  end

  def test_from_bytes_hex
    key = Blake2::Key.from_bytes([0xDE, 0xAD, 0xBE, 0xAF])
    assert_equal [222, 173, 190, 175], key.bytes
  end

  def test_from_bytes_int
    key = Blake2::Key.from_bytes([222, 173, 190, 175])
    assert_equal [222, 173, 190, 175], key.bytes
  end

  def test_from_hex_raises_on_non_valid_byte_array
    assert_raises(ArgumentError) { Blake2::Key.from_bytes([-1]) }
    assert_raises(ArgumentError) { Blake2::Key.from_bytes([256]) }
    assert_raises(ArgumentError) { Blake2::Key.from_bytes(['foo']) }
  end
end
