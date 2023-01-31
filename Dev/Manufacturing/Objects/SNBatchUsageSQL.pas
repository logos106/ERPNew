unit SNBatchUsageSQL;

interface

uses
  ERPDbComponents, DAScript, SysUtils, classes, Types, DB, ReportBaseObj;

type

  TSNBatchUsageReport = class(TReportWithDateRangeBase)
  private
    (*fDateTo: TDateTime;
    fDateFrom: TDateTime;*)
    fReportClassName: string;
    fUseDateRange: boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
    property ReportClassName: string read fReportClassName write fReportClassName;
  published
    (*property DateFrom: TDateTime read fDateFrom write fDateFrom;
    property DateTo: TDateTime read fDateTo write fDateTo;*)
    property UseDateRange: boolean read fUseDateRange write fUseDateRange;
  end;


implementation

{ TSNBatchUsageReport }

constructor TSNBatchUsageReport.Create;
begin
  inherited;
  DateFrom := 0;
  DateTo := MaxDateTime;
  fUseDateRange := false;
end;

destructor TSNBatchUsageReport.Destroy;
begin

  inherited;
end;

function TSNBatchUsageReport.PopulateReportSQL(SQL: TStrings;
  var msg: string): boolean;
begin
  result := inherited;

  SQL.Clear;
  SQL.Add('select');
  SQL.Add('if(pqa.TransType = "TSalesOrderLine" , '+
             ' if(s.IsInternalOrder="T",  '+
                ' if(S.converted="T", "Converted Internal Sales Order", "Unconvertd Internal Sales Order"),  '+
             ' "unconverted SalesOrder"),  '+
          ' "Invoice") AS SaleType,');
  SQL.Add('s.SaleID, s.InvoiceDocNumber, s.SaleDate, s.CustomerName, s.ClientPrintName as CustomerPrintName, s.ClientID as CustomerID,');
  SQL.Add('sl.ProductName, sl.ProductPrintName, sl.ProductID, sl.MemoLine,');
  SQL.Add('snd.SerialNumber, snd.BatchNumber, snd.BatchProductName, snd.BatchProductID, snd.BatchQty');
  SQL.Add('from tblsales s');
  SQL.Add('inner join tblsaleslines sl on sl.SaleID = s.SaleID');
  SQL.Add('inner join tblpqa pqa on pqa.TransLineID = sl.SaleLineID and pqa.TransID = sl.SaleID '+
          ' and (((s.converted ="F" or s.IsInternalOrder ="T") and pqa.TransType = "TSalesOrderLine" ) or '+
          '      ( pqa.TransType = "TInvoiceLine") )');
  SQL.Add('inner join tblpqadetails pqad on pqad.PQAType = "SN" and pqad.PQAID = pqa.PQAID');
  SQL.Add('inner join');
  SQL.Add('(select s.SaleID  , sl.SaleLineID, sl.ProductName, sl.ProductID,');
  SQL.Add('pqad.Value as BatchNumber, sum(pqad.Qty) as BatchQty,');
  SQL.Add('ptp.ProductName as BatchProductName, ptp.ProductId as BatchProductID, pt.ParentId, ppg.InProcProgressId, pqadin.Value as SerialNumber');
  SQL.Add('from tblsales s');
  SQL.Add('inner join tblsaleslines sl on s.saleId = sl.saleId');
  SQL.Add('inner join tblproctree pt on sl.salelineId = pt.masterId and pt.mastertype <> "mtProduct"');
  SQL.Add('inner join tblproctreepart ptp on pt.proctreeid = ptp.proctreeid');
  SQL.Add('inner join tblprocprogress ppg on ptp.ProcTreePartId = ppg.ProcTreePartID and ppg.Alloctype = "OUT"');
  SQL.Add('inner join tblpqa pqa on pqa.TransLineID = ppg.ProcProgressID  and pqa.TransType = "TProcProgressOUT"');
  SQL.Add('inner join tblpqadetails pqad on pqad.PQAID = pqa.PQAID and pqad.PQAType = "Batch"');
  SQL.Add('inner join tblprocprogress ppgin on ppg.InProcProgressId = ppgin.ProcProgressID');
  SQL.Add('inner join tblpqa pqain on pqain.TransLineID = ppgin.ProcProgressID and pqain.TransType = "TProcProgressIN"');
  SQL.Add('inner join tblpqadetails pqadin on pqadin.PQAID = pqain.PQAID and pqadin.PQAType ="SN"');
  //SQL.Add('where s.IsInvoice = "T"');
  SQL.Add('where s.IsSalesOrder = "T" ');
  if UseDateRange then begin
    SQL.Add('and s.SaleDate between ' + QuotedStr(FormatDateTime('yyyy-mm-dd',DateFrom)) +
      ' and ' + QuotedStr(FormatDateTime('yyyy-mm-dd',DateTo)));
  end;
  SQL.Add('group by ppg.ProcProgressID, pqad.Value) as snd on snd.SerialNumber = pqad.Value');
end;

initialization

  RegisterClass(TSNBatchUsageReport);

end.
