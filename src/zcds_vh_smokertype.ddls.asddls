@AbapCatalog.sqlViewName: 'ZV_B_SMOKERTYPE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flights - Class Types'


@Search.searchable: true

define view ZCDS_VH_SMOKERTYPE  as select from    dd07l as FixedValue
    left outer join dd07t as ValueText on  FixedValue.domname    = ValueText.domname
                                       and FixedValue.domvalue_l = ValueText.domvalue_l
                                       and FixedValue.as4local   = ValueText.as4local

{

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key FixedValue.domvalue_l as DomValue,
      @Semantics.text: true -- identifies the text field
  key  ValueText.ddtext      as Text
}

where FixedValue.domname   = 'S_SMOKER'
  and FixedValue.as4local  = 'A' --Active
  and ValueText.ddlanguage = $session.system_language 
