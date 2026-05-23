@spawn
!exec self "set ballreset#gs_object_id# #gs_game_time#"

@hit
!exec self "set ballreset#gs_object_id# #gs_game_time#"

@idling
!exec self "cvarcopy ballreset#gs_object_id# resetcheck"
!exec self "cvarcopy gs_game_time gametime"
!exec self "inc gametime -#resetcheck#"
!if null [gametime>=30000] @then1

@then1
!notify target all 
!exec null "svchat No one has hit the ball for 30 seconds!"
!exec null "svchat ^900BALL RESET!"
!exec self "set ballreset#gs_object_id# #gs_game_time#"
!teleport self coords #ballresetx# #ballresety# 200