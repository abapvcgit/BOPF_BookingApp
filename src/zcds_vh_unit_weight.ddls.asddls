@AbapCatalog.sqlViewName: 'ZV_HV_WEIGHT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Search according to length units'

@Search.searchable: true

define view ZCDS_VH_UNIT_WEIGHT
  as select from    t006
    left outer join t006a on t006.msehi = t006a.msehi
{
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key t006.msehi,
      @Semantics.text: true -- identifies the text field
   t006a.msehl

}
where
      t006.dimid  like 'MASS'
  and t006a.spras = $session.system_language
