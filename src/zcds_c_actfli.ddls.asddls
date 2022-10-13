@AbapCatalog.sqlViewName: 'ZV_C_ACTFLI'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flights'


@Metadata.allowExtensions: true

@Search.searchable: true
@ObjectModel:{
      createEnabled: true,
      deleteEnabled: true,
      updateEnabled: true,
      usageType:{
         serviceQuality: #X,
         sizeCategory: #S,
         dataClass: #TRANSACTIONAL
      }
}
define view zcds_c_actfli
  as select from zcds_i_actfli
  association [1] to zcds_c_planif as _Planif on $projection.carrid = _Planif.carrid
                                           and $projection.connid = _Planif.connid
{
  key carrid,
  key connid,
      @Search.defaultSearchElement: true
  key fldate,
      price,
      currency,
      planetype,
      seatsmax,
      seatsocc,
      paymentsum,
      /* Associations */
      _Currency,
      @ObjectModel.association.type: [#TO_COMPOSITION_ROOT,#TO_COMPOSITION_PARENT]
      _Planif,
      _Planes
}
