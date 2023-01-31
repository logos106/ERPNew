unit SalesShipmentList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TSalesShipmentListGUI = class(TBaseListingGUI)
    qryMaindetails: TLargeintField;
    qryMainsaleId: TIntegerField;
    qryMainShipAddressId: TIntegerField;
    qryMainshipAddressname: TWideStringField;
    qryMainuomQty: TFloatField;
    qryMainProductname: TWideStringField;
    qryMainshipId: TIntegerField;
    qryMainShipmentStatus: TWideStringField;
    qryMainisSalesOrder: TWideStringField;
    qryMainisinvoice: TWideStringField;
    qryMainDetailDesc: TWideStringField;
    qryMainshipdate: TDateTimeField;
    qryMainsaleLineId: TIntegerField;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormCreate(Sender: TObject);
  private
    tablename :String;
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, MySQLConst, CommonDbLib;

{$R *.dfm}

procedure TSalesShipmentListGUI.FormCreate(Sender: TObject);
begin
  tablename := GetUserTemporaryTableName('Salesshipment');
  Qrymain.SQL.clear;
  Qrymain.SQL.Add('Select distinct ');
  Qrymain.SQL.Add('1                as details, ');
  Qrymain.SQL.Add('saleId           as SaleID, ');
  Qrymain.SQL.Add('ShipAddressId    as ShipAddressId, ');
  Qrymain.SQL.Add('shipAddressname  as shipAddressname, ');
  Qrymain.SQL.Add('null             as uomQty , ');
  Qrymain.SQL.Add('null             as Productname, ');
  Qrymain.SQL.Add('null             as Shipdate, ');
  Qrymain.SQL.Add('null             as SaleLineID, ');
  Qrymain.SQL.Add('null             as shipId, ');
  Qrymain.SQL.Add('null             as ShipmentStatus, ');
  Qrymain.SQL.Add('isSalesOrder     as isSalesOrder, ');
  Qrymain.SQL.Add('isinvoice        as isinvoice, ');
  Qrymain.SQL.Add('null             as DetailDesc , ');
  Qrymain.SQL.Add('null             as ctn');
  Qrymain.SQL.Add('from ' +tablename +'  T ');
  Qrymain.SQL.Add('where GroupShipmentsforSameAddress ="T"  ');
  Qrymain.SQL.Add('and (Select count(ID) from ' +tablename +'  t1 where t.saleId = t1.saleId and t.ShipAddressId = t1.shipaddressID) > 1');
  Qrymain.SQL.Add('union all');
  Qrymain.SQL.Add('Select distinct ');
  Qrymain.SQL.Add('2                as details, ');
  Qrymain.SQL.Add('SaleId           as SaleID, ');
  Qrymain.SQL.Add('ShipAddressId    as ShipAddressID, ');
  Qrymain.SQL.Add('shipAddressname  as shipAddressname, ');
  Qrymain.SQL.Add('uomQty           as uomQty   , ');
  Qrymain.SQL.Add('Productname      as Productname, ');
  Qrymain.SQL.Add('Shipdate      as Shipdate, ');
  Qrymain.SQL.Add('SaleLineID      as SaleLineID, ');
  Qrymain.SQL.Add('shipId           as shipId, ');
  Qrymain.SQL.Add('ShipmentStatus   as ShipmentStatus, ');
  Qrymain.SQL.Add('isSalesOrder     as isSalesOrder, ');
  Qrymain.SQL.Add('isinvoice        as isinvoice, ');
  Qrymain.SQL.Add('DetailDesc       as DetailDesc, ');
  Qrymain.SQL.Add('(Select count(ID) from ' +tablename +'  t1 where t.saleId = t1.saleId and t.ShipAddressId = t1.shipaddressID) as cnt');
  Qrymain.SQL.Add('from ' +tablename +'  t');
  Qrymain.SQL.Add('where (Select count(ID) from ' +tablename +'  t1 where t.saleId = t1.saleId and t.ShipAddressId = t1.shipaddressID) >1 and GroupShipmentsforSameAddress ="T"');
  Qrymain.SQL.Add('union');
  Qrymain.SQL.Add('Select distinct ');
  Qrymain.SQL.Add('3                as details, ');
  Qrymain.SQL.Add('SaleId           as SaleId, ');
  Qrymain.SQL.Add('ShipAddressId    as ShipAddressId, ');
  Qrymain.SQL.Add('shipAddressname  as shipAddressname, ');
  Qrymain.SQL.Add('uomQty           as uomQty   , ');
  Qrymain.SQL.Add('Productname      as Productname, ');
  Qrymain.SQL.Add('Shipdate      as Shipdate, ');
  Qrymain.SQL.Add('SaleLineID      as SaleLineID, ');
  Qrymain.SQL.Add('shipId           as shipId, ');
  Qrymain.SQL.Add('ShipmentStatus   as ShipmentStatus, ');
  Qrymain.SQL.Add('isSalesOrder     as isSalesOrder, ');
  Qrymain.SQL.Add('isinvoice        as isinvoice, ');
  Qrymain.SQL.Add('DetailDesc       as DetailDesc, ');
  Qrymain.SQL.Add('(Select count(ID) from ' +tablename +'  t1 where t.saleId = t1.saleId and t.ShipAddressId = t1.shipaddressID) as cnt');
  Qrymain.SQL.Add('from ' +tablename +'  t');
  Qrymain.SQL.Add('where (Select count(ID) from ' +tablename +'  t1 where t.saleId = t1.saleId and t.ShipAddressId = t1.shipaddressID) =1 or GroupShipmentsforSameAddress ="F"');
  Qrymain.SQL.Add('order by SaleId, ShipAddressId, details, shipAddressname');
  inherited;
end;

procedure TSalesShipmentListGUI.FormShow(Sender: TObject);
begin
  inherited;
  if grpfilters.itemindex= -1 then grpfilters.itemindex := 0;
end;

procedure TSalesShipmentListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
(*    if Qrymaindetails.AsInteger =1 then Abrush.Color := $00CAFFFF;
    if Qrymaindetails.AsInteger =2 then Abrush.Color := $00CEDEFF;*)
end;

procedure TSalesShipmentListGUI.grpFiltersClick(Sender: TObject);
begin
(*  groupfilterString := '';
  if grpfilters.itemindex =0 then
       groupfilterString := 'Details = 1 or details = 3';*)
  inherited;
end;

procedure TSalesShipmentListGUI.REfreshQuery;
begin
(*  Qrymain.ParamByName('DateFrom').asDateTime := FilterdateFrom;
  Qrymain.ParamByName('DateTo').asDateTime   := FilterdateTo;*)

  With ScriptMain do begin
    SQL.Clear;
    SQL.Add('Drop table if exists ' +tablename +' ;');
    SQL.Add('create table ' +tablename +'' );
    SQL.Add('select' );
    SQL.Add('"No shipment" as DetailDesc,' );
    SQL.Add('1 as details,' );
    SQL.Add('S.SaleId as SaleID,' );
    SQL.Add('SL.SAleLineId as SAleLineId,' );
    SQL.Add('S.ShipToID as ShipAddressId,' );
    SQL.Add('S.ShipTo as ShipAddressname,' );
    SQL.Add('SL.Productname as Productname,' );
    SQL.Add('s.GroupShipmentsforSameAddress as  GroupShipmentsforSameAddress,' );
    SQL.Add('SL.UnitofMeasureShipped as uomqty,' );
    SQL.Add('null as shipID ,' );
    SQL.Add('NULL as ShipmentStatus,' );
    SQL.Add('SL.ShipDate,' );
    SQL.Add('S.IsSalesOrder as IsSalesorder,' );
    SQL.Add('S.IsInvoice as isinvoice' );
    SQL.Add('from  tblsaleslines SL' );
    SQL.Add('inner join tblsales S on S.saleId = SL.saleID' );
    SQL.Add('left join tblsaleslinesshipments SLS  on SLS.salelineId = SL.saleLineId' );
    SQL.Add('Where ifnull(SLS.ID,0)=0' );
    SQL.Add('and  SL.shipdate between ' + quotedstr(FormatdateTime(MysqlDateTimeFormat , filterDateFrom)) + ' and ' + quotedstr(FormatdateTime(MysqlDateTimeFormat , filterDateTo))+ ' and (S.IsInvoice="T" or S.IsSalesOrder="T")' );
    SQL.Add('union all' );
    SQL.Add('select' );
    SQL.Add('"Single shipment" as DetailDesc,' );
    SQL.Add('2 as details,' );
    SQL.Add('SLS.SaleId as SaleId,' );
    SQL.Add('SL.saleLineID as SAleLineId,' );
    SQL.Add('SLS.ShipAddressId as ShipAddressId,' );
    SQL.Add('SLS.ShipAddressname as ShipAddressname,' );
    SQL.Add('SL.ProductName as productname ,' );
    SQL.Add('S.GroupShipmentsforSameAddress as GroupShipmentsforSameAddress,' );
    SQL.Add('SLS.UOMQty as uomqty ,' );
    SQL.Add('SLS.ID as ShipID,' );
    SQL.Add('if(SLS.shipmentStatus="N","Not Shipped" ,if(SLS.shipmentStatus="S","Shipped" ,if(SLS.shipmentStatus="R","Shipment Response Received" ,"Unknown" ) ) ) as ShipmentStatus,' );
    SQL.Add('SL.ShipDate,' );
    SQL.Add('S.IsSalesOrder as IsSalesorder,' );
    SQL.Add('S.IsInvoice as isinvoice' );
    SQL.Add('from tblsaleslinesshipments SLS' );
    SQL.Add('inner join tblsaleslines SL on SLS.salelineId = SL.saleLineId' );
    SQL.Add('inner join tblsales S on S.saleId = SL.saleID' );
    SQL.Add('Where SL.shipdate between ' + quotedstr(FormatdateTime(MysqlDateTimeFormat , filterDateFrom)) + ' and ' + quotedstr(FormatdateTime(MysqlDateTimeFormat , filterDateTo)) +' and (S.IsInvoice="T" or S.IsSalesOrder="T")' );
    SQL.Add('and  ((Select count(ID) from tblsaleslinesshipments SLSub where SLSub.ShipAddressId = SLs.ShipAddressId and SLSub.SaleId = SLS.saleID)=1  or S.GroupShipmentsforSameAddress="F")' );
    SQL.Add('group by  ShipAddressId, ShipAddressname, SaleId' );
    SQL.Add('union' );
    SQL.Add('select' );
    SQL.Add('"Multiple Shipments" as DetailDesc,' );
    SQL.Add('4 as details,' );
    SQL.Add('SLS.SaleId as SaleID,' );
    SQL.Add('SL.SAleLineId as SAleLineId,' );
    SQL.Add('SLS.ShipAddressId as ShipAddressId,' );
    SQL.Add('SLS.ShipAddressname as ShipAddressname,' );
    SQL.Add('Productname as Productname,' );
    SQL.Add('S.GroupShipmentsforSameAddress as GroupShipmentsforSameAddress,' );
    SQL.Add('SLS.UOMQty as uomqty,' );
    SQL.Add('SLS.ID as shipID ,' );
    SQL.Add('if(SLS.shipmentStatus="N","Not Shipped" ,if(SLS.shipmentStatus="S","Shipped" ,if(SLS.shipmentStatus="R","Shipment Response Received" ,"Unknown" ) ) ) as ShipmentStatus,' );
    SQL.Add('SL.ShipDate,' );
    SQL.Add('S.IsSalesOrder as IsSalesorder,' );
    SQL.Add('S.IsInvoice as isinvoice' );
    SQL.Add('from tblsaleslinesshipments SLS' );
    SQL.Add('inner join tblsaleslines SL on SLS.salelineId = SL.saleLineId' );
    SQL.Add('inner join tblsales S on S.saleId = SL.saleID' );
    SQL.Add('Where S.GroupShipmentsforSameAddress="T"' );
    SQL.Add('and  SL.shipdate between ' + quotedstr(FormatdateTime(MysqlDateTimeFormat , filterDateFrom)) + ' and ' + quotedstr(FormatdateTime(MysqlDateTimeFormat , filterDateTo)) +' and (S.IsInvoice="T" or S.IsSalesOrder="T")' );
    SQL.Add('and ((Select count(ID) from tblsaleslinesshipments SLSub where SLSub.ShipAddressId = SLs.ShipAddressId and SLSub.SaleId = SLS.saleID) >1 ) and S.GroupShipmentsforSameAddress="T"' );
    SQL.Add('union' );
    SQL.Add('select' );
    SQL.Add('"Balance Qty to be shipped" as DetailDesc,' );
    SQL.Add('5 as details,' );
    SQL.Add('S.SaleId as SaleID,' );
    SQL.Add('SL.SAleLineId as SAleLineId,' );
    SQL.Add('S.ShipToID as ShipAddressId,' );
    SQL.Add('S.ShipTo as ShipAddressname,' );
    SQL.Add('SL.Productname as Productname,' );
    SQL.Add('S.GroupShipmentsforSameAddress as  GroupShipmentsforSameAddress,' );
    SQL.Add('SL.UnitofMeasureShipped - (Select sum(UOMQty) from tblsaleslinesshipments SLS where SLS.SaleLineID = SL.saleLineID) as uomqty,' );
    SQL.Add('null as shipID ,' );
    SQL.Add('NULL as ShipmentStatus,' );
    SQL.Add('SL.ShipDate,' );
    SQL.Add('S.IsSalesOrder as IsSalesorder,' );
    SQL.Add('S.IsInvoice as isinvoice' );
    SQL.Add('from  tblsaleslines SL' );
    SQL.Add('inner join tblsales S on S.saleId = SL.saleID' );
    SQL.Add('Where SL.shipdate between ' + quotedstr(FormatdateTime(MysqlDateTimeFormat , filterDateFrom)) + ' and ' + quotedstr(FormatdateTime(MysqlDateTimeFormat , filterDateTo)) +' and (S.IsInvoice="T" or S.IsSalesOrder="T")' );
    SQL.Add('having uomqty <>0' );
    SQL.Add('order by saleId, details , ShipAddressId, saleLineId;' );
    SQL.Add('ALTER TABLE ' +tablename +'  ADD COLUMN ID INT(11) NULL AUTO_INCREMENT , Add Primary key (ID);'  );
    Execute;
  end;
  inherited;

end;

procedure TSalesShipmentListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(Qrymaindetails.fieldname);
  RemoveFieldfromGrid(QrymainSaleLineID.fieldname);
  RemoveFieldfromGrid(QrymainShipAddressId.fieldname);
  RemoveFieldfromGrid(QrymainShipId.fieldname);
  if not devmode then RemoveFieldfromGrid(qryMainDetailDesc.fieldname);
end;

initialization
  RegisterClassOnce(TSalesShipmentListGUI);

end.

