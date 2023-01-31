unit CustPrepaymentList;

interface
{$I ERP.inc}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, MemDS, DBAccess, MyAccess,ERPdbComponents,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TCustPrepaymentListGUI = class(TBaseListingGUI)
    qryMainCompanyName: TWideStringField;
    qryMainPaymentDate: TDateField;
    qryMainAmount: TFloatField;
    qryMainReferenceNo: TWideStringField;
    qryMainDeleted: TWideStringField;
    qryMainPaymentMethod: TWideStringField;
    qryMainDepartment: TWideStringField;
    qryMainNotes: TWideStringField;
    qryMainEmployeeID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainAccountNo: TWideStringField;
    qryMainReceiptNo: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    btnPrintTemplate: TDNMSpeedButton;
    qryMainbalance: TFloatField;
    qryMainApplied: TFloatField;
    qryMainBankAccountName: TWideStringField;
    qryMainPrePaymentID: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure cmdNewClick(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPrintTemplateClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
  public
    { Public declarations }
  end;

implementation
  
uses Forms, frmCustPrepayments, CommonLib, AppEnvironment, tcConst;

{$R *.dfm}

{ TCustPrepaymentListGUI }

procedure TCustPrepaymentListGUI.RefreshQuery;
begin
  if chkIgnoreDates.Checked then begin
    qryMain.Params.ParamByName('txtfrom').AsDate := 0;
    qryMain.Params.ParamByName('txtto').AsDate := SysUtils.MaxDateTime;
  end
  else begin
    qryMain.Params.ParamByName('txtfrom').AsDate := dtFrom.DateTime;
    qryMain.Params.ParamByName('txtto').AsDate := dtTo.DateTime;
  end;
  inherited;
end;

procedure TCustPrepaymentListGUI.RefreshTotals;
var
  TotalPayments , totalbalance, totalApplied: double;
begin
  TotalPayments := 0;
  totalbalance:=0;
  totalApplied:=0;
  qryMain.DisableControls;
  with qryMain do begin
    First;
    while not Eof do begin
      TotalPayments := TotalPayments + qryMainAmount.AsCurrency;
      totalbalance:=totalbalance + qryMainbalance.asCurrency;
      totalApplied:=totalApplied +qryMainApplied.AsCurrency;

      Next;
    end;
    First;
  end;
  qryMain.EnableControls;
  grdMain.ColumnByName('Amount').FooterValue := FloatToStrF(TotalPayments, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('balance').FooterValue := FloatToStrF(totalbalance, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('applied').FooterValue := FloatToStrF(totalApplied, ffCurrency, 15, CurrencyRoundPlaces);

end;

procedure TCustPrepaymentListGUI.FormCreate(Sender: TObject);
begin
  fbEnableWebSearch := true;
  btnPrintTemplate.visible := false;
  {$IFDEF DevMode}
  btnPrintTemplate.visible := true;
  {$ENDIF}
  inherited;
  ShowChartViewOnPopup := True;  
end;

procedure TCustPrepaymentListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        GroupFilterString := 'Deleted <> ' + QuotedStr('T');
      end;
    1: 
      begin
        GroupFilterString := 'Deleted = ' + QuotedStr('T');
      end;
  end;
  inherited;
end;

procedure TCustPrepaymentListGUI.cmdNewClick(Sender: TObject);
var tmpComponent:TComponent;
begin
  DisableForm;
  try
    inherited;
    tmpComponent:= GetComponentByClassName('TfmCustPrepayments');
    if not assigned(tmpComponent) then exit;
    with TfmCustPrepayments(tmpComponent) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TCustPrepaymentListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TCustPrepaymentListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TCustPrepaymentListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TCustPrepaymentListGUI.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields(
    'EmployeeId,ClientId');
end;

procedure TCustPrepaymentListGUI.btnPrintTemplateClick(Sender: TObject);
begin
  inherited;
  PrintTemplateReport('CustPrepayment' , '' , False , 1);
end;

initialization
  RegisterClassOnce(TCustPrepaymentListGUI);
end.


