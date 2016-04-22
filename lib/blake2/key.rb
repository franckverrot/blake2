class Blake2
  class Key
    attr_reader :bytes

    def initialize(bytes)
      @bytes = bytes
    end

    def self.from_string(str)
      new(@bytes = str.bytes)
    end

    def self.from_hex(hex_str)
      new(@bytes = [hex_str].pack("H*").bytes)
    end

    def self.none
      new(@bytes = [])
    end
  end
end
