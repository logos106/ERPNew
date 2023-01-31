unit ProductSalesListFormNotSold;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProductSalesListForm, DB, DAScript, MyScript, ERPdbComponents, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, DNMSpeedButton, wwdblook, Shader, DNMPanel, ProductSalesListFormBase,
  BaseListingForm, CustomInputBox;

type
  TProductSalesListFormNotSoldGUI = class(TProductSalesListFormBaseGUI)
    qryMainPartsID: TIntegerField;
    qryMainPartName: TWideStringField;
    qryMainCost1: TFloatField;
    qryMainPrice1: TFloatField;
    qryMainClassID: TIntegerField;
    qryMainPREFEREDSUPP: TWideStringField;
    qryMainInStockQty: TFloatField;
    qryMainAvailableQty: TFloatField;
    qryMainLastSold: TDateTimeField;
    qryMainInvoiceBOQty: TFloatField;
    qryMainSOQty: TFloatField;
    qryMainShippedQty: TFloatField;
    qryMainDaysAgo: TIntegerField;
    qryMainStockValue: TFloatField;
    qryMainlinesid: TIntegerField;
    qryMainMAAQ: TFloatField;
    qryMainPreferredLevel: TFloatField;
    qryMainClass: TWideStringField;
    qryMainReorderPoint: TFloatField;
    qryMainReorderAmount: TFloatField;
    qryMainFirstColumn: TWideStringField;
    qryMainSecondColumn: TWideStringField;
    qryMainThirdColumn: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainAttrib1Sale: TFloatField;
    qryMainAttrib2Sale: TFloatField;
    qryMainAttrib1SaleRate: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure btnExpressDetailClick(Sender: TObject);
  private
    Tablename :String;
    procedure beforeShowSold(Sender: TObject);
    procedure MakeQrymain;
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;override;
  end;


implementation

uses pqalib, CommonLib, CommonDbLib, ProductQtyLib, CommonFormLib, DateUtils, MySQLConst,  tcConst;

{$R *.dfm}
procedure TProductSalesListFormNotSoldGUI.btnExpressDetailClick(Sender: TObject);
begin
  inherited;
  OpenERpListForm('TProductSalesListFormSoldGUI', beforeShowSold);
  Self.Close;
end;

procedure TProductSalesListFormNotSoldGUI.FormCreate(Sender: TObject);
begin
  TableName := GetUserTemporaryTableName('salesProjectionreport');
  Qrymain.SQL.clear;
  Qrymain.SQL.add('Select');
  Qrymain.SQL.add('* ');
  Qrymain.SQL.add('from ' +tablename);
  inherited;
  ShowChartViewOnPopup := True;
  cboClassQry.Connection := qryMain.Connection;
  MakeQrymain;
end;

procedure TProductSalesListFormNotSoldGUI.FormShow(Sender: TObject);
begin
  inherited;
  grdmain.Hint := 'MAAQ(Monthly Average Activity Quantity) = '+NL+
                  '          (Product''s Total ''Shipped Qty'' + ''Invoice Back Order Qty''  + ''Sales Order Qty'') /  '+NL+
                  '          No of months between the first sale of the product to the last sale of the product'+NL;
end;

procedure TProductSalesListFormNotSoldGUI.beforeShowSold(Sender: TObject);
begin
  CopyParamsto(Sender);
  if sender is TProductSalesListFormBaseGUI then TProductSalesListFormBaseGUI(Sender).ClassID := cboclassQry.FieldByName('ClassID').AsInteger;
end;
Procedure TProductSalesListFormNotSoldGUI.MakeQrymain;
begin
  inherited;
  opendb(cboClassQry);
  cboClassQry.Locate('classname' , cboClass.Text, []);
  With TempMyScript do try
    SQL.Add('drop table if exists ' +tablename +';');
    SQL.Add('Create table ' + tablename +' SELECT PC.id as linesid,P.PartsID, P.PartName, P.Cost1, P.Price1,'+
            ' PC.ClassID,PC.Classname as Class, P.PREFEREDSUPP,PC.PreferredLevel ,'+
            ' PC.ReorderPoint ,PC.ReorderAmount ,'+
            ' P.PARTSDESCRIPTION AS Description,'+
            ' P.Attrib1Sale as Attrib1Sale,P.Attrib2Sale as Attrib2Sale,P.Attrib1SaleRate as Attrib1SaleRate,'+
            ' '+Firstcolumn + ' AS "FirstColumn",'+
            ' '+Secondcolumn + ' AS "SecondColumn",'+
            ' '+Thirdcolumn + ' AS "ThirdColumn",'+
          SQL4Qty(tInStock)+' as InStockQty,  '+
          SQL4Qty(tInvBO)+' as InvoiceBOQty,  '+
          SQL4Qty(tSO)+' as SOQty,  '+
          SQL4Qty(tAvailable)+' as AvailableQty '+
          ' From ' + ProductTables(tSummary) +
      ' Where PC.ClassID = '+IntToStr(cboClassQry.FieldByName('ClassID').asInteger) +
      ' GROUP BY P.PartsID, PC.ClassID;');
    //SQL.Add('delete from ' + tablename +' where InStockQty <=0;');

    SQL.Add('Alter table  ' + tablename +' add column LastSold dateTime;');
    SQL.Add('update  ' + tablename +' T Set  LastSold =  '   +
        ' (SELECT max(S.SaleDate)  '+
        ' FROM tblsaleslines SL  '+
        ' inner join  tblsales S  on S.SaleID = SL.SaleID AND S.Deleted <> ''T''  AND (S.IsInvoice = ''T'' OR S.IsCashSale=''T'' OR S.IsRefund=''T'' OR S.IsPOS=''T'')  '+
        ' where SL.ProductID = T.PArtsID /*and S.sAleDate <= ' + Quotedstr(formatDateTime(MysqlDateTimeFormat , filterDateto)) +'*/);');

    SQL.Add('Delete from ' + tablename +'  where ifnull(LastSold,0) between ' + Quotedstr(formatDateTime(MysqlDateTimeFormat , filterDatefrom)) +' and ' + Quotedstr(formatDateTime(MysqlDateTimeFormat , filterDateto)) +';');

    SQL.Add('Alter table  ' + tablename +' add column DaysAgo int(11);');
    SQL.Add('update  ' + tablename +' T Set DaysAgo = DATEDIFF(curdate() ,LastSold);');

    SQL.Add('Alter table  ' + tablename +' add column StockValue Double;');
    SQL.Add('update  ' + tablename +' T Set StockValue = Cost1 * InStockQty;');

    SQL.Add('Alter table  ' + tablename +' add column ShippedQty Double;');
    SQL.Add('Alter table  ' + tablename +' add column MinSaleDAte DateTime;');
    SQL.Add('Alter table  ' + tablename +' add column MaxSateDate Datetime;');
(*    SQL.Add('update  ' + tablename +' T Set  ShippedQty =  '   +
        ' (SELECT Sum(SL.Shipped)  '+
        ' FROM tblsaleslines SL  '+
        ' inner join  tblsales S  on S.SaleID = SL.SaleID AND S.Deleted <> ''T''  AND (S.IsInvoice = ''T'' OR S.IsCashSale=''T'' OR S.IsRefund=''T'' OR S.IsPOS=''T'')  '+
        ' where SL.ProductID = T.PArtsID);');*)

    SQL.Add('Drop table if exists ' + tablename +'1;');
    SQL.Add('Create table ' + tablename +'1   '   +
        ' Select  SL.productId,   '   +
        ' Sum(SL.Shipped) ShippedQty ,   '   +
        ' min(S.saledate) MinSaleDAte,    '   +
        ' Max(S.SaleDate) MaxSateDate   '   +
        ' from ' + tablename +' T     '   +
        ' inner join tblsaleslines SL on SL.ProductID = T.PArtsID    '   +
        ' inner join  tblsales S  on S.SaleID = SL.SaleID AND S.Deleted <> ''T''  AND (S.IsInvoice = ''T'' OR S.IsCashSale=''T'' OR S.IsRefund=''T'' OR S.IsPOS=''T'')  '   +
        ' group by SL.productId;');
    SQL.Add('update  ' + tablename +' T   inner join ' + tablename +'1  T1      '   +
        ' Set  T.ShippedQty =  T1.ShippedQty , T.MinSaleDAte = T1.MinSaleDAte , T.MaxSateDate = T1.MaxSateDate;');
    SQL.Add('Alter table  ' + tablename +' add column MAAQ Double;');
    SQL.Add('update  ' + tablename +' T    '   +
        ' Set MAAQ = (ifnull(ShippedQty,0) + ifnull(InvoiceBOQty,0) + ifnull(SOQty,0)) * 30 / Datediff(ifnull(MaxSateDate, curDate()),ifnull(MinSaleDAte,curDate()));' );
    Execute;
  finally
    Free;
  end;
end;

procedure TProductSalesListFormNotSoldGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  //monthly average activity Qty
  //QrymainMAAQ.AsFloat :=   (QrymainShippedQty.AsFloat + QrymainInvoiceBOQty.AsFloat + QrymainSOQty.AsFloat) * 30 / (Daysbetween(FilterDateTo,FilterDateFrom));
end;

procedure TProductSalesListFormNotSoldGUI.RefreshQuery;
begin
  closeDB(Qrymain);
  MakeQrymain;
  inherited;
  TimerMsg(FilterLabel , 'List of Products NOT SOLD within the date range specified');
end;

procedure TProductSalesListFormNotSoldGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainClassid.FieldName);
  RemoveFieldfromGrid(qryMainPArtsID.FieldName);
  RemoveFieldfromGrid(qryMainLinesID.FieldName);
  (*RemoveFieldfromGrid(qryMainInvoiceBOQty.FieldName);
  RemoveFieldfromGrid(qryMainSOQty.FieldName);
  RemoveFieldfromGrid(qryMainShippedQty.FieldName);*)
end;

initialization
  RegisterClassOnce(TProductSalesListFormNotSoldGUI);

end.

