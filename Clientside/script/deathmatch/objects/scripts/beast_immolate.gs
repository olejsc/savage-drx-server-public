@use
!attach target

@attach
!setstate self idle 11000 activate

@activate
!damageradius owner 115 5000
!damage owner 999999
!die self
