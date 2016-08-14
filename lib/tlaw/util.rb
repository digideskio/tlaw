module TLAW
  module Util
    module_function

    def camelize(string)
      string.to_s
        .sub(/^[a-z\d]*/) { |l| l.capitalize }
        .gsub(/(?:_|(\/))([a-z\d]*)/i) { "#{$1}#{$2.capitalize}" }
    end

    def flatten_hashes(val)
      case val
      when Array
        val.map { |e| flatten_hashes(e) }
      when Hash
        flatten_hash(val)
      else
        val
      end
    end

    def flatten_hash(hash)
      hash.map { |k, v|
        if v.is_a?(Hash)
          flatten_hash(v).map { |k1, v1| ["#{k}.#{k1}", v1] }
        else
          [[k, flatten_hashes(v)]]
        end
      }.flatten(1).to_h
    end
  end
end