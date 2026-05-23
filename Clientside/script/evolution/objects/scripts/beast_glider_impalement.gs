@use
!exec self "set impalement_#gs_object_id# 0"
!attach owner

@attach
!setstate self idle
!delay self 500

@idle
!exec owner "cvarcopy impalement_#gs_object_id# impalement"
!if null [impalement==20] @then9

@idling
!exec owner "inc impalement_#gs_object_id# 1"



!setstate self activate
!delay self 100

@active

!if null [gs_game_time%5==0] @then0
!if null [gs_game_time%5==1] @then1
!if null [gs_game_time%5==2] @then2
!if null [gs_game_time%5==3] @then3
!if null [gs_game_time%5==4] @then4

!if null [gs_game_time%4==0] @then5
!if null [gs_game_time%4==1] @then6
!if null [gs_game_time%4==2] @then7
!if null [gs_game_time%4==3] @then8

!exec owner "set angle [temp_time%360]"


!drop target #angle# #vel#

!setstate self idle
!delay self 250

@then0
!exec owner "set temp_time [gs_game_time*3]"

@then1
!exec owner "set temp_time [gs_game_time*5]"

@then2
!exec owner "set temp_time [gs_game_time*7]"

@then3
!exec owner "set temp_time [gs_game_time*11]"

@then4
!exec owner "set temp_time [gs_game_time*13]"

@then5
!exec owner "set vel [30]"

@then6
!exec owner "set vel [40]"

@then7
!exec owner "set vel [50]"

@then8
!exec owner "set vel [60]"



@then9
!die self


@drop
!damageradius self 50 300 unit neutral enemy
!die self
