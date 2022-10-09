@AbapCatalog.sqlViewName: 'ZV_B_BOOKINGS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bookings - Basic View'
define view zcds_b_bookings
  as select from bookings
{

  key carrid,
  key connid,
  key fldate,
  key bookid,
      customid,
      custtype,
      smoker,
      luggweight,
      wunit,
      invoice,
      class,
      forcuram,
      forcurkey,
      loccuram,
      order_date
}
