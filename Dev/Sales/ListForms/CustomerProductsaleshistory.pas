unit CustomerProductsalesHistory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, StdCtrls, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TCustomerProductsaleshistoryGUI = class(TBaseListingGUI)
    btnExpressDetail: TDNMSpeedButton;
    qryMainSaleDate: TDateField;
    qryMainProductName: TWideStringField;
    qryMainQty: TFloatField;
    qryMainlineprice: TFloatField;
    qryMainPARTSID: TIntegerField;
    qryMaintype: TWideStringField;
    qryMainSAleID: TIntegerField;
    qryMainUOM: TWideStringField;
    qryMainUnitofMeasureSaleLines: TWideStringField;
    qryMainUnitofMeasureMultiplier: TFloatField;
    qryMainDaysSinceSale: TIntegerField;
    qryMainSaleQty: TFloatField;
    qryMainAvailableQty: TFloatField;
    btnSelect: TDNMSpeedButton;
    qryMainid: TIntegerField;
    DNMPanel1: TDNMPanel;
    chkIncludeNonERPSales: TCheckBox;
    qryMainNonERPSales: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure btnExpressDetailClick(Sender: TObject);
    procedure grdMainKeyPress(Sender: TObject; var Key: Char);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure btnSelectClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure chkIncludeNonERPSalesClick(Sender: TObject);
  private
    fiClientID: Integer;
    Tablename :String;
    Procedure MakeQry;
  Protected
    procedure SetGridColumns; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
    Property ClientID:Integer read fiClientID write fiClientId;
    Procedure RefreshQuery;override;
  end;


implementation

uses pqalib, Commonlib,systemlib, tcDataUtils, CommonFormLib, CommonDbLib, ProductQtyLib,
  MySQLConst, AppEnvironment, LogLib, tcConst;

{$R *.dfm}
procedure TCustomerProductsaleshistoryGUI.btnExpressDetailClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormultiselectModal('TProductListExpressGUI' , nil , fOnGridDataSelect);
  Self.Close;
end;

procedure TCustomerProductsaleshistoryGUI.btnSelectClick(Sender: TObject);
begin
  inherited;
  if Qrymain.recordcount =0 then exit;
  grdmain.UnselectAll;
  Qrymain.first;
  while Qrymain.eof = False do begin
    if QrymainQty.asFloat <>   QrymainSaleQty.asfloat then grdmain.selectrecord;
    Qrymain.next;
  end;


  if grdMain.SelectedList.Count >0 then
    if MessageDlg('You have changed Quantity in ' + inttostr(grdMain.SelectedList.Count) +' records(s). Would you like to add them to the transaction?', mtConfirmation, [mbYes, mbNo], 0) = mryes then
      cmdPrint.Click;

end;

procedure TCustomerProductsaleshistoryGUI.chkIncludeNonERPSalesClick(
  Sender: TObject);
begin
  inherited;
  if screen.activecontrol = sender then
    RefreshQuery;
end;

procedure TCustomerProductsaleshistoryGUI.FormCreate(Sender: TObject);
begin
  tablename := GetUserTemporaryTableName('CPSH');
  Qrymain.SQL.Text := 'Select * from ' +tablename;
  inherited;
  fiClientId:= 0;
end;

procedure TCustomerProductsaleshistoryGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if QrymainnonERPSales.AsBoolean then     ABrush.color :=Inactivefontcolor;
  if (QrymainQty.asFloat <>   QrymainSaleQty.asfloat) and (SameText(field.fieldname , 'Qty')) then
      ABrush.color := $006F6FFF
  else if SameText(field.fieldname , 'Qty') then begin
    ABrush.color := $0061C100;
    AFont.Style := AFont.Style + [fsBold];
  end;
end;

procedure TCustomerProductsaleshistoryGUI.grdMainDblClick(Sender: TObject);
begin
  if QrymainNonERPSales.asBoolean then SubsequentID := '_NonERPSales';
  inherited;
end;

procedure TCustomerProductsaleshistoryGUI.grdMainKeyPress(Sender: TObject;
  var Key: Char);
begin
  if SameText(ActiveFieldNAme , 'Qty') then
    if ((Key >= '0') and (Key <= '9')) or ((Key = '.') )  then exit; // accept this value as this column is editable

  inherited;
end;

procedure TCustomerProductsaleshistoryGUI.MakeQry;
var
  tmpfilename:String;
begin
  with Scriptmain do try
    SQL.Add('Drop table if exists ' +tablename +';');
    SQL.Add('CREATE TABLE `' +tablename +'` (');
    SQL.Add('  `SaleID` int(11) NOT NULL DEFAULT "0",');
    SQL.Add('  `NonERPSale` Enum ("T","F") DEFAULT "F",');
    SQL.Add('  `type` varchar(11) NOT NULL DEFAULT "",');
    SQL.Add('  `SaleDate` date DEFAULT NULL,');
    SQL.Add('  `ProductName` varchar(60) DEFAULT NULL,');
    SQL.Add('  `PARTSID` int(11) DEFAULT "0",');
    SQL.Add('  `DaysSinceSale` int(7) DEFAULT NULL,');
    SQL.Add('  `SaleQty` double NOT NULL DEFAULT "0",');
    SQL.Add('  `Qty` double NOT NULL DEFAULT "0",');
    SQL.Add('  `lineprice` double NOT NULL DEFAULT "0",');
    SQL.Add('  `UOM` varchar(255) DEFAULT NULL,');
    SQL.Add('  `UnitofMeasureSaleLines` varchar(255) DEFAULT NULL,');
    SQL.Add('  `UnitofMeasureMultiplier` double NOT NULL DEFAULT "1",');
    SQL.Add('  `AvailableQty` double DEFAULT NULL');
    SQL.Add(') ENGINE=MyISAM DEFAULT CHARSET=utf8;');
    SQL.add(CreateTemporaryTableusingfile('' ,
                        ' Select' +
                        ' S.SaleId as SAleID,' +
                        '"F" as NonERPSale , ' +
                        ' if(S.ISQuote="T" , "Quote" ,if(S.IsSalesorder="T" ,"Sales Order" ,"Invoice" ) ) type,' +
                        ' S.SaleDate as SaleDate ,' +
                        ' SL.ProductName as ProductName,' +
                        ' SL.productID as PARTSID,' +
                        ' DateDiff(S.sAleDate,curdate()) as DaysSinceSale,' +
                        ' SL.UnitofMeasureQtySold as SaleQty   ,' +
                        ' SL.UnitofMeasureQtySold as Qty   ,' +
                        ' SL.LinePrice  as lineprice,' +
                        ' concat(SL.UnitofMeasureSaleLines , "(" , SL.UnitofMeasureMultiplier , ")") as UOM ,' +
                        ' SL.UnitofMeasureSaleLines , SL.UnitofMeasureMultiplier ' +
                        ' from tblsales S inner join tblsaleslines SL on S.SaleId = SL.saleID' +
                        ' Where S.clientID =' + inttostr(clientID)  +
                        ' and S.Saledate between ' +  Quotedstr(formatDateTime(MySQLDateTimeformat , filterdatefrom)) +' and  ' +  Quotedstr(formatDateTime(MySQLDateTimeformat , filterdateto)) +
                        ' and S.converted = "F" and (S.ISQuote="T"  or S.IsSalesorder ="T" Or s.ISInvoice ="T") and ifnull(SL.BaseLineno,0) = 0' +
                        iif( chkIncludeNonERPSales.checked ,' union all Select' +
                                                            ' S.SaleId as SAleID,' +
                                                            '"T" as NonERPSale , ' +
                                                            ' if(S.ISQuote="T" , "Quote" ,if(S.IsSalesorder="T" ,"Sales Order" ,"Invoice" ) ) type,' +
                                                            ' S.SaleDate as SaleDate ,' +
                                                            ' SL.ProductName as ProductName,' +
                                                            ' SL.productID as PARTSID,' +
                                                            ' DateDiff(S.sAleDate,curdate()) as DaysSinceSale,' +
                                                            ' SL.Shipped as SaleQty   ,' +
                                                            ' SL.Shipped as Qty   ,' +
                                                            ' if(ifnull(SL.Shipped,0)<>0  and ifnull(SL.TotalLineAmountInc,0)<>0 ,  SL.TotalLineAmountInc / SL.Shipped , 0) as lineprice,' +
                                                            Quotedstr(Appenv.DefaultClass.DefaultUOM) + '  as UOM ,' +
                                                            Quotedstr(Appenv.DefaultClass.DefaultUOM) + '  as UnitofMeasureSaleLines , '+
                                                            '1 as UnitofMeasureMultiplier ' +
                                                            ' from tblnonerpsales S inner join tblnonerpsaleslines SL on S.SaleId = SL.saleID and ifnull(ERPSalelineID,0)=0' +
                                                            ' Where S.clientID =' + inttostr(clientID)  +
                                                            ' and S.Saledate between ' +  Quotedstr(formatDateTime(MySQLDateTimeformat , filterdatefrom)) +' and  ' +  Quotedstr(formatDateTime(MySQLDateTimeformat , filterdateto)) +
                                                            ' and (S.ISQuote="T"  or S.IsSalesorder ="T" Or s.ISInvoice ="T") '  ,'')+
                        ' order by saleDate desc , saleID, productname'  ,
                        'SAleID,NonERPSale,type,SaleDate,ProductName,PARTSID,DaysSinceSale,SaleQty,Qty,lineprice,UOM,UnitofMeasureSaleLines,UnitofMeasureMultiplier' ,
                        tablename , tmpfilename));

    SQL.Add('ALTER TABLE ' + tablename +' 	ADD COLUMN `id` INT(11) NOT NULL AUTO_INCREMENT ,ADD PRIMARY KEY (`id`);');
    SQL.Add('update ' +Tablename +  ' as tmp ' +
                  ' Set AvailableQty = (select ' + SQL4Qty(tAvailable,'PQA' , 'PQA.Qty') +
                  ' from tblPQa as PQA where  PQA.ProductID = tmp.PARTSID); ' );
    SQL.Add('update ' +Tablename +  ' as tmp  Set UnitofMeasureMultiplier = 1 where ifnull(UnitofMeasureMultiplier,0)= 0; ');
    SQL.Add('update ' +Tablename +  ' as tmp  Set AvailableQty = AvailableQty /UnitofMeasureMultiplier ; ');
    clog(SQL.text);
    AppEnv.UtilsClient.DeleteServerFiles(replaceStr(tmpfilename, '.tmp' , '*.tmp'));
    Execute;
  finally
    AppEnv.UtilsClient.DeleteServerFiles(replaceStr(tmpfilename, '.tmp' , '*.tmp'));
  end;
end;

procedure TCustomerProductsaleshistoryGUI.RefreshQuery;
begin
  (*Qrymain.ParamByName('Ignoredate').AsString := BooleantoStr(chkIgnoreDates.Checked);
  Qrymain.ParamByName('DateFrom').AsDateTime  := FilterDateFrom;
  Qrymain.ParamByName('DateTo').AsDateTime    := FilterDateTo;
  Qrymain.ParamByName('clientID').AsInteger   := ficlientID;*)
Qrymain.DisableControls;
try
  if Qrymain.Active then Qrymain.Close;
  makeQry;
  inherited;
finally
  Qrymain.EnableControls;
end;
  Self.Caption := 'Customer Product Sales History' ;
  TitleLabel.Caption := getClientName(fiClientID);
end;

procedure TCustomerProductsaleshistoryGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainPARTSID.fieldname);
  RemoveFieldfromGrid(qryMainID.fieldname);
end;

procedure TCustomerProductsaleshistoryGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if GuiPrefs.Node.Exists('Options.IncludeNonERPSales') then
      chkIncludeNonERPSales.Visible :=  GuiPrefs.Node['Options.IncludeNonERPSales'].asBoolean;
end;

procedure TCustomerProductsaleshistoryGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.IncludeNonERPSales'].asBoolean := chkIncludeNonERPSales.Visible ;
end;

initialization
  RegisterClassOnce(TCustomerProductsaleshistoryGUI);

end.

