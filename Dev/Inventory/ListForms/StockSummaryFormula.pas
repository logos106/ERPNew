unit StockSummaryFormula;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, ProductMovementList,
  DAScript, MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TStockSummaryFormulaGUI = class(TBaseListingGUI)
    Panel4: TPanel;
    lblClassTitle: TLabel;
    cboPart: TwwDBLookupCombo;
    cboPartsQry: TERPQuery;
    cboPartsQryPARTSID: TIntegerField;
    cboPartsQryPartName: TWideStringField;
    qryMainProductID: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainFirstColumn: TWideStringField;
    qryMainSecondColumn: TWideStringField;
    qryMainThirdColumn: TWideStringField;
    qryMainClassID: TLargeintField;
    qryMainFormulaQtyvalue1: TFloatField;
    qryMainFormulaQtyvalue2: TFloatField;
    qryMainFormulaQtyvalue3: TFloatField;
    qryMainFormulaQtyvalue4: TFloatField;
    qryMainFormulaQtyvalue5: TFloatField;
    qryMainAvailable: TFloatField;
    qryMainInStock: TFloatField;
    qryMainso: TFloatField;
    qryMaininvbo: TFloatField;
    qryMainpobo: TFloatField;
    qryMainonbuild: TFloatField;
    qryMainbuilding: TFloatField;
    DNMSpeedButton1: TDNMSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cboPartCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
      modified: Boolean);
    procedure DNMSpeedButton1Click(Sender: TObject);
  private
    tablename:String;
    fiProductId: Integer;
    Procedure MakeQrymain;
    procedure MakeTempTable;
    procedure SetProductID(const Value: Integer);
    procedure BeforeshowProductMovementformula(Sender: TObject);
  Protected
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    procedure SetGridColumns; Override;
    procedure AdjustDisplayLabels; Override;

  public
    Procedure RefreshQuery;override;
    Property ProductID :Integer read fiProductId write SetProductID;

  end;

implementation

uses CommonDbLib, ProductQtyLib , ProductStockReportLib, AppEnvironment,
  CommonLib,  CommonFormLib, ProductMovementformula;

{$R *.dfm}

{ TStockformulaSummaryGUI }


procedure TStockSummaryFormulaGUI.AdjustDisplayLabels;
begin
    qryMainFormulaQtyValue1.Displaylabel := Appenv.CompanyPrefs.PartCalcField1Name;
    qryMainFormulaQtyValue2.Displaylabel := Appenv.CompanyPrefs.PartCalcField2Name;
    qryMainFormulaQtyValue3.Displaylabel := Appenv.CompanyPrefs.PartCalcField3Name;
    qryMainFormulaQtyValue4.Displaylabel := Appenv.CompanyPrefs.PartCalcField4Name;
    qryMainFormulaQtyValue5.Displaylabel := Appenv.CompanyPrefs.PartCalcField5Name;
  inherited;
end;

procedure TStockSummaryFormulaGUI.cboPartCloseUp(Sender: TObject; LookupTable,FillTable: TDataSet; modified: Boolean);
begin
  cboPartsQry.Locate('PartName' , cboPart.text , []);
  fiProductID := cboPartsQryPartsID.asInteger;
  MakeTempTable;
  RefreshQuery;
end;

procedure TStockSummaryFormulaGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TProductMovementformulaGUI' ,BeforeshowProductMovementformula);
end;
procedure TStockSummaryFormulaGUI.BeforeshowProductMovementformula(Sender: TObject);
begin
  if not(Sender is TProductMovementformulaGUI) then exit;
  TProductMovementformulaGUI(Sender).ProductId := cboPartsQry.FieldByname('PArtsID').asInteger;
end;
procedure TStockSummaryFormulaGUI.FormCreate(Sender: TObject);
begin
  MakeQrymain;
  inherited;
  if not ErrorOccurred then begin
    cboPartsQry.Connection := qryMain.Connection;
    cboPartsQry.Open;
    cboPartsQry.first;
  end;
  fiProductID:=0;

end;

procedure TStockSummaryFormulaGUI.FormShow(Sender: TObject);
begin
  inherited;
    if cboPartsQry.active = false then cboPartsQry.open;
    cboPart.Text :=cboPartsQry.fieldByname('PartName').asSTring;
end;

procedure TStockSummaryFormulaGUI.MakeQrymain;
begin
  // inherited
  tablename := CommonDbLib.CreateUserTemporaryTable('tmp_ProductMovement' , 'Formula');
  ExecuteSQL('Alter table ' + tablename + ' Add column FormulaQtyvalue1 Double Null, '+
                                        ' Add column FormulaQtyvalue2 Double Null,  '+
                                        ' Add column FormulaQtyvalue3 Double Null,  '+
                                        ' Add column FormulaQtyvalue4 Double Null,  '+
                                        ' Add column FormulaQtyvalue5 Double Null;');


  if qrymain.Active then qrymain.close;
  qrymain.SQL.clear;
  qryMain.SQL.Add(' Select ');
  qryMain.SQL.Add(' ProductID	, ');
  qryMain.SQL.Add(' ProductName	, ');
  qryMain.SQL.Add(' FirstColumn	, ');
  qryMain.SQL.Add(' SecondColumn	, ');
  qryMain.SQL.Add(' ThirdColumn	,  ');
  qryMain.SQL.Add(' ClassID	,  ');
  qryMain.SQL.Add(' FormulaQtyvalue1, ');
  qryMain.SQL.Add(' FormulaQtyvalue2, ');
  qryMain.SQL.Add(' FormulaQtyvalue3, ');
  qryMain.SQL.Add(' FormulaQtyvalue4, ');
  qryMain.SQL.Add(' FormulaQtyvalue5,  ');
  qryMain.SQL.Add(' Sum(Available) Available,  ');
  qryMain.SQL.Add(' sum(InStock) InStock,  ');
  qryMain.SQL.Add(' sum(so) so,  ');
  qryMain.SQL.Add(' sum(invbo) invbo,  ');
  qryMain.SQL.Add(' sum(pobo) pobo,  ');
  qryMain.SQL.Add(' sum(onbuild) onbuild,  ');
  qryMain.SQL.Add(' sum(building) building');
  qryMain.SQL.Add(' from ' +  tablename );
  qryMain.SQL.Add(' group by ProductID	,ProductName	,FirstColumn	,SecondColumn	,ThirdColumn	, ClassID	,FormulaQtyvalue1,FormulaQtyvalue2,FormulaQtyvalue3,FormulaQtyvalue4,FormulaQtyvalue5;'); {incase so with tree created and converted on the same day , sorting id desc will give so first as these transactions(of tree) doesn;t store the time in PQA }
end;

procedure TStockSummaryFormulaGUI.ReadnApplyGuiPrefExtra;
var
  s:String;
begin
  inherited;
  if fiProductID =0 then begin
    s:=GuiPrefs.Node['General.ProductName'].AsString;
    if s<> '' then begin
       if cboPartsQry.active = false then cboPartsQry.open;
        if cboPart.text <> s then begin
          cboPart.text:=s;
          cboPartCloseUp(cboPart ,cboPart.LookupTable , nil,  True);
        end;
    end;
  end;

end;

procedure TStockSummaryFormulaGUI.RefreshQuery;
begin
  MakeTempTable;
  inherited;
  qryMain.FieldByName('ThirdColumn').DisplayLabel   := AppEnv.DefaultClass.ThirdColumn;
  qryMain.FieldByName('SecondColumn').DisplayLabel  := AppEnv.DefaultClass.SecondColumn;
  qryMain.FieldByName('FirstColumn').DisplayLabel   := AppEnv.DefaultClass.FirstColumn;
end;

procedure TStockSummaryFormulaGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainclassid.fieldName);
  RemoveFieldfromGrid(qryMainProductID.fieldName);
  if not Appenv.CompanyPrefs.PartCalcfield1Visible then RemoveFieldfromGrid(qryMainFormulaQtyValue1.fieldName);
  if not Appenv.CompanyPrefs.PartCalcfield2Visible then RemoveFieldfromGrid(qryMainFormulaQtyValue2.fieldName);
  if not Appenv.CompanyPrefs.PartCalcfield3Visible then RemoveFieldfromGrid(qryMainFormulaQtyValue3.fieldName);
  if not Appenv.CompanyPrefs.PartCalcfield4Visible then RemoveFieldfromGrid(qryMainFormulaQtyValue4.fieldName);
  if not Appenv.CompanyPrefs.PartCalcfield5Visible then RemoveFieldfromGrid(qryMainFormulaQtyValue5.fieldName);
end;

procedure TStockSummaryFormulaGUI.SetProductID(const Value: Integer);
begin
  fiProductId := Value;
  if cboPartsQry.active = false then cboPartsQry.open;
  if cboPartsQry.Locate('PartsID' , Value, []) then begin
    cboPart.text :=cboPartsQryPartName.asString;
    fiProductID := cboPartsQryPartsID.asInteger;
    RefreshQuery;
  end;
end;

procedure TStockSummaryFormulaGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['General.ProductName'].AsString:=cboPart.text;
end;

procedure TStockSummaryFormulaGUI.MakeTempTable;
(*var
  fiPartsID:Integer;*)
Var
   s: string;
begin
    (*if  cboPart.text <> '' then fiPartsID:= cboPartsQry.fieldByname('PartsID').asInteger else  fiPartsID:= 0;*)
    s := ChangeQuery( ProductStockReportLib.SQLtoAddDataToStockFormulaSummary(Tablename, fiProductID ,True , 0 , 0));
    ExecuteSQL(s);
end;

initialization
  RegisterClassOnce(TStockSummaryFormulaGUI);
end.

