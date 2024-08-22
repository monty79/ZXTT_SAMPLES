*&---------------------------------------------------------------------*
*& Report ZXTT_TEST_FOOTER
*&---------------------------------------------------------------------*
report ZXTT_TEST_FOOTER.
parameters P_TEMPLT type W3OBJID default 'ZXTT_FOOTER.DOCX'.

start-of-selection.
  data
  : begin of LS_ROOT
  ,   BODY type STRING value `Тело teststr проверка`
  ,   FOOTNOTE type STRING value `Колонтитул teststr проверка`
  , end of LS_ROOT
  .

  data(LO_FILE) = cast ZIF_XTT_FILE( new ZCL_XTT_FILE_SMW0( IV_OBJID = P_TEMPLT ) ).
*  data(LO_XTT) = cast ZCL_XTT( new ZCL_XTT_WORD_DOCX( IO_FILE = LO_FILE ) ).
  data(LO_XTT) = cast ZCL_XTT( new ZCL_XTT_WORD_DOCX(
    IO_FILE = LO_FILE
*    IV_PATH_IN_ARC = 'word/footer1.xml' " Не актуально
  ) ).

  LO_XTT->MERGE( IS_BLOCK = LS_ROOT IV_BLOCK_NAME = 'R'
*  IV_BODY_TAG = 'w:ftr' " Не актуально
  ).

  LO_XTT->SHOW( ).
