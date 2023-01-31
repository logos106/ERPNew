unit SalesBackOrderList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BackOrderListForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  BackorderListBase, ComCtrls, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TSalesBackOrderListGUI = class(TBackOrdersListGUI)
    qryMainIsInvoice: TWideStringField;
    qryMainIsSalesOrder: TWideStringField;
    qryMainSalesCategory: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);override;
    procedure FormCreate(Sender: TObject);
  private
    fscontainerfilter:String;
    procedure setcontainerfilter(const Value: String);
    Procedure MakeQrymain;
  Protected
    procedure SetGridColumns; Override;
  public
  Property containerfilter :String read fscontainerfilter write setcontainerfilter;
  end;


implementation

uses CommonLib, ProductQtyLib, SalesBackOrderSQL;

{$R *.dfm}

{ TSalesBackOrderListGUI }

procedure TSalesBackOrderListGUI.FormCreate(Sender: TObject);
begin
  containerfilter := '';
  MakeQrymain;
  inherited;
end;

procedure TSalesBackOrderListGUI.FormShow(Sender: TObject);
begin
  inherited;
  btnExpressDetail.Visible := False;
end;

procedure TSalesBackOrderListGUI.grpFiltersClick(Sender: TObject);
begin
      if grpfilters.itemindex =0 then groupfilterString := ' IsInvoice =' +quotedstr('T')
 else if grpfilters.itemindex =1 then groupfilterString := ' IsSalesOrder =' +quotedstr('T')
 else groupfilterString := '';
  inherited;

end;

procedure TSalesBackOrderListGUI.MakeQrymain;
var
    Report: TSalesBackOrderReport;
    msg:String;
begin
    CloseDB(Qrymain);
    Qrymain.SQL.clear;
Report := TSalesBackOrderReport.Create;
  try
    Report.DateFrom := FilterDateFrom;
    Report.DateTo := FilterDateTo;
    Report.ExtraFilter := containerfilter;
    Report.CustomerId := CustomerId;
    Report.PopulateReportSQL(qryMain.SQL,msg);
    qryMain.SQL.add('Order by SaleLineID desc');
    self.RefreshOrignalSQL();
  finally
    Report.Free;
  end;

(*    Qrymain.sql.add('SELECT');
    Qrymain.sql.add('S.SaleID as SaleID,');
    Qrymain.sql.add('S.ShipDate as ShipDate,');
    Qrymain.sql.add('C.ClientID as ClientID,');
    Qrymain.sql.add('E.EmployeeID as EmployeeID,');
    Qrymain.sql.add('SL.ProductID as ProductID,');
    Qrymain.sql.add('S.SaleDate as SaleDate,');
    Qrymain.sql.add(Firstcolumn('P') + ' AS FirstColumn, ');
    Qrymain.sql.add(Secondcolumn('P') + ' AS Secondcolumn,');
    Qrymain.sql.add(Thirdcolumn('P') + ' AS Thirdcolumn,');
    Qrymain.sql.add('CONCAT_WS(" ", If(InStr(C.Company,"^") -1 >0,Left(C.Company,InStr(C.Company,"^")-1),C.Company),IF(char_length(C.JobName)>0, Concat("(",C.JobName,")"),"")) as CustomerName,');
    Qrymain.sql.add('TypeName as CustomerType,');
    Qrymain.sql.add('S.GlobalRef as GlobalRef,');
    Qrymain.sql.add('S.OriginalNo as OriginalNo,');
    Qrymain.sql.add('S.DueDate as DueDate ,');
    Qrymain.sql.add('S.InvoiceDocNumber as InvoiceDocNumber,');
    Qrymain.sql.add('S.PONumber as PONumber,');
    Qrymain.sql.add('SL.BackOrder as BackOrder,');
    Qrymain.sql.add('SL.ProductName as ProductName,');
    Qrymain.sql.add('SL.Product_Description as Product_Description,');
    Qrymain.sql.add('SL.LinePrice as LinePrice,');
    Qrymain.sql.add('SL.LinePriceInc as LinePriceInc,');
    Qrymain.sql.add('SL.LineWholesalePrice as LineWholesalePrice,');
    Qrymain.sql.add('SL.LineCost as LineCost,');
    Qrymain.sql.add('SL.LineCostInc as LineCostInc,');
    Qrymain.sql.add('SL.BackOrder*SL.LineCost as TotalLineCost,');
    Qrymain.sql.add('SL.BackOrder*SL.LineCostInc as TotalLineCostinc,');
    Qrymain.sql.add('SL.BackOrder*SL.LinePrice as TotalLinePrice,');
    Qrymain.sql.add('SL.BackOrder*SL.LinePriceInc as TotalLinePriceInc,');
    Qrymain.sql.add('SL.SalesLinesCustField1,');
    Qrymain.sql.add('SL.SalesLinesCustField2,');
    Qrymain.sql.add('SL.SalesLinesCustField3,');
    Qrymain.sql.add('SL.SalesLinesCustField4,');
    Qrymain.sql.add('SL.SalesLinesCustField5,');
    Qrymain.sql.add('SL.SalesLinesCustField6,');
    Qrymain.sql.add('SL.SalesLinesCustField7,');
    Qrymain.sql.add('SL.SalesLinesCustField8,');
    Qrymain.sql.add('SL.SalesLinesCustField9,');
    Qrymain.sql.add('SL.SalesLinesCustField10,');
    Qrymain.sql.add('SL.WarrantyEndsOn as WarrantyEndsOn,');
    Qrymain.sql.add('SL.WarrantyPeriod as WarrantyPeriod,');
    Qrymain.sql.add('SL.ShipDate as LineShipDate,');
    Qrymain.sql.add('S.Employeename as Rep,');
    Qrymain.sql.add('S.EnteredBy as EnteredBy,');
    Qrymain.sql.add('S.PickUpFrom as PickUpFrom,');
    Qrymain.sql.add('S.Deleted as Deleted,');
    Qrymain.sql.add('SL.SaleLineID as SaleLineID,');
    Qrymain.sql.add('S.Converted as Converted,');
    Qrymain.sql.add('S.QuoteGlobalRef as ConvertFromQuote,');
    Qrymain.sql.add('S.SalesOrderGlobalRef as ConvertFromSO,');
    Qrymain.sql.add('C.CUSTFLD1 AS CUSTFLD1,');
    Qrymain.sql.add('C.CUSTFLD2 AS CUSTFLD2,');
    Qrymain.sql.add('C.CUSTFLD3 AS CUSTFLD3,');
    Qrymain.sql.add('C.CUSTFLD4 AS CUSTFLD4,');
    Qrymain.sql.add('C.CUSTFLD5 AS CUSTFLD5,');
    Qrymain.sql.add('C.CUSTFLD6 AS CUSTFLD6,');
    Qrymain.sql.add('C.CUSTFLD7 AS CUSTFLD7,');
    Qrymain.sql.add('C.CUSTFLD8 AS CUSTFLD8,');
    Qrymain.sql.add('C.CUSTFLD9 AS CUSTFLD9,');
    Qrymain.sql.add('C.CUSTFLD10 AS CUSTFLD10,');
    Qrymain.sql.add('C.CUSTFLD11 AS CUSTFLD11,');
    Qrymain.sql.add('C.CUSTFLD12 AS CUSTFLD12,');
    Qrymain.sql.add('C.CUSTFLD13 AS CUSTFLD13,');
    Qrymain.sql.add('C.CUSTFLD14 AS CUSTFLD14,');
    Qrymain.sql.add('C.CUSTFLD15 AS CUSTFLD15,');
    Qrymain.sql.add('C.CUSTdate1 as CUSTdate1,');
    Qrymain.sql.add('C.CUSTdate2 as CUSTdate2,');
    Qrymain.sql.add('C.CUSTdate3 as CUSTdate3,');
    Qrymain.sql.add('S.Class as class,');
    Qrymain.sql.add('SL.CreationDate as CreationDate,');
    Qrymain.sql.add('P.PreferedSupp as PreferedSupplier ,');
    Qrymain.sql.add('S.PickMemo ,');
    Qrymain.sql.add('S.IsInvoice as IsInvoice,');
    Qrymain.sql.add('S.IsSalesOrder as IsSalesOrder,');
    Qrymain.sql.add('if(S.IsInvoice ="T", "I" , "S") as SalesCategory');
    Qrymain.sql.add('FROM tblSales S');
    Qrymain.sql.add('INNER JOIN tblSalesLines SL on S.SaleId = Sl.saleId');
    Qrymain.sql.add('INNER JOIN tblParts P ON SL.ProductID=P.PARTSID');
    Qrymain.sql.add('INNER JOIN tblClients C ON  (S.ClientID = C.ClientID)');
    Qrymain.sql.add('Left JOIN tblclienttype CT on CT.ClientTypeID = C.ClientTypeID');
    Qrymain.sql.add('inner JOIN tblEmployees E ON  S.EmployeeID = E.EmployeeID');
    Qrymain.sql.add('WHERE S.Converted  ="F" and (S.IsInvoice="T" OR S.IsSalesOrder="T" ) AND S.IsRefund="F" AND S.IsCashSale="F"');
    Qrymain.sql.add('AND   S.IsQuote="F" AND S.Deleted="F"');
    Qrymain.sql.add('AND   S.SaleDate Between :txtfrom AND :txtto');
    Qrymain.sql.add('AND   SL.Invoiced = "F" AND SL.BackOrder <> 0');
    Qrymain.sql.add('AND   ifnull(S.BOID , "") = ""');
    if containerfilter <> '' then Qrymain.sql.add('AND   (' + containerfilter +')');
    Qrymain.sql.add('GROUP BY SL.SaleLineID order by SaleLineID desc');
    RefreshOrignalSQL(false);*)
end;

procedure TSalesBackOrderListGUI.setcontainerfilter(const Value: String);
begin
  { need to prefix field names, typical Value passed is as follows .. }
  { (SaleID = 1153 and ProductId = 49) OR (SaleID = 2167 and ProductId = 49) OR etc }
  fscontainerfilter := Value;
  fscontainerfilter := StringReplace(fscontainerfilter,'SaleID','S.SaleID',[rfReplaceAll,rfIgnoreCase]);
  fscontainerfilter := StringReplace(fscontainerfilter,'ProductId','SL.ProductId',[rfReplaceAll,rfIgnoreCase]);
  makeQrymain;
end;

procedure TSalesBackOrderListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainSalesCategory.fieldname);
end;


initialization
  RegisterClassOnce(TSalesBackOrderListGUI);

end.

