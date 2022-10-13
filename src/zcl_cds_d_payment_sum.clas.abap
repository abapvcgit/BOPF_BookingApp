CLASS zcl_cds_d_payment_sum DEFINITION
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



CLASS zcl_cds_d_payment_sum IMPLEMENTATION.


  METHOD /bobf/if_frw_determination~execute.

    DATA(lt_actfli) = VALUE ztcds_i_actfli( ).

    io_read->retrieve(
    EXPORTING
      iv_node                 =  is_ctx-node_key                " Node Name
      it_key                  =  it_key                " Key Table
*        iv_before_image         = abap_false       " Data Element for Domain BOOLE: TRUE (="X") and FALSE (=" ")
*        iv_fill_data            = abap_true        " Data element for domain BOOLE: TRUE (='X') and FALSE (=' ')
*        it_requested_attributes =                  " List of Names (e.g. Fieldnames)
    IMPORTING
*        eo_message              =                  " Message Object
      et_data                 =  lt_actfli                " Data Return Structure
*        et_failed_key           =                  " Key Table
*        et_node_cat             =                  " Node Category Assignment
  ).


    LOOP AT lt_actfli REFERENCE INTO DATA(lo_actfli) .

      SELECT seatsmax UP TO 1 ROWS
        INTO @DATA(lv_seatsmax)
        FROM saplane
        WHERE planetype EQ @lo_actfli->planetype.
      ENDSELECT.
      lo_actfli->seatsmax = lv_seatsmax.
      lo_actfli->paymentsum = lo_actfli->seatsmax * lo_actfli->price.
      io_modify->update(
        EXPORTING
          iv_node           = is_ctx-node_key                 " Node
          iv_key            = lo_actfli->key                 " Key
*            iv_root_key       =                  " NodeID
          is_data           = lo_actfli                  " Data
*            it_changed_fields =                  " List of Names (e.g. Fieldnames)
      ).

    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
