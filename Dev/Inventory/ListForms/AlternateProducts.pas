unit AlternateProducts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, wwcheckbox,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TAlternateProductsGUI = class(TBaseListingGUI)
    qryMainAlternateProductID: TIntegerField;
    qryMainPartsId: TIntegerField;
    qryMainAlternateProductName: TWideStringField;
    qryMainisdefault: TWideStringField;
    qryMaindescription: TWideStringField;
    qryMainCategory: TLargeintField;
    qryMainInstockQty: TFloatField;
    qryMainPrice1: TFloatField;
    qryMainCost1: TFloatField;
    qryMainPREFEREDSUPP: TWideStringField;
    qryMainDefaultbin: TWideStringField;
    qryMainSupplier: TWideStringField;
    qryMainExtraPriceQuantity: TIntegerField;
    qryMainExtraPrice: TFloatField;
    qryMainForeignPrice: TFloatField;
    qryMainSupplierProductCode: TWideStringField;
    qryMainSupplierProductName: TWideStringField;
    qryMainExtraPriceUOM: TWideStringField;
    qryMainExtraPriceUOMMultiplier: TFloatField;
    qryMainExtraPriceMinimumOrderQty: TFloatField;
    pnlShowExtraForeignPrice: TDNMPanel;
    chkShowExtraForeignPrice: TCheckBox;
    btnMakeAltProducts: TDNMSpeedButton;
    qryMainPartname: TWideStringField;
    qryMainExtraPriceID: TLargeintField;
    qryMainSalesdescription: TWideStringField;
    qryMainPurchasedescription: TWideStringField;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure chkShowExtraForeignPriceClick(Sender: TObject);
    procedure btnMakeAltProductsClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); Override;
    procedure FormDestroy(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);
    procedure mnuFilterPopup(Sender: TObject);
  private
    mnuMakeAltProducts1 , mnuMakeAltProducts2 : TMenuItem;
    mainProductID: Integer;
    fsTablename1 :String;
    fiProductId: Integer;
    fiClasId: Integer;
    procedure SetProductID(const Value: Integer);
    procedure SetclassId(const Value: Integer);
    procedure ExcludeMainProductIdfromOtherProducts(var OtherProductIDs: String);
    procedure BeforeAlternateProductSearch(Sender: TObject);
  Protected
    fsTablename :String;
    procedure SetGridColumns; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    Procedure AfterFormShow; Override;
    Procedure MakeQrymain;virtual;
    Procedure initPopupmenu;Override;
    procedure AfterPopup(Popupform:TComponent);Override;
    Procedure PopulateData;
  public
    Procedure RefreshQuery;Override;
    Property ProductId :Integer read fiProductId write SetProductID;
    Property ClassId:Integer read fiClasId Write SetclassId;
  end;

implementation

uses CommonLib, tcConst, ProductQtyLib, LogLib, PQALib ,
  BaseListLib, DbSharedObjectsObj, CommonDbLib, UserLockBaseObj, tcDataUtils,
  frmPartsFrm, AlternateProductsEBP, CommonFormLib, AlternateProductSearch,
  AppEnvironment;

{$R *.dfm}
{ TAlternateProductsGUI }

procedure TAlternateProductsGUI.AfterFormShow;
begin
  inherited;
  //chkShowExtraForeignPriceclick(chkShowExtraForeignPrice);
end;
Procedure TAlternateProductsGUI.ExcludeMainProductIdfromOtherProducts(Var OtherProductIDs:String);
var
  qry: TERPQuery;
begin
  if OtherProductIDs = '' then exit;

  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    qry.SQL.text := 'Select distinct partsId from tblparts where partsId in (' + OtherProductIDs +') and PartsID<> ' + inttostr(mainProductID);
    qry.open;
    OtherProductIDs := qry.groupconcat('partsId');
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;

end;
procedure TAlternateProductsGUI.AfterPopup(Popupform: TComponent);
begin
  inherited;
  if Popupform is TfrmParts then begin
    TfrmParts(Popupform).Pagecontrol.ActivePage:= TfrmParts(Popupform).Extra_Buy_Price;
    if (qryMainCategory.asInteger <> 4 ) and (qryMainExtraPriceID.AsInteger <> 0) then begin
      SetControlFocus(TfrmParts(Popupform).grdBuyPrice);
      TfrmParts(Popupform).qryExtraBuyPrice.Locate('ExtraPartPriceID' ,qryMainExtraPriceID.AsInteger , [] );
    end;
  end;

end;

procedure TAlternateProductsGUI.btnMakeAltProductsClick(Sender: TObject);
var
  OtherProductIDs:String;
  fi:Integer;
  mainProductName:String;
begin
  inherited;
  mainProductID:= QrymainpartsID.asInteger;
  mainProductName:= Qrymainpartname.asString;

  if SelectedRecords<= 1 then begin
    MessageDlgXP_Vista('Please Select the Main Product and Other Products to Link as Alternate Products', mtInformation, [mbOK], 0);
    Exit;
  end;

  if Userlock.lock('tblparts', mainProductID) =false then begin
    MessageDlgXP_Vista(TRIM(CustomiseLockMessage(Userlock.LockMessage , ['Unable to update data.' + #13#10 ,'accessing this record','Record has been in use'],
                                                                   ['Unable to add Alternate Products for '+quotedstr(Qrymainpartname.asString), 'Accessing this Product','Product has been in Use'])),
                        mtWarning, [mbOK], 0);

    Exit;
  end;
  try
    OtherProductIDs:= SelectedIDs('PartsId' , True);
    if OtherProductIDs <> '' then ExcludeMainProductIdfromOtherProducts(OtherProductIDs);

    if OtherProductIDs = '' then begin
      MessageDlgXP_Vista('You have only Selected the Main Product ' + quotedstr(mainProductName)+'.'+NL+NL+'Please Select Other Products to Link as Alternate Products.', mtInformation, [mbOK], 0);
      Exit;
    end;
    if MessageDlgXP_vista('Do you wish to Add all the selected Products to '+ quotedstr(mainProductName)+' as Alternate Products?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;
    with ScriptMainInTrans do try
      SQL.clear;
      SQL.Add('INSERT IGNORE INTO tblPartsAlternate (ProductID , ProductName , AlternateProductID , AlternateProductName , AlternateProductPrintName) Select '+ inttostr(mainProductID)+' as ProductId, '+
                        quotedstr(mainProductName)+' as ProductName , '+
                        ' PartsId as AlternateProductID ,  '+
                        ' Partname as AlternateProductName ,  '+
                        ' ProductPrintName as AlternateProductPrintName  '+
                        ' from tblparts  '+
                        ' where partsId in (' +OtherProductIDs+')  '+
                        ' and PartsId <> '+ inttostr(mainProductID));
      showProgressbar(WAITMSG, SQL.count);
      try
        ScriptMainBeginTrans;
        try
          clog(SQL.Text);
          fi:= Recordcount('tblPartsAlternate');
          Execute;
          ScriptMainCommit;
          grdmain.unselectall;
          HideProgressbar;
          MessageDlgXP_Vista(inttostr(Recordcount('tblPartsAlternate') - fi) + ' Link(s) are Created for ' + quotedstr(mainProductName)+'.', mtInformation, [mbOK], 0);
        Except
            on E:Exception do begin
                ScriptMainrollback;
            end;
        end;
      finally
        HideProgressbar;
        UserLock.UnlockAllCurrentInstance;
      end;
    finally
      ScrptMainCleanConn;
    end;
  finally
    Userlock.UnlockAllCurrentInstance;
  end;
end;

procedure TAlternateProductsGUI.chkShowExtraForeignPriceClick(Sender: TObject);
begin
  inherited;
  if not IsFormshown then exit;
  if chkShowExtraForeignPrice.checked then begin
    GuiPrefs.DbGridElement[grdmain].AddField(qryMainSupplier.FieldName);
    GuiPrefs.DbGridElement[grdmain].AddField(qryMainExtraPriceQuantity.FieldName);
    GuiPrefs.DbGridElement[grdmain].AddField(qryMainExtraPrice.FieldName);
    GuiPrefs.DbGridElement[grdmain].AddField(qryMainForeignPrice.FieldName);
    GuiPrefs.DbGridElement[grdmain].AddField(qryMainSupplierProductCode.FieldName);
    GuiPrefs.DbGridElement[grdmain].AddField(qryMainSupplierProductName.FieldName);
    GuiPrefs.DbGridElement[grdmain].AddField(qryMainExtraPriceUOM.FieldName);
    GuiPrefs.DbGridElement[grdmain].AddField(qryMainExtraPriceUOMMultiplier.FieldName);
    GuiPrefs.DbGridElement[grdmain].AddField(qryMainExtraPriceMinimumOrderQty.FieldName);
  end else begin
    grdmain.RemoveField(qryMainSupplier.FieldName);
    grdmain.RemoveField(qryMainExtraPriceQuantity.FieldName);
    grdmain.RemoveField(qryMainExtraPrice.FieldName);
    grdmain.RemoveField(qryMainForeignPrice.FieldName);
    grdmain.RemoveField(qryMainSupplierProductCode.FieldName);
    grdmain.RemoveField(qryMainSupplierProductName.FieldName);
    grdmain.RemoveField(qryMainExtraPriceUOM.FieldName);
    grdmain.RemoveField(qryMainExtraPriceUOMMultiplier.FieldName);
    grdmain.RemoveField(qryMainExtraPriceMinimumOrderQty.FieldName);
  end;
end;

procedure TAlternateProductsGUI.FormCreate(Sender: TObject);
begin
  fstablename := commondblib.GetUserTemporaryTableName('Stock');
  fsTablename1:= fstablename +'1';
  MakeQrymain;
  inherited;

  fiProductId:=0;
  fiClasId:=0;

  if classnameis('TAlternateProductsGUI')  or classnameis('TAlternateProductsEBPGUI')  then EnableMultiSelect('');
  //Populatedata;
  HaveDateRangeSelection := False;
end;

procedure TAlternateProductsGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fstablename);
  DestroyUserTemporaryTable(fsTablename1);
  inherited;
end;

procedure TAlternateProductsGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if QrymainIsDefault.asBoolean and (Qrymaincategory.asInteger = 1) then
    if sametext(Field.fieldname ,qrymainDescription.fieldname) then else
      ABrush.Color:= GridColhighLightGreen;

  if sametext(Field.fieldname ,qrymainDescription.fieldname) then
    AFont.style :=AFont.style  +[fsBold];
end;

procedure TAlternateProductsGUI.grdMainDblClick(Sender: TObject);
begin
  if classnameis('TAlternateProductsGUI')  or classnameis('TAlternateProductsEBPGUI')  then
    if sametext(Activefieldname, qrymaindescription.fieldname) or sametext(Activefieldname, qrymainPartname.fieldname) or sametext(Activefieldname, qrymainAlternateProductName.fieldname)   then begin
      OpenERPListForm('TAlternateProductSearchGUI' , BeforeAlternateProductSearch);;
      exit;
    end;
  inherited;
end;
procedure TAlternateProductsGUI.BeforeAlternateProductSearch(Sender: TObject);
begin
   if sender is TAlternateProductSearchGUI then begin
      TAlternateProductSearchGUI(Sender).productId := qrymainpartsID.asInteger;
      TAlternateProductSearchGUI(Sender).Classid := Appenv.DefaultClass.ClassID;
   end;
end;
procedure TAlternateProductsGUI.grpFiltersClick(Sender: TObject);
begin
  // checking for the caption of the item as the inherited form has a different set
  if grpfilters.itemindex <0 then exit;
       if sametext(grpfilters.items[grpfilters.itemindex]  , 'Extra Buy Prices')  then groupfilterstring := 'Category = 1 or Category = 4'
  else if sametext(grpfilters.items[grpfilters.itemindex]  , 'Foreign Buy Price') then groupfilterstring := 'Category = 2 or Category = 5'
  else if sametext(grpfilters.items[grpfilters.itemindex]  , 'No Extra Price')    then groupfilterstring := 'Category = 3 or Category = 6'
  else groupfilterstring := '';
  inherited;
end;

procedure TAlternateProductsGUI.initPopupmenu;
begin
  inherited;
  if classnameis('TAlternateProductsGUI')  or classnameis('TAlternateProductsEBPGUI')  then
      BaseListLib.NewMenuItem(self,btnMakeAltProducts.caption,true,btnMakeAltProducts.onclick,mnuMakeAltProducts1,mnuMakeAltProducts2);
end;

procedure TAlternateProductsGUI.MakeQrymain;
begin
    closedb(qrymain);
    qrymain.SQL.clear;


{1: Alternate products with Extra buy Price}
    qrymain.SQL.add('select ');
    qrymain.SQL.add('1'                                                 + ' as Category , ');
    qrymain.SQL.add('P.partsId'                                         + ' as PartsId,');
    qrymain.SQL.add('P.Partname'                                        + ' as Partname,');
    qrymain.SQL.add('TP.Salesdescription'                               + ' as Salesdescription,');
    qrymain.SQL.add('TP.Purchasedescription'                            + ' as Purchasedescription,');
    qrymain.SQL.add('concat(AP.ProductName, "''s Alternate Products")'  + ' as description, ');
    qrymain.SQL.add('AP.AlternateProductID'                             + ' as AlternateProductID, ');
    qrymain.SQL.add('AP.AlternateProductName'                           + ' as AlternateProductName, ');
    qrymain.SQL.add('AP.isdefault '                                     + ' as isdefault, ');
    qrymain.SQL.add('CL.company'                                        + ' as Supplier,');
    qrymain.SQL.add('convert(ifnull(EP.ExtraPartPriceID,0), unsigned) ' + ' as ExtraPriceID	,');
    qrymain.SQL.add('EP.Buy1'                                           + ' as ExtraPriceQuantity,');
    qrymain.SQL.add('EP.Price'                                          + ' as ExtraPrice,');
    qrymain.SQL.add('convert(NULL, DECIMAL)'                            + ' as ForeignPrice,');
    qrymain.SQL.add('EP.SupplierProductCode'                            + ' as SupplierProductCode,');
    qrymain.SQL.add('EP.SupplierProductName'                            + ' as SupplierProductName,');
    qrymain.SQL.add('concat(EP.UOM, "(" , EP.UOMMultiplier, ")")'       + ' as ExtraPriceUOM,');
    qrymain.SQL.add('EP.UOMMultiplier'                                  + ' as ExtraPriceUOMMultiplier,');
    qrymain.SQL.add('EP.MinimumOrderQty'                                + ' as ExtraPriceMinimumOrderQty  ,');
    qrymain.SQL.add('TP.instockQty'                                     + ' as instockQty, ');
    qrymain.SQL.add('P.Price1'                                          + ' as Price1,');
    qrymain.SQL.add('P.Cost1'                                           + ' as Cost1,');
    qrymain.SQL.add('P.PREFEREDSUPP'                                    + ' as PREFEREDSUPP,');
    qrymain.SQL.add('TP.Defaultbin'                                     + ' as Defaultbin');
    qrymain.SQL.add('from ' + fsTablename1 +' TP inner join tblparts P on TP.partsId = P.partsID ');
    qrymain.SQL.add('inner join tblpartsalternate  AP on AP.AlternateProductID = P.PARTSID ');
    qrymain.SQL.add('inner join tblextraprice EP on EP.PartsID = P.partsId');
    qrymain.SQL.add('inner join tblclients CL on EP.SupplierID = CL.clientID');
    qrymain.SQL.add('Where P.Active <> "F" ');
    qrymain.SQL.add('UNION ALL  ');

   if self is TAlternateProductsEBPGUI then begin
{2: Alternate products with foreign buy Price}
    qrymain.SQL.add('select ');
    qrymain.SQL.add('2'                                               + ' as Category , ');
    qrymain.SQL.add('P.partsId'                                       + ' as PartsId,');
    qrymain.SQL.add('P.Partname'                                      + ' as Partname,');
    qrymain.SQL.add('TP.Salesdescription'                             + ' as Salesdescription,');
    qrymain.SQL.add('TP.Purchasedescription'                          + ' as Purchasedescription,');
    qrymain.SQL.add('concat(AP.ProductName, "''s Alternate Products")'+ ' as description, ');
    qrymain.SQL.add('AP.AlternateProductID'                           + ' as AlternateProductID, ');
    qrymain.SQL.add('AP.AlternateProductName'                         + ' as AlternateProductName, ');
    qrymain.SQL.add('AP.isdefault '                                   + ' as isdefault, ');
    qrymain.SQL.add('CL.company'                                      + ' as Supplier,');
    qrymain.SQL.add('convert(ifnull(FP.ForeignPriceID,0), unsigned) ' + ' as ExtraPriceID	,');
    qrymain.SQL.add('FP.Buy1'                                         + ' as ExtraPriceQuantity,');
    qrymain.SQL.add('NULL'                                            + ' as ExtraPrice,');
    qrymain.SQL.add('FP.Price1'                                       + ' as ForeignPrice,');
    qrymain.SQL.add('FP.SupplierProductCode'                          + ' as SupplierProductCode,');
    qrymain.SQL.add('FP.SupplierProductName'                          + ' as SupplierProductName,');
    qrymain.SQL.add('concat(FP.UOM, "(" , FP.UOMMultiplier, ")")'     + ' as ExtraPriceUOM,');
    qrymain.SQL.add('FP.UOMMultiplier'                                + ' as ExtraPriceUOMMultiplier,');
    qrymain.SQL.add('NULL'                                            + ' as ExtraPriceMinimumOrderQty  ,');
    qrymain.SQL.add('TP.instockQty'                                   + ' as instockQty, ');
    qrymain.SQL.add('P.Price1'                                        + ' as Price1,');
    qrymain.SQL.add('P.Cost1'                                         + ' as Cost1,');
    qrymain.SQL.add('P.PREFEREDSUPP'                                  + ' as PREFEREDSUPP,');
    qrymain.SQL.add('TP.Defaultbin'                                   + ' as Defaultbin');
    qrymain.SQL.add('from ' + fsTablename1 +' TP inner join tblparts P on TP.partsId = P.partsID ');
    qrymain.SQL.add('inner join tblpartsalternate  AP on AP.AlternateProductID = P.PARTSID ');
    qrymain.SQL.add('inner  join tblforeignprice FP on FP.PartsId = P.PartsId');
    qrymain.SQL.add('Left join tblclients CL on FP.clientID = CL.clientID');
    qrymain.SQL.add('inner  join tblcurrencyconversion CC on CC.CurrencyID = FP.CurrencyID');
    qrymain.SQL.add('Where P.Active <> "F" ');
    qrymain.SQL.add('UNION ALL  ');
   end;
{3: Alternate products with no Extra buy Price}
    qrymain.SQL.add('select ');
    qrymain.SQL.add('3'                                               + ' as Category , ');
    qrymain.SQL.add('P.partsId'                                       + ' as PartsId,');
    qrymain.SQL.add('P.Partname'                                      + ' as Partname,');
    qrymain.SQL.add('TP.Salesdescription'                               + ' as Salesdescription,');
    qrymain.SQL.add('TP.Purchasedescription'                            + ' as Purchasedescription,');
    qrymain.SQL.add('concat(AP.ProductName, "''s Alternate Products")'+ ' as description, ');
    qrymain.SQL.add('AP.AlternateProductID'                           + ' as AlternateProductID, ');
    qrymain.SQL.add('AP.AlternateProductName'                         + ' as AlternateProductName, ');
    qrymain.SQL.add('AP.isdefault '                                   + ' as isdefault, ');
    qrymain.SQL.add('null'                                            + ' as Supplier,');
    qrymain.SQL.add('NULL'                                            + ' as ExtraPriceID	,');
    qrymain.SQL.add('NULL'                                            + ' as ExtraPriceQuantity,');
    qrymain.SQL.add('NULL'                                            + ' as ExtraPrice,');
    qrymain.SQL.add('convert(NULL, DECIMAL)'                          + ' as ForeignPrice,');
    qrymain.SQL.add('NULL'                                            + ' as SupplierProductCode,');
    qrymain.SQL.add('NULL'                                            + ' as SupplierProductName,');
    qrymain.SQL.add('NULL'                                            + ' as ExtraPriceUOM,');
    qrymain.SQL.add('NULL'                                            + ' as ExtraPriceUOMMultiplier,');
    qrymain.SQL.add('NULL'                                            + ' as ExtraPriceMinimumOrderQty  ,');
    qrymain.SQL.add('TP.instockQty'                                   + ' as instockQty, ');
    qrymain.SQL.add('P.Price1'                                        + ' as Price1,');
    qrymain.SQL.add('P.Cost1'                                         + ' as Cost1,');
    qrymain.SQL.add('P.PREFEREDSUPP'                                  + ' as PREFEREDSUPP,');
    qrymain.SQL.add('TP.Defaultbin'                                   + ' as Defaultbin');
    qrymain.SQL.add('from ' + fsTablename1 +' TP inner join tblparts P on TP.partsId = P.partsID ');
    qrymain.SQL.add('inner join tblpartsalternate  AP on AP.AlternateProductID = P.PARTSID ');
    qrymain.SQL.add('Left join tblextraprice EP on EP.PartsID = P.partsId');
    if self is TAlternateProductsEBPGUI then qrymain.SQL.add('Left  join tblforeignprice FP on FP.PartsId = P.PartsId');
    qrymain.SQL.add('Where P.Active <> "F" ');
    qrymain.SQL.add('and ifnull(EP.ExtraPartPriceID,0)=0 ');
    if self is TAlternateProductsEBPGUI then qrymain.SQL.add('and ifnull(FP.ForeignPriceID,0)=0  ');
    qrymain.SQL.add('and P.IsSystemProduct ="F"');
    qrymain.SQL.add('UNION ALL  ');
{4: NO Alternate product, but with Extra buy Price}
    qrymain.SQL.add('select ');
    qrymain.SQL.add('4'                                               + ' as Category , ');
    qrymain.SQL.add('P.partsId'                                       + ' as PartsId,');
    qrymain.SQL.add('P.Partname'                                      + ' as Partname,');
    qrymain.SQL.add('P.partname'                                      + ' as description, ');
    qrymain.SQL.add('TP.Salesdescription'                               + ' as Salesdescription,');
    qrymain.SQL.add('TP.Purchasedescription'                            + ' as Purchasedescription,');
    qrymain.SQL.add('NULL'                                            + ' as AlternateProductID, ');
    qrymain.SQL.add('NULL'                                            + ' as AlternateProductName, ');
    qrymain.SQL.add('"F"'                                             + ' as isdefault, ');
    qrymain.SQL.add('CL.company'                                      + ' as Supplier,');
    qrymain.SQL.add('convert(ifnull(EP.ExtraPartPriceID,0), unsigned)'+ ' as ExtraPriceID	,');
    qrymain.SQL.add('EP.Buy1'                                         + ' as ExtraPriceQuantity,');
    qrymain.SQL.add('EP.Price'                                        + ' as ExtraPrice,');
    qrymain.SQL.add('NULL '                                           + ' as ForeignPrice,');
    qrymain.SQL.add('EP.SupplierProductCode'                          + ' as SupplierProductCode,');
    qrymain.SQL.add('EP.SupplierProductName'                          + ' as SupplierProductName,');
    qrymain.SQL.add('concat(EP.UOM, "(" , EP.UOMMultiplier, ")")'     + ' as ExtraPriceUOM,');
    qrymain.SQL.add('EP.UOMMultiplier'                                + ' as ExtraPriceUOMMultiplier,');
    qrymain.SQL.add('EP.MinimumOrderQty'                              + ' as ExtraPriceMinimumOrderQty  ,');
    qrymain.SQL.add('TP.instockQty'                                   + ' as instockQty, ');
    qrymain.SQL.add('P.Price1'                                        + ' as Price1,');
    qrymain.SQL.add('P.Cost1'                                         + ' as Cost1,');
    qrymain.SQL.add('P.PREFEREDSUPP'                                  + ' as PREFEREDSUPP,');
    qrymain.SQL.add('TP.Defaultbin'                                   + ' as Defaultbin');
    qrymain.SQL.add('from ' + fsTablename1 +' TP inner join tblparts P on TP.partsId = P.partsID ');
    qrymain.SQL.add('Left join tblpartsalternate  AP on AP.AlternateProductID = P.PARTSID ');
    qrymain.SQL.add('inner join tblextraprice EP on EP.PartsID = P.partsId');
    qrymain.SQL.add('inner join tblclients CL on EP.SupplierID = CL.clientID');
    qrymain.SQL.add('Where P.Active <> "F" and ifnull(AP.ID,0)=0 and P.IsSystemProduct ="F"  ');
    qrymain.SQL.add('UNION ALL  ');

   if self is TAlternateProductsEBPGUI then begin
{4: NO Alternate product, but with foreign buy Price}
    qrymain.SQL.add('select ');
    qrymain.SQL.add('5'                                             + ' as Category , ');
    qrymain.SQL.add('P.partsId'                                     + ' as PartsId,');
    qrymain.SQL.add('P.Partname'                                    + ' as Partname,');
    qrymain.SQL.add('TP.Salesdescription'                               + ' as Salesdescription,');
    qrymain.SQL.add('TP.Purchasedescription'                            + ' as Purchasedescription,');
    qrymain.SQL.add('P.partname'                                    + ' as description, ');
    qrymain.SQL.add('NULL'                                          + ' as AlternateProductID, ');
    qrymain.SQL.add('NULL'                                          + ' as AlternateProductName, ');
    qrymain.SQL.add('"F"'                                           + ' as isdefault, ');
    qrymain.SQL.add('CL.company'                                    + ' as Supplier,');
    qrymain.SQL.add('convert(ifnull(FP.ForeignPriceID,0), unsigned)'+ ' as ExtraPriceID	,');
    qrymain.SQL.add('FP.Buy1'                                       + ' as ExtraPriceQuantity,');
    qrymain.SQL.add('Null'                                          + ' as ExtraPrice,');
    qrymain.SQL.add('FP.Price1'                                     + ' as ForeignPrice,');
    qrymain.SQL.add('FP.SupplierProductCode'                        + ' as SupplierProductCode,');
    qrymain.SQL.add('FP.SupplierProductName'                        + ' as SupplierProductName,');
    qrymain.SQL.add('concat(FP.UOM, "(" , FP.UOMMultiplier, ")")'   + ' as ExtraPriceUOM,');
    qrymain.SQL.add('FP.UOMMultiplier'                              + ' as ExtraPriceUOMMultiplier,');
    qrymain.SQL.add('NULL'                                          + ' as ExtraPriceMinimumOrderQty  ,');
    qrymain.SQL.add('TP.instockQty'                                 + ' as instockQty, ');
    qrymain.SQL.add('P.Price1'                                      + ' as Price1,');
    qrymain.SQL.add('P.Cost1'                                       + ' as Cost1,');
    qrymain.SQL.add('P.PREFEREDSUPP'                                + ' as PREFEREDSUPP,');
    qrymain.SQL.add('TP.Defaultbin'                                 + ' as Defaultbin');
    qrymain.SQL.add('from ' + fsTablename1 +' TP inner join tblparts P on TP.partsId = P.partsID ');
    qrymain.SQL.add('Left join tblpartsalternate  AP on AP.AlternateProductID = P.PARTSID ');
    qrymain.SQL.add('inner  join tblforeignprice FP on FP.PartsId = P.PartsId');
    qrymain.SQL.add('Left join tblclients CL on FP.clientID = CL.clientID');
    qrymain.SQL.add('inner  join tblcurrencyconversion CC on CC.CurrencyID = FP.CurrencyID');
    qrymain.SQL.add('Where P.Active <> "F"  and ifnull(AP.ID,0)=0 and P.IsSystemProduct ="F"  ');
    qrymain.SQL.add('UNION ALL  ');
   end;
{4: NO Alternate product, Extra buy Price or foreign price}
    qrymain.SQL.add('select ');
    qrymain.SQL.add('6'                      + ' as Category , ');
    qrymain.SQL.add('P.partsId'              + ' as PartsId,');
    qrymain.SQL.add('P.Partname'             + ' as Partname,');
    qrymain.SQL.add('TP.Salesdescription'                               + ' as Salesdescription,');
    qrymain.SQL.add('TP.Purchasedescription'                            + ' as Purchasedescription,');
    qrymain.SQL.add('P.partname'             + ' as description, ');
    qrymain.SQL.add('NULL'                   + ' as AlternateProductID, ');
    qrymain.SQL.add('NULL'                   + ' as AlternateProductName, ');
    qrymain.SQL.add('"F"'                    + ' as isdefault, ');
    qrymain.SQL.add('NULL'                   + ' as Supplier,');
    qrymain.SQL.add('NULL '                  + ' as ExtraPriceID	,');
    qrymain.SQL.add('NULL'                   + ' as ExtraPriceQuantity,');
    qrymain.SQL.add('NULL'                   + ' as ExtraPrice,');
    qrymain.SQL.add('convert(NULL, DECIMAL)' + ' as ForeignPrice,');
    qrymain.SQL.add('NULL'                   + ' as SupplierProductCode,');
    qrymain.SQL.add('NULL'                   + ' as SupplierProductName,');
    qrymain.SQL.add('NULL'                   + ' as ExtraPriceUOM,');
    qrymain.SQL.add('NULL'                   + ' as ExtraPriceUOMMultiplier,');
    qrymain.SQL.add('NULL'                   + ' as ExtraPriceMinimumOrderQty  ,');
    qrymain.SQL.add('TP.instockQty'          + ' as instockQty, ');
    qrymain.SQL.add('P.Price1'               + ' as Price1,');
    qrymain.SQL.add('P.Cost1'                + ' as Cost1,');
    qrymain.SQL.add('P.PREFEREDSUPP'         + ' as PREFEREDSUPP,');
    qrymain.SQL.add('TP.Defaultbin'          + ' as Defaultbin');
    qrymain.SQL.add('from ' + fsTablename1 +' TP inner join tblparts P on TP.partsId = P.partsID ');
    qrymain.SQL.add('Left join tblpartsalternate  AP on AP.AlternateProductID = P.PARTSID ');
    qrymain.SQL.add('Left join tblextraprice EP on EP.PartsID = P.partsId');
    if self is TAlternateProductsEBPGUI then qrymain.SQL.add('Left  join tblforeignprice FP on FP.PartsId = P.PartsId');
    qrymain.SQL.add('Where P.Active <> "F"  ');
    qrymain.SQL.add('and ifnull(AP.ID,0)=0 ');
    qrymain.SQL.add('and ifnull(EP.ExtraPartPriceID,0)=0 ');
    if self is TAlternateProductsEBPGUI then qrymain.SQL.add('and ifnull(FP.ForeignPriceID,0)=0  ');
    qrymain.SQL.add('and P.IsSystemProduct ="F"');
    qrymain.SQL.add('Order by description, Partname, Category  , AlternateProductName, Supplier');
    clog(Qrymain.sql.text);
end;

procedure TAlternateProductsGUI.mnuFilterPopup(Sender: TObject);
begin
  inherited;
  try
      mnuMakeAltProducts1.visible := SelectedRecords>1;
      mnuMakeAltProducts2.visible := SelectedRecords>1;
    if Qrymainpartname.asString <> '' then
      mnuMakeAltProducts2.caption := 'Link Selected Products as Alternate Products for ' + quotedstr(Qrymainpartname.asString);
  except

  end;

end;

procedure TAlternateProductsGUI.PopulateData;
(*function ProductnClassfilter:String;
begin
  result := '';
  if ProductID<>0 then result := 'P.partsId = ' + inttostr(ProductID);
  if classid <> 0 then begin
    if result <> '' then result := result +' and ';
    result := result + ' pqa.DepartmentID =' + inttostr(classid);
  end;
  if result <> '' then result := ' where ' + result;
end;*)
begin
  With Scriptmain do begin
    SQL.clear;
    SQL.add('Drop table if exists '+ fsTablename +';');
    SQL.add('CREATE TABLE  '+ fsTablename +' ( ' +
            ' ID INT(11) NOT NULL AUTO_INCREMENT, ' +
            ' partsId INT(11) NULL DEFAULT 0, ' +
            ' partname varchar(255) null default "", '+
            ' Classname varchar(255) null default "", '+
            ' classId int(11) null Default 0, '+
            ' Defaultbin VARCHAR(61) NULL DEFAULT NULL, ' +
            ' InstockQty DOUBLE(22,5) NULL DEFAULT NULL, ' +
            ' PRIMARY KEY (ID), ' +
            ' INDEX allidx (partsId, classId) ) COLLATE="utf8_general_ci" ENGINE=Myisam; ' );

    SQL.add('insert ignore into '+ fsTablename +' ( PartsID , classId, partname, classname, Defaultbin  , InstockQty) '+
            ' Select P.partsId, PQA.departmentId,  P.partname, c.classname, '+
            ' concat(PB.BinLocation , "-" , PB.BinNumber) as Defaultbin, '+
            ProductQtyLib.SQL4Qty(tInStock) + ' as InstockQty  '+
            ' from '+ replacestr(ProductTables(tSummary) , 'inner join' , 'Left join') +
            ' Left join tblproductbin PB on PB.BinID = PC.DefaultbinId '+
            ' Group by P.partsId, PQA.departmentId;');

    SQL.add('Drop table if exists '+ fsTablename1 +';');
    SQL.add('CREATE TABLE  '+ fsTablename1 +' ( ' +
            ' ID INT(11) NOT NULL AUTO_INCREMENT, ' +
            ' partsId INT(11) NULL DEFAULT 0, ' +
            ' partname varchar(255) null default "", '+
            ' salesDESCRIPTION varchar(255) default "", ' +
            ' PurchaseDESCRIPTION varchar(255) default "", ' +
            ' Defaultbin VARCHAR(61) NULL DEFAULT NULL, ' +
            ' InstockQty DOUBLE(22,5) NULL DEFAULT NULL, ' +
            ' PRIMARY KEY (ID), ' +
            ' INDEX allidx (partsId) ) COLLATE="utf8_general_ci" ENGINE=Myisam; ' );


    SQL.add('insert ignore into '+ fsTablename1 +' ( PartsID , partname, Defaultbin  , InstockQty) '+
            ' Select PartsID , partname, Defaultbin  , sum(InstockQty) '+
            ' from '+ fstablename +
            ' Group by partsId;');
    SQL.add('update  '+ fsTablename1 +' T inner join tblparts P on P.partsId = T.partsId Set T.salesDESCRIPTION = P.PARTSDESCRIPTION , T.PurchaseDESCRIPTION = P.PURCHASEDESC;');

    DoshowProgressbar(2, WaitMSG);
    try
      clog(SQL.text);
      SQL.text := ChangeQuery(SQL.text);
      Execute;
    finally
      DOHideProgressbar;
    end;
  end;

end;

procedure TAlternateProductsGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if classnameis('TAlternateProductsGUI') then
    Qrymain.locate('IsDefault;category' , vararrayof(['T' , 1]), []);
end;

procedure TAlternateProductsGUI.RefreshQuery;
begin
  Populatedata;
  inherited;
end;

procedure TAlternateProductsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainAlternateProductID.fieldname);
  RemoveFieldfromGrid(qryMainPartsId.fieldname);
  RemoveFieldfromGrid(qryMainCategory.fieldname);
  RemoveFieldfromGrid(qryMainExtraPriceID.fieldname);
end;

procedure TAlternateProductsGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
    if GuiPrefs.Node.Exists('Options.ShowExtraForeignPrice') then
      chkShowExtraForeignPrice.Checked :=  GuiPrefs.Node['Options.ShowExtraForeignPrice'].asBoolean;
end;
Procedure TAlternateProductsGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.ShowExtraForeignPrice'].asBoolean := chkShowExtraForeignPrice.Checked;
end;

procedure TAlternateProductsGUI.SetProductID(const Value: Integer);
begin
  fiProductId := Value;
  //Qrymain.Params.Parambyname('ProductId').asInteger := Value;
  Self.Caption := 'Alternate Products for :' +GetProduct(Value);
end;
procedure TAlternateProductsGUI.SetclassId(const Value: Integer);
begin
  fiClasId := Value;
end;

initialization
  RegisterClassOnce(TAlternateProductsGUI);

end.
