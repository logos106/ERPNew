unit SalesSummary;

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
  TSalesSummaryGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainsaleID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainSaleDate: TDateTimeField;
    qryMainSalesTotalAmount: TFloatField;
    qryMainSalesTotalAmountInc: TFloatField;
    qryMainSalesBalance: TFloatField;
    qryMainSalesPayment: TFloatField;
    qryMainLinesTotalAmount: TFloatField;
    qryMainLinestotalAmountInc: TFloatField;
    qryMainPaymentTotal: TFloatField;
    qryMainCompany: TWideStringField;
    DBMemo1: TDBMemo;
    (*qryMainSaletype: TWideStringField;*)
    qryMainErrorCodeDesc: TWideStringField;
    qryMainErrorCode: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);


  private
    Tablename :String;
    procedure Progressdialog(Sender: TObject; var SQL: String; var Omit: Boolean);
  public
    Procedure RefreshQuery; Override;
  end;

implementation

uses CommonLib, CommonDbLib, ProductQtyLib, BaseFormForm, tcConst;

{$R *.dfm}
procedure TSalesSummaryGUI.FormCreate(Sender: TObject);
begin
  inherited;
  IgnoreQuerySpeed := TRue;
  Tablename:= CreateUserTemporaryTable('tmp_salessummary');
  closeDB(Qrymain);
  Qrymain.SQL.Clear;
  Qrymain.SQL.add('select ');
  Qrymain.SQL.add('T.*,  ');
  Qrymain.SQL.add('C.Company  ');
  Qrymain.SQL.add('from '+tablename +' T  ');
  Qrymain.SQL.add('inner join tblclients c on C.clientId = T.ClientID  ');
  Qrymain.SQL.add('order by SaleID');
end;

procedure TSalesSummaryGUI.RefreshQuery;
var
  strSQL:TStringList;
begin
  closeDB(QryMain);
  strSQL:=TStringList.create;
  try
    strSQL.add('Truncate  '+tablename +' ;');
    strSQL.add('insert into '+tablename +' (saleID,ClientID,SaleDate,SalesTotalAmount,SalesTotalAmountInc,SalesBalance,SalesPayment,LinesTotalAmount,LinestotalAmountInc) ' +
              ' SELECT S.SaleID, S.ClientID,S.SaleDate,S.TotalAmount,S.TotalAmountInc,S.Balance,S.Payment,'+
              ' Sum(SL.TotalLineAmount),Sum(SL.TotalLineAmountInc) '+
              ' FROM tblsales AS S '+
              ' Inner Join tblsaleslines AS SL ON S.SaleID = SL.SaleID group by S.SaleID;');
    strSQL.add('update '+tablename +' Set  PaymentTotal = '+
            'ifnull((Select Sum(ifnull(DL.Payment,0)) from tbldeposits AS D ' +
            'Inner Join tbldepositline AS DL ON DL.PaymentID = D.PaymentID ' +
            ' Where CustomerPayment="T"  ' +
            ' AND D.Customer="T"  ' +
            ' AND TrnType<>"Prepayment"   ' +
            ' and DL.SaleId = '+tablename +'.SaleId  ' +
            ' and ifnull(D.Deleted,"T") =  "F"),0);');
    strSQL.add('update '+tablename +' Set  PaymentTotal = '+
            'ifnull((Select Sum(ifnull(SP.Amount,0)) from tblsalespayments AS SP ' +
            ' Where SP.SaleId = '+tablename +'.SaleId  ' +
            ' and ifnull(SP.Deleted,"T") =  "F"),0) where ifnull(PaymentTotal,0) = 0;');

  showProgressbar('Please Wait', 4);
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

procedure TSalesSummaryGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if qryMainErrorcode.AsInteger <> 0 then
    Afont.Color := clred;
end;


procedure TSalesSummaryGUI.Progressdialog(Sender: TObject; var SQL: String;
  var Omit: Boolean);
begin
  inherited;
  stepProgressbar;
end;

procedure TSalesSummaryGUI.grdMainDblClick(Sender: TObject);
begin
(*  SubsequentID := Chr(95) + qryMainSaletype.asString;*)
  inherited;

end;

procedure TSalesSummaryGUI.grpFiltersClick(Sender: TObject);
begin
  if grpFilters.ItemIndex = 0 then GroupFilterString := 'errorcode<>0' else GroupFilterString := '';
  inherited;

end;

procedure TSalesSummaryGUI.qryMainAfterOpen(DataSet: TDataSet);
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
      if Round(qryMainSalesTotalAmountInc.asfloat,CurrencyRoundPlaces) <> Round(qryMainLinestotalAmountInc.asFloat ,CurrencyRoundPlaces) then qryMainErrorcode.AsInteger := qryMainErrorcode.AsInteger +1;
      if Round(qryMainSalesTotalAmount.asfloat,CurrencyRoundPlaces)    <> Round(qryMainLinestotalAmount.asFloat ,CurrencyRoundPlaces) then qryMainErrorcode.AsInteger := qryMainErrorcode.AsInteger +2;
      if Round(qryMainSalesTotalAmountInc.asfloat,CurrencyRoundPlaces) <> Round(qryMainSalesPayment.asfloat+qryMainSalesbalance.asfloat ,CurrencyRoundPlaces) then qryMainErrorcode.AsInteger := qryMainErrorcode.AsInteger +4;
      if abs(Round(qryMainSalesTotalAmountInc.asfloat,CurrencyRoundPlaces)) <  abs(Round(qryMainPaymentTotal.asfloat ,CurrencyRoundPlaces)) then qryMainErrorcode.AsInteger := qryMainErrorcode.AsInteger +8;
      if Round(qryMainSalesPayment.asfloat,CurrencyRoundPlaces)        <> Round(qryMainPaymentTotal.asfloat ,CurrencyRoundPlaces) then qryMainErrorcode.AsInteger := qryMainErrorcode.AsInteger +16;
      qryMainErrorCodeDesc.asString:='';

      ErrorCode:= qryMainErrorcode.AsInteger ;
      if errorcode>=16 then begin
        qryMainErrorCodeDesc.asString := qryMainErrorCodeDesc.asString +chr(13)+'Sales.Payment<> Payment.Total';
        errorcode:= errorcode-16;
      end;
      if errorcode>=8 then begin
        qryMainErrorCodeDesc.asString := qryMainErrorCodeDesc.asString +chr(13)+'Sales.Total< Payment.Total';
        errorcode:= errorcode-8;
      end;
      if errorcode>=4 then begin
        qryMainErrorCodeDesc.asString := qryMainErrorCodeDesc.asString +chr(13)+'Sales.Total<>Sales Payment +Sales Balance';
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

procedure TSalesSummaryGUI.FormShow(Sender: TObject);
begin
  inherited;
  grpFiltersClick(grpFilters);
end;

initialization
  RegisterClassOnce(TSalesSummaryGUI);

end.
