class Blake2
  # Validate and normalize an HMAC key, provided in different formats,
  # into an Array of Integer Bytes.
  class Key
    attr_reader :bytes

    def initialize(bytes)
      @bytes = bytes
    end

    # Create a blank Key
    #
    # @return [Blake2::Key] a Blake2::Key object with a `bytes` attr
    def self.none
      new([])
    end

    # Create a key from an ASCII String
    #
    # @param str [String] an ASCII String key
    # @return [Blake2::Key] a Blake2::Key object with a `bytes` attr
    def self.from_string(str)
      if str.is_a?(String) && str.ascii_only?
        new(str.bytes)
      else
        raise ArgumentError, 'key must be an ASCII String'
      end
    end

    # Create a key from a Hex String [a-fA-F0-9]
    #
    # @param str [String] a Hex String key
    # @return [Blake2::Key] a Blake2::Key object with a `bytes` attr
    def self.from_hex(str)
      if str.is_a?(String) && str.match(/^[a-fA-F0-9]+$/)
        new([str].pack('H*').bytes)
      else
        raise ArgumentError, 'key must be a Hex String [a-fA-F0-9]'
      end
    end

    # Create a key from Array of Integer (0-255) Bytes.
    # This simply validates and passes through the Array.
    #
    # @param str [Array] an Array of Integer (0-255) Bytes
    # @return [Blake2::Key] a Blake2::Key object with a `bytes` attr
    def self.from_bytes(bytes)
      if bytes.all? { |b| b.is_a?(Integer) && b.between?(0, 255) }
        new(bytes)
      else
        raise ArgumentError, 'key must be a Byte Array of Integers (0-255)'
      end
    end
  end
end
