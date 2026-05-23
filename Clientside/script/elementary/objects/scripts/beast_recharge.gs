@use
!heal target 1000
!givemana target 250
!givestamina target 5000

!exec target "cvarcopy despairvar#gs_object_id# despairtemp"
!if target [despairtemp==2] @then2
@then2
!exec target "set despairvar#gs_object_id# 1"