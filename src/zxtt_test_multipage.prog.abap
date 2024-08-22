*&---------------------------------------------------------------------*
*& Много листов и страниц
*&---------------------------------------------------------------------*
report ZXTT_TEST_MULTIPAGE.
types
: begin of TY_PAGE_TAB
,   NUM type STRING
,   STR type STRING
, end of TY_PAGE_TAB
, TT_PAGE_TAB type standard table of TY_PAGE_TAB with default key
.
types
: begin of TY_PAGE_DATA
,   PAGE_NAME type STRING
,   T type TT_PAGE_TAB
, end of TY_PAGE_DATA
, TT_PAGE_DATA type standard table of TY_PAGE_DATA with default key
.
data LT_PAGES_DIRECT type  TT_PAGE_DATA.

start-of-selection.
  LT_PAGES_DIRECT = value #(
    ( PAGE_NAME = 'Страница первая'
      T = value #(
        ( NUM = 1 STR = 'Ячейка 1 строка 1' )
        ( NUM = 2 STR = 'Ячейка 2 строка 2' )
      )
    )
    ( PAGE_NAME = 'Страница вторая'
      T = value #(
        ( NUM = 3 STR = 'c2Ячейка 1 строка 1' )
        ( NUM = 4 STR = 'c2Ячейка 2 строка 2' )
      )
    )
  ).

end-of-selection.
  new ZCL_XTT_WORD_DOCX(
    new ZCL_XTT_FILE_SMW0( 'ZXTT_TEST_MULTIPAGE.DOCX' )
      )->MERGE( IS_BLOCK = LT_PAGES_DIRECT
    )->DOWNLOAD( ).
*--------------------------------------------------------------------*
  new ZCL_XTT_EXCEL_XLSX(
    new ZCL_XTT_FILE_SMW0( 'ZXTT_TEST_MULTIPAGE.XLSX' )
      )->MERGE( IS_BLOCK = LT_PAGES_DIRECT
    )->DOWNLOAD( ).
*--------------------------------------------------------------------*
  data
  : begin of LS_FIRST_PAGE
  ,   SOME_VALUE type STRING
  , end of LS_FIRST_PAGE
  .
  LS_FIRST_PAGE-SOME_VALUE = 'что-то выводим вначале'.

  data(LR_XTT) = new ZCL_XTT_EXCEL_XLSX(
    new ZCL_XTT_FILE_SMW0( 'ZXTT_TEST_MULTIPAGE_V2.XLSX' ) ).

  LR_XTT->MERGE(
    IV_BLOCK_NAME = 'F'
    IS_BLOCK = LS_FIRST_PAGE ).

  LR_XTT->MERGE(
*    IV_BLOCK_NAME = 'R'
    IS_BLOCK = LT_PAGES_DIRECT ).

  LR_XTT->DOWNLOAD( ).
