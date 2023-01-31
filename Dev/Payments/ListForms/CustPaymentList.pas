unit CustPaymentList;

interface
{$I ERP.inc}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar, ImgList, Menus, AdvMenus, PrintDAT,
  ActnList, wwDialog, Wwlocate, SelectionDialog, DNMPanel, MemDS,
  DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog,
  wwdblook, Shader, kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox , BaseListExpress,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TCustPaymentListGUI = class(TBaseListExpressGUI)
    qryMainPaymentDate: TDateTimeField;
    qryMainCustomerName: TWideStringField;
    qryMainOpeningBalance: TFloatField;
    qryMainPaymentAmount: TFloatField;
    qryMainPaymentMethod: TWideStringField;
    qryMainReferenceNo: TWideStringField;
    qryMainBankAccount: TWideStringField;
    qryMainDepartment: TWideStringField;
    qryMainNotes: TWideStringField;
    qryMainDeleted: TWideStringField;
    qryMainClassID: TIntegerField;
    qryMainClientID: TAutoIncField;
    qryMainPaymentID: TAutoIncField;
    qryMainEmployeeID: TIntegerField;
    qryMainAccountID: TIntegerField;
    qryMainReceiptNo: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    btnPrintTemplate: TDNMSpeedButton;
    qryMainprintjobname: TWideStringField;
    qryMainjobname: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure btnPrintTemplateClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    procedure SetGridColumns; override;
    Function ExpressDetailListName:String;override;
  public
    { Public declarations }
  end;

implementation

uses Forms, frmcustPayments, CommonLib, AppEnvironment, tcConst, DateUtils,
  CommonFormLib;

{$R *.dfm}

procedure TCustPaymentListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: GroupFilterString := 'Deleted <> ' + QuotedStr('T');
    1: GroupFilterString := 'Deleted = ' + QuotedStr('T');
  end;
  inherited;
end;

procedure TCustPaymentListGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;
end;

procedure TCustPaymentListGUI.RefreshTotals;
var
  TotalPayments: double;
begin
  TotalPayments := 0;
  qryMain.DisableControls;
  with qryMain do begin
    First;
    while not Eof do begin
      TotalPayments := TotalPayments + qryMainPaymentAmount.AsCurrency;
      Next;
    end;
    First;
  end;
  qryMain.EnableControls;
  grdMain.ColumnByName('PaymentAmount').FooterValue := FloatToStrF(TotalPayments, ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TCustPaymentListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainEmployeeId.fieldname);
  RemoveFieldfromGrid(QrymainClientId.fieldname);
  RemoveFieldfromGrid(QrymainClassId.fieldname);
  RemoveFieldfromGrid(QrymainPaymentId.fieldname);
  RemoveFieldfromGrid(QrymainAccountId.fieldname);
end;

procedure TCustPaymentListGUI.FormCreate(Sender: TObject);
begin
  fbEnableWebSearch := true;
  btnPrintTemplate.visible := false;
  {$IFDEF DevMode}
  btnPrintTemplate.visible := true;
  {$ENDIF}
  inherited;
end;

procedure TCustPaymentListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TCustPaymentListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TCustPaymentListGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfmCustPayments' , 0);
end;

procedure TCustPaymentListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

function TCustPaymentListGUI.ExpressDetailListName: String;
begin
  Result := 'TCustPaymentListDettailsGUI';
end;

procedure TCustPaymentListGUI.btnPrintTemplateClick(Sender: TObject);
begin
  inherited;
  PrintTemplateReport('CustPayments' , '' , False , 1);
end;

initialization
  RegisterClassOnce(TCustPaymentListGUI);
end.
