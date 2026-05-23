@spawn
!give owner human_legionnaire_melee 0 0
!exec owner "set unittier#gs_object_id# 3"


@die
!test target siege
!exec target "set teamvar #gs_object_team#"
!spawngoodie self money #teamvar# nearby
!spawngoodie self money #teamvar# nearby
!spawngoodie self money #teamvar# nearby
!spawngoodie self money #teamvar# nearby
!spawngoodie self money #teamvar# nearby
!spawngoodie self ammo #teamvar# nearby
!spawngoodie self ammo #teamvar# nearby

