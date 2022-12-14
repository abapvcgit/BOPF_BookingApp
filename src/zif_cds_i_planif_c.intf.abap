interface ZIF_CDS_I_PLANIF_C
  public .


  interfaces /BOBF/IF_LIB_CONSTANTS .

  constants:
    BEGIN OF SC_ACTION,
      BEGIN OF ZCDS_I_ACTFLI,
 CREATE_ZCDS_I_ACTFLI           TYPE /BOBF/ACT_KEY VALUE '000C290F2DC31EED91D8C0DC1F65E03A',
 DELETE_ZCDS_I_ACTFLI           TYPE /BOBF/ACT_KEY VALUE '000C290F2DC31EED91D8C0DC1F66603A',
 SAVE_ZCDS_I_ACTFLI             TYPE /BOBF/ACT_KEY VALUE '000C290F2DC31EED91D8C0DC1F66E03A',
 UPDATE_ZCDS_I_ACTFLI           TYPE /BOBF/ACT_KEY VALUE '000C290F2DC31EED91D8C0DC1F66203A',
 VALIDATE_ZCDS_I_ACTFLI         TYPE /BOBF/ACT_KEY VALUE '000C290F2DC31EED91D8C0DC1F66A03A',
      END OF ZCDS_I_ACTFLI,
      BEGIN OF ZCDS_I_PLANIF,
 CREATE_ZCDS_I_PLANIF           TYPE /BOBF/ACT_KEY VALUE '000C290F2DC31EDD91CF05BF4DC31C57',
 DELETE_ZCDS_I_PLANIF           TYPE /BOBF/ACT_KEY VALUE '000C290F2DC31EDD91CF05BF4DC39C57',
 LOCK_ZCDS_I_PLANIF             TYPE /BOBF/ACT_KEY VALUE '000C290F2DC31EDD91CF05BF4DC25C57',
 SAVE_ZCDS_I_PLANIF             TYPE /BOBF/ACT_KEY VALUE '000C290F2DC31EDD91CF05BF4DC41C57',
 UNLOCK_ZCDS_I_PLANIF           TYPE /BOBF/ACT_KEY VALUE '000C290F2DC31EDD91CF05BF4DC29C57',
 UPDATE_ZCDS_I_PLANIF           TYPE /BOBF/ACT_KEY VALUE '000C290F2DC31EDD91CF05BF4DC35C57',
 VALIDATE_ZCDS_I_PLANIF         TYPE /BOBF/ACT_KEY VALUE '000C290F2DC31EDD91CF05BF4DC3DC57',
      END OF ZCDS_I_PLANIF,
    END OF SC_ACTION .
  constants:
    BEGIN OF SC_ACTION_ATTRIBUTE,
        BEGIN OF ZCDS_I_PLANIF,
        BEGIN OF LOCK_ZCDS_I_PLANIF,
 GENERIC                        TYPE STRING VALUE 'GENERIC',
 EDIT_MODE                      TYPE STRING VALUE 'EDIT_MODE',
 ALL_NONE                       TYPE STRING VALUE 'ALL_NONE',
 SCOPE                          TYPE STRING VALUE 'SCOPE',
 FORCE_INVALIDATION             TYPE STRING VALUE 'FORCE_INVALIDATION',
 LOCK_PARAMETER_BUFFER          TYPE STRING VALUE 'LOCK_PARAMETER_BUFFER',
        END OF LOCK_ZCDS_I_PLANIF,
        BEGIN OF UNLOCK_ZCDS_I_PLANIF,
 GENERIC                        TYPE STRING VALUE 'GENERIC',
 EDIT_MODE                      TYPE STRING VALUE 'EDIT_MODE',
 ALL_NONE                       TYPE STRING VALUE 'ALL_NONE',
 SCOPE                          TYPE STRING VALUE 'SCOPE',
 FORCE_INVALIDATION             TYPE STRING VALUE 'FORCE_INVALIDATION',
 LOCK_PARAMETER_BUFFER          TYPE STRING VALUE 'LOCK_PARAMETER_BUFFER',
        END OF UNLOCK_ZCDS_I_PLANIF,
      END OF ZCDS_I_PLANIF,
    END OF SC_ACTION_ATTRIBUTE .
  constants:
    BEGIN OF SC_ALTERNATIVE_KEY,
      BEGIN OF ZCDS_I_ACTFLI,
 DB_KEY                         TYPE /BOBF/OBM_ALTKEY_KEY VALUE '000C290F2DC31EED91D8C0DC1F62603A',
 PARENT_KEY                     TYPE /BOBF/OBM_ALTKEY_KEY VALUE '000C290F2DC31EED91D8C0DC1F62803A',
      END OF ZCDS_I_ACTFLI,
      BEGIN OF ZCDS_I_PLANIF,
 DB_KEY                         TYPE /BOBF/OBM_ALTKEY_KEY VALUE '000C290F2DC31EDD91CF05D449329C57',
      END OF ZCDS_I_PLANIF,
    END OF SC_ALTERNATIVE_KEY .
  constants:
    BEGIN OF SC_ASSOCIATION,
      BEGIN OF ZCDS_I_ACTFLI,
 MESSAGE                        TYPE /BOBF/OBM_ASSOC_KEY VALUE '000C290F2DC31EED91D8C0DC1F65803A',
 PROPERTY                       TYPE /BOBF/OBM_ASSOC_KEY VALUE '000C290F2DC31EED91D8C0DC1F65C03A',
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '000C290F2DC31EED91D8C0DC1F67203A',
 TO_ROOT                        TYPE /BOBF/OBM_ASSOC_KEY VALUE '000C290F2DC31EED91D8C0DC1F67403A',
      END OF ZCDS_I_ACTFLI,
      BEGIN OF ZCDS_I_ACTFLI_MESSAGE,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '000C290F2DC31EED91D8C0DC1F67603A',
      END OF ZCDS_I_ACTFLI_MESSAGE,
      BEGIN OF ZCDS_I_ACTFLI_PROPERTY,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '000C290F2DC31EED91D8C0DC1F67803A',
      END OF ZCDS_I_ACTFLI_PROPERTY,
      BEGIN OF ZCDS_I_PLANIF,
 LOCK                           TYPE /BOBF/OBM_ASSOC_KEY VALUE '000C290F2DC31EDD91CF05BF4DC23C57',
 MESSAGE                        TYPE /BOBF/OBM_ASSOC_KEY VALUE '000C290F2DC31EDD91CF05BF4DC1FC57',
 PROPERTY                       TYPE /BOBF/OBM_ASSOC_KEY VALUE '000C290F2DC31EDD91CF05BF4DC2FC57',
 _FLIGHTS                       TYPE /BOBF/OBM_ASSOC_KEY VALUE '000C290F2DC31EED91D8C0DC1F65203A',
      END OF ZCDS_I_PLANIF,
      BEGIN OF ZCDS_I_PLANIF_LOCK,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '000C290F2DC31EDD91CF05BF4DC47C57',
      END OF ZCDS_I_PLANIF_LOCK,
      BEGIN OF ZCDS_I_PLANIF_MESSAGE,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '000C290F2DC31EDD91CF05BF4DC45C57',
      END OF ZCDS_I_PLANIF_MESSAGE,
      BEGIN OF ZCDS_I_PLANIF_PROPERTY,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '000C290F2DC31EDD91CF05BF4DC49C57',
      END OF ZCDS_I_PLANIF_PROPERTY,
    END OF SC_ASSOCIATION .
  constants:
    BEGIN OF SC_ASSOCIATION_ATTRIBUTE,
      BEGIN OF ZCDS_I_ACTFLI,
        BEGIN OF PROPERTY,
 ALL_NODE_PROPERTY              TYPE STRING VALUE 'ALL_NODE_PROPERTY',
 ALL_NODE_ATTRIBUTE_PROPERTY    TYPE STRING VALUE 'ALL_NODE_ATTRIBUTE_PROPERTY',
 ALL_ASSOCIATION_PROPERTY       TYPE STRING VALUE 'ALL_ASSOCIATION_PROPERTY',
 ALL_ASSOCIATION_ATTRIBUTE_PROP TYPE STRING VALUE 'ALL_ASSOCIATION_ATTRIBUTE_PROP',
 ALL_ACTION_PROPERTY            TYPE STRING VALUE 'ALL_ACTION_PROPERTY',
 ALL_ACTION_ATTRIBUTE_PROPERTY  TYPE STRING VALUE 'ALL_ACTION_ATTRIBUTE_PROPERTY',
 ALL_QUERY_PROPERTY             TYPE STRING VALUE 'ALL_QUERY_PROPERTY',
 ALL_QUERY_ATTRIBUTE_PROPERTY   TYPE STRING VALUE 'ALL_QUERY_ATTRIBUTE_PROPERTY',
 ALL_SUBTREE_PROPERTY           TYPE STRING VALUE 'ALL_SUBTREE_PROPERTY',
        END OF PROPERTY,
      END OF ZCDS_I_ACTFLI,
      BEGIN OF ZCDS_I_PLANIF,
        BEGIN OF PROPERTY,
 ALL_NODE_PROPERTY              TYPE STRING VALUE 'ALL_NODE_PROPERTY',
 ALL_NODE_ATTRIBUTE_PROPERTY    TYPE STRING VALUE 'ALL_NODE_ATTRIBUTE_PROPERTY',
 ALL_ASSOCIATION_PROPERTY       TYPE STRING VALUE 'ALL_ASSOCIATION_PROPERTY',
 ALL_ASSOCIATION_ATTRIBUTE_PROP TYPE STRING VALUE 'ALL_ASSOCIATION_ATTRIBUTE_PROP',
 ALL_ACTION_PROPERTY            TYPE STRING VALUE 'ALL_ACTION_PROPERTY',
 ALL_ACTION_ATTRIBUTE_PROPERTY  TYPE STRING VALUE 'ALL_ACTION_ATTRIBUTE_PROPERTY',
 ALL_QUERY_PROPERTY             TYPE STRING VALUE 'ALL_QUERY_PROPERTY',
 ALL_QUERY_ATTRIBUTE_PROPERTY   TYPE STRING VALUE 'ALL_QUERY_ATTRIBUTE_PROPERTY',
 ALL_SUBTREE_PROPERTY           TYPE STRING VALUE 'ALL_SUBTREE_PROPERTY',
        END OF PROPERTY,
      END OF ZCDS_I_PLANIF,
    END OF SC_ASSOCIATION_ATTRIBUTE .
  constants:
    SC_BO_KEY  TYPE /BOBF/OBM_BO_KEY VALUE '000C290F2DC31EDD91CF05BF4DC15C57' .
  constants:
    SC_BO_NAME TYPE /BOBF/OBM_NAME VALUE 'ZCDS_I_PLANIF' .
  constants:
    BEGIN OF SC_DETERMINATION,
      BEGIN OF ZCDS_I_ACTFLI,
 ACTION_AND_FIELD_CONTROL       TYPE /BOBF/DET_KEY VALUE '000C290F2DC31EED91D8C0DC1F62A03A',
 PAYMENT_SUM                    TYPE /BOBF/DET_KEY VALUE '000C290F2DC31EED92B6329301F20AC8',
 SET_IDS                        TYPE /BOBF/DET_KEY VALUE '000C290F2DC31EED91EAAA6120916070',
      END OF ZCDS_I_ACTFLI,
      BEGIN OF ZCDS_I_PLANIF,
 ACTION_AND_FIELD_CONTROL       TYPE /BOBF/DET_KEY VALUE '000C290F2DC31EDD91CF05D44932BC57',
 SET_CONID                      TYPE /BOBF/DET_KEY VALUE '000C290F2DC31EDD91D1E353A436BDF6',
      END OF ZCDS_I_PLANIF,
    END OF SC_DETERMINATION .
  constants:
    BEGIN OF SC_GROUP,
 ZCDS_I_PLANIF                  TYPE /BOBF/OBM_GROUP_KEY VALUE '000C290F2DC31EED91F13AE61B3DE3CC',
    END OF SC_GROUP .
  constants:
    SC_MODEL_VERSION TYPE /BOBF/CONF_VERSION VALUE '00000' .
  constants:
    BEGIN OF SC_NODE,
 ZCDS_I_ACTFLI                  TYPE /BOBF/OBM_NODE_KEY VALUE '000C290F2DC31EED91D8C0DC1F61E03A',
 ZCDS_I_ACTFLI_MESSAGE          TYPE /BOBF/OBM_NODE_KEY VALUE '000C290F2DC31EED91D8C0DC1F65603A',
 ZCDS_I_ACTFLI_PROPERTY         TYPE /BOBF/OBM_NODE_KEY VALUE '000C290F2DC31EED91D8C0DC1F65A03A',
 ZCDS_I_PLANIF                  TYPE /BOBF/OBM_NODE_KEY VALUE '000C290F2DC31EDD91CF05BF4DC19C57',
 ZCDS_I_PLANIF_LOCK             TYPE /BOBF/OBM_NODE_KEY VALUE '000C290F2DC31EDD91CF05BF4DC21C57',
 ZCDS_I_PLANIF_MESSAGE          TYPE /BOBF/OBM_NODE_KEY VALUE '000C290F2DC31EDD91CF05BF4DC1DC57',
 ZCDS_I_PLANIF_PROPERTY         TYPE /BOBF/OBM_NODE_KEY VALUE '000C290F2DC31EDD91CF05BF4DC2DC57',
    END OF SC_NODE .
  constants:
    BEGIN OF SC_NODE_ATTRIBUTE,
      BEGIN OF ZCDS_I_ACTFLI,
  NODE_DATA                      TYPE STRING VALUE 'NODE_DATA',
  CARRID                         TYPE STRING VALUE 'CARRID',
  CONNID                         TYPE STRING VALUE 'CONNID',
  FLDATE                         TYPE STRING VALUE 'FLDATE',
  PRICE                          TYPE STRING VALUE 'PRICE',
  CURRENCY                       TYPE STRING VALUE 'CURRENCY',
  PLANETYPE                      TYPE STRING VALUE 'PLANETYPE',
  SEATSMAX                       TYPE STRING VALUE 'SEATSMAX',
  SEATSOCC                       TYPE STRING VALUE 'SEATSOCC',
  PAYMENTSUM                     TYPE STRING VALUE 'PAYMENTSUM',
      END OF ZCDS_I_ACTFLI,
      BEGIN OF ZCDS_I_PLANIF,
  NODE_DATA                      TYPE STRING VALUE 'NODE_DATA',
  CARRID                         TYPE STRING VALUE 'CARRID',
  CONNID                         TYPE STRING VALUE 'CONNID',
  CITYFROM                       TYPE STRING VALUE 'CITYFROM',
  AIRPFROM                       TYPE STRING VALUE 'AIRPFROM',
  CITYTO                         TYPE STRING VALUE 'CITYTO',
  AIRPTO                         TYPE STRING VALUE 'AIRPTO',
  FLTIME                         TYPE STRING VALUE 'FLTIME',
  DEPTIME                        TYPE STRING VALUE 'DEPTIME',
  ARRTIME                        TYPE STRING VALUE 'ARRTIME',
  DISTANCE                       TYPE STRING VALUE 'DISTANCE',
  DISTID                         TYPE STRING VALUE 'DISTID',
      END OF ZCDS_I_PLANIF,
    END OF SC_NODE_ATTRIBUTE .
  constants:
    BEGIN OF SC_NODE_CATEGORY,
      BEGIN OF ZCDS_I_ACTFLI,
 ZCDS_I_ACTFLI                  TYPE /BOBF/OBM_NODE_CAT_KEY VALUE '000C290F2DC31EED91D8C0DC1F65003A',
      END OF ZCDS_I_ACTFLI,
      BEGIN OF ZCDS_I_PLANIF,
 ROOT                           TYPE /BOBF/OBM_NODE_CAT_KEY VALUE '000C290F2DC31EDD91CF05BF4DC1BC57',
      END OF ZCDS_I_PLANIF,
    END OF SC_NODE_CATEGORY .
  constants:
    BEGIN OF SC_VALIDATION,
      BEGIN OF ZCDS_I_ACTFLI,
 F_VALIDATIONS                  TYPE /BOBF/VAL_KEY VALUE '000C290F2DC31EED91F13AE61B3D83CC',
      END OF ZCDS_I_ACTFLI,
    END OF SC_VALIDATION .
endinterface.
