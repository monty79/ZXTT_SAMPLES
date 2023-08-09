*&---------------------------------------------------------------------*
*& Merge test in XTT
*&---------------------------------------------------------------------*
report ZTEST_GROUP_MERGE_XTT.
types
: begin of GTY_TAB
,   LEV1_ID     type HROBJID
,   LEV1_NAME   type STRING
,   LEV2_ID     type HROBJID
,   LEV2_NAME   type STRING
,   DETAIL_ID   type HROBJID
,   DETAIL_NAME type STRING
,   VALUE       type I
,   HIDE        type ABAP_BOOL
, end of GTY_TAB
, GTT_TAB type standard table of GTY_TAB with default key
.
PARAMETERS hide_l1 TYPE abap_bool as CHECKBOX.
PARAMETERS hide_l2 TYPE abap_bool as CHECKBOX.

class LCL_HANDLER definition final.
  public section.
    class-methods ON_TREE for event PREPARE_TREE of ZCL_XTT_REPLACE_BLOCK
      importing IR_TREE IR_DATA.
endclass.

class LCL_HANDLER implementation.
  method ON_TREE.
    field-symbols <TAB> type GTY_TAB.
    assign IR_DATA->* to <TAB>.
    case IR_TREE->LEVEL.
      when 1. <TAB>-HIDE = hide_l1.
      when 2. <TAB>-HIDE = hide_l2.
    endcase.
  endmethod.
endclass .

start-of-selection.
  data
  : begin of GS_DATA
  ,   T type GTT_TAB
  , end of GS_DATA
  .
  GS_DATA-T = value #(
    LEV1_ID  = '10' LEV1_NAME = 'Level1-a'
      LEV2_ID = '20' LEV2_NAME = 'Service'
        ( DETAIL_ID = '31' DETAIL_NAME = 'detail_a' VALUE = 1 )
        ( DETAIL_ID = '32' DETAIL_NAME = 'detail_b' VALUE = 2 )
      LEV2_ID = '21' LEV2_NAME = 'Managers'
        ( DETAIL_ID = '33' DETAIL_NAME = 'detail_c' VALUE = 3 )
        ( DETAIL_ID = '34' DETAIL_NAME = 'detail_d' VALUE = 4 )

    LEV1_ID  = '20' LEV1_NAME = 'Level1-b'
      LEV2_ID = '22' LEV2_NAME = 'Managers'
        ( DETAIL_ID = '35' DETAIL_NAME = 'detail_e' VALUE = 5 )
        ( DETAIL_ID = '36' DETAIL_NAME = 'detail_f' VALUE = 6 )
        ( DETAIL_ID = '37' DETAIL_NAME = 'detail_g' VALUE = 7 )
      LEV2_ID = '23' LEV2_NAME = 'Service'
        ( DETAIL_ID = '38' DETAIL_NAME = 'detail_h' VALUE = 8 )
        ( DETAIL_ID = '39' DETAIL_NAME = 'detail_i' VALUE = 9 )
        ( DETAIL_ID = '40' DETAIL_NAME = 'detail_j' VALUE = 10 )
  ).

end-of-selection.
  data(LO_XTT) = new ZCL_XTT_EXCEL_XLSX( new ZCL_XTT_FILE_SMW0( 'ZTEST_GROUP_MERGE_XTT.XLSX' ) ).
  set HANDLER LCL_HANDLER=>ON_TREE activation abap_true.
  LO_XTT->MERGE( IS_BLOCK = GS_DATA ).
  set HANDLER LCL_HANDLER=>ON_TREE activation abap_false.
  LO_XTT->DOWNLOAD( ).
