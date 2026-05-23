@use
!givestate owner fullstop 1000
!toss target 1 1

@idle
!delay self 1000

@toss
!setstate self idle

@idling
!die self

@die
!givestateradius owner 100 sh_bane_tag 12000
!givestamina owner 5000