unit frmRecTrans;

interface
{$I ERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, StdCtrls, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ExtCtrls, ComCtrls, Grids, Wwdbigrd, Wwdbgrid, DNMPanel,
  DNMSpeedButton, Shader, ProgressDialog;

type
  TfmRecTrans = class(TBaseInputGUI)
    Qry1: TERPQuery;
    qry2: TERPQuery;
    Qry3: TERPQuery;
    Qry4: TERPQuery;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    ds1: TDataSource;
    ds2: TDataSource;
    ds3: TDataSource;
    ds4: TDataSource;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    DNMPanel4: TDNMPanel;
    wwDBGrid3: TwwDBGrid;
    wwDBGrid4: TwwDBGrid;
    wwDBGrid1: TwwDBGrid;
    btnrefresh: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    lbl4: TLabel;
    lbl3: TLabel;
    lbl2: TLabel;
    lbl1: TLabel;
    DNMSpeedButton2: TDNMSpeedButton;
    DNMSpeedButton3: TDNMSpeedButton;
    DNMSpeedButton4: TDNMSpeedButton;
    DNMSpeedButton5: TDNMSpeedButton;
    wwDBGrid2: TwwDBGrid;
    MainPage: TPageControl;
    DNMSpeedButton1: TDNMSpeedButton;
    DNMPanel5: TDNMPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Qry1ID: TIntegerField;
    Qry1SeqNo: TIntegerField;
    Qry1Reconciled: TWideStringField;
    Qry1ReconciledFlagtype: TWideStringField;
    Qry1Description: TWideStringField;
    Qry1Category: TWideStringField;
    Qry1AccountID: TIntegerField;
    Qry1DepositID: TIntegerField;
    Qry1DepositLineID: TIntegerField;
    Qry1DepositDate: TDateTimeField;
    Qry1Amount: TFloatField;
    Qry1PaymentID: TIntegerField;
    Qry1CusID: TIntegerField;
    Qry1ReferenceNo: TWideStringField;
    Qry1Notes: TWideStringField;
    Qry1CompanyName: TWideStringField;
    Qry1ReconciliationLineID: TIntegerField;
    qry2ID: TIntegerField;
    qry2SeqNo: TIntegerField;
    qry2Reconciled: TWideStringField;
    qry2ReconciledFlagtype: TWideStringField;
    qry2Description: TWideStringField;
    qry2Category: TWideStringField;
    qry2AccountID: TIntegerField;
    qry2DepositID: TIntegerField;
    qry2DepositLineID: TIntegerField;
    qry2DepositDate: TDateTimeField;
    qry2Amount: TFloatField;
    qry2PaymentID: TIntegerField;
    qry2CusID: TIntegerField;
    qry2ReferenceNo: TWideStringField;
    qry2Notes: TWideStringField;
    qry2CompanyName: TWideStringField;
    qry2ReconciliationLineID: TIntegerField;
    Qry3ID: TIntegerField;
    Qry3SeqNo: TIntegerField;
    Qry3Reconciled: TWideStringField;
    Qry3ReconciledFlagtype: TWideStringField;
    Qry3Description: TWideStringField;
    Qry3Category: TWideStringField;
    Qry3AccountID: TIntegerField;
    Qry3DepositID: TIntegerField;
    Qry3DepositLineID: TIntegerField;
    Qry3DepositDate: TDateTimeField;
    Qry3Amount: TFloatField;
    Qry3PaymentID: TIntegerField;
    Qry3CusID: TIntegerField;
    Qry3ReferenceNo: TWideStringField;
    Qry3Notes: TWideStringField;
    Qry3CompanyName: TWideStringField;
    Qry3ReconciliationLineID: TIntegerField;
    Qry4ID: TIntegerField;
    Qry4SeqNo: TIntegerField;
    Qry4Reconciled: TWideStringField;
    Qry4ReconciledFlagtype: TWideStringField;
    Qry4Description: TWideStringField;
    Qry4Category: TWideStringField;
    Qry4AccountID: TIntegerField;
    Qry4DepositID: TIntegerField;
    Qry4DepositLineID: TIntegerField;
    Qry4DepositDate: TDateTimeField;
    Qry4Amount: TFloatField;
    Qry4PaymentID: TIntegerField;
    Qry4CusID: TIntegerField;
    Qry4ReferenceNo: TWideStringField;
    Qry4Notes: TWideStringField;
    Qry4CompanyName: TWideStringField;
    Qry4ReconciliationLineID: TIntegerField;
    Qry1ReconciliationID: TIntegerField;
    qry2ReconciliationID: TIntegerField;
    Qry3ReconciliationID: TIntegerField;
    Qry4ReconciliationID: TIntegerField;
    qry5: TERPQuery;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    StringField1: TWideStringField;
    StringField2: TWideStringField;
    StringField3: TWideStringField;
    StringField4: TWideStringField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    IntegerField5: TIntegerField;
    DateTimeField1: TDateTimeField;
    FloatField1: TFloatField;
    IntegerField6: TIntegerField;
    IntegerField7: TIntegerField;
    StringField5: TWideStringField;
    StringField6: TWideStringField;
    StringField7: TWideStringField;
    IntegerField8: TIntegerField;
    IntegerField9: TIntegerField;
    ds5: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnPopulateSQL: TDNMSpeedButton;
    ds6: TDataSource;
    qry6: TERPQuery;
    qry6TrnsType: TWideStringField;
    qry6ReconciliationID: TIntegerField;
    qry6TotalAmountInc: TFloatField;
    qry6suppliername: TWideStringField;
    qry6CompanyName: TWideStringField;
    qry6Payee: TWideStringField;
    qry6ReconciliationLineID: TIntegerField;
    qry6category: TWideStringField;
    qry6transId: TIntegerField;
    procedure btnrefreshclick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Qry1AfterOpen(DataSet: TDataSet);
    procedure qry2AfterOpen(DataSet: TDataSet);
    procedure Qry3AfterOpen(DataSet: TDataSet);
    procedure Qry4AfterOpen(DataSet: TDataSet);
    procedure DNMSpeedButton5Click(Sender: TObject);
    procedure DNMSpeedButton4Click(Sender: TObject);
    procedure DNMSpeedButton3Click(Sender: TObject);
    procedure DNMSpeedButton2Click(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnPopulateSQLClick(Sender: TObject);
    procedure qry6AfterOpen(DataSet: TDataSet);
  private
  (*  Procedure Addfixfield;*)
    fsTablename :String;

    procedure Fixit(Grid: TwwDBGrid; Qry: TERPQuery; Gridno: Integer);
    function LockforSingleUser:Boolean;
    (*procedure AddAudit(ReconciledFlagtype: String; GridNo: Integer;TransGlobalref: String);*)
    Procedure beforeshowGenDataList(Sender:TObject);
    procedure MyScriptBeforeExecute(Sender: TObject; var SQL: String; var Omit: Boolean);
  public
    { Public declarations }
  end;


implementation

uses CommonDbLib, CommonLib, FastFuncs, MAIN, dmMainGUI,
  AppEnvironment, BusObjAudit, BusObjBase, tcConst, CommonFormLib,
  AuditTrailList, ObjGenData, GenDataList, DAScript,
  TransLockManagementObj, UserUtilsClientObj;

{$R *.dfm}

procedure TfmRecTrans.btnrefreshclick(Sender: TObject);
begin
  inherited;
  fsTablename := CreateUserTemporaryTable('tmp_bankrec');  //GetUserTemporaryTableName('bankrec');

with Commondblib.TempMyScript do try
    SQL.Clear;
    SQL.Add('insert into ' +fsTablename  +' (SeqNo,Reconciled,ReconciledFlagtype,Description,Category,AccountID,DepositID,DepositLineID,DepositDate,Amount,PaymentID,CusID,ReferenceNo,Notes,CompanyName)  ' +
          'SELECT 1 as SeqNo, tblbankdepositlines.Reconciled , "L" as ReconciledFlagtype, "Other" as Description, "Deposit" as Category,tblbankdepositlines.AccountID,  tblbankdeposit.DepositID,tblbankdepositlines.DepositLineID,DepositDate, ' +
      'ABS(Amount) as Amount, PaymentID,If(IsNull(CusID),0,CusID) as CusID,' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.TrnsType ,"Split Deposit") as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName ' +
      'FROM tblbankdeposit ' +
      'INNER JOIN tblbankdepositlines  Using (DepositID) ' +
      'WHERE tblbankdepositlines.TrnsType<>"Deposit Entry" ' +
      'AND tblbankdepositlines.TrnsType<>"Cheque Deposit" ' +
      'AND tblbankdepositlines.TrnsType<>"Cheque" ' +
      'AND tblbankdepositlines.TrnsType<>"'+CUSTOMER_PREPAYMENT+'"  ' +
      'AND tblbankdepositlines.TrnsType<>"Supplier Prepayment" ' +
      'AND FromDeposited<>"T" ' +
      'AND ifnull(Round(Amount,5),0) > 0.00  ' +
      'AND tblbankdeposit.Deleted <>"T"  ');
       SQL.Add('Group By tblbankdepositlines.DepositLineID; ');

    //Customer Prepayment
    SQL.Add('insert into ' +fsTablename  +' (SeqNo,Reconciled,ReconciledFlagtype,Description,Category,AccountID,DepositID,DepositLineID,DepositDate,Amount,PaymentID,CusID,ReferenceNo,Notes,CompanyName)  ' +
      'SELECT 2, tblbankdepositlines.Reconciled  , "L" ,"'+CUSTOMER_PREPAYMENT+'" , "Deposit" , tblbankdepositlines.AccountID  , tblbankdeposit.DepositID,tblbankdepositlines.DepositLineID,DepositDate, ABS(Deposit) as Amount, ' +
      'tblbankdeposit.DepositID as PaymentID,If(IsNull(CusID),0,CusID) as CusID,' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.TrnsType ,"Deposit Entry") as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName ' +
      'FROM tblbankdeposit ' +
      'INNER JOIN tblbankdepositlines Using (DepositID) ' +
      'WHERE  tblbankdepositlines.TrnsType="'+CUSTOMER_PREPAYMENT+'" ' +
      'AND ifnull(Round(Deposit,5),0) > 0.00 ' +
      'AND tblbankdeposit.Deleted <>"T"  ');

      SQL.Add('Group By tblbankdepositlines.DepositLineID; ');

    //negative Supplier Prepayment as deposits
    SQL.Add('insert into ' +fsTablename  +' (SeqNo,Reconciled,ReconciledFlagtype,Description,Category,AccountID,DepositID,DepositLineID,DepositDate,Amount,PaymentID,CusID,ReferenceNo,Notes,CompanyName)  ' +
        '  SELECT 3,tblbankdepositlines.Reconciled ,  "L" ,"Supplier Prepayment" , "Deposit" , tblbankdepositlines.AccountID  , tblbankdeposit.DepositID,tblbankdepositlines.DepositLineID,DepositDate, ABS(Sum(Amount)) as Amount, ' +
      'PaymentID,If(IsNull(CusID),0,CusID) as CusID, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.TrnsType ,"Split Deposit") as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName  ' +
      'FROM tblbankdeposit  ' +
      'INNER JOIN tblbankdepositlines Using (DepositID) ' +
      'WHERE tblbankdepositlines.TrnsType="Supplier Prepayment" ' +
      'AND tblbankdeposit.Deleted <>"T" AND ifnull(Round(Amount,5),0) < 0.00 ');
      SQL.Add('Group By tblbankdepositlines.DepositLineID ; ');

    //Deposit Entry
    SQL.Add('insert into ' +fsTablename  +' (SeqNo,Reconciled,ReconciledFlagtype,Description,Category,AccountID,DepositID,DepositLineID,DepositDate,Amount,PaymentID,CusID,ReferenceNo,Notes,CompanyName)  ' +
      'SELECT 4, tblbankdeposit.Reconciled ,"H",  "Deposit Entry" , "Deposit" , tblbankdeposit.AccountID , tblbankdeposit.DepositID,0 as DepositLineID,DepositDate, ABS(Deposit) as Amount, ' +
      'tblbankdeposit.DepositID as PaymentID,If(IsNull(CusID),0,CusID) as CusID,' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.TrnsType ,"Deposit Entry") as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName ' +
      'FROM tblbankdeposit ' +
      'INNER JOIN tblbankdepositlines Using (DepositID) ' +
      'WHERE tblbankdepositlines.TrnsType="Deposit Entry" ' +
      'AND ifnull(Round(Deposit,5),0) > 0.00 ' +
      'AND tblbankdeposit.Deleted <>"T"  ');


      SQL.Add('Group By  tblbankdeposit.DepositID ;');

    //Deposit Entry Split
    SQL.Add('insert into ' +fsTablename  +' (SeqNo,Reconciled,ReconciledFlagtype,Description,Category,AccountID,DepositID,DepositLineID,DepositDate,Amount,PaymentID,CusID,ReferenceNo,Notes,CompanyName)  ' +
      'SELECT 5, tblbankdepositlines.Reconciled ,  "L" ,"Deposit Entry Split" , "Deposit" , tblbankdepositlines.AccountID, tblbankdeposit.DepositID,DepositLineID,DepositDate, ABS(Amount) as Amount, ' +
      'tblbankdeposit.DepositID as PaymentID,If(IsNull(CusID),0,CusID) as CusID,' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      '"Split Deposit" as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName ' +
      'FROM tblbankdeposit ' +
      'INNER JOIN tblbankdepositlines Using (DepositID) ' +
      'WHERE tblbankdepositlines.TrnsType="Deposit Entry" ' +
      'AND ifnull(Round(Amount,5),0) < 0.00 ' +
      'AND tblbankdeposit.Deleted <>"T"  ');


      SQL.Add('Group By tblbankdepositlines.DepositLineID ;');

    //Bank Deposit
    SQL.Add('insert into ' +fsTablename  +' (SeqNo,Reconciled,ReconciledFlagtype,Description,Category,AccountID,DepositID,DepositLineID,DepositDate,Amount,PaymentID,CusID,ReferenceNo,Notes,CompanyName)  ' +
      'SELECT 6,tblbankdeposit.Reconciled , "H", "Bank Deposit" , "Bank Deposit" , tblbankdeposit.AccountID , tblbankdeposit.DepositID,0 as DepositLineID,DepositDate, ABS(Deposit) as Amount, ' +
      'tblbankdeposit.DepositID as PaymentID, CusID, tblbankdeposit.Notes as ReferenceNo, ' +
      '"Bank Deposit" as Notes, ' +
      '"" as CompanyName ' +
      'FROM tblbankdeposit ' +
      'INNER JOIN tblbankdepositlines Using (DepositID) ' +
      'WHERE  tblbankdepositlines.TrnsType<>"Deposit Entry"  ' +
      'AND tblbankdepositlines.TrnsType<>"Cheque Deposit" ' +
      'AND tblbankdepositlines.TrnsType<>"'+CUSTOMER_PREPAYMENT+'"  ' +
      'AND tblbankdepositlines.TrnsType<>"Supplier Prepayment" ' +
      'AND ifnull(Round(Deposit,5),0) > 0.00 AND FromDeposited="T" ' +
      'AND tblbankdeposit.Deleted <>"T" ');

      SQL.Add('Group By  tblbankdeposit.DepositID ;');

    //Cheques
    SQL.Add('insert into ' +fsTablename  +' (SeqNo,Reconciled,ReconciledFlagtype,Description,Category,AccountID,DepositID,DepositLineID,DepositDate,Amount,PaymentID,CusID,ReferenceNo,Notes,CompanyName)  ' +
          '  SELECT 7,tblbankdeposit.Reconciled  ,"H",  "Cheques" , "Deposit" ,tblbankdeposit.AccountID,  tblbankdeposit.DepositID,0 as DepositLineID,DepositDate, ABS(Deposit) as Amount, ' +
      // 0 as DepositLineID Due To
      'PaymentID,If(IsNull(CusID),0,CusID) as CusID, ' +                                                                                         //  Grouping
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.TrnsType ,"Split Deposit") as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName  ' +
      'FROM tblbankdeposit  ' +
      'INNER JOIN tblbankdepositlines Using (DepositID) ' +
      'WHERE tblbankdepositlines.TrnsType="Cheque" ' +
      'AND tblbankdeposit.Deleted <>"T" ' +
      'AND ifnull(Round(Deposit,5),0) > 0.00 ');


      SQL.Add('Group By tblbankdeposit.DepositID ; '); //Not tblbankdepositlines.DepositLineID  Because Sum Of Cheque Header Account

    //Cheque Deposits
    SQL.Add('insert into ' +fsTablename  +' (SeqNo,Reconciled,ReconciledFlagtype,Description,Category,AccountID,DepositID,DepositLineID,DepositDate,Amount,PaymentID,CusID,ReferenceNo,Notes,CompanyName)  ' +
      'SELECT 8,tblbankdeposit.Reconciled  , "H" , "Cheque Deposits" , "Deposit" , tblbankdeposit.AccountID , tblbankdeposit.DepositID,tblbankdepositlines.DepositLineID,DepositDate, ABS(Sum(Amount)) as Amount, ' +
      'PaymentID,If(IsNull(CusID),0,CusID) as CusID, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.TrnsType ,"Deposit Entry") as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName ' +
      'FROM tblbankdeposit ' +
      'INNER JOIN tblbankdepositlines Using (DepositID) ' +
      'WHERE tblbankdepositlines.TrnsType="Cheque Deposit" ' +
      'AND ifnull(Round(Amount,5),0) > 0.00 ' +
      'AND tblbankdeposit.Deleted <>"T"  ');

      SQL.Add('Group By tblbankdepositlines.DepositLineID; ');


    SQL.Add('insert into ' +fsTablename  +' (SeqNo,Reconciled,ReconciledFlagtype,Description,Category,AccountID,DepositID,DepositLineID,DepositDate,Amount,PaymentID,CusID,ReferenceNo,Notes,CompanyName)  ' +
      'SELECT 9,tblbankdepositlines.Reconciled , "L" , "Other" , "Withdrawal" , tblbankdepositlines.AccountID , tblbankdeposit.DepositID,tblbankdepositlines.DepositLineID,DepositDate, ' +
      'ABS(Amount) as Amount, PaymentID,If(IsNull(CusID),0,CusID) as CusID, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.TrnsType ,"Split Deposit") as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName ' +
      'FROM tblbankdeposit ' +
      'INNER JOIN tblbankdepositlines Using (DepositID) ' +
      'WHERE tblbankdepositlines.TrnsType<>"Deposit Entry" ' +
      'AND tblbankdepositlines.TrnsType<>"Cheque"  ' +
      'AND tblbankdepositlines.TrnsType<>"Cheque Deposit" ' +
      'AND tblbankdepositlines.TrnsType<>"'+CUSTOMER_PREPAYMENT+'" ' +
      'AND tblbankdepositlines.TrnsType<>"Supplier Prepayment" ' +
      'AND tblbankdeposit.Deleted <>"T"  ' +
      'AND FromDeposited<>"T" ' +
      'AND ifnull(Round(Amount,5),0) < 0.00 ');


      SQL.Add('Group By tblbankdepositlines.DepositLineID; ');

    //Bank Deposit
    SQL.Add('insert into ' +fsTablename  +' (SeqNo,Reconciled,ReconciledFlagtype,Description,Category,AccountID,DepositID,DepositLineID,DepositDate,Amount,PaymentID,CusID,ReferenceNo,Notes,CompanyName)  ' +
      'SELECT 10, tblbankdeposit.Reconciled, "H", "Bank Deposit" , "Withdrawal" , tblbankdeposit.AccountID , tblbankdeposit.DepositID,0 as DepositLineID,DepositDate, ABS(Deposit) as Amount, ' +
      'tblbankdeposit.DepositID as PaymentID,If(IsNull(CusID),0,CusID) as CusID, tblbankdeposit.Notes as ReferenceNo, ' +
      '"Bank Deposit" as Notes, ' +
      '"" as CompanyName ' +
      'FROM tblbankdeposit ' +
      'INNER JOIN tblbankdepositlines Using (DepositID) ' +
      'WHERE tblbankdepositlines.TrnsType<>"Deposit Entry" AND tblbankdepositlines.TrnsType<>"Cheque" ' +
      'AND tblbankdepositlines.TrnsType<>"'+CUSTOMER_PREPAYMENT+'" AND tblbankdepositlines.TrnsType<>"Supplier Prepayment" ' +
      'AND ifnull(Round(Deposit,5),0) < 0.00 AND FromDeposited="T" ' +
      'AND tblbankdeposit.Deleted <>"T" ');


      SQL.Add('Group By  tblbankdeposit.DepositID; ');

    //Deposit Entry
    SQL.Add('insert into ' +fsTablename  +' (SeqNo,Reconciled,ReconciledFlagtype,Description,Category,AccountID,DepositID,DepositLineID,DepositDate,Amount,PaymentID,CusID,ReferenceNo,Notes,CompanyName)  ' +
      'SELECT 11, tblbankdeposit.Reconciled  ,"H",  "Deposit Entry" , "Withdrawal" ,tblbankdeposit.AccountID ,  tblbankdeposit.DepositID,0 as DepositLineID,DepositDate, ABS(Deposit) as Amount, ' +
      'tblbankdeposit.DepositID as PaymentID,If(IsNull(CusID),0,CusID) as CusID,' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.TrnsType ,"Deposit Entry") as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName ' +
      'FROM tblbankdeposit ' +
      'INNER JOIN tblbankdepositlines Using (DepositID) ' +
      'WHERE tblbankdepositlines.TrnsType="Deposit Entry" ' +
      'AND ifnull(Round(Deposit,5),0) < 0.00 ' +
      'AND tblbankdeposit.Deleted <>"T"  ');


      SQL.Add('Group By  tblbankdeposit.DepositID ;');

    //Deposit Entry Split
    SQL.Add('insert into ' +fsTablename  +' (SeqNo,Reconciled,ReconciledFlagtype,Description,Category,AccountID,DepositID,DepositLineID,DepositDate,Amount,PaymentID,CusID,ReferenceNo,Notes,CompanyName)  ' +
      'SELECT 12, tblbankdepositlines.Reconciled , "L" , "Deposit Entry Split" , "Withdrawal" , tblbankdepositlines.AccountID , tblbankdeposit.DepositID,DepositLineID,DepositDate, ABS(Amount) as Amount, ' +
      'tblbankdeposit.DepositID as PaymentID,If(IsNull(CusID),0,CusID) as CusID,' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      '"Split Deposit" as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName ' +
      'FROM tblbankdeposit ' +
      'INNER JOIN tblbankdepositlines Using (DepositID) ' +
      'WHERE tblbankdepositlines.TrnsType="Deposit Entry" ' +
      'AND ifnull(Round(Amount,5),0) > 0.00 ' +
      'AND tblbankdeposit.Deleted <>"T"  ');


      SQL.Add('Group By tblbankdepositlines.DepositLineID  ;');

    //Supplier Prepayment
    SQL.Add('insert into ' +fsTablename  +' (SeqNo,Reconciled,ReconciledFlagtype,Description,Category,AccountID,DepositID,DepositLineID,DepositDate,Amount,PaymentID,CusID,ReferenceNo,Notes,CompanyName)  ' +
        '  SELECT 13, tblbankdepositlines.Reconciled, "L" , "Supplier Prepayment" , "Withdrawal" ,tblbankdepositlines.AccountID ,  tblbankdeposit.DepositID,tblbankdepositlines.DepositLineID,DepositDate, ABS(Sum(Amount)) as Amount, ' +
      'PaymentID,If(IsNull(CusID),0,CusID) as CusID, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.TrnsType ,"Split Deposit") as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName  ' +
      'FROM tblbankdeposit  ' +
      'INNER JOIN tblbankdepositlines Using (DepositID) ' +
      'WHERE tblbankdepositlines.TrnsType="Supplier Prepayment" ' +
      'AND tblbankdeposit.Deleted <>"T" AND ifnull(Round(Amount,5),0) > 0.00 ');
      SQL.Add('Group By tblbankdepositlines.DepositLineID ; ');

    //negative Customer Prepayment as withdrawal
    SQL.Add('insert into ' +fsTablename  +' (SeqNo,Reconciled,ReconciledFlagtype,Description,Category,AccountID,DepositID,DepositLineID,DepositDate,Amount,PaymentID,CusID,ReferenceNo,Notes,CompanyName)  ' +
      'SELECT 14, tblbankdepositlines.Reconciled,  "L" ,"'+CUSTOMER_PREPAYMENT+'" , "Withdrawal" , tblbankdeposit.AccountID , tblbankdeposit.DepositID,tblbankdepositlines.DepositLineID,DepositDate,  ABS(Deposit) as Amount, ' +
      'tblbankdeposit.DepositID as PaymentID,If(IsNull(CusID),0,CusID) as CusID,' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.TrnsType ,"Deposit Entry") as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName ' +
      'FROM tblbankdeposit ' +
      'INNER JOIN tblbankdepositlines Using (DepositID) ' +
      'WHERE tblbankdepositlines.TrnsType="'+CUSTOMER_PREPAYMENT+'" ' +
      'AND ifnull(Round(Deposit,5),0) < 0.00 ' +
      'AND tblbankdeposit.Deleted <>"T"  ');
      SQL.Add('Group By tblbankdepositlines.DepositLineID ;');

    //Cheques
    SQL.Add('insert into ' +fsTablename  +' (SeqNo,Reconciled,ReconciledFlagtype,Description,Category,AccountID,DepositID,DepositLineID,DepositDate,Amount,PaymentID,CusID,ReferenceNo,Notes,CompanyName)  ' +
        '  SELECT 15, tblbankdeposit.Reconciled,"H",  "Cheques" ,  "Withdrawal" ,tblbankdeposit.AccountID ,  tblbankdeposit.DepositID,0 as DepositLineID,DepositDate, ABS(Deposit) as Amount, ' +
      // 0 as DepositLineID Due To
      'PaymentID,If(IsNull(CusID),0,CusID) as CusID, ' +                                                                                         //  Grouping
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.TrnsType ,"Split Deposit") as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName  ' +
      'FROM tblbankdeposit  ' +
      'INNER JOIN tblbankdepositlines Using (DepositID) ' +
      'WHERE tblbankdepositlines.TrnsType="Cheque" ' +
      'AND tblbankdeposit.Deleted <>"T" ' +
      'AND ifnull(Round(Deposit,5),0) < 0.00 ');


      SQL.Add('Group By tblbankdeposit.DepositID ; '); //Not tblbankdepositlines.DepositLineID  Because Sum Of Cheque Header Account

    //Cheque Deposits
    SQL.Add('insert into ' +fsTablename  +' (SeqNo,Reconciled,ReconciledFlagtype,Description,Category,AccountID,DepositID,DepositLineID,DepositDate,Amount,PaymentID,CusID,ReferenceNo,Notes,CompanyName)  ' +
      'SELECT 16, tblbankdeposit.Reconciled, "H", "heque Deposits" , "Withdrawal" , tblbankdeposit.AccountID  , tblbankdeposit.DepositID,tblbankdepositlines.DepositLineID,DepositDate, ABS(Sum(Amount)) as Amount, ' +
      'PaymentID,If(IsNull(CusID),0,CusID) as CusID, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.TrnsType ,"Deposit Entry") as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName ' +
      'FROM tblbankdeposit ' +
      'INNER JOIN tblbankdepositlines Using (DepositID) ' +
      'WHERE tblbankdepositlines.TrnsType="Cheque Deposit" ' +
      'AND ifnull(Round(Amount,5),0) < 0.00 ' +
      'AND tblbankdeposit.Deleted <>"T"  ');
      SQL.Add('Group By tblbankdepositlines.DepositLineID ');
      SQL.add('Order by DepositDate;');
    SQL.add('Drop table if exists ' +fstablename +'d;');
    SQL.add('Create table ' +fstablename +'d '+
              'Select RDL.* from tblreconciliationdepositlines RDL  '+
              'inner join tblreconciliation R using (ReconciliationID )  '+
              'Where ifnull(R.Deleted,"F") ="F";');
    SQL.add('Drop table if exists ' +fstablename +'w;');
    SQL.add('Create table ' +fstablename +'w  '+
              'Select RwL.* from tblreconciliationwithdrawallines RwL  '+
              'inner join tblreconciliation R using (ReconciliationID )   '+
              'Where ifnull(R.Deleted,"F") ="F";');
    showProgressbar('Refreshing List' , 25, False);
    try
      BEFOREEXECUTE :=MyScriptBeforeExecute;
      Execute;
    finally
      HideProgressbar;
    end;
finally
    Free;
end;

closeDB(Qry1);
closedb(Qry2);
closedb(Qry3);
closedb(Qry4);

Qry1.SQL.clear;
Qry2.SQL.clear;
Qry3.SQL.clear;
Qry4.SQL.clear;

Qry1.SQL.add('SELECT T.* , RDL.ReconciliationID, RDL.ReconciliationLineID       FROM ' +fsTablename + '  AS T ' +
              ' Left Join  ' +fstablename +'d  AS RDL ' +
              ' ON  ifnull(RDL.PaymentID,0)     = ifnull(T.DepositID,0) ' +
              ' ANd ifnull(RDL.Payee,"")        = ifnull(T.CompanyName,"") ' +
              ' AND ifnull(RDL.DepositLineID,0) = ifnull(T.DepositLineID,0) ' +
              ' AND ifnull(RDL.ClientID,0)      = ifnull(T.CusID,0) ' +
              ' AND ifnull(RDL.Reference,"")    = ifnull(T.ReferenceNo,"")  ' +
              ' AND Date(ifnull(RDL.DepositDate,0))   = Date(ifnull(T.DepositDate,0))  ' +
              ' AND ifnull(RDL.AccountID,0)     = ifnull(T.AccountID,0)  ' +
              ' AND  ifnull(RDL.Notes,"")       = ifnull(T.Notes,"")' +
              ' and ifnull(T.Category,"")       =  "Deposit" ' +
              ' WHERE ifnull(T.reconciled,"F")  = "T"  ' +
              ' and ifnull(RDL.ReconciliationLineID ,0) = 0  ' +
              ' and ifnull(Category,"")         = "Deposit" '+
              'UNION ALL '+
              'SELECT T.* , RDL.ReconciliationID, RDL.ReconciliationLineID     FROM ' +fsTablename + '  AS T ' +
              ' Left Join  ' +fstablename +'d  AS RDL  on ' +
              '  T.DepositID = RDL.PaymentID  ' +
              ' AND T.DepositDate = RDL.DepositDate  ' +
              ' AND ifnull(Category,"")         = "Bank Deposit" '+
              ' AND T.AMOUNT = RDL.Amount  ' +
              '  AND RDL.Notes = "Bank Deposit" where ifnull(T.reconciled,"F")  = "T"  ' );



Qry2.SQL.add('SELECT T.* ,RDL.ReconciliationID, RDL.ReconciliationLineID  FROM ' +fsTablename + '  AS T ' +
              ' Left Join  ' +fstablename +'d  AS RDL ' +
              ' ON  ifnull(RDL.PaymentID,0) = ifnull(T.DepositID,0) ' +
              ' ANd ifnull(RDL.Payee,"") = ifnull(T.CompanyName,"") ' +
              ' AND ifnull(RDL.DepositLineID,0) = ifnull(T.DepositLineID,0) ' +
              ' AND ifnull(RDL.ClientID,0) =ifnull( T.CusID,0) ' +
              ' AND ifnull(RDL.Reference,"") = ifnull(T.ReferenceNo,"")  ' +
              ' AND Date(ifnull(RDL.DepositDate,0))   = Date(ifnull(T.DepositDate,0))  ' +
              ' AND ifnull(RDL.AccountID,0) = ifnull(T.AccountID,0)  ' +
              ' AND ifnull(RDL.Notes,"")  = ifnull(T.Notes,"")' +
              ' and ifnull(T.Category,"") =  "Deposit" ' +
              ' WHERE ifnull(T.reconciled,"") = "F"  ' +
              ' and ifnull(RDL.ReconciliationLineID ,0) <> 0  ' +
              ' and ifnull(Category,"") = "Deposit"');

Qry3.SQl.add('SELECT T.*  ,RwL.ReconciliationID, RwL.ReconciliationLineID ' +
              ' FROM ' +fsTablename +'  AS T ' +
              ' Left Join  ' +fstablename +'w AS RwL  ' +
              ' ON  ifnull(RwL.PaymentID,0) = ifnull(T.DepositID,0)  ' +
              ' ANd ifnull(RWL.Payee,"") = ifnull(T.CompanyName,"") ' +
              ' AND ifnull(RwL.DepositLineID,0) = ifnull(T.DepositLineID,0)  ' +
              ' AND ifnull(RwL.ClientID,0) = ifnull(T.CusID,0)  ' +
              ' AND ifnull(RwL.Reference,"") = ifnull(T.ReferenceNo,"")  ' +
              ' AND Date(ifnull(RwL.DepositDate,0))   = Date(ifnull(T.DepositDate,0))  ' +
              ' AND ifnull(RwL.AccountID,0) = ifnull(T.AccountID,0)  ' +
              ' and ifnull(T.Category,"") =  "Withdrawal" ' +
              ' AND ifnull(RwL.Notes,"")  = ifnull(T.Notes,"")' +
              ' WHERE ifnull(T.reconciled,"") = "T"  ' +
              ' and ifnull(RwL.ReconciliationLineID ,0) = 0 ' +
              ' and ifnull(Category,"") = "Withdrawal"');
              
Qry4.SQL.add('SELECT T.*  ,RwL.ReconciliationID, RwL.ReconciliationLineID ' +
              ' FROM ' +fsTablename +' AS T ' +
              ' Left Join  ' +fstablename +'w AS RwL  ' +
              ' ON  ifnull(RwL.PaymentID,0) = ifnull(T.DepositID,0)  ' +
              ' ANd ifnull(RwL.Payee,"") = ifnull(T.CompanyName,"") ' +
              ' AND ifnull(RwL.DepositLineID,0) = ifnull(T.DepositLineID,0)  ' +
              ' AND ifnull(RwL.ClientID,0) = ifnull(T.CusID,0)  ' +
              ' AND ifnull(RwL.Reference,0) = ifnull(T.ReferenceNo,"")  ' +
              ' AND Date(ifnull(RwL.DepositDate,0))   = Date(ifnull(T.DepositDate,0)) ' +
              ' AND ifnull(RwL.AccountID,0) = ifnull(T.AccountID,0)  ' +
              ' and ifnull(T.Category,"") =  "Withdrawal" ' +
              ' AND ifnull(RwL.Notes,"")  = ifnull(T.Notes,"")' +
              ' WHERE ifnull(T.reconciled,"") = "F"  ' +
              ' and ifnull(RwL.ReconciliationLineID ,0) <> 0 ' +
              ' and ifnull(Category,"") = "Withdrawal"');





  showProgressbar('Refreshing List' , 4, False);
  try
    OpenDB(Qry4);
      stepProgressbar;
    OpenDB(Qry3);
      stepProgressbar;
    OpenDB(Qry2);
      stepProgressbar;
    OpenDB(Qry1);
      stepProgressbar;
  finally
    HideProgressbar;
  end;
end;
procedure TfmRecTrans.FormShow(Sender: TObject);
begin
  inherited;
  {$IFDEF DevMode}
    btnPopulateSQL.visible := True;
  {$ELSE}
    btnPopulateSQL.visible := False;
  {$ENDIF}

closeDB(Qry1);
closedb(Qry2);
closedb(Qry3);
closedb(Qry4);
(*closedb(Qry6);*)
  btnrefreshclick(btnrefresh);
end;

procedure TfmRecTrans.FormCreate(Sender: TObject);
begin
  inherited;
  fbTabSettingEnabled := false;
end;

procedure TfmRecTrans.Button2Click(Sender: TObject);
var
  strSQL:string;
begin
  inherited;
  strSQL:= '{One}' +Qry1.SQL.text+
          '~|||~{Two}'+Qry2.SQL.text+
          '~|||~{Three}'+Qry3.SQL.text+
          '~|||~{Four}'+Qry4.SQL.text(*+
          '~|||~{Four}'+Qry6.SQL.text*);
  fbReportSQLSupplied := True;
  PrintTemplateReport('Invalid Bank Rec.' ,strSQL  , False , 1);
  fbReportSQLSupplied :=False;
end;

procedure TfmRecTrans.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmRecTrans.Qry1AfterOpen(DataSet: TDataSet);
begin
  inherited;
  lbl1.caption := 'Total Records :  ' +IntToStr(Qry1.recordcount);
end;

procedure TfmRecTrans.qry2AfterOpen(DataSet: TDataSet);
begin
  inherited;
  lbl2.caption := 'Total Records :  ' +IntToStr(Qry2.recordcount);
end;

procedure TfmRecTrans.Qry3AfterOpen(DataSet: TDataSet);
begin
  inherited;
  lbl3.caption := 'Total Records :  ' +IntToStr(Qry3.recordcount);
end;

procedure TfmRecTrans.Qry4AfterOpen(DataSet: TDataSet);
begin
  inherited;
  lbl4.caption := 'Total Records :  ' +IntToStr(Qry4.recordcount);
end;
procedure TfmRecTrans.DNMSpeedButton5Click(Sender: TObject);
begin
  inherited;
  Fixit(wwDBGrid1 , Qry1 , 1);
end;
procedure TfmRecTrans.Fixit(Grid :TwwDBGrid ; Qry :TERPQuery;Gridno :Integer);
var
  i:Integer;
  tablename:String;
  fieldname:String;
begin
  if not LockForSingleUser then exit;
  try
(*    Addfixfield;*)
      if Grid.SelectedList.Count > 0 then begin
        BeginTransaction;
        try
          With CommonDbLib.TempMyQuery do try
            connection := Self.MyConnection;
              showProgressbar('Please Wait', Grid.Selected.Count);
              try
                for i := 0 to Grid.SelectedList.Count - 1 do begin
                    stepProgressbar;
                    Qry.GotoBookmark(Grid.SelectedList.Items[i]);
                    SQl.clear;
                    if Qry.fieldbyname('ReconciledFlagtype').asString ='H' then begin
                      SQL.add('Select * from tblbankdeposit where DepositID = ' +IntToStr(Qry.fieldByname('DepositID').asInteger));
                      fieldname := 'DepositID';
                      tablename := 'tblbankdeposit';
                    end else if Qry.fieldbyname('ReconciledFlagtype').asString ='L' then begin
                      SQL.add('Select * from tblbankdepositlines where DepositLineID = ' +IntToStr(Qry.fieldByname('DepositLineID').asInteger));
                      tablename := 'tblbankdepositlines';
                      fieldname := 'DepositLineID';
                    end;
                    open;
                    if recordcount = 0 then continue;

                    (*if fieldByname('ERPFixREconciled').asString <> 'N' then Continue;
                    Edit;
                    fieldByname('ERPFixREconciled').asString := Qry.fieldByname('Reconciled').asString;*)

                    Edit;
                    if  ((Gridno = 1) or ( Gridno = 3)) and (fieldByname('Reconciled').asString <>'F')  then begin
                      TGenData.NewRec('BankRecFix',Tablename , IntToStr(Fieldbyname(fieldname).asinteger) ,'Reconciled' , fieldByname('Reconciled').asString , 'F');
                      fieldByname('Reconciled').asString :='F';
                    end else if  ((Gridno = 2) or ( Gridno = 4)) and (fieldByname('Reconciled').asString <> 'T')  then begin
                      TGenData.NewRec('BankRecFix',Tablename , IntToStr(Fieldbyname(fieldname).asinteger) ,'Reconciled' , fieldByname('Reconciled').asString , 'F');
                      fieldByname('Reconciled').asString :='T';
                    end;
                    post;

                    (*AddAudit(Qry.fieldbyname('ReconciledFlagtype').asString ,Gridno , Fieldbyname('globalref').asString);*)
                    Close;
                end;
              finally
                hideProgressbar;
              end;
          finally
              Free;
          end;
          CommitTransaction;
          btnrefreshclick(btnrefresh);
        except
            RollbackTransaction;
        end;
      end;
  finally
    AppEnv.UtilsClient.UnlockLogon;
  end;
end;
(*Procedure TfmRecTrans.AddAudit(ReconciledFlagtype:String; GridNo:Integer;TransGlobalref:String);
var
  Str:String;
begin

  str := 'insert into tblaudittrail  (TransType , DataDescription , AuditDate , '+
                'EmployeeID , ChangedFields , TransGlobalref )' +
        ' Values (' ;
  str:= str +Quotedstr('ERPReconciliationFix')+' ,';

  if ReconciledFlagtype ='H' then str:= str+ QuotedStr('tblbankdeposit')+',' else str:= str+QuotedStr('tblbankdepositlines')+',' ;
  str:= str +Quotedstr(formatdatetime(mysqlDateformat, now))+' ,';
  str:= str +IntToStr(Appenv.Employee.EmployeeID)+' ,';
       if GridNo=1 then str:= str+QuotedStr(TabSheet1.Caption +': Field = Reconciled , OldValue ="T", NewValue ="F"')+' ,'
  else if GridNo=2 then str:= str+QuotedStr(TabSheet2.Caption +':Field = Reconciled , OldValue ="F", NewValue ="T"')+' ,'
  else if GridNo=3 then str:= str+QuotedStr(TabSheet3.Caption +':Field = Reconciled , OldValue ="T", NewValue ="F"')+' ,'
  else if GridNo=4 then str:= str+QuotedStr(TabSheet4.Caption +':Field = Reconciled , OldValue ="F", NewValue ="T"')+' ,';
  str:= str +Quotedstr(TransGlobalref)+' )';
  ExecuteSQL(str);


end;*)
(*procedure TfmRecTrans.Addfixfield;
begin
  Try
    ExecuteSQL('alter table tblbankdepositlines add column ERPFixREconciled enum("T","F", "N") Default "N"');
  Except
      // kill the exception
  end;
  Try
    ExecuteSQL('alter table tblbankdeposit add column ERPFixREconciled enum("T","F","N") Default "N"');
  Except
      // kill the exception
  end;

end;*)

function TfmRecTrans.LockforSingleUser: Boolean;
var
  msg:String;
begin
  result := False;

  if AppEnv.UtilsClient.LockLogon(msg,AppEnv.AppDb.Database, 'Performing Reconciliation Fix') then begin
    result:= true;
  end
  else begin
    if msg = USERS_IN_SYSTEM_MESSAGE then begin
      MainForm.GetCurrentUserCount;
      dtmMainGUI.dlgCurrentUsers.Caption := myConnection.Database + ' Reconciliation Fix';
      dtmMainGUI.dlgCurrentUsers.Color := self.Color;
      dtmMainGUI.dlgCurrentUsers.Message := 'The following user(s) must exit the system.';
      dtmMainGUI.dlgCurrentUsers.Execute;
    end
    else begin
      MessageDlgXP_Vista('Unable to perform Reconciliation Fix, Unable to Lock User Logon: ' + msg, mtInformation, [mbOk], 0);
    end;
  end;
end;

procedure TfmRecTrans.DNMSpeedButton4Click(Sender: TObject);
begin
  inherited;
  Fixit(wwDBGrid2 , Qry2 , 2);
end;

procedure TfmRecTrans.DNMSpeedButton3Click(Sender: TObject);
begin
  inherited;
  Fixit(wwDBGrid3 , Qry3 , 3);
end;

procedure TfmRecTrans.DNMSpeedButton2Click(Sender: TObject);
begin
  inherited;
  Fixit(wwDBGrid4 , Qry4 , 4);
end;

procedure TfmRecTrans.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
 OpenERPListForm('TGenDataListGUI', beforeshowGenDataList)
end;

procedure TfmRecTrans.beforeshowGenDataList(Sender: TObject);
begin
if not(Sender is     TGenDataListGUI) then Exit;
  TGenDataListGUI(Sender).filterstring := 'Description = ' +Quotedstr('BankRecFix');
  TGenDataListGUI(Sender).Description := 'Description';
  TGenDataListGUI(Sender).Value1 := 'Tablename';
  TGenDataListGUI(Sender).Value2:= 'ID';
  TGenDataListGUI(Sender).Value3:= 'FieldName';
  TGenDataListGUI(Sender).Value4:= 'Old Value';
  TGenDataListGUI(Sender).Value5:= 'New Value';
end;

procedure TfmRecTrans.MyScriptBeforeExecute(Sender: TObject; var SQL: String; var Omit: Boolean);
begin
  stepProgressbar;
end;

procedure TfmRecTrans.FormDestroy(Sender: TObject);
begin
  inherited;
  CommonDbLib.DestroyUserTemporaryTable(fsTablename);
  CommonDbLib.DestroyUserTemporaryTable(fsTablename+'d');
  CommonDbLib.DestroyUserTemporaryTable(fsTablename+'w');
end;

procedure TfmRecTrans.btnPopulateSQLClick(Sender: TObject);
var
  x:TLockManagement;
begin
  inherited;
  x:= TLockManagement.create;
  try
    x.logSQLs;
  finally
      Freeandnil(x);
  end;
end;

procedure TfmRecTrans.qry6AfterOpen(DataSet: TDataSet);
begin
  inherited;
  (*lbl6.caption := 'Total Records :  ' +IntToStr(Qry6.recordcount);*)
end;

initialization
  RegisterClassOnce(TfmRecTrans);

end.
