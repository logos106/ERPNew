unit SalesOrderStatusReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, MemDS, DBAccess, MyAccess,ERPdbComponents,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TSalesOrderStatusReportGUI = class(TBaseListingGUI)
    qryMainSaleDate: TDateField;
    qryMainTransactionType: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainCustomerType: TWideStringField;
    qryMainGlobal: TWideStringField;
    qryMainOriginal: TWideStringField;
    qryMainPONumber: TWideStringField;
    qryMainTotalAmountEx: TFloatField;
    qryMainTotalTax: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    qryMainEmployeeName: TWideStringField;
    qryMainConsignmentNote: TWideStringField;
    qryMainClassName: TWideStringField;
    qryMainProductType: TWideStringField;
    qryMainDepartment: TWideStringField;
    qryMainType: TWideStringField;
    qryMainManufacturer: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainProductDescription: TWideStringField;
    qryMainLinePriceEx: TFloatField;
    qryMainLinePriceInc: TFloatField;
    qryMainLineCostEx: TFloatField;
    qryMainLineCostInc: TFloatField;
    qryMainTaxCode: TWideStringField;
    qryMainLineTax: TFloatField;
    qryMainShipped: TFloatField;
    qryMainLineTotalEx: TFloatField;
    qryMainLineTotalInc: TFloatField;
    qryMainPreferedSupplier: TWideStringField;
    qryMainEmployeeID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainSaleID: TIntegerField;
    qryMainBackorder: TFloatField;
    qryMainConverted: TWideStringField;
    qryMainSalesOrderNumber: TWideStringField;
    qryMainProductPrintName: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure cmdNewClick(Sender: TObject);
  private
    { Private declarations }
    UseCreationDate: boolean;
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
  public
    { Public declarations }
  end;

implementation

uses
   frmSalesOrder, CommonLib, Forms, AppEnvironment,
  FastFuncs, tcConst;

{$R *.dfm}

{ TSalesOrderStatusReportGUI }

procedure TSalesOrderStatusReportGUI.RefreshQuery;
var
  SaleDateTo, SaleDateFrom, CreateDateTo, CreateDateFrom: TDateTime;
begin
  inherited;
  if UseCreationDate then begin
    SaleDateTo     := 300000;
    SaleDateFrom   := 0;
    CreateDateTo   := dtto.DateTime;
    CreateDateFrom := dtfrom.DateTime;
  end else begin
    SaleDateTo     := dtto.DateTime;
    SaleDateFrom   := dtfrom.DateTime;
    CreateDateTo   := 300000;
    CreateDateFrom := 0;
  end;
  
  qryMain.Params.ParamByName('txtfrom').AsDate :=  SaleDateFrom;
  qryMain.Params.ParamByName('txtto').AsDate :=  SaleDateTo;
  qryMain.Params.ParamByName('txtfrom1').AsDate :=  CreateDateFrom;
  qryMain.Params.ParamByName('txtto1').AsDate :=  CreateDateTo;

  inherited;

  qryMain.FieldByName('Product Name').DisplayLabel := AppEnv.DefaultClass.PartColumn;
  qryMainDepartment.DisplayLabel := AppEnv.DefaultClass.ThirdColumn;
  qryMainType.DisplayLabel := AppEnv.DefaultClass.SecondColumn;
  qryMainManufacturer.DisplayLabel := AppEnv.DefaultClass.FirstColumn;
  RefreshTotals;
end;

procedure TSalesOrderStatusReportGUI.RefreshTotals;
var
  TotalEx, TotalInc, Tax, Shipped, BackOrder: double;
  bm: TBookmark;
begin
  Shipped := 0;
  BackOrder := 0;
  TotalEx := 0;
  TotalInc := 0;
  Tax := 0;

  with qryMain do begin
    bm := GetBookmark;
    DisableControls;
    First;
    while not Eof do begin
      Shipped := Shipped + qryMainShipped.AsCurrency;
      BackOrder := BackOrder + qryMainBackorder.AsCurrency;
      TotalEx := TotalEx + qryMainLineTotalEx.AsCurrency;
      TotalInc := TotalInc + qryMainLineTotalInc.AsCurrency;
      Tax := Tax + qryMainLineTax.AsCurrency;
      Next;
    end;
    EnableControls;
    GotoBookmark(bm);
    FreeBookmark(bm);    
  end;
  grdMain.ColumnByName('Shipped').FooterValue := FloatToStrF(Shipped, ffFixed, 15, 2);
  grdMain.ColumnByName('BackOrder').FooterValue := FloatToStrF(BackOrder, ffFixed, 15, 2);
  grdMain.ColumnByName('Line Total (Ex)').FooterValue := FloatToStrF(TotalEx, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Line Total (Inc)').FooterValue := FloatToStrF(TotalInc, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Line Tax').FooterValue := FloatToStrF(Tax, ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TSalesOrderStatusReportGUI.FormCreate(Sender: TObject);
begin
  inherited;
  ShowChartViewOnPopup := True;
end;

procedure TSalesOrderStatusReportGUI.grpFiltersClick(Sender: TObject);
begin
  inherited;
  case grpFilters.ItemIndex of
    1: 
      begin
        UseCreationDate := true;
      end;
    0: 
      begin
        UseCreationDate := false;
      end;
  end;
  RefreshQuery;
end;

procedure TSalesOrderStatusReportGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + Trim(qryMain.FieldByName('Transaction Type').AsString);
  inherited;
end;

procedure TSalesOrderStatusReportGUI.cmdNewClick(Sender: TObject);
var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TSalesOrderGUI');
  if not Assigned(tmpComponent) then Exit;
  with TSalesOrderGUI(tmpComponent) do begin
    AttachObserver(Self);
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

initialization
  RegisterClassOnce(TSalesOrderStatusReportGUI);
end.
