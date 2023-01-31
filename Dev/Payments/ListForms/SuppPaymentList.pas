unit SuppPaymentList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm,
  PrintDAT, ActnList, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, DNMPanel, MemDS, DBAccess, MyAccess,ERPdbComponents,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TSuppPaymentListGUI = class(TBaseListingGUI)
    qryMainSupplierName: TWideStringField;
    qryMainOpeningBalance: TFloatField;
    qryMainPaymentAmount: TFloatField;
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
    qryMainPaymentDate: TDateField;
    qryMainPaymentMethod2: TWideStringField;
    qryMainChequePrinted: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    procedure SetGridColumns; override;
  public
    { Public declarations }
  end;

implementation

uses frmSuppPayments, CommonLib, Forms, AppEnvironment, tcConst;

{$R *.dfm}

procedure TSuppPaymentListGUI.grpFiltersClick(Sender: TObject);
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

procedure TSuppPaymentListGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('txtfrom').AsDateTime := FilterDateFrom;
  qryMain.Params.ParamByName('txtto').AsDateTime := FilterdateTo;
  inherited;
  qryMainReferenceNo.DisplayLabel := 'Chq / Reference #';
end;

procedure TSuppPaymentListGUI.cmdNewClick(Sender: TObject);
var 
  tmpComponent: TComponent;
begin
  DisableForm;
  try
    inherited;
    tmpComponent := GetComponentByClassName('TfmSuppPayments');
    if not Assigned(tmpComponent) then Exit;
    with TfmSuppPayments(tmpComponent) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TSuppPaymentListGUI.RefreshTotals;
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

procedure TSuppPaymentListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainAccountID.fieldname);
  RemoveFieldfromGrid(QrymainclassId.fieldname);
  RemoveFieldfromGrid(QrymainclientID.fieldname);
  RemoveFieldfromGrid(QrymainEmployeeID.fieldname);
  RemoveFieldfromGrid(Qrymainglobalref.fieldname);
end;

procedure TSuppPaymentListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  ShowChartViewOnPopup := True;
  if (not Assigned(Owner)) or (not (Owner is TForm)) then begin
    {only do this if the list not owned by another form, ie embeded}
    fbEnableWebSearch := true;
  end;
end;

procedure TSuppPaymentListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TSuppPaymentListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TSuppPaymentListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TSuppPaymentListGUI.FormShow(Sender: TObject);
begin
  inherited;
  if issubform then begin
    grpFilters.itemindex:= 0;
    grpFiltersClick(Sender);
  end;

  GuiPrefs.DbGridElement[grdMain].RemoveFields(
    'EmployeeId,ClientId,ClassId,PaymentId,AccountId');
end;

initialization
  RegisterClassOnce(TSuppPaymentListGUI);
end.

