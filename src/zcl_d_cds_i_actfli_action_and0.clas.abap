CLASS zcl_d_cds_i_actfli_action_and0 DEFINITION
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



CLASS zcl_d_cds_i_actfli_action_and0 IMPLEMENTATION.


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

    DATA(lo_helper_paymentsum) = NEW /bobf/cl_lib_h_set_property( io_modify = io_modify
                                                     is_context = is_ctx ).

    DATA(lo_helper_capacity) = NEW /bobf/cl_lib_h_set_property( io_modify = io_modify
    is_context = is_ctx ).

    LOOP AT lt_actfli REFERENCE INTO DATA(lo_actfli) .


      lo_helper_paymentsum->set_attribute_read_only(
          iv_attribute_name = zif_cds_i_planif_c=>sc_node_attribute-zcds_i_actfli-paymentsum
          iv_key            = lo_actfli->key ).

      lo_helper_capacity->set_attribute_read_only(
        iv_attribute_name = zif_cds_i_planif_c=>sc_node_attribute-zcds_i_actfli-seatsmax
        iv_key            = lo_actfli->key ).
    ENDLOOP.


  ENDMETHOD.
ENDCLASS.
