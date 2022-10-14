@AbapCatalog.sqlViewName: 'ZV_I_BOOKINGS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bookings - Composite  View'

@Search.searchable: true

@ObjectModel:{
     compositionRoot: true,
     transactionalProcessingEnabled: true,
     writeActivePersistence: 'bookings',
     createEnabled: true,
     deleteEnabled: true,
      updateEnabled: true,
     semanticKey: ['bookid'],
     usageType:{
        serviceQuality: #X,
        sizeCategory: #S,
        dataClass: #MIXED

     }
}
define view zcds_i_bookings
  as select from zcds_b_bookings

  association [1] to actfli as _Actfli  on  $projection.carrid = _Actfli.carrid
                                        and $projection.connid = _Actfli.connid
                                        and $projection.fldate = _Actfli.fldate
  association [1] to zcds_vh_classtypes as _Class on $projection.class = _Class.DomValue
  association [1] to customers as _Customers  on $projection.customid = _Customers.id
                                              and $projection.custtype = _Customers.custtype
  association [1] to ZCDS_VH_UNIT_WEIGHT as _Wunit on $projection.wunit = _Wunit.msehi
  association [1] to scurx as _Scurx on $projection.forcurkey = _Scurx.currkey  
{
      @ObjectModel.foreignKey.association: '_Actfli'
      @ObjectModel.mandatory: true
  key carrid,

      @ObjectModel.foreignKey.association: '_Actfli'
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
  key connid,

      @ObjectModel.foreignKey.association: '_Actfli'
      @Search.defaultSearchElement: true
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
  key fldate,

      @Search.defaultSearchElement: true
      @ObjectModel.readOnly: true
  key bookid,
      
      @ObjectModel.foreignKey.association: '_Customers'
      customid,
      
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      @ObjectModel.foreignKey.association: '_Customers'
      custtype,
      smoker,
     
      @Semantics.quantity.unitOfMeasure: 'wunit'
      @ObjectModel.mandatory: true
      luggweight,
      
      @ObjectModel.foreignKey.association: '_Wunit'
      wunit,
      invoice,
      
      @ObjectModel.foreignKey.association: '_Class'
      class,
      
      @Semantics.amount.currencyCode: 'forcurkey'
      @ObjectModel.mandatory: true
      forcuram,
      
      @ObjectModel.foreignKey.association: '_Scurx'
      forcurkey,
      loccuram,
      order_date,

      _Actfli,
      _Class,
      _Customers,
      _Wunit,
      _Scurx
}
