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

    # Here is the implemention of a representation combinator.
    # An instance of Node is an object which represent a cell
    # Expressed with few symbol as an geometric and symetric cell.

    # The trick here is that the '+' operator combine the
    # Represention of it's left operand with it's own
    # Represention to build a new Node.

    # Therefore the set of all instances of Node
    # Generate a structure of monoid with the '+' operator.

    # Such structure makes utterly useless ridiculous boiler-plate
    # code for processing representions. Instead we gain a hight level
    # of abstraction for combining both: from the left and the bottom
    # of a Node object. That kind of abstraction is highly analogous
    # Haskell's applicative functors witch is structure preserving mappings.

    class Node
      attr_accessor :content
      def initialize value=0
        @content = [[" ", "_", "_", "_", "_", " "],
                    ["|", " ", " ", " ", " ", "|"],
                    ["|", " ", " ", "#{value}", " ", "|"],
                    ["|", "_", "_", "_", "_", "|"]]
        @idx   = 2,3
        @value = value
      end

      def to_s
        @content
          .map { |c| c.inject(:+) }
          .join("\n")
      end

      def +(other)
        content = other.content.dup
        content[0][0] = "_"
        content[1][0] = " "
        content[2][0] = " "
        content[3][0] = "_"
        n = Node.new
        n.content = @content
                    .zip(content)
                    .map { |i, o| i + o }
        n
      end
      def *(other)
        content = other.content.dup
        size = content[0].size - 1
        u = [0, 5] + (6..size).step(5).to_a
        u.each { |i| content[0][i] = "|"}
        ((0..size).to_a - u).each { |i| content[0][i] = " " }
        n = Node.new
        content.shift
        n.content = @content + content
        n
      end
    end

    def self.j(*arg)
      arg.map { |z| Node.new z }.inject(:+)
    end
  end
end
