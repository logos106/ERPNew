unit WalmartItems;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel , WalmartListBase, ItemResponse ,
  InventoryFeed;

type
  TWalmartItemsGUI = class(TWalmartListBaseGUI)
    qryMainID: TIntegerField;
    qryMainMart: TWideStringField;
    qryMainSku: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainWpid: TWideStringField;
    qryMainUpc: TWideStringField;
    qryMainGtin: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainShelf: TWideStringField;
    qryMainProductType: TWideStringField;
    qryMainPrice_Currency: TWideStringField;
    qryMainPrice_Amount: TWideStringField;
    qryMainPublishedStatus: TWideStringField;
    qryMainNameValueAttributes_Name: TWideStringField;
    qryMainNameValueAttributes_Type: TWideStringField;
    qryMainERPProductId: TIntegerField;
    qryMainfulfillmentLagTime: TIntegerField;
    qryMainMinfulfillmentLagTime: TIntegerField;
    qryMainERPpartname: TWideStringField;
    btnSynchItems: TDNMSpeedButton;
    btnUpdateQty: TDNMSpeedButton;
    qryMainAvailabilityCode: TWideStringField;
    qryMainuomid: TIntegerField;
    qryMainuomqty: TFloatField;
    btnExporttoWalmart: TDNMSpeedButton;
    qryMainTID: TIntegerField;
    qryMainERPPArtsId: TIntegerField;
    DNMPanel1: TDNMPanel;
    chkShowProduct: TwwCheckBox;
    Label1: TLabel;
    qryMainuommult: TFloatField;
    lblExporttoWalmart: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnItemsClick(Sender: TObject);
    procedure btnUpdateQtyClick(Sender: TObject);
    procedure btnExporttoWalmartClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lblExporttoWalmartClick(Sender: TObject);
  private
    WalmartProducts: IXMLItemResponses;
    InventoryFeed : IXMLInventoryFeed;
    Tablename:String;
    procedure onCreateProduct(Sender: TObject);
    procedure DoUpdateBulkInventory(fsFilename: String);
    Procedure MakeQrymain;
//    procedure btnExporttoWalmartClick1(Sender: TObject);
    procedure DoExportnUpdate;
    procedure DoShownExportnUpdate;
  Protected
    procedure SetGridColumns; Override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
    procedure AfterPopup(Popupform:TComponent);Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, CK_DLL_WalmartLib, Walmart_Item_Lib, BusobjProduct,
  ShellAPI,  BusobjWalmartItems, CommonFormLib, LogLib, XMLDoc, CK_DLL_Const, SystemLib,
  CommonDbLib , frmPartsFrm, tcDataUtils, AppEnvironment, Preferences, FilesLib;

{$R *.dfm}
Procedure TWalmartItemsGUI.DoUpdateBulkInventory(fsFilename:String);
var
  errMsg:String;
begin
  DisableForm;
  try
          ListTimerMsg('Updating Walmart Inventory. Please Wait......');
          try
            showProgressbar('Update Walmart Inventory', 10);
            try
                stepProgressbar;
                Processingcursor(True);
                try
                  UpdateWalmartinvitms(fsFilename , errMsg, LoginList);
                finally
                  Processingcursor(False);
                  LoginList('=========================================');
                end;
            finally
              HideProgressbar;
            end;
          finally
            hideTimerMsg;
          end;
  finally
    EnableForm;
  end;
end;
procedure TWalmartItemsGUI.AfterPopup(Popupform: TComponent);
begin
  inherited;
  if  not(Popupform is TfrmParts ) then exit;
  TfrmParts(Popupform).FocusWalmartPage;

end;

procedure TWalmartItemsGUI.btnExporttoWalmartClick(Sender: TObject);
begin
  if chkShowProduct.checked then
    DoShownExportnUpdate
  else DoExportnUpdate;
end;
procedure TWalmartItemsGUI.DoExportnUpdate;
var
  fs, errMsg:String;
begin
  if not Appenv.companyprefs.Walmart_EnableInvFeed then exit;
//    IXMLInventoryFeed
  if selectedrecords =0 then
    if qrymainid.asInteger <> 0then
      grdmain.selectrecord;

  if selectedrecords =0 then Exit;
  iterateprocno:= 2;
  InventoryFeed := NewInventoryFeed;
  with InventoryFeed.InventoryHeader do begin
      Version := '1.4';
      //FeedDate :=
  end;
  iterateSelectedrecords;

  with InventoryFeed do begin
      fs:=SystemLib.ExeDir+'WalmartProducts.xml';
      Savetofile(fs, XML, true);
      if fileExists (fs) then
        WalmartProductUpdate(XML, fs, errmsg, LoginList );
  end;
end;

//procedure TWalmartItemsGUI.btnExporttoWalmartClick1(Sender: TObject);
//var
//  fs: String;
//begin
//  inherited;
//  if selectedrecords =0 then
//    if qrymainid.asInteger <> 0then
//      grdmain.selectrecord;
//
//  if selectedrecords =0 then Exit;
//  iterateprocno:= 1;
//  WalmartProducts := NewXMLDocument.GetDocBinding('ItemResponses', TXMLItemResponses, WALMART_TargetNameSpace) as IXMLItemResponses;
//  try
//    iterateSelectedrecords;
//    with WalmartProducts do begin
//      fs:=SystemLib.ExeDir+'WalmartProducts.xml';
//      clog(XML, fs);
//      if devmode then begin
//          ShellExecute(0, nil, 'explorer.exe', PChar(fs), nil,  SW_SHOWNORMAL);
//      end;
//      DoUpdateBulkInventory(fs);
////      if WalmartProductUpdate(fs , errMsg , LoginList) then begin
////         ListTimerMsg(inttostr(selectedrecords) +' Product(s) Updated on Walmart');
////         LoginList   (inttostr(selectedrecords) +' Product(s) Updated on Walmart');
////      end;
//    end;
//  finally
//    //freeandnil(WalmartProducts);
//  end;
//end;

procedure TWalmartItemsGUI.btnItemsClick(Sender: TObject);
var
  sitems:String;
  errMsg:String;
begin
  inherited;
  Processingcursor(True);
  try
    LoginList('Checking for Items' );
    sItems:=GetWallMartitems(errMsg, LoginList);
    if errmsg <> '' then begin
      MessageDlgXP_vista('Walmart items synch Caused Error - ' + Errmsg, mtWarning, [mbOK], 0);
      Exit;
    end;
    clog(sItems);
    SetWalmartItems(sItems, onCreateProduct);
    RefreshQuery;
  finally
    Processingcursor(False);
  end;
end;
procedure TWalmartItemsGUI.onCreateProduct(Sender: TObject);
begin
  if sender is TProductsimple then begin
    LoginList('New ERP Product Created for Walmart ' + TProductsimple(Sender).productname);
  end else if sender is Twalmartitems then begin
    LoginList('New Walmart Product Created ' + Twalmartitems(Sender).productname);
  end;
end;
procedure TWalmartItemsGUI.RefreshQuery;
begin
  MakeQrymain;
  inherited;

end;

procedure TWalmartItemsGUI.btnUpdateQtyClick(Sender: TObject);
begin
  DoShownExportnUpdate
end;
procedure TWalmartItemsGUI.DoShownExportnUpdate;
begin
  // this option is invisible
  // as if the qty is changed and updated on walmart, the enxt update will overwrite it based on the product's available qty
  // the solution is this should make a stock adjustment and process it to make that qty available
  // following tables are deleted from db as well

  {CREATE TABLE `tblwalmartitemqtyupdatelines` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Globalref` varchar(255) DEFAULT NULL,
  `UpdateID` int(11) NOT NULL DEFAULT '0',
  `WalmartProductId` int(11) NOT NULL DEFAULT '0',
  `ERPProductID` int(11) NOT NULL DEFAULT '0',
  `CurQty` double NOT NULL DEFAULT '0',
  `NewQty` double NOT NULL DEFAULT '0',
  `Status` varchar(255) DEFAULT NULL,
  `StatusText` text,
  `mstimestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `msUpdatesiteCode` varchar(3) DEFAULT NULL,
  `fulfillmentLagTime` int(11) DEFAULT NULL,
  `MinfulfillmentLagTime` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=innodb AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
CREATE TABLE `tblwalmartitemqtyupdate` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Globalref` varchar(255) NOT NULL DEFAULT '',
  `QtyUpdateDate` datetime DEFAULT NULL,
  `EmployeeId` int(11) NOT NULL DEFAULT '0',
  `EmployeeName` varchar(255) DEFAULT NULL,
  `mstimeStamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `msUpdatesitecode` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;}

  OpenERPFormModal('TfmWalmartItemQty', 0);
end;

procedure TWalmartItemsGUI.FormCreate(Sender: TObject);
begin
  tablename := GetUserTemporaryTableName('WI');
  Qrymain.sql.text := 'Select * from '+ tablename;
  inherited;
  HaveDateRangeSelection:= False;
  EnableMultiSelect('Choose Products to Upload to Walmart, and Choose '+btnExporttoWalmart.caption+'.');
  (*newButton('Synch Items' , btnItemsClick ,pnlExtraButtons);*)
end;

procedure TWalmartItemsGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(Tablename);
  inherited;

end;

procedure TWalmartItemsGUI.FormShow(Sender: TObject);
begin
  inherited;
  btnExporttoWalmart.Enabled := Appenv.companyprefs.Walmart_EnableInvFeed;
  lblExporttoWalmart.visible:= not(Appenv.companyprefs.Walmart_EnableInvFeed);
  if lblExporttoWalmart.visible then
    lblExporttoWalmart.Parent.height := lblExporttoWalmart.Parent.height  + lblExporttoWalmart.height;
end;

procedure TWalmartItemsGUI.IterateselectedRecordsCallback(var Abort: boolean;SelIndex: Integer);
var
  aInventory :IXMLInventory;
begin
  if iterateprocNo = 1 then begin
    with WalmartProducts.ItemResponse.Add do begin
        Mart        := QrymainMart.asString;
        Sku         := QrymainSku.asString;
        Wpid        := QrymainWpid.asString;
        Upc         := QrymainUpc.asString;
        Gtin        := QrymainGtin.asString;
        ProductName := QrymainProductName.asString;
        Shelf       := QrymainShelf.asString;
        ProductType := QrymainProductType.asString;
        PublishedStatus := QrymainPublishedStatus.asString;

        Price.Currency :=  QrymainPrice_currency.asString;
        Price.amount :=  QrymainPrice_amount.AsString;
    end;
    Exit;
  end;
  if iterateprocNo = 2 then begin
    aInventory:= InventoryFeed.Inventory.Add;
    with aInventory do begin
        Sku         := QrymainSku.asString;
        AvailabilityCode := qrymainAvailabilityCode.asString;
        Quantity.unit_ := uppercase(qrymainuom.asString);


              Quantity.amount :=  //FloattostrF(ProductAvailableQty(qry.FieldByname('ERPProductId').asInteger), ffgeneral, 15,2); // FloattostrF(Twalmartitemqtyupdatelines(Sender).NewQty, ffgeneral, 15,2);
                                FloattostrF(divZer(ProductAvailableQty(qrymainERPProductId.asInteger , ''(*qrymainUOM.asString*)) ,
                                                           qrymainUOMMult.asFloat), ffgeneral, 15,2);


        if (qrymainfulfillmentLagTime.asInteger =0) and DevMode then fulfillmentLagTime := 1
        else fulfillmentLagTime := qrymainfulfillmentLagTime.asInteger;

        if (qrymainMinfulfillmentLagTime.asInteger =0) and DevMode then MinfulfillmentLagTime := 1
        else MinfulfillmentLagTime := qrymainMinfulfillmentLagTime.asInteger;
        clog(aInventory.xml);
    end;
    Exit;
  end;

  inherited;
end;

procedure TWalmartItemsGUI.lblExporttoWalmartClick(Sender: TObject);
begin
  inherited;
  OpenPrefform('EDI and Integration' ,  'chkWalmart_EnableInvFeed', 0 , True, 'Walmart' , 'pnlWalmartOptions' ,
                    'Changes made here will not take affect unless the Application is Restarted.');
end;

procedure TWalmartItemsGUI.MakeQrymain;
begin
  With Scriptmain do begin
    SQL.clear;
    SQL.Add('Drop table if exists ' + tablename +';');
    SQL.Add('create table ' + tablename +' '+
            ' Select '+
            ' WI.ID as ID , '+
            ' WI.Mart as Mart , '+
            ' WI.Sku as Sku , '+
            ' WI.Wpid as Wpid , '+
            ' WI.Upc as Upc , '+
            ' WI.Gtin as Gtin , '+
            ' WI.ProductName as ProductName , '+
            ' WI.Shelf as Shelf , '+
            ' WI.ProductType as ProductType , '+
            ' WI.Price_Currency  as Price_Currency , '+
            ' WI.Price_Amount as Price_Amount , '+
            ' WI.PublishedStatus as PublishedStatus , '+
            ' WI.NameValueAttributes_Name as NameValueAttributes_Name , '+
            ' WI.NameValueAttributes_Type as NameValueAttributes_Type , '+
            ' WI.ERPProductId  as ERPProductId , '+
            ' WI.fulfillmentLagTime  as fulfillmentLagTime ,  '+
            ' WI.MinfulfillmentLagTime  as MinfulfillmentLagTime ,  '+
            ' WI.AvailabilityCode as AvailabilityCode, '+
            ' WI.UOM as UOM , '+
            ' WI.uomid as uomid,  '+
            ' WI.uomMult as uomMult,  '+
            ' WI.uomqty as uomqty, '+
            ' P.partname as ERPpartname ,  '+
            ' P.partsId as ERPPArtsId '+
            ' from tblwalmartItems WI '+
            ' Left join tblparts p on P.partsId = WI.ERPProductId;');
    SQL.Add('Alter table ' + tablename +' ADD COLUMN `TID` INT(11) NOT NULL AUTO_INCREMENT FIRST, 	ADD PRIMARY KEY (`TID`);');
    SQL.Add('update ' + tablename +' t inner join tblunitsofmeasure uom on T.erppartsId = ifnull(uom.partID,0) '+
            ' Set T.uom = uom.unitname , t.uomid = uom.unitId, t.uommult =  uom.Multiplier '+
            ' where ifnull(t.uom,"")="" ;');
    SQL.Add('update ' + tablename +' t , (Select uom.unitid, uom.unitname , uom.Multiplier  from tblunitsofmeasure uom '+
						' where ifnull(uom.partID,0) =0 and uom.unitname =(select defaultuom from tblColumnHeadings) ) uom '+
            ' Set T.uom = uom.unitname, t.uomid = uom.unitId, t.uommult =  uom.Multiplier  '+
            ' where ifnull(t.uom,"")="";');
    // int uom to blank if its not a walmart uom
    SQL.Add('update ' + tablename +' t set uom ='+quotedstr(DefaultWalmartUOM)+' , uomid =0 , uommult =1 '+
              ' where uom not in (' + WalmartProductUnits+');');
    SQL.Add('update ' + tablename +' t  '+
            ' inner join tblunitsofmeasure uom on T.erppartsId = ifnull(uom.partID,0) and uom.unitname = t.uom '+
            ' Set t.uomid = uom.unitId '+
            ' where ifnull(t.uomid,0)=0 ;');
    ExecutewithProgress(False);
  end;
end;

procedure TWalmartItemsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainERPProductId.fieldname);
  RemoveFieldfromGrid(qryMainERPPArtsId.fieldname);
  RemoveFieldfromGrid(qryMainID.fieldname);

end;

initialization
  RegisterClassOnce(TWalmartItemsGUI);
end.
