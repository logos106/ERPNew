unit transactiontablecompare;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, DADump, MyDump, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TtransactiontablecompareGUI = class(TBaseListingGUI)
    DNMPanel1: TDNMPanel;
    lblServer3: TLabel;
    edtServer3: TEdit;
    lblServer2: TLabel;
    edtServer2: TEdit;
    MyConnection3: TERPConnection;
    MyConnection2: TERPConnection;
    DataSource2: TDataSource;
    ERPQuery2: TERPQuery;
    DataSource3: TDataSource;
    ERPQuery3: TERPQuery;
    Dump: TMyDump;
    qryMainautoID: TIntegerField;
    qryMainID: TWideStringField;
    qryMainDebitsEx: TFloatField;
    qryMainDebitsInc: TFloatField;
    qryMainCreditsEx: TFloatField;
    qryMaincreditsInc: TFloatField;
    qryMainAmountex: TFloatField;
    qryMainTaxAmount: TFloatField;
    qryMainAmountinc: TFloatField;
    qryMainDebitsEx2: TFloatField;
    qryMainDebitsInc2: TFloatField;
    qryMainCreditsEx2: TFloatField;
    qryMaincreditsInc2: TFloatField;
    qryMainAmountex2: TFloatField;
    qryMainTaxAmount2: TFloatField;
    qryMainAmountinc2: TFloatField;
    qryMainDebitsEx3: TFloatField;
    qryMainDebitsInc3: TFloatField;
    qryMainCreditsEx3: TFloatField;
    qryMaincreditsInc3: TFloatField;
    qryMainAmountex3: TFloatField;
    qryMainTaxAmount3: TFloatField;
    qryMainAmountinc3: TFloatField;
    qryMainType: TWideStringField;
    qryMainAccountType: TWideStringField;
    qryMainAccountName: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainSeqno: TFloatField;
    qryMainSaleID: TIntegerField;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainPaymentID: TIntegerField;
    qryMainPrepaymentID: TIntegerField;
    qryMainFixedAssetID: TIntegerField;
    qryMainSalelineID: TIntegerField;
    qryMainPurchaselineID: TIntegerField;
    qryMainPaymentlineID: TIntegerField;
    qryMainPrePaymentlineID: TIntegerField;
    btnPopulate: TDNMSpeedButton;
    DNMSpeedButton1: TDNMSpeedButton;
    DNMSpeedButton2: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPopulateClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure DNMSpeedButton2Click(Sender: TObject);
  private
    Tablename1, Tablename2, tablename3, tablenameall :String;
    Procedure Populatedata;
    procedure highlightamount(Field: TField; var AFont: TFont; var ABrush: TBrush;field1, field2, Field3: TFloatField);
  Protected
    procedure SetGridColumns; Override;
    Procedure RefreshTotals;Override;
  public
    Procedure RefreshQuery;Override;
  end;

implementation

uses tcConst, CommonLib, LogLib, CommonDbLib, MySQLConst, AppEnvironment, Math;

{$R *.dfm}

{ TBaseListingGUI1 }

procedure TtransactiontablecompareGUI.btnPopulateClick(Sender: TObject);
begin
  inherited;
  Populatedata;
  RefreshQuery;
end;

procedure TtransactiontablecompareGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  dtFrom.date := incmonth(dtFrom.date , -1);
  dtTo.date := incmonth(dtTo.date , -1);
  dtToChange(nil);
end;

procedure TtransactiontablecompareGUI.DNMSpeedButton2Click(Sender: TObject);
begin
  inherited;
  dtTo.date := incmonth(dtTo.date , 1);
  dtFrom.date := incmonth(dtFrom.date , 1);
  dtToChange(nil);
end;

procedure TtransactiontablecompareGUI.FormCreate(Sender: TObject);
begin
  Tablename1 := commondblib.GetUserTemporaryTableName('transcompare');
  Tablename2 := Tablename1 +'_2';
  Tablename3 := Tablename1 +'_3';
  tablenameall:= Tablename1 +'_all';
  (* (executeSQL('drop table if exists '+ tablenameall +';' +
             ' CREATE TABLE '+tablenameall+' ( '+
             ' autoID int(11) NOT NULL AUTO_INCREMENT, '+
             ' ID varchar(171) NOT NULL DEFAULT "", '+
             ' Seqno            double DEFAULT NULL, '+
             ' Type             varchar(50) DEFAULT NULL, '+
             ' GlobalRef        varchar(255) DEFAULT NULL, '+
             ' SaleID           int(11) DEFAULT "0", '+
             ' PurchaseOrderID  int(11) DEFAULT "0", '+
             ' PaymentID        int(11) DEFAULT "0", '+
             ' PrepaymentID     int(11) DEFAULT "0", '+
             ' FixedAssetID     int(11) DEFAULT "0", '+
             ' SalelineID       int(11) DEFAULT NULL, '+
             ' PurchaselineID   int(11) DEFAULT NULL, '+
             ' PaymentlineID    int(11) DEFAULT NULL, '+
             ' PrePaymentlineID int(11) DEFAULT NULL, '+
             ' DebitsEx         double DEFAULT NULL, '+
             ' DebitsInc        double DEFAULT NULL, '+
             ' CreditsEx        double DEFAULT NULL, '+
             ' creditsInc       double DEFAULT NULL, '+
             ' Amountex         double DEFAULT NULL, '+
             ' TaxAmount        double DEFAULT NULL, '+
             ' Amountinc        double DEFAULT NULL, '+
             ' DebitsEx2        double DEFAULT NULL, '+
             ' DebitsInc2       double DEFAULT NULL, '+
             ' CreditsEx2       double DEFAULT NULL, '+
             ' creditsInc2      double DEFAULT NULL, '+
             ' Amountex2        double DEFAULT NULL, '+
             ' TaxAmount2       double DEFAULT NULL, '+
             ' Amountinc2       double DEFAULT NULL, '+
             ' DebitsEx3        double DEFAULT NULL, '+
             ' DebitsInc3       double DEFAULT NULL, '+
             ' CreditsEx3       double DEFAULT NULL, '+
             ' creditsInc3      double DEFAULT NULL, '+
             ' Amountex3        double DEFAULT NULL, '+
             ' TaxAmount3       double DEFAULT NULL, '+
             ' Amountinc3       double DEFAULT NULL, '+
             ' PRIMARY KEY (autoID), '+
             ' KEY ID (ID) ) ENGINE=MyISAM AUTO_INCREMENT=148342 DEFAULT CHARSET=utf8;' ); *)

  Qrymain.sql.text := 'select * from '+tablenameall;
  inherited;
  dtFrom.date :=0;
  dtTo.date     := encodedate(2015,1,31);
  dtFrom.date   := encodedate(2015,1,1);
  fbDateRangeSupplied := True;
  filterString := 'AccountType = '+quotedstr('COGS')+' AND AccountName = '+Quotedstr('Cost of Goods Sold');

  AddCalccolumn(qrymainDebitsEx.Fieldname, TRue);
  AddCalccolumn(qrymainDebitsInc.Fieldname, TRue);
  AddCalccolumn(qrymainCreditsEx.Fieldname, TRue);
  AddCalccolumn(qrymaincreditsInc.Fieldname, TRue);
  AddCalccolumn(qrymainAmountex.Fieldname, TRue);
  AddCalccolumn(qrymainTaxAmount.Fieldname, TRue);
  AddCalccolumn(qrymainAmountinc.Fieldname, TRue);
  AddCalccolumn(qrymainDebitsEx2.Fieldname, TRue);
  AddCalccolumn(qrymainDebitsInc2.Fieldname, TRue);
  AddCalccolumn(qrymainCreditsEx2.Fieldname, TRue);
  AddCalccolumn(qrymaincreditsInc2.Fieldname, TRue);
  AddCalccolumn(qrymainAmountex2.Fieldname, TRue);
  AddCalccolumn(qrymainTaxAmount2.Fieldname, TRue);
  AddCalccolumn(qrymainAmountinc2.Fieldname, TRue);
  AddCalccolumn(qrymainDebitsEx3.Fieldname, TRue);
  AddCalccolumn(qrymainDebitsInc3.Fieldname, TRue);
  AddCalccolumn(qrymainCreditsEx3.Fieldname, TRue);
  AddCalccolumn(qrymaincreditsInc3.Fieldname, TRue);
  AddCalccolumn(qrymainAmountex3.Fieldname, TRue);
  AddCalccolumn(qrymainTaxAmount3.Fieldname, TRue);
  AddCalccolumn(qrymainAmountinc3.Fieldname, TRue);

end;

procedure TtransactiontablecompareGUI.FormDestroy(Sender: TObject);
begin
  if not devmode then begin
    DestroyUserTemporaryTable(Tablename1);
    DestroyUserTemporaryTable(Tablename2);
    DestroyUserTemporaryTable(Tablename3);
    DestroyUserTemporaryTable(Tablenameall);

  end;
  inherited;

end;

procedure TtransactiontablecompareGUI.FormShow(Sender: TObject);
begin
  inherited;
  btnPopulate.Click;
end;
procedure TtransactiontablecompareGUI.highlightamount(Field: TField; var AFont: TFont;var ABrush: TBrush;field1,field2,Field3:TFloatField);
begin
  if sametext(field.fieldname , field1.fieldname) or sametext(field.fieldname , field2.fieldname) or sametext(field.fieldname , field3.fieldname) then
    if not(Samevalue(field1.asfloat , field2.asfloat, 0.0001)) or
       not(Samevalue(field2.asfloat , field3.asfloat, 0.0001)) or
       not(Samevalue(field3.asfloat , field1.asfloat, 0.0001)) then ABrush.color :=  $0080FFFF;

end;
procedure TtransactiontablecompareGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
    highlightamount(field, AFont, ABrush, QrymaindebitsEx   , QrymaindebitsEx2  , QrymaindebitsEx3);
    highlightamount(field, AFont, ABrush, QrymaindebitsInc  , QrymaindebitsInc2 , QrymaindebitsInc3);
    highlightamount(field, AFont, ABrush, QrymainCreditsEx  , QrymainCreditsEx2 , QrymainCreditsEx3);
    highlightamount(field, AFont, ABrush, QrymainCreditsInc , QrymainCreditsInc2, QrymainCreditsInc3);
    highlightamount(field, AFont, ABrush, QrymainTaxAmount  , QrymainTaxAmount2 , QrymainTaxAmount3);
    highlightamount(field, AFont, ABrush, QrymainAmountEx   , QrymainAmountEx2  , QrymainAmountEx3);
    highlightamount(field, AFont, ABrush, QrymainAmountInc  , QrymainAmountInc2 , QrymainAmountInc3);



  (*if sametext(field.fieldname , 'debitsex') or sametext(field.fieldname , 'debitsex2') or sametext(field.fieldname , 'debitsex3') then
    if not(Samevalue(QrymaindebitsEx.asfloat , QrymaindebitsEx2.asfloat, 0.0001)) or
       not(Samevalue(QrymaindebitsEx2.asfloat , QrymaindebitsEx3.asfloat, 0.0001)) or
       not(Samevalue(QrymaindebitsEx.asfloat , QrymaindebitsEx3.asfloat, 0.0001)) then ABrush.color :=  $0080FFFF;
  if sametext(field.fieldname , 'debitsInc') or sametext(field.fieldname , 'debitsInc2') or sametext(field.fieldname , 'debitsInc3') then
    if not(Samevalue(QrymaindebitsInc.asfloat , QrymaindebitsInc2.asfloat, 0.0001)) or
       not(Samevalue(QrymaindebitsInc2.asfloat , QrymaindebitsInc3.asfloat, 0.0001)) or
       not(Samevalue(QrymaindebitsInc.asfloat , QrymaindebitsInc3.asfloat, 0.0001)) then ABrush.color :=  $0080FFFF;

  if sametext(field.fieldname , 'CreditsEx') or sametext(field.fieldname , 'CreditsEx2') or sametext(field.fieldname , 'CreditsEx3') then
    if not(Samevalue(QrymainCreditsEx.asfloat , QrymainCreditsEx2.asfloat, 0.0001)) or
       not(Samevalue(QrymainCreditsEx2.asfloat , QrymainCreditsEx3.asfloat, 0.0001)) or
       not(Samevalue(QrymainCreditsEx.asfloat , QrymainCreditsEx3.asfloat, 0.0001)) then ABrush.color :=  $0080FFFF;

  if sametext(field.fieldname , 'CreditsInc') or sametext(field.fieldname , 'CreditsInc2') or sametext(field.fieldname , 'CreditsInc3') then
    if not(Samevalue(QrymainCreditsInc.asfloat , QrymainCreditsInc2.asfloat, 0.0001)) or
       not(Samevalue(QrymainCreditsInc2.asfloat , QrymainCreditsInc3.asfloat, 0.0001)) or
       not(Samevalue(QrymainCreditsInc.asfloat , QrymainCreditsInc3.asfloat, 0.0001)) then ABrush.color :=  $0080FFFF;

  if sametext(field.fieldname , 'AmountEx') or sametext(field.fieldname , 'AmountEx2') or sametext(field.fieldname , 'AmountEx3') then
    if not(Samevalue(QrymainAmountEx.asfloat , QrymainAmountEx2.asfloat, 0.0001)) or
       not(Samevalue(QrymainAmountEx2.asfloat , QrymainAmountEx3.asfloat, 0.0001)) or
       not(Samevalue(QrymainAmountEx.asfloat , QrymainAmountEx3.asfloat, 0.0001)) then ABrush.color :=  $0080FFFF;

  if sametext(field.fieldname , 'AmountInc') or sametext(field.fieldname , 'AmountInc2') or sametext(field.fieldname , 'AmountInc3') then
    if not(Samevalue(QrymainAmountInc.asfloat , QrymainAmountInc2.asfloat, 0.0001)) or
       not(Samevalue(QrymainAmountInc2.asfloat , QrymainAmountInc3.asfloat, 0.0001)) or
       not(Samevalue(QrymainAmountInc.asfloat , QrymainAmountInc3.asfloat, 0.0001)) then ABrush.color :=  $0080FFFF;

  if sametext(field.fieldname , 'TaxAmount') or sametext(field.fieldname , 'TaxAmount2') or sametext(field.fieldname , 'TaxAmount3') then
    if not(Samevalue(QrymainTaxAmount.asfloat , QrymainTaxAmount2.asfloat, 0.0001)) or
       not(Samevalue(QrymainTaxAmount2.asfloat , QrymainTaxAmount3.asfloat, 0.0001)) or
       not(Samevalue(QrymainTaxAmount.asfloat , QrymainTaxAmount3.asfloat, 0.0001)) then ABrush.color :=  $0080FFFF;*)
end;

procedure TtransactiontablecompareGUI.RefreshQuery;
begin
  inherited;
end;

procedure TtransactiontablecompareGUI.RefreshTotals;
begin
  inherited;
  CalcnshowFooter;
end;

procedure TtransactiontablecompareGUI.Populatedata;
var
  ctr:Integer;
begin
  clog('');
  try
    //  inherited;
(*      qrymain.connection.Connected := False;
      qrymain.connection.server := edtServer1.Text;
      qrymain.connection.Connected := True;
      Qrymain.Connection := qrymain.connection;*)


      MyConnection2.Connected := False;
      SetMyDacConnection(MyConnection2);
      MyConnection2.server := edtServer2.Text;
      MyConnection2.Connected := True;
      erpQuery2.Connection := MyConnection2;


      MyConnection3.Connected := False;
      SetMyDacConnection(MyConnection3);
      MyConnection3.server := edtServer3.Text;
      MyConnection3.Connected := True;
      erpQuery3.Connection := MyConnection3;

        With scriptmain do begin
          SQL.Clear;
          SQL.add('Drop table if exists '+Tablename1 +' ;');
          SQL.add('create table '+Tablename1 +'');
          for ctr := 1 to 2 do begin
              if ctr = 2 then SQL.add('union');
              SQL.add('SELECT ');
              SQL.add('concat(ifnull(Seqno,0),'+
                      'ifnull(type,""),'+
                      'ifnull(SaleID,0), '+
                      'ifnull(PurchaseOrderID,0), '+
                      'ifnull(PaymentID,0), '+
                      'ifnull(PrepaymentID,0), '+
                      'ifnull(FixedAssetID,0), '+
                      'ifnull(SalelineID,0), '+
                      'ifnull(PurchaselineID,0), '+
                      'ifnull(PaymentlineID,0), '+
                      'ifnull(PrePaymentlineID ,0)) as ID,  ');
              SQL.add('SaleID, PurchaseOrderID, PaymentID, PrepaymentID, FixedAssetID, SalelineID, PurchaselineID, PaymentlineID, PrePaymentlineID ,  ');
              SQL.add('seqno, Date,ClassName as Class, Type, T.GlobalRef,');
              SQL.add('AccountName,');
              SQL.add('ClientName,');
              SQL.add('DebitsEx,DebitsInc, CreditsEx, creditsInc,');
              SQL.add('CreditsEx-DebitsEx as Amountex,');
              SQL.add('(CreditsInc-DebitsInc)-(CreditsEx-DebitsEx) as TaxAmount,');
              SQL.add('CreditsInc-DebitsInc as Amountinc,');
              SQL.add('T.ClassID, ');
              SQL.add('TransID,ProductName, ProductDesc, TaxCode,Notes, EmployeeID, Accounttype, AccountID,');
              SQL.add('T.Level1,T.Level2 , T.Level3 , T.Level4/*,');
              SQL.add('tblClass.Level1, tblClass.Level2, tblClass.Level3, tblClass.Level4*/');
              SQL.add('FROM');
              SQL.add(iif(ctr=1 , 'tbltransactions' , 'tbltransactionsummarydetails')+' T');
              SQL.add('LEFT Join tblClass Using(ClassID)');
              SQL.add('WHERE CreditsEx-DebitsEx <> 0');
              SQL.add('and date between ' + quotedstr(formatDateTime(mysqlDatetimeformat , filterDateFrom)) +' and '+  quotedstr(formatDateTime(mysqlDatetimeformat , filterDateto)));
              SQL.add(iif(ctr=1 , 'and T.Type <> "Closing Date Summary"' , ';'));
          end;
          (*SQL.add('union all SELECT  ');
          SQL.add('concat(ifnull(Seqno,0),'+
                  'ifnull(type,""),'+
                  'ifnull(SaleID,0), '+
                  'ifnull(PurchaseOrderID,0), '+
                  'ifnull(PaymentID,0), '+
                  'ifnull(PrepaymentID,0), '+
                  'ifnull(FixedAssetID,0), '+
                  'ifnull(SalelineID,0), '+
                  'ifnull(PurchaselineID,0), '+
                  'ifnull(PaymentlineID,0), '+
                  'ifnull(PrePaymentlineID ,0)) as ID,  ');
          SQL.add('SaleID, PurchaseOrderID, PaymentID, PrepaymentID, FixedAssetID, SalelineID, PurchaselineID, PaymentlineID, PrePaymentlineID ,  ');
          SQL.add('Seqno, Date,ClassName as Class, Type, T.GlobalRef,');
          SQL.add('AccountName,');
          SQL.add('ClientName,');
          SQL.add('DebitsEx,DebitsInc, CreditsEx, creditsInc,');
          SQL.add('CreditsEx-DebitsEx as Amountex,');
          SQL.add('(CreditsInc-DebitsInc)-(CreditsEx-DebitsEx) as TaxAmount,');
          SQL.add('CreditsInc-DebitsInc as Amountinc,');
          SQL.add('T.ClassID, ');
          SQL.add('TransID,ProductName, ProductDesc, TaxCode,Notes, EmployeeID, AccountType,AccountID,');
          SQL.add('T.Level1,T.Level2 , T.Level3 , T.Level4/*,');
          SQL.add('tblClass.Level1, tblClass.Level2, tblClass.Level3, tblClass.Level4*/');
          SQL.add('FROM');
          SQL.add('tbltransactionsummarydetails T');
          SQL.add('LEFT Join tblClass Using(ClassID)');
          SQL.add('WHERE CreditsEx-DebitsEx <> 0 ');
          SQL.add('and date between ' + quotedstr(formatDateTime(mysqlDatetimeformat , filterDateFrom)) +' and '+  quotedstr(formatDateTime(mysqlDatetimeformat , filterDateto))+';');*)
          SQL.add('alter table '+Tablename1 +' add index seqno (seqno);');
          SQL.add('alter table '+Tablename1 +' add index date (date);');
          SQL.add('alter table '+Tablename1 +' add index type (type);');
          SQL.add('alter table '+Tablename1 +' add index ID (ID);');
          SQL.add('ALTER TABLE '+Tablename1 +' 	ADD COLUMN autoID INT(11) NOT NULL AUTO_INCREMENT first, 	ADD PRIMARY KEY (autoID);');
          Logtext(SQL.text);
          DoShowProgressbar(50 , WAITMSG);
          try
              Connection  := qrymain.connection;
              DoStepProgressbar('Trans Data :' + Qrymain.connection.Server);
              Execute;
              Connection  := MyConnection2;
              DoStepProgressbar('Trans Data :' + MyConnection2.server);
              Execute;
              Connection  := MyConnection3;
              DoStepProgressbar('Trans Data :' + MyConnection3.server);
              Execute;

              DoStepProgressbar('Import All data ');
              SQL.Clear;
              Dump.Tablenames:= Tablename1 ;
              Dump.Options.AddDrop:= false;
              Dump.Options.GenerateHeader:= false;
              Dump.Options.AddLock:= false;
              Dump.Options.CompleteInsert:= true;
              Dump.Objects:= [doData];

              DoStepProgressbar('Export data :' + MyConnection2.Server);
              Dump.Connection := MyConnection2;
              Dump.BackupToFile('c:\temp\' + MyConnection2.Server+'.sql');

              DoStepProgressbar('Export data :' + MyConnection3.Server);
              Dump.Connection := MyConnection3;
              Dump.BackupToFile('c:\temp\' + MyConnection3.Server+'.sql');

              SQL.Clear;
              connection := qrymain.connection;

              DoStepProgressbar('Import data :' + MyConnection2.Server);
              SQL.LoadFromFile('c:\temp\' + MyConnection2.Server+'.sql');
              SQL.text := replacestr(SQL.text, Tablename1  , Tablename2);
              SQL.text := ' Drop table if exists  '+ Tablename2 +'; '+
                          ' Create table   '+ Tablename2 +' like '+Tablename1 +';' +
                          SQL.text;
              logtext(SQL.Text);
              Execute;
              DoStepProgressbar('Import data :' + MyConnection3.Server);

              SQL.Clear;
              SQL.LoadFromFile('c:\temp\' + MyConnection3.Server+'.sql');
              SQL.text := replacestr(SQL.text, Tablename1  , Tablename3);
              SQL.text := ' Drop table if exists  '+ Tablename3 +'; '+
                          ' Create table   '+ Tablename3 +' like '+Tablename1 +';' +
                          SQL.text;
              logtext(SQL.Text);
              Execute;
              DoStepProgressbar;

              SQL.Clear;
              SQL.Add('Drop table if exists '+tablenameall+'; ');
              SQL.Add('create table '+tablenameall+'');
              SQL.Add('Select distinct ID, seqno,Accounttype, Accountname, type, Globalref , SaleID, PurchaseOrderID, PaymentID, PrepaymentID, FixedAssetID, SalelineID, PurchaselineID, PaymentlineID, PrePaymentlineID     from '+Tablename1 +''+
                        ' union Select distinct ID, seqno,Accounttype, Accountname, type, Globalref , SaleID, PurchaseOrderID, PaymentID, PrepaymentID, FixedAssetID, SalelineID, PurchaselineID, PaymentlineID, PrePaymentlineID  from '+ Tablename2+''+
                        ' union Select distinct ID, seqno,Accounttype, Accountname, type, Globalref , SaleID, PurchaseOrderID, PaymentID, PrepaymentID, FixedAssetID, SalelineID, PurchaselineID, PaymentlineID, PrePaymentlineID  from '+ Tablename3+';');

              SQL.Add('alter table '+tablenameall+' add index ID (ID);');
              SQL.Add('ALTER TABLE '+tablenameall+' 	ADD COLUMN autoID INT(11) NOT NULL AUTO_INCREMENT first, 	ADD PRIMARY KEY (autoID);');

              SQL.Add('alter table '+tablenameall+' add column DebitsEx double;');
              SQL.Add('alter table '+tablenameall+' add column DebitsInc double;');
              SQL.Add('alter table '+tablenameall+' add column CreditsEx double;');
              SQL.Add('alter table '+tablenameall+' add column creditsInc double;');
              SQL.Add('alter table '+tablenameall+' add column Amountex double;');
              SQL.Add('alter table '+tablenameall+' add column TaxAmount double;');
              SQL.Add('alter table '+tablenameall+' add column Amountinc double;');


              SQL.Add('alter table '+tablenameall+' add column DebitsEx2 double; ');
              SQL.Add('alter table '+tablenameall+' add column DebitsInc2 double;');
              SQL.Add('alter table '+tablenameall+' add column CreditsEx2 double;');
              SQL.Add('alter table '+tablenameall+' add column creditsInc2 double;');
              SQL.Add('alter table '+tablenameall+' add column Amountex2 double;');
              SQL.Add('alter table '+tablenameall+' add column TaxAmount2 double;');
              SQL.Add('alter table '+tablenameall+' add column Amountinc2 double;');


              SQL.Add('alter table '+tablenameall+' add column DebitsEx3 double;');
              SQL.Add('alter table '+tablenameall+' add column DebitsInc3 double;');
              SQL.Add('alter table '+tablenameall+' add column CreditsEx3 double;');
              SQL.Add('alter table '+tablenameall+' add column creditsInc3 double;');
              SQL.Add('alter table '+tablenameall+' add column Amountex3 double;');
              SQL.Add('alter table '+tablenameall+' add column TaxAmount3 double;');
              SQL.Add('alter table '+tablenameall+' add column Amountinc3 double;');

              SQL.Add('update '+tablenameall+' Ta inner join '+Tablename1 +' t1 on ta.id = t1.ID Set '+
                      ' ta.Debitsex     = t1.Debitsex, '+
                      ' ta.DebitsInc    = t1.DebitsInc, '+
                      ' ta.creditsex    = t1.creditsex, '+
                      ' ta.creditsInc   = t1.creditsInc, '+
                      ' ta.Amountex     = t1.Amountex, '+
                      ' ta.TaxAmount    = t1.TaxAmount, '+
                      ' ta.Amountinc    = t1.Amountinc;');

              SQL.Add('update '+tablenameall+' Ta inner join  '+ Tablename2+' t1 on ta.id = t1.ID Set  '+
                      ' ta.Debitsex2     = t1.Debitsex, '+
                      ' ta.DebitsInc2    = t1.DebitsInc, '+
                      ' ta.creditsex2    = t1.creditsex, '+
                      ' ta.creditsInc2   = t1.creditsInc, '+
                      ' ta.Amountex2     = t1.Amountex, '+
                      ' ta.TaxAmount2    = t1.TaxAmount, '+
                      ' ta.Amountinc2    = t1.Amountinc;');

              SQL.Add('update '+tablenameall+' Ta inner join  '+ Tablename3+' t1 on ta.id = t1.ID Set'+
                      ' ta.Debitsex3     = t1.Debitsex, '+
                      ' ta.DebitsInc3    = t1.DebitsInc, '+
                      ' ta.creditsex3    = t1.creditsex, '+
                      ' ta.creditsInc3   = t1.creditsInc, '+
                      ' ta.Amountex3     = t1.Amountex, '+
                      ' ta.TaxAmount3    = t1.TaxAmount, '+
                      ' ta.Amountinc3    = t1.Amountinc;');
              execute;

          finally
             DoHideProgressbar;
          end;

        end;
  except
    on E:Exception do begin
      MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
    end;
  end;
  inherited;
  FieldList := TStringList.Create;
  try
    AddGridSelectedfield('Seqno'      ,10 ,'Seqno');
    AddGridSelectedfield('Type'       ,20 ,'Type');
    AddGridSelectedfield('DebitsEx'   ,10 ,qrymain.connection.server            ,'Debits (Ex)');
    AddGridSelectedfield('DebitsEx2'  ,10 ,MyConnection2.server(*'Alpha'*)      ,'Debits (Ex)');
    AddGridSelectedfield('DebitsEx3'  ,10 ,MyConnection3.server(*'Beta'*)       ,'Debits (Ex)');
    AddGridSelectedfield('DebitsInc'  ,10 ,qrymain.connection.server            ,'Debits (Inc)');
    AddGridSelectedfield('DebitsInc2' ,10 ,MyConnection2.server(*'Alpha'*)      ,'Debits (Inc)');
    AddGridSelectedfield('DebitsInc3' ,10 ,MyConnection3.server(*'Beta'*)       ,'Debits (Inc)');
    AddGridSelectedfield('CreditsEx'  ,10 ,qrymain.connection.server            ,'Credits (Ex)');
    AddGridSelectedfield('CreditsEx2' ,10 ,MyConnection2.server(*'Alpha'*)      ,'Credits (Ex)');
    AddGridSelectedfield('CreditsEx3' ,10 ,MyConnection3.server(*'Beta'*)       ,'Credits (Ex)');
    AddGridSelectedfield('creditsInc' ,10 ,qrymain.connection.server            ,'credits (Inc)');
    AddGridSelectedfield('creditsInc2',10 ,MyConnection2.server(*'Alpha'*)      ,'credits (Inc)');
    AddGridSelectedfield('creditsInc3',10 ,MyConnection3.server(*'Beta'*)       ,'credits (Inc)');
    AddGridSelectedfield('Amountex'   ,10 ,qrymain.connection.server            ,'Amount (Ex)');
    AddGridSelectedfield('Amountex2'  ,10 ,MyConnection2.server(*'Alpha'*)      ,'Amount (Ex)');
    AddGridSelectedfield('Amountex3'  ,10 ,MyConnection3.server(*'Beta'*)       ,'Amount (Ex)');
    AddGridSelectedfield('TaxAmount'  ,10 ,qrymain.connection.server            ,'TaxAmount');
    AddGridSelectedfield('TaxAmount2' ,10 ,MyConnection2.server(*'Alpha'*)      ,'TaxAmount');
    AddGridSelectedfield('TaxAmount3' ,10 ,MyConnection3.server(*'Beta'*)       ,'TaxAmount');
    AddGridSelectedfield('Amountinc'  ,10 ,qrymain.connection.server            ,'Amount (Inc)');
    AddGridSelectedfield('Amountinc2' ,10 ,MyConnection2.server(*'Alpha'*)      ,'Amount (Inc)');
    AddGridSelectedfield('Amountinc3' ,10 ,MyConnection3.server(*'Beta'*)       ,'Amount (Inc)');

    grdmain.Selected.Text := Fieldlist.Text;
    grdmain.ApplySelected;
  finally
    Freeandnil(fieldlist);
  end;
end;
procedure TtransactiontablecompareGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('AutoId');
  RemoveFieldfromGrid('ID');
  RemoveFieldfromGrid('SaleID');
  RemoveFieldfromGrid('PurchaseOrderID');
  RemoveFieldfromGrid('PaymentID');
  RemoveFieldfromGrid('PrepaymentID');
  RemoveFieldfromGrid('FixedAssetID');
  RemoveFieldfromGrid('SalelineID');
  RemoveFieldfromGrid('PurchaselineID');
  RemoveFieldfromGrid('PaymentlineID');
  RemoveFieldfromGrid('PrePaymentlineID');
  RemoveFieldfromGrid('Accounttype');
  RemoveFieldfromGrid('AccountName');
end;

initialization
  RegisterClassOnce(TtransactiontablecompareGUI);
end.
