@die 
!die link

@given
!exec owner "cvarcopy relovar#gs_object_id# relotemp"
!give owner #relotemp# 1 0

!attach owner

@attach
!teleport target link
!die link

!die self

