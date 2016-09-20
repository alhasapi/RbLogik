class String
  def items
    self.split('').map(&:to_i)
  end
  def isOp
    Logik::Hatab.include? self.to_sym
  end
end

class Fixnum
  def to_bool
    self == 0 ? false : true
  end
  def bin
    self.to_s(2)
  end
  def half
    self / 2
  end
end

module Logik
 # Miscelaneous functions for generating logical tables
  module Generator
    def self.to_table resp
      value = $GB_STATES.values + [resp.map { |u| u == false ? 0 : 1 }]
      value.map { |arg|
                  fst, *tail = arg
                  fst.zip( *tail )
                }
    end
    def self.optmzedGrtor k
      n       = 2**k
      size    = (n - 1).bin.size
      joiner  = -> arg {
        fst, *tail = arg
        fst.zip(*tail)
      }
      to_b = ->(u) { ("0" * (size - u.bin.size) + u.bin.to_s).items }
      joiner.((0..Float::INFINITY)
                .take(n)
                .collect(&to_b))
    end

    class Node
      attr_accessor :head, :mid, :md, :s
      def initialize n=0
        @head = " _____\n"
        @mid  = "|  %s  |\n"
        @md   = "      |"
        @value = n
        @s = [@head , (@mid * 2 %[' ', @value]) , "|" , @head.strip + "|"]
      end

      def to_s
        @s.inject(:+)
      end

      def +(other)
        s = other.s
        n = Node.new
        n.s = @s.zip(s)
              .map { |item, aitem| item + aitem }
        n
      end
    end
  end
end
