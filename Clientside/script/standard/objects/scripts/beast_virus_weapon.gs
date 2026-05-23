@impact
!if target [gs_object_id>=0] @then0

@then0
!testnot target building
!if target enemy @then1

@then1
!givestate target infected 10000
!exec owner client "play2d /models/savageheroes/units/virus/virus.ogg"
!die self