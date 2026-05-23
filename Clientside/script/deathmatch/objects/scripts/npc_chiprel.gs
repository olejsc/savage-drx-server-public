@die
!heal target 50
!exec target "objedit #gs_object_name#"
!exec target "objput researchtime temprace"
!if target [temprace==100] @then0 // beast
!if target [temprace!=100] @then1 // human

@then0

@then1
!givestate target adrenaline 2000