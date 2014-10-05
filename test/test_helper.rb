require 'minitest/autorun'
require 'minitest/assertions'
require 'pp'

class Array
  def hd
    self.each.map { |b| sprintf("%X", b) }.join
  end
end

require 'blake2'
