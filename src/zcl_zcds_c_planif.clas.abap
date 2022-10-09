class ZCL_ZCDS_C_PLANIF definition
  public
  inheriting from CL_SADL_GTK_EXPOSURE_MPC
  final
  create public .

public section.
protected section.

  methods GET_PATHS
    redefinition .
  methods GET_TIMESTAMP
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZCDS_C_PLANIF IMPLEMENTATION.


  method GET_PATHS.
et_paths = VALUE #(
( |CDS~ZCDS_C_PLANIF| )
).
  endmethod.


  method GET_TIMESTAMP.
RV_TIMESTAMP = 20221007195617.
  endmethod.
ENDCLASS.
