@use
!attach target

@attach
!setstate self idle 10000 activate

@activate
!damageradius owner 100 5300
!damage owner 999999
!die self

@fizzle
!die self