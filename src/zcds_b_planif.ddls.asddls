@AbapCatalog.sqlViewName: 'ZV_B_PLANIF'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Connection Offers for flights-Basic View'

define view zcds_b_planif
  as select from planfli
{

  key carrid,
  key connid,
      cityfrom,
      airpfrom,
      cityto,
      airpto,
      fltime ,
      deptime,
      arrtime,
      distance,
      distid
}
