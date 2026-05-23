@impact
!testnot target ally
!testnot target building
!if target corpse @then0
#added damage from ulti
!hasstate target sh_bane_tag
!damage target 100

@then0
!heal owner .05
