@AbapCatalog.sqlViewName: 'ZV_I_PLANIF'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Connection Offers for flights-Composite'

@Search.searchable: true

@ObjectModel:{
     compositionRoot: true,
     transactionalProcessingEnabled: true,
     writeActivePersistence: 'planfli',
     createEnabled: true,
     deleteEnabled: true,
      updateEnabled: true,
     semanticKey: ['connid'],
     usageType:{
        serviceQuality: #X,
        sizeCategory: #S,
        dataClass: #MIXED


     }
}

define view zcds_i_planif
  as select from zcds_b_planif
  association [0..*] to zcds_i_actfli as _Flights on $projection.carrid = _Flights.carrid   
                                                 and $projection.connid = _Flights.connid
  association [1] to scarr    as _Airline on $projection.carrid = _Airline.carrid
  /*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ] }*/
  association [1] to sgeocity as _CityF    on $projection.cityfrom = _CityF.city
  association [1] to sairport as _AirportF on $projection.airpfrom = _AirportF.id
  
   /*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ] }*/
  association [1] to sgeocity as _CityT    on $projection.cityto = _CityT.city
  association [1] to sairport as _AirportT on $projection.airpto = _AirportT.id
  
  association [1] to zcds_b_unit_dist as _Units on $projection.distid = _Units.msehi
{

      @Search.defaultSearchElement: true
      @ObjectModel.foreignKey.association: '_Airline'
      @ObjectModel.mandatory: true
  key carrid,
      @ObjectModel.readOnly: true
  key connid,

      @Search.defaultSearchElement: true
      @ObjectModel.foreignKey.association: '_CityF'
      @ObjectModel.mandatory: true
      cityfrom,
      
      @Search.defaultSearchElement: true
      @ObjectModel.foreignKey.association: '_AirportF'
      airpfrom,
      
      @ObjectModel.mandatory: true
      @Search.defaultSearchElement: true
      @ObjectModel.foreignKey.association: '_CityT'
      cityto,
      
      @Search.defaultSearchElement: true
      @ObjectModel.foreignKey.association: '_AirportT'
      airpto,
      
      @EndUserText.label: 'Distance'
      @Semantics.quantity.unitOfMeasure: 'distid'
      distance,
      
      @ObjectModel.foreignKey.association: '_Units'
      distid,
      
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _Flights,
      _Airline,
      _CityF,
      _AirportF,
      _CityT,
      _AirportT,
      _Units
}
