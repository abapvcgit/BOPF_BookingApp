CLASS zcl_cds_d_set_booking_id DEFINITION
  PUBLIC
  INHERITING FROM /bobf/cl_lib_d_supercl_simple
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /bobf/if_frw_determination~execute
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cds_d_set_booking_id IMPLEMENTATION.


  METHOD /bobf/if_frw_determination~execute.

    DATA: lv_counter   TYPE char12,
          lv_timestamp TYPE timestampl.
    DATA(lt_bookings) = VALUE ztcds_i_bookings( ).


    io_read->retrieve(
  EXPORTING
    iv_node                 = is_ctx-node_key                 " Node Name
    it_key                  = it_key                 " Key Table
*        iv_before_image         = abap_false       " Data Element for Domain BOOLE: TRUE (="X") and FALSE (=" ")
*        iv_fill_data            = abap_true        " Data element for domain BOOLE: TRUE (='X') and FALSE (=' ')
*        it_requested_attributes =                  " List of Names (e.g. Fieldnames)
  IMPORTING
*        eo_message              =                  " Message Object
    et_data                 = lt_bookings                 " Data Return Structure
*        et_failed_key           =                  " Key Table
*        et_node_cat             =                  " Node Category Assignment
).

  LOOP AT lt_bookings REFERENCE INTO DATA(lo_booking) WHERE bookid is INITIAL.

    CALL FUNCTION 'NUMBER_GET_NEXT'
        EXPORTING
          nr_range_nr             = '01'
          object                  = 'ZBOOKINGID'
        IMPORTING
          number                  = lv_counter
        EXCEPTIONS
          interval_not_found      = 1
          number_range_not_intern = 2
          object_not_found        = 3
          quantity_is_0           = 4
          quantity_is_not_1       = 5
          interval_overflow       = 6
          buffer_overflow         = 7
          OTHERS                  = 8.

      IF sy-subrc <> 0.
*
      ENDIF.
      lo_booking->bookid = lv_counter.
      lo_booking->order_date = sy-datum.
      io_modify->update(
            EXPORTING
            iv_node           = is_ctx-node_key    " uuid of node
            iv_key            = lo_booking->key       " key of line
            is_data           = lo_booking            " ref to modified data
            it_changed_fields = VALUE #(
                                          ( zif_cds_i_bookings_c=>sc_node_attribute-zcds_i_bookings-bookid )
                                          ( zif_cds_i_bookings_c=>sc_node_attribute-zcds_i_bookings-order_date )
                                         )
            ).
      CLEAR: lv_counter.
  ENDLOOP.

  ENDMETHOD.
ENDCLASS.
