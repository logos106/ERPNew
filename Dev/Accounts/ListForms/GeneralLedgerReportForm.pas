unit GeneralLedgerReportForm;

{ Date     Version Who  What
 -------- -------- ---  --------------------------------------------------------
 07/09/05  1.00.01 IJB  Modified to use new filtering on base listing.
 }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList,
  Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls,
  ExtCtrls, wwdblook, wwcheckbox, kbmMemTable, Mask, DBCtrls, wwDialog,
  TransactionsTable,  Wwlocate, SelectionDialog, DNMPanel, MemDS, DBAccess, MyAccess,ERPdbComponents,
  wwdbdatetimepicker, ProgressDialog,  Shader, BaseInputForm,
  DAScript, MyScript, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg,
  GeneralLedgerReportSQL;

const
  SX_DatechangeMsg = WM_USER + 112;

type
  TGeneralLedgerReportGUI = class(TBaseListingGUI)
    BitBtn1: TDNMSpeedButton;
    qryMainAccounts: TWideStringField;
    qryMainType: TWideStringField;
    qryMainDate: TDateField;
    qryMainGlobalRef: TWideStringField;
    qryMainClass: TWideStringField;
    qryMainAccountName: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainRepName: TWideStringField;
    qryMainTaxCode: TWideStringField;
    qryMainTaxRate: TFloatField;
    qryMainDebitsEx: TFloatField;
    qryMainCreditsEx: TFloatField;
    qryMainDebitsInc: TFloatField;
    qryMainCreditsInc: TFloatField;
    qryMainAmountEx: TFloatField;
    qryMainAmountInc: TFloatField;
    qryMainClassID: TIntegerField;
    qryMainSaleID: TIntegerField;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainPaymentID: TIntegerField;
    qryMainAccountID: TIntegerField;
    qryMainClientName: TWideStringField;
    qryMainProductDescription: TWideStringField;
    qryMainPrepaymentID: TIntegerField;
    qryMainFixedAssetID: TIntegerField;
    qryMainAccountNumber: TWideStringField;
    qryMainDetails: TIntegerField;
    qryMainChequeNumber: TWideStringField;
    qryMainMemo: TWideStringField;
    qryMainReferenceNo: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormDestroy(Sender: TObject);
    procedure DateChange(var Message: TMessage); message SX_DatechangeMsg;
    procedure BitBtn1Click(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
      Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

  private
    TotalsQry           : TERPQuery;
//    PrevDateTo          : TDateTime;
//    PrevDateFrom        : TDateTime;
//    fsTableName         : String;
//    fcfields            : String;
    GeneralLedgerReport: TGeneralLedgerReport;
//    Procedure CreateTemptable;


  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    Procedure PopulateReportTable ; override;
    Procedure AssignKeyId(Popupform :TBaseInputGUI); Override;
//    function DoDtFromChange(Sender:Tobject): boolean; override;
//    function DoDtToChange(Sender: TObject): boolean; override;
    //Procedure initFCFields; override;

  public
    { Public declarations }
  end;


implementation

uses
  StrUtils, Forms,
  AppEnvironment, CommonLib, CommonDbLib, MySQLConst, FastFuncs, tcConst,
  busobjStockMovement, BusobjStockAdjustEntry, busobjstockTransferentry,
  BusObjSaleBase ,SalesConst, tcDataUtils;

{$R *.dfm}
procedure TGeneralLedgerReportGUI.FormCreate(Sender: TObject);
begin
  ReportonForeignCurrency := true;
  inherited;
  SelectionOption := soClass;
  GeneralLedgerReport := TGeneralLedgerReport.Create;
  GeneralLedgerReport.ReportClassName := self.ClassName;
  EnableClosingDateBalanceCheck:=True;
//  createTempTable;
  showFCFooters := True;
  ShowChartViewOnPopup := True;
end;

procedure TGeneralLedgerReportGUI.grdMainDblClick(Sender: TObject);
begin
  if (qryMainSaleID.AsInteger > 0) or (qryMainPurchaseOrderID.AsInteger > 0) or
    (qryMainPaymentID.AsInteger > 0) or (qryMainPrepaymentID.AsInteger > 0) or
    (qryMainFixedAssetID.AsInteger > 0) then begin

          if sametext(qryMain.Fields.FieldByName('Type').AsString , TStockAdjustEntry.Transtype)    then SubsequentID := Chr(95) + AdjustType(QrymainSaleID.asInteger)  +  qryMain.Fields.FieldByName('Type').AsString
    else  if sametext(qryMain.Fields.FieldByName('Type').AsString , TStockTransferEntry.Transtype)  then SubsequentID := Chr(95) + TransferType(QrymainSaleID.asInteger)+  qryMain.Fields.FieldByName('Type').AsString
    else  SubsequentID := Chr(95) + qryMain.Fields.FieldByName('Type').AsString;

    if SameText(qryMainType.AsString,'Cash Sale') then begin
      case TSalesBase.GetSaleType(qryMainSaleID.AsInteger) of
        stPOS,
        stPOSLayby,
        stPOSLaybyPayment,
        stPOSCashSale: SubsequentID := Chr(95) + 'POS';
      end;
    end;


    inherited;
  end;
end;

procedure TGeneralLedgerReportGUI.RefreshQuery;
begin
  PopulateReportTable;
  inherited;
end;

Procedure TGeneralLedgerReportGUI.PopulateReportTable ;
var
  msg: string;
//  SQLList :TStringList;
//  ctr :Integer;
begin

  GeneralLedgerReport.DateFrom := dtFrom.Date;
  GeneralLedgerReport.DateTo := dtTo.Date;
  GeneralLedgerReport.IgnoreDates := chkIgnoreDates.Checked;
  GeneralLedgerReport.DepartmentID := self.SelectedClassID;
  GeneralLedgerReport.ReportOnForeignCurrency := self.ReportOnForeignCurrency;
  GeneralLedgerReport.PopulateReportSQL(qryMain.SQL, msg);

  self.RefreshOrignalSQL();

//    SQLList := TStringList.Create;
//    Try
//        SQLList.Add('truncate ' + fsTablename +';');
//        SQLList.add('insert into ' + fstablename);
//        SQLList.add('(Accounts , Type , Date , GlobalRef, Class , AccountName , `Client Name` , ProductName ,');
//        SQLList.add('ProductDescription ,RepName, TaxCode , TaxRate , DebitsEx, CreditsEx, DebitsInc,');
//        SQLList.add('CreditsInc, AmountEx, AmountInc, AccountNumber, ClassID, SaleID, PurchaseOrderID, PaymentID,');
//        SQLList.add('PrepaymentID, FixedAssetID, Details, AccountID, ChequeNumber, Memo, ReferenceNo');
//        if FCFields <> '' then SQLList.add(',' + FCFields);
//        SQLList.add(')');
//        SQLList.add('SELECT');
//        SQLList.add('Space(255) as Accounts,');
//        SQLList.add('Trans.Type,');
//        SQLList.add('Trans.Date,');
//        SQLList.add('Trans.GlobalRef,');
//        SQLList.add('CL.ClassName as Class,');
//        SQLList.add('Trans.AccountName as AccountName,');
//        SQLList.add('Trans.ClientName as "Client Name",');
//        SQLList.add('Trans.ProductName,');
//        SQLList.add('Trans.ProductDesc as ProductDescription,');
//        SQLList.add('RepName,');
//        SQLList.add('Trans.TaxCode,');
//        SQLList.add('(Trans.TaxRate* 100) as TaxRate,');
//        SQLList.add('DebitsEx as DebitsEx,');
//        SQLList.add('CreditsEx as CreditsEx,');
//        SQLList.add('DebitsInc as DebitsInc,');
//        SQLList.add('CreditsInc as CreditsInc,');
//        SQLList.add('If((Trans.AccountType = "AR" OR Trans.AccountType = "OASSET" OR Trans.AccountType = "BANK" OR Trans.AccountType = "OCASSET" OR Trans.AccountName = ' + QuotedStr(GLACCOUNT_TAX_PAID) + '   OR Trans.AccountName = ' + QuotedStr(GLACCOUNT_TAX_COLLECTED) + '),');
//        SQLList.add('(DebitsEx-CreditsEx),(CreditsEx-DebitsEx)) as "AmountEx",');
//        SQLList.add('If((Trans.AccountType = "AR" OR Trans.AccountType = "OASSET" OR Trans.AccountType = "BANK" OR Trans.AccountType = "OCASSET" OR Trans.AccountName = ' + QuotedStr(GLACCOUNT_TAX_PAID) + '   OR Trans.AccountName = ' + QuotedStr(GLACCOUNT_TAX_COLLECTED) + '),');
//        SQLList.add('(DebitsInc-CreditsInc),(CreditsInc-DebitsInc)) as "AmountInc",');
//        SQLList.add('COA.AccountNumber,');
//        SQLList.add('Trans.ClassID,');
//        SQLList.add('Trans.SaleID,');
//        SQLList.add('Trans.PurchaseOrderID,');
//        SQLList.add('Trans.PaymentID,');
//        SQLList.add('Trans.PrepaymentID,');
//        SQLList.add('Trans.FixedAssetID,');
//        SQLList.add('2 as Details,');
//        SQLList.add('Trans.AccountID,');
//        SQLList.add('PO.InvoiceNumber as ChequeNumber,');
////        SQLList.add('GLL.Memo as Memo,');
//        SQLList.add('if(not IsNull(GLL.GJDID),GLL.Memo,if(not IsNull(ChequeLine.PurchaseLineID),ChequeLine.Product_Description,if (not IsNull(BillLine.PurchaseLineID),BillLine.Product_Description,NULL))) as Memo,');
//        SQLList.add('if(not IsNull(Bill.PurchaseOrderID),Bill.RefNo,if(not IsNull(SP.PaymentID),SP.ReferenceNo,null))  as ReferenceNo');
//        if FCFields <> '' then SQLList.add(',' + FCFields);
//        SQLList.add('FROM tbltransactions as Trans');
//        SQLList.add('INNER JOIN tblchartofaccounts COA Using(AccountID)');
//        SQLList.add('Left JOIN tblclass CL on CL.ClassID = Trans.ClassID');
//        SQLList.add('left join tblPurchaseOrders as PO on PO.PurchaseOrderID = Trans.PurchaseOrderID and Trans.Type = "Cheque"');
//        SQLList.add('left join tblgeneraljournaldetails as GLL on GLL.GJDID = Trans.Salelineid and Trans.Type = "Journal Entry"');
//        SQLList.add('left join tblPurchaseOrders as Bill on Bill.PurchaseOrderID = Trans.PurchaseOrderID and Trans.Type = "Bill"');
//        SQLList.add('left join tblPurchaseLines as ChequeLine on ChequeLine.PurchaseLineID = Trans.PurchaseLineID and Trans.Type = "Cheque"');
//        SQLList.add('left join tblPurchaseLines as BillLine on BillLine.PurchaseLineID = Trans.PurchaseLineID and Trans.Type = "Bill"');
//        SQLList.add('left join tblwithdrawal as SP on SP.PaymentID = Trans.PaymentID and Trans.Type = "Supplier Payment"');
//        SQLList.add('Where Trans.Date Between ' + Quotedstr(Formatdatetime(MysqlDateFormat , FilterdateFrom)) + '  AND ' + Quotedstr(formatDatetime(MysqlDateFormat , FilterDateto)));
//        if not chkAllClass.Checked then
//            SQLList.add('AND Trans.ClassID = ' + cboClass.LookupValue);
//        SQLList.add('Union All');
//        SQLList.add('SELECT');
//        SQLList.add('SUBSTRING(If((char_length(COA.AccountGroup)>0),Concat(Replace(COA.AccountGroup,"^"," - ") ," - ",Trans.AccountName),Trans.AccountName),1,255) as Accounts,');
//        SQLList.add('Null as Type,');
//        SQLList.add('Null as Date,');
//        SQLList.add('"" as GlobalRef,');
//        SQLList.add('"" as Class,');
//        SQLList.add('Trans.AccountName as AccountName,');
//        SQLList.add('""  as "Client Name",');
//        SQLList.add('"" as ProductName,');
//        SQLList.add('"" as ProductDescription,');
//        SQLList.add('"" as RepName,');
//        SQLList.add('"" as TaxCode,');
//        SQLList.add('NULL as TaxRate,');
//        SQLList.add('Sum(DebitsEx) as DebitsEx,');
//        SQLList.add('Sum(CreditsEx) as CreditsEx,');
//        SQLList.add('Sum(DebitsInc) as DebitsInc,');
//        SQLList.add('Sum(CreditsInc) as CreditsInc,');
//        SQLList.add('If((Trans.AccountType = "AR" OR Trans.AccountType = "OASSET" OR Trans.AccountType = "BANK" OR Trans.AccountType = "OCASSET" OR Trans.AccountName = ' + QuotedStr(GLACCOUNT_TAX_PAID) + '   OR Trans.AccountName = ' + QuotedStr(GLACCOUNT_TAX_COLLECTED) + '),');
//        SQLList.add('Sum(DebitsEx) - Sum(CreditsEx),Sum(CreditsEx) - Sum(DebitsEx)) as "AmountEx",');
//        SQLList.add('If((Trans.AccountType = "AR" OR Trans.AccountType = "OASSET" OR Trans.AccountType = "BANK" OR Trans.AccountType = "OCASSET" OR Trans.AccountName = ' + QuotedStr(GLACCOUNT_TAX_PAID) + '   OR Trans.AccountName = ' + QuotedStr(GLACCOUNT_TAX_COLLECTED) + '),');
//        SQLList.add('Sum(DebitsInc) - Sum(CreditsInc),Sum(CreditsInc) - Sum(DebitsInc)) as "AmountInc",');
//        SQLList.add('COA.AccountNumber,');
//        SQLList.add('Null as ClassID,');
//        SQLList.add('Null as SaleID,');
//        SQLList.add('Null as PurchaseOrderID,');
//        SQLList.add('Null as PaymentID,');
//        SQLList.add('Null as PrepaymentID,');
//        SQLList.add('Null as FixedAssetID,');
//        SQLList.add('0 as Details,');
//        SQLList.add('Trans.AccountID,');
//        SQLList.add('Null as ChequeNumber,');
//        SQLList.add('Null as Memo,');
//        SQLList.add('Null as ReferenceNo');
//        if FCFields <> '' then SQLList.add(',' + FCFields);
//        SQLList.add('FROM tbltransactions as Trans');
//        SQLList.add('INNER JOIN tblchartofaccounts COA Using(AccountID)');
//        SQLList.add('Left JOIN tblclass CL on CL.ClassID = Trans.ClassID');
//        SQLList.add('Where Trans.Date Between ' + Quotedstr(Formatdatetime(MysqlDateFormat , FilterdateFrom)) + '  AND ' + Quotedstr(formatDatetime(MysqlDateFormat , FilterDateto)));
//        if not chkAllClass.Checked then
//            SQLList.add('AND Trans.ClassID = ' + cboClass.LookupValue);
//        SQLList.add('Group By Trans.AccountID');
//        SQLList.add('Union All');
//        SQLList.add('SELECT');
//        SQLList.add('"" as AccountName,');
//        SQLList.add('Trans.Type,');
//        SQLList.add('Null as Date,');
//        SQLList.add('"" as GlobalRef,');
//        SQLList.add('"" as Class,');
//        SQLList.add('Trans.AccountName as AccountName,');
//        SQLList.add('""  as "Client Name",');
//        SQLList.add('"" as ProductName, "" as ProductDescription,');
//        SQLList.add('"" as RepName,');
//        SQLList.add('"" as TaxCode,');
//        SQLList.add('NULL as TaxRate,');
//        SQLList.add('Sum(DebitsEx) as DebitsEx,');
//        SQLList.add('Sum(CreditsEx) as CreditsEx,');
//        SQLList.add('Sum(DebitsInc) as DebitsInc,');
//        SQLList.add('Sum(CreditsInc) as CreditsInc,');
//        SQLList.add('If((Trans.AccountType = "AR" OR Trans.AccountType = "OASSET" OR Trans.AccountType = "BANK" OR Trans.AccountType = "OCASSET" OR Trans.AccountName = ' + QuotedStr(GLACCOUNT_TAX_PAID) + '   OR Trans.AccountName = ' + QuotedStr(GLACCOUNT_TAX_COLLECTED) + '),');
//        SQLList.add('Sum(DebitsEx) - Sum(CreditsEx),Sum(CreditsEx) - Sum(DebitsEx)) as "AmountEx",');
//        SQLList.add('If((Trans.AccountType = "AR" OR Trans.AccountType = "OASSET" OR Trans.AccountType = "BANK" OR Trans.AccountType = "OCASSET" OR Trans.AccountName = ' + QuotedStr(GLACCOUNT_TAX_PAID) + '   OR Trans.AccountName = ' + QuotedStr(GLACCOUNT_TAX_COLLECTED) + '),');
//        SQLList.add('Sum(DebitsInc) - Sum(CreditsInc),Sum(CreditsInc) - Sum(DebitsInc)) as "AmountInc",');
//        SQLList.add('COA.AccountNumber,');
//        SQLList.add('Null as ClassID,');
//        SQLList.add('Null as SaleID,');
//        SQLList.add('Null as PurchaseOrderID,');
//        SQLList.add('Null as PaymentID,');
//        SQLList.add('Null as PrepaymentID,');
//        SQLList.add('Null as FixedAssetID,');
//        SQLList.add('1 as Details,');
//        SQLList.add('Trans.AccountID,');
//        SQLList.add('Null as ChequeNumber,');
//        SQLList.add('Null as Memo,');
//        SQLList.add('Null as ReferenceNo');
//        if FCFields <> '' then SQLList.add(',' + FCFields);
//        SQLList.add('FROM tbltransactions as Trans');
//        SQLList.add('INNER JOIN tblchartofaccounts COA Using(AccountID)');
//        SQLList.add('Left JOIN tblclass CL on CL.ClassID = Trans.ClassID');
//        SQLList.add('Where Trans.Date Between ' + Quotedstr(Formatdatetime(MysqlDateFormat , FilterdateFrom)) + '  AND ' + Quotedstr(formatDatetime(MysqlDateFormat , FilterDateto)));
//        if not chkAllClass.Checked then
//            SQLList.add('AND Trans.ClassID = ' + cboClass.LookupValue);
//        SQLList.add('Group By Trans.AccountID,Type');
//        SQLList.add('Order By AccountID,Details;');
//        if FConReport.RecordCount > 0 then begin
//            FCOnReport.first;
//            while FConReport.Eof = False do begin
//                for ctr := low(Amountfields) to high(Amountfields) do
//                    SQLList.add('update ' +fstablename + ' set ' +  FCOnReportCode.asString + '_' + amountfields[ctr] + '  = ' + Amountfields[ctr] + ' * ' + FCOnReportCode.asString + '_FCRate;' );
//                FConReport.next;
//            end;
//        end;
//        With CommonDbLib.TempMyScript do try
//          connection := Qrymain.Connection;
//          SQL.add(ChangeQuery(SQLList.text));
//          execute;
//        finally
//            free;
//        end;
//    finally
//        FreeandNil(SQLList);
//    end;
end;

procedure TGeneralLedgerReportGUI.RefreshTotals;
var
    fsFilter :STring;
begin
    Qrymain.disablecontrols;
    try
        fsFilter := Qrymain.filter;
        if fsfilter <> '' then
            qrymain.filter := Qrymain.filter + ' AND Details = ' + IntToStr(grpFilters.ItemIndex)
        else
            qrymain.filter := ' Details = ' + IntToStr(grpFilters.ItemIndex);
        qrymain.filtered := True;
        inherited;
    finally
        if fsfilter <> '' then begin
            Qrymain.filter := fsFilter;
            qrymain.filtered := True;
        end else qrymain.filtered := False;
        qrymain.enablecontrols;
    end;
end;

procedure TGeneralLedgerReportGUI.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Totalsqry);
//  DeleteTable(fstablename);
  GeneralLedgerReport.Free;
  inherited;
end;

procedure TGeneralLedgerReportGUI.DateChange(var Message: TMessage);
begin
  if not (dtTo.DroppedDown or dtFrom.DroppedDown) then begin
    RefreshQuery;
  end;
end;

//function TGeneralLedgerReportGUI.DoDtFromChange(Sender:TObject): boolean;
//begin
//  result:= false;
//  if not (FilterdateFrom = PrevDateFrom) then begin
//    PostMessage(self.Handle, SX_DatechangeMsg, 0, 0);
//    result:= true;
//  end;
//  PrevDateFrom := FilterdateFrom;
//end;

//function TGeneralLedgerReportGUI.DoDtToChange(Sender:TObject): boolean;
//begin
//  result:= false;
//  if not (FilterDateto = PrevDateTo) then begin
//    PostMessage(self.Handle, SX_DatechangeMsg, 0, 0);
//    result:= true;
//  end;
//  PrevDateTo := FilterDateto;
//end;

procedure TGeneralLedgerReportGUI.BitBtn1Click(Sender: TObject);
begin
  RefreshQuery;
end;

procedure TGeneralLedgerReportGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if not Empty(qryMainAccounts.AsString) then begin
    AFont.Style := AFont.Style + [fsBold];
  end;
end;

procedure TGeneralLedgerReportGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin {Summary}
        GroupFilterString := '(Details = 0)';
      end;

    1:
      begin {Details}
        GroupFilterString := '(Details <> 2)';
      end;

    2:
      begin  {Extra Details}
        GroupFilterString := '(Details <> 1)';
      end;
  end;
  inherited;
end;

procedure TGeneralLedgerReportGUI.AssignKeyId(Popupform: TBaseInputGUI);
begin
  Popupform.KeyId := 0;
  if (Sysutils.SameText(qryMainType.asString , TStockTransferEntry.Transtype)) or
            (Sysutils.SameText(qryMainType.asString , TStockAdjustEntry.Transtype))  then begin
     Popupform.KeyId := QrymainSaleID.asInteger;
  end;
  if Popupform.KeyId = 0 then inherited;
end;

//procedure TGeneralLedgerReportGUI.CreateTemptable;
//var
//    SQLList :TStringList;
//    ctr :Integer;
//begin
//    fsTablename := commondbLib.CreateUserTemporaryTable('tmp_GeneralLedger' , '');
//    FCFields := '';
//    SQLList := TStringList.Create;
//    Try
//        if FConReport.RecordCount > 0 then begin
//            FCOnReport.first;
//            while FConReport.Eof = False do begin
//                SQLList.add('Alter table ' + fsTablename + ' Add column  ' + FCOnReportCode.asString + '_FCRate Double,');
//                for ctr := low(Amountfields) to high(Amountfields) do begin
//                    if ctr > 0 then SQLList.add(',');
//                    SQLList.add('Add column  ' + FCOnReportCode.asString + '_' + amountfields[ctr] + ' Double' );
//                end;
//                SQLList.add(';');
//                if FCFields <> '' then FCFields := FCFields + ',' ;
//                FCFields := FCFields + FCOnReportCode.asString + '_FCRate';
//                FCOnReport.Next;
//              end;
//            with CommonDbLib.TempMyScript do try
//              SQl.add(SQLList.Text);
//              Execute;
//            finally
//                Free;
//            end;
//        end;
//    finally
//        Freeandnil(SQLList);
//    end;
//    qrymain.SQl.text := StringReplace(Qrymain.SQL.text , 'tmp_generalledger' , fsTablename, [rfIgnoreCase]);
//    RefreshOrignalSQL;
//end;

procedure TGeneralLedgerReportGUI.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose:= True;
end;

initialization
  RegisterClassOnce(TGeneralLedgerReportGUI);

end.
