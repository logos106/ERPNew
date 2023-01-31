unit frmSoldProductsReport;

{ Date     Version Who  What
 -------- -------- ---  --------------------------------------------------------
 30/05/06  1.00.01  AL  Initial Version

 }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton,  wwdblook,
  Shader, kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox;

type
  TSoldProductsReport = class(TBaseListingGUI)
    btnConfigure: TDNMSpeedButton;
    cmdUpdateProdQtyLines: TERPCommand;
    qryMainDepartmentID: TIntegerField;
    qryMainDepartment: TWideStringField;
    qryMainQuantitySold: TFloatField;
    qryMainProductID: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainFirstColumn: TWideStringField;
    qryMainSecondColumn: TWideStringField;
    qryMainThirdColumn: TWideStringField;
    qryMainDetail: TLargeintField;
    qryMainSaleID: TLargeintField;
    qryMainSaletype: TWideStringField;
    qryMainTotalEx: TFloatField;
    qryMainTotalInc: TFloatField;
    qryMainLineTax: TFloatField;
    qryMainPREFEREDSUPP: TWideStringField;
    qryMainProductPrintName: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure btnConfigureClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure grpFiltersClick(Sender: TObject);Override;
  private
    fdPreferredLevelPercentage: double;
    fdReoderPointPercentage: double;
    { Private declarations }
  protected
    Procedure RefreshQuery; override;
    Procedure UpdateProductQtyLines(ProductId, DepartmentId : integer; QtySold : double);
    procedure RefreshTotals; override;
  public
    { Public declarations }
    property ReoderPointPercentage : double read fdReoderPointPercentage write fdReoderPointPercentage;
    property PreferredLevelPercentage : double read fdPreferredLevelPercentage write fdPreferredLevelPercentage;
  end;

var
  SoldProductsReport: TSoldProductsReport;

implementation

uses FastFuncs,frmSoldProductReportPercentage, Forms,  AppEnvironment, CommonLib,
  ProductQtyLib, BusObjSaleBase, SalesConst;

{$R *.dfm}

{ TSoldProductsReport }

procedure TSoldProductsReport.RefreshQuery;
begin
  qryMain.ParamByName('DateFrom1').AsDate := dtFrom.Date;
  qryMain.ParamByName('DateTo1').AsDate := dtTo.Date;
  qryMain.ParamByName('DateFrom2').AsDate := dtFrom.Date;
  qryMain.ParamByName('DateTo2').AsDate := dtTo.Date;
  inherited;
end;

procedure TSoldProductsReport.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;

procedure TSoldProductsReport.FormCreate(Sender: TObject);
begin
  qryMain.SQL.text := StringReplace(qryMain.SQL.text , '"" AS FirstColumn'  , Firstcolumn('P') + ' AS FirstColumn' , [rfReplaceAll,rfIgnoreCase]);
  qryMain.SQL.text := StringReplace(qryMain.SQL.text , '"" AS SecondColumn' , Firstcolumn('P') + ' AS SecondColumn', [rfReplaceAll,rfIgnoreCase]);
  qryMain.SQL.text := StringReplace(qryMain.SQL.text , '"" AS ThirdColumn'  , Firstcolumn('P') + ' AS ThirdColumn' , [rfReplaceAll,rfIgnoreCase]);
  inherited;

  AddCalccolumn(qryMainQuantitySold.fieldName   , False);
  AddCalccolumn(qryMainTotalEx.fieldName   , True);
  AddCalccolumn(qryMainTotalInc.fieldName   , True);
  AddCalccolumn(qryMainLineTax.fieldName   , True);
  fbEnableWebSearch := true;
  fdReoderPointPercentage := 10;
  fdPreferredLevelPercentage := 100;
end;

procedure TSoldProductsReport.cmdNewClick(Sender: TObject);
Var i : integer;
  ProgressDialog: TProgressDialog;
begin
  if grdMain.SelectedList.Count = 0 then begin
    CommonLib.MessageDlgXP_Vista('Nothing is selected!', mtWarning, [mbOK], 0);
    Exit;
  end;
  ProgressDialog := TProgressDialog.Create(nil);
  Processingcursor(True);
  try
    ProgressDialog.Caption := 'Please Wait .......';
    ProgressDialog.MinValue := 0;
    ProgressDialog.Step := 1;
    ProgressDialog.MaxValue := grdMain.SelectedList.Count - 1;
    ProgressDialog.Execute;
    cmdUpdateProdQtyLines.Connection := qryMain.Connection;
    for I := 0 to grdMain.SelectedList.Count - 1 do begin
      qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);

      UpdateProductQtyLines(qryMain.FieldByName('ProductID').AsInteger,
                            qryMain.FieldByName('DepartmentID').AsInteger,
                            qryMain.FieldByName('QuantitySold').AsFloat);
      ProgressDialog.StepIt;
    end;
  finally
    FreeandNil(ProgressDialog);
    Processingcursor(False);
  end;
end;

procedure TSoldProductsReport.UpdateProductQtyLines(ProductId,
  DepartmentId: integer; QtySold : double);
begin
  cmdUpdateProdQtyLines.ParamByName('ReorderPoint').AsFloat := QtySold * ReoderPointPercentage / 100;
  cmdUpdateProdQtyLines.ParamByName('PreferredLevel').AsFloat := QtySold * PreferredLevelPercentage / 100;
  cmdUpdateProdQtyLines.ParamByName('ProductID').AsInteger := ProductId;
  cmdUpdateProdQtyLines.ParamByName('DepartmentID').AsInteger := DepartmentId;
  cmdUpdateProdQtyLines.Execute;
end;

procedure TSoldProductsReport.btnConfigureClick(Sender: TObject);
Var Form : TReportPercentage;
begin
  Form := TReportPercentage.Create(nil);
  try
    Form.edtRP.Text := IntToStr(Trunc(ReoderPointPercentage));
    Form.edtPL.Text := IntToStr(Trunc(PreferredLevelPercentage));
    if Form.ShowModal = mrOk then begin
      ReoderPointPercentage := FastFuncs.StrToInt(Form.edtRP.Text);
      PreferredLevelPercentage := FastFuncs.StrToInt(Form.edtPL.Text);
    end;
  finally
    FreeandNil(Form);
  end;  
end;

procedure TSoldProductsReport.FormShow(Sender: TObject);
begin
  inherited;
  if Trim(AppEnv.DefaultClass.PartColumn) <> '' then
    qryMain.FieldByName('ProductName').DisplayLabel := AppEnv.DefaultClass.PartColumn;

  if Trim(AppEnv.DefaultClass.ThirdColumn) <> '' then
    qryMain.FieldByName('ThirdColumn').DisplayLabel := AppEnv.DefaultClass.ThirdColumn;

  if Trim(AppEnv.DefaultClass.SecondColumn) <> '' then
    qryMain.FieldByName('SecondColumn').DisplayLabel := AppEnv.DefaultClass.SecondColumn;

  if Trim(AppEnv.DefaultClass.FirstColumn) <> '' then
    qryMain.FieldByName('FirstColumn').DisplayLabel := AppEnv.DefaultClass.FirstColumn;
  grpFiltersClick(grpFilters);
end;

procedure TSoldProductsReport.grdMainDblClick(Sender: TObject);
var
  ProductID:Integer;
begin
  if grpFilters.ItemIndex = 1 then begin
    ProductID:= qryMainProductID.asInteger;
    grpFilters.ItemIndex := 0;
    Qrymain.Locate('ProductID' , ProductID , []);
  end else begin
    SubsequentID := Chr(95) + qryMain.Fields.FieldByName('Saletype').AsString;
    if SameText(qryMain.FieldByName('Saletype').AsString,'CashSale') then begin
      case TSalesBase.GetSaleType(qryMain.FieldByName('SaleID').AsInteger) of
        stPOS,
        stPOSLayby,
        stPOSLaybyPayment,
        stPOSCashSale: SubsequentID := Chr(95) + 'POS';
      end;
    end;
    inherited;
  end;
end;

procedure TSoldProductsReport.grpFiltersClick(Sender: TObject);
begin
  if grpFilters.itemindex = 0 then GroupFilterString := 'Detail = 2'
  else if grpfilters.itemindex = 1 then GroupFilterString := 'DEtail = 1'
  else GroupFilterString := '';
  inherited;
  if grpFilters.itemindex = 1 then begin
    RemoveFieldfromGrid('Saletype');
  end else begin
    grdmain.AddField('Saletype');
  end;
end;

initialization
  RegisterClassOnce(TSoldProductsReport);

end.
