unit frmSalesProductSpec;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,ERPdbComponents,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, DNMPanel, Grids,
  Wwdbigrd, Wwdbgrid, DNMSpeedButton, StdCtrls, wwcheckbox , Mask,
  wwdbedit, wwdblook, MemDS, Buttons, BusobjSaleBase,
  Shader, ImgList, ProgressDialog , BusObjBase , BusObjFeTransLines,
  wwclearbuttongroup, wwradiogroup,frmTransProductSpec;

type
  TfmSalesProductSpec = class(TfmTransProductSpec)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure grdProductGroupExit(Sender: TObject);
    procedure cboFormulaCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboProductXCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure btnCancelClick(Sender: TObject);
    procedure grdRelatedPrCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
    fFESalesLinesDataSource :TDatasource;
    fRelatedPrDatasource :TDatasource;
    fProductLookup :TDataset;
    fOriginatedFromProductID:integer;
    Procedure   SetFESalesLinesDataSource(Const Value : TDatasource);
    Procedure   SetRelatedPrDatasource(Const Value : TDatasource);
    Procedure   setProductLookup(Const Value :TDataset);


    procedure OpenDs;
    procedure ShowFormulaValue;

  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);override;
    procedure Selectformula(Sender: TwwDbGrid);Override;
    procedure LocateFormula(Sender: TObject);Override;
  public
    Property FESalesLinesDataSource :TDatasource Write SetFESalesLinesDataSource;
    Property FERelatedPrDaatsource :TDatasource Write SetRelatedPrDatasource;

    Property ProductLookup :TDataset read fProductLookup Write SetProductLookup;
  end;


implementation

uses Sales, CommonLib, BaseTransForm,  AppEnvironment, ProductformulaList,
  tcDataUtils, CommonFormLib, BusObjConst;

{$R *.dfm}
procedure TfmSalesProductSpec.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true; // its sub option of slaes, so if sales has access, this should have
  inherited;
    {change the color and image based on the form called from}

  if Assigned(Self.Owner) then
    if Self.Owner is TBaseSaleGUI then  begin
        grdProductGroup.Footercolor :=TBaseSaleGUI(Self.Owner).grdTransactions.FooterColor;
        grdProductGroup.TitleColor  :=TBaseSaleGUI(Self.Owner).grdTransactions.TitleColor;
        grdRelatedPr.Footercolor :=TBaseSaleGUI(Self.Owner).grdTransactions.FooterColor;
        grdRelatedPr.TitleColor :=TBaseSaleGUI(Self.Owner).grdTransactions.TitleColor;
  end;
  fbTabSettingEnabled := false;
  fFESalesLinesDataSource := nil;
  fRelatedPrDatasource    := nil;
  fFETransLines           := nil;
  if Assigned(Self.Owner) then
      if Self.Owner is TBaseSaleGUI then begin
           FESalesLinesDataSource :=TBaseSaleGUI(Self.Owner).dsFESalesLines;
           FERelatedPrDaatsource :=TBaseSaleGUI(Self.Owner).dsFESaleslinesRelatedPrs;
           ProductLookup :=QryRelatedPRLookup;
      end;
end;
Procedure TfmSalesProductSpec.setFESalesLinesDataSource(Const Value : TDatasource);
begin
    fFESalesLinesDataSource     := Value;
    if Value = nil then Exit;
    grdProductGroup.Datasource  := Value;
    //grdinactive.Datasource  := Value;
    edtProductName.Datasource   := Value;
    edtFormula.text := getDescribeFormula(Value.Dataset.Fieldbyname('formulaID').asInteger);
    edtFormulaWithValue.text :=getFormulaName(Value.Dataset.Fieldbyname('formulaID').asInteger);
    ShowFormulaValue;

end;
Procedure   TfmSalesProductSpec.SetRelatedPrDatasource(Const Value : TDatasource);
begin
    fRelatedPrDatasource        := Value;
    if Value = nil then exit;
   grdRelatedPr.Datasource      := Value;
end;

Procedure TfmSalesProductSpec.SetProductLookup(Const Value :TDataset);
begin
    fProductLookup := Value;
    if value = nil then Exit;
    cboProductX.Lookuptable := Value;
end;
procedure TfmSalesProductSpec.FormShow(Sender: TObject);
var
    Ctr:Integer;
    fifieldNo:String;
    ficwidth :Integer;
    ProductformulaID:Integer;
begin
  DisableForm;
  try
    inherited;
    OpenQueries;
    OpenDs;
    {datasources are supposed to be initialised
    the datasources are kept outside as the sales form is using this at the moment and
    these tables are part of the sales object which shoould be intialised from the sales form.
    and we don;t want to keep any dependancy for the sales form}
    if (fFESalesLinesDataSource =nil) or (fRelatedPrDatasource =nil) then begin
        CommonLib.MessageDlgXP_Vista(ReplaceStr('Error openeing ' + Self.Caption , '(Full Access)' , '') , mtWarning , [mbOK] , 0);
        Self.Close;
        Exit;
    end;
    For ctr := grdProductGroup.FieldCount-1 downto 0 do begin
      fifieldNo :=REplaceStr(grdProductGroup.Fields[ctr].FieldName , 'Field' , '');
      if qryFieldNames.Locate('FormulaEntryNo' , fifieldNo , []) = False then begin
          grdProductGroup.RemoveField(grdProductGroup.Fields[ctr].FieldName);
      end else begin
          grdProductGroup.ColumnByName(grdProductGroup.Fields[ctr].FieldName).DisplayLabel := CommonLib.SeparateWords(qryFieldNamesFormulaEntryName.asString);
      end;
    end;
    fiCwidth := System.Round(int(60/grdProductGroup.FieldCount));
    if fiCWidth < 12 then fiCWidth := 12;
    For ctr := grdProductGroup.FieldCount-1 downto 0 do
        grdProductGroup.ColumnByName(grdProductGroup.Fields[ctr].FieldName).DisplayWidth := fiCwidth;
    if grdProductGroup.FieldCount> 5 then begin
        grdProductGroup.height := 100; // scroll bars will be displayed , so adjust the height
        pnlProduct.height := 130;
    end else begin
        grdProductGroup.height := 60;
        pnlProduct.height := 98;
    end;

    fOriginatedFromProductID := fFETransLines.ProductID;
    ProductformulaID:= fFETransLines.formulaID;
    if ProductformulaID <> 0 then begin
      if fFETransLines.Lines.locate('formulaID' , ProductformulaID ,[]) = False then begin
        fFETransLines.Lines.New;
        fFETransLines.Lines.ProductId :=fFETransLines.ProductID;
        fFETransLines.Lines.ProductName := fFETransLines.Productname;
        fFETransLines.Lines.formulaID :=ProductformulaID;
        fFETransLines.Lines.PostDB;
      end;
    end;
    Setcontrolfocus(grdProductGroup);
    ShowFormulaValue;
  finally
    EnableForm;
  end;
end;

procedure TfmSalesProductSpec.grdRelatedPrCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if fOriginatedFromProductID = fFETransLines.Lines.ProductId then ABrush.Color:= $0080FF80; { light green }
end;

procedure TfmSalesProductSpec.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusobjEvent_ToDo ) and (Value =  BusObjEventVal_FormulaValue) then begin
    ShowFormulaValue;
  end;
end;

procedure TfmSalesProductSpec.LocateFormula(Sender: TObject);
begin
  if not(Sender is TfmProductformulaList) then exit;
  TfmProductformulaList(Sender).KeyIdtoLocate := edtProductName.datasource.Dataset.Fieldbyname('formulaID').asInteger;
end;
procedure TfmSalesProductSpec.OpenDs;
begin
  if Assigned(Self.Owner) then
    if Self.Owner is TBaseSaleGUI then  begin
      if assigned(FETransLines) then
        TBaseSaleGUI(owner).REadFeSaleslines; // just accessing the object to make sure the table is active - it was not for tree products
    end;

end;

procedure TfmSalesProductSpec.Selectformula(Sender: TwwDbGrid);
begin
  EditDB(edtProductName.datasource.Dataset);
  //edtProductName.datasource.Dataset.Fieldbyname('formulaID').asInteger;
  fFETransLines.formulaID := sender.datasource.dataset.FieldByName('FormulaId').asInteger;
  fFETransLines.PostDB;
  edtFormula.text := getDescribeFormula(fFETransLines.Lines.formulaID );
  edtFormulaWithValue.text :=getFormulaName(fFETransLines.Lines.formulaID);
  ShowFormulaValue;
end;
Procedure TfmSalesProductSpec.ShowFormulaValue;
begin
  DoShowFormulaValue(FETransLines);
end;
procedure TfmSalesProductSpec.btnCompletedClick(Sender: TObject);
begin
    if fFETransLines.Save then
      self.Modalresult := mrOk;
end;

procedure TfmSalesProductSpec.grdProductGroupExit(Sender: TObject);
begin
  inherited;
    if Assigned(FETransLines) then fFETransLines.postdb;
end;

procedure TfmSalesProductSpec.cboFormulaCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if Modified = false then Exit;
  inherited;
   grdRelatedPr.SetActiveField('RelatedQty');
end;

procedure TfmSalesProductSpec.cboProductXCloseUp(Sender: TObject;  LookupTable, FillTable: TDataSet; modified: Boolean);
var
  s:String;
begin
  if Modified = false then Exit;
  inherited;
    fillTable.Fieldbyname('productName').asString := LookupTable.Fieldbyname('Partname').asSTring;
    fillTable.Fieldbyname('ProductID').asInteger  := LookupTable.Fieldbyname('PartsId').asInteger;
    fFETransLines.Lines.PostDB;
    fFETransLines.Lines.EditDB;
    if fOriginatedFromProductID = LookupTable.Fieldbyname('PartsId').asInteger then begin
      s:= 'FESalesLineID = ' +inttostr(fFETransLines.ID) +' and ProductID = ' + inttostr(fOriginatedFromProductID);
      if  fFETransLines.Lines.ISUnique(fFETransLines.Lines.ID, s , fFETransLines.Lines.Connection.connection) then
        CommonLib.MessageDlgXP_Vista('The formula will be applied to the product itself.',mtInformation, [mbOK], 0)
      else begin
        CommonLib.MessageDlgXP_Vista('A formula is already applied to the product, Can only apply to one formula to the product',mtInformation, [mbOK], 0);
        DeleteLine;
      end;
    end;
end;

procedure TfmSalesProductSpec.btnCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

initialization
  RegisterClassOnce(TfmSalesProductSpec);

finalization
  UnRegisterClass(TfmSalesProductSpec);


end.
