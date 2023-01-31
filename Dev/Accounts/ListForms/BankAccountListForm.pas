unit BankAccountListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar, Mask, DBCtrls, ImgList, Menus, AdvMenus,
  PrintDAT, ActnList, SelectionDialog, DNMPanel,
  wwDialog, Wwlocate, MemDS, DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker,
  ProgressDialog,  wwdblook, Shader, kbmMemTable, DAScript, MyScript,
  CustomInputBox, wwcheckbox, wwclearbuttongroup, wwradiogroup, GIFImg  ;

const
  SX_DatechangeMsg = WM_USER + 126;

type
  TBankAccountListGUI = class(TBaseListingGUI)
    grpFilterQuickFix: TwwRadioGroup;
    qryMainDate: TDateField;
    qryMainType: TWideStringField;
    qryMainAccountName: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainAmount: TFloatField;
    qryMainClassName: TWideStringField;
    qryMainSaleID: TIntegerField;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainPaymentID: TIntegerField;
    qryMainNotes: TWideStringField;
    qryMainPrepaymentID: TIntegerField;
    qryMainTransID: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    qryMainChqRefNo: TWideStringField;
    qryMainReconciled: TWideStringField;
    qryMainAmountinc: TFloatField;
    qryMainTax: TFloatField;
    qryMainPayee: TWideStringField;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure DateChange(var Message: TMessage); message SX_DatechangeMsg;
    procedure actRefreshQryExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grpFilterQuickFixClick(Sender: TObject);
    procedure chkIncludehistoryClick(Sender: TObject);
  private
    {Private declarations}
//    ToPrevDate, FromPrevDate: TDateTime;
    (*procedure AddReconcileFlags;*)

    Procedure MakeQrymain;

  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    function DoDtFromChange(Sender:Tobject): boolean; override;
//    function DoDtToChange(Sender: TObject): boolean; override;
  public
    {Public declarations}
  end;

implementation

{$R *.dfm}

uses
  strUtils, Forms, CommonLib, tcConst, AccountsListSQL,  LogLib;

procedure TBankAccountListGUI.RefreshQuery;
begin
(*  if chkIgnoreDates.Checked then begin
    qryMain.Params.ParamByName('txtfrom').asDate := 0;
    qryMain.Params.ParamByName('txtto').asDate := MaxDateTime;
    qryMain.Params.ParamByName('txtfrom1').asDate := 0;
    qryMain.Params.ParamByName('txtto1').asDate := MaxDateTime;
  end
  else begin
    qryMain.Params.ParamByName('txtfrom').asDate := dtfrom.DateTime;
    qryMain.Params.ParamByName('txtto').asDate := dtto.DateTime;
    qryMain.Params.ParamByName('txtfrom1').asDate := dtfrom.DateTime;
    qryMain.Params.ParamByName('txtto1').asDate := dtto.DateTime;
  end;*)
  InitDateFromnDateto;
  MakeQrymain;
  inherited;
  //RefreshTotals; - gets called from base's Refresh Query
end;

procedure TBankAccountListGUI.RefreshTotals;
var
  dTotAmount: double;
  dTotAmountinc: double;
  dTottax: double;
begin
  dTotAmount := 0;
  dTotAmountinc := 0;
  dTottax := 0;

  qryMain.DisableControls;
  with qryMain do begin
    First;
    while not Eof do begin
      dTotAmount := dTotAmount + qryMainAmount.AsCurrency;
      dTotAmountinc := dTotAmountinc + qryMainAmountinc.AsCurrency;
      dTottax := dTottax + qryMainTax.AsCurrency;
      Next;
    end;
    First;
  end;
  qryMain.EnableControls;
  grdMain.ColumnByName('Amount').FooterValue    := FloatToStrF(dTotAmount, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('AmountInc').FooterValue := FloatToStrF(dTotAmountinc, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Tax').FooterValue       := FloatToStrF(dTottax, ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TBankAccountListGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMain.Fields.FieldByName('Type').AsString;
  inherited;
end;

procedure TBankAccountListGUI.grpFilterQuickFixClick(Sender: TObject);
begin
  InitGroupfilterString(qryMainReconciled.fieldname  , ['T','F',''], false, grpFilterQuickFix);
  inherited grpFiltersClick(Sender);
end;

procedure TBankAccountListGUI.MakeQrymain;
var
  msg: string;
  BankAccountReport: TBankAccountReport;
begin
  BankAccountReport:=TBankAccountReport.create;
  try
    BankAccountReport.DateFrom := filterdatefrom;
    BankAccountReport.DateTo := filterDateto;
    BankAccountReport.IgnoreDates := chkIgnoreDates.Checked;
    BankAccountReport.IncludedataPriorToClosingDate := IncludedataPriorToClosingDate;
    BankAccountReport.PopulateReportSQL(qryMain.SQL,msg);
    clog(qrymain.sql.text);
  finally
    Freeandnil(BankAccountReport);
  end;
end;

procedure TBankAccountListGUI.FormCreate(Sender: TObject);
begin
  //fbIncludehistory := True;
  MakeQrymain;
  inherited;
  ShowChartViewOnPopup := True;
  btnRequery.Click;
end;

//function TBankAccountListGUI.DoDtToChange(Sender:TObject): boolean;
//begin
//  result:= false;
//  if not dtTo.DroppedDown then begin
//    if not (dtTo.DateTime = ToPrevDate) then begin
//      PostMessage(self.Handle, SX_DatechangeMsg, 0, 0);
//      result:= true;
//    end;
//    ToPrevDate := dtTo.DateTime;
//  end;
//end;


function TBankAccountListGUI.DoDtFromChange(Sender:TObject): boolean;
begin
  result:= false;
  if not dtFrom.DroppedDown then begin
    if not (dtFrom.DateTime = FromPrevDate) then begin
      PostMessage(self.Handle, SX_DatechangeMsg, 0, 0);
      Application.ProcessMessages;
      (*Self.AddReconcileFlags;*)
      result:= true;
    end;
    FromPrevDate := dtFrom.DateTime;
  end;
end;

procedure TBankAccountListGUI.DateChange(var Message: TMessage);
begin
  If not qryMain.Active then Exit;
  RefreshQuery;
end;

procedure TBankAccountListGUI.actRefreshQryExecute(Sender: TObject);
begin
  (*Self.AddReconcileFlags;*)
  inherited;
end;

(*procedure TBankAccountListGUI.AddReconcileFlags;
var
  TransactionTableObj: TTransactionTableObj;
begin
  TransactionTableObj := TTransactionTableObj.Create(True);
  try
    TransactionTableObj.AddReconcileFlags(dtFrom.DateTime,dtTo.DateTime);
  finally
    FreeandNil(TransactionTableObj);
  end;
  inherited;
end;*)

procedure TBankAccountListGUI.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('SaleID,PurchaseOrderID,PaymentID,TransID,PrepaymentID');
  btnRequery.Click; {to add the reconcileFlags and refresh}
end;

procedure TBankAccountListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TBankAccountListGUI.chkIncludehistoryClick(Sender: TObject);
begin
  inherited;
  //MakeQrymain;
  Refreshquery;
end;

procedure TBankAccountListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TBankAccountListGUI.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TBankAccountListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TBankAccountListGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainTax.asfloat := qryMainAmountinc.asfloat - qryMainAmount.AsFloat;
end;

initialization
  RegisterClassOnce(TBankAccountListGUI);
end.
