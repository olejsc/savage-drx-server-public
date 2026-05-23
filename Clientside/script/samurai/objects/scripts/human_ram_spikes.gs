@use
!drop target 42 50
!drop target 90 35
!drop target 138 50
!drop target 180 50
!drop target 222 50
!drop target 270 35
!drop target 318 50

@drop
!setstate self sleep 
!delay self 700

@sleeping
!setstate self idle 10000 activate

@idling
!scan self 25 activate unit neutral enemy

@activate
!damage enemy 150
!givestate enemy caltrops 2500
!delay self 300

@active
!die self


