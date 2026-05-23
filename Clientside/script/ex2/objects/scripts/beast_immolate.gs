@use
!attach target

@attach
!setstate self idle 10000 activate

@activate
!damageradius owner 125 6000
!damage owner 999999
!die self
