{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
01/07/05  1.00.01 BJ   Added 'Refreshtotal' proc to display the total for the grid
                       The total is calcualted for AmountEx, AmountInc and Tax
                       The toal is negated for credit(IsCredit = 'T' in tblPurchaseOrders).
                       Note: the records in the Grid is not showing the negated amount
                       Only the total is negated, so a direct total of the amount
                       in the grid may not match with the totals displayed at the bottom
}
unit BillListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar, ImgList, Menus, AdvMenus, PrintDAT,
  ActnList, wwDialog, Wwlocate, SelectionDialog, DNMPanel, MemDS, DBAccess,
  MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog,  wwdblook,
  Shader, kbmMemTable, wwcheckbox, DAScript, MyScript, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg, BillReportSQL;

type
  TBillListGUI = class(TBaseListingGUI)
    qryMainPurchaseOrderID: TIntegerField;
    qryMainType: TWideStringField;
    qryMainClientID: TIntegerField;
    qryMainCompany: TWideStringField;
    qryMainComments: TWideStringField;
    qryMainContact1: TWideStringField;
    qryMainETADate: TDateField;
    qryMainPhone: TWideStringField;
    qryMainInvoiced: TWideStringField;
    qryMainInvoiceNumber: TWideStringField;
    qryMainIsRA: TWideStringField;
    qryMainDeleted: TWideStringField;
    qryMainSalesComments: TWideStringField;
    qryMainTotalAmountEx: TFloatField;
    qryMainTotalTax: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    qryMainBillNumber: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainIsCredit: TWideStringField;
    lblApproval: TLabel;
    chkShowNonApproved: TwwCheckBox;
    qryMainApproved: TWideStringField;
    qryMainOrderDate: TDateField;
    qryMainCreditOrReturn: TWideStringField;
    qryMainbalance: TFloatField;
    qryMainPrintName: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure cmdNewClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure FormCreate(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure RefreshTotals; override;
    procedure FormShow(Sender: TObject);
    procedure chkShowNonApprovedClick(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure dtFromChange(Sender: TObject);
    procedure dtToChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    BillReport: TBillReport;
    procedure MakeQrymain;
  protected
    procedure RefreshQuery; override;
    Procedure SetGridColumns;override;
    Procedure onBeforeExecute(Sender: TObject; var SQL: String;var Omit: Boolean);
  public
    { Public declarations }
  end;

implementation

uses frmBill, Forms, CommonLib,tcDataUtils,AppEnvironment,CommonDBLib,BusObjApprovals,
     DateUtils, MySQLConst, tcConst, CommonFormLib;

{$R *.dfm}

procedure TBillListGUI.RefreshTotals;
var
  bm: TBookmark;
  TotalAmountEx: double;
  TotalTax: double;
  TotalAmountInc: double;
begin
{The Credits are negated for the total. But the records in the
Grid is not showing the negated amount so a direct total of the amount
in the grid may not match with the totals displayed at the bottom}
  inherited;
  bm := qryMain.GetBookmark;
  qryMain.DisableControls;
  try
    with qryMain do begin
      First;
      TotalAmountEx  := 0;
      TotalTax       := 0;
      TotalAmountInc := 0;
      while not Eof do begin
//        if FieldByName('IsCredit').AsString = 'T' then begin
//          TotalAmountEx := TotalAmountEx - qryMain.FieldByName('Total Amount (Ex)').AsFloat;
//          TotalTax := TotalTax - qryMain.FieldByName('Total Tax').AsFloat;
//          TotalAmountInc := TotalAmountInc - qryMain.FieldByName('Total Amount (Inc)').AsFloat;
//        end else begin
//          TotalAmountEx := TotalAmountEx + qryMain.FieldByName('Total Amount (Ex)').AsFloat;
//          TotalTax := TotalTax + qryMain.FieldByName('Total Tax').AsFloat;
//          TotalAmountInc := TotalAmountInc + +qryMain.FieldByName('Total Amount (Inc)').AsFloat;
//        end;
        TotalAmountEx := TotalAmountEx + qryMain.FieldByName('Total Amount (Ex)').AsFloat;
        TotalTax := TotalTax + qryMain.FieldByName('Total Tax').AsFloat;
        TotalAmountInc := TotalAmountInc + +qryMain.FieldByName('Total Amount (Inc)').AsFloat;
        Next;
      end;
    end;
  Finally
    qryMain.GotoBookmark(bm);
    qryMain.FreeBookmark(bm);
    qryMain.EnableControls;
  end;
  grdMain.ColumnByName('Total Amount (Ex)').FooterValue := FloatToStrF(TotalAmountEx, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Total Tax').FooterValue := FloatToStrF(TotalTax, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Total Amount (Inc)').FooterValue := FloatToStrF(TotalAmountInc, ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TBillListGUI.grpFiltersClick(Sender: TObject);
begin
  (*GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin
        GroupFilterString := 'Deleted <> ' + QuotedStr('T');
      end;
    1:
      begin
        GroupFilterString := 'Deleted = ' + QuotedStr('T');
      end;
  end;*)
  if grpFilters.ItemIndex = 0 then GroupFilterString := 'Balance = 0'
  else if grpFilters.ItemIndex = 1 then GroupFilterString := 'Balance <> 0'
  else GroupFilterString := '';
  inherited;
end;
{ }
procedure TBillListGUI.RefreshQuery;
(*var
  msg: string;*)
begin
//  Qrymain.Parambyname('DateFrom').AsDateTime := FilterDateFrom;
//  Qrymain.Parambyname('dateTo').AsDateTime := FilterDateTo;
//  Qrymain.Parambyname('UseApprovalLevels').AsBoolean :=AppEnv.CompanyPrefs.UseApprovalLevels;
//  Qrymain.Parambyname('ShowNonApproved').AsBoolean :=chkShowNonApproved.Checked;

(*  BillReport.DateFrom := dtFrom.Date;
  BillReport.DateTo := dtTo.Date;
  BillReport.IgnoreDates := chkIgnoreDates.Checked;
  BillReport.UseApprovalLevels := false; //AppEnv.CompanyPrefs.UseApprovalLevels;
  BillReport.ShowNonApproved := chkShowNonApproved.Checked;

  BillReport.PopulateReportSQL(qryMain.SQL, msg);
  self.RefreshOrignalSQL();*)

  InitDateFromnDateto;
       if grpFilters.itemindex = 0 then qryMain.Params.ParamByName('paidFilter').asString := 'T'
  else if grpFilters.itemindex = 1 then qryMain.Params.ParamByName('paidFilter').asString := 'F'
  else qryMain.Params.ParamByName('paidFilter').asString := 'All';
  inherited;
end;

procedure TBillListGUI.cmdNewClick(Sender: TObject);
begin
  OpenERPForm('TBillGUI' , 0);
(*Var
  tmpComponent: TComponent;
begin
  DisableForm;
  try
    tmpComponent := GetComponentByClassName('TBillGUI');
    If not Assigned(tmpComponent) then Exit;
    with TBillGUI(tmpComponent) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  finally
    EnableForm;
  end;*)
end;

procedure TBillListGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMain.Fields.FieldByName('Type').AsString;
  inherited;
end;

procedure TBillListGUI.FormCreate(Sender: TObject);
begin
  BillReport := TBillReport.Create;
  makeQrymain;
  inherited;
  if (not Assigned(Owner)) or (not (Owner is TForm)) then begin
    {only do this if the list not owned by another form, ie embeded}
    fbEnableWebSearch := true;
  end;
end;
Procedure TBillListGUI.MakeQrymain;
var
  msg:String;
begin
  BillReport.UseApprovalLevels := false; //AppEnv.CompanyPrefs.UseApprovalLevels;
  BillReport.ShowNonApproved := chkShowNonApproved.Checked;
  BillReport.includePOs := false; // dene asked to remove POs from bill list , for BES // true;
  BillReport.PopulateReportSQL(qryMain.SQL, msg);
  self.RefreshOrignalSQL();
end;
procedure TBillListGUI.FormDestroy(Sender: TObject);
begin
  BillReport.Free;
  inherited;
end;

procedure TBillListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := QuotedStr('OrderDate') + ' DESC CIS ; ' + QuotedStr('PurchaseOrderID') + ' DESC CIS';
  BaseIndexFieldNames := QuotedStr('PurchaseOrderID') + ' DESC CIS';
end;

procedure TBillListGUI.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields(
    'PurchaseOrderId,ClientId,IsRA,IsCredit');
end;

procedure TBillListGUI.chkShowNonApprovedClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TBillListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TBillListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TBillListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TBillListGUI.dtFromChange(Sender: TObject);
begin
  inherited;
  Application.ProcessMessages;
  SetcontrolFocus(dtFrom);
end;

procedure TBillListGUI.dtToChange(Sender: TObject);
begin
  inherited;
  Application.ProcessMessages;
  SetcontrolFocus(dtto);
end;

procedure TBillListGUI.SetGridColumns;
begin
  inherited;
end;

procedure TBillListGUI.onBeforeExecute(Sender: TObject; var SQL: String;
  var Omit: Boolean);
begin
  stepProgressbar;
end;

initialization
  RegisterClassOnce(TBillListGUI);

end.
