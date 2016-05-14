require 'test_helper'

class Blake2VectorTest < MiniTest::Test
  def test_a_million_iteration
    100000.times do |i|
      Blake2.new(32, Blake2::Key.none).digest('abc', :to_hex)
    end
  end
end
