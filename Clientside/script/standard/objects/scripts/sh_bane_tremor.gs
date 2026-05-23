@use
!givestate owner fullstop 1800
!toss target 1 1

@idle
!delay self 1000

@toss
!setstate self idle

@idling
!givestate owner camera_shake 300
!die self

@die
!damageradius self 150 300 enemy neutral unit player npc item
