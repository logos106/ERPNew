unit BillReportSQL;

interface

uses
   ERPDbComponents, DAScript, SysUtils, classes, Types, DB, ReportBaseObj;

type

   TBillReport = class(TReportWithDateRangeBase)

   private
      (* fDateTo: TDateTime;
        fDateFrom: TDateTime;
        fIgnoreDates: boolean; *)
      fPaid: boolean;
      fUnpaid: boolean;
      fShowNonApproved: boolean;
      fUseApprovalLevels: boolean;
      fbIncludePOs: boolean;
      fbIncludeBills: boolean;
      fbIncludeCredits: boolean;
      fiClassId: Integer;
      (* procedure SetDateFrom(const Value: TDateTime);
        procedure SetDateTo(const Value: TDateTime);
        function DateFromSQL: string;
        function DateToSQL: string; *)

   public
      constructor Create; override;
      destructor Destroy; override;
      function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
      property UseApprovalLevels: boolean read fUseApprovalLevels write fUseApprovalLevels;
      property ShowNonApproved: boolean read fShowNonApproved write fShowNonApproved;

   published
      (* property DateFrom: TDateTime read fDateFrom write SetDateFrom;
        property DateTo: TDateTime read fDateTo write SetDateTo;
        property IgnoreDates: boolean read fIgnoreDates write fIgnoreDates; *)
      property Paid: boolean read fPaid write fPaid;
      property Unpaid: boolean read fUnpaid write fUnpaid;
      Property IncludeBills: boolean read fbIncludeBills write fbIncludeBills;
      Property IncludeCredits: boolean read fbIncludeCredits write fbIncludeCredits;
      Property IncludePOs: boolean read fbIncludePOs write fbIncludePOs;
      Property ClassId: Integer read fiClassId write fiClassId;

   end;

implementation

uses LogLib, ProductQtyLib, StringUtils;

{ TBillReport }

constructor TBillReport.Create;
begin
   inherited;
   fbIncludePOs := False;
   fiClassId := 0;
   fbIncludeBills := True;
   fbIncludeCredits := True;
   (* fDateFrom := MinDateTime;
     fDateTo := MaxDateTime;
     fIgnoreDates := true; *)
   fPaid := True;
   fUnpaid := True;
   fUseApprovalLevels := False;
   fShowNonApproved := True;
end;

(* function TBillReport.DateFromSQL: string;
  var
  dt: TDateTime;
  begin
  if not APIMode then begin
  result := ':Datefrom';
  exit;
  end
  else if fIgnoreDates then dt := MinDateTime
  else dt := fDateFrom;
  result := '"' + FormatDateTime('yyyy-mm-dd',dt) + '"';
  end;

  function TBillReport.DateToSQL: string;
  var
  dt: TDateTime;
  begin
  if not APIMode then begin
  result := ':Dateto';
  Exit;
  end else if fIgnoreDates then dt := MaxDateTime
  else dt := fDateTo;
  result := '"' + FormatDateTime('yyyy-mm-dd',dt) + '"';
  end; *)

destructor TBillReport.Destroy;
begin

   inherited;
end;

function TBillReport.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;

  Function Transcondition: String;
   begin
      result := '';
      if IncludeBills then
         result := 'PO.IsBill = "T"';
      if IncludeCredits then
      begin
         if result <> '' then
            result := result + ' OR ';
         result := result + ' PO.IsCredit = "T" ';
      end;
      if result <> '' then
         result := '(PL.AccountName <> Space(1) and (' + result + '))';

      if IncludePOs then
      begin
         if result <> '' then
            result := result + ' OR ';
         result := result + '(PL.Productname <> Space(1) and (PO.isPO="T"))';
      end;
      if fiClassId <> 0 then
      begin
         if result <> '' then
            result := '(' + result + ' ) AND ';
         result := result + '(PL.ClassID = ' + inttostr(fiClassId) + ' )';
      end;
      if result <> '' then
         result := ' AND ( ' + result + ')';
      logtext(result);
   end;

  function ReplaceAlias(AClause: string): string;
  var
    STemp: string;
  begin
    STemp := AClause;
    STemp := ReplaceStr(STemp, 'BillNumber', 'Concat_WS("", PO.PurchaseOrderNumber)');
    STemp := ReplaceStr(STemp, 'Balance', 'IFNULL(PO.balance, 0)');
    Result := STemp;
  end;

begin
   result := inherited;

   SQL.Clear;
   SQL.Add('SELECT');
   SQL.Add('NULL AS ID,');
   SQL.Add('PO.ContactId AS ContactId,');
   SQL.Add('PO.GlobalRef AS GlobalRef,');
   SQL.Add('PO.PurchaseOrderID as PurchaseOrderID,');
   SQL.Add(POType('PO') + ' AS Type,');
   SQL.Add('C.ClientID AS ClientID,');
   SQL.Add('C.Company AS Company,');
   SQL.Add('C.PrintName AS PrintName,');
   SQL.Add('Concat_WS("", PO.PurchaseOrderNumber) AS BillNumber,');
   SQL.Add('Date(PO.OrderDate) AS OrderDate,');
   SQL.Add('PO.Comments AS Comments,');
   SQL.Add('IF(NOT ISNULL(C1.Company),C1.Company, IF(NOT ISNULL(C2.Company), C2.Company, Space(100))) AS Contact,');
   SQL.Add('PO.DueDate AS DueDate,');
   SQL.Add('PO.ETADate AS ETADate,');
   SQL.Add('C.Phone AS Phone,');
   SQL.Add('PL.Invoiced AS Invoiced,');
   SQL.Add('PO.IsCredit AS IsCredit,');
   SQL.Add('PO.InvoiceNumber as InvoiceNumber,');
   SQL.Add('PO.IsRA AS IsRA,');
   SQL.Add('PO.Deleted AS Deleted,');
   SQL.Add('PO.SalesComments AS SalesComments,');
   SQL.Add('IF(IsCredit = "T", -PO.TotalAmount,PO.TotalAmount) AS "Total Amount (Ex)",');
   SQL.Add('IF(IsCredit = "T", -PO.TotalTax,PO.TotalTax) AS "Total Tax",');
   SQL.Add('IF(IsCredit = "T", -PO.TotalAmountInc,PO.TotalAmountInc) AS "Total Amount (Inc)",');
   SQL.Add('PO.Approved AS Approved,');
   SQL.Add('IF(IsCredit="T", "Credit", IF(IsRA="T", "Return Authority", NULL) ) AS CreditOrReturn,');
   SQL.Add('IFNULL(PO.balance, 0) AS Balance');
   SQL.Add('FROM tblPurchaseOrders PO');
   SQL.Add('INNER JOIN tblPurchaseLines PL ON (PO.PurchaseOrderID=PL.PurchaseOrderID)');
   SQL.Add('LEFT JOIN tblClients C ON (PO.SupplierName=C.Company)');
   SQL.Add('LEFT JOIN tblParts P ON (PL.ProductName=P.PARTName)');
   SQL.Add('LEFT JOIN tblContacts C1 ON C1.ContactID=PO.contactId');
   SQL.Add('LEFT JOIN tblContacts C2 ON (C2.IsPrimarycontact="T" AND C2.ClientID=C.ClientID)');
   SQL.Add('WHERE OrderDate BETWEEN ' + DateFromSQL + ' AND ' + DateToSQL);
   SQL.Add(Transcondition);

   // SQL.Add('and ((:UseApprovalLevels="F")  or ( (:ShowNonApproved="T" or PO.Approved = "T")');
   if UseApprovalLevels then
      if not ShowNonApproved then
         SQL.Add('and PO.Approved = "T"');

   if not APIMode then
      SQL.Add('and ((:paidFilter ="All") or (:paidFilter ="T" and IfNull(PO.balance,0) = 0) or (:paidFilter ="F" and IfNull(PO.balance,0) <> 0))')
   else if Paid and Unpaid then
   begin { all }
   end
   else if Paid then
      SQL.Add('and IfNull(PO.balance,0) = 0')
   else if Unpaid then
      SQL.Add('and IfNull(PO.balance,0) <> 0');

   if not (Search = '') then
      SQL.Add('AND ' + ReplaceAlias(Search));

   SQL.Add('GROUP BY PO.PurchaseOrderID');
end;

(* procedure TBillReport.SetDateFrom(const Value: TDateTime);
  begin
  fDateFrom := Value;
  end;

  procedure TBillReport.SetDateTo(const Value: TDateTime);
  begin
  fDateTo := Value;
  end; *)

initialization

RegisterClass(TBillReport);

end.
