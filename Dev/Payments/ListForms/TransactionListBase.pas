unit TransactionListBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel , TransactionListSQL;

type
  TTransactionListBaseGUI = class(TBaseListingGUI)
    procedure FormCreate(Sender: TObject);
    procedure chkIgnoreDatesClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FCFields :String;
    fsGlobalref: String;
  Protected
    fsTablename :STring;
    aTransactionListReport : TTransactionListReport;
    //procedure CreateReportTable;
    Procedure PopulateReportTable; override;
    Function TransactionListReport :TTransactionListReport;
    Function TransListtype : TTransListtype; virtual;abstract;
  public
    Property Globalref :String read fsGlobalref write fsGlobalref;
  end;


implementation

uses CommonDbLib, DbSharedObjectsObj, MySQLConst, CommonLib, tcConst, LogLib;

{$R *.dfm}

procedure TTransactionListBaseGUI.FormCreate(Sender: TObject);
begin
  fsGlobalref := '';
  fsTablename := CommonDbLib.GetUserTemporaryTableName('tmp_transactionjournal' );
  pnlIncludehistory.Visible := true;
  inherited;
  aTransactionListReport := nil;
end;

procedure TTransactionListBaseGUI.FormDestroy(Sender: TObject);
begin
  Freeandnil(aTransactionListReport);
  inherited;

end;

function TTransactionListBaseGUI.TransactionListReport: TTransactionListReport;
begin
  if aTransactionListReport = nil then
    aTransactionListReport := TTransactionListReport.create;
  result := aTransactionListReport;
end;
procedure TTransactionListBaseGUI.PopulateReportTable;
var
  msg :String;
begin
  with TransactionListReport do begin
    DateFrom            := FilterdateFrom;
    DateTo              := FilterDateTo;
    FConReport          := Self.fFConReport;
    FilterIndex         := grpfilters.itemindex;
    selectedClassId     := Self.selectedClassId;
    IncludedataPriorToClosingDate := self.IncludedataPriorToClosingDate;
    IsLimit0selection   := self.IsLimit0selection;
    globalref := Self.globalref;
    TransListtype := sElf.TransListtype;
    ListClassname := Self.classname;
    //DoPopulateReportTable;
    //PopulateReportSQL(Qrymain.sql, msg);
  end;
{var
  ctr, i:Integer;
  transtypes :Array of String;
Function summaryTransMultiplier :Integer;
begin
  if ctr = 1 then begin
    Result := 0;
    Exit;
  end;
  With tempMyquery do try
     SQL.Add('Select Max(transID) as transID  from tbltransactions ');
     open;
     REsult := fieldbyname('transID').AsInteger;
  finally

  end;
end;
Procedure populateTranstypes;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    Qry.SQL.Text := 'Select distinct type from tbltransactions '+
                    ' Where Date Between ' + quotedstr(formatdateTime(MysqlDateTimeFormat , FilterdateFrom)) +' AND  ' + quotedstr(formatdateTime(MysqlDateTimeFormat , FilterdateTo)) ;
    Qry.open;
    StepProgressbar;
    setlength( transtypes  ,0);
    if Qry.recordcount =0 then exit;
    Qry.first;
    while Qry.eof = false do begin
      setlength( transtypes  ,length(transtypes )+1);
      transtypes[high(transtypes)] :=Qry.fieldbyname('type').AsString;
      Qry.Next;
    StepProgressbar;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
begin
Processingcursor(True);
try
  showProgressbar(WAITMSG, 20);
  try
    CreateReportTable;
    StepProgressbar;
    populateTranstypes;
  finally
    HideProgressbar;
  end;

  if IsLimit0selection  then else begin
    if length(transtypes)>0 then
      with Scriptmain do begin
        SQL.Clear;
        for i := low(transtypes) to high(transtypes) do begin
              for ctr:= 1 to 2 do begin
                if (ctr =1) or (IncludedataPriorToClosingDate) then begin
                  SQL.Add('/*1 - '+inttostr(i)+' of ' + inttostr(high(transtypes)) +' */ insert into ' + fsTablename +
                                     ' (Category , Date,'+
                                     ' GlobalRef,'+
                                     ' Type,'+
                                     ' CLIENTNAME,'+
                                     ' ClassID,'+
                                     ' SaleID,'+
                                     ' SaleLineID,'+
                                     ' PurchaseOrderID,'+
                                     ' PurchaseLineID,'+
                                     ' PaymentID,'+
                                     ' PrepaymentID,'+
                                     ' FixedAssetID,'+
                                     ' AccountName,'+
                                     ' AccountID,'+
                                     ' AccountType ,'+
                                     ' DebitsEx,'+
                                     ' CreditsEx,'+
                                     ' DebitsInc,'+
                                     ' CreditsInc,'+
                                     ' CashDebitsEx,'+
                                     ' CashCreditsEx,'+
                                     ' CashDebitsInc,'+
                                     ' CashCreditsInc,'+
                                     ' ProductName,'+
                                     ' ProductGroup,'+
                                     ' ProductDesc,'+
                                     ' TransTimeStamp,'+
                                     ' TaxCode,'+
                                     ' Account, AccountNumber, EmployeeID, Seqno, transId , Beforeclosing'+
                                     iif(FCFields <> '' ,',' + FCFields , '')+
                                     ' ) ' + NL +
                                     ' SELECT ' + inttostr(summaryTransMultiplier) +'+  1, '+
                                     ' Trans.Date ,'+
                                     ' Trans.GlobalRef ,'+
                                     ' Trans.Type ,'+
                                     ' ClientName ,'+
                                     ' Trans.ClassID ,'+
                                     ' Trans.SaleID ,'+
                                     ' Trans.SaleLineID ,'+
                                     ' Trans.PurchaseOrderID ,'+
                                     ' Trans.PurchaseLineID ,'+
                                     ' Trans.PaymentID ,'+
                                     ' Trans.PrepaymentID ,'+
                                     ' Trans.FixedAssetID ,'+
                                     ' null, '+//'SUBSTRING(If((char_length(AccountGroup)>0),Concat(Replace(AccountGroup,"^"," - ") ," - ",Trans.AccountName),Trans.AccountName),1,255) ,'+
                                     ' Trans.AccountID ,'+
                                     ' Trans.AccountType as AccountType, /*tblacctypedesc.AccDesc ,*/'+
                                     ' DebitsEx ,'+
                                     ' CreditsEx ,'+
                                     ' DebitsInc ,'+
                                     ' CreditsInc ,'+
                                     ' Cash_DebitsEx ,'+
                                     ' Cash_CreditsEx ,'+
                                     ' Cash_DebitsInc ,'+
                                     ' Cash_CreditsInc ,'+
                                     ' ProductName ,'+
                                     ' ProductGroup ,'+
                                     ' ProductDesc ,'+
                                     ' Trans.msTimeStamp as TransTimeStamp,'+
                                     ' Trans.TaxCode ,'+
                                     ' Trans.AccountName ,'+
                                     ' null as AccountNumber , /*tblchartofaccounts.AccountNumber ,*/'+
                                     ' Trans.EmployeeID, trans.Seqno , trans.transId , '+
                                      iif(ctr = 1 ,Quotedstr('T'), Quotedstr('F'))+
                                      iif(FCFields <> '' ,',' + FCFields , '')+
                                      iif(ctr = 1 ,' FROM tbltransactions as Trans', iif(ctr = 2,' FROM tbltransactionsummarydetails as Trans' , ''))+
                                     (*' INNER JOIN tblchartofaccounts Using(AccountID)'+
                                     ' LEFT JOIN tblacctypedesc On tblacctypedesc.AccType=Trans.AccountType '+*)
                                     iif(globalref <> '',' Where Trans.Globalref = ' + quotedstr(globalref) ,
                                     ' Where trans.Date Between ' + quotedstr(formatdateTime(MysqlDateTimeFormat , FilterdateFrom)) +' AND  ' + quotedstr(formatdateTime(MysqlDateTimeFormat , FilterdateTo)) +
                                     ' and trans.type =' +quotedstr(transtypes[i])+
                                     iif(selectedClassId <> 0 ,'  AND Trans.ClassID = ' + inttostr(selectedClassId), ''))+
                                     iif((ctr = 1) and IncludedataPriorToClosingDate ,' and trans.type <> ''Closing Date Summary'' and Seqno <100' , '')+
                                     ' Order by Trans.SaleID ,Trans.SaleLineID ,Trans.PurchaseOrderID ,Trans.PurchaseLineID ,Trans.PaymentID ,Trans.PrepaymentID ,Trans.FixedAssetID;');
                end;
              end;
          end;
        if devmode OR not(self.classnameis('TTransactionListGUI')) then
        else begin
            SQL.add('/*2-1*/ALTER TABLE  ' + fsTablename + ' ADD INDEX `AccountID` (`AccountID`);');
            SQL.add('/*2-2*/ALTER TABLE  ' + fsTablename + ' ADD INDEX `SaleLineId` (`SaleLineId`);');
            SQL.add('/*2-3*/ALTER TABLE  ' + fsTablename + ' ADD INDEX `PurchaseOrderID` (`PurchaseOrderID`);');
            SQL.add('/*2-4*/ALTER TABLE  ' + fsTablename + ' ADD INDEX `PurchaseLineID` (`PurchaseLineID`);');
            SQL.add('/*2-5*/ALTER TABLE  ' + fsTablename + ' ADD INDEX `AccountType` (`AccountType`);');

            SQL.add('/*4*/update ' + fsTablename + ' T INNER JOIN tblchartofaccounts COA Using(AccountID) Set T.AccountNumber = COA.AccountNumber;');
            SQL.add('/*5*/update ' + fsTablename + ' T INNER JOIN tblchartofaccounts COA Using(AccountID) Set T.Accountname = SUBSTRING(If((char_length(COA.AccountGroup)>0),Concat(Replace(COA.AccountGroup,"^"," - ") ," - ",COA.AccountName),COA.AccountName),1,255);');

            SQL.add('/*6*/update ' + fsTablename + ' T INNER JOIN tblacctypedesc ATD  on ATD.AccType=T.AccountType Set T.AccountType = ATD.AccDesc  ;');
            SQL.add('/*7*/update ' + fsTablename + ' T inner join tblEmployees      emp on emp.Employeeid = T.employeeid Set T.Employeename = emp.EmployeeName;' );
            SQL.add('/*8*/update ' + fsTablename + ' T inner join tblClass          CLS on cls.ClassId    = T.ClassId    Set T.Department = CLS.ClassName;' );
            SQL.add('/*9*/update ' + fsTablename + ' T ');
            SQL.add('  left join tblgeneraljournaldetails GLL on GLL.GJDID = T.SaleLineId and T.type = "Journal Entry"');
            SQL.add('  left join tblPurchaseOrders as Bill on Bill.PurchaseOrderID = T.PurchaseOrderID and T.Type = "Bill"');
            SQL.add('  left join tblPurchaseLines as ChequeLine on ChequeLine.PurchaseLineID = T.PurchaseLineID and T.Type = "Cheque"');
    //        SQL.add('  Set T.Memo = ifnull(J.Memo, "") ;' );
            SQL.add('  Set T.Memo = if(not IsNull(GLL.GJID),GLL.Memo,if(not IsNull(ChequeLine.PurchaseLineID),ChequeLine.Product_Description,NULL));');
            SQL.add('/*10*/update ' + fsTablename + ' T ');
            SQL.add('inner join tblPurchaseOrders as Bill on Bill.PurchaseOrderID = T.PurchaseOrderID and T.Type = "Bill"');
            SQL.add('  Set T.ReferenceNo =  Bill.RefNo;');
            if FConReport.RecordCount > 0 then begin
                FCOnReport.first;
                while FConReport.Eof = False do begin
                    SQL.add('/*11-'+inttostr(FConReport.recno)+' of ' + inttostr(FConReport.RecordCount) +' */update ' + fsTablename + ' set ' );
                    SQL.add(FCOnReportCode.asString + '_DebitsEx =DebitsEx    * ' + FCOnReportCode.asString + '_FCRate, ' );
                    SQL.add(FCOnReportCode.asString + '_CreditsEx =CreditsEx  * ' + FCOnReportCode.asString + '_FCRate, ' );
                    SQL.add(FCOnReportCode.asString + '_DebitsInc =DebitsInc  * ' + FCOnReportCode.asString + '_FCRate, ' );
                    SQL.add(FCOnReportCode.asString + '_CreditsInc =CreditsInc* ' + FCOnReportCode.asString + '_FCRate; ' );
                    FCOnReport.Next;
                end;
            end;
            // just to group the transaction records
            SQL.add('/*12*/update ' + fsTablename + ' T Set type = trim(replace(type , "Un-Invoiced" , "")) where type <> "Un-Invoiced";' );
        end;

        SQL.text := ChangeQuery(SQL.Text);
        clog(SQL.Text);
        ExecutewithProgress;
    end;
  end;
finally
  HideProgressbar;
end;}
end;

procedure TTransactionListBaseGUI.chkIgnoreDatesClick(Sender: TObject);
begin
  if chkIgnoreDates.checked then
    chkIncludehistory.checked := True;
  inherited;
end;

(*Procedure TTransactionListBaseGUI.CreateReportTable;
begin

    FCFields := '';
    With Scriptmain do begin
        SQl.Clear;
        SQL.Add(CreateUserTemporaryTableSQL(fstablename , 'tmp_transactionjournal'));
        if FConReport.RecordCount > 0 then begin
            FCOnReport.first;
            while FConReport.Eof = False do begin
                SQL.add('Alter table ' + fsTablename + ' Add column  ' + FCOnReportCode.asString + '_FCRate Double,');
                SQL.add(' Add column  ' + FCOnReportCode.asString + '_DebitsEx Double,' );
                SQL.add(' Add column  ' + FCOnReportCode.asString + '_CreditsEx  Double,' );
                SQL.add(' Add column  ' +  FCOnReportCode.asString + '_DebitsInc  Double, ' );
                SQL.add( ' Add column  ' + FCOnReportCode.asString + '_CreditsInc Double;');
                if FCFields <> '' then FCFields := FCFields + ',' ;
                FCFields := FCFields + FCOnReportCode.asString + '_FCRate';
                FCOnReport.Next;
              end;
        end;
        logtext(SQL.Text);
        Execute;
    end;
end;*)
end.
