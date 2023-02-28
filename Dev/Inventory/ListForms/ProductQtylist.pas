unit ProductQtylist;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox, BaseListDetails , pqalib, wwclearbuttongroup, wwradiogroup,
  GIFImg;

type
  TProductQtylistGUI = class(TBaseListDetailsGUI)
    chkQtyOnTransit: TCheckBox;
    qryMainProductName: TWideStringField;
    qryMainPreferedSupplier: TWideStringField;
    qryMainProductPrintName: TWideStringField;
    qryMainMultipleBins: TWideStringField;
    qryMainbatch: TWideStringField;
    qryMainSNTracking: TWideStringField;
    qryMainLandedCost: TFloatField;
    qryMainProductTypeCode: TWideStringField;
    qryMainFirstColumn: TWideStringField;
    qryMainSecondColumn: TWideStringField;
    qryMainThirdColumn: TWideStringField;
    qryMainSalesDescription: TWideStringField;
    qryMainCostIncA: TFloatField;
    qryMainPriceIncA: TFloatField;
    qryMainCostExA: TFloatField;
    qryMainPriceExA: TFloatField;
    qryMainPRODUCTCODE: TWideStringField;
    qryMainTAXCODE: TWideStringField;
    qryMainPurchaseTaxcode: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainPARTSID: TIntegerField;
    qryMainAvgCost: TFloatField;
    qryMainAvailable: TFloatField;
    qryMainInStock: TFloatField;
    qryMainAllocatedSO: TFloatField;
    qryMainAllocatedBO: TFloatField;
    qryMainOnOrder: TFloatField;
    qryMainOnBuild: TFloatField;
    qryMainBuilding: TFloatField;
    qryMainOnTransit: TFloatField;
    qryMainPurchaseDescription: TWideStringField;
    qryMainIncomeAccount: TWideStringField;
    qryMainAssetAccount: TWideStringField;
    qryMainCostofGoodsSoldAccount: TWideStringField;
    qryMainSOBackOrders: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure actRefreshQryExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure chkQtyOnTransitClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure cmdNewClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grpFiltersClick(Sender: TObject);Override;
  private
    Qtytype: Tqtytype;
    fsProductIDs: String;
    function BalanceSheetStockValue: Double;
    procedure ProductDetails;
    procedure beforeshowProductQtyDetails(Sender: TObject);
    procedure ShowOnTransit;
  Protected
    procedure SetDispLabels;Virtual;
    procedure MakeQRYMain;Virtual;
    Procedure RefreshTotals;Override;
    Procedure SetGridColumns;override;
    function ShowQtyOnTransit:Boolean;
    procedure ReadnApplyGuiPrefExtra; override;
    Procedure WriteGuiPrefExtra; override;
    Function ExpressDetailListName:String;Override;
    Function ExtraFields:String; Virtual;
    Function ExtraTables:String; Virtual;
    Function ExtraConditions:String; Virtual;
    Function ExtraGroupings:String; Virtual;
    Function OrderFields:String; Virtual;
  public
    Procedure RefreshQuery;Override;
    Property ProductIDs :String read fsProductIDs write fsProductIDs;
  end;


implementation

uses CommonLib, ProductQtyLib, tcConst, AppEnvironment, BalanceSheetForm, tcDataUtils,
  GuiPrefsObj, SystemLib, AppContextObj, CommonFormLib,
  ProductQtyDetails, ProductQtyOnTransit, ProductMovementList, frmPartsFrm;

{$R *.dfm}
{ TProductQtylistGUI }

procedure TProductQtylistGUI.FormCreate(Sender: TObject);
begin
  inherited;
  if Appenv.CompanyPrefs.ProductClassDefaultAll  then SelectionOption := soClass;
  ProductIDs := '';
end;

procedure TProductQtylistGUI.FormShow(Sender: TObject);
begin
  inherited;
  chkAdvancedPrinting.Visible := False;
  DtFrom.Date := 0;
  Qrymain.first;
  if Appenv.CompanyPrefs.AutoLocateproductinList then
    if GuiPrefs.Node.Exists('Options.PartsID') then
      Qrymain.locate('PartsId',  GuiPrefs.Node['Options.PartsID'].asInteger , []);

  if AppEnv.CompanyPrefs.ProductClassDefaultAll then
  else if Appenv.Employee.DefaultClassID = 0 then
    TimerMsg(FilterLabel, 'The list shows Products of your Default ' + Appenv.DefaultClass.ClassHeading + ' based on the preference. Your Default ' + Appenv.DefaultClass.ClassHeading+' is not selected')
  else
    TimerMsg(FilterLabel, 'The list shows Products of your Default ' + Appenv.DefaultClass.ClassHeading + ' - ' + quotedstr(Appenv.Employee.DefaultClassName) + ' based on the preference');
end;

procedure TProductQtylistGUI.ProductDetails;
begin
  OpenERPListForm('TProductQtyDetailsGUI', beforeshowProductQtyDetails)
end;

procedure TProductQtylistGUI.beforeshowProductQtyDetails(Sender: TObject);
begin
  if sender is TProductQtyDetailsGUI then begin
    TProductQtyDetailsGUI(Sender).productId := qryMainPARTSID.asInteger;
    if not AppEnv.CompanyPrefs.ProductClassDefaultAll then TProductQtyDetailsGUI(Sender).ClassID := appenv.Employee.DefaultClassID else TProductQtyDetailsGUI(Sender).ClassID := 0;
    TProductQtyDetailsGUI(Sender).Qtytype := Qtytype;
  end else if sender is TProductQtyOnTransitGUI then begin
    TProductQtyOnTransitGUI(Sender).ProductId :=qryMainPARTSID.asInteger;
  end;
end;

procedure TProductQtylistGUI.ShowOnTransit;
begin
  OpenERPListForm('TProductQtyOnTransitGUI' , beforeshowProductQtyDetails)
end;

function TProductQtylistGUI.ShowQtyOnTransit: Boolean;
begin
  Result := chkQtyOnTransit.Checked;
end;

procedure TProductQtylistGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not(ShowQtyOnTransit) and Sametext(Field.fieldname , qryMainOnTransit.fieldname) then begin
        ABrush.Color := Inactivefontcolor ;
        AFont.Color := Inactivefontcolor;
  end;
end;

procedure TProductQtylistGUI.grdMainDblClick(Sender: TObject);
Var
  Frm : TComponent;
  Procedure AppcontextClassID;
  begin
    if AppEnv.CompanyPrefs.ProductClassDefaultAll then begin
      AppContext['PartDrillInfo'].IntVar['Department'] := 0;
    end else begin
      AppContext['PartDrillInfo'].IntVar['Department'] := appenv.Employee.DefaultClassID;
    end;
  end;
begin
  if ActiveFieldName ='' then exit;
{------}if Sametext(ActiveFieldName, Qrymainonorder.fieldName) then begin
            SubsequentID := Chr(95) + 'OnOrderRequest';
            AppcontextClassID;
{------}end else if Sametext(ActiveFieldName, qryMainBuilding.fieldName ) then begin
              Qtytype :=tbuilding;
              ProductDetails;
              exit;
{------}end else if Sametext(ActiveFieldName, qryMainOnTransit.fieldName ) then begin
              ShowOnTransit;
              exit;
{------}end else if Sametext(ActiveFieldName,qryMainOnBuild.fieldName ) then begin
              Qtytype :=tonBuild;
              ProductDetails;
              exit;
{------}end else if Sametext(ActiveFieldName, qryMainAllocatedSO.fieldName ) or Sametext(ActiveFieldName, qryMainSOBackOrders.fieldName ) then begin
            SubsequentID := Chr(95) + 'OnSORequest';
            AppcontextClassID;
{------}end else if Sametext(ActiveFieldName,qryMainAllocatedBO.fieldName ) then begin
            SubsequentID := Chr(95) + 'OnBORequest';
            AppcontextClassID;
{------}end else if Sametext(ActiveFieldName, QrymainAvailable.fieldName) or Sametext(ActiveFieldName, qryMainInStock.fieldName) then begin
            ProcessingCursor(True);
            try
              if AppEnv.CompanyPrefs.ProductClassDefaultAll then
                 TProductMovementForm.showList(Self, qryMainPARTSID.asInteger, 0)
              else TProductMovementForm.showList(Self, qryMainPARTSID.asInteger, appenv.Employee.DefaultClassID);
              Exit;
            finally
              ProcessingCursor(False);
            end;
{------}end else begin
            SubsequentID := '';
{------}end;

  inherited;

  if SubsequentID = '' then begin
    frm := FindExistingComponent('TfrmParts');
    if Assigned(frm) then begin
      with TfrmParts(frm) do begin
        DNMPanel10.Height := DNMPanel10.Height + 1;
        pnlMainHeader.Height := pnlMainHeader.Height + 1;
        DNMPanel10.Height := DNMPanel10.Height - 1;
        pnlMainHeader.Height := pnlMainHeader.Height - 1;
      end;
    end;
  end;
end;

procedure TProductQtylistGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Active' , ['T','F','']);
  inherited;
end;

procedure TProductQtylistGUI.actRefreshQryExecute(Sender: TObject);
var
  balancesheet:Tcomponent;
begin
  try
    if devmode then begin
      if not FormStillOpen('TBalanceSheetGUI') then exit;
      balancesheet:= GetComponentByClassName('TBalanceSheetGUI');
      if balancesheet = nil then exit;
      DtTo.Date := TBalanceSheetGUI(balancesheet).FilterDateTo;
    end ;
  finally
    inherited;
  end;

end;

Function TProductQtylistGUI.BalanceSheetStockValue:Double;
var
  balancesheet:Tcomponent;
begin
  result := 0;
  try
    if not FormStillOpen('TBalanceSheetGUI') then exit;
    balancesheet:= GetComponentByClassName('TBalanceSheetGUI');
    if balancesheet = nil then exit;
    With TBalanceSheetGUI(balancesheet).qryMain do begin
      if Locate('ACCNAME' , tcdatautils.GetAccountName(AppEnv.CompanyPrefs.DefPartsAssetAccount) , []) then begin
        REsult := fieldbyname('Column2').AsFloat;
      end;
    end;
  Except
    // kill the exception
  end;
end;
procedure TProductQtylistGUI.chkQtyOnTransitClick(Sender: TObject);
begin
  inherited;
  if Screen.activecontrol = chkQtyOnTransit then RefreshQuery;
end;

procedure TProductQtylistGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfrmParts', 0);
end;

function TProductQtylistGUI.ExpressDetailListName: String;
begin
  result:= 'TProductListExpressGUI';
end;

procedure TProductQtylistGUI.RefreshQuery;
begin
  MakeQrymain;
  inherited;
end;
procedure TProductQtylistGUI.RefreshTotals;
begin
  inherited;
  CalcnShowfooter;
end;

procedure TProductQtylistGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainpartsId.fieldname);
end;

procedure TProductQtylistGUI.MakeQRYMain;
begin
  with qryMain do begin
    Active := False;

    with SQL do begin
      Clear;
      Add('SELECT ');
      Add('P.PARTNAME         AS ProductName, ');
      Add('P.ProductPrintName AS ProductPrintName, ');
      Add('P.MultipleBins     AS MultipleBins,');
      Add('P.batch            AS batch,');
      Add('P.SNTracking       AS SNTracking,');
      Add('LandedCost         AS LandedCost, ');
      Add('P.PARTTYPE         AS ProductTypeCode, ');
      Add(Firstcolumn + '     AS FirstColumn, ');
      Add(Secondcolumn+ '     AS SecondColumn, ');
      Add(Thirdcolumn + '     AS ThirdColumn, ');
      Add('PARTSDESCRIPTION   AS SalesDescription,');
      Add('PURCHASEDESC       AS PurchaseDescription,');
      Add('COSTINC1           AS CostIncA,');
      Add('PRICEINC1          AS PriceIncA,');
      Add('COST1              AS CostExA,');
      Add('PRICE1             AS PriceExA,');
      Add('PRODUCTCODE        AS PRODUCTCODE,');
      Add('P.TAXCODE          AS TAXCODE,');
      Add('PURCHTAXCODE       AS PurchaseTaxcode,');
      Add('P.Active           AS Active,');
      Add('P.PARTSID          AS PARTSID,');
      Add('AvgCost            AS AvgCost,');
      Add('INCOMEACCNT        AS IncomeAccount,');
      Add('ASSETACCNT         AS AssetAccount,');
      Add('COGSACCNT          AS CostofGoodsSoldAccount,');
      Add('P.PREFEREDSUPP     AS PreferedSupplier, ');
      Add(ExtraFields);
      Add('ROUND(IF(P.PARTTYPE = "INV", ' + ProductQtylib.SQL4QtyAsOnDate(filterdateTo, tSOBO) + ',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS SOBackOrders, ');
      if AppEnv.CompanyPrefs.CountSOBOInAvailable  then begin
        Add('ROUND(IF(P.PARTTYPE = "INV",' + ProductQtylib.SQL4QtyAsOnDate(filterdateTo, tAvailable ) + ' - ' +
              ProductQtylib.SQL4QtyAsOnDate(filterdateTo, tSoBo) +', 0.0), ' +  IntToStr(tcConst.GeneralRoundPlaces) + ') AS "Available", ');
      end else Add('Round(IF(P.PARTTYPE = "INV", ' + ProductQtylib.SQL4QtyAsOnDate(filterdateTo, tAvailable ) + ',0.0),' + IntToStr(tcConst.GeneralRoundPlaces) + ') AS "Available",');
      Add( 'ROUND(IF(P.PARTTYPE = "INV",' + ProductQtylib.SQL4QtyAsOnDate(filterdateTo, tInstock)    + ', 0.0), ' + IntToStr(tcConst.GeneralRoundPlaces) + ') AS InStock, ');
      Add( 'ROUND(IF(P.PARTTYPE = "INV",' + ProductQtylib.SQL4QtyAsOnDate(filterdateTo, tSO)         + ', 0.0), ' + IntToStr(tcConst.GeneralRoundPlaces) + ') AS AllocatedSO, ');
      Add( 'ROUND(IF(P.PARTTYPE = "INV",' + ProductQtylib.SQL4QtyAsOnDate(filterdateTo, tInvBO)      + ', 0.0), ' + IntToStr(tcConst.GeneralRoundPlaces) + ') AS AllocatedBO, ');
      Add( 'ROUND(IF(P.PARTTYPE = "INV",' + ProductQtylib.SQL4QtyAsOnDate(filterdateTo, tPOBO)       + ', 0.0), ' + IntToStr(tcConst.GeneralRoundPlaces) + ') AS OnOrder, ');
      Add( 'ROUND(IF(P.PARTTYPE = "INV",' + ProductQtylib.SQL4QtyAsOnDate(filterdateTo, tOnBuild)    + ', 0.0), ' + IntToStr(tcConst.GeneralRoundPlaces) + ') AS OnBuild, ');
      Add( 'ROUND(IF(P.PARTTYPE = "INV",' + ProductQtylib.SQL4QtyAsOnDate(filterdateTo, tBuilding)   + ', 0.0), ' + IntToStr(tcConst.GeneralRoundPlaces) + ') AS Building, ');
      Add('IF(' + Quotedstr(BooleanToStr(ShowQtyOnTransit)) + ' <> "T", 0.0, Round(IFNULL(IF(P.PARTTYPE = "INV",' + pqalib.SQL4QtyField(tOnTransitOUT, 'STPQA', 'STPQA.QTY') +', 0.0),0),' + IntToStr(tcConst.GeneralRoundPlaces)+')) AS "OnTransit" ');
      Add('FROM ' + ProductTables(tProductList));
      Add(ExtraTables);
      Add('WHERE char_length(P.PARTNAME) > 0 AND NOT ISNULL(P.PARTNAME) ');
      if ProductIDs <> '' then Add(' AND P.partsID IN ( ' + ProductIDs+')' );
      if SelectedClassID <> 0 then Add(' AND PC.ClassID = ' + IntToStr(SelectedClassID ));
      Add(ExtraConditions);
      Add('GROUP BY P.PARTSID ' + ExtraGroupings);
      Add(OrderFields);
      RefreshOrignalSQL(False);
    end;
  end;
end;

Function TProductQtylistGUI.ExtraFields:String; begin Result := ''; end;
Function TProductQtylistGUI.ExtraTables:String; begin Result := ''; end;
Function TProductQtylistGUI.ExtraConditions:String; begin Result := ''; end;
Function TProductQtylistGUI.ExtraGroupings:String; begin Result := ''; end;
Function TProductQtylistGUI.OrderFields:String; begin Result := ''; end;

procedure TProductQtylistGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if OrderFields ='' then qryMain.IndexFieldNames := QuotedStr('ProductName') + ' ASC CIS';
  BaseIndexFieldNames := qryMain.IndexFieldNames;
  If ShowQtyOnTransit then begin
    GuiPrefs.DbGridElement[grdMain].AddField(QrymainOnTransit.FieldName);
    QrymainOnTransit.index := Qrymaininstock.index+1;
  end;
  if SelectedClassID <> 0 then begin
    TimerMsg(FilterLabel , 'The list shows Products of ' + Appenv.DefaultClass.ClassHeading+' - '+ quotedstr(tcdatautils.GetClassName(SelectedClassID )));
  end;
  SetDispLabels;

end;
procedure TProductQtylistGUI.SetDispLabels;
var
  s:String;
begin
  inherited;

  if SelectedClassID <> 0 then begin
    s:= tcdatautils.GetClassName(SelectedClassID );
    if s <> '' then begin
      s:= 'Quantity in ' + Quotedstr(s) +' Read As ' +quotedstr(AppEnv.DefaultClass.DefaultUOM);
      if AppEnv.CompanyPrefs.CountSOBOInAvailable  then  s := s + ' - (SO BO Included in Available)'
      else s := s + ' - (SO BO not Counted in Available)';
    end;
  end else begin
    s:= 'Quantity Read As ' +quotedstr(AppEnv.DefaultClass.DefaultUOM) + ' - (SO BO ';
    if AppEnv.CompanyPrefs.CountSOBOInAvailable  then s := s + 'Included In Available)'
    else s := s + 'not Counted in Available)';
  end;

      With TwwDbGridGuiElement(GuiPrefs.DbGridElement[grdMain]) do begin
         FieldGroupname['Available'] := s;
         FieldGroupname['InStock'] := s;
         FieldGroupname['Ontransit'] := s;
         FieldGroupname['AllocatedSO'] := s;
         FieldGroupname['AllocatedBO'] := s;
         FieldGroupname['SOBackOrders'] := s;
         FieldGroupname['OnOrder'] := s;
         FieldGroupname['Building'] := s;
         FieldGroupname['OnBuild'] := s;
         FieldGroupname['Available'] := s;
         FieldGroupName['SOBO'] := s;
         FieldGroupName['RA'] := s;
      end;
end;
procedure TProductQtylistGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if GuiPrefs.Node.Exists('Options.IgnoreDates') then begin
    chkIgnoreDates.Checked := GuiPrefs.Node['Options.IgnoreDates'].asBoolean;
  end;
  if GuiPrefs.Node.Exists('Options.showQtyOnTransit') then begin
    chkQtyOnTransit.Checked := GuiPrefs.Node['Options.showQtyOnTransit'].asBoolean;
  end else begin
    chkQtyOnTransit.Checked := False;
  end;
end;
Procedure TProductQtylistGUI.WriteGuiPrefExtra;
begin
  inherited;
     GuiPrefs.Node['Options.IgnoreDates'].asBoolean     := chkIgnoreDates.Checked;
     GuiPrefs.Node['Options.showQtyOnTransit'].asBoolean:= chkQtyOnTransit.Checked ;
      GuiPrefs.Node['Options.PartsID'].asInteger         := QrymainpartsID.asInteger;
end;


initialization
  RegisterClassOnce(TProductQtylistGUI);

end.

