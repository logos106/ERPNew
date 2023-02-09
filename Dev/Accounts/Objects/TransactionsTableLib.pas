unit TransactionsTableLib;

interface

uses TransactionsTable;

type
  TTransactionTableExtra = class(TTransactionTableObj)
  private
  Public
    constructor Create(OwnerListing:boolean);Override;
    Function TransSQL(const Value:Integer;DonotMakeTransTable:Boolean =False; const aSaleID:Integer=0): String;
    function TransactionSummarySQL(const SQLNo: Integer): String;
    function TransactionSQLs: String;
    function InventoryAssetPostingSQLs: String;
  end;


implementation

uses classes , SysUtils, CommonLib;

{ TTransactionTableExtra }

constructor TTransactionTableExtra.create(OwnerListing:boolean);
begin
  inherited create(OwnerListing);
  LOAD_INTO_String := 'INTO TABLE ' + TableName +
              '  CHARACTER SET  UTF8  (' + TransSQLFields(0) +') ';
  BeforeOrAfterClosing := '>';
  TABLENAME := 'TMP_1';
end;

function TTransactionTableExtra.InventoryAssetPostingSQLs: String;
var
  st:TStringlist;
  MAINst:TStringlist;
begin
  st:= TStringlist.create;
  MAINst:= TStringlist.create;
  try
    try
      {invoice }            TrnsTable25(St, true);  mainst.add(replacestr(replacestr(st.text , chr(13), ' '), chr(10), ' ')); mainst.add('Union all');st.clear;
      {cash sale}           TrnsTable26(St, true);  mainst.add(replacestr(replacestr(st.text , chr(13), ' '), chr(10), ' ')); mainst.add('Union all');st.clear;
      {Refund}              TrnsTable27(St, true);  mainst.add(replacestr(replacestr(st.text , chr(13), ' '), chr(10), ' ')); mainst.add('Union all');st.clear;
      {Stock transfer from} TrnsTable39(St, true);  mainst.add(replacestr(replacestr(st.text , chr(13), ' '), chr(10), ' ')); mainst.add('Union all');st.clear;
      {stock transfer to}   TrnsTable40(St, true);  mainst.add(replacestr(replacestr(st.text , chr(13), ' '), chr(10), ' ')); mainst.add('Union all');st.clear;
      {Stock Adjustment}    TrnsTable55(St, true);  mainst.add(replacestr(replacestr(st.text , chr(13), ' '), chr(10), ' ')); mainst.add('Union all');st.clear;
      {Manufacturing}       TrnsTable71(St, true);  mainst.add(replacestr(replacestr(st.text , chr(13), ' '), chr(10), ' ')); st.clear;
    Except
      // kill exception
    end;
    Result := MAINst.text;
  finally
    FreeandNil(st);
    FreeandNil(MAINst);
  end;

end;

function TTransactionTableExtra.TransactionSQLs: String;
var
  st:TStringlist;
  MAINst:TStringlist;
begin
  st:= TStringlist.create;
  MAINst:= TStringlist.create;
  try
    try
          TrnsTable02(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable03(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable04(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable05(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable06(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable07(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable08(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable10(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable11(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable12(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable14(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable16(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable17(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable18(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable19(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable20(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable21(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable22(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable23(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable24(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable25(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable26(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable27(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable28(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable29(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable30(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable31(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable32(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable33(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable34(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable35(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable36(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable37(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable38(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable39(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable40(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable41(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable42(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable43(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable44(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable45(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable46(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable47(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable48(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable49(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable50(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable51(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable52(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable53(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable54(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable55(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable56(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable57(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable58(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable59(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable60(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable61(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable62(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable63(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable64(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable65(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable66(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable67(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable69(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable70(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable71(St, true);  mainst.add(StripNewLine(st.text));st.clear;
          TrnsTable80(St, true);  mainst.add(StripNewLine(st.text));st.clear;
    Except
      // kill exception
    end;
    Result := MAINst.text;
  finally
    FreeandNil(st);
    FreeandNil(MAINst);
  end;

end;

function TTransactionTableExtra.TransactionSummarySQL(const SQLNo: Integer): String;
var
  st:TStringlist;
begin
  st:= TStringlist.create;
  try
    try
      Case SQLNo of
          2:TrnsTable02(st);
          3:TrnsTable03(st);
          4:TrnsTable04(st);
          5:TrnsTable05(st);
          6:TrnsTable06(st);
          7:TrnsTable07(st);
          8:TrnsTable08(st);
          10:TrnsTable10(st);
          11:TrnsTable11(st);
          12:TrnsTable12(st);
          14:TrnsTable14(st);
          16:TrnsTable16(st);
          17:TrnsTable17(st);
          18:TrnsTable18(st);
          19:TrnsTable19(st);
          20:TrnsTable20(st);
          21:TrnsTable21(st);
          22:TrnsTable22(st);
          23:TrnsTable23(st);
          24:TrnsTable24(st);
          25:TrnsTable25(st);
          26:TrnsTable26(st);
          27:TrnsTable27(st);
          28:TrnsTable28(st);
          29:TrnsTable29(st);
          30:TrnsTable30(st);
          31:TrnsTable31(st);
          32:TrnsTable32(st);
          33:TrnsTable33(st);
          34:TrnsTable34(st);
          35:TrnsTable35(st);
          36:TrnsTable36(st);
          37:TrnsTable37(st);
          38:TrnsTable38(st);
          39:TrnsTable39(st);
          40:TrnsTable40(st);
          41:TrnsTable41(st);
          42:TrnsTable42(st);
          43:TrnsTable43(st);
          44:TrnsTable44(st);
          45:TrnsTable45(st);
          46:TrnsTable46(st);
          47:TrnsTable47(st);
          48:TrnsTable48(st);
          49:TrnsTable49(st);
          50:TrnsTable50(st);
          51:TrnsTable51(st);
          52:TrnsTable52(st);
          53:TrnsTable53(st);
          54:TrnsTable54(st);
          55:TrnsTable55(st);
          56:TrnsTable56(st);
          57:TrnsTable57(st);
          58:TrnsTable58(st);
          59:TrnsTable59(st);
          60:TrnsTable60(st);
          61:TrnsTable61(st);
          62:TrnsTable62(st);
          63:TrnsTable63(st);
          64:TrnsTable64(st);
          65:TrnsTable65(st);
          66:TrnsTable66(st);
          67:TrnsTable67(st);
          69:TrnsTable69(st);
          70:TrnsTable70(st);
          71:TrnsTable71(st);
          80:TrnsTable80(st);
      End;
    Except
      // kill exception
    end;
    Result := st.text;
  finally
    FreeandNil(st);
  end;
end;

function TTransactionTableExtra.TransSQL(const Value: Integer;DonotMakeTransTable:Boolean =False; const aSaleID:Integer=0): String;
var
  st:TStringlist;
begin
  st:= tStringlist.create;
  try
           if Value =	2	then TrnsTable02(st, DonotMakeTransTable)
      else if Value =	3	then TrnsTable03(st, DonotMakeTransTable)
      else if Value =	4	then TrnsTable04(st, DonotMakeTransTable)
      else if Value =	5	then TrnsTable05(st, DonotMakeTransTable)
      else if Value =	6	then TrnsTable06(st, DonotMakeTransTable)
      else if Value =	7	then TrnsTable07(st, DonotMakeTransTable)
      else if Value =	8	then TrnsTable08(st, DonotMakeTransTable)
      else if Value =	10	then TrnsTable10(st, DonotMakeTransTable)
      else if Value =	11	then TrnsTable11(st, DonotMakeTransTable)
      else if Value =	12	then TrnsTable12(st, DonotMakeTransTable)
      else if Value =	14	then TrnsTable14(st, DonotMakeTransTable)
      else if Value =	16	then TrnsTable16(st, DonotMakeTransTable)
      else if Value =	17	then TrnsTable17(st, DonotMakeTransTable)
      else if Value =	18	then TrnsTable18(st, DonotMakeTransTable)
      else if Value =	19	then TrnsTable19(st, DonotMakeTransTable)
      else if Value =	20	then TrnsTable20(st, DonotMakeTransTable)
      else if Value =	21	then TrnsTable21(st, DonotMakeTransTable)
      else if Value =	22	then TrnsTable22(st, DonotMakeTransTable)
      else if Value =	23	then TrnsTable23(st, DonotMakeTransTable)
      else if Value =	24	then TrnsTable24(st, DonotMakeTransTable)
      else if Value =	25	then TrnsTable25(st, DonotMakeTransTable)
      else if Value =	26	then TrnsTable26(st, DonotMakeTransTable)
      else if Value =	27	then TrnsTable27(st, DonotMakeTransTable)
      else if Value =	28	then TrnsTable28(st, DonotMakeTransTable)
      else if Value =	29	then TrnsTable29(st, DonotMakeTransTable)
      else if Value =	30	then TrnsTable30(st, DonotMakeTransTable)
      else if Value =	31	then TrnsTable31(st, DonotMakeTransTable)
      else if Value =	32	then TrnsTable32(st, DonotMakeTransTable)
      else if Value =	33	then TrnsTable33(st, DonotMakeTransTable)
      else if Value =	34	then TrnsTable34(st, DonotMakeTransTable)
      else if Value =	35	then TrnsTable35(st, DonotMakeTransTable)
      else if Value =	36	then TrnsTable36(st, DonotMakeTransTable)
      else if Value =	37	then TrnsTable37(st, DonotMakeTransTable)
      else if Value =	38	then TrnsTable38(st, DonotMakeTransTable)
      else if Value =	39	then TrnsTable39(st, DonotMakeTransTable)
      else if Value =	40	then TrnsTable40(st, DonotMakeTransTable)
      else if Value =	41	then TrnsTable41(st, DonotMakeTransTable)
      else if Value =	42	then TrnsTable42(st, DonotMakeTransTable)
      else if Value =	43	then TrnsTable43(st, DonotMakeTransTable)
      else if Value =	44	then TrnsTable44(st, DonotMakeTransTable)
      else if Value =	45	then TrnsTable45(st, DonotMakeTransTable)
      else if Value =	46	then TrnsTable46(st, DonotMakeTransTable)
      else if Value =	47	then TrnsTable47(st, DonotMakeTransTable)
      else if Value =	48	then TrnsTable48(st, DonotMakeTransTable)
      else if Value =	49	then TrnsTable49(st, DonotMakeTransTable)
      else if Value =	50	then TrnsTable50(st, DonotMakeTransTable)
      else if Value =	51	then TrnsTable51(st, DonotMakeTransTable)
      else if Value =	52	then TrnsTable52(st, DonotMakeTransTable)
      else if Value =	53	then TrnsTable53(st, DonotMakeTransTable)
      else if Value =	54	then TrnsTable54(st, DonotMakeTransTable)
      else if Value =	55	then TrnsTable55(st, DonotMakeTransTable)
      else if Value =	56	then TrnsTable56(st, DonotMakeTransTable)
      else if Value =	57	then TrnsTable57(st, DonotMakeTransTable)
      else if Value =	58	then TrnsTable58(st, DonotMakeTransTable)
      else if Value =	59	then TrnsTable59(st, DonotMakeTransTable)
      else if Value =	60	then TrnsTable60(st, DonotMakeTransTable)
      else if Value =	61	then TrnsTable61(st, DonotMakeTransTable)
      else if Value =	62	then TrnsTable62(st, DonotMakeTransTable)
      else if Value =	63	then TrnsTable63(st, DonotMakeTransTable)
      else if Value =	64	then TrnsTable64(st, DonotMakeTransTable)
      else if Value =	65	then TrnsTable65(st, DonotMakeTransTable)
      else if Value =	66	then TrnsTable66(st, DonotMakeTransTable)
      else if Value =	67	then TrnsTable67(st, DonotMakeTransTable)
      else if Value =	69	then TrnsTable69(st, DonotMakeTransTable)
      else if Value =	70	then TrnsTable70(st, DonotMakeTransTable)
      else if Value =	71	then TrnsTable71(st, DonotMakeTransTable)
      else if Value =	72	then TrnsTable72(st, DonotMakeTransTable)
      else if Value =	73	then TrnsTable73(st, DonotMakeTransTable)
      else if Value =	74	then TrnsTable74(st, DonotMakeTransTable)
      else if Value =	75	then TrnsTable75(st, DonotMakeTransTable)
      else if Value =	76	then TrnsTable76(st, DonotMakeTransTable)
      else if Value =	77	then TrnsTable77(st, DonotMakeTransTable)
      else if Value =	78	then TrnsTable78(st, DonotMakeTransTable)
      else if Value =	79	then TrnsTable79(st, DonotMakeTransTable)
      else if Value =	80	then TrnsTable80(st, DonotMakeTransTable)
      else if Value =	81	then TrnsTable81(st, DonotMakeTransTable)
      else if Value =	83	then TrnsTable83(st, DonotMakeTransTable)
      else if Value =	84	then TrnsTable84(st, DonotMakeTransTable)
      else if Value =	85	then TrnsTable85(st, DonotMakeTransTable)
      else if Value =	87	then TrnsTable87(st, DonotMakeTransTable, aSaleID)
      else if Value =	92	then TrnsTable92(st, DonotMakeTransTable)
      else if Value =	93	then TrnsTable93(st, DonotMakeTransTable)
      else exit;
      REsult := st.text;
  finally
    freeandnil(st);
  end;
end;
end.
