@spawn
!exec self "createvar _ward#gs_object_id#_lifecounter 0"

@idle

@idling
!exec self "cvarcopy _ward#gs_object_id#_lifecounter counter"
!if null [counter>=120] @then0
!exec self "inc _ward#gs_object_id#_lifecounter 1"

@chasing
!exec self "cvarcopy _ward#gs_object_id#_lifecounter counter"
!if null [counter>=120] @then0
!exec self "inc _ward#gs_object_id#_lifecounter 1"

@walking
!exec self "cvarcopy _ward#gs_object_id#_lifecounter counter"
!if null [counter>=120] @then0
!exec self "inc _ward#gs_object_id#_lifecounter 1"

@then0
!die self
