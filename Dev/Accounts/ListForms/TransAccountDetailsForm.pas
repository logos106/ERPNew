unit TransAccountDetailsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, MemDS, DBAccess, MyAccess,ERPdbComponents,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, BaseInputForm, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TTransAccountDetailsGUI = class(TBaseListingGUI)
    qryMainDate: TDateField;
    qryMainType: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainAccountName: TWideStringField;
    qryMainDebitsEx: TFloatField;
    qryMaindebitsInc: TFloatField;
    qryMaincreditsEx: TFloatField;
    qryMainCreditsInc: TFloatField;
    qryMainAmountEx: TFloatField;
    qryMainAmountInc: TFloatField;
    qryMainClassID: TIntegerField;
    qryMainSaleID: TIntegerField;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainPaymentID: TIntegerField;
    qryMainTransID: TIntegerField;
    qryMainClass: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainProductDesc: TWideStringField;
    qryMainTaxCode: TWideStringField;
    qryMainNotes: TWideStringField;
    qryMainEmployeeID: TIntegerField;
    qryMainClientName: TWideStringField;
    qryMainPrepaymentID: TIntegerField;
    qryMainFixedAssetID: TIntegerField;
    qryMainTaxAmount: TFloatField;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure SctMainError(Sender: TObject; E: Exception; SQL: string;
      var Action: TErrorAction);
  private
    { Private declarations }
    fDateTo: TDateTime;
    fDateFrom: TDateTime;
    fWhereString: string;
    fInverseCreditvsDebits: Boolean;
    fsTablename :String;
    ficlientId: Integer;
    procedure CreateTempTable;
    procedure BeforBlindBalanceShow(Sender: TObject);
    procedure AfterBlindBalanceShow(Sender: TObject);
  protected
    PopulateReportTableDone: boolean;
    Procedure PopulateReportTable; override;
    Procedure AssignKeyId(Popupform :TBaseInputGUI); Override;
    procedure onLoadmemtable;Override;

  public
    CallingClassName:String;
    procedure RefreshTotals; override;
    property ToDate: TDateTime read fDateTo write fDateTo;
    property FromDate: TDateTime read fDateFrom write fDateFrom;
    property WhereString: string read fWhereString write fWhereString;
    property InverseCreditvsDebits: Boolean read fInverseCreditvsDebits write fInverseCreditvsDebits;
    Property clientId :Integer read ficlientId write ficlientId;
    procedure RefreshQuery; override;
    Function totalTaxAmount :Double;
  end;


implementation

uses strUtils, ChartOfAccountsListForm,
     Forms, CommonLib, CommonDbLib, FastFuncs, busobjStockMovement,
  BusobjStockAdjustEntry, busobjstockTransferentry, BusObjSaleBase, SalesConst,
  tcDataUtils, CommonFormLib, LogLib;

{$R *.dfm}

procedure TTransAccountDetailsGUI.grpFiltersClick(Sender: TObject);
begin
  //
end;
Procedure TTransAccountDetailsGUI.onLoadmemtable;
begin
  if fstablename <> '' then begin
    DestroyUserTemporaryTable(fsTablename);
    fsTablename := '';
  end;
end;
Procedure TTransAccountDetailsGUI.PopulateReportTable;
var
    SQLList :TStringList;
    FCFields : String;
    ctr:Integer;
begin
    if PopulateReportTableDone then exit;
    PopulateReportTableDone := true;
    try
        CreateTempTable;
        FCFields := '';
        SQLList := TStringList.Create;
        Try
            SQLList.Add('Truncate ' + fsTablename +';');
            SQLList.Add('insert into ' + fsTablename );
            SQLList.Add('(seqno, `Date`,`Class`,`Type`,`GlobalRef`,`AccountName`,`ClientName`,DebitsEx, debitsinc, creditsEx, creditsInc, ');
            SQLList.Add('`Amount (Ex)`,`Tax Amount`,`Amount (Inc)`,`ClassID`,`SaleID`,`PurchaseOrderID`,');
            SQLList.Add('`PaymentID`,`PrepaymentID`,`FixedAssetID`,`TransID`,`ProductName`,`ProductDesc`,`TaxCode`,');
            SQLList.Add('`Notes`,`EmployeeID` , AccountType,AccountID, COALevel1, COALevel2, COALevel3, COALevel4,');
            SQLList.Add('Level1,Level2,Level3,Level4');
            if FCFields <> '' then SQLList.add(',' + FCFields);
            SQLList.Add(')');

            for ctr:= 1 to 2 do begin
              if (ctr =1 ) OR   IncludedataPriorToClosingDate then begin
                SQLList.Add('SELECT Seqno, Date,ClassName as Class, Type, T.GlobalRef,');
                SQLList.Add('AccountName,');
                SQLList.Add('ClientName,');
                SQLList.Add('DebitsEx,DebitsInc, CreditsEx, creditsInc,');
                If fInverseCreditvsDebits then Begin
                    SQLList.Add('CreditsEx-DebitsEx as `Amount (Ex)`,');
                  //SQLList.Add('if(Type in ( "Invoice"  ,"Refund" ,"Cash Sale" ) or (type = "Journal Entry"  and tblgeneraljournal.TaxSelect="INPUT"), (CreditsInc-DebitsInc)-(CreditsEx-DebitsEx)  , (DebitsInc-CreditsInc)-(DebitsEx-CreditsEx)) as `Tax Amount`,');
                    SQLList.Add('if(Type in ( "Invoice"  ,"Refund" ,"Cash Sale" ) or (type = "Journal Entry"  and tblgeneraljournal.TaxSelect<>"INPUT"), (DebitsInc-CreditsInc)-(DebitsEx-CreditsEx)  , (CreditsInc-DebitsInc)-(CreditsEx-DebitsEx) ) as `Tax Amount`,');
                  //SQLList.Add('(CreditsInc-DebitsInc)-(CreditsEx-DebitsEx) as `Tax Amount`,');
                    SQLList.Add('CreditsInc-DebitsInc as `Amount (Inc)`,');
                end else begin
                    SQLList.Add('DebitsEx-CreditsEx as `Amount (Ex)`,');
                    //SQLList.Add('if(Type in ( "Invoice"  ,"Refund" ,"Cash Sale" ) or (type = "Journal Entry"  and tblgeneraljournal.TaxSelect="INPUT") , (DebitsInc-CreditsInc)-(DebitsEx-CreditsEx), (CreditsInc-DebitsInc)-(CreditsEx-DebitsEx) ) as `Tax Amount`,');
                    SQLList.Add('if(Type in ( "Invoice"  ,"Refund" ,"Cash Sale" ) or (type = "Journal Entry"  and tblgeneraljournal.TaxSelect<>"INPUT") , (CreditsInc-DebitsInc)-(CreditsEx-DebitsEx), (DebitsInc-CreditsInc)-(DebitsEx-CreditsEx) ) as `Tax Amount`,');
                    //SQLList.Add('(DebitsInc-CreditsInc)-(DebitsEx-CreditsEx) as `Tax Amount`,');
                    SQLList.Add('DebitsInc-CreditsInc as `Amount (Inc)`,');
                end;
                SQLList.Add('T.ClassID, SaleID, PurchaseOrderID, PaymentID, PrepaymentID, FixedAssetID,');
                SQLList.Add('TransID,ProductName, ProductDesc, TaxCode,Notes, EmployeeID, AccountType,AccountID,');
                SQLList.Add('T.Level1,T.Level2 , T.Level3 , T.Level4,');
                SQLList.Add('tblClass.Level1, tblClass.Level2, tblClass.Level3, tblClass.Level4');
                if FCFields <> '' then SQLList.add(',' + FCFields);
                SQLList.Add('FROM ');

                if ctr = 1 then SQLList.Add('tbltransactions T ')
                else SQLList.Add('tbltransactionsummarydetails T');

                SQLList.Add('LEFT JOIN tblgeneraljournal ON (T.SaleID=GJID AND T.Type = "Journal Entry" ) ');
                SQLList.Add('LEFT Join tblClass Using(ClassID)');
                SQLList.Add('WHERE CreditsEx-DebitsEx <> 0 ');
                if clientId <> 0 then SQLList.Add('AND  T.clientId = ' + inttostr(clientId));
                if (ctr =1 ) and   IncludedataPriorToClosingDate then begin
                  SQLList.Add('and T.Type <> "Closing Date Summary"');
                  SQLList.Add('union all ');
                end;
              end;
            end;

            SQLList.Add(';');
            if FConReport.RecordCount > 0 then begin
                FCOnReport.first;
                while FConReport.Eof = False do begin
                    SQLList.add('update ' + fsTablename + ' set ' );
                    SQLList.add('`' + FCOnReportCode.asString + '_DebitsEx` =`DebitsEx`   * `' + FCOnReportCode.asString + '_FCRate`, ' );
                    SQLList.add('`' + FCOnReportCode.asString + '_DebitsInc` =`DebitsInc`   * `' + FCOnReportCode.asString + '_FCRate`, ' );
                    SQLList.add('`' + FCOnReportCode.asString + '_CreditsEx` =`CreditsEx`   * `' + FCOnReportCode.asString + '_FCRate`, ' );
                    SQLList.add('`' + FCOnReportCode.asString + '_CreditsInc` =`CreditsInc`   * `' + FCOnReportCode.asString + '_FCRate`, ' );
                    SQLList.add('`' + FCOnReportCode.asString + '_Amount (Ex)` =`Amount (Ex)`   * `' + FCOnReportCode.asString + '_FCRate`, ' );
                    SQLList.add('`' + FCOnReportCode.asString + '_Tax Amount` =`Tax Amount`     * `' + FCOnReportCode.asString + '_FCRate`, ' );
                    SQLList.add('`' + FCOnReportCode.asString + '_Amount (Inc)` =`Amount (Inc)` * `' + FCOnReportCode.asString + '_FCRate`; ' );
                    FCOnReport.Next;
                end;
            end;
            clog(SQLList.text);
            ExecuteSQL(ChangeQuery(SQLList.text));
        finally
            FreeandNil(SQLLIst);
        end;
    finally
      PopulateReportTableDone := False;
    end;
end;


procedure TTransAccountDetailsGUI.RefreshQuery;
begin
ProcessingCursor(True);
try
  qryMain.Close;
  PopulateReportTable;
  qryMain.Params.ParamByName('txtfrom').AsDatetime := FilterDateFrom;
  qryMain.Params.ParamByName('txtto').AsDatetime := FilterDateTo;
  inherited;
  if qryMain.recordcount > 0 then qryMain.first;
finally
  Processingcursor(False);
end;
end;

procedure TTransAccountDetailsGUI.grdMainDblClick(Sender: TObject);
begin

        if (Sysutils.SameText(qryMainType.asString , TStockAdjustEntry.Transtype))    then SubsequentID := Chr(95) + AdjustType(QrymainSaleID.asInteger)   +  qryMain.Fields.FieldByName('Type').AsString
  else  if (Sysutils.SameText(qryMainType.asString , TStockTransferEntry.Transtype))  then SubsequentID := Chr(95) + TransferType(QrymainSaleID.asInteger) +  qryMain.Fields.FieldByName('Type').AsString
  else  SubsequentID := Chr(95) + qryMain.Fields.FieldByName('Type').AsString;

  if SameText(qryMain.Fields.FieldByName('Type').AsString,'Cash Sale') then begin
    case TSalesBase.GetSaleType(qryMain.Fields.FieldByName('SaleID').AsInteger) of
      stPOS,
      stPOSLayby,
      stPOSLaybyPayment,
      stPOSCashSale: SubsequentID := Chr(95) + 'POS';
    end;
  end
  else if SameText(qryMain.Fields.FieldByName('Type').AsString,'POS EOP Variance') then begin
    OpenERPListForm('TfrmBlindBalanceReport', BeforBlindBalanceShow, AfterBlindBalanceShow);
    exit;
  end;
  inherited;
end;

procedure TTransAccountDetailsGUI.FormShow(Sender: TObject);
begin
  GuiPrefs.DbGridElement[grdMain].RemoveFields('FixedAssetID,PrepaymentID,' +
    'ClassID,SaleID,PurchaseOrderID,PaymentID,TransID,EmployeeID');
  fbNoRequery := true;
  try
    fbFormOpenedOk  := false;
    ErrorOccurred   := true; // To Stop RefreshQuery On Date Set
    dtFrom.DateTime := fDateFrom;
    dtTo.DateTime   := fDateTo;
    inherited;
  finally
    ErrorOccurred  := false;
    fbFormOpenedOk := true;
    fbNoRequery    := false;
  end;
//  RefreshQuery;
end;

procedure TTransAccountDetailsGUI.RefreshTotals;
begin
  inherited;
end;


procedure TTransAccountDetailsGUI.SctMainError(Sender: TObject; E: Exception;
  SQL: string; var Action: TErrorAction);
begin
  if pos('Duplicate column Name' , E.message)>0 then
    Action := eaContinue
  else inherited;

end;

function TTransAccountDetailsGUI.totalTaxAmount: Double;
begin
  result := FooterValue('TaxAmount');
end;

procedure TTransAccountDetailsGUI.BeforBlindBalanceShow(Sender: TObject);
begin
  TBaseListingGUI(Sender).FilterString := 'PeriodId = ' + qryMainSaleID.AsString;
end;

procedure TTransAccountDetailsGUI.CreateTempTable;
var
  //SQLList :TStringList;
  FCFields : String;
begin
  if fsTablename = '' then begin
    fsTablename := commondbLib.CreateUserTemporaryTable('tmp_transaccountdetails' , fsTablename);
    if FConReport.RecordCount > 0 then begin
          FCFields:= '';
          FCOnReport.first;
          with scriptmain do begin
            SQL.clear;
            while FConReport.Eof = False do begin
              SQL.add(' Alter table ' + fsTablename+' Add column  `' + FCOnReportCode.asString + '_DebitsEx` Double;');
              SQL.add(' Alter table ' + fsTablename+' Add column  `' + FCOnReportCode.asString + '_DebitsInc` Double;');
              SQL.add(' Alter table ' + fsTablename+' Add column  `' + FCOnReportCode.asString + '_CreditsEx` Double;');
              SQL.add(' Alter table ' + fsTablename+' Add column  `' + FCOnReportCode.asString + '_CreditsInc` Double;');
              SQL.add(' Alter table ' + fsTablename+' Add column  `' + FCOnReportCode.asString + '_FCRate` Double;');
              SQL.add(' Alter table ' + fsTablename+' Add column  `' + FCOnReportCode.asString + '_Amount (Ex)` Double;' );
              SQL.add(' Alter table ' + fsTablename+' Add column  `' + FCOnReportCode.asString + '_Tax Amount`  Double;' );
              SQL.add(' Alter table ' + fsTablename+' Add column  `' +  FCOnReportCode.asString + '_Amount (Inc)`  Double;');
              if FCFields <> '' then FCFields := FCFields + ',' ;
              FCFields := FCFields + FCOnReportCode.asString + '_FCRate';
              FCOnReport.Next;
            end;
            if SQL.count >0 then Execute;
          end;
    end;
  end;
  Qrymain.Close;
  Qrymain.SQL.clear;
  Qrymain.SQL.add('select ');
  Qrymain.SQL.add('T.*  ');
  Qrymain.SQL.add('from ' + fsTablename +'  T');
  Qrymain.SQL.add('Where T.`Amount (Ex)` <>0 and T.Date Between :txtfrom AND :txtto');
  if wherestring <> '' then Qrymain.SQL.add(wherestring);
  RefreshOrignalSQL(false);
end;

procedure TTransAccountDetailsGUI.FormCreate(Sender: TObject);
begin
  PopulateReportTableDone := false;
//  fbIncludehistory:= True;
  ficlientId:=0;
  ReportonForeignCurrency := true;
  fsTablename := '';
  inherited;
  CreateTempTable;
  SearchMode:= smFullList;

  ShowFCFooters := True;
  CallingClassName:='';
end;

procedure TTransAccountDetailsGUI.FormDestroy(Sender: TObject);
begin
  CommonDbLib.DestroyUserTemporaryTable(fsTablename);
  inherited;
end;

procedure TTransAccountDetailsGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := QuotedStr('Date') + ' DESC CIS';
end;

procedure TTransAccountDetailsGUI.AfterBlindBalanceShow(Sender: TObject);
begin
  TBaseListingGUI(Sender).chkIgnoreDates.Checked := true;
end;

procedure TTransAccountDetailsGUI.AssignKeyId(Popupform: TBaseInputGUI);
begin
  Popupform.KeyId := 0;
  if (Sysutils.SameText(qryMainType.asString , TStockTransferEntry.Transtype)) or
            (Sysutils.SameText(qryMainType.asString , TStockAdjustEntry.Transtype))  then begin
     Popupform.KeyId := QrymainSaleID.asInteger;
  end;
  if Popupform.KeyId = 0 then inherited;

end;

initialization
  RegisterClassOnce(TTransAccountDetailsGUI);
end.
