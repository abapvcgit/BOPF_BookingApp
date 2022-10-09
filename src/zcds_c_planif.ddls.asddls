@AbapCatalog.sqlViewName: 'ZV_C_PLANIF'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Connection Offers for flights'



@Metadata.allowExtensions: true

@Search.searchable: true
@ObjectModel:{
      compositionRoot: true,
      transactionalProcessingDelegated: true,
      createEnabled: true,
      updateEnabled: true,
      deleteEnabled: true,

      usageType:{
         serviceQuality: #X,
         sizeCategory: #S,
         dataClass: #TRANSACTIONAL


      }
}
@OData.publish: true


define view zcds_c_planif
  as select from zcds_i_planif
  association [0..*] to zcds_c_actfli as _Flights on $projection.carrid = _Flights.carrid
                                                and $projection.connid = _Flights.connid
{

  key carrid,
  key connid,

      @EndUserText.label: 'City From'
      cityfrom,

      @EndUserText.label: 'City From'
      airpfrom,

      @EndUserText.label: 'City To'
      cityto,
      airpto,

      distance,
      distid,
      /* Associations */
      
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _Flights,
      _Airline,
      _CityF,
      _AirportF,
      _CityT,
      _AirportT
}
