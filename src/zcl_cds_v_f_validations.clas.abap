CLASS zcl_cds_v_f_validations DEFINITION
  PUBLIC
  INHERITING FROM /bobf/cl_lib_v_supercl_simple
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /bobf/if_frw_validation~execute
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS :validate_date IMPORTING iv_fldate TYPE sydatum
                                     iv_carid  TYPE s_carr_id
                                     iv_conid  TYPE s_conn_id
                           EXPORTING es_msg    TYPE symsg,

      validate_arifare IMPORTING iv_airfare TYPE s_price
                       EXPORTING es_msg     TYPE symsg,
      validate_plane IMPORTING iv_plane TYPE s_planetye
                     EXPORTING es_msg   TYPE symsg.

ENDCLASS.



CLASS zcl_cds_v_f_validations IMPLEMENTATION.


  METHOD /bobf/if_frw_validation~execute.


    DATA: lw_msg TYPE symsg,
          lv_err TYPE char1.

    DATA(lt_actfli) = VALUE ztcds_i_actfli( ).



    IF eo_message IS NOT BOUND.
      eo_message = /bobf/cl_frw_factory=>get_message( ).
    ENDIF.


    io_read->retrieve(
      EXPORTING
        iv_node                 =  is_ctx-node_key                " Node Name
        it_key                  =  it_key                " Key Table
*          iv_before_image         = abap_false       " Data Element for Domain BOOLE: TRUE (="X") and FALSE (=" ")
*          iv_fill_data            = abap_true        " Data element for domain BOOLE: TRUE (='X') and FALSE (=' ')
*          it_requested_attributes =                  " List of Names (e.g. Fieldnames)
      IMPORTING
*          eo_message              =                  " Message Object
        et_data                 = lt_actfli                 " Data Return Structure
*          et_failed_key           =                  " Key Table
*          et_node_cat             =                  " Node Category Assignment
    ).



    LOOP AT lt_actfli REFERENCE INTO DATA(lo_actfli).


      lo_actfli->paymentsum = lo_actfli->seatsmax * lo_actfli->price.

      me->validate_date(
        EXPORTING
          iv_fldate = lo_actfli->fldate
          iv_carid  = lo_actfli->carrid
          iv_conid  = lo_actfli->connid
        IMPORTING
          es_msg    = lw_msg
      ).
      IF lw_msg-msgty EQ 'E'.
        eo_message->add_message(
          EXPORTING
            is_msg       =  lw_msg                " Message that is to be added to the message object
            iv_node      = is_ctx-node_key                 " Node to be used in the origin location
            iv_key       = lo_actfli->key                 " Instance key to be used in the origin location
*               iv_attribute =                  " Attribute to be used in the origin location
*               iv_lifetime  =                  " Lifetime of the message
        ).
        CLEAR :lw_msg.
        lv_err = 'E'.

      ENDIF.

      me->validate_arifare(
        EXPORTING
          iv_airfare = lo_actfli->price
        IMPORTING
          es_msg     = lw_msg
      ).

      IF lw_msg-msgty EQ 'E'.
        eo_message->add_message(
          EXPORTING
            is_msg       =  lw_msg                " Message that is to be added to the message object
            iv_node      = is_ctx-node_key                 " Node to be used in the origin location
            iv_key       = lo_actfli->key                 " Instance key to be used in the origin location
*               iv_attribute =                  " Attribute to be used in the origin location
*               iv_lifetime  =                  " Lifetime of the message
        ).
        lv_err = 'E'.
        CLEAR :lw_msg.
      ENDIF.

      me->validate_plane(
        EXPORTING
          iv_plane = lo_actfli->planetype
        IMPORTING
          es_msg   = lw_msg
      ).
      IF lw_msg-msgty EQ 'E'.
        eo_message->add_message(
          EXPORTING
            is_msg       =  lw_msg                " Message that is to be added to the message object
            iv_node      = is_ctx-node_key                 " Node to be used in the origin location
            iv_key       = lo_actfli->key                 " Instance key to be used in the origin location
*               iv_attribute =                  " Attribute to be used in the origin location
*               iv_lifetime  =                  " Lifetime of the message
        ).
        lv_err = 'E'.
        CLEAR :lw_msg.
      ENDIF.

    ENDLOOP.

    IF lv_err IS NOT INITIAL.
      APPEND INITIAL LINE TO et_failed_key ASSIGNING FIELD-SYMBOL(<ls_failed_key>).
      <ls_failed_key>-key = lo_actfli->key.
    ENDIF.
  ENDMETHOD.
  METHOD validate_date.
    IF iv_fldate IS INITIAL.
      es_msg = VALUE #(  msgty =  'E'
                  msgid = '00'
                  msgno = '001'
                  msgv1 = 'Date Can´t be empty' ).

    ENDIF.
  ENDMETHOD.

  METHOD validate_arifare.

    IF iv_airfare IS INITIAL.
      es_msg = VALUE #(  msgty =  'E'
               msgid = '00'
               msgno = '001'
               msgv1 = 'Airfare is Required' ).
    ENDIF.

  ENDMETHOD.



  METHOD validate_plane.
    IF iv_plane IS INITIAL.
      es_msg = VALUE #(  msgty =  'E'
               msgid = '00'
               msgno = '001'
               msgv1 = 'Plane Type is Required' ).
    ELSE.

      SELECT planetype UP TO 1 ROWS
      INTO @DATA(lv_type)
      FROM saplane
      WHERE planetype EQ @iv_plane
      .
      ENDSELECT.
      IF sy-subrc NE 0.
        es_msg = VALUE #(  msgty =  'E'
               msgid = '00'
               msgno = '001'
               msgv1 = 'Plane Type is not valid' ).
      ENDIF.

    ENDIF.
  ENDMETHOD.

ENDCLASS.
