@AbapCatalog.sqlViewName: 'ZV_B_ACTFLI'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flights  - Basic View'
define view zcds_b_actfli
  as select from actfli
{
  key carrid,
  key connid,
  key fldate,
      price,
      currency,
      planetype,
      seatsmax,
      seatsocc,
      paymentsum
}
