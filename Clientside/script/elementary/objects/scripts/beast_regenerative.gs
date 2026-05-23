@spawn
!exec owner "cvarcopy unittier#gs_object_id# tiertemp"
!if owner [tiertemp==1] @then0
!if owner [tiertemp==2] @then1
!if owner [tiertemp==3] @then2

@then0
!givestate target regenerative -1
@then1
!givestate target regenerative2 -1
@then2
!givestate target regenerative3 -1
