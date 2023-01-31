unit ExpenseClaimListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar, ImgList, Menus, AdvMenus, PrintDAT,
  ActnList, wwDialog, Wwlocate, SelectionDialog, DNMPanel, MemDS, DBAccess,
  MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog,  wwdblook,
  Shader, kbmMemTable, wwcheckbox, DAScript, MyScript, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TExpenseClaimListGUI = class(TBaseListingGUI)
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
    qryMainClaimNumber: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainIsCredit: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainApproved: TWideStringField;
    qryMainPaid: TWideStringField;
    lblApproval: TLabel;
    chkShowNonApproved: TwwCheckBox;
    qryMainOrderDate: TDateField;
    qryMainProcessed: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainSeqno: TLargeintField;
    qryMainExpenseClaimID: TIntegerField;
    qryMainClaimdate: TDateField;
    qryMainStatus: TWideStringField;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure RefreshTotals; override;
    procedure chkShowNonApprovedClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
  private
    DoRefreshQuery: boolean;
  protected
    procedure RefreshQuery; override;
    procedure ApplyQueryFilter; override;
    procedure SetGridColumns; override;
  public
    { Public declarations }
  end;

implementation

uses
  Forms, CommonLib,AppEnvironment,CommonDbLib,tcDataUtils,BusObjApprovals,
  DateUtils, tcConst, BaseInputForm, ExpenseClaimSQL;

{$R *.dfm}


procedure TExpenseClaimListGUI.FormShow(Sender: TObject);
begin
  inherited;
  if grpFilters.ItemIndex < 0 then
    grpFilters.ItemIndex := 0;
  DoRefreshQuery := true;
  RefreshQuery;
end;


procedure TExpenseClaimListGUI.RefreshTotals;
begin
  CalcnShowFooter;
end;

procedure TExpenseClaimListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainglobalref.fieldname);
  RemoveFieldfromGrid(qrymainclientID.fieldname);
  RemoveFieldfromGrid(qrymainSeqno.fieldname);
end;

procedure TExpenseClaimListGUI.RefreshQuery;
var
  Report: TExpenseClaimReport;
  msg: string;
begin
  if not DoRefreshQuery then exit;
  qryMain.Close;
  Report := TExpenseClaimReport.Create;
  try
    Report.DateFrom := FilterDateFrom;
    Report.DateTo := FilterDateTo;
    case grpFilters.ItemIndex of
      0:   Report.Status := 'Pending';
      1:   Report.Status := 'Approved';
      2:   Report.Status := 'Declined';
      3:   Report.Status := 'Processed';
      4:   Report.Status := 'All';
    end;

    Report.PopulateReportSQL(qryMain.SQL,msg);
    self.RefreshOrignalSQL();
  finally
    Report.Free;
  end;

//  qryMain.Params.ParamByName('txtfrom').AsDateTime := filterDateFrom;
//  qryMain.Params.ParamByName('txtto').AsDateTime := filterDateTo;
//  case grpFilters.ItemIndex of
//    0:   qryMain.Params.ParamByName('Status').AsString := 'Pending';
//    1:   qryMain.Params.ParamByName('Status').AsString := 'Approved';
//    2:   qryMain.Params.ParamByName('Status').AsString := 'Declined';
//    3:   qryMain.Params.ParamByName('Status').AsString := 'Processed';
//    4:   qryMain.Params.ParamByName('Status').AsString := 'All';
//  end;
  inherited;
end;

procedure TExpenseClaimListGUI.grdMainDblClick(Sender: TObject);
begin
  if (sametext(ActiveFieldname , qrymainExpenseClaimID.fieldname) and (qrymainExpenseClaimID.asInteger <>0)) or
     (sametext(ActiveFieldname , qryMainClaimdate.fieldname) and (qryMainClaimdate.asDatetime <> 0)) or
     (sametext(ActiveFieldname , qryMainDescription.fieldname) and (qryMainDescription.asString <> '')) then
     SubsequentID := Chr(95) + 'Request'
  else
    SubsequentID := Chr(95) + qryMain.Fields.FieldByName('Type').AsString;
 inherited;
end;

procedure TExpenseClaimListGUI.grpFiltersClick(Sender: TObject);
begin
  //inherited;
  RefreshQuery;
end;

procedure TExpenseClaimListGUI.FormCreate(Sender: TObject);
begin
  fbEnableWebSearch := true;
  inherited;
  AddCalcColumn(QrymaintotalamountEx.fieldname , true);
  AddCalcColumn(QrymaintotalamountInc.fieldname , true);
  AddCalcColumn(QrymaintotalTax.fieldname , true);
  DoRefreshQuery := false;
end;

procedure TExpenseClaimListGUI.ApplyQueryFilter;
begin
  inherited;
  RefreshQuery;
end;

procedure TExpenseClaimListGUI.chkShowNonApprovedClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TExpenseClaimListGUI.cmdNewClick(Sender: TObject);
var
  form: TBaseInputGUI;
begin
  inherited;
  Form := TBaseInputGUI(GetComponentByClassName('TfmExpenseClaim'));
  if Assigned(form) then begin
    form.KeyID := 0;
    form.FormStyle := fsMDIChild;
    form.BringToFront;
  end;

end;


initialization
  RegisterClassOnce(TExpenseClaimListGUI);
end.
