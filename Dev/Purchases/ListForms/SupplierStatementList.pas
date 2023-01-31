unit SupplierStatementList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, MemDS, DBAccess, MyAccess,ERPdbComponents,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TSupplierStatementGUI = class(TBaseListingGUI)
    qryMainSupplierName: TWideStringField;
    qryMainType: TWideStringField;
    qryMainGlobal: TWideStringField;
    qryMainTransactionNo: TWideStringField;
    qryMainTotalAmountEx: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    qryMainComments: TWideStringField;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainPaid: TFloatField;
    qryMainbalance: TFloatField;
    qryMainInvoiceNumber: TWideStringField;
    qryMainTerms: TWideStringField;
    Label2: TLabel;
    chkBasePurchOn: TCheckBox;
    qryMainDate: TDateTimeField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure chkBasePurchOnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
    procedure ReadnApplyGuiPrefExtra; override;
    Procedure WriteGuiPrefExtra; override;
    procedure RefreshTotals; override;
    procedure SetGridColumns; override;
  public
    { Public declarations }
  end;

//var
//  SupplierStatementGUI: TSupplierStatementGUI;

implementation

uses
  CommonLib, SystemLib;

{$R *.dfm}

{ TSupplierStatementGUI }

procedure TSupplierStatementGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
    if GuiPrefs.Node.Exists('Options.BasesOnInvoicedate') then
      chkBasePurchOn.checked :=  GuiPrefs.Node['Options.BasesOnInvoicedate'].asBoolean;
end;

procedure TSupplierStatementGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('BasedonInvoiceDate').AsString := BooleanTostr(chkBasePurchOn.Checked);
  qryMain.Params.ParamByName('IgnoreDateRange').AsString    := BooleanTostr(chkIgnoreDates.Checked);
  qryMain.Params.ParamByName('txtfrom').AsDate  := FilterdateFrom;
  qryMain.Params.ParamByName('txtto').AsDate    := FilterdateTo;
  inherited;
end;

procedure TSupplierStatementGUI.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;

end;

procedure TSupplierStatementGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainclientid.fieldname);
  RemoveFieldfromGrid(qryMainGlobal.fieldname);
end;

procedure TSupplierStatementGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.BasesOnInvoicedate'].asBoolean:= chkBasePurchOn.checked;
end;

procedure TSupplierStatementGUI.chkBasePurchOnClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
  if chkBasePurchOn.Checked then
    TimerMsg(FilterLabel , 'The purchase orders are filtered on the ''Invoice date'' for the selected date range' )
  else TimerMsg(FilterLabel , 'The purchase orders are filtered on the ''Order date'' for the selected date range' );
end;

procedure TSupplierStatementGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  SupplierStatementGUI := nil;
end;

procedure TSupplierStatementGUI.FormCreate(Sender: TObject);
begin
  //fbIgnoreAccessLevels:=True;
  inherited;
  AddCalccolumn(qryMainTotalAmountEx.FieldName, true);
  AddCalccolumn(qryMainTotalAmountInc.FieldName, true);
  AddCalccolumn(qryMainBalance.FieldName, true);
  AddCalccolumn(qryMainPaid.FieldName, true);
end;

procedure TSupplierStatementGUI.FormShow(Sender: TObject);
begin
  inherited;
  qryMainDate.displayformat := FormatSettings.ShortDateFormat;
end;

procedure TSupplierStatementGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMain.Fields.FieldByName('Type').AsString;
  inherited;
end;

procedure TSupplierStatementGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := 'SupplierName,Date DESC';
end;

initialization
  RegisterClassOnce(TSupplierStatementGUI);
end.
