@spawn
!exec self "set balloon#gs_object_id# 0"
!exec self "set balloon#gs_object_id#drop_ammo 0"
!exec self "set balloon#gs_object_id#drop_health 0"
#gs_team_resource #3 - elec #4 - mag #5 - chem

@hit
!test target ally
!exec self "cvarcopy balloon#gs_object_id# goodiecheck"
!exec self "cvarcopy gs_game_time gametime"
!exec self "inc gametime -#goodiecheck#"
!if null [gametime>=1000] @then1
!if null [gametime<=999] @then2
!if null [gametime<=0] @then5

@then1 
#!notify target all YES
!spawngoodie target ammo #gs_object_team# nearby
!spawngoodie target extra #gs_object_team# nearby
!exec self "set balloon#gs_object_id# #gs_game_time#"

@then2 
#!notify target all NO

@then5
!exec self "set balloon#gs_object_id# 0"

@idling
!exec self "cvarcopy gs_team#gs_object_team#_resource3 checkresource"
!if self [checkresource>=1] @then3
!exec self "cvarcopy gs_team#gs_object_team#_resource4 checkresource"
!if self [checkresource>=1] @then4

!exec self "cvarcopy balloon#gs_object_id#drop_ammo checkdrop"
!if self [checkdrop>=1] @then8
!exec self "cvarcopy balloon#gs_object_id#drop_health checkdrop"
!if self [checkdrop>=1] @then9

@walking
!exec self "cvarcopy gs_team#gs_object_team#_resource3 checkresource"
!if self [checkresource>=1] @then3
!exec self "cvarcopy gs_team#gs_object_team#_resource4 checkresource"
!if self [checkresource>=1] @then4

!exec self "cvarcopy balloon#gs_object_id#drop_ammo checkdrop"
!if self [checkdrop>=1] @then8
!exec self "cvarcopy balloon#gs_object_id#drop_health checkdrop"
!if self [checkdrop>=1] @then9

@chasing
!exec self "cvarcopy gs_team#gs_object_team#_resource3 checkresource"
!if self [checkresource>=1] @then3
!exec self "cvarcopy gs_team#gs_object_team#_resource4 checkresource"
!if self [checkresource>=1] @then4

!exec self "cvarcopy balloon#gs_object_id#drop_ammo checkdrop"
!if target [checkdrop>=1] @then8
!exec self "cvarcopy balloon#gs_object_id#drop_health checkdrop"
!if target [checkdrop>=1] @then9

@then8
!spawngoodie self ammo #gs_object_team# coords #gs_object_posx# #gs_object_posy#
!exec self "inc balloon#gs_object_id#drop_ammo -1"

@then9
!spawngoodie self extra #gs_object_team# coords #gs_object_posx# #gs_object_posy#
!exec self "inc balloon#gs_object_id#drop_health -1"

@then3
!givestate self balloon_spark 2000

@then4
!givestate self balloon_mag 2000

@then6
!givestate self balloon_spark 0

@then7
!givestate self balloon_mag 0

@die