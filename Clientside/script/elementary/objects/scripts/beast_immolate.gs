@use
!givestate owner sacrifice 10000
!attach self

@attach
!setstate self idle 10000 activate

@activate
!ifnot owner [gs_object_healthpercent==0] @then0

@then0
!stun owner 2200
!damageradius owner 100 5300
!exec owner "set unittiervar#gs_object_id# #gs_object_name#"
!changeunit owner npc_ghost2
!damage owner 100 1
!givestate owner sacrifice3 2000
!setstate self idle 2000 sleep
!givestate owner beast_protect 0
!givestate owner beast_protect2 0
!givestate owner zapped 0
!givestate owner beast_mist 0
!givestate owner fire_shield 0
!givestate owner beast_staminaregen 0
!givestate owner despair 0


@sleep
!teleport owner home
!exec owner "cvarcopy unittiervar#gs_object_id# tiertemp"
!changeunit owner #tiertemp#
!heal owner 9999
!die self




