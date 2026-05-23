@impact
!test target enemy
!test target unit
!if target siege @then0
!testnot target siege
!inventory target 1
!if target [gs_inventory_count>-1] @then0

@then0
!if target [gs_object_mana>0] @then1

@then1
!exec target "set _mana [gs_object_mana*-1]"
!exec target "set _manaburn [gs_object_mana*1]"
!givemana target #_mana#
!damage target #_manaburn# 1 0
!givestate target mana_burn 10000