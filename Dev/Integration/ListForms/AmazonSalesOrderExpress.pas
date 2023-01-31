unit AmazonSalesOrderExpress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SalesorderListExpress, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TAmazonSalesOrderExpressGUI = class(TSalesorderListExpressGUI)
  private
    { Private declarations }
  Protected
    procedure MakeQryMain; override;
    function ExtraTables: String; Override;
  public
    { Public declarations }
  end;


implementation

uses
  ProductQtyLib, CommonLib;

{$R *.dfm}

{ TAmazonSalesOrderExpressGUI }

function TAmazonSalesOrderExpressGUI.ExtraTables: String;
begin
  Result := 'inner join tblediorder EDI on S.saleId = EDI.ERPSalesOrderId and EDI.EDIParty = "Amazon"';
end;

procedure TAmazonSalesOrderExpressGUI.MakeQryMain;
begin
  inherited;
    (*Qrymain.Sql.clear;
    Qrymain.Sql.Add('Select Distinct ');
    Qrymain.Sql.Add('S.clientId           AS ClientId, ');
    Qrymain.Sql.Add('S.InvoiceDocNumber   AS Saleno, ');
    Qrymain.Sql.Add('S.SaleId             AS SaleId, ');
    Qrymain.Sql.Add('S.BOID               AS BORef, ');
    Qrymain.Sql.Add('S.Customername       AS CustomerName, ');
    Qrymain.Sql.Add('S.ClientPrintName    AS PrintName, ');
    Qrymain.Sql.Add('S.totalAmountinc     AS TotalAmountinc, ');
    Qrymain.Sql.Add('S.TotalTax     AS TotalTax, ');
    Qrymain.Sql.Add('S.totalAmount        AS TotalAmount, ');
    Qrymain.Sql.Add('S.Payment            AS Payment, ');
    Qrymain.Sql.Add('S.balance            AS Balance, ');
    Qrymain.Sql.Add('S.SaleDate           AS SaleDate, ');
    Qrymain.Sql.Add('Date(S.SaleDateTime) AS TransDate, ');
    Qrymain.Sql.Add('Time(S.SaleDateTime) AS TransTime, ');
    Qrymain.Sql.Add('S.Converted          AS Converted, ');
    Qrymain.Sql.Add('S.futureSo           AS futureSo, ');
    Qrymain.Sql.Add('S.Deleted            AS Done, ');
    Qrymain.Sql.Add(SaleType('S')+ '      AS Type, ');
    Qrymain.Sql.Add('S.QuoteStatus        AS Status, ');
    Qrymain.Sql.Add('S.ShipDate           AS shipdate, ');
    Qrymain.Sql.Add('S.HoldSale           AS held, ');
    Qrymain.Sql.Add('S.PONumber           AS PONumber, ');
    Qrymain.Sql.Add('S.terms              AS terms, ');
    Qrymain.Sql.Add('S.Comments           AS Comments, ');
    Qrymain.Sql.Add('S.Class              AS ClassName, ');
    Qrymain.Sql.Add('S.dueDate            AS dueDate, ');
    Qrymain.Sql.Add('S.employeename       AS employeename, ');
    Qrymain.Sql.Add('ReplaceNewLine(S.ShipTo,"") as ShipTo , ');
    Qrymain.Sql.Add(ExtraFields);
    Qrymain.Sql.Add('If(IsNull(S.ClientSignature),"F","T") AS HasSignature ');
    Qrymain.Sql.Add('From tblSales S ');
    Qrymain.Sql.Add('inner join tblsaleslines SL on S.saleID = SL.SaleId'); // AND  SL.Invoiced = "T" ');
    Qrymain.Sql.Add(ExtraTables);
    Qrymain.Sql.Add(' and S.IsSalesOrder= "T" AND (S.IsCashSale="F" OR S.IsLayByTOS= "T") ');

    if ExcludeDeleted then
      Qrymain.Sql.Add('Where s.deleted ="F" ')
    else
      Qrymain.Sql.Add('Where (s.deleted ="F" or s.deleted ="T")');

    Qrymain.Sql.Add('and S.SaleDate between :DateFrom and  :dateTo ');
    Qrymain.Sql.Add('and (:CustomerId =0 or S.clientID = :CustomerId) ');
    Qrymain.Sql.Add('AND (:SalesClassId =0 or S.ClassID = :SalesClassId) ');

    //Qrymain.Sql.Add(Extraconditions);
    Qrymain.Sql.Add('Order by SaleID Desc');
    RefreshOrignalSQL(true);*)
end;

initialization
  RegisterClassOnce(TAmazonSalesOrderExpressGUI);

end.
