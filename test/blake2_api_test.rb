require 'test_helper'

class Blake2Test < MiniTest::Test
  def test_hex_with_input_only
    res = Blake2.hex('abc')
    assert_kind_of String, res
    assert_equal '508c5e8c327c14e2e1a72ba34eeb452f37458b209ed63a294d999b4c86675982', res
  end

  def test_hex_with_input_and_key
    res = Blake2.hex('abc', Blake2::Key.none)
    assert_kind_of String, res
    assert_equal '508c5e8c327c14e2e1a72ba34eeb452f37458b209ed63a294d999b4c86675982', res
  end

  def test_hex_with_input_key_and_length
    res = Blake2.hex('abc', Blake2::Key.none, 32)
    assert_kind_of String, res
    assert_equal '508c5e8c327c14e2e1a72ba34eeb452f37458b209ed63a294d999b4c86675982', res
  end

  def test_bytes_with_input_only
    res = Blake2.bytes('abc')
    assert_kind_of Array, res
    assert_equal [80, 140, 94, 140, 50, 124, 20, 226, 225, 167, 43, 163, 78, 235, 69, 47, 55, 69, 139, 32, 158, 214, 58, 41, 77, 153, 155, 76, 134, 103, 89, 130], res
  end

  def test_bytes_with_input_and_key
    res = Blake2.bytes('abc', Blake2::Key.none)
    assert_kind_of Array, res
    assert_equal [80, 140, 94, 140, 50, 124, 20, 226, 225, 167, 43, 163, 78, 235, 69, 47, 55, 69, 139, 32, 158, 214, 58, 41, 77, 153, 155, 76, 134, 103, 89, 130], res
  end

  def test_bytes_with_input_key_and_length
    res = Blake2.bytes('abc', Blake2::Key.none, 32)
    assert_kind_of Array, res
    assert_equal [80, 140, 94, 140, 50, 124, 20, 226, 225, 167, 43, 163, 78, 235, 69, 47, 55, 69, 139, 32, 158, 214, 58, 41, 77, 153, 155, 76, 134, 103, 89, 130], res
  end

  def test_input_raises_on_non_string
    assert_raises(ArgumentError) { Blake2.hex(nil) }
    assert_raises(ArgumentError) { Blake2.bytes(nil) }
  end

  def test_key_raises_on_non_key
    assert_raises(ArgumentError) { Blake2.hex('abc', []) }
    assert_raises(ArgumentError) { Blake2.bytes('abc', []) }
  end

  def test_length_raises_on_invalid
    assert_raises(ArgumentError) { Blake2.hex('abc', Blake2::Key.none, -1) }
    assert_raises(ArgumentError) { Blake2.hex('abc', Blake2::Key.none, 0) }
    assert_raises(ArgumentError) { Blake2.hex('abc', Blake2::Key.none, 33) }
    assert_raises(ArgumentError) { Blake2.hex('abc', Blake2::Key.none, '32') }
    assert_raises(ArgumentError) { Blake2.bytes('abc', Blake2::Key.none, -1) }
    assert_raises(ArgumentError) { Blake2.bytes('abc', Blake2::Key.none, 0) }
    assert_raises(ArgumentError) { Blake2.bytes('abc', Blake2::Key.none, 33) }
    assert_raises(ArgumentError) { Blake2.bytes('abc', Blake2::Key.none, '32') }
  end
end
