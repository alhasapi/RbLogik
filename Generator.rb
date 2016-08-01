
class Fixnum
  def bin
    self.to_s.to_i(2)
  end
  def half
    self / 2
  end
end

class String
end
module Logik
  # Miscelaneous functions for generating logical tables
  module Generator
    def self.expand_table tab, size
      tab *= 2 while tab.size < 2 **size
      tab
    end
    def self.the_table_of size
      n_size, limit, tables = [2**size] * 2 << []
      until tables.size == size
        current = [0] * n_size.half +
                  [1] * n_size.half
        not_enough = current.size < limit
        current = expand_table(current, size) if not_enough
        tables << current
        n_size = n_size.half
      end
     tables
    end

    def self.optimized_generator n
      size    = (n - 1).bin.size
      padding = ->( z ) {
        _z = z.bin
        "0" * (size - _z.size) + _z
      }
      (0..n-1).collect(&padding).map(&:split)
    end
  end
end
