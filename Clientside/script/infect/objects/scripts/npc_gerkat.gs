@die
!exec target "objedit #gs_object_name#"
!exec target "objput researchtime temprace"
!if target [temprace==100] @then0 // beast
!if target [temprace!=100] @then1 // human

@then0
!give target beast_rabid 1 0

@then1
