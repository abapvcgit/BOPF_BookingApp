@AbapCatalog.sqlViewName: 'ZV_C_BOOKINGS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bookings'

@Metadata.allowExtensions: true


@ObjectModel:{
      compositionRoot: true,
      transactionalProcessingDelegated: true,
      createEnabled: true,
      deleteEnabled: true,
       updateEnabled: true,
      semanticKey: ['bookid'],
      usageType:{
         serviceQuality: #X,
         sizeCategory: #S,
         dataClass: #TRANSACTIONAL
      }
}
@OData.publish: true
define view zcds_c_bookings as select from zcds_i_bookings {
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
    TxClass,
    forcuram,
    forcurkey,
    loccuram,
    order_date,
    /* Associations */
    _Actfli,
    _Class,
    _Customers,
    _Wunit,
    _Scurx
}
