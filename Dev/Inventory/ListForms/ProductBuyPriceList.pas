unit ProductBuyPriceList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel , BusObjCurrency,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TProductBuyPriceListGUI = class(TBaseListingGUI)
    qryMainPartName: TWideStringField;
    qryMainSupplier: TWideStringField;
    qryMainID: TIntegerField;
    qryMainPartsID: TIntegerField;
    qryMainQuantity: TIntegerField;
    qryMainPrice: TFloatField;
    qryMainSupplierProductCode: TWideStringField;
    qryMainSupplierProductName: TWideStringField;
    qryMainCurrency: TWideStringField;
    qryMainCurrencyCode: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainMinimumOrderQty: TFloatField;
    qryMainDescription: TWideStringField;
    qryMainCurrencyID: TIntegerField;
    qryMainUOMPrice: TFloatField;
    qryMainUOMMultiplier: TFloatField;
    btnMakeAltProducts: TDNMSpeedButton;
    qryMainCategory: TLargeintField;
    qryMainCategoryDesc: TWideStringField;
    procedure formatWithcurrencySymbol(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure btnMakeAltProductsClick(Sender: TObject);
    procedure mnuFilterPopup(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
    ForeignCurrency: TCurrency;
    mainProductID: Integer;
    mnuMakeAltProducts1 , mnuMakeAltProducts2 : TMenuItem;
    procedure ExcludeMainProductIdfromOtherProducts(var OtherProductIDs: String);
  Protected
    procedure SetGridColumns; Override;
    procedure AfterPopup(Popupform:TComponent);Override;
    Procedure initPopupmenu;Override;
  public
    { Public declarations }
  end;

implementation

uses CommonLib, CommonFormLib, frmPartsFrm, AppEnvironment, tcDataUtils,
  UserLockBaseObj, tcConst, LogLib, DbSharedObjectsObj, CommonDbLib,
  BaseListLib;

{$R *.dfm}

procedure TProductBuyPriceListGUI.FormCreate(Sender: TObject);
begin
  ForeignCurrency:= TCurrency.Create(nil);
  inherited;
  EnableMultiSelect('Choose Products to Choose and Link them as Alternate Products');
end;

procedure TProductBuyPriceListGUI.FormDestroy(Sender: TObject);
begin
  ForeignCurrency.Free;
  inherited;

end;

procedure TProductBuyPriceListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  (*if grpfilters.ItemIndex< 3 then
  else if Qrymaincategory.asInteger = 1 then ABrush.color := GridColhighLightGreen
  else if Qrymaincategory.asInteger = 2 then ABrush.color := GridColhighLightYellow1
  else if Qrymaincategory.asInteger = 3 then ABrush.color := GridColhighLightBlue;*)
end;

procedure TProductBuyPriceListGUI.grpFiltersClick(Sender: TObject);
begin
  specialnote := '';
        if grpfilters.ItemIndex =0 then GroupFilterString := qryMainCategory.FieldName +' = 1'
  else  if grpfilters.ItemIndex =1 then GroupFilterString := qryMainCategory.FieldName +' = 2'
  else  if grpfilters.ItemIndex =2 then GroupFilterString := qryMainCategory.FieldName +' = 3'
  else begin
    GroupFilterString := '';
    specialnote := '  Blue : Products With No Extra Buy Price / Extra Foreign buy Price '+NL+
                   'Yellow : Products With Extra Foreign Buy Price '+NL+
                   ' Green : Products With Extra Buy Price ';
  end;
  inherited;
end;


procedure TProductBuyPriceListGUI.initPopupmenu;
begin
  inherited;
  BaseListLib.NewMenuItem(self,btnMakeAltProducts.caption,true,btnMakeAltProducts.onclick,mnuMakeAltProducts1,mnuMakeAltProducts2);
end;

procedure TProductBuyPriceListGUI.mnuFilterPopup(Sender: TObject);
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

procedure TProductBuyPriceListGUI.AfterPopup(Popupform:TComponent);
begin
  if Popupform is TfrmParts then begin
    TfrmParts(Popupform).Pagecontrol.ActivePage:= TfrmParts(Popupform).Extra_Buy_Price;
    if qryMainCategory.asInteger = 2 then begin
      SetControlFocus(TfrmParts(Popupform).grdForeign);
      if Qrymainid.AsInteger <> 0 then TfrmParts(Popupform).qryForeignPrice.Locate('ForeignPriceID' ,Qrymainid.AsInteger , [] );
    end else if qryMainCategory.asInteger = 1 then begin
      SetControlFocus(TfrmParts(Popupform).grdBuyPrice);
      if Qrymainid.AsInteger <> 0 then TfrmParts(Popupform).qryExtraBuyPrice.Locate('ExtraPartPriceID' ,Qrymainid.AsInteger , [] );
    end;
  end;
end;

procedure TProductBuyPriceListGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  QrymainUOMPrice.asFloat := QrymainUOMMultiplier.asfloat *
                                      QrymainPrice.asfloat;

end;
Procedure TProductBuyPriceListGUI.ExcludeMainProductIdfromOtherProducts(Var OtherProductIDs:String);
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
procedure TProductBuyPriceListGUI.btnMakeAltProductsClick(Sender: TObject);
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

procedure TProductBuyPriceListGUI.formatWithcurrencySymbol(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  inherited;
  if sender is TFloatField then
    if qryMainCategory.asInteger = 2 then
      Text:= ForeignCurrency.CachedSymbolForId(QrymainCurrencyId.AsInteger) +
              floattoStrF(Sender.AsFloat , ffnumber, 15,2)
    else
      Text:= floattoStrF(Sender.AsFloat , ffcurrency, 15,2);

end;

procedure TProductBuyPriceListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(Qrymaincurrencyid.fieldname);
  RemoveFieldfromGrid(Qrymainid.fieldname);
  RemoveFieldfromGrid(QrymainPartsid.fieldname);
  RemoveFieldfromGrid(qryMainUOMMultiplier.fieldname);
  RemoveFieldfromGrid(qryMainQuantity.fieldname);
  RemoveFieldfromGrid(qryMainCategory.fieldname);

end;

(*initialization
  RegisterClassOnce(TProductBuyPriceListGUI);*)

end.

