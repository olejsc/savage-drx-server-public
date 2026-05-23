@use
!teleport null home
!inventory owner 0 
!exec owner "set relovar#gs_object_id# #gs_inventory_name#"
!remove owner 0
!attach target
!givestate owner relocate 2500


@attach
!setstate self idle 2500 activate

@activate
!give owner human_relocaterhelper 1 0
!die self


