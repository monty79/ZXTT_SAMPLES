*&---------------------------------------------------------------------*
*& Три раза таблицы с раскраской, дальше - нет
*&---------------------------------------------------------------------*
report ZXTT_TEST_TABLE_4TIMES.
types:
begin of LTY_TAB_LINE
,  INDEX type I
,  LINE type STRING
,  VALUE1 type STRING
,  VALUE2 type STRING
,end of LTY_TAB_LINE
.
types: begin of LTY_ROOT
, HEAD type STRING
, COUNT type STRING
, T1 type standard table of LTY_TAB_LINE with default key
, T2 type standard table of LTY_TAB_LINE with default key
, FOOT type STRING
, FOOTv type STRING
,end of LTY_ROOT.

start-of-selection.
  data LT_ROOT type standard table of LTY_ROOT.
  data LS_ROOT type LTY_ROOT.
  do 4 times.
    clear LS_ROOT.
    LS_ROOT-HEAD = SY-INDEX.
    LS_ROOT-T1 = value #(
      ( INDEX = 1 LINE = `formatting` && CL_ABAP_CHAR_UTILITIES=>CR_LF && ` OK` )
      ( INDEX = 2 LINE = `formatting` && CL_ABAP_CHAR_UTILITIES=>CR_LF && ` OK` )
      ).
    LS_ROOT-T2 = value #(
      ( INDEX = 3 LINE = `formatting OK` )
      ( INDEX = 4 LINE = `formatting OK` )
      ( INDEX = 5 LINE = `formatting OK` )
    ).
    LS_ROOT-FOOT = 'foot 0'.
    append LS_ROOT to LT_ROOT.
  enddo.

  do 5 times.
    clear LS_ROOT.
    LS_ROOT-T1 = value #(
      ( INDEX = 6 LINE = `formatting NOT OK` )
    ).
    LS_ROOT-T2 = value #(
      ( INDEX = 7 LINE = `formatting NOT OK` )
      ( INDEX = 8 LINE = `formatting NOT OK` )
    ).
    LS_ROOT-FOOT = 'foot'.
    append LS_ROOT to LT_ROOT.
  enddo.

end-of-SELECTION.
  new ZCL_XTT_WORD_DOCX(
      new ZCL_XTT_FILE_SMW0( 'ZTEST_TABLE_4TIMES.DOCX' )
*      new ZCL_XTT_FILE_SMW0( 'ZTEST_FIX.DOCX' )
  )->MERGE( LT_ROOT )->DOWNLOAD(
    IV_OPEN = ZIF_XTT=>MC_BY-OLE  "Только в этом режиме портится раскараска
   ).
