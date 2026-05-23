@spawn
!exec owner "set despairvar#gs_object_id# 0"
!exec owner "set agitativevar#gs_object_id# 0"
!exec owner "set unittier#gs_object_id# 2"

@wounded
!exec owner "cvarcopy despairvar#gs_object_id# despairtemp"
!exec owner "cvarcopy agitativevar#gs_object_id# agitativetemp"
!if owner [despairtemp>0] @then0
!if owner [agitativetemp==1] @then2

@then0
!if owner [gs_object_healthpercent<=0.3] @then1

@then1
!givestate owner despair 5000
!if owner [despairtemp==1] @then3

@then3
!givestate owner despairhelper 200
!exec owner "set despairvar#gs_object_id# 2"

@then2
!givestamina owner 1600

@die
!test target siege
!exec target "set teamvar #gs_object_team#"
!spawngoodie self money #teamvar# nearby
!spawngoodie self money #teamvar# nearby
!spawngoodie self money #teamvar# nearby
!spawngoodie self ammo #teamvar# nearby
!spawngoodie self ammo #teamvar# nearby


