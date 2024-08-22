*&---------------------------------------------------------------------*
*& Перевод строки во всех видах
*&---------------------------------------------------------------------*
report ZXTT_TEST_CRLF.
types
: begin of TY_TAB_STR
,   CELL_BREAK type STRING
, end of TY_TAB_STR
.
data
: begin of LS_DATA
,   HEAD_BREAK type STRING
,   T type standard table of TY_TAB_STR
, end of LS_DATA
.

start-of-selection.
  LS_DATA = value #(
    HEAD_BREAK = 'Одна строка' && CL_ABAP_CHAR_UTILITIES=>CR_LF && 'Другая строка'
    T = value #(
        ( CELL_BREAK = 'Ячейка 1 строка' && CL_ABAP_CHAR_UTILITIES=>CR_LF && 'Другая строка'  )
        ( CELL_BREAK = 'Ячейка 2 строка' && CL_ABAP_CHAR_UTILITIES=>NEWLINE && 'Другая строка'  )
        ( CELL_BREAK = 'Ячейка 3 строка не другая строка'  )
      )
    )
  .

end-of-selection.
  new ZCL_XTT_EXCEL_XLSX(
    new ZCL_XTT_FILE_SMW0( 'ZXTT_TEST_CRLF.XLSX' )
      )->MERGE( IS_BLOCK = LS_DATA
    )->DOWNLOAD( ).

  new ZCL_XTT_WORD_DOCX(
    new ZCL_XTT_FILE_SMW0( 'ZXTT_TEST_CRLF.DOCX' )
      )->MERGE( IS_BLOCK = LS_DATA
    )->DOWNLOAD( ).
