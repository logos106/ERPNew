unit PQAMismatchSlPartIdfix;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript;

type
  TPQAMismatchSlPartIdfixGUI = class(TBaseListingGUI)
    btnUpdate: TDNMSpeedButton;
    qryMainPartname: TWideStringField;
    qryMaintobename: TWideStringField;
    qryMainproductname: TWideStringField;
    qryMainPartsId: TIntegerField;
    qryMaintobeid: TIntegerField;
    qryMainProductID: TIntegerField;
    qryMainSaleLineId: TIntegerField;
    qryMainSaleId: TIntegerField;
    qryMainISsalesOrder: TWideStringField;
    qryMainIsInvoice: TWideStringField;
    DNMSpeedButton1: TDNMSpeedButton;
    qryMainPQAID: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
  private
      tablename1, Tablename2:String;
      updateSQL:TStringlist;
  public
    procedure IterateselectedRecordsCallback(var Abort: boolean;SelIndex:Integer); Override;
    Procedure RefreshQuery;override;
  end;


implementation

uses CommonDbLib, tcConst, BusObjSales, CommonLib;

{$R *.dfm}

{ TBaseListingGUI2 }

procedure TPQAMismatchSlPartIdfixGUI.btnUpdateClick(Sender: TObject);
begin
  inherited;
  updateSQL:=TStringlist.create;
  try
   IterateProcNo:= 1;
   IterateRecords(True , WAITMSG);
   if updateSQL.count > 0 then
    ExecuteSQL(updateSQL.text);
  finally
    FreeandNil(updateSQL);
  end;
end;

procedure TPQAMismatchSlPartIdfixGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  grdmain.SelectAll;
end;

procedure TPQAMismatchSlPartIdfixGUI.FormCreate(Sender: TObject);
var
  s:String;
begin
  inherited;
  DestroyUserTemporaryTable(tablename1);
  DestroyUserTemporaryTable(tablename2);
  Tablename1 := GetUserTemporaryTableName(self.Classname +'1');
  Tablename2 := GetUserTemporaryTableName(self.Classname +'2');
  s:= 'Create table ' +tablename1 +'  Select saleLineId, SaleId, ProductId,Productname , Product_Description from tblsaleslines;' +
        ' ALTER TABLE `' +tablename1 +'`  ADD INDEX `Product_Description` (`Product_Description`);' +
        ' ALTER TABLE `' +tablename1 +'`  ADD INDEX `saleLineId` (`saleLineId`);' +
        ' ALTER TABLE `' +tablename1 +'`  ADD INDEX `SaleId` (`SaleId`);' +
        ' ALTER TABLE `' +tablename1 +'`  ADD INDEX `ProductId` (`ProductId`);' +
        ' ALTER TABLE `' +tablename1 +'`  ADD INDEX `Productname` (`Productname`);' +
        ' Create table ' +tablename2 +'  Select PartsID, Partname , PARTSDESCRIPTION from tblParts;' +
        ' ALTER TABLE `' +tablename2 +'`  ADD INDEX `PARTSDESCRIPTION` (`PARTSDESCRIPTION`);' +
        ' ALTER TABLE `' +tablename2 +'`  ADD INDEX `PartsID` (`PartsID`);' +
        ' ALTER TABLE `' +tablename2 +'`  ADD INDEX `Partname` (`Partname`);' ;
  executeSQL(s);
  closedb(Qrymain);
  Qrymain.SQL.clear;
  Qrymain.SQL.add(' Select PQa.PQAID, P.Partname , PP.Partname tobename, SL.productname , P.PartsId, PP.PartsId tobeid, SL.ProductID , ISsalesOrder, IsInvoice' +
        ' from ' +tablename1 +' SL' +
        ' inner join tblsales S on S.SaleId = Sl.saleId' +
        ' inner join ' +tablename2 +' P on P.PARTSID = Sl.ProductId' +
        ' inner join ' +tablename2 +' PP on PP.PARTSDESCRIPTION = SL.Product_Description' +
        ' inner join tblpqa PQA on PQA.transId = SL.SaleId and PQa.TranslineID = Sl.SaleLineId and PQA.transtype in ("TSalesorderline" , "TInvoiceLine")' +
        ' where SL.ProductID <> PP.PARTSID and ifnull(SL.Product_Description,"") <> ifnull(P.PARTSDESCRIPTION,"")' +
        ' order by ISsalesOrder, IsInvoice');
end;

procedure TPQAMismatchSlPartIdfixGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(tablename1);
  DestroyUserTemporaryTable(tablename2);
  inherited;

end;

procedure TPQAMismatchSlPartIdfixGUI.IterateselectedRecordsCallback(var Abort: boolean;SelIndex:Integer);
begin
  inherited;
  if  IterateProcNo = 1 then begin
      updateSQL.add('update tblsaleslines set ProductId = ' +inttostr(qryMaintobeid.asInteger) +' , Productname  = ' +quotedstr(QrymaintoBename.asString) +' where SaleLineId = ' + inttostr(QrymainSaleLineID.asInteger) +';');
      updateSQL.add('update tblPQA set ProductId = ' +inttostr(qryMaintobeid.asInteger) +' , Productname  = ' +quotedstr(QrymaintoBename.asString) +' where PQAID = ' + inttostr(QrymainPQAID.asInteger) + ';')
  end;
end;

procedure TPQAMismatchSlPartIdfixGUI.RefreshQuery;
begin
  inherited;

end;
initialization
  RegisterClassOnce(TPQAMismatchSlPartIdfixGUI);

end.

