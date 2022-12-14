CLASS zcl_cds_d_set_ids DEFINITION
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



CLASS zcl_cds_d_set_ids IMPLEMENTATION.


  METHOD /bobf/if_frw_determination~execute.

    DATA(lt_actfli) = VALUE ztcds_i_actfli( ).
    DATA(lt_planfli) = VALUE ztcds_i_planif( ).

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

    io_read->retrieve_by_association(
       EXPORTING
         iv_node                 = zif_cds_i_planif_c=>sc_node-zcds_i_actfli                 " Node Name
         it_key                  =  it_key                 " Key Table
         iv_association          = zif_cds_i_planif_c=>sc_association-zcds_i_actfli-to_root                 " Name of Association
*          is_parameters           =
*          it_filtered_attributes  =                  " List of Names (e.g. Fieldnames)
         iv_fill_data            = abap_true       " Data Element for Domain BOOLE: TRUE (="X") and FALSE (=" ")
*          iv_before_image         = abap_false       " Data Element for Domain BOOLE: TRUE (="X") and FALSE (=" ")
*          it_requested_attributes =                  " List of Names (e.g. Fieldnames)
       IMPORTING
*          eo_message              =                  " Message Object
         et_data                 = lt_planfli                 " Data Return Structure
*          et_key_link             =                  " Key Link
*          et_target_key           =                  " Key Table
*          et_failed_key           =                  " Key Table
     ).
    READ TABLE lt_planfli REFERENCE INTO DATA(lo_plan) INDEX 1.
    IF sy-subrc EQ 0.
      LOOP AT lt_actfli REFERENCE INTO DATA(lo_actfli) WHERE connid IS INITIAL
                                                       AND carrid IS INITIAL.
        lo_actfli->carrid = lo_plan->carrid.
        lo_actfli->connid = lo_plan->connid.

        io_modify->update(
          EXPORTING
            iv_node           = is_ctx-node_key                 " Node
            iv_key            = lo_actfli->key                 " Key
*            iv_root_key       =                  " NodeID
            is_data           = lo_actfli                  " Data
*            it_changed_fields =                  " List of Names (e.g. Fieldnames)
        ).

      ENDLOOP.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
