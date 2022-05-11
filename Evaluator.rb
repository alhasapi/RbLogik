require "./Parser"
require "./Generator"

module Logik
  $loaded = false
  $GB_STATES = {}
  module Evaluator
    def self.evAtomiq op, *args
      return $GB_STATES[op] if $GB_STATES.key? op
      (left, right) = args
      op = op.to_sym
      return left.zip(right).map { |ar| Hatab[op].(*ar) } unless op.eql? :not
      args.flatten.map(&Hatab[:not]).to_a
    end

    def self.runExpr expr
      expr = Logik::Parser::parse( expr )
      $GB_STATES = _load_with_tables expr
      tables evL2( expr )
    end

    def self.evL expr
      if !$loaded then
        $GB_STATES = _load_with_tables expr
        $loaded = true
      end
      if expr[0].isOp
        case expr[0]
        when "not"
          (op, arg) = expr
          evAtomiq op, (evL arg)
        else
          (op, arg1, arg2) = expr
          evAtomiq op, (evL arg1), (evL arg2)
        end
      else # Looking for the table of variable?
        evAtomiq expr[0]
      end
    end

    def self.repl
      loop do
        begin
          print "Herbrand > "
          s = gets.chomp
          break if ["q", "quit"].include? s
          runExpr(s)
        rescue => e
            puts e.class, e.message
            puts "Invalid Expression"
        end
      end
      "Good bye :-)."
    end

    def self.evL2 e
      func = -> expr {
        if expr[0].isOp
          op, *z  = expr
          evAtomiq op, *z.map(&func)
        else # Looking for the table of a variable?
          evAtomiq expr[0]
        end
      }
      func.(e)
    end

    def self._load_with_tables expr
      vars = expr
             .flatten
             .select { |item| item.size == 1}.uniq
      vars.zip(Logik::Generator::optmzedGrtor vars.size).to_h
    end

    def self.tables result
      result.map! { |g| g ? 1 : 0 }
      v, *rst = $GB_STATES.values + [result]
      puts v.zip(*rst).map { |u| Generator::j(*u) }.inject(:*)
    end
  end
end
