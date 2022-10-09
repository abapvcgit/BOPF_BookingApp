@AbapCatalog.sqlViewName: 'ZV_I_BOOKINGS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bookings - Composite  View'

@Search.searchable: true


define view zcds_i_bookings
  as select from zcds_b_bookings

  association [1] to scarr as _Airline  on  $projection.carrid = _Airline.carrid
  association [1] to actfli as _Actfli  on  $projection.carrid = _Actfli.carrid
                                        and $projection.connid = _Actfli.connid
                                        and $projection.fldate = _Actfli.fldate


{
      @Search.defaultSearchElement: true
      @ObjectModel.foreignKey.association: '_Airline'
      @ObjectModel.mandatory: true
  key carrid,

      @ObjectModel.foreignKey.association: '_Actfli'
      @ObjectModel.mandatory: true
      @Search.defaultSearchElement: true
  key connid,

      @ObjectModel.foreignKey.association: '_Actfli'
      @ObjectModel.mandatory: true
      @Search.defaultSearchElement: true
  key fldate,

      @Search.defaultSearchElement: true
      @ObjectModel.readOnly: true
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
      order_date,

      _Airline,
      _Actfli
}
