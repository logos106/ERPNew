unit POSummary;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  DBCtrls, DAScript, MyScript;

type
  TPOSummaryGUI = class(TBaseListingGUI)
    DBMemo1: TDBMemo;
    qryMainID: TIntegerField;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainOrderDate: TDateTimeField;
    qryMainPOTotalAmount: TFloatField;
    qryMainPOTotalAmountInc: TFloatField;
    qryMainPOBalance: TFloatField;
    qryMainPOPayment: TFloatField;
    qryMainLinesTotalAmount: TFloatField;
    qryMainLinestotalAmountInc: TFloatField;
    qryMainPaymentTotal: TFloatField;
    qryMainErrorCode: TIntegerField;
    qryMainErrorCodeDesc: TWideStringField;
    qryMainCompany: TWideStringField;
    btnPayments: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure btnPaymentsClick(Sender: TObject);


  private
    Tablename :String;
    procedure Progressdialog(Sender: TObject; var SQL: String; var Omit: Boolean);
  public
    Procedure RefreshQuery; Override;
  end;

implementation

uses CommonLib, CommonDbLib, ProductQtyLib, BaseFormForm, TransPaymentList,
  FastFuncs, tcConst;

{$R *.dfm}
procedure TPOSummaryGUI.FormCreate(Sender: TObject);
begin
  inherited;
  IgnoreQuerySpeed := TRue;
  Tablename:= CreateUserTemporaryTable('tmp_POsummary');
  closeDB(Qrymain);
  Qrymain.SQL.Clear;
  Qrymain.SQL.add('select ');
  Qrymain.SQL.add('T.*,  ');
  (*Qrymain.SQL.add(POtype('s') +' as POtype , ');*)
  Qrymain.SQL.add('C.Company  ');
  Qrymain.SQL.add('from '+tablename +' T  ');
(*  Qrymain.SQL.add('inner join tblPOs S on s.POId = T.POId');*)
  Qrymain.SQL.add('inner join tblclients c on C.clientId = T.ClientID  ');
  Qrymain.SQL.add('order by PurchaseOrderID');
end;

procedure TPOSummaryGUI.RefreshQuery;
var
  strSQL:TStringList;
begin
  closeDB(QryMain);
  strSQL:=TStringList.create;
  try
    strSQL.add('Truncate  '+tablename +' ;');
    strSQL.add('insert into '+tablename +' (PurchaseOrderID,ClientID,OrderDate,POTotalAmount,POTotalAmountInc,POBalance,POPayment,LinesTotalAmount,LinestotalAmountInc) ' +
              ' SELECT S.PurchaseOrderID, S.ClientID,S.OrderDate,S.TotalAmount,S.TotalAmountInc,S.Balance,S.Payment,'+
              ' Sum(SL.TotalLineAmount),Sum(SL.TotalLineAmountInc) '+
              ' FROM tblpurchaseorders AS S '+
              ' Inner Join tblpurchaselines AS SL ON S.PurchaseOrderID = SL.PurchaseOrderID group by S.PurchaseOrderID;');
    strSQL.add('update '+tablename +' Set  PaymentTotal = '+
            '(Select Sum(DL.Payment) from tblwithdrawal AS D ' +
            'Inner Join tblwithdrawallines AS DL ON DL.PaymentID = D.PaymentID ' +
            ' WHERE SupplierPayment="T" AND D.Supplier="T" AND Deleted="F" AND TrnType<>"Prepayment" ' +
            ' and DL.POID = '+tablename +'.PurchaseOrderID  ' +
            ' and ifnull(D.Deleted,"T") =  "F")');
  showProgressbar('Please Wait', 3);
  try
    ExecuteSQL(StrSQL.text, nil, Progressdialog );
  finally
      HideProgressbar;
  end;
  finally
      FreeandNil(strSQL);
  end;
  inherited;
  openDB(Qrymain);

end;

procedure TPOSummaryGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if qryMainErrorcode.AsInteger <> 0 then
    Afont.Color := clred;
end;


procedure TPOSummaryGUI.Progressdialog(Sender: TObject; var SQL: String;
  var Omit: Boolean);
begin
  inherited;
  stepProgressbar;
end;

procedure TPOSummaryGUI.grdMainDblClick(Sender: TObject);
begin
(*  SubsequentID := Chr(95) + qryMainPOtype.asString;*)
  inherited;

end;

procedure TPOSummaryGUI.grpFiltersClick(Sender: TObject);
begin
  if grpFilters.ItemIndex = 0 then GroupFilterString := 'errorcode<>0' else GroupFilterString := '';
  inherited;

end;

procedure TPOSummaryGUI.qryMainAfterOpen(DataSet: TDataSet);
var
  ErrorCode:Integer;
begin
  inherited;
  if Qrymain.recordcount = 0 then exit;
  showProgressbar('Please Wait' , Qrymain.recordcount);
  try
    While Qrymain.Eof = False do begin
      EditDB(Qrymain);
      qryMainErrorcode.AsInteger := 0;
      if Round(qryMainPOTotalAmountInc.asfloat,CurrencyRoundPlaces) <> Round(qryMainLinestotalAmountInc.asFloat ,CurrencyRoundPlaces) then qryMainErrorcode.AsInteger := qryMainErrorcode.AsInteger +1;
      if Round(qryMainPOTotalAmount.asfloat,CurrencyRoundPlaces)    <> Round(qryMainLinestotalAmount.asFloat ,CurrencyRoundPlaces) then qryMainErrorcode.AsInteger := qryMainErrorcode.AsInteger +2;
      if Round(qryMainPOTotalAmountInc.asfloat,CurrencyRoundPlaces) <> Round(qryMainPOPayment.asfloat+qryMainPObalance.asfloat ,CurrencyRoundPlaces) then qryMainErrorcode.AsInteger := qryMainErrorcode.AsInteger +4;
      if abs(Round(qryMainPOTotalAmountInc.asfloat,CurrencyRoundPlaces)) <  abs(Round(qryMainPaymentTotal.asfloat ,CurrencyRoundPlaces)) then qryMainErrorcode.AsInteger := qryMainErrorcode.AsInteger +8;
      if Round(qryMainPOPayment.asfloat,CurrencyRoundPlaces)        <> Round(qryMainPaymentTotal.asfloat ,CurrencyRoundPlaces) then qryMainErrorcode.AsInteger := qryMainErrorcode.AsInteger +16;
      qryMainErrorCodeDesc.asString:='';

      ErrorCode:= qryMainErrorcode.AsInteger ;
      if errorcode>=16 then begin
        qryMainErrorCodeDesc.asString := qryMainErrorCodeDesc.asString +chr(13)+'PO.Payment<> Payment.Total';
        errorcode:= errorcode-16;
      end;
      if errorcode>=8 then begin
        qryMainErrorCodeDesc.asString := qryMainErrorCodeDesc.asString +chr(13)+'PO.Total< Payment.Total';
        errorcode:= errorcode-8;
      end;
      if errorcode>=4 then begin
        qryMainErrorCodeDesc.asString := qryMainErrorCodeDesc.asString +chr(13)+'PO.Total<>PO Payment +PO Balance';
        errorcode:= errorcode-4;
      end;
      if errorcode>=2 then begin
        qryMainErrorCodeDesc.asString := qryMainErrorCodeDesc.asString +chr(13)+'Header.Total< Lines.Total';
        errorcode:= errorcode-2;
      end;
      if errorcode>=1 then begin
        qryMainErrorCodeDesc.asString := qryMainErrorCodeDesc.asString +chr(13)+'Header.Total(Inc)< Lines.Total(Inc)';
      end;
      PostDB(Qrymain);
      Qrymain.next;
      stepProgressbar;
    end;
  finally
    HideProgressbar
  end;
end;

procedure TPOSummaryGUI.FormShow(Sender: TObject);
begin
  inherited;
  grpFiltersClick(grpFilters);
end;

procedure TPOSummaryGUI.btnPaymentsClick(Sender: TObject);
var
  TempSQL(* , DblClickType *): string;
  TransPaymentList: TBaseListingGUI;
begin
  inherited;

    TempSQL      := 'SELECT   ' + Quotedstr( 'Supplier Payment') +' as DblClickType , Concat_ws("",PaymentNo) as "Receipt No",PaymentDate as "Payment Date",Payment as "Payment Amount", ' +
      'ReferenceNo as "Reference No",tblwithdrawallines.PaymentID ' +
      'FROM tblwithdrawal INNER JOIN tblwithdrawallines Using(PaymentID) ' +
      'WHERE SupplierPayment="T" AND tblwithdrawal.Supplier="T" AND Deleted="F" AND TrnType<>"Prepayment" ' +
      'AND POID=' + IntToStr(qryMainPurchaseOrderID.asInteger) + ' ' + 'ORDER BY PaymentDate DESC;';
    //DblClickType := 'Supplier Payment'   ;

  TransPaymentList :=  TTransPaymentListGUI(GetComponentByClassName('TTransPaymentListGUI', False, Self));
  TransPaymentList.qryMain.SQL.Text := TempSQL;
  //TTransPaymentListGUI(TransPaymentList).DblClickType:= DblClickType;
  TransPaymentList.FormStyle := fsMdiChild;
  TransPaymentList.BringToFront;
end;

initialization
  RegisterClassOnce(TPOSummaryGUI);

end.
