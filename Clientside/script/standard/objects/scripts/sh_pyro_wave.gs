@impact
!if target [gs_object_id>=0] @then1

@then1
!testnot target ally
!testnot target building
!givestate target energy_armor 100