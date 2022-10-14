class ZCL_ZCDS_C_BOOKINGS definition
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



CLASS ZCL_ZCDS_C_BOOKINGS IMPLEMENTATION.


  method GET_PATHS.
et_paths = VALUE #(
( |CDS~ZCDS_C_BOOKINGS| )
).
  endmethod.


  method GET_TIMESTAMP.
RV_TIMESTAMP = 20221014170628.
  endmethod.
ENDCLASS.
