@spawn

@wounded
!testnot target ally
!if self [gs_object_healthpercent<=0.5] @then0

@then0
!givestate self human_potion 20000
