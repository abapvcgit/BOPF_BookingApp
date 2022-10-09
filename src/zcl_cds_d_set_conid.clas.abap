CLASS zcl_cds_d_set_conid DEFINITION
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



CLASS zcl_cds_d_set_conid IMPLEMENTATION.


  METHOD /bobf/if_frw_determination~execute.


    DATA lv_counter TYPE char12.
    DATA lv_timestamp TYPE timestampl.
    DATA(lt_planfli) = VALUE ztcds_i_planif( ).

    io_read->retrieve(
   EXPORTING
     iv_node                 = is_ctx-node_key                 " Node Name
     it_key                  = it_key                 " Key Table
*        iv_before_image         = abap_false       " Data Element for Domain BOOLE: TRUE (="X") and FALSE (=" ")
*        iv_fill_data            = abap_true        " Data element for domain BOOLE: TRUE (='X') and FALSE (=' ')
*        it_requested_attributes =                  " List of Names (e.g. Fieldnames)
   IMPORTING
*        eo_message              =                  " Message Object
     et_data                 = lt_planfli                 " Data Return Structure
*        et_failed_key           =                  " Key Table
*        et_node_cat             =                  " Node Category Assignment
 ).



    LOOP AT lt_planfli REFERENCE INTO DATA(lo_plan) WHERE connid IS INITIAL.

      CALL FUNCTION 'NUMBER_GET_NEXT'
        EXPORTING
          nr_range_nr             = '01'
          object                  = 'ZCONID'
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
      lo_plan->connid = lv_counter.

      io_modify->update(
            EXPORTING
            iv_node           = is_ctx-node_key    " uuid of node
            iv_key            = lo_plan->key       " key of line
            is_data           = lo_plan            " ref to modified data
            it_changed_fields = VALUE #( ( zif_cds_i_planif_c=>sc_node_attribute-zcds_i_planif-connid )
                                         )
            ).
      CLEAR: lv_counter.
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
