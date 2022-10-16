CLASS zcl_cds_a_set_invoice DEFINITION
  PUBLIC
  INHERITING FROM /bobf/cl_lib_a_supercl_simple
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /bobf/if_frw_action~execute
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cds_a_set_invoice IMPLEMENTATION.


  METHOD /bobf/if_frw_action~execute.

    DATA(lt_bookings) = VALUE ztcds_i_bookings( ).
    DATA:lw_msg TYPE symsg.

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

      IF lo_booking->invoice IS INITIAL.
        lo_booking->invoice = 'X'.


        io_modify->update(
              EXPORTING
              iv_node           = is_ctx-node_key    " uuid of node
              iv_key            = lo_booking->key       " key of line
              is_data           = lo_booking            " ref to modified data
              it_changed_fields = VALUE #(
                                            ( zif_cds_i_bookings_c=>sc_node_attribute-zcds_i_bookings-invoice )
                                           )
              ).
        lw_msg = VALUE #(  msgty =  'S'
               msgid = '00'
               msgno = '001'
               msgv1 = 'Invoice Set' ).

        eo_message->add_message(
             EXPORTING
               is_msg       =  lw_msg                " Message that is to be added to the message object
               iv_node      = is_ctx-node_key                 " Node to be used in the origin location
               iv_key       = lo_booking->key                 " Instance key to be used in the origin location
*               iv_attribute =                  " Attribute to be used in the origin location
*               iv_lifetime  =                  " Lifetime of the message
           ).
      ENDIF.
    ENDLOOP.
    io_modify->end_modify( iv_process_immediately = abap_true ).
  ENDMETHOD.
ENDCLASS.
