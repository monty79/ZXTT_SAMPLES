*&---------------------------------------------------------------------*
*& Report ZXTT_TEST_PIVOT
*&---------------------------------------------------------------------*
REPORT zxtt_test_19000101.

DATA
: BEGIN OF ls_data
,   datumz TYPE d VALUE '00000101'
,   datum0 TYPE d VALUE '18991230'
,   datum1 TYPE d VALUE '18991231'
,   datum2 TYPE d VALUE '19000101'
,   datum3 TYPE d VALUE '19000228'
,   datum4 TYPE d VALUE '19000301'
,   betrg TYPE betrg
, END OF ls_data
.
  NEW zcl_xtt_excel_xlsx(
    NEW zcl_xtt_file_smw0( 'ZXTT_TEST_19000101.XLSX' )
      )->merge( is_block = ls_data
    )->download( ).


*  CONSTANTS: gc_save_file_name TYPE string VALUE 'ZXTT_TEST_19000101.xlsx'.
*INCLUDE zdemo_excel_outputopt_incl.
*
*  DATA(lo_excel) = NEW zcl_excel( ).
*  DATA(lo_worksheet) = lo_excel->get_active_worksheet( ).
*  lo_worksheet->set_cell( ip_column = 'A' ip_row = 2 ip_value = ls_data-datum0 ).
*  lo_worksheet->set_cell( ip_column = 'A' ip_row = 3 ip_value = ls_data-datum1 ).
*  lo_worksheet->set_cell( ip_column = 'A' ip_row = 4 ip_value = ls_data-datum2 ).
*  lo_worksheet->set_cell( ip_column = 'A' ip_row = 5 ip_value = ls_data-datum3 ).
*  lo_worksheet->set_cell( ip_column = 'A' ip_row = 6 ip_value = ls_data-datum4 ).
*  lcl_output=>output( lo_excel ).
