@use
!givestate owner fullstop 2700
!toss target 1 1

@idle
!delay self 2600

@toss
!setstate self idle

@idling
!die self

@die
!givestate owner sh_bane_rage 18000