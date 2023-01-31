unit NonERPPOList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NonERPTransList, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TNonERPPOListGUI = class(TNonERPTransListGUI)
    qryMainIsPO: TWideStringField;
    qryMainIsRA: TWideStringField;
    qryMainIsBill: TWideStringField;
    qryMainIsCredit: TWideStringField;
    qryMainIsCheque: TWideStringField;
    grpextrafilters: TwwRadioGroup;
    qryMainInvoiceNumber: TWideStringField;
    qryMainInvoiceDate: TDateField;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
  private
  Protected
    procedure SetGridColumns; Override;
    procedure PopulateData;Override;
    Function ExtraFeilds:String;Override;
    function getDataImportType: String;Override;
    Procedure MakeERPTrans(Const aTransID:Integer);Override;

  public
    Procedure RefreshQuery;Override;
  end;

implementation

uses BusObjNonERPPO, MySQLConst, CommonLib, ProductQtyLib, LogLib;

{$R *.dfm}

{ TNonERPPOListGUI }

function TNonERPPOListGUI.ExtraFeilds: String;
begin
  Result := 'Accountname varchar(255) null default null,'+
             'InvoiceNumber varchar(255) null default null,'+
             'InvoiceDate DAte null default null , '+
             'IsPO ENUM("T","F") NOT NULL DEFAULT "F" ,'+
             'IsRA ENUM("T","F") NOT NULL DEFAULT "F" ,'+
             'IsBill ENUM("T","F") NOT NULL DEFAULT "F" ,'+
             'IsCredit ENUM("T","F") NOT NULL DEFAULT "F" ,'+
             'IsCheque ENUM("T","F") NOT NULL DEFAULT "F" ,';
end;

procedure TNonERPPOListGUI.FormCreate(Sender: TObject);
begin
  if grpextrafilters.itemindex = -1 then grpextrafilters.itemindex:= 0;
  transtype := 'PO';
  makeQrymain;
  inherited;
  DisableSortoncolumtitleclick:= TRue;
  EnableMultiSelect('Select Entries to Make ERP PO');
end;


function TNonERPPOListGUI.getDataImportType: String;
begin
  REsult := 'Non ERP Purchases';
end;

procedure TNonERPPOListGUI.grpFiltersClick(Sender: TObject);
begin
       if grpextrafilters.itemindex = 0 then GroupFilterString := '(IsPO='+Quotedstr('T')+') or ( IsRA='+Quotedstr('F')+' and IsBill='+Quotedstr('F')+' and IsCredit='+Quotedstr('F')+' and IsCheque='+Quotedstr('F')+')'
  else if grpextrafilters.itemindex = 1 then GroupFilterString := 'IsRA='+Quotedstr('T')
  else if grpextrafilters.itemindex = 2 then GroupFilterString := 'IsBill='+Quotedstr('T')
  else if grpextrafilters.itemindex = 3 then GroupFilterString := 'IsCredit='+Quotedstr('T')
  else if grpextrafilters.itemindex = 4 then GroupFilterString := 'IsCheque='+Quotedstr('T')
  else GroupFilterString := '';
  inherited;
end;

procedure TNonERPPOListGUI.MakeERPTrans(const aTransID: Integer);
begin
  inherited;
       if qrymainisBill.asBoolean or qrymainisCredit.asBoolean  or qrymainisCheque.asBoolean   then TNonERPPurchase.ConvertToERPExpense(self, aTransID)
  else TNonERPPurchase.ConvertToERPPurchase(self, aTransID);

end;


procedure TNonERPPOListGUI.PopulateData;
begin
  With Scriptmain do begin
    SQL.clear;
    SQL.add('TRUNCATE ' + fstablename +';');
    SQL.add('Insert ignore into  ' + fstablename +
              ' (rownum,aTransId,TransId,ERPTransId,ClientName,Source,clientID,TransDate,ProductName,TranslineID,Shipped,TotalLineAmountInc,Classname,Accountname,InvoiceNumber,InvoiceDate,IsPO, IsRA ,IsBill ,IsCredit ,IsCheque ) '+
               ' select ' +
               ' convert( @rownum:=if(@PurchaseOrderID <> T.PurchaseOrderID,  @rownum:= 1 ,  @rownum+1) ,  SIGNED) rownum , ' +
               '  @PurchaseOrderID := T.PurchaseOrderID, ' +
               '  T.* ' +
               '  from ' +
               ' (Select PO.PurchaseOrderID as PurchaseOrderID, PO.ERPPOID, ' +
               ' PO.Suppliername as  ClientName, ' +
               ' PO.Source as  Source, ' +
               ' PO.clientID as  clientID, ' +
               ' PO.OrderDate as TransDate, ' +
               ' PL.ProductName as ProductName, ' +
               ' PL.PurchaseLineID as TranslineID, ' +
               ' PL.Shipped as Shipped , ' +
               ' PL.TotalLineAmountInc as TotalLineAmountInc, ' +
               ' PL.Class as Classname,'+
               ' PL.AccountName as AccountName ,'+
               ' PO.InvoiceNumber as InvoiceNumber ,'+
               ' PO.InvoiceDate as InvoiceDate,'+
               ' PO.IsPO, PO.IsRA ,PO.IsBill ,PO.IsCredit ,PO.IsCheque '+
               ' from ' +
               ' tblnonerppurchases PO ' +
               ' inner join tblnonerppurchaselines PL on PO.PurchaseOrderID = PL.PurchaseOrderID ' +
               ' Where PO.OrderDate Between  ' + Quotedstr(Formatdatetime(MysqlDateFormat , FilterDateFrom)) + '  AND ' + Quotedstr(formatDatetime(MysqlDateFormat , FilterDateTo))+
               ' Order by OrderDate desc, PurchaseOrderID desc ) T, ' +
               ' (SELECT @rownum:=0) r , ' +
               '  (SELECT @PurchaseOrderID:=0) s;');
    SQL.add('Update  tblpurchaseorders P inner join ' + fstablename + ' T on P.PurchaseOrderID = T.ERPTransId '+
              ' Set T.type = '+ POType() +' where  ifnull(T.ERPTransId ,0)<>0;');
    SQL.add('Update  ' + fstablename + ' T Set ERPTransId =0 where ifnull(ERPTransId,0)=0;');
    logtext(SQL.Text);
    ExecutewithProgress(False);
  end;

end;

procedure TNonERPPOListGUI.RefreshQuery;
begin
  PopulateData;
  inherited;
end;

procedure TNonERPPOListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainIsPO.FieldName);
  RemoveFieldfromGrid(qryMainIsRA.FieldName);
  RemoveFieldfromGrid(qryMainIsBill.FieldName);
  RemoveFieldfromGrid(qryMainIsCredit.FieldName);
  RemoveFieldfromGrid(qryMainIsCheque.FieldName);
end;
initialization
  RegisterClassOnce(TNonERPPOListGUI);

end.
