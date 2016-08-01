require "./Atomiqs"

# Here is the parsing and evaluation code.

module Logik
  # The evaluation strategy is a little bit tricky.
  # Ad hoc reductions of logical operations require
  # a storage of intermediate states of each computation
  # meanwhile expression reduction is performed.
  #
  # Therefore we adopt the strategy of a global variable
  # Witch holds current states of each operation at runtime.
  # The global states storage is expected to be
  # visible to the evaluator.
a = 12;;
  $GB_STATES = {}
  module Parser
    lookup = ->( op_name ) {
      op = op_name.to_sym
      Hatab.each_pairs do |o_name, lmdExpr|
        lmdExpr if o_name.eql? op
      end
    }


    def self.lexIt expr
      normalizer  = ->( u ) {
        "()".include?(u) ? " #{u} " : u
      }
      expr
        .each_char
        .collect(&normalizer)
        .join("")
        .split
    end
    def self.extract_structure expr
      raise SyntaxError.new("EOF") if expr.size.zero?
      token = expr.shift
      if ?(.eql? token then
        it = []
        it << extract_structure(expr) until expr[0] == ?)
        expr.shift
        it
      else
        token
      end
    end
    def self.parse code
      extract_structure( lexIt code )
    end
  end
end
