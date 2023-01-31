unit FrmSalesRelatedProducts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel, BusobjBase, busobjsaleBase,
  Mask, wwdbedit, Buttons, Wwdbigrd, Grids, Wwdbgrid, ComCtrls, DBCtrls,
  wwdblook, ERPDbLookupCombo, wwSpeedButton, wwDBNavigator, wwclearpanel,
  wwclearbuttongroup, wwradiogroup;

type
  TFmSalesRelatedProducts = class(TBaseInputGUI)
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    DSDetails: TDataSource;
    dsSalesObj: TDataSource;
    chkshowList: TCheckBox;
    qryProductformula: TERPQuery;
    qryProductformulaFormulaName: TWideStringField;
    qryProductformulaFormulaID: TIntegerField;
    TABCTL20: TPageControl;
    TabMain: TTabSheet;
    pnlTab: TDNMPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    lblFormula1: TLabel;
    lblFormula2: TLabel;
    lblFormula3: TLabel;
    lblFormula5: TLabel;
    lblFormula4: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label1: TLabel;
    lblrelUnitofMeasureShipped: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    wwDBEdit7: TwwDBEdit;
    edtFormula1: TwwDBEdit;
    edtFormula2: TwwDBEdit;
    edtFormula3: TwwDBEdit;
    edtFormula5: TwwDBEdit;
    edtFormula4: TwwDBEdit;
    wwDBEdit13: TwwDBEdit;
    txtComments: TDBMemo;
    navPartPic: TwwDBNavigator;
    navPartPicFirst: TwwNavButton;
    navPartPicPrior: TwwNavButton;
    navPartPicNext: TwwNavButton;
    navPartPicLast: TwwNavButton;
    cboProductformula: TwwDBLookupCombo;
    btnChangeProduct: TDNMSpeedButton;
    edtProductName: TwwDBEdit;
    edtUnitofMeasureShipped: TEdit;
    wwDBEdit2: TwwDBEdit;
    grpDescription: TwwRadioGroup;
    tabFollowupnProducts: TTabSheet;
    pnlGrid: TDNMPanel;
    DNMPanel1: TDNMPanel;
    grdTransactions: TwwDBGrid;
    grdTransactionsIButton: TwwIButton;
    DNMPanel4: TDNMPanel;
    pnlsold: TDNMPanel;
    lblQtySold: TLabel;
    edtQtySold: TwwDBEdit;
    DNMPanel7: TDNMPanel;
    Label2: TLabel;
    pnlShipped: TDNMPanel;
    lblQtyShipped: TLabel;
    edtQtyShipped: TwwDBEdit;
    pnluom: TDNMPanel;
    lblUOM: TLabel;
    edtuom: TwwDBEdit;
    pnlBO: TDNMPanel;
    lblBO: TLabel;
    edtBO: TwwDBEdit;
    DNMPanel5: TDNMPanel;
    lblProductname: TLabel;
    DBText2: TDBText;
    chkShippedQtyOnly: TCheckBox;
    grpListDescription: TwwRadioGroup;
    Label4: TLabel;
    pnlTotals: TDNMPanel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Shape3: TShape;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    Label5: TLabel;
    wwDBEdit1: TwwDBEdit;
    edtmainProductname: TwwDBEdit;
    edtrelUnitofMeasureShipped: TwwDBEdit;
    DNMSpeedButton1: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdTransactionsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdTransactionsCalcTitleAttributes(Sender: TObject;
      AFieldName: string; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure grdTransactionsDblClick(Sender: TObject);
    procedure chkShippedQtyOnlyClick(Sender: TObject);
    procedure chkshowListClick(Sender: TObject);
    procedure btnChangeProductClick(Sender: TObject);
    procedure edtUnitofMeasureShippedExit(Sender: TObject);
    procedure edtUnitofMeasureShippedKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grpDescriptionClick(Sender: TObject);
    procedure grpListDescriptionClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fiSaleId: Integer;
    fConnection: TMyDacDataConnection;
    fiParentLineId: Integer;
    fSalesobj:TSalesBase;
    fSalesBase:TSalesBase;
    aupodaterelatedProdQty :TNotifyEvent;
    function DoShowSalesRelatedProducts(aSalesBase : TSalesBase; fupodaterelatedProdQty :TNotifyEvent) :Boolean;
    procedure Initfields;
    function ActivePageIndex: Integer;
    procedure Chooseproduct(Sender: TwwDbGrid);
    procedure exmainproduct(Sender: TObject);
    procedure RefreshNavigator;
    procedure UpdateSalesQty(const Qty: Double; Sales : TSalesBase);
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    Property SaleId:Integer read fiSaleId write fiSaleId;
    Property ParentLineId :Integer read fiParentLineId write fiParentLineId;
    Property Connection : TMyDacDataConnection read fConnection write fConnection;
    Class function ShowSalesRelatedProducts(aSalesBase : TSalesBase; formcolor : TColor ; fupodaterelatedProdQty :TNotifyEvent) :Boolean;
  end;


implementation

uses BusObjSales, AppEnvironment, CommonLib, tcConst, BusObjConst,
  CommonFormLib, ProductListExpressForm, LogLib;

{$R *.dfm}

procedure TFmSalesRelatedProducts.btnDeleteClick(Sender: TObject);
begin
  inherited;
  fSalesobj.lines.Deleted := True;
  fSalesobj.lines.PostDB;
end;
Function TFmSalesRelatedProducts.ActivePageIndex:Integer;
begin
  if chkshowList.checked then result := 0 else result := 1;
end;
procedure TFmSalesRelatedProducts.chkshowListClick(Sender: TObject);
(*var
  Allowchange :Boolean;*)
begin
  inherited;
  GuiPrefs.Node['Options.ShowList'].asBoolean := chkShowList.Checked;


  fbIsLocalPrefChanged := True;
  (*if MainPage.ActivePageIndex <> ActivePageIndex then begin
      MainPageChanging(MainPage , Allowchange);
      if not Allowchange then exit;
      TTabsheet(MainPage.pages[ActivePageIndex]).Tabvisible := False;
      MainPage.ActivePageIndex :=ActivePageIndex;
      TTabsheet(MainPage.pages[ActivePageIndex]).Tabvisible := true;
      MainPage.OnChange(MainPage);
      Setcontrolfocus(MainPage);
    end;*)
(*        pnlGrid.Visible := ActivePageIndex =0;
        pnlTab.Visible := ActivePageIndex =1;*)
  if TabCtl20.ActivePageIndex =0 then TabCtl20.ActivePageIndex := 1 else TabCtl20.ActivePageIndex  :=0;
  TTabsheet(TabCtl20.pages[TabCtl20.ActivePageIndex]).Tabvisible := False;

end;

procedure TFmSalesRelatedProducts.chkShippedQtyOnlyClick(Sender: TObject);
begin
  inherited;
  GuiPrefs.Node['Options.ShippedQtyOnly'].asBoolean := chkShippedQtyOnly.Checked;
  fbIsLocalPrefChanged:= True;
  Initfields;
end;

procedure TFmSalesRelatedProducts.cmdCancelClick(Sender: TObject);
begin
  inherited;
  if fsModal in FormState then modalresult := mrCancel
  else Self.Close;
end;

procedure TFmSalesRelatedProducts.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if fsModal in FormState then modalresult := mrOk
  else Self.Close;
end;

procedure TFmSalesRelatedProducts.btnChangeProductClick(Sender: TObject);
begin
  inherited;

  OpenERPListFormSingleselectModal('TProductListExpressGUI' , Chooseproduct , exmainproduct);

end;
procedure TFmSalesRelatedProducts.Chooseproduct(Sender: TwwDbGrid);
var
  fbflag:Boolean;
begin

   fSalesobj.Lines.Dataset.DisableControls;
   try
    fbFlag:= fSalesobj.Lines.DoFieldChangewhenDisabled;
    fSalesobj.Lines.DoFieldChangewhenDisabled := true;
    try
      if fSalesobj.Lines.ProductId <> 0 then begin
        fSalesobj.Lines.DEleted := True;
        fSalesobj.Lines.PostDB;
        fSalesobj.Lines.New;
      end;
        fSalesobj.Lines.IsRelatedProduct := true;
        fSalesobj.Lines.ParentProductID := fSalesBase.Lines.ProductId;
        fSalesobj.Lines.RelatedParentLineRef:= fSalesBase.Lines.Globalref;
        fSalesobj.Lines.RelatedProductQty := 1;
        fSalesobj.Lines.ProductId :=  Sender.DataSource.DataSet.FieldByName('PartsID').AsInteger;
        fSalesobj.Lines.ProductNAme :=  Sender.DataSource.DataSet.FieldByName('Productname').asString;
        fSalesobj.Lines.FormulaID := fSalesobj.Lines.Product.FormulaID;
        fSalesobj.Lines.PostDB;

    finally
      fSalesobj.Lines.DoFieldChangewhenDisabled :=fbFlag;
    end;
   finally
    fSalesobj.Lines.Dataset.Enablecontrols;
    Application.ProcessMessages;
    fSalesobj.Lines.Last;
   end;
end;
procedure TFmSalesRelatedProducts.UpdateSalesQty(Const Qty :Double; Sales : TSalesBase);
begin
    if Sales.Lines.UOMQtysold <Qty then begin
      Sales.Lines.UOMQtysold := Qty;
      Sales.Lines.Qtysold := Sales.Lines.UOMQtysold*Sales.Lines.UOMMultiplier;
    end;
    Sales.Lines.UOMQtyShipped  := Qty;
    Sales.Lines.QtyShipped := Sales.Lines.UOMQtyShipped*Sales.Lines.UOMMultiplier;
    Sales.Lines.UOMQtyBackOrder :=   Sales.Lines.UOMQtysold -Sales.Lines.UOMQtyShipped;
    Sales.Lines.QtyBackOrder :=   Sales.Lines.Qtysold -Sales.Lines.QtyShipped;
    Sales.Lines.PostDB;
    (*Sales.Lines.CalcLineTotals;
    Sales.CalcOrdertotals;*)
end;
procedure TFmSalesRelatedProducts.grpListDescriptionClick(Sender: TObject);
begin
  inherited;
  grpDescription.itemindex := grpListDescription.itemindex ;
end;

procedure TFmSalesRelatedProducts.edtUnitofMeasureShippedExit(Sender: TObject);
var
  fdQty:Double;
begin
  inherited;
  try
    //if fSalesbase.lines.UOMQtysold < strTofloat(edtUnitofMeasureShipped.text) then fSalesbase.lines.UOMQtysold  :=  strTofloat(edtUnitofMeasureShipped.text);
    fdQty:= strTofloat(edtUnitofMeasureShipped.text);
    UpdateSalesQty(fdQty , fSalesbase);
  except end;
  edtUnitofMeasureShipped.text := Floattostr(round(fSalesbase.lines.UOMQtyShipped,5));
  (*fdQty :=fSalesobj.lines.FormulaQtyShippedValue *fSalesBase.Lines.uomQtyshipped* fSalesobj.lines.RelatedProductQty;
  UpdateSalesQty(fdQty , fSalesobj);*)
  //fSalesbase.lines.UpdateRelatedPartsQty;
  clog('');
  fSalesbase.lines.PostDB;
  if Assigned(aupodaterelatedProdQty) then aupodaterelatedProdQty(nil);
  edtmainProductname.Refresh;
end;

procedure TFmSalesRelatedProducts.edtUnitofMeasureShippedKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  try
    if isnumber(edtUnitofMeasureShipped.text) then else Key := 0;
  Except
    on E:Exception do begin
      Key := 0;
    end;
  end;
end;

procedure TFmSalesRelatedProducts.exmainproduct(Sender: TObject);
begin
   if Sender is TProductListExpressGUI then
    TProductListExpressGUI(Sender).FilterString := 'PartsId <> ' +   inttostr(fSalesBase.Lines.ProductID);
end;
procedure TFmSalesRelatedProducts.RefreshNavigator;
begin
  navPartPic.visible := true;//navPartPic.datasource.dataset.recordcount>1;
end;
procedure TFmSalesRelatedProducts.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  fSalesobj.lines.Last;
  fSalesobj.lines.New;
  btnChangeProduct.click;
end;

procedure TFmSalesRelatedProducts.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
var
  fdQty :Double;
begin
  inherited;
  {-->} if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_ProductChanged) and (Sender is TSalesLineBase)  then begin
          TSalesLineBase(Sender).IsRelatedProduct := true;
          TSalesLineBase(Sender).ParentProductID := fSalesBase.Lines.ProductId;
          TSalesLineBase(Sender).RelatedParentLineRef:= fSalesBase.Lines.Globalref;
          TSalesLineBase(Sender).RelatedProductQty := 1;
  {-->} end else if (EventType = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterPost) and (Sender is TSalesLineBase)  then begin
          REfreshNavigator;
  {-->} end else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_FormulaValue) then begin
          fdQty := fSalesobj.lines.FormulaQtyShippedValue *fSalesBase.Lines.uomQtyshipped* fSalesBase.Lines.RelatedProductQty;
          UpdateSalesQty(fdQty , fSalesobj);
  {-->} end else if (EventType = BusObjEvent_ToDo) and (Value = BusObjEvent_CheckDescriptionField) and (Sender is TSalesLineBase) then begin
          TSalesLineBase(Sender).RelatedProductFormulaDescriptionUsing := grpDescription.itemindex;
        end;
(*    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TSalesLineBase     then TSalesLineBase(Sender).DataSet := tblDetails;
    end;*)
end;

function TFmSalesRelatedProducts.DoShowSalesRelatedProducts(aSalesBase: TSalesBase; fupodaterelatedProdQty :TNotifyEvent): Boolean;
begin
      REsult := False;
      aupodaterelatedProdQty := fupodaterelatedProdQty ;
      fSalesBase:= aSalesBase;
           if aSalesBase is TInvoice    then fSalesobj := TInvoice.create(self)
      else if aSalesBase is TSalesOrder then fSalesobj := TSalesOrder.create(self)
      else if aSalesBase is TQuote      then fSalesobj := TQuote.create(self)
      else Exit;

      fSalesobj.connection :=aSalesBase.connection;
      fSalesobj.BusObjEvent := DoBusinessObjectEvent;
      fSalesobj.load(aSalesBase.ID);
      if fSalesobj.count =0 then exit;
      fSalesobj.lines.dataset.filter := 'RelatedParentLineRef = ' +quotedstr(aSalesBase.lines.Globalref)+' and Deleted  <> ' +quotedstr('T') ;
      fSalesobj.lines.dataset.filtered := true;

      dsDetails.dataset := aSalesBase.lines.Dataset;
      dsSalesObj.dataset := fSalesobj.lines.Dataset;
      fSalesobj.connection.BeginNestedTransaction;
      try
        Showmodal;
        if modalresult = mrOk then begin
          fSalesobj.connection.CommitNestedTransaction;
          REsult := True;
        end else begin
          fSalesobj.connection.RollbackNestedTransaction;
        end;
      Except
        on E:Exception do begin
          MessageDlgXP_Vista('Changes Made to the Alternate Products are Reverted' + NL + NL+ E.message, mtWarning, [mbOK], 0);
          fSalesobj.connection.RollbackNestedTransaction;
        end;

      end;



end;

procedure TFmSalesRelatedProducts.FormCreate(Sender: TObject);
begin
  inherited;
  aupodaterelatedProdQty := nil;
  TabCtl20.ActivePageIndex  :=0;
  TTabsheet(TabCtl20.pages[0]).Tabvisible := False;
  TTabsheet(TabCtl20.pages[1]).Tabvisible := False;

  //fbTabSettingEnabled := false;
  fiSaleId:= 0;
  fiParentLineId:= 0;
  fConnection:= nil;
  lblProductname.caption := AppEnv.DefaultClass.PartColumn;
end;

procedure TFmSalesRelatedProducts.FormDestroy(Sender: TObject);
begin
  Freeandnil(fSalesobj);
  fSalesBase := nil;
  dsSalesObj.dataset := nil;
  DSDetails.dataset := nil;
  fConnection:= nil;
  inherited;

end;

procedure TFmSalesRelatedProducts.Initfields;
begin
  lblFormula1.caption := AppEnv.Companyprefs.Fe1Name;lblFormula1.visible := AppEnv.Companyprefs.Fe1Visible; edtFormula1.visible := AppEnv.Companyprefs.Fe1Visible;
  lblFormula2.caption := AppEnv.Companyprefs.Fe2Name;lblFormula2.visible := AppEnv.Companyprefs.Fe2Visible; edtFormula2.visible := AppEnv.Companyprefs.Fe2Visible;
  lblFormula3.caption := AppEnv.Companyprefs.Fe3Name;lblFormula3.visible := AppEnv.Companyprefs.Fe3Visible; edtFormula3.visible := AppEnv.Companyprefs.Fe3Visible;
  lblFormula4.caption := AppEnv.Companyprefs.Fe4Name;lblFormula4.visible := AppEnv.Companyprefs.Fe4Visible; edtFormula4.visible := AppEnv.Companyprefs.Fe4Visible;
  lblFormula5.caption := AppEnv.Companyprefs.Fe5Name;lblFormula5.visible := AppEnv.Companyprefs.Fe5Visible; edtFormula5.visible := AppEnv.Companyprefs.Fe5Visible;

  grdTransactions.Selected.Clear;
  grdTransactions.selected.add(SelectedText('ProductName' ,AppEnv.DefaultClass.PartColumn ,15 , '', true));
  pnlsold.visible := chkShippedQtyOnly.Checked;
  pnlBO.visible := chkShippedQtyOnly.Checked;

  if not chkShippedQtyOnly.Checked then begin
          if AppEnv.Companyprefs.Fe1Visible     then grdTransactions.selected.add(SelectedText('FormulaQtySoldValue1' , AppEnv.Companyprefs.Fe1Name ,5 , 'Qty Sold'));
          if AppEnv.Companyprefs.Fe2Visible     then grdTransactions.selected.add(SelectedText('FormulaQtySoldValue2' , AppEnv.Companyprefs.Fe2Name ,5 , 'Qty Sold'));
          if AppEnv.Companyprefs.Fe3Visible     then grdTransactions.selected.add(SelectedText('FormulaQtySoldValue3' , AppEnv.Companyprefs.Fe3Name ,5 , 'Qty Sold'));
          if AppEnv.Companyprefs.Fe4Visible     then grdTransactions.selected.add(SelectedText('FormulaQtySoldValue4' , AppEnv.Companyprefs.Fe4Name ,5 , 'Qty Sold'));
          if AppEnv.Companyprefs.Fe5Visible     then grdTransactions.selected.add(SelectedText('FormulaQtySoldValue5' , AppEnv.Companyprefs.Fe5Name ,5 , 'Qty Sold'));
          if AppEnv.Companyprefs.FeFieldVisible then grdTransactions.selected.add(SelectedText('FormulaQtySoldValue' , 'Rel Qty' ,5 , 'Qty Sold'));
          grdTransactions.selected.add(SelectedText('UnitofMeasureQtySold', 'Qty' ,5 , 'Qty Sold'));
  end;

  if AppEnv.Companyprefs.Fe1Visible then grdTransactions.selected.add(SelectedText('FormulaQtyShippedValue1' , AppEnv.Companyprefs.Fe1Name ,5 , 'Qty Shipped'));
  if AppEnv.Companyprefs.Fe2Visible then grdTransactions.selected.add(SelectedText('FormulaQtyShippedValue2' , AppEnv.Companyprefs.Fe2Name ,5 , 'Qty Shipped'));
  if AppEnv.Companyprefs.Fe3Visible then grdTransactions.selected.add(SelectedText('FormulaQtyShippedValue3' , AppEnv.Companyprefs.Fe3Name ,5 , 'Qty Shipped'));
  if AppEnv.Companyprefs.Fe4Visible then grdTransactions.selected.add(SelectedText('FormulaQtyShippedValue4' , AppEnv.Companyprefs.Fe4Name ,5 , 'Qty Shipped'));
  if AppEnv.Companyprefs.Fe5Visible then grdTransactions.selected.add(SelectedText('FormulaQtyShippedValue5' , AppEnv.Companyprefs.Fe5Name ,5 , 'Qty Shipped'));
  if AppEnv.Companyprefs.FeFieldVisible then grdTransactions.selected.add(SelectedText('FormulaQtyShippedValue' , 'Rel Qty' ,5 , 'Qty Shipped'));
  grdTransactions.selected.add(SelectedText('UnitofMeasureShipped', ' Qty' ,5 , 'Qty Shipped'));

  grdTransactions.selected.add(SelectedText('UnitofMeasureBackorder', 'BO Qty' ,5 , ''));
  grdTransactions.selected.add(SelectedText('RelatedProductProdLine', 'Prod Line' ,5 , ''));
  grdTransactions.selected.add(SelectedText('RelatedProductPatternName', 'Pattern Name' ,10 , ''));
  grdTransactions.selected.add(SelectedText('RelatedProductFormulaDescription', 'Description' ,20 , '', True));


  grdTransactions.ApplySelected;
end;
procedure TFmSalesRelatedProducts.FormShow(Sender: TObject);
var
  fdQty :Double;
begin
  inherited;
  pnlTotals.visible := devmode;
  lblrelUnitofMeasureShipped.visible := devmode;
  edtrelUnitofMeasureShipped.visible := devmode;

  if not GuiPrefs.active then GuiPrefs.active := True;
  if GuiPrefs.Node.Exists('Options.ShippedQtyOnly')     then chkShippedQtyOnly.Checked := GuiPrefs.Node['Options.ShippedQtyOnly'].asBoolean     else chkShippedQtyOnly.Checked := AppEnv.CompanyPrefs.SingleQtySO;
  if GuiPrefs.Node.Exists('Options.ShowList')           then chkShowList.Checked       := GuiPrefs.Node['Options.ShowList'].asBoolean           else chkShowList.Checked       := False;
  if GuiPrefs.Node.Exists('Options.DescriptionOption')  then grpDescription.itemindex  := GuiPrefs.Node['Options.DescriptionOption'].asInteger  else grpDescription.itemindex  := 0;

  //Initfields;

  lblProductname.caption := 'Sale ' + AppEnv.DefaultClass.PartColumn;
  chkShippedQtyOnlyClick(chkShippedQtyOnly);
  chkshowListClick(chkshowList);

  OpenQueries;
  if fSalesbase.lines.UOMQtyShipped  =0 then UpdateSalesQty(1, fSalesbase);
  edtUnitofMeasureShipped.text := Floattostr( round(fSalesbase.lines.UOMQtyShipped ,5));

  fdQty := fSalesobj.lines.FormulaQtyShippedValue *fSalesBase.Lines.uomQtyshipped * fSalesBase.Lines.RelatedProductQty;
  UpdateSalesQty(fdQty , fSalesobj);

  //Self.Height := 400;
  RefreshNavigator;
  Setcontrolfocus(edtUnitofMeasureShipped);
  edtUnitofMeasureShipped.SelectAll;
end;
procedure TFmSalesRelatedProducts.grdTransactionsCalcCellColors(Sender: TObject;Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;ABrush: TBrush);
begin
  inherited;
  AFont.color := clBlack;
  if sametext(Field.Fieldname , 'ProductName' ) then ABrush.color := Inactivefontcolor
  else if sametext(Field.Fieldname , 'FormulaQtySoldValue1' ) or
          sametext(Field.Fieldname , 'FormulaQtySoldValue2'  ) or
          sametext(Field.Fieldname , 'FormulaQtySoldValue3'  ) or
          sametext(Field.Fieldname , 'FormulaQtySoldValue4'  ) or
          sametext(Field.Fieldname , 'FormulaQtySoldValue5'  ) or
          sametext(Field.Fieldname , 'FormulaQtySoldValue'  ) or
          sametext(Field.Fieldname , 'UnitofMeasureQtySold') then ABrush.color := GridColhighLightGreen

  else if sametext(Field.Fieldname , 'FormulaQtyShippedValue1' ) or
          sametext(Field.Fieldname , 'FormulaQtyShippedValue2' ) or
          sametext(Field.Fieldname , 'FormulaQtyShippedValue3' ) or
          sametext(Field.Fieldname , 'FormulaQtyShippedValue4' ) or
          sametext(Field.Fieldname , 'FormulaQtyShippedValue5' ) or
          sametext(Field.Fieldname , 'FormulaQtyShippedValue' ) or
          sametext(Field.Fieldname , 'UnitofMeasureShipped') then ABrush.color := GridColhighLightYellow1
  else if sametext(Field.Fieldname , 'UnitofMeasureBackorder') then ABrush.color := GridColhighLightBlue
  else if sametext(Field.Fieldname , 'RelatedProductFormulaDescription' ) then ABrush.color := Inactivefontcolor;

end;

procedure TFmSalesRelatedProducts.grdTransactionsCalcTitleAttributes(
  Sender: TObject; AFieldName: string; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  inherited;
  AFont.color := clBlack;
  if sametext(AFieldName , 'ProductName' ) then ABrush.color := Inactivefontcolor
  else if sametext(AFieldName , 'FormulaQtySoldValue1' ) or
          sametext(AFieldName , 'FormulaQtySoldValue2'  ) or
          sametext(AFieldName , 'FormulaQtySoldValue3'  ) or
          sametext(AFieldName , 'FormulaQtySoldValue4'  ) or
          sametext(AFieldName , 'FormulaQtySoldValue5'  ) or
          sametext(AFieldName , 'FormulaQtySoldValue'  ) or
          sametext(AFieldName , 'UnitofMeasureQtySold') then ABrush.color := GridColhighLightGreen

  else if sametext(AFieldName , 'FormulaQtyShippedValue1' ) or
          sametext(AFieldName , 'FormulaQtyShippedValue2' ) or
          sametext(AFieldName , 'FormulaQtyShippedValue3' ) or
          sametext(AFieldName , 'FormulaQtyShippedValue4' ) or
          sametext(AFieldName , 'FormulaQtyShippedValue5' ) or
          sametext(AFieldName , 'FormulaQtyShippedValue' ) or
          sametext(AFieldName , 'UnitofMeasureShipped') then ABrush.color := GridColhighLightYellow1
  else if sametext(AFieldName , 'UnitofMeasureBackorder') then ABrush.color := GridColhighLightBlue;

end;

procedure TFmSalesRelatedProducts.grdTransactionsDblClick(Sender: TObject);
begin
  inherited;
{----}if Sysutils.SameText(TField(grdtransactions.GetActiveField).fieldname, 'FormulaQtyShippedValue1') or
                  Sysutils.SameText(TField(grdtransactions.GetActiveField).fieldname, 'FormulaQtyShippedValue2') or
                  Sysutils.SameText(TField(grdtransactions.GetActiveField).fieldname, 'FormulaQtyShippedValue3') or
                  Sysutils.SameText(TField(grdtransactions.GetActiveField).fieldname, 'FormulaQtyShippedValue4') or
                  Sysutils.SameText(TField(grdtransactions.GetActiveField).fieldname, 'FormulaQtyShippedValue5') or
                  Sysutils.SameText(TField(grdtransactions.GetActiveField).fieldname, 'FormulaQtyShippedValue')  then begin
                  if MessageDlgXP_Vista('Do you Wish to Copy the ''Quantity Sold'' Values To the ''Quantity Shipped'' Values?', mtConfirmation, [mbYes, mbNo], 0) = mryes then begin
                     fSalesobj.lines.FormulaQtySoldValue1 := fSalesobj.lines.FormulaQtyShippedValue1;
                     fSalesobj.lines.FormulaQtySoldValue2 := fSalesobj.lines.FormulaQtyShippedValue2;
                     fSalesobj.lines.FormulaQtySoldValue3 := fSalesobj.lines.FormulaQtyShippedValue3;
                     fSalesobj.lines.FormulaQtySoldValue4 := fSalesobj.lines.FormulaQtyShippedValue4;
                     fSalesobj.lines.FormulaQtySoldValue5 := fSalesobj.lines.FormulaQtyShippedValue5;
                     fSalesobj.lines.FormulaQtySoldValue := fSalesobj.lines.FormulaQtyShippedValue;
                  end;
{----}end else if Sysutils.SameText(TField(grdtransactions.GetActiveField).fieldname, 'FormulaQtySoldValue') or
                  Sysutils.SameText(TField(grdtransactions.GetActiveField).fieldname, 'FormulaQtySoldValue2') or
                  Sysutils.SameText(TField(grdtransactions.GetActiveField).fieldname, 'FormulaQtySoldValue3') or
                  Sysutils.SameText(TField(grdtransactions.GetActiveField).fieldname, 'FormulaQtySoldValue4') or
                  Sysutils.SameText(TField(grdtransactions.GetActiveField).fieldname, 'FormulaQtySoldValue5')  then begin
                  if MessageDlgXP_Vista('Do you Wish to Copy the ''Quantity Shipped'' Values To the ''Quantity Sold'' Values?', mtConfirmation, [mbYes, mbNo], 0) = mryes then begin
                     fSalesobj.lines.FormulaQtyShippedValue1 := fSalesobj.lines.FormulaQtySoldValue1;
                     fSalesobj.lines.FormulaQtyShippedValue2 := fSalesobj.lines.FormulaQtySoldValue2;
                     fSalesobj.lines.FormulaQtyShippedValue3 := fSalesobj.lines.FormulaQtySoldValue3;
                     fSalesobj.lines.FormulaQtyShippedValue4 := fSalesobj.lines.FormulaQtySoldValue4;
                     fSalesobj.lines.FormulaQtyShippedValue5 := fSalesobj.lines.FormulaQtySoldValue5;
                     fSalesobj.lines.FormulaQtyShippedValue := fSalesobj.lines.FormulaQtySoldValue;
                  end;
      end;
end;

procedure TFmSalesRelatedProducts.grpDescriptionClick(Sender: TObject);
begin
  inherited;
  GuiPrefs.Node['Options.DescriptionOption'].asInteger:= grpDescription.itemindex;
  fSalesobj.lines.initRelatedProductFormulaDescription;
end;

class function TFmSalesRelatedProducts.ShowSalesRelatedProducts(aSalesBase: TSalesBase; formcolor : TColor ; fupodaterelatedProdQty :TNotifyEvent): Boolean;
var
  form :TFmSalesRelatedProducts;
begin
  REsult := False;
  if aSalesBase.lines.HasRelatedProducts = false then exit;

  form := TFmSalesRelatedProducts.create(nil);
  try
    form.color :=formcolor;
    result := form.DoShowSalesRelatedProducts(aSalesBase , fupodaterelatedProdQty );
  finally
    Freeandnil(form);
  end;



end;

end.
