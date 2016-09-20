module Logik
  Noot = ->( z ) { !z }
  Oor  = ->( p, q ) { [p, q].any? }
  Aand = ->( p, q ) { [p, q].all? }
  Imp  = ->( p, q ) { Oor.( Noot.( p ), q ) }
  Eq   = ->( p, q ) { Aand.( Imp.( p, q ), Imp.( q, p ) ) }
  Hatab = {}
  Hatab[:and] = Aand
  Hatab[:not] = Noot
  Hatab[:or ] = Oor
  Hatab[:imp] = Imp
  Hatab[:eq ] = Eq

  Hatab.each do |name, func|
    Hatab[name] = ->(*a) {
      a = a.map { |z| z == 0 ? false : true } if a[0].is_a? Fixnum
      func.(*a)
    }
  end
end
