unit SalesAddressLabelPrn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup;

type
  TSalesAddressLabelPrnGUI = class(TBaseListingGUI)
    btnAddresslabel: TDNMSpeedButton;
    qryMainClientId: TIntegerField;
    qryMainSaleno: TWideStringField;
    qryMainSaleId: TIntegerField;
    qryMainBORef: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainTotalAmountinc: TFloatField;
    qryMainTotalAmount: TFloatField;
    qryMainPayment: TFloatField;
    qryMainBalance: TFloatField;
    qryMainSaleDate: TDateField;
    qryMainConverted: TWideStringField;
    qryMainfutureSo: TWideStringField;
    qryMainDone: TWideStringField;
    qryMainType: TWideStringField;
    qryMainStatus: TWideStringField;
    qryMainshipdate: TDateField;
    qryMainheld: TWideStringField;
    qryMainPONumber: TWideStringField;
    qryMainterms: TWideStringField;
    qryMainComments: TWideMemoField;
    qryMainnoofboxes: TLargeintField;
    qryMainshipped: TFloatField;
    qryMainIsBO: TStringField;
    chkIncludeBackorders: TwwCheckBox;
    Label2: TLabel;
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure btnAddresslabelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure chkIncludeBackordersClick(Sender: TObject);
  private
    fiCustomerID:Integer;
  Protected
    procedure SetGridColumns; Override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
    Procedure RefreshQuery;Override;
    Property CustomerID :Integer read fiCustomerID write fiCustomerID;
  end;


implementation

uses CommonLib, saleslib, AppEnvironment, tcConst, SystemLib;

{$R *.dfm}

{ TSalesAddressLabelPrnGUI }

procedure TSalesAddressLabelPrnGUI.btnAddresslabelClick(Sender: TObject);
begin
  inherited;
  IterateProcNo := 1;
  IterateselectedRecords;
end;
procedure TSalesAddressLabelPrnGUI.chkIncludeBackordersClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;

end;

procedure TSalesAddressLabelPrnGUI.FormCreate(Sender: TObject);
begin
  inherited;
  CustomerID := 0;
end;

procedure TSalesAddressLabelPrnGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMainType.AsString;
  inherited;
end;

procedure TSalesAddressLabelPrnGUI.grpFiltersClick(Sender: TObject);
begin
       if grpFilters.ItemIndex = 0 then GroupFilterString := 'isinvoice =' +Quotedstr('T')
  else if grpFilters.ItemIndex = 1 then GroupFilterString := 'isSalesOrder =' +Quotedstr('T')
  else if grpFilters.ItemIndex = 2 then GroupFilterString := 'IsRefund =' +Quotedstr('T')
  else if grpFilters.ItemIndex = 3 then GroupFilterString := 'IsLayby =' +Quotedstr('T')
  else GroupFilterString := '';
  (*if chkIncludeBackorders.Checked =False  then begin
    if GroupFilterString <> '' then GroupFilterString := ' and ';
    GroupFilterString := GroupFilterString + 'ISBO = ' +quotedstr('F');
  end;*)
  inherited;
end;

procedure TSalesAddressLabelPrnGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
var
  noofBoxes:Integer;
begin
  inherited;
  if IterateProcNo = 1 then begin
  ReportSQLSupplied := true;
  try
    noofBoxes := CustomInputInteger('No of Lables' , 'Specify the number of labels to be printed for ' +NL+ Qrymaintype.asString +' # ' + inttostr(QrymainsaleID.asInteger) +NL+'for ' +quotedstr(Qrymaincustomername.asString) , inttostr(qryMainnoofboxes.AsInteger));
    if noofBoxes <=0 then exit;
    PrintTemplateReport('Address Labels', SalesAddressLabelSQL(noofBoxes, QrymainSaleID.AsInteger), not(Appenv.Employee.ShowPreview) and not(devmode), 1);
  finally
    ReportSQLSupplied := False;
  end;

  end;
end;

procedure TSalesAddressLabelPrnGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  Qrymainisbo.AsBoolean := Qrymainshipped.asfloat = 0;
end;

procedure TSalesAddressLabelPrnGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
    if GuiPrefs.Node.Exists('Options.IncludeBackorders') then
      chkIncludeBackorders.checked :=  GuiPrefs.Node['Options.IncludeBackorders'].asBoolean;

end;

procedure TSalesAddressLabelPrnGUI.RefreshQuery;
begin
  Qrymain.ParamByName('datefrom').AsDateTime := filterDateFrom;
  Qrymain.ParamByName('DateTo').AsDateTime := filterDateto;
  Qrymain.ParamByName('CustomerID').asInteger := CustomerID;
  Qrymain.ParamByName('IncludeBos').asString := booleantoStr(chkIncludeBackorders.checked);
  inherited;
end;

procedure TSalesAddressLabelPrnGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(Qrymainshipped.FieldName);
  RemoveFieldfromGrid(QrymainclientID.FieldName);
end;

procedure TSalesAddressLabelPrnGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.IncludeBackorders'].asBoolean:= chkIncludeBackorders.checked;
end;

initialization
  RegisterClassOnce(TSalesAddressLabelPrnGUI);
end.

