unit PriceDiscountListForm;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 09/11/05  1.00.01 MV   Initial version.
 11/11/05  1.00.02 MV   Added customer selection to support running as report

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, wwdblook, CustomInputBox, Shader,
  kbmMemTable;

type
  TPriceDiscountList = class(TBaseListingGUI)
    qryMainPriceLevel: TStringField;
    qryMainDescAttrib1: TStringField;
    qryMainDescAttrib2: TStringField;
    qryMainUnitofMeasure: TStringField;
    qryMainBARCODE: TStringField;
    qryMainPriceMatrixDesc: TStringField;
    qryMainPRICE1: TFloatField;
    qryMainPRICE2: TFloatField;
    qryMainPRICE3: TFloatField;
    qryMainSellQty12: TIntegerField;
    qryMainofPrice1: TFloatField;
    qryMainSellQty22: TIntegerField;
    qryMainofPrice2: TFloatField;
    qryMainSellQty32: TIntegerField;
    qryMainofPrice3: TFloatField;
    qryMainPrice1Ex: TCurrencyField;
    qryMainPrice2Ex: TCurrencyField;
    qryMainPrice3Ex: TCurrencyField;
    qryMainUofMPriceInc: TCurrencyField;
    qryMainTAXCODE: TStringField;
    qryMainProduct: TStringField;
    Panel4: TPanel;
    lblCustomer: TLabel;
    cboClient: TwwDBLookupCombo;
    qryClientLookup: TMyQuery;
    qryMainUnitofMeasureID: TIntegerField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure cboClientCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
  private
    { Private declarations }
    bInitialiseStartup: boolean;
    iClientTypeID: integer;
    procedure ModifiyControlVisibleState(VisibleState: boolean);
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
    property InitialiseStartup: boolean read bInitialiseStartup write bInitialiseStartup;
    property ClientTypeID: integer read iClientTypeID write iClientTypeID;
  end;

//var
//  PriceDiscountList: TPriceDiscountList;

implementation

uses
  DNMLib, CommonLib;

const
  QRY_MAIN_SQL_LINE_INSERT_POS = 9;

  {$R *.dfm}

procedure TPriceDiscountList.RefreshQuery;
var
  FilterIndex: Integer;
begin
  qryClientLookup.Locate('Company', cboClient.LookupValue, [loCaseInsensitive]);

  inherited;

  FilterIndex := cboFilter.Items.IndexOf('Desc Attrib1');

  if FilterIndex >= 0 then
    cboFilter.Items[FilterIndex] := GetDescAttribName(1);

  FilterIndex := cboFilter.Items.IndexOf('Desc Attrib2');

  if FilterIndex >= 0 then
    cboFilter.Items[FilterIndex] := GetDescAttribName(2);

  grdMain.ColumnByName('DescAttrib1').DisplayLabel := GetDescAttribName(1);
  grdMain.ColumnByName('DescAttrib2').DisplayLabel := GetDescAttribName(2);
end;

procedure TPriceDiscountList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

//  PriceDiscountList := nil;
  Action := caFree;
end;

procedure TPriceDiscountList.FormShow(Sender: TObject);
begin
  inherited;

  ModifiyControlVisibleState(false);

  qryMain.Close;
  qryMain.SQL.Insert(QRY_MAIN_SQL_LINE_INSERT_POS, 'WHERE PM.ClientTypeID = :xClientTypeID');
  qryMain.Params.ParamByName('xClientTypeID').AsInteger := ClientTypeID;
  qryMain.Open;

  if not qryMain.Active then Exit;

  RefreshQuery;
end;

procedure TPriceDiscountList.ModifiyControlVisibleState(VisibleState: boolean);
begin
  // Show or Hide specified controls
  if VisibleState then begin
    cboDateRange.Visible := true;
    lblFrom.Visible      := true;
    dtFrom.Visible       := true;
    lblTo.Visible        := true;
    dtTo.Visible         := true;
  end else begin
    cboDateRange.Visible := false;
    lblFrom.Visible      := false;
    dtFrom.Visible       := false;
    lblTo.Visible        := false;
    dtTo.Visible         := false;
  end;
end;

procedure TPriceDiscountList.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;

  qryMainUofMPriceInc.AsCurrency := GetAmountInc(qryMainPRICE1.AsFloat * GetUnitMultiplier(qryMainUnitofMeasureID.AsInteger),
    GetTaxRate(qryMainTAXCODE.AsString));

  qryMainPrice1Ex.AsFloat := qryMainPRICE1.AsFloat - ((DivZer(qryMainofPrice1.AsFloat, 100)) * qryMainPRICE1.AsFloat);

  qryMainPrice2Ex.AsFloat := qryMainPRICE2.AsFloat - ((DivZer(qryMainofPrice2.AsFloat, 100)) * qryMainPRICE2.AsFloat);

  qryMainPrice3Ex.AsFloat := qryMainPRICE3.AsFloat - ((DivZer(qryMainofPrice3.AsFloat, 100)) * qryMainPRICE3.AsFloat);

  grdMain.RefreshDisplay;
end;

procedure TPriceDiscountList.FormCreate(Sender: TObject);
begin
  inherited;
  if not ErrorOccurred then begin
    qryClientLookup.Connection := qryMain.Connection;
    qryClientLookup.Open;
  end;
end;

procedure TPriceDiscountList.cboClientCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;

  qryMain.Params.ParamByName('xClientTypeID').AsInteger := cboClient.LookupTable.FieldByName('ClientTypeID').AsInteger;
  RefreshQuery;
end;

initialization
  RegisterClassOnce(TPriceDiscountList);

finalization
  UnRegisterClass(TPriceDiscountList);
end.
