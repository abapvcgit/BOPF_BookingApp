CLASS zcl_cds_v_booking_validations DEFINITION
  PUBLIC
  INHERITING FROM /bobf/cl_lib_v_supercl_simple
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /bobf/if_frw_validation~execute
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS :validate_planif IMPORTING iv_fldate TYPE sydatum
                                       iv_carid  TYPE s_carr_id
                                       iv_conid  TYPE s_conn_id
                             EXPORTING es_msg    TYPE symsg,
      validate_weight IMPORTING iv_weight TYPE s_lugweigh
                      EXPORTING es_msg    TYPE symsg,
      validate_price  IMPORTING iv_price TYPE s_f_cur_pr
                      EXPORTING es_msg   TYPE symsg.
ENDCLASS.



CLASS zcl_cds_v_booking_validations IMPLEMENTATION.


  METHOD /bobf/if_frw_validation~execute.

    DATA: lw_msg TYPE symsg,
          lv_err TYPE char1.

    DATA(lt_bookings) = VALUE ztcds_i_bookings( ).

    IF eo_message IS NOT BOUND.
      eo_message = /bobf/cl_frw_factory=>get_message( ).
    ENDIF.

    io_read->retrieve(
        EXPORTING
          iv_node                 = is_ctx-node_key                 " Node Name
          it_key                  = it_key                 " Key Table
*                iv_before_image         = abap_false       " Data Element for Domain BOOLE: TRUE (="X") and FALSE (=" ")
*                iv_fill_data            = abap_true        " Data element for domain BOOLE: TRUE (='X') and FALSE (=' ')
*                it_requested_attributes =                  " List of Names (e.g. Fieldnames)
        IMPORTING
*                eo_message              =                  " Message Object
          et_data                 = lt_bookings                 " Data Return Structure
*                et_failed_key           =                  " Key Table
*                et_node_cat             =                  " Node Category Assignment
        ).

    LOOP AT lt_bookings REFERENCE INTO DATA(lo_booking).

      me->validate_planif(
        EXPORTING
          iv_fldate = lo_booking->fldate
          iv_carid  = lo_booking->carrid
          iv_conid  = lo_booking->connid
        IMPORTING
          es_msg    = lw_msg
      ).
      IF lw_msg-msgty EQ 'E'.
        eo_message->add_message(
          EXPORTING
            is_msg       =  lw_msg                " Message that is to be added to the message object
            iv_node      = is_ctx-node_key                 " Node to be used in the origin location
            iv_key       = lo_booking->key                 " Instance key to be used in the origin location
*               iv_attribute =                  " Attribute to be used in the origin location
*               iv_lifetime  =                  " Lifetime of the message
        ).
        CLEAR :lw_msg.
        lv_err = 'E'.
      ENDIF.

      me->validate_weight(
        EXPORTING
          iv_weight = lo_booking->luggweight
        IMPORTING
          es_msg    = lw_msg
      ).
      IF lw_msg-msgty EQ 'E'.
        eo_message->add_message(
          EXPORTING
            is_msg       =  lw_msg                " Message that is to be added to the message object
            iv_node      = is_ctx-node_key                 " Node to be used in the origin location
            iv_key       = lo_booking->key                 " Instance key to be used in the origin location
*               iv_attribute =                  " Attribute to be used in the origin location
*               iv_lifetime  =                  " Lifetime of the message
        ).
        CLEAR :lw_msg.
        lv_err = 'E'.
      ENDIF.

      me->validate_price(
        EXPORTING
          iv_price = lo_booking->forcuram
        IMPORTING
          es_msg   = lw_msg
      ).

      IF lw_msg-msgty EQ 'E'.
        eo_message->add_message(
          EXPORTING
            is_msg       =  lw_msg                " Message that is to be added to the message object
            iv_node      = is_ctx-node_key                 " Node to be used in the origin location
            iv_key       = lo_booking->key                 " Instance key to be used in the origin location
*               iv_attribute =                  " Attribute to be used in the origin location
*               iv_lifetime  =                  " Lifetime of the message
        ).
        CLEAR :lw_msg.
        lv_err = 'E'.
      ENDIF.

      IF lv_err IS NOT INITIAL.
        APPEND INITIAL LINE TO et_failed_key ASSIGNING FIELD-SYMBOL(<ls_failed_key>).
        <ls_failed_key>-key = lo_booking->key.
      ENDIF.
    ENDLOOP.



  ENDMETHOD.
  METHOD validate_planif.
    IF iv_fldate IS INITIAL OR iv_carid IS INITIAL OR iv_conid IS INITIAL.
      es_msg = VALUE #(  msgty =  'E'
                  msgid = '00'
                  msgno = '001'
                  msgv1 = 'Some of the Booking Flight fields are empty' ).
    ELSE.

      SELECT carrid UP TO 1 ROWS
      INTO @DATA(lv_carid)
      FROM actfli
      WHERE carrid EQ @iv_carid
      AND connid EQ @iv_conid
      AND fldate EQ @iv_fldate.
      ENDSELECT.
      IF sy-subrc NE 0.
        es_msg = VALUE #(  msgty =  'E'
                msgid = '00'
                msgno = '001'
                msgv1 = 'The Booking Flight fields are not register in Flights ' ).
      ENDIF.

    ENDIF.
  ENDMETHOD.

  METHOD validate_weight.
    IF iv_weight IS INITIAL.
      es_msg = VALUE #(  msgty =  'E'
                  msgid = '00'
                  msgno = '001'
                  msgv1 = 'Luggage Weight is required' ).
    ENDIF.
  ENDMETHOD.

  METHOD validate_price.
    IF iv_price IS INITIAL.
      es_msg = VALUE #(  msgty =  'E'
                msgid = '00'
                msgno = '001'
                msgv1 = 'Amount is required' ).
    ENDIF.
  ENDMETHOD.

ENDCLASS.
