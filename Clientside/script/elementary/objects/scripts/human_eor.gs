@use
!inventory owner 0 
!remove owner 0
!give owner human_legionnaire_melee2 1 0
!givestamina owner 1600
!attach target


@attach
!setstate self sleep 140 idle


@idle
!setstate self sleep 4000 activate
!exec owner "cvarcopy unittier#gs_object_id# tiertemp"
!if owner [tiertemp==1] @then0
!if owner [tiertemp==2] @then1
!if owner [tiertemp==3] @then2

@then0
!givestate owner berserk1 -1
@then1
!givestate owner berserk2 -1
@then2
!givestate owner berserk3 -1


@activate
!exec owner "cvarcopy unittier#gs_object_id# tiertemp"
!if owner [tiertemp==1] @then3
!if owner [tiertemp==2] @then4
!if owner [tiertemp==3] @then5

@then3
!givestate owner berserk11 -1
@then4
!givestate owner berserk22 -1
@then5
!givestate owner berserk33 -1





