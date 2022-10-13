@AbapCatalog.sqlViewName: 'ZV_B_LENGTHS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Search according to length units'


define view zcds_b_unit_dist
  as select from    t006
    left outer join t006a on t006.msehi = t006a.msehi
{
  key t006.msehi,
      t006a.msehl

}
where
      t006.dimid  like 'LENGTH'
  and t006a.spras = $session.system_language
