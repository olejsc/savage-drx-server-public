@spawn
!give owner human_nomad_melee 0 0
!exec owner "set unittier#gs_object_id# 1"


@die
#!exec target "chat Target: #gs_object_name#"
!test target siege
!exec target "set teamvar #gs_object_team#"
!spawngoodie self money #teamvar# nearby
!spawngoodie self money #teamvar# nearby
!spawngoodie self ammo #teamvar# nearby
