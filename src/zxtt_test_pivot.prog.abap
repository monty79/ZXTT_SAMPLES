*&---------------------------------------------------------------------*
*& Report ZXTT_TEST_PIVOT
*&---------------------------------------------------------------------*
*& PoC сводные таблицы в Excel через XTT
*&---------------------------------------------------------------------*
REPORT zxtt_test_pivot.

TYPES
: BEGIN OF lty_data
,   plans TYPE pltxt
,   betrg TYPE betrg
, END OF lty_data
.
TYPES ltt_data TYPE STANDARD TABLE OF lty_data WITH DEFAULT KEY.

DATA(lo_xtt) = NEW zcl_xtt_excel_xlsx( NEW zcl_xtt_file_smw0( 'ZXTT_TEST_PIVOT.XLSX' ) ).

lo_xtt->merge(
  is_block = NEW ltt_data(
    plans = 'ABAPer'
    ( betrg = 100500 )
    ( betrg = 200800 )
    ( betrg = 300900 )
    plans = 'Tractor Operator'
    ( betrg = 100 )
    ( betrg = 200 )
    ( betrg = 300 )
    ( betrg = 400 )
  )
)->download( ).
