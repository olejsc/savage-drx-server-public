@use
!toss target 20 1.0

@toss
!setstate self idle
!delay self 0

@idling
!scan self 50 activate unit neutral enemy

@activate
!delay self 200

@active
!die self

@die
!givestateradius self 50 caltrops 4000

