@AbapCatalog.sqlViewName: 'ZV_I_ACTFLI'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flights  - Composite View'

@Search.searchable: true

@ObjectModel:{

     writeActivePersistence: 'actfli',
     createEnabled: true,
     deleteEnabled: true,
     updateEnabled: true,
     usageType:{
        serviceQuality: #X,
        sizeCategory: #S,
        dataClass: #MIXED


     }
}
define view zcds_i_actfli
  as select from zcds_b_actfli
  association [1] to zcds_i_planif as _Planif   on  $projection.carrid = _Planif.carrid
                                                and $projection.connid = _Planif.connid
  association [1] to scurx         as _Currency on  $projection.currency = _Currency.currkey

  association [1] to saplane       as _Planes   on  $projection.planetype = _Planes.planetype
{
      @ObjectModel.readOnly: true
  key carrid,
      @ObjectModel.readOnly: true
  key connid,
  
      @Search.defaultSearchElement: true
      @ObjectModel.mandatory: true
  key fldate,
      @ObjectModel.mandatory: true
      @Semantics.amount.currencyCode: 'currency'
      price,
      @ObjectModel.foreignKey.association: '_Currency'
      currency,

      @ObjectModel.foreignKey.association: '_Planes'
      planetype,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      seatsmax,
      
      @ObjectModel.readOnly: true
      seatsocc,


      @ObjectModel:{  foreignKey.association: '_Currency', readOnly: 'EXTERNAL_CALCULATION' }
      paymentsum,

      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
      _Planif,
      _Currency,
      _Planes
}
