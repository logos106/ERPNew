unit ManufaccturesalesOrders;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel,BusObjBase, BusobjJournal;

type
  TManufacturesalesOrdersGUI = class(TBaseListingGUI)
    qryMainSaleID: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainProductName: TWideStringField;
    qryMainuom: TWideStringField;
    qryMainshipped: TFloatField;
    qryMainIsInternalOrder: TWideStringField;
    qryMainConverted: TWideStringField;
    QryAPD1: TERPQuery;
    QryAPD2: TERPQuery;
    QryAPD2ClassId: TIntegerField;
    QryAPD2deptClassname: TWideStringField;
    QryAPD2AccountId: TIntegerField;
    QryAPD2Accountname: TWideStringField;
    QryAPD2Accounttype: TWideStringField;
    QryAPD2debitamount: TFloatField;
    QryAPD2Creditamount: TFloatField;
    QryAPD2description: TWideStringField;
    QryAPD2productname: TWideStringField;
    QryAPD2sourcelineId: TIntegerField;
    QryAPD1ClassId: TIntegerField;
    QryAPD1deptClassname: TWideStringField;
    QryAPD1AccountId: TIntegerField;
    QryAPD1Accountname: TWideStringField;
    QryAPD1Accounttype: TWideStringField;
    QryAPD1debitamount: TFloatField;
    QryAPD1Creditamount: TFloatField;
    QryAPD1description: TWideStringField;
    QryAPD1productname: TWideStringField;
    QryAPD1sourcelineId: TIntegerField;
    QryAPD2SourceId: TIntegerField;
    QryAPD2SourceName: TWideStringField;
    QryAPD1SourceId: TIntegerField;
    QryAPD1SourceName: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
  private
    procedure SAveTreeCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure MakeJEforManCOGSDiff(Sender: TObject);
  public
    { Public declarations }
  end;


implementation

uses CommonLib, CommonDbLib, DbSharedObjectsObj, BusObjSales, BusObjProcess,
  tcConst, DebugLib, LogLib, BusObjAccountPosting, AppEnvironment,
  BusObjProcessPart;

{$R *.dfm}
procedure TManufacturesalesOrdersGUI.MakeJEforManCOGSDiff(Sender: TObject);
var
  fJE :TJournalEntry;
  //credits,debits:Double;
  fstablename:String;
  Qry :TERPQuery;
  Script :TERPScript;
begin
   if not(Sender is TSalesLineProcTree) then exit;
   if not(Assigned(TSalesLineProcTree(Sender).Sales)) then exit;
   With TSalesLineProcTree(Sender).Sales do begin
    fsTablename := GetUserTemporaryTableName('ManAdjJE');
    try
        Script := DbSharedObj.GetScript(GetSharedMyDacConnection);
        try
            Script.Connection := GetSharedMyDacConnection ;
              Script.SQL.clear;
              Script.SQL.Add('DROP table if exists '+ fsTablename +'1; ');
              Script.SQL.Add('create table '+ fsTablename +'1');
              Script.SQL.Add('SELECT');
              Script.SQL.Add('/*AP.SourceId, AP.SourceName,APD.sourcelineId,*/');
              Script.SQL.Add('APD.ClassId,APD.deptClassname,');
              Script.SQL.Add('APD.AccountId, APD.Accountname, APD.Accounttype,');
              Script.SQL.Add('APD.debitamount,APD.Creditamount, APD.description, APD.productname');
              Script.SQL.Add('FROM ' +fixtablename('tblaccountpostingdetail','_ManFix')+' APD');
              Script.SQL.Add('INNER JOIN ' +fixtablename('tblaccountposting','_ManFix')+' AP ON APD.AccountPostingId = AP.AccountPostingId');
              Script.SQL.Add('where AP.SourceName =' +quotedstr(AccountPostingSource_Manufacturing)+'  and AP.SourceId = '+inttostr(TSalesLineProcTree(Sender).cleanID)+';');
              Script.SQL.Add('DROP table if exists '+ fsTablename +'2; ');
              Script.SQL.Add('create table '+ fsTablename +'2 like  '+ fsTablename +'1;');
              Script.SQL.Add('drop table if exists '+fsTablename +'3;');

              Script.SQL.Add('CREATE TABLE  '+fsTablename +'3 ( ');
              Script.SQL.Add('  `ClassId` int(11) DEFAULT NULL,');
              Script.SQL.Add('  `deptClassname` varchar(255) DEFAULT NULL,');
             Script.SQL.Add('  `AccountID` int(11) DEFAULT NULL,');
              Script.SQL.Add('  `AccountName` varchar(255) DEFAULT NULL,');
              Script.SQL.Add('  `AccountType` varchar(255) DEFAULT NULL,');
              Script.SQL.Add('  `debitamount` double DEFAULT NULL,');
              Script.SQL.Add('  `Creditamount` double DEFAULT NULL,');
              Script.SQL.Add('  `description` varchar(342) DEFAULT NULL,');
              Script.SQL.Add('  `productname` varchar(342) DEFAULT NULL');
              Script.SQL.Add(') ENGINE=MyISAM DEFAULT CHARSET=utf8;');

              Script.Execute;

              Script.Connection := connection.Connection  ;
              Script.SQL.clear;
              Script.SQL.Add('insert ignore into '+ fsTablename +'2');
              Script.SQL.Add('SELECT');
              Script.SQL.Add('/*AP.SourceId, AP.SourceName,APD.sourcelineId,*/');
              Script.SQL.Add('APD.ClassId,APD.deptClassname,');
              Script.SQL.Add('APD.AccountId, APD.Accountname, APD.Accounttype,');
              Script.SQL.Add('APD.debitamount,APD.Creditamount, APD.description, APD.productname');
              Script.SQL.Add('FROM tblaccountpostingdetail APD');
              Script.SQL.Add('INNER JOIN tblaccountposting AP ON APD.AccountPostingId = AP.AccountPostingId');
              Script.SQL.Add('where AP.SourceName =' +quotedstr(AccountPostingSource_Manufacturing)+'  and AP.SourceId = '+inttostr(TSalesLineProcTree(Sender).ID)+';');


              Script.SQL.Add('insert ignore into '+fsTablename +'3');
              Script.SQL.Add('Select  ClassId, deptClassname, AccountID, AccountName , AccountType,');
              Script.SQL.Add('Sum(debitamount) debitamount,');
              Script.SQL.Add('Sum(Creditamount) Creditamount,');
              Script.SQL.Add('GROUP_CONCAT(description) description,');
              Script.SQL.Add('GROUP_CONCAT(productname) productname');
              Script.SQL.Add('from');
              Script.SQL.Add('(Select ClassId,deptClassname,AccountId, Accountname, Accounttype,0-debitamount as debitamount,0-Creditamount as Creditamount, description, productname from '+fsTablename +'1 '+
                             ' union all '+
                             ' Select ClassId,deptClassname,AccountId, Accountname, Accounttype,debitamount as debitamount,Creditamount as Creditamount, description, productname from  '+fsTablename +'2) as T');
              Script.SQL.Add('group by classid, accountId');
              Script.Execute;

        finally
          DbSharedObj.ReleaseObj(script);
        end;
        Qry := DbSharedObj.GetQuery(connection.Connection);
        try
          Qry.SQL.Text :='Select * from '+fsTablename +'3 where round(ifnull(debitamount,0),'+inttostr(CurrencyRoundPlaces)+')<>0 or round(ifnull(Creditamount,0),'+inttostr(CurrencyRoundPlaces)+')<>0 ';
          Qry.Open;
          if Qry.recordcount >0 then begin
            Qry.First;
            fJE :=TJournalEntry.Create(Self);
            try
              fJE.Connection := connection;
              fJE.Load(0);
              fJE.connection.BeginNestedTransaction;
              try
                fJE.NEw;
                fJE.TransactionDate := SaleDate;
                fJE.PostDB;
                While Qry.Eof = False do begin
                  if Qry.fieldbyname('debitamount').asFloat <> 0 then begin
                    fJE.Lines.New;
                    fJE.Lines.AccountID   := Qry.fieldbyname('AccountID').asInteger;
                    fJE.Lines.ClassID     := Qry.fieldbyname('ClassID').asInteger;
                    fJE.Lines.TaxCode     := Appenv.RegionalOptions.TaxCodeNoTax;
                    fJE.Lines.DebitAmountinc := Round(Qry.fieldbyname('debitamount').asFloat, CurrencyRoundPlaces);
                    //fJE.Lines.CreditAmount:= Qry.fieldbyname('Creditamount').asFloat;
                    fJE.Lines.Memo        := 'Manufacture COGS Adjustment - Sale # ' + inttostr(SaleID);
                    fJE.Lines.ManCOGSAdjustmentMemo := inttostr(TSalesLineProcTree(Sender).ID)+','+
                                                       quotedstr(Qry.fieldbyname('description').asString)+','+
                                                       quotedstr(Qry.fieldbyname('productname').asString);
                    fJE.Lines.PostDB;
                  end;

                  if Qry.fieldbyname('Creditamount').asFloat <> 0 then begin
                    fJE.Lines.New;
                    fJE.Lines.AccountID   := Qry.fieldbyname('AccountID').asInteger;
                    fJE.Lines.ClassID     := Qry.fieldbyname('ClassID').asInteger;
                    fJE.Lines.TaxCode     := Appenv.RegionalOptions.TaxCodeNoTax;
                    //fJE.Lines.DebitAmount := Qry.fieldbyname('debitamount').asFloat;
                    fJE.Lines.CreditAmountinc:= Round(Qry.fieldbyname('Creditamount').asFloat, CurrencyRoundPlaces);
                    fJE.Lines.Memo        := 'Manufacture COGS Adjustment - Sale # ' + inttostr(SaleID);
                    fJE.Lines.ManCOGSAdjustmentMemo :=inttostr(TSalesLineProcTree(Sender).ID)+','+
                                                       quotedstr(Qry.fieldbyname('description').asString)+','+
                                                       quotedstr(Qry.fieldbyname('productname').asString);
                    fJE.Lines.PostDB;
                  end;

                  Qry.Next;
                end;
                fJE.PostDB;
                fJE.ExecuteSQL('insert ignore into  tblAccountpostingLink_COGSFix '+
                                                                    '(oldSalesLineProcTreeID , newSalesLineProcTreeID) values '+
                                                                    '('+inttostr(TSalesLineProcTree(Sender).CleanID)+','+inttostr(TSalesLineProcTree(Sender).ID)+');');
                fJE.Connection.CommitNestedTransaction;
              Except
                on E:Exception do begin
                  fJE.connection.RollbackNestedTransaction;
                end;
              end;
            finally
              FreeandNil(fJE);
            end;
          end;
        finally
          DbSharedObj.ReleaseObj(Qry);
        end;

    finally
      DestroyUserTemporaryTable(fsTablename);
      DestroyUserTemporaryTable(fsTablename+'1');
      DestroyUserTemporaryTable(fsTablename+'2');
      DestroyUserTemporaryTable(fsTablename+'3');
    end;



    (*closedb(QryAPD1);QryAPD1.Connection := GetSharedDataConnection; QryAPD1.ParamByName('SourceName').AsString := AccountPostingSource_Manufacturing; QryAPD1.ParamByName('SourceId').AsInteger :=TSalesLineProcTree(Sender).ID;OpenDB(QryAPD1);
    closedb(QryAPD2);QryAPD2.Connection := connection.Connection  ; QryAPD2.ParamByName('SourceName').AsString := AccountPostingSource_Manufacturing; QryAPD2.ParamByName('SourceId').AsInteger :=TSalesLineProcTree(Sender).ID;OpenDB(QryAPD2);
    credits:= 0;
    debits:=0;
    if (QryAPD1.RecordCount > 0) or (QryAPD2.RecordCount > 0) then begin
      fJE :=TJournalEntry.Create(Self);
      try
        fJE.Connection := connection;
        fJE.Load(0);
        fJE.connection.BeginNestedTransaction;
        try
          fJE.NEw;
          fJE.TransactionDate := SaleDate;
          if QryAPD1.RecordCount >0 then begin
            QryAPD1.First;
            While QryAPD1.Eof = False do begin
              fJE.Lines.New;
              fJE.Lines.AccountID   := QryAPD1.fieldbyname('AccountID').asInteger;
              fJE.Lines.ClassID     := QryAPD1.fieldbyname('ClassID').asInteger;
              fJE.Lines.TaxCode     := Appenv.RegionalOptions.TaxCodeNoTax;
              fJE.Lines.DebitAmount := 0- QryAPD1.fieldbyname('debitamount').asFloat;
              fJE.Lines.CreditAmount:= 0- QryAPD1.fieldbyname('Creditamount').asFloat;
              fJE.Lines.Memo        := 'Man COGS Adjustment # ' + inttostr(SaleID);
              fJE.Lines.ManCOGSAdjustmentMemo := quotedstr('R')+','+
                                                 inttostr( QryAPD1.fieldbyname('SourceId').asInteger)+','+
                                                 quotedstr( QryAPD1.fieldbyname('SourceName').asString)+','+
                                                 inttostr( QryAPD1.fieldbyname('sourcelineId').asInteger);
              fJE.Lines.PostDB;
              credits := credits +fJE.Lines.CreditAmountinc;
              debits := debits   +fJE.Lines.DebitAmountinc;
              QryAPD1.Next;
            end;
          end;
          if QryAPD2.RecordCount >0 then begin
            QryAPD2.First;
            While QryAPD2.Eof = False do begin
              fJE.Lines.New;
              fJE.Lines.AccountID   := QryAPD2.fieldbyname('AccountID').asInteger;
              fJE.Lines.ClassID     := QryAPD2.fieldbyname('ClassID').asInteger;
              fJE.Lines.TaxCode     := Appenv.RegionalOptions.TaxCodeNoTax;
              fJE.Lines.DebitAmount := QryAPD2.fieldbyname('debitamount').asFloat;
              fJE.Lines.CreditAmount:= QryAPD2.fieldbyname('Creditamount').asFloat;
              fJE.Lines.Memo        := 'Man COGS Adjustment # ' + inttostr(SaleID);
              fJE.Lines.ManCOGSAdjustmentMemo := quotedstr('P')+','+
                                                 inttostr( QryAPD2.fieldbyname('SourceId').asInteger)+','+
                                                 quotedstr( QryAPD2.fieldbyname('SourceName').asString)+','+
                                                 inttostr( QryAPD2.fieldbyname('sourcelineId').asInteger);
              fJE.Lines.PostDB;
              credits := credits +fJE.Lines.CreditAmountinc;
              debits := debits   +fJE.Lines.DebitAmountinc;
              QryAPD1.Next;
            end;
          end;
          fJE.PostDB;
          if  credits<> debits then begin
          end;
          if not fJE.Save then begin
            fJE.connection.RollbackNestedTransaction;
          end else begin
            fJE.Connection.CommitNestedTransaction;
          end;
        Except
          on E:Exception do begin
            fJE.connection.RollbackNestedTransaction;
          end;
        end;
      Finally
        FreeandNil(fJE);
      end;
    end;  *)
   end;
end;
procedure TManufacturesalesOrdersGUI.cmdNewClick(Sender: TObject);
var
  s:String;
  Qry:TERPQuery;
  SO:TSalesOrder;
begin
//  inherited;
  if grdMain.SelectedList.Count =0 then exit;

  s:= SelectedIDs('SaleID' , true);
  if s='' then exit;

(*  try
    s:= 'alter table tblProctree add column COGSFixDone Enum("T","F") default "F";';
    ExecuteSQLwithProgress(s);
  Except
    // kill the exception
  end;*)

  s:= DoBackuptables(['tblaccountposting' ,'tblaccountpostingdetail' ,'tblProctree' ,'tblsaleslines' ,'tblsales' , 'tblgeneraljournal', 'tblgeneraljournaldetails'] , '_ManFix' , False);
  if s<> '' then begin
    ExecuteSQLwithProgress(s);
  end;

  s:= '';
  s:= SelectedIDs('SaleID' , true);
  Qry := DbSharedObj.GetQuery(Qrymain.Connection);
  try
    Qry.SQL.Text := 'Select SaleId from tblsales where saleId in (' + s+ ') and converted ="T" order by saleId';
    Qry.open;
    if Qry.Recordcount =0 then exit;
    Qry.first;
    DoShowProgressbar(Qry.REcordcount, WAITMSG);
    try
      clog('');
      s := '';
      while Qry.Eof = False do begin
        DoStepProgressbar('SO # ' +Qry.FieldByName('SaleID').AsString+NL+s);  s:= '1';
        try
          SO:= TSalesOrder.CreateWithNewConn(Self);
          try                                                                 s:='2';
            SO.Load(Qry.FieldByName('SaleID').AsInteger);                     s:='3';
            if SO.count >0 then begin
              if SO.Lock then try                                             s:='4';
                SO.MakeJEforManCOGSDiff := Self.MakeJEforManCOGSDiff;
                SO.InstantiateAllTrees;                                       s:='5';
                SO.Lines.IterateRecords(SAveTreeCallback);                    s:='6';
                SO.PostDB;                                                    s:='7';
                so.connection.CommitTransaction;                              s:='8';
                Logtext('Done #' + inttostr(so.ID));
              finally
                SO.UnLock;                                                    s:='09';
              end;
            end;
          finally
            FreeandNil(SO);                                                   s:='10';
          end;
        Except
          on E:Exception do begin
            s:= s+ '#' +E.Message;
            Logtext(s);
          end;
        end;
        Qry.Next;
      end;
      Logtext('All updated' );
    finally
      DoHideProgressbar;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
procedure TManufacturesalesOrdersGUI.SAveTreeCallback(const Sender: TBusObj; var Abort: Boolean);
var
    PostDesc: string;
Function COGSFixDone( SalesLineProcTreeID:Integer):Boolean;
var
  Qry:TERPQuery;
begin
  Qry := DbSharedObj.GetQuery(Sender.Connection.Connection);
  try
    Qry.sQL.text := 'Select oldSalesLineProcTreeID from tblAccountpostingLink_COGSFix where oldSalesLineProcTreeID =' + inttostr(SalesLineProcTreeID) ;
    Qry.Open;
    result :=Qry.Fieldbyname('oldSalesLineProcTreeID').AsInteger>0;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
begin
  if not(Sender is TSalesorderLine) then exit;
  if Assigned(TSalesLineProcTree(TSalesorderLine(Sender).Container.ItemByClass(TSalesLineProcTree))) then begin
    //if TSalesLineProcTree(TSalesorderLine(Sender).Container.ItemByClass(TSalesLineProcTree)).COGSFixDone = False then
    if not COGSFixDone(TSalesLineProcTree(TSalesorderLine(Sender).Container.ItemByClass(TSalesLineProcTree)).ID) then
      TSalesLineProcTree(TSalesorderLine(Sender).Container.ItemByClass(TSalesLineProcTree)).DoAccountPosting(PostDEsc);
  end;
end;
initialization
  RegisterClassOnce(TManufacturesalesOrdersGUI);

end.
