unit InventoryAssetList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, ComCtrls, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TInventoryAssetListGUI = class(TBaseListingGUI)
    dsCostDetails: TDataSource;
    QryCostDetails: TERPQuery;
    qryMainPartsID: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainMultipleBins: TWideStringField;
    qryMainbatch: TWideStringField;
    qryMainSNTracking: TWideStringField;
    qryMainLandedCost: TFloatField;
    qryMainProductTypeCode: TWideStringField;
    qryMainFirstColumn: TWideStringField;
    qryMainSecondColumn: TWideStringField;
    qryMainThirdColumn: TWideStringField;
    qryMainSalesDescription: TWideStringField;
    QrymainASSETACCNT: TWideStringField;
    qryMainSOBO: TFloatField;
    qryMainAvailable: TFloatField;
    qryMaininstock: TFloatField;
    qryMainSOQty: TFloatField;
    qryMainInvBO: TFloatField;
    qryMainPOBO: TFloatField;
    qryMainonbuild: TFloatField;
    qryMainBuilding: TFloatField;
    qryMaincost1: TFloatField;
    qryMainPrice1: TFloatField;
    qryMainWHOLESALEPRICE: TFloatField;
    qryMainPURCHASEDESC: TWideStringField;
    qryMainProductCode: TWideStringField;
    qryMainPreferredSupplier: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainSupplierProductCode: TWideStringField;
    qryMainArea: TWideStringField;
    qryMainAvgCost: TFloatField;
    qryMainStockValue: TFloatField;
    qryMainBalamount: TFloatField;
    qryMainDiffAmount: TFloatField;
    qryMainIsSystemProduct: TWideStringField;
    qryMainCalctotalcost: TFloatField;
    QryCostDetailsID: TIntegerField;
    QryCostDetailsPartsId: TIntegerField;
    QryCostDetailsDate: TDateTimeField;
    QryCostDetailstype: TWideStringField;
    QryCostDetailsDescription: TWideStringField;
    QryCostDetailsTransId: TIntegerField;
    QryCostDetailsTransQty: TFloatField;
    QryCostDetailsQty: TFloatField;
    QryCostDetailscost: TFloatField;
    QryCostDetailstotalcost: TFloatField;
    DNMPanel1: TDNMPanel;
    Label4: TLabel;
    chkHideProducts: TwwCheckBox;
    dsAssetAccounts: TDataSource;
    QryAssetAccounts: TERPQuery;
    dsCostsum: TDataSource;
    QryCostsum: TERPQuery;
    QryCostsumPartsID: TIntegerField;
    QryCostsumtotalcost: TFloatField;
    dsBalancesheet: TDataSource;
    QryAssetAccountsID: TIntegerField;
    QryAssetAccountsPartscount: TIntegerField;
    QryAssetAccountsAccountName: TWideStringField;
    QryAssetAccountscalctotalcost: TFloatField;
    QryAssetAccountsBalanceSheetamt1: TFloatField;
    QryAssetAccountsBalanceSheetamtexJE1: TFloatField;
    QryAssetAccountsBalanceSheetamt2: TFloatField;
    QryAssetAccountsBalanceSheetamtexJE2: TFloatField;
    QryAssetAccountsBalanceSheetamt: TFloatField;
    QryAssetAccountsBalanceSheetamtexJE: TFloatField;
    QryAssetAccountsDifference: TFloatField;
    QryAssetAccountsDifferenceexJE: TFloatField;
    Splitter1: TSplitter;
    dsBalancesheetDetails: TDataSource;
    QryBalancesheetDetails: TERPQuery;
    WideStringField1: TWideStringField;
    WideStringField2: TWideStringField;
    FloatField1: TFloatField;
    WideStringField3: TWideStringField;
    QryBalancesheet: TERPQuery;
    QryBalancesheetType: TWideStringField;
    QryBalancesheetPriorToclosingDt: TWideStringField;
    QryBalancesheetAmount: TFloatField;
    QryBalancesheetaccountName: TWideStringField;
    QryBalancesheetDetailsProductname: TWideStringField;
    pgMain: TPageControl;
    TabBalancesheet: TTabSheet;
    report1n2: TSplitter;
    grdAccounts: TwwDBGrid;
    wwIButton2: TwwIButton;
    pnlBalancesheet: TDNMPanel;
    lblBalancesheet: TLabel;
    grdBalancesheet: TwwDBGrid;
    wwIButton3: TwwIButton;
    TabBalancesheetDetails: TTabSheet;
    Splitter2: TSplitter;
    grdAccountsDetails: TwwDBGrid;
    wwIButton4: TwwIButton;
    PnlBalancesheetDetails: TDNMPanel;
    Label2: TLabel;
    grdBalancesheetDetails: TwwDBGrid;
    wwIButton5: TwwIButton;
    TabProduct: TTabSheet;
    grdcosts: TwwDBGrid;
    wwIButton1: TwwIButton;
    Splitter3: TSplitter;
    QryBalancesheetDetailsSeqno: TFloatField;
    QryBalancesheetDetailsPurchaseOrderId: TIntegerField;
    QryBalancesheetDetailssaleId: TIntegerField;
    QryBalancesheetDetailsPaymentID: TIntegerField;
    QryBalancesheetDetailsPrepaymentID: TIntegerField;
    QryBalancesheetDetailsFixedAssetID: TIntegerField;
    QryBalancesheetDetailsDebitsEx: TFloatField;
    QryBalancesheetDetailsCreditsEx: TFloatField;
    QryAssetAccountsDetails: TERPQuery;
    WideStringField4: TWideStringField;
    WideStringField5: TWideStringField;
    FloatField2: TFloatField;
    WideStringField6: TWideStringField;
    dsAssetAccountsDetails: TDataSource;
    QryBalancesheetDetailsDate: TDateField;
    dsPQa: TDataSource;
    QryPQa: TERPQuery;
    pnlPQa: TDNMPanel;
    Label5: TLabel;
    grdPQa: TwwDBGrid;
    wwIButton6: TwwIButton;
    Label6: TLabel;
    Splitter4: TSplitter;
    pnlBSnPQA: TDNMPanel;
    Label7: TLabel;
    grdBSnPQA: TwwDBGrid;
    wwIButton7: TwwIButton;
    dsBSnPQA: TDataSource;
    QryBSnPQA: TERPQuery;
    QryBSnPQAID: TIntegerField;
    QryBSnPQASEQNO: TIntegerField;
    QryBSnPQADATE: TDateTimeField;
    QryBSnPQAPQAID: TIntegerField;
    QryBSnPQATYPE: TWideStringField;
    QryBSnPQACLASSID: TIntegerField;
    QryBSnPQASALEID: TIntegerField;
    QryBSnPQAPURCHASEORDERID: TIntegerField;
    QryBSnPQAPAYMENTID: TIntegerField;
    QryBSnPQAPREPAYMENTID: TIntegerField;
    QryBSnPQAFIXEDASSETID: TIntegerField;
    QryBSnPQASALELINEID: TIntegerField;
    QryBSnPQAPURCHASELINEID: TIntegerField;
    QryBSnPQAPAYMENTLINEID: TIntegerField;
    QryBSnPQAPREPAYMENTLINEID: TIntegerField;
    QryBSnPQAACCOUNTNAME: TWideStringField;
    QryBSnPQAACCOUNTGROUPLEVELS: TWideStringField;
    QryBSnPQALEVEL1: TWideStringField;
    QryBSnPQALEVEL2: TWideStringField;
    QryBSnPQALEVEL3: TWideStringField;
    QryBSnPQALEVEL4: TWideStringField;
    QryBSnPQAACCOUNTID: TIntegerField;
    QryBSnPQAACCOUNTTYPE: TWideStringField;
    QryBSnPQAPRODUCTNAME: TWideStringField;
    QryBSnPQAACTUALTOTALCOST: TFloatField;
    QryBSnPQADEBITSEX: TFloatField;
    QryBSnPQACREDITSEX: TFloatField;
    QryBSnPQADEBITSINC: TFloatField;
    QryBSnPQACREDITSINC: TFloatField;
    QryBSnPQAADEBITSEX: TFloatField;
    QryBSnPQAACREDITSEX: TFloatField;
    QryBSnPQAADEBITSINC: TFloatField;
    QryBSnPQAACREDITSINC: TFloatField;
    btndiff: TDNMSpeedButton;
    QryPQatransId: TLargeintField;
    QryPQadescription: TWideStringField;
    QryPQaTransLineId: TIntegerField;
    QryPQaproductName: TWideStringField;
    QryPQaAlloctype: TWideStringField;
    QryPQaActualtotalcost: TFloatField;
    QryPQaActualtotalcostinc: TFloatField;
    QryPQaqty: TFloatField;
    QryPQatransdate: TDateTimeField;
    DNMSpeedButton3: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure QryCostDetailsAfterOpen(DataSet: TDataSet);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure chkHideProductsClick(Sender: TObject);
    procedure CalcAccountTotals(DataSet: TDataSet);
    procedure CalcCostHistoryTotal(DataSet: TDataSet);
    procedure FormActivate(Sender: TObject);
    procedure grdAccountsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdcostsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure CalcBalancesheetTotal(DataSet: TDataSet);
    procedure grdBalancesheetCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainCalcTitleAttributes(Sender: TObject; AFieldName: string;
      AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure grdAccountsCalcTitleAttributes(Sender: TObject;
      AFieldName: string; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure grdBalancesheetCalcTitleAttributes(Sender: TObject;
      AFieldName: string; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure grdcostsCalcTitleAttributes(Sender: TObject; AFieldName: string;
      AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure Splitter1CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure Splitter1Moved(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure QryAssetAccountsAfterOpen(DataSet: TDataSet);
    procedure QryAssetAccountsDetailsAfterOpen(DataSet: TDataSet);
    procedure QryBalancesheetAfterOpen(DataSet: TDataSet);
    procedure QryBalancesheetDetailsAfterOpen(DataSet: TDataSet);
    procedure qryMainAfterScroll(DataSet: TDataSet);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure QryPQaAfterOpen(DataSet: TDataSet);
    procedure QryBSnPQAAfterOpen(DataSet: TDataSet);
    procedure btndiffClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure DNMSpeedButton3Click(Sender: TObject);
  private
    fstablename :String;
    fsCosttablename :String;
    fsAccountTablename:String;
    fsAccountTablenameDetails :String;
    fsTransactionInvAsset :String;
    ccountsDetailsTotalAmount :double;
    Procedure Populatedata;
    Procedure createTables;
    function ProductAssetValue(ProductQry, inTRansQry,StockcostHistoryQry: TERPQuery): Double;
    Procedure Grdcolours(Sender:TObject;Afieldname:String; AFont: TFont; ABrush: TBrush);
    procedure Gridfields(dataset:TDataset);
    procedure PopulateProductBalansesheet;
    function InTransSQL(Productname:String = ''):String;
    Procedure DoCalcFooter(Dataset :TDataset; grid :TwwDBGrid; fieldnames:String);
    procedure initPQAMovement(Sender: TObject);
  Protected
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    procedure SetGridColumns; Override;
    Procedure RefreshTotals;Override;
    procedure CalcFooter; Overload;Override;

  public
    Procedure RefreshQuery;override;
  end;

implementation

uses ProductQtyLib, BusObjStock, CommonDbLib, tcConst, AppEnvironment, PQALib,
  CommonLib,DNMLib, LogLib, PQAList, TransactionsTable, math,
  CommonFormLib, PQAMovement, DbSharedObjectsObj;

{$R *.dfm}



procedure TInventoryAssetListGUI.chkHideProductsClick(Sender: TObject);
begin
  if chkHideProducts.checked then groupfilterString := 'instock <>0'
  else groupfilterString := '';
  inherited grpFiltersClick(nil);
end;

procedure TInventoryAssetListGUI.createTables;
begin
  With ScriptMain do begin
    SQL.clear;
    SQL.add('Drop table if exists '+fstablename +';');
    SQL.add('CREATE TABLE '+fstablename+' ( '+
          '   ID                  int(11) NOT NULL AUTO_INCREMENT,'+
          '   PartsID             int(11) NOT NULL DEFAULT 0, '+
          '   ProductName         VARCHAR(60) DEFAULT NULL, '+
          '   MultipleBins        ENUM("T","F") Default "F", '+
          '   batch               ENUM("T","F") Default "F", '+
          '   SNTracking          ENUM("T","F") Default "F", '+
          '   LandedCost          DOUBLE NOT NULL DEFAULT 0, '+
          '   ProductTypeCode     VARCHAR(13) DEFAULT NULL, '+
          '   FirstColumn         VARCHAR(255) DEFAULT NULL, '+
          '   SecondColumn        VARCHAR(255) DEFAULT NULL, '+
          '   ThirdColumn         VARCHAR(255) DEFAULT NULL, '+
          '   SalesDescription    VARCHAR(255) DEFAULT NULL, '+
          '   ASSETACCNT          VARCHAR(255) DEFAULT NULL, '+
          '   SOBO                DOUBLE(22,5) DEFAULT NULL, '+
          '   Available           DOUBLE(22,5) DEFAULT NULL, '+
          '   instock             DOUBLE(22,5) DEFAULT NULL, '+
          '   SOQty               DOUBLE(22,5) DEFAULT NULL, '+
          '   InvBO               DOUBLE(22,5) DEFAULT NULL, '+
          '   POBO                DOUBLE(22,5) DEFAULT NULL, '+
          '   onbuild             DOUBLE(22,5) DEFAULT NULL, '+
          '   Building            DOUBLE(22,5) DEFAULT NULL, '+
          '   cost1               DOUBLE NOT NULL DEFAULT 0, '+
          '   Price1              DOUBLE NOT NULL DEFAULT 0, '+
          '   WHOLESALEPRICE      DOUBLE NOT NULL DEFAULT 0, '+
          '   PURCHASEDESC        VARCHAR(255) DEFAULT NULL, '+
          '   ProductCode         VARCHAR(255) DEFAULT NULL, '+
          '   PreferredSupplier   VARCHAR(55) DEFAULT NULL, '+
          '   Active              ENUM("T","F") Default "T", '+
          '   SupplierProductCode VARCHAR(50) DEFAULT NULL, '+
          '   Area                VARCHAR(50) DEFAULT NULL, '+
          '   AvgCost             DOUBLE NOT NULL DEFAULT 0, '+
          '   StockValue          DOUBLE(22,5) DEFAULT NULL, '+
          '   Balamount           DOUBLE(22,5) DEFAULT NULL, '+
          '   DiffAmount          DOUBLE(22,5) DEFAULT NULL, '+
          '   IsSystemProduct     ENUM("T","F") Default "F", '+
          '   Calctotalcost       DOUBLE DEFAULT NULL ,'+
          ' PRIMARY KEY (ID), '+
          ' KEY ProductName (ProductName)'+
          '   ) ENGINE=MyISAM DEFAULT CHARSET=utf8;');

    SQL.add('Drop table if exists '+ fsCosttablename+';');
    SQL.add('CREATE TABLE '+ fsCosttablename+' ( '+
                      ' ID            INT(11)     NOT NULL AUTO_INCREMENT, '+
                      ' PartsId       INT(11)         NULL DEFAULT NULL, '+
                      ' Date          DATETIME        NULL DEFAULT NULL, '+
                      ' type          VARCHAR(100)    NULL DEFAULT NULL, '+
                      ' TransId       INT(11)         NULL DEFAULT NULL, '+
                      ' TransQty      DOUBLE          NULL DEFAULT NULL, '+
                      ' Qty           DOUBLE          NULL DEFAULT NULL, '+
                      ' cost          DOUBLE          NULL DEFAULT NULL, '+
                      ' totalcost     DOUBLE          NULL DEFAULT NULL, '+
                      ' PRIMARY KEY (ID)  ) ENGINE=MyISAM; ');

    SQL.add('Drop table if exists '+ fsAccountTablename+';');
    SQL.add('CREATE TABLE '+ fsAccountTablename+' ( '+
                      ' ID              int(11) NOT NULL AUTO_INCREMENT,'+
                      ' Partscount      int(11)       DEFAULT NULL,'+
                      ' AccountName     varchar(100)  DEFAULT NULL,'+
                      ' calctotalcost   double        DEFAULT NULL,'+
                      ' BalanceSheetamt1 double        DEFAULT NULL,'+
                      ' BalanceSheetamt2 double        DEFAULT NULL,'+
                      ' BalanceSheetamtexJE1 double        DEFAULT NULL,'+
                      ' BalanceSheetamtexJE2 double        DEFAULT NULL,'+
                      ' BalanceSheetamt double        DEFAULT NULL,'+
                      ' BalanceSheetamtexJE double        DEFAULT NULL,'+
                      ' Difference double        DEFAULT NULL,'+
                      ' DifferenceexJE double        DEFAULT NULL,'+
                      ' PRIMARY KEY (ID), '+
                      ' KEY AccountName (AccountName)'+
                      ' ) ENGINE=MyISAM ; ');

    SQL.add('Drop table if exists '+ fsAccountTablenamedetails+';');
    SQL.add('CREATE TABLE '+ fsAccountTablenamedetails+' ( '+
                      ' ID              int(11) NOT NULL AUTO_INCREMENT,'+
                      ' ProductName     varchar(100)  DEFAULT NULL,'+
                      ' Type            varchar(100)  DEFAULT NULL,'+
                      ' AccountName     varchar(100)  DEFAULT NULL,'+
                      ' calctotalcost   double        DEFAULT NULL,'+
                      ' BalanceSheetamt1 double        DEFAULT NULL,'+
                      ' BalanceSheetamt2 double        DEFAULT NULL,'+
                      ' BalanceSheetamtexJE1 double        DEFAULT NULL,'+
                      ' BalanceSheetamtexJE2 double        DEFAULT NULL,'+
                      ' BalanceSheetamt double        DEFAULT NULL,'+
                      ' BalanceSheetamtexJE double        DEFAULT NULL,'+
                      ' Difference double        DEFAULT NULL,'+
                      ' DifferenceexJE double        DEFAULT NULL,'+
                      ' PRIMARY KEY (ID), '+
                      ' KEY AccountName (AccountName)'+
                      ' ) ENGINE=MyISAM ; ');

    Logtext(SQL.Text);
    Execute;
  end;
end;

procedure TInventoryAssetListGUI.DNMSpeedButton3Click(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TPQAMovementGUI' , initPQAMovement);
end;
procedure TInventoryAssetListGUI.initPQAMovement(Sender:TObject);
begin
  if not(Sender is TPQAMovementGUI) then exit;
  TPQAMovementGUI(Sender).ProductId := qryMainPARTSID.AsInteger;
end;

procedure TInventoryAssetListGUI.FormActivate(Sender: TObject);
begin
  inherited;
  Self.WindowState := wsMaximized;
end;

procedure TInventoryAssetListGUI.FormCreate(Sender: TObject);
begin
  btndiff.visible := Devmode;
  grpfilters.visible := Devmode;

  NonSearchMode:= true;
  grdAccounts.hint := 'Total Amount :Summary from the PQA (based on individual transactions)'+NL+
                      'Balancesheet Amount:Summary from the Balancesheet (Transaction Table)'+NL;
  grdAccounts.showhint :=  True;

  grdBalancesheet.hint :='Balancesheet Summary on Transaction Types'+NL;
  grdBalancesheet.showhint :=  True;


  grdMain.hint :='Summary from the PQA (based on individual transactions)'+NL;
  grdMain.showhint :=  True;

  grdcosts.hint :='List of latest transactions that make up the In-stock Qty of the selected product.'+
                  'Asset Value of the product is based on the cost in these transactions for the product.'+NL;
  grdcosts.showhint :=  True;


  fstablename := commondblib.GetUserTemporaryTableName('InvAsset');
  fsCosttablename := fstablename +'Costs';
  fsAccountTablename:= fstablename +'Accounts';
  fsAccountTablenamedetails:= fstablename +'AccountsDetails';
  fsTransactionInvAsset := commondbLib.CreateUserTemporaryTable('tmp_TransactionInvAsset' , '');


  createTables;
  Qrymain.SQL.text := 'Select * from ' + fstablename;

  QryCostDetails.SQL.text   := ' Select T.* , TT.Description from ' + fsCosttablename +' T inner join tblpqatranstypes TT on T.type = TT.Transtype';
  QryCostsum.SQL.text       := ' Select PartsID, sum(totalcost) as totalcost from ' + fsCosttablename +' T group by partsID';
  QryAssetAccounts.SQL.text := ' Select * from '+  fsAccountTablename;
  QryAssetAccountsDEtails.SQL.text := ' Select * from '+  fsAccountTablenameDetails;

  QryAssetAccountsDetails.SQl.text :=  'SELECT  "F" PriorToclosingDt,  Trans.accountName,  Trans.Type,  TRUNCATE(Sum(DebitsEx)-Sum(CreditsEx),4) AS Amount '+
                      'FROM tbltransactions   as Trans '+
                      'WHERE Trans.AccountName in (Select Distinct AccountName from  ' +fsAccountTablename +') '+
                      'and Productname = :ProductName '+
                      'Group By type '+
                      'union all '+
                      'SELECT  "T" as PriorToclosingDt,  Trans.Accountname,  Trans.Type,  TRUNCATE(Sum(DebitsEx)-Sum(CreditsEx),4) AS Amount '+
                      'FROM tbltransactionsummarydetails  as Trans '+
                      'WHERE Trans.AccountName in (Select Distinct AccountName from  ' +fsAccountTablename +') '+
                      'and Productname = :ProductName '+
                      'Group By type';


  QryBalancesheet.SQL.text :=   'SELECT '+
                      'Trans.date, Trans.Seqno,'+
                      'Trans.PurchaseOrderId, Trans.saleId,Trans.PaymentID, Trans.PrepaymentID , Trans.FixedAssetID,'+
                      ' "F" PriorToclosingDt, '+
                      ' Trans.accountName, '+
                      ' Trans.Type, '+
                      ' TRUNCATE(Sum(DebitsEx)-Sum(CreditsEx),4) AS Amount '+
                      ' FROM tbltransactions   as Trans '+
                      ' WHERE Trans.AccountName in (Select Distinct AccountName from  '+fsAccountTablename +')'+
                      ' Group By type, accountName '+
                      ' union all '+
                      ' SELECT '+
                      'Trans.date, Trans.Seqno,'+
                      'Trans.PurchaseOrderId, Trans.saleId,Trans.PaymentID, Trans.PrepaymentID , Trans.FixedAssetID,'+
                      ' "F" PriorToclosingDt, '+
                      ' Trans.accountName, '+
                      ' Trans.Type, '+
                      ' TRUNCATE(Sum(DebitsEx)-Sum(CreditsEx),4) AS Amount '+
                      ' FROM tbltransactionsummarydetails   as Trans '+
                      ' WHERE Trans.AccountName in (Select Distinct AccountName from  '+fsAccountTablename +')'+
                      ' Group By type, accountName '+
                      ' order by  purchaseOrdeRId, saleId,   Date desc, Type, PriorToclosingDt';

  QryPQa.SQL.text :=   'select PQA.transId, TT.description, PQA.TransLineId, PQA.productName, PQA.Alloctype, '+
                      pqalib.SQL4QtyField(tInstock(*tActStockwithMan*),'PQA','Actualtotalcost') +' as Actualtotalcost ,'+
                      pqalib.SQL4QtyField(tInstock(*tActStockwithMan*),'PQA','Actualtotalcost') +' as Actualtotalcostinc,' +
                      pqalib.SQL4QtyField(tInstock(*tActStockwithMan*), 'PQA' , 'QTY')    +' as qty, PQA.transdate'+
                      ' from tbltransactionpqas PQA'+
                      ' Left join tblpqatranstypes TT on PQA.TransType = TT.transType'+
                      ' where productname = :ProductName '+
                      ' having 	round(qty,'+ inttostr(TcConst.GeneralRoundPlaces) +') <> 0'+
                      ' order by transdate desc , PQA.transtype';


  QryBalancesheetDetails.SQL.text :=   'SELECT '+
                      'Trans.Date,'+
                      'Trans.Seqno,'+
                      'Trans.PurchaseOrderId, Trans.saleId,Trans.PaymentID, Trans.PrepaymentID , Trans.FixedAssetID,'+
                      ' "F" PriorToclosingDt, '+
                      ' Trans.accountName, '+
                      'Trans.ProductName,'+
                      ' Trans.Type, '+
                      'DebitsEx,CreditsEx,'+
                      ' TRUNCATE((DebitsEx)-(CreditsEx),4) AS Amount '+
                      ' FROM tbltransactions   as Trans '+
                      ' WHERE Trans.AccountName in (Select Distinct AccountName from  '+fsAccountTablename +')'+
                      ' and Productname = :ProductName '+
                      ' union all '+
                      'SELECT '+
                      'Trans.Date,'+
                      'Trans.Seqno,'+
                      'Trans.PurchaseOrderId, Trans.saleId,Trans.PaymentID, Trans.PrepaymentID , Trans.FixedAssetID,'+
                      ' "T" PriorToclosingDt, '+
                      ' Trans.accountName, '+
                      'Trans.ProductName,'+
                      ' Trans.Type, '+
                      'DebitsEx,CreditsEx,'+
                      ' TRUNCATE((DebitsEx)-(CreditsEx),4) AS Amount '+
                      ' FROM tbltransactionsummarydetails   as Trans '+
                      ' WHERE Trans.AccountName in (Select Distinct AccountName from  '+fsAccountTablename +')'+
                      ' and Productname = :ProductName '+
                      ' order by  date desc  , Type, PriorToclosingDt';

  inherited;
  Self.WindowState := wsMaximized;
  AddCalccolumn('Calctotalcost' , True);
  AddCalccolumn('StockValue' , True);
  AddCalccolumn('Balamount' , True);
  AddCalccolumn('DiffAmount' , True);

  grdcosts.TitleColor         := Self.Color;grdcosts.FooterColor        := Self.Color;
  grdAccounts.TitleColor      := Self.Color;grdAccounts.FooterColor     := Self.Color;
  grdBalancesheet.TitleColor := Self.Color; grdBalancesheet.FooterColor := Self.Color;

end;
procedure TInventoryAssetListGUI.FormResize(Sender: TObject);
begin
  inherited;
  RealignTabControl(pgMain, 1);
end;

procedure TInventoryAssetListGUI.FormShow(Sender: TObject);
begin
  inherited;
  RealignTabControl(pgMain, 1);
  pgmain.ActivePage := TabBalancesheet;
end;

function TInventoryAssetListGUI.ProductAssetValue(ProductQry, inTRansQry, StockcostHistoryQry :TERPQuery ):Double;
(*var
  RunningQty, BuyQty , BuyPrice ,LandedCostsPerItem, AssetValue:Double;*)
  (*Procedure MakeCostHistoryRec(Qty, linecost:Double);
  begin
    if StockcostHistoryQry = nil then exit;
    if StockcostHistoryQry.Active=False then StockcostHistoryQry.Open;
      StockcostHistoryQry.Append;
      StockcostHistoryQry.fieldbyname('PartsId').AsInteger  := ProductQry.fieldbyname('PartsId').AsInteger;
      StockcostHistoryQry.fieldbyname('Date').AsDateTime    := inTRansQry.fieldbyname('transDate').AsDateTime;
      StockcostHistoryQry.fieldbyname('type').AsString      := inTRansQry.fieldbyname('transtype').AsString;
      StockcostHistoryQry.fieldbyname('TransId').AsInteger  := inTRansQry.fieldbyname('TransID').AsInteger;
      StockcostHistoryQry.fieldbyname('TransQty').AsFloat   := inTRansQry.fieldbyname('Qty').AsFloat;
      StockcostHistoryQry.fieldbyname('Qty').AsFloat        := Qty;
      StockcostHistoryQry.fieldbyname('cost').AsFloat       := LineCost;
      StockcostHistoryQry.fieldbyname('totalcost').AsFloat  := Qty*LineCost;
      PostDB(StockcostHistoryQry);
  end;*)
begin
  Result := 0;
    if  (ProductQry.RecordCount =0) or (ProductQry.FieldByName('PartsID').AsInteger =0)   then exit;

      if inTRansQry.fieldbyname('ProductID').AsInteger <> ProductQry.FieldByName('PartsID').AsInteger then
        inTRansQry.Locate('ProductID' ,ProductQry.FieldByName('PartsID').AsInteger , []);
        if inTRansQry.fieldbyname('ProductID').AsInteger  = ProductQry.FieldByName('PartsID').AsInteger then
        result := inTRansQry.fieldbyname('cost').asfloat;


(*
    inTRansQry.First;
    RunningQty := ProductQry.FieldByName('instock').AsFloat;
    AssetValue := 0;
    try
      if RunningQty =0 then exit;
      if inTRansQry.fieldbyname('ProductID').AsInteger <> ProductQry.FieldByName('PartsID').AsInteger then
        inTRansQry.Locate('ProductID' ,ProductQry.FieldByName('PartsID').AsInteger , []);

      if RunningQty <0 then begin
        if inTRansQry.fieldbyname('ProductID').AsInteger = ProductQry.FieldByName('PartsID').AsInteger then begin
            BuyPrice  := inTRansQry.FieldByName('actuallinecost').asFloat;
            if Appenv.CompanyPrefs.IncludeLandedCostsinAvgCost then begin
              LandedCostsPerItem := inTRansQry.FieldByName('LandedCostsPerItem').AsFloat;
            end else begin
              LandedCostsPerItem := 0;
            end;
            MakeCostHistoryRec(RunningQty , BuyPrice + LandedCostsPerItem);
            AssetValue := RunningQty *( BuyPrice + LandedCostsPerItem);
        end else begin
          MakeCostHistoryRec(RunningQty , 0{ProductQry.fieldbyname('Cost1').asfloat});
          AssetValue := RunningQty *( 0{ProductQry.fieldbyname('Cost1').asfloat});
        end;
        Exit;
      end;

      while (RunningQty > 0) and (not inTRansQry.Eof) and (inTRansQry.fieldbyname('ProductID').AsInteger = ProductQry.FieldByName('PartsID').AsInteger) do begin
            BuyQty    := inTRansQry.FieldByName('Qty').AsFloat;
            BuyPrice  := inTRansQry.FieldByName('actuallinecost').asFloat;
            if Appenv.CompanyPrefs.IncludeLandedCostsinAvgCost then begin
              LandedCostsPerItem := inTRansQry.FieldByName('LandedCostsPerItem').AsFloat;
            end else begin
              LandedCostsPerItem := 0;
            end;

            if (RunningQty > BuyQty) then begin
                MakeCostHistoryRec(BuyQty , BuyPrice + LandedCostsPerItem);
                AssetValue := AssetValue + (BuyQty * (BuyPrice + LandedCostsPerItem));
                RunningQty := RunningQty - BuyQty;
            end else begin
                MakeCostHistoryRec(RunningQty , BuyPrice + LandedCostsPerItem);
                AssetValue := AssetValue + (RunningQty * (BuyPrice + LandedCostsPerItem));
                RunningQty := RunningQty - RunningQty;
            end;
            inTRansQry.Next;
      end;
    finally
      REsult :=  AssetValue;
    end;*)

end;

procedure TInventoryAssetListGUI.RefreshQuery;
begin
    clog('');
    closedb(QryCostDetails);
    closedb(QryAssetAccounts);
    closeDB(QryBalancesheet);
    closedb(Qrymain);
    Populatedata;
    inherited;
    opendb(QryCostsum);
    openDB(QryCostDetails);
    openDB(QryAssetAccounts);
    openDB(QryBalancesheet);
    openDB(QryBalancesheetdetails);
    openDB(QryAssetAccountsDetails);
    //CalcCostHistoryTotal(nil);
    //CalcAccountTotals(nil);
end;

procedure TInventoryAssetListGUI.RefreshTotals;
begin
  try
    inherited;
    CalcnshowFooter;
  finally
(*    lblDifference.caption := 'Difference of Actual Stock Value ('      + floatTostrF(Fieldtotal('Calctotalcost'), ffCurrency,15, CurrencyRoundPlaces) +') and  '+
                             'Stock Value on Avg cost (' + floatTostrF(Fieldtotal('StockValue')   , ffCurrency,15, CurrencyRoundPlaces) +') = ' +
                             floatTostrF(Fieldtotal('Calctotalcost') -Fieldtotal('StockValue')    , ffCurrency,15, CurrencyRoundPlaces);*)
  end;
end;

procedure TInventoryAssetListGUI.SetGridColumns;
begin
  inherited;

end;

procedure TInventoryAssetListGUI.Splitter1CanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  inherited;
  RealignTabControl(pgMain, 1);
end;

procedure TInventoryAssetListGUI.Splitter1Moved(Sender: TObject);
begin
  inherited;
  RealignTabControl(pgMain, 1);
end;

procedure TInventoryAssetListGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Grpfilters.Horizontalsplit'].asInteger:= pgMain.Height;
  GuiPrefs.Node['Grpfilters.verticalsplit1'].asInteger := pnlBalancesheet.width;
  GuiPrefs.Node['Grpfilters.verticalsplit2'].asInteger := grdAccountsDetails.width;
  GuiPrefs.Node['Grpfilters.verticalsplit3'].asInteger := pnlPQA.width;
  GuiPrefs.Node['Grpfilters.verticalsplit4'].asInteger := pnlBSnPQA.width;
  GuiPrefs.Node['Grpfilters.HideProducts'].asBoolean   := chkHideProducts.checked;
end;
procedure TInventoryAssetListGUI.ReadnApplyGuiPrefExtra;
var
  x:Integer;
begin
  inherited;
  x := GuiPrefs.Node['Grpfilters.Horizontalsplit'].asInteger;
  if (x<=0) or (x> Panel1.Height-10) then x:= trunc(Panel1.height/2);
  pgMain.Height := x;



  x := GuiPrefs.Node['Grpfilters.verticalsplit1'].asInteger;
  if (x<=0) or (x> TabBalancesheet.Width-10) then x:= trunc(TabBalancesheet.Width/2);
  pnlBalancesheet.width := x;

  x := GuiPrefs.Node['Grpfilters.verticalsplit2'].asInteger;
  if (x<=0) or (x> TabBalancesheetDetails.Width-10) then x:= trunc(TabBalancesheetDetails.Width/3);
  grdAccountsDetails.width := x;

  x := GuiPrefs.Node['Grpfilters.verticalsplit3'].asInteger;
  if (x<=0) or (x> TabBalancesheetDetails.Width-10) then x:= trunc(TabBalancesheetDetails.Width/3);
  pnlPQA.width := x;

  x := GuiPrefs.Node['Grpfilters.verticalsplit4'].asInteger;
  if (x<=0) or (x> TabProduct.Width-10) then x:= trunc(TabProduct.Width/3);
  pnlBSnPQA.width := x;

  chkHideProducts.checked:= GuiPrefs.Node['Grpfilters.HideProducts'].asBoolean;
  RealignTabControl(pgMain, 1);
end;
  function TInventoryAssetListGUI.InTransSQL(Productname:String = ''):String;
  begin
    (*REsult := 'Select PQa.ProductID, PQa.transdate , PQa.transtype, PQa.transId, PQa.actualtotalcost,  ' +
              ' if(PQa.Alloctype = "IN" , PQA.Qty , 0-PQA.Qty) qty ,   ' +
              ' Round(PQa.actualtotalcost/ if(PQa.Alloctype = "IN" , PQA.Qty , 0-PQA.Qty),'+ inttostr(TcConst.GeneralRoundPlaces) +') as actuallinecost,  ' +
              ' POL.LandedCostsPerItem ' +
              ' from  tbltransactionpqas pqa ' +
              ' Left join tblpurchaselines POL on POL.PurchaseLineID = pqa.TransLineID and pqa.TransType = "TPurchaseOrderLine" ' +
              '   where  ((PQa.Alloctype = "IN" and PQa.qty >0 and PQa.transtype <>"TRefundSaleLine" ) or (PQa.Alloctype = "OUT" and PQa.Qty <0) or (PQa.transtype ="TRefundSaleLine" and PQa.Qty <0)  ) ' +
              ' and PQa.transtype <> "TProcTreePartIN" and ifnull(PQa.StockQty,0) <>0   and PQa.IsSubBOM <> "T" ' ;
              if Productname <> '' then REsult := Result +' and pqa.productname =' + quotedstr(Productname);
              REsult := Result +' order by   ProductId, TransDate desc ,PQAID desc, transId desc, transLineId desc;';*)
    REsult := 'Select PQa.ProductID,pqa.productname , ' +
              ' sum(if(pqa.SoldQty=0, PQa.actualtotalcost , 0))+sum(if(pqa.SoldQty<> 0 and pqa.stockqty-pqa.SoldQty >0, PQa.actualtotalcost/(pqa.stockqty)*(pqa.stockqty-pqa.SoldQty ) , 0)) as cost' +
              ' from  tbltransactionpqas pqa ' +
              ' Left join tblpurchaselines POL on POL.PurchaseLineID = pqa.TransLineID and pqa.TransType = "TPurchaseOrderLine" ' +
              ' where  ((PQa.Alloctype = "IN" and PQa.qty >0 and PQa.transtype <>"TRefundSaleLine" ) or (PQa.Alloctype = "OUT" and PQa.Qty <0) or (PQa.transtype ="TRefundSaleLine" and PQa.Qty <0)  )  '+
              ' and PQa.transtype <> "TProcTreePartIN"   and PQa.transtype <> "TProcTreePartINDONE" and PQa.IsSubBOM <> "T" ' ;
    if Productname <> '' then REsult := Result +' and pqa.productname =' + quotedstr(Productname);
    REsult := Result +' group by ProductID';
  end;

procedure TInventoryAssetListGUI.Populatedata;
var
  QryInTRans, QryProductList, Qrycost :TERPQuery;
  Assetvalue:double;
begin
  With ScriptMain do begin
    SQL.clear;

{1: List of Inventory products}
          SQL.add('truncate  '+fstablename +';');
          SQL.add(' insert into '+fstablename + '( PartsID,ProductName,MultipleBins,batch,SNTracking,LandedCost,ProductTypeCode,FirstColumn,SecondColumn,ThirdColumn,SalesDescription,ASSETACCNT,'+
                                                  'SOBO,Available,instock,SOQty,InvBO,POBO,onbuild,Building,cost1,Price1,WHOLESALEPRICE,PURCHASEDESC,ProductCode,PreferredSupplier,Active,'+
                                                  'SupplierProductCode,Area,AvgCost,IsSystemProduct)'+
                                                  ' SELECT P.PartsID as PartsID, '+
                                                  ' P.PARTNAME as ProductName, '+
                                                  ' P.MultipleBins MultipleBins,'+
                                                  ' P.batch batch,'+
                                                  ' P.SNTracking SNTracking,'+
                                                  ' LandedCost as "LandedCost", '+
                                                  ' P.PARTTYPE as ProductTypeCode, '+
                                                   ProductQtylib.Firstcolumn + ' AS FirstColumn, '+
                                                   ProductQtylib.Secondcolumn+ ' AS SecondColumn, '+
                                                   ProductQtylib.Thirdcolumn + ' AS ThirdColumn, '+
                                                  ' PARTSDESCRIPTION as SalesDescription,'+
                                                  ' P.ASSETACCNT as ASSETACCNT,'+
                                                  ' Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tSOBO)       +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS SOBO,'+
                                                  ' Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tAvailable)  +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS Available,'+
                                                  ' Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tInstock(*tActStockwithMan*))    +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS instock     ,'+
                                                  ' Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tSO)         +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS SOQty ,'+
                                                  ' Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tInvBO)      +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS InvBO ,'+
                                                  ' Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tPOBO)       +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS POBO     ,'+
                                                  ' Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tOnBuild)    +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS onbuild     ,'+
                                                  ' Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tBuilding)   +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+') AS Building     ,'+
                                                  ' COST1 as cost1,'+
                                                  ' PRICE1 as Price1,'+
                                                  ' WHOLESALEPRICE as WHOLESALEPRICE,'+
                                                  ' PURCHASEDESC ,'+
                                                  ' PRODUCTCODE as "ProductCode",'+
                                                  ' PREFEREDSUPP as "PreferredSupplier",'+
                                                  ' P.Active as Active,'+
                                                  ' SupplierProductCode as SupplierProductCode,'+
                                                  ' Area as Area,'+
                                                  ' AvgCost as AvgCost,'+
                                                  ' P.IsSystemProduct as IsSystemProduct'+
                                                  ' FROM ' + ProductTables(tProductList)+
                                                  ' WHERE P.PARTTYPE = "INV"'+
                                                  ' GROUP BY P.PARTSID ;');

          //SQL.add('Alter table ' + fsTablename +' add column Calctotalcost DOUBLE;');
          SQL.add('update ' + fsTablename +' set StockValue = AvgCost* instock;');
          SQL.add('truncate  '+ fsCosttablename+';');

          SQL.Text := ChangeQuery(SQl.Text);
          DoShowProgressbar(SQL.Count , WAITMSG);
          try
            Logtext(SQL.Text);
            execute;
          finally
            DoHideProgressbar;
          end;
        end;
{2: calculate the actual totalcost for the product's instock from the Last IN transactions}
      QryInTRans      := Tempmyquery;
      QryProductList  := Tempmyquery;
      Qrycost         := Tempmyquery;

      QryInTRans.SQL.text     := InTRansSQL;
      QryProductList.SQL.text := 'Select * from '+fstablename +' order by partsId';
      Qrycost.SQL.text := 'Select * from '+fsCosttablename;

      opendb(QryInTRans);
      openDB(QryProductList);
      openDB(Qrycost);
      with Scriptmain do begin
            SQL.clear;
            QryProductList.first;
            QryInTRans.first;
            DoShowProgressbar(QryProductList.Recordcount , WAITMSG);
            try
              While QryProductList.eof = False do begin
                Assetvalue := ProductAssetValue(QryProductList, QryInTRans , QryCost );
                SQL.add('update '+fstablename +' set  Calctotalcost = ' + floatTostr( Assetvalue) +' where PartsId = ' +inttostr( QryProductList.fieldbyname('PartsId').asInteger)+';');
                QryProductList.Next;
                DoStepProgressbar(QryProductList.fieldbyname('ProductName').asString);
              end;
            finally
              DoHideProgressbar;
            end;
            if SQL.Count >0 then begin
              DoShowProgressbar(SQL.Count , WAITMSG);
              try
                Logtext(SQL.Text);
                execute;
              finally
                DoHideProgressbar;
              end;
            end;
            SQL.Clear;
      end;


  With ScriptMain do begin
    SQL.clear;

{3: Product's Transaction Value total group by account}
        SQL.add('Truncate  '+fsAccountTablename +';');
        SQl.add('insert into '+ fsAccountTablename +' (AccountName ,Partscount, calctotalcost) '+
                ' Select ASSETACCNT , count(*) ctr , sum(calctotalcost) as calctotalcost   '+
                ' from ' + fsTablename +' T group by ASSETACCNT;');

{4: Balancesheet amount for each product in the Qrymain}
        SQL.add('Drop table if exists  '+fsAccountTablename +'1;');
        SQL.add('Create table   '+fsAccountTablename +'1 '+
                'Select ProductName, Sum(Amount) amount from (SELECT  Productname, TRUNCATE(Sum(DebitsEx)-Sum(CreditsEx),4) AS Amount '+
                            'FROM tbltransactions   as Trans '+
                            'WHERE Trans.AccountName in (Select Distinct AccountName from  ' +fsAccountTablename +') '+
                            'Group By ProductName '+
                            'union all '+
                            'SELECT  Productname, TRUNCATE(Sum(DebitsEx)-Sum(CreditsEx),4) AS Amount '+
                            'FROM tbltransactionsummarydetails  as Trans '+
                            'WHERE Trans.AccountName in (Select Distinct AccountName from  ' +fsAccountTablename +') '+
                            'Group By ProductName) TransSummary group by productname ;');
        SQL.add('Alter table  '+fsAccountTablename +'1 add index productname (ProductName);');
        SQL.add('update '+fstablename +' T inner join '+ fsAccountTablename +'1 T1 on T.productname = T1.productname Set T.Balamount = T1.amount;');
        SQL.add('update '+fstablename +' Set DiffAmount = Balamount -CalcTotalcost;');


{5: Product's account summary from balancesheet}
        SQL.add('Drop table if exists  '+fsAccountTablename +'1;');
        SQL.add('CREATE TABLE  '+fsAccountTablename +'1 ('+
                          ' ID              int(11) NOT NULL AUTO_INCREMENT,'+
                          ' AccountName     varchar(100)  DEFAULT NULL,'+
                          ' type     varchar(100)  DEFAULT NULL,'+
                          ' Amount          double        DEFAULT NULL,'+
                          ' PRIMARY KEY (ID),'+
                          ' KEY AccountName (AccountName)'+
                          ' ) ENGINE=MyISAM ; ');

        SQL.add('insert into '+fsAccountTablename +'1 (AccountName, type , Amount) '+
                          ' SELECT '+
                          ' Trans.accountName, '+
                          ' Trans.Type, '+
                          ' Sum(DebitsEx)-Sum(CreditsEx) AS Amount '+
                          ' FROM tbltransactions  as Trans '+
                          ' WHERE Trans.AccountName in (Select Distinct AccountName from  '+fsAccountTablename +')'+
                          ' AND type <> "Closing Date Summary" '+
                          ' Group By type, Accountname, Trans.AccountType; ');
        SQL.add('update ' + fsAccountTablename +' T  Set T.BalanceSheetamt1 = (select ifnull(sum(ifnull(T1.Amount,0)),0) from ' + fsAccountTablename +'1 as T1 where T.accountname = T1.accountname );');
        SQL.add('update ' + fsAccountTablename +' T  Set T.BalanceSheetamtexJE1 = (select ifnull(sum(ifnull(T1.Amount,0)),0) from ' + fsAccountTablename +'1 as T1 where T.accountname = T1.accountname and Type <> "Journal Entry" );');

        SQL.add('truncate '+fsAccountTablename +'1;');
        SQL.add('insert into '+fsAccountTablename +'1 (AccountName, type , Amount) '+
                          ' SELECT '+
                          ' Trans.Accountname, '+
                          ' Trans.Type, '+
                          ' Sum(DebitsEx)-Sum(CreditsEx) AS Amount '+
                          ' FROM tbltransactionsummarydetails  as Trans '+
                          ' WHERE Trans.AccountName in (Select Distinct AccountName from  '+fsAccountTablename +')'+
                          ' Group By type, Accountname, Trans.AccountType ;');
        SQL.add('update ' + fsAccountTablename +' T  Set T.BalanceSheetamt2 = (select ifnull(sum(ifnull(T1.Amount,0)),0) from ' + fsAccountTablename +'1 as T1 where T.accountname = T1.accountname );');
        SQL.add('update ' + fsAccountTablename +' T  Set T.BalanceSheetamtexJE2 = (select ifnull(sum(ifnull(T1.Amount,0)),0) from ' + fsAccountTablename +'1 as T1 where T.accountname = T1.accountname  and Type <> "Journal Entry");');

        SQL.add('update ' + fsAccountTablename +'  Set BalanceSheetamt = ifnull(BalanceSheetamt1,0) + ifnull(BalanceSheetamt2,0);');
        SQL.add('update ' + fsAccountTablename +'  Set BalanceSheetamtexJE = ifnull(BalanceSheetamtexJE1,0) + ifnull(BalanceSheetamtexJE2,0);');
        SQL.add('update ' + fsAccountTablename +'  Set Difference = BalanceSheetamt- calctotalcost;');
        SQL.add('update ' + fsAccountTablename +'  Set DifferenceexJE = BalanceSheetamtExJE- calctotalcost;');
        SQL.add('Drop table if exists  '+fsAccountTablename +'1;');
    Logtext(SQL.Text);
    execute;
  end;
end;
procedure TInventoryAssetListGUI.CalcCostHistoryTotal(DataSet: TDataSet);
begin
  inherited;
  grdcosts.ColumnByName('totalcost').FooterValue := FloatToStrF(QryCostsum.fieldbyname('totalcost').AsFloat, ffCurrency, 15, CurrencyRoundPlaces);
end;
procedure TInventoryAssetListGUI.CalcFooter;
begin
  inherited;

end;

procedure TInventoryAssetListGUI.DoCalcFooter(Dataset: TDataset; grid: TwwDBGrid;  fieldnames: String);
var
  st:TStringlist;
  totals:Array of double;
  ctr:Integer;
begin
  //if dataset.recordcount =0 then exit;

  if not(dgshowfooter in grid.Options) then grid.Options := grid.Options + [dgshowfooter];
  st:= TStringlist.create;
  try
    st.commatext := fieldnames;
    if st.count =0 then exit;
    setlength(totals, st.count);
    for ctr:= 0 to st.count-1 do totals[ctr]:=0;
    if Dataset.Recordcount >0 then begin
      Dataset.first;
      while Dataset.eof = False do begin
        for ctr:= 0 to st.count-1 do
          totals[ctr] := totals[ctr] +dataset.fieldbyname(st[ctr]).asFloat;
        Dataset.next;
      end;
    end;
    for ctr:= 0 to st.count-1 do begin
      grid.columnbyname(st[ctr]).footerValue := FloatToStrF(totals[ctr], ffcurrency, 15,2);
      if grid =grdAccountsDetails then
        if sametext(St[ctr] , 'amount') then
          ccountsDetailsTotalAmount :=totals[ctr];
    end;
  finally
    Freeandnil(st);
  end;

end;

Procedure TInventoryAssetListGUI.PopulateProductBalansesheet;
var
  st:Tstringlist;
begin
  DoShowProgressbar(5 , WAITMSG);
  try
    DoStepProgressbar('Summary of Balancesheet');
    TabBalancesheetDetails.caption := 'Balance Sheet Entries for the Product :' +quotedstr(Qrymainproductname.asString);
    closeDB(QryAssetAccountsDetails);
    QryAssetAccountsDetails.parambyname('Productname').asString := Qrymainproductname.asString;
    opendb(QryAssetAccountsDetails);
    DoStepProgressbar('Details of BalanceSheet');

    closeDB(QryBalancesheetDetails);
    QryBalancesheetDetails.parambyname('Productname').asString := Qrymainproductname.asString;
    QryBalancesheetDetails.masterSource:= dsAssetAccountsDetails;
    QryBalancesheetDetails.masterfields := 'Type;accountName';
    QryBalancesheetDetails.detailfields := 'Type;accountName';
    opendb(QryBalancesheetDetails);
    DoStepProgressbar('Details of PQA');

    Closedb(QryPQa);
    QryPQa.parambyname('Productname').asString := Qrymainproductname.asString;
    OpenDB(QryPQa);

    closedb(QryBSnPQA);
    DoStepProgressbar('PQA n Balance Sheet Comparison');
    st := TStringlist.create;
    try
        with TTransactionTableObj.Create do try
          InvAssetPostings(st ,fsTransactionInvAsset,Qrymainproductname.asString);
        finally
          Free;
        end;
      With ScriptMain do begin
        SQL.clear;
        SQL.add('Truncate ' + fsTransactionInvAsset+';');
        SQL.add(st.text);
        Logtext(Sql.text);
        Execute;
      end;
    finally
      Freeandnil(st);
    end;
    opendb(QryBSnPQA);

    TabBalancesheetDetails.TabVisible:= TRue;
    pgmain.ActivePage := TabBalancesheetDetails;
    SetControlFocus(grdAccountsDetails);
    RealignTabControl(pgMain, 1);
    pnlBSnPQA.visible := True;
  finally
    DohideProgressbar;
  end;
  (*With Scriptmain do begin
    SQL.clear;
    SQL.add('Truncate  '+fsAccountTablenameDetails +';');
    SQl.add('insert into '+ fsAccountTablenameDetails +' (AccountName ,ProductName,type, calctotalcost) '+
            ' Select ASSETACCNT , ProductName ,type,  sum(calctotalcost) as calctotalcost   '+
            ' from ' + fsTablename +' T where ProductName = ' + quotedstr(Qrymainproductname.AsString) +' group by ASSETACCNT,  type;');

    SQL.add('Drop table if exists   '+fsAccountTablename +'1 ;');

    SQL.add('CREATE TABLE   '+fsAccountTablename +'1  ('+
                      ' ID              int(11) NOT NULL AUTO_INCREMENT,'+
                      ' AccountName     varchar(100)  DEFAULT NULL,'+
                      ' ProductName     varchar(100)  DEFAULT NULL,'+
                      ' type     varchar(100)  DEFAULT NULL,'+
                      ' Amount          double        DEFAULT NULL,'+
                      ' PRIMARY KEY (ID),'+
                      ' KEY AccountName (AccountName)'+
                      ' ) ENGINE=MyISAM ; ');

    SQL.add('insert into  '+fsAccountTablename +'1  (AccountName, ProductName, type , Amount) '+
                      ' SELECT '+
                      ' Trans.accountName, '+
                      ' Trans.ProductName, '+
                      ' Trans.Type, '+
                      ' Sum(DebitsEx)-Sum(CreditsEx) AS Amount '+
                      ' FROM tbltransactions  as Trans '+
                      ' WHERE TRans.productname = '+Quotedstr(Qrymainproductname.AsString)+' and Trans.AccountName in (Select Distinct AccountName from  '+fsAccountTablename +')'+
                      ' AND type <> "Closing Date Summary" '+
                      ' Group By type, Accountname, ProductName, Trans.AccountType; ');
    SQL.add('update ' + fsAccountTablenameDetails +' T  Set T.BalanceSheetamt1     = (select ifnull(sum(ifnull(T1.Amount,0)),0) from  '+fsAccountTablename +'1  as T1 where T.accountname = T1.accountname and T.type = T1.type);');
    SQL.add('update ' + fsAccountTablenameDetails +' T  Set T.BalanceSheetamtexJE1 = (select ifnull(sum(ifnull(T1.Amount,0)),0) from  '+fsAccountTablename +'1  as T1 where T.accountname = T1.accountname and T.type = T1.type and Type <> "Journal Entry" );');

    SQL.add('truncate  '+fsAccountTablename +'1 ;');
    SQL.add('insert into  '+fsAccountTablename +'1  (AccountName, ProductName, type , Amount) '+
                      ' SELECT '+
                      ' Trans.accountName, '+
                      ' Trans.ProductName, '+
                      ' Trans.Type, '+
                      ' Sum(DebitsEx)-Sum(CreditsEx) AS Amount '+
                      ' FROM tbltransactionsummarydetails  as Trans '+
                      ' WHERE TRans.productname = '+Quotedstr(Qrymainproductname.AsString)+' and Trans.AccountName in (Select Distinct AccountName from  '+fsAccountTablename +')'+
                      ' AND type <> "Closing Date Summary" '+
                      ' Group By type, Accountname, ProductName, Trans.AccountType; ');
    SQL.add('update ' + fsAccountTablenameDetails +' T  Set T.BalanceSheetamt2     = (select ifnull(sum(ifnull(T1.Amount,0)),0) from  '+fsAccountTablename +'1  as T1 where T.accountname = T1.accountname and T.type = T1.type);');
    SQL.add('update ' + fsAccountTablenameDetails +' T  Set T.BalanceSheetamtexJE2 = (select ifnull(sum(ifnull(T1.Amount,0)),0) from  '+fsAccountTablename +'1  as T1 where T.accountname = T1.accountname and T.type = T1.type  and Type <> "Journal Entry" );');

    SQL.add('update ' + fsAccountTablenameDetails +'  Set BalanceSheetamt = ifnull(BalanceSheetamt1,0) + ifnull(BalanceSheetamt2,0);');
    SQL.add('update ' + fsAccountTablenameDetails +'  Set BalanceSheetamtexJE = ifnull(BalanceSheetamtexJE1,0) + ifnull(BalanceSheetamtexJE2,0);');
    SQL.add('update ' + fsAccountTablenameDetails +'  Set Difference = BalanceSheetamt- calctotalcost;');
    SQL.add('update ' + fsAccountTablenameDetails +'  Set DifferenceexJE = BalanceSheetamtExJE- calctotalcost;');
    SQL.add('Drop table if exists   '+fsAccountTablename +'1 ;');
    DoShowProgressbar(Sql.Count, WAITMSG);
    try
      execute;
    finally
      DoHideProgressbar;
    end;
    Closedb(QryAssetAccountsDetails);    opendb(QryAssetAccountsDetails);
    Closedb(QryBalancesheetDetails);     opendb(QryBalancesheetDetails);
    TabBalancesheetDetails.TabVisible:= TRue;
    pgmain.ActivePage := TabBalancesheet;
    SetControlFocus(grdAccountsDetails);
    RealignTabControl(pgMain, 1);
  end;*)
end;
procedure TInventoryAssetListGUI.btndiffClick(Sender: TObject);
begin
  inherited;
(*  if qrymain.recordcount =0 then exit;
  grdmain.SetActiveField('Productname');
  if Qrymain.eof then qrymain.first;
  While Qrymain.eof = false do begin
    grdMainDblClick(grdmain);
    if not Samevalue(qrymaincalctotalcost.asfloat , ccountsDetailsTotalAmount ,0.001) then break;
    qrymain.Next;
  end;*)
end;

procedure TInventoryAssetListGUI.CalcAccountTotals(DataSet: TDataSet);
var
  Qry:TERPQuery;
begin
  inherited;
    Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
    try
    with Qry do begin
      SQL.Text := 'Select sum(calctotalcost) as calctotalcost from ' + fsTablename ;
      open;
      grdAccounts.ColumnByName('calctotalcost').FooterValue := FloatToStrF(fieldbyname('calctotalcost').AsFloat, ffCurrency, 15, CurrencyRoundPlaces);
      if active then close;
      SQL.clear;
      SQL.text := 'Select sum(Balancesheetamt) as Balancesheetamt , '+
                      ' sum(Balancesheetamt1) as Balancesheetamt1 ,'+
                      ' sum(Balancesheetamt2) as Balancesheetamt2, '+
                      ' sum(BalanceSheetamtexJE) as BalanceSheetamtexJE , '+
                      ' sum(BalanceSheetamtexJE1) as BalanceSheetamtexJE1 ,'+
                      ' sum(BalanceSheetamtexJE2) as BalanceSheetamtexJE2 '+
                      ' from ' + fsaccountTablename ;
      Open;
      grdAccounts.ColumnByName('Balancesheetamt').FooterValue  := FloatToStrF(fieldbyname('Balancesheetamt').AsFloat , ffCurrency, 15, CurrencyRoundPlaces);
      grdAccounts.ColumnByName('Balancesheetamt1').FooterValue := FloatToStrF(fieldbyname('Balancesheetamt1').AsFloat, ffCurrency, 15, CurrencyRoundPlaces);
      grdAccounts.ColumnByName('Balancesheetamt2').FooterValue := FloatToStrF(fieldbyname('Balancesheetamt2').AsFloat, ffCurrency, 15, CurrencyRoundPlaces);
      grdAccounts.ColumnByName('BalanceSheetamtexJE').FooterValue  := FloatToStrF(fieldbyname('BalanceSheetamtexJE').AsFloat , ffCurrency, 15, CurrencyRoundPlaces);
      grdAccounts.ColumnByName('BalanceSheetamtexJE1').FooterValue := FloatToStrF(fieldbyname('BalanceSheetamtexJE1').AsFloat, ffCurrency, 15, CurrencyRoundPlaces);
      grdAccounts.ColumnByName('BalanceSheetamtexJE2').FooterValue := FloatToStrF(fieldbyname('BalanceSheetamtexJE2').AsFloat, ffCurrency, 15, CurrencyRoundPlaces);
    end;
    finally
      DbSharedObj.ReleaseObj(Qry);
    end;
end;
procedure TInventoryAssetListGUI.CalcBalancesheetTotal(DataSet: TDataSet);
var
  fdAmount:Double;
begin
  inherited;
  lblBalancesheet.caption := 'Detail posting of account : ' +Quotedstr(QryAssetAccountsAccountName.asString);
  lblBalancesheet.Refresh;

  fdAmount:=0;
  try
    if QryBalancesheet.recordcount =0 then exit;
    QryBalancesheet.disablecontrols;
    try
      DoShowProgressbar(QryBalancesheet.Recordcount , WAITMSG);
      try
        QryBalancesheet.first;
        while QryBalancesheet.Eof = False do begin
          fdAmount := fdAmount + QryBalancesheetAmount.asfloat;
          QryBalancesheet.Next;
          DoStepProgressbar(QryBalancesheetAccountname.asString);
        end;
      finally
        DoHideProgressbar;
      end;
    finally
      QryBalancesheet.enablecontrols;
    end;
  finally
    grdBalancesheet.ColumnByName('Amount').FooterValue := FloatToStrF(fdAmount, ffCurrency, 15, CurrencyRoundPlaces);
  end;
end;
procedure TInventoryAssetListGUI.grdMainCalcCellColors        (Sender: TObject;  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;  ABrush: TBrush);begin  Grdcolours(Sender, field.FieldName ,  Afont, ABrush);end;
procedure TInventoryAssetListGUI.grdAccountsCalcCellColors    (Sender: TObject;  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;  ABrush: TBrush);begin  Grdcolours(Sender, field.FieldName ,  Afont, ABrush);end;
procedure TInventoryAssetListGUI.grdBalancesheetCalcCellColors(Sender: TObject;  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;  ABrush: TBrush);begin  Grdcolours(Sender, field.FieldName ,  Afont, ABrush);end;
procedure TInventoryAssetListGUI.grdcostsCalcCellColors       (Sender: TObject;  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;  ABrush: TBrush);begin  Grdcolours(Sender, field.FieldName ,  Afont, ABrush);end;
procedure TInventoryAssetListGUI.grdcostsCalcTitleAttributes        (Sender: TObject;  AFieldName: string; AFont: TFont; ABrush: TBrush;  var ATitleAlignment: TAlignment);begin  Grdcolours(Sender, AFieldName ,  Afont, ABrush);end;
procedure TInventoryAssetListGUI.grdMainCalcTitleAttributes         (Sender: TObject;  AFieldName: string; AFont: TFont; ABrush: TBrush;  var ATitleAlignment: TAlignment);begin  Grdcolours(Sender, AFieldName ,  Afont, ABrush);end;
procedure TInventoryAssetListGUI.grdMainDblClick(Sender: TObject);
var
  Assetvalue:Double;
  QryInTRans:TERpQuery;
begin
  if SameText(Activefieldname , Qrymainproductname.FieldName) then begin
    ProcessingCursor(true);
    try
      PopulateProductBalansesheet;
      Exit;
    finally
      ProcessingCursor(False);
    end;
  end else if SameText(Activefieldname , Qrymaincalctotalcost.FieldName) then begin
    QryInTRans := TempMyQuery;
    try
      QryInTRans.SQL.Text := IntransSQL(Qrymainproductname.asString);
      opendb(QryInTRans);
      //Assetvalue := ProductAssetValue(Qrymain, QryInTRans , nil );
      Assetvalue :=QryInTRans.fieldbyname('cost').asfloat;
      Logtext(FloatToStr(AssetValue));
      Exit;
    finally
      QryInTRans.ClosenFree;
    end;
  end;
  inherited;
end;

procedure TInventoryAssetListGUI.grdAccountsCalcTitleAttributes     (Sender: TObject;  AFieldName: string; AFont: TFont; ABrush: TBrush;  var ATitleAlignment: TAlignment);begin  Grdcolours(Sender, AFieldName ,  Afont, ABrush);end;
procedure TInventoryAssetListGUI.grdBalancesheetCalcTitleAttributes (Sender: TObject;  AFieldName: string; AFont: TFont; ABrush: TBrush;  var ATitleAlignment: TAlignment);begin  Grdcolours(Sender, AFieldName ,  Afont, ABrush);end;

Procedure TInventoryAssetListGUI.Grdcolours(Sender:TObject;Afieldname:String; AFont: TFont; ABrush: TBrush);
begin
    if Sender = grdcosts then
      if sameText(AFieldName, QryCostDetailscost.fieldname) or sameText(AFieldName, QryCostDetailstotalcost.fieldname)  or sameText(AFieldName, QryCostDetailsTransQty.fieldname) then Abrush.color := $00C6FFFF;

    if (sender = grdbalancesheet) or (sender = grdbalancesheetdetails) then
      if sameText(AFieldName, QryBalancesheetAmount.fieldname) or sameText(AFieldName, QryBalancesheetType.fieldname)  then Abrush.color := $00CEFF9D;

    if sender = grdmain then
      if sameText(AFieldName, qrymaininstock.fieldname) or sameText(AFieldName, qryMainCalctotalcost.fieldname)  then Abrush.color := $00C6FFFF
      else if sameText(AFieldName, qrymainDiffAmount.fieldname)  then AFont.color := clMaroon;

    if (sender = grdAccounts) or (sender = grdAccountsdetails ) then
           if sameText(AFieldName, QryAssetAccountsPartscount.fieldname)            or sameText(AFieldName, QryAssetAccountscalctotalcost.fieldname)        then Abrush.color := $00C6FFFF
      else if sameText(AFieldName, QryAssetAccountsBalanceSheetamt2.fieldname)      or sameText(AFieldName, QryAssetAccountsBalanceSheetamt1.fieldname)     or sameText(AFieldName, QryAssetAccountsBalanceSheetamt.fieldname)     then Abrush.color := $00CEFF9D
      else if sameText(AFieldName, QryAssetAccountsBalanceSheetamtexJE2.fieldname)  or sameText(AFieldName, QryAssetAccountsBalanceSheetamtexJE1.fieldname) or sameText(AFieldName, QryAssetAccountsBalanceSheetamtexJE.fieldname) then Abrush.color := $00CEFF9D
      else if sameText(AFieldName, QryAssetAccountsDifference.fieldname)            or sameText(AFieldName, QryAssetAccountsDifferenceexJE.fieldname)       then AFont.color :=clRed;
end;

procedure TInventoryAssetListGUI.QryCostDetailsAfterOpen          (DataSet: TDataSet);begin  inherited;  QryCostDetailsDate.DisplayFormat := FormatSettings.Shortdateformat;  CalcCostHistoryTotal(nil);  Gridfields(dataset);end;
procedure TInventoryAssetListGUI.qryMainAfterScroll(DataSet: TDataSet);
begin
  inherited;
  CalcCostHistoryTotal(dataset);
  //PopulateProductBalansesheet;
  try
    TabBalancesheetDetails.TabVisible:= False;
    RealignTabControl(pgMain, 1);
    pnlBSnPQA.visible := False;
  Except
    Setcontrolfocus(grdmain);
    TabBalancesheetDetails.TabVisible:= False;
    pnlBSnPQA.visible := False;
  end;
end;

procedure TInventoryAssetListGUI.QryBalancesheetDetailsAfterOpen  (DataSet: TDataSet);begin  inherited;  CalcBalancesheetTotal(dataset);  Gridfields(dataset);  QryBalancesheetDetailsSeqno.visible := DevMode;DoCalcFooter(Dataset ,grdBalancesheetDetails,  'amount,creditsEx,debitsEx'); end;
procedure TInventoryAssetListGUI.QryBalancesheetAfterOpen         (DataSet: TDataSet);begin  inherited;  CalcBalancesheetTotal(Dataset);  Gridfields(dataset); end;
procedure TInventoryAssetListGUI.QryAssetAccountsAfterOpen        (DataSet: TDataSet);begin  inherited;  Gridfields(dataset);end;
procedure TInventoryAssetListGUI.QryAssetAccountsDetailsAfterOpen (DataSet: TDataSet);begin  inherited;  Gridfields(dataset);DoCalcFooter(Dataset ,grdAccountsDetails,  'amount');end;
procedure TInventoryAssetListGUI.QryPQaAfterOpen                  (DataSet: TDataSet);begin  inherited;  Gridfields(dataset);DoCalcFooter(Dataset ,grdPQA,  'actualTotalCost,Actualtotalcostinc')end;
procedure TInventoryAssetListGUI.QryBSnPQAAfterOpen               (DataSet: TDataSet);begin  inherited;  Gridfields(dataset);end;


procedure TInventoryAssetListGUI.Gridfields(dataset:TDataset);
begin
  FieldList := TStringList.Create;
  try
    if dataset = grdAccounts.DataSource.DataSet then begin
      fieldList.Clear;
      AddGridSelectedfield('AccountName'          ,15 , 'Account'  , '' , dataset);
      AddGridSelectedfield('Partscount'           ,15 , 'No of Products'  , '' , dataset);
      AddGridSelectedfield('calctotalcost'        ,20 , 'Total amount'  , '' , dataset);
      AddGridSelectedfield('BalanceSheetamt2'     ,15 , LockMsgClosingDate , 'Balance Sheet Amount'  , dataset);
      AddGridSelectedfield('BalanceSheetamt1'     ,15 , 'After Closing Date'  , 'Balance Sheet Amount'  , dataset);
      AddGridSelectedfield('BalanceSheetamt'      ,20 , 'Total'               , 'Balance Sheet Amount' , dataset);
      AddGridSelectedfield('BalanceSheetamtexJE2' ,15 , LockMsgClosingDate , 'Balance Sheet Amount(Ex Journal Entry)' , dataset);
      AddGridSelectedfield('BalanceSheetamtexJE1' ,15 , 'After Closing Date'  , 'Balance Sheet Amount(Ex Journal Entry)' , dataset);
      AddGridSelectedfield('BalanceSheetamtexJE'  ,20 , 'Total'               , 'Balance Sheet Amount(Ex Journal Entry)' , dataset);
      AddGridSelectedfield('Difference'           ,15 , 'Inc JE'              , 'Difference' , dataset);
      AddGridSelectedfield('DifferenceexJE'       ,15 , 'Ex JE'               , 'Difference' , dataset);
      grdAccounts.Selected.Text := fieldList.Text;
      grdAccounts.ApplySelected;
    end;
    if dataset = grdAccountsDetails.DataSource.DataSet then begin
      fieldList.Clear;
      AddGridSelectedfield('AccountName'          ,15 , 'Account'               , '' , dataset);
      AddGridSelectedfield('PriorToclosingDt'     ,10 , 'Prior To~Closing Date?', '' , dataset);
      AddGridSelectedfield('Type'             ,15 , 'Type', '' , dataset);
      AddGridSelectedfield('Amount'           ,20 , 'Amount', '' , dataset);
      grdAccountsDetails.Selected.Text := fieldList.Text;
      grdAccountsDetails.ApplySelected;
    end;

    if dataset = grdBalancesheet.DataSource.DataSet then begin
      fieldList.Clear;
      AddGridSelectedfield('PriorToclosingDt' ,1 , 'Prior To~Closing Date?', '' , dataset);
      AddGridSelectedfield('Type'             ,15 , 'Type', '' , dataset);
      AddGridSelectedfield('Amount'           ,20 , 'Amount', '' , dataset);
      grdBalancesheet.Selected.Text := fieldList.Text;
      grdBalancesheet.ApplySelected;
    end;

    if dataset = grdBalancesheetDetails.DataSource.DataSet then begin
      fieldList.Clear;
      if devmode then
        AddGridSelectedfield('Seqno'          ,1  , 'Seqno'     , '' , dataset);
      AddGridSelectedfield('Date'             ,10 , 'Date'      , '' , dataset);
      AddGridSelectedfield('ProductName'      ,10 , 'Product'   , '' , dataset);
      AddGridSelectedfield('AccountName'      ,15 , 'Account'   , '' , dataset);
      AddGridSelectedfield('Type'             ,10 , 'Type'      , '' , dataset);
      AddGridSelectedfield('Amount'           ,14 , 'Amount'    , '' , dataset);
      AddGridSelectedfield('DebitsEx'         ,12 , 'DebitsEx'  , '' , dataset);
      AddGridSelectedfield('CreditsEx'        ,12 , 'CreditsEx' , '' , dataset);
      AddGridSelectedfield('PurchaseOrderId'  ,11 , 'PO#'       , '' , dataset);
      AddGridSelectedfield('saleId'           ,11 , 'Sale#'     , '' , dataset);
      AddGridSelectedfield('PriorToclosingDt' ,10 , 'Prior To~Closing Date?', '' , dataset);
      grdBalancesheetDetails.Selected.Text := fieldList.Text;
      grdBalancesheetDetails.ApplySelected;
    end;


    if dataset = grdcosts.DataSource.DataSet then begin
      fieldList.Clear;
      AddGridSelectedfield('TransId'    , 1 , 'Trans#', '' , dataset);
      AddGridSelectedfield('Date'       , 10, 'Date', '' , dataset);
      AddGridSelectedfield('Description', 15, 'Type', '' , dataset);
      AddGridSelectedfield('TransQty'   , 10, 'Trans Qty', '' , dataset);
      AddGridSelectedfield('Qty'        , 10, 'Qty', '' , dataset);
      AddGridSelectedfield('cost'       , 10, 'Trans Cost', '' , dataset);
      AddGridSelectedfield('totalcost'  , 16, 'Total Cost For Qty', '' , dataset);
      grdcosts.Selected.Text := fieldList.Text;
      grdcosts.ApplySelected;
    end;
    if dataset = grdPQa.datasource.dataset then begin
      fieldList.Clear;
      AddGridSelectedfield('description'        , 20 , 'Type', '' , dataset);
      AddGridSelectedfield('TransID'            , 15 , 'ID', '' , dataset);
      AddGridSelectedfield('transdate'          , 12 , 'Date', '' , dataset);
      AddGridSelectedfield('qty'                , 12 , 'Quantity', '' , dataset);
      AddGridSelectedfield('Actualtotalcost'    , 12 , 'Cost (Ex)', '' , dataset);
      AddGridSelectedfield('Actualtotalcostinc' , 14 , 'Cost (Inc)', '' , dataset);
      grdPQa.ApplySelected;
    end;
    if dataset = grdBSnPQa.datasource.dataset then begin
      fieldList.Clear;
      AddGridSelectedfield('Type'             ,10 , 'Type'      , '' , dataset);
      AddGridSelectedfield('AccountName'      ,15 , 'Account'   , '' , dataset);
      AddGridSelectedfield('PurchaseOrderId'  ,11 , 'PO#'       , '' , dataset);
      AddGridSelectedfield('saleId'           ,11 , 'Sale#'     , '' , dataset);
      AddGridSelectedfield('DebitsEx'         ,12 , 'Debits'  , 'Transaction Table' , dataset);
      AddGridSelectedfield('CreditsEx'        ,12 , 'Credits' , 'Transaction Table' , dataset);
      AddGridSelectedfield('aDebitsEx'        ,12 , 'Debits'  , 'With COGS' , dataset);
      AddGridSelectedfield('aCreditsEx'       ,12 , 'Credits' , 'With COGS' , dataset);
      AddGridSelectedfield('Actualtotalcost'  ,12 , 'Actual~Cost (Ex)', '' , dataset);
      AddGridSelectedfield('SeqNo'            ,10 , 'Seq No', '' , dataset);
      grdBSnPQa.ApplySelected;
    end;

  finally
    Freeandnil(FieldList);
  end;
end;

procedure TInventoryAssetListGUI.grpFiltersClick(Sender: TObject);
begin
  groupfilterString:= '';
  if grpfilters.ItemIndex = 1 then
    groupfilterString := 'DiffAmount>1  or DiffAmount <-1';
    //groupfilterString := 'Balamount <> Calctotalcost';
  inherited;

end;

initialization
  RegisterClass(TInventoryAssetListGUI);

end.
