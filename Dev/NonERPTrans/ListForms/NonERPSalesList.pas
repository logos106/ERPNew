unit NonERPSalesList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg , NonERPTransList;

type
  TNonERPSalesListGUI = class(TNonERPTransListGUI)
    qryMainJobname: TWideStringField;
    qryMainjobnnumber: TIntegerField;
    qryMainIsPOS: TWideStringField;
    qryMainIsRefund: TWideStringField;
    qryMainIsCashSale: TWideStringField;
    qryMainIsInvoice: TWideStringField;
    qryMainIsQuote: TWideStringField;
    qryMainIsSalesOrder: TWideStringField;
    qryMainIsVoucher: TWideStringField;
    qryMainIsLayby: TWideStringField;
    qryMainIsCustomerReturn: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);
  private
    procedure DoAftershowTerms(Sender: TObject);
  Protected
    procedure SetGridColumns; Override;
    procedure PopulateData;Override;
    Procedure MakeERPTrans(Const aTransID:Integer);Override;
    Function ExtraFeilds:String;Override;
    function getDataImportType: String;Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, MySQLConst, BusObjNonERPSales, ProductQtyLib, CommonFormLib,
  tcDataUtils, frmTerms;

{$R *.dfm}

{ TNonERPSalesListGUI }
procedure TNonERPSalesListGUI.MakeERPTrans(const aTransID: Integer);
begin
  inherited;
  TNonERPSales.ConvertToERPSales(self, aTransID);
end;


function TNonERPSalesListGUI.ExtraFeilds: String;
begin
  Result := 'jobname varchar(255) null default null,'+
            'jobnumber int(11) null default null,'+
            'IsPOS             ENUM("T","F") NOT NULL DEFAULT "F" ,'+
            'IsRefund          ENUM("T","F") NOT NULL DEFAULT "F" ,'+
            'IsCashSale        ENUM("T","F") NOT NULL DEFAULT "F" ,'+
            'IsInvoice         ENUM("T","F") NOT NULL DEFAULT "F" ,'+
            'IsQuote           ENUM("T","F") NOT NULL DEFAULT "F" ,'+
            'IsSalesOrder      ENUM("T","F") NOT NULL DEFAULT "F" ,'+
            'IsVoucher         ENUM("T","F") NOT NULL DEFAULT "F" ,'+
            'IsLayby           ENUM("T","F") NOT NULL DEFAULT "F" ,'+
            'IsCustomerReturn  ENUM("T","F") NOT NULL DEFAULT "F" ,';
end;

procedure TNonERPSalesListGUI.FormCreate(Sender: TObject);
begin
  transtype := 'Sales';
  makeQrymain;
  inherited;
  DisableSortoncolumtitleclick:= TRue;
  EnableMultiSelect('Select Entries to Make ERP Sales');
end;

procedure TNonERPSalesListGUI.FormDestroy(Sender: TObject);
begin
  DeleteTable(fstablename);
  inherited;

end;

function TNonERPSalesListGUI.getDataImportType: String;
begin
  REsult := 'Non ERP Sales';
end;

procedure TNonERPSalesListGUI.grdMainDblClick(Sender: TObject);
begin
  if sametext(activefieldname, qrymainterms.fieldname) and (trim(qrymainterms.asString)<> '') then begin
    OpenERPForm('TfmTerms' ,GetTerms(qrymainterms.asString), DoAftershowTerms);
    Exit;
  end;
  inherited;
end;

procedure TNonERPSalesListGUI.DoAftershowTerms(Sender:TObject);
begin
  if sender is  TfmTerms then begin
    if TfmTerms(Sender).KeyId =0 then
      TfmTerms(Sender).TermnametoAdd := qrymainterms.asString;
  end;
end;
procedure TNonERPSalesListGUI.PopulateData;
begin
  With Scriptmain do begin
    SQL.clear;
    SQL.add('TRUNCATE ' + fstablename +';');
    SQL.add('Insert ignore into  ' + fstablename +
              ' (rownum,aTransId,TransId,ERPTransId,ClientName,Source,clientID,TransDate,ProductName,TranslineID,Shipped,TotalLineAmountInc,Classname, '+
               ' terms,status,jobname,jobnumber, '+
               ' IsPOS,IsRefund,IsCashSale,IsInvoice,IsQuote,IsSalesOrder,IsVoucher,IsLayby,IsCustomerReturn) '+
               ' select ' +
               ' convert( @rownum:=if(@SaleId <> T.SaleId,  @rownum:= 1 ,  @rownum+1) ,  SIGNED) rownum , ' +
               '  @SaleId := T.SaleId, ' +
               '  T.* ' +
               '  from ' +
               ' (Select S.saleId as SaleId, S.ERPSaleId, ' +
               ' S.customerName as  ClientName, ' +
               ' S.Source as  Source, ' +
               ' S.clientID as  clientID, ' +
               ' S.saledate as TransDate, ' +
               ' SL.ProductName as ProductName, ' +
               ' SL.SaleLineID as TranslineID, ' +
               ' SL.Shipped as Shipped , ' +
               ' SL.TotalLineAmountInc as TotalLineAmountInc, ' +
               ' S.Class as ClassName, '+
               ' S.terms, '+
               ' S.status, '+
               ' S.jobname, '+
               ' S.jobnumber, '+
               ' S.IsPOS,S.IsRefund,S.IsCashSale,S.IsInvoice,S.IsQuote,S.IsSalesOrder,S.IsVoucher,S.IsLayby,S.IsCustomerReturn '+
               ' from ' +
               ' tblnonerpsales S ' +
               ' inner join tblnonerpsaleslines SL on S.saleId = Sl.saleId ' +
               ' Where s.saledate Between  ' + Quotedstr(Formatdatetime(MysqlDateFormat , FilterDateFrom)) + '  AND ' + Quotedstr(formatDatetime(MysqlDateFormat , FilterDateTo))+
               ' Order by SaleDate desc, SaleId desc ) T, ' +
               ' (SELECT @rownum:=0) r , ' +
               '  (SELECT @SaleId:=0) s;');
    SQL.add('Update  tblsales S inner join ' + fstablename + ' T on S.saleId = T.ERPTransId '+
              ' Set T.type = '+ Productqtylib.SaleType() +' where  ifnull(T.ERPTransId ,0)<>0;');
    SQL.add('Update  ' + fstablename + ' T Set ERPTransId =0 where ifnull(ERPTransId,0)=0;');
    ExecutewithProgress(False);
  end;

end;

procedure TNonERPSalesListGUI.RefreshQuery;
begin
  PopulateData;
  inherited;
end;

procedure TNonERPSalesListGUI.SetGridColumns;
begin
  inherited;

end;

initialization
  RegisterClassOnce(TNonERPSalesListGUI);
end.
