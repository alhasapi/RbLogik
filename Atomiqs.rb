module Logik
  # Here I implement atomic logic operations
  Noot = ->( z ) { !z }
  Oor  = ->( p, q ) { [p, q].any? }
  Aand = ->( p, q ) { [p, q].all? }
  Imp  = ->( p, q ) { Oor.( Noot.( p ), q ) }
  Eq   = ->( p, q ) { Aand.( Imp.( p, q ), Imp.( p, q ) ) }

  Hatab = {}
  Hatab[:and] = Aand
  Hatab[:or ] = Noot
  Hatab[:or ] = Oor
  Hatab[:imp] = Imp
  Hatab[:eq ] = Eq
end
