unit ImportCostForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,  StdCtrls,
  DBCtrls, ExtCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, Grids, Wwdbigrd, Wwdbgrid,
  DBClient, kbmMemTable, Buttons, DNMSpeedButton, DBAccess, MyAccess,ERPdbComponents, DataState, Menus, AdvMenus,
  MemDS, Shader, ImgList, ProgressDialog, contnrs;

type
  TProductCostImport = class
  private
    foOwner: TObject;
    fdPOAmount: Double;
    fProductId: integer;
    fDuty: double;
    ffLandedCosts: double;
    fHandling: double;
    fLineAmount: double;
    fCostsAdded: boolean;
  public

    property ProductId : integer read fProductId write fProductId;
    property ImportCostOwner: TObject read foOwner write foOwner;
    property LandedCost: double read ffLandedCosts write ffLandedCosts;
    Property POAmount :Double read fdPOAmount write fdPOAmount;
    property Duty : double read fDuty write fDuty;
    property Handling : double read fHandling write fHandling;
    property LineAmount : double read fLineAmount write fLineAmount;
    property CostsAdded: boolean read fCostsAdded write fCostsAdded;
  end;

  TPOImportList = class
  private
    fList: TObjectList;
  protected
    property List : TObjectList read fList write fList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(AProduct : TProductCostImport);
    function ImportedProduct(AProductId : integer) : TProductCostImport;
    function CostsExistForProduct(AProductId : integer): boolean;
    function LandedCost(AProductId : integer) : double;
    function TotalLandedCost : double;
    function Amount(AProductId : integer) : double;
    procedure InitCosts;
    procedure Clear;
  end;

  TImportCostGUI = class(TBaseInputGUI)
    pnlHeader: TDNMPanel;
    pnlDetail: TDNMPanel;
    pnlFooter: TDNMPanel;
    pnlCustomer: TPanel;
    qryExpenseCosts: TERPQuery;
    dsExpenseCosts: TDataSource;
    grdCostExpenses: TwwDBGrid;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryExpenseCostsPurchaseLineID: TAutoIncField;
    qryExpenseCostsRelatedPOIDUsed: TWideStringField;
    qryExpenseCostsSupplierName: TWideStringField;
    qryExpenseCostsLineCost: TFloatField;
    qryExpenseCostsLineTax: TFloatField;
    qryExpenseCostsLineCostInc: TFloatField;
    qryExpenseCostsTotalLineAmountInc: TFloatField;
    qryExpenseCostsTotalLineAmount: TFloatField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryExpenseCostsOrderDate: TDateTimeField;
    Label1: TLabel;
    btnBills: TDNMSpeedButton;
    qryExpenseCostsPurchaseOrderID: TIntegerField;
    qryExpenseCostsProduct_description: TWideStringField;
    qryExpenseCostsaccountname: TWideStringField;
    qryExpenseCostsProductId: TIntegerField;
    qryExpenseCostsDuty: TFloatField;
    qryExpenseCostsHandling: TFloatField;
    btnGridDelete: TwwIButton;
    qryExpenseCostsIsBill: TWideStringField;
    qryExpenseCostsIsCheque: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure qryExpenseCostsRelatedPOIDUsedChange(Sender: TField);
    procedure btnBillsClick(Sender: TObject);
    procedure grdCostExpensesDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnGridDeleteClick(Sender: TObject);
  private
    ffLandedCosts: double;
    foOwner: TObject;
    fiClientID: integer;
    fsSupplierName: string;
    fdDuty, fdHandling :Double;
    fiDutysupplier, fiHandlingSupplier :Integer;
    fdPOAmount: Double;
    ChoosenHandlingnDuty :boolean;
    fImports: TPOImportList;
    procedure PerformExpensesCalcTotals;
    procedure ChooseHandlingnDuty(Sender: TwwDBGrid);
    procedure InitHandlingndutyList(Sender: TObject);
    function POProductIds: String;
    procedure LoadProducts;
    function GetLandedCost(ProductId : integer): double;
    function GetTotalLandedCost: double;
    procedure DoAfterShow(Sender: TObject);
    procedure DoBeforeShow(Sender: TObject);
    procedure OpenExpenseForm;
  protected
  public
    procedure UpdateMe; overload; override;
    procedure UpdateMe(const Cancelled: boolean; const aObject: TObject = nil); override;
    property Products : TPOImportList read fImports write fImports;
    property ClientID: integer read fiClientID write fiClientID;
    property SupplierName: string read fsSupplierName write fsSupplierName;
    property ImportCostOwner: TObject read foOwner write foOwner;
//    property LandedCost: double read ffLandedCosts write ffLandedCosts;
    property LandedCost[ProductId : integer] : double read GetLandedCost;
    property TotalLandedCost : double read GetTotalLandedCost;
    Property POAmount :Double read fdPOAmount write fdPOAmount;
  end;


implementation

uses
  DNMExceptions, CommonLib, tcConst, busobjExpenses, busObjBase, AppEnvironment,
  CommonFormLib, tcDataUtils, DbSharedObjectsObj, DutynHandlingList, frmBill,
  frmCheque;

{$R *.dfm}

procedure TImportCostGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      //qryExpenseCosts.Connection := MyConnection;
      qryExpenseCosts.ParamByName('RelatedPOID').asInteger := KeyID;
      OpenQueries;
      LoadProducts;
      pnlCustomer.Caption := fsSupplierName;
      PerformExpensesCalcTotals;
      BeginTransaction;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
end;

function TImportCostGUI.GetLandedCost(ProductId : integer): double;
var
  P :TProductCostImport;
begin
  p := Products.ImportedProduct(ProductId);
//  Result := p.Duty + p.Handling;
  if assigned(p) then
    Result := p.LineAmount
  else
    Result := 0;
end;

function TImportCostGUI.GetTotalLandedCost: double;
begin
//  Result := ffLandedCosts;
  Result := Products.TotalLandedCost;
end;

procedure TImportCostGUI.grdCostExpensesDblClick(Sender: TObject);
begin
  OpenExpenseForm
end;

procedure TImportCostGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseQueries;
  Action := caFree;
end;

procedure TImportCostGUI.FormCreate(Sender: TObject);
begin
  inherited;
  Products := TPoImportList.Create;
  Showcontrolhint( btnBills , 'If Any of the Product(s) on this Purchase Order have Multiple Choices for Duty / Handling per Product,'+NL+
                  'The list of Duty / Handling will be Listed to Choose From.' +NL+
                  'If There is Only 1 Choice for Duty / Handling per product, These will be Selected Automatically' +NL);
end;

procedure TImportCostGUI.FormDestroy(Sender: TObject);
begin
  Products.Free;
  inherited;
end;

procedure TImportCostGUI.PerformExpensesCalcTotals;
var
  dCostEx, dCostInc: double;
  dTax, dTotalLineAmt: double;
  bm:TBookmark;
  p : TProductCostImport;

  procedure InitializeVariables;
  begin
    dCostEx := 0;
    dTax := 0;
    dCostInc := 0;
    dTotalLineAmt := 0;
  end;
begin //==>>PerformExpensesCalcTotals
  InitializeVariables;
  Products.InitCosts; // @@@@@
  with qryExpenseCosts do begin
    bm:= GetBookmark;
    try
    First;
    while not Eof do begin
      if qryExpenseCostsRelatedPOIDUsed.AsBoolean then
      begin
        dCostEx := dCostEx + qryExpenseCostsLineCost.AsCurrency;
        dCostInc := dCostInc + qryExpenseCostsLineCostInc.AsCurrency;
        dTotalLineAmt := dTotalLineAmt + qryExpenseCostsTotalLineAmount.AsCurrency;
        dTax := dTax + qryExpenseCostsLineTax.AsCurrency;
        p := Products.ImportedProduct(qryexpensecostsproductid.asInteger);
        if assigned(p) then
        begin
          p.LineAmount := p.LineAmount + qryExpenseCostsTotalLineAmount.AsCurrency;
        end;
      end;
      Next;
    end;
    finally
      GotoBookmark(bm);
      FreeBookmark(bm);
    end;
  end;
  ffLandedCosts := dTotalLineAmt;
  grdCostExpenses.ColumnByName('LineCost').FooterValue := FloatToStrF(dCostEx, ffCurrency, 15, CurrencyRoundPlaces);
  grdCostExpenses.ColumnByName('LineTax').FooterValue := FloatToStrF(dTax, ffCurrency, 15, CurrencyRoundPlaces);
  grdCostExpenses.ColumnByName('LineCostInc').FooterValue := FloatToStrF(dCostInc, ffCurrency, 15, CurrencyRoundPlaces);
  grdCostExpenses.ColumnByName('TotalLineAmount').FooterValue := FloatToStrF(dTotalLineAmt, ffCurrency, 15, CurrencyRoundPlaces);
end;


procedure TImportCostGUI.btnOKClick(Sender: TObject);
begin
  self.CommitTransaction;
//  try
//    qryExpenseCosts.UpdateBatch(arAll);
//  except
//    on EAbort do HandleEAbortException;
//    else raise;
//  end;
end;
procedure TImportCostGUI.ChooseHandlingnDuty(Sender: TwwDBGrid);
begin
  if not(Sender.Owner is  TDutynHandlingListGUI) then exit;
  fdDuty            := TDutynHandlingListGUI(Sender.owner).SelctedDuty;
  fdHandling        := TDutynHandlingListGUI(Sender.owner).SelctedHandling;
  fiDutysupplier    := TDutynHandlingListGUI(Sender.owner).SelctedDutySupplier;
  fiHandlingSupplier:= TDutynHandlingListGUI(Sender.owner).SelctedHandlingSupplier;
  ChoosenHandlingnDuty := True;
end;

procedure TImportCostGUI.DoAfterShow(Sender: TObject);
begin

end;

procedure TImportCostGUI.DoBeforeShow(Sender: TObject);
begin
  if sender is TfmCheque then
    TfmCheque(Sender).AttachObserver(self)
  else if sender is TBillGUI then
    TBillGUI(Sender).AttachObserver(self);
end;

procedure TImportCostGUI.InitHandlingndutyList(Sender: TObject);
begin
   if not (Sender is TDutynHandlingListGUI) then exit;
   TDutynHandlingListGUI(Sender).POProductIds := POProductIds;
end;
procedure TImportCostGUI.LoadProducts;
var
  qry : TERPQuery;
  p : TProductCostImport;
begin
  Products.Clear;
  { need one for general costs  .. ie for products that don't have duty or handling }
  p := TProductCostImport.Create;
  p.ProductId := 0;
  Products.Add(p);


  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(qryExpenseCosts.Connection);
  try
//  POProductIds;

//    qry.sql.Text := 'select TT.ProductId, max(TT.number) as Number, ProductPrintName from';
//    qry.SQL.add('(select count(productid) as number, productid, productprintname from tblpurchaselines');
//    qry.SQL.Add('where purchaseorderid=' + IntToStr(KeyId) + ' and productid is not null group by productid) TT');
    qry.sql.Text := 'select count(productid) as number, productid, productprintname from tblpurchaselines';
    qry.SQL.Add('where purchaseorderid=' + IntToStr(KeyId) + ' and productid is not null group by productid');
    qry.SQL.Add('order by number desc limit 1');
    qry.Open;
    if (qry.RecordCount > 0) and (qry.Fields[0].asInteger > 1) then
    begin
      MessageDlgXP_Vista('The Purchase Order Has ' + qry.Fields[0].AsString + ' Lines with ' + qry.Fields[2].AsString + ' Product.'#13#10 +
        'Cannot Create Correct Bill For This PO', mtInformation, [mbOk], 0);
      ModalResult := mrCancel;
//      raise EAbort.Create('Error Message');
      Self.Close;
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);
      exit;
    end;
    qry.Close;
    qry.SQL.Text := 'Select Distinct ProductId from tblpurchaselines where PurchaseOrderId = ' + IntToStr(KeyId) + ' and Shipped > 0';
    opendb(qry);
    qry.First;
    while not qry.eof do
    begin
      p := TProductCostImport.Create;
      p.ProductId := qry.FieldByName('ProductId').AsInteger;
      Products.Add(p);
      qry.Next;
    end;

  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
  Products.InitCosts;
end;

procedure TImportCostGUI.OpenExpenseForm;
begin
  if qryExpenseCosts.RecordCount = 0 then exit;

  if qryExpenseCostsIsBill.AsBoolean then begin
    if fsModal in FormState then
      OpenERPFormModal(TBillGUI.ClassName,qryExpenseCostsPurchaseOrderID.AsInteger,DoBeforeShow)
    else
      OpenERPForm(TBillGUI.ClassName,qryExpenseCostsPurchaseOrderID.AsInteger,DoAfterShow,DoBeforeShow);
  end
  else if qryExpenseCostsIsCheque.AsBoolean then begin
    if fsModal in FormState then
      OpenERPFormModal(TfmCheque.ClassName,qryExpenseCostsPurchaseOrderID.AsInteger,DoBeforeShow)
    else
      OpenERPForm(TfmCheque.ClassName,qryExpenseCostsPurchaseOrderID.AsInteger,DoAfterShow,DoBeforeShow);
  end;
end;

Function TImportCostGUI.POProductIds :String;
var
  qry : TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(qryExpenseCosts.Connection);
  try
    qry.SQL.Text := 'Select Distinct ProductId from tblpurchaselines where PurchaseOrderId = ' + IntToStr(KeyId);
    opendb(qry);
    result := qry.GroupConcat('ProductId');
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TImportCostGUI.btnBillsClick(Sender: TObject);
var
  BillObj: TBill;
  //Handlingbill : TBill;
  qry : TERPQuery;
  lHandling,
  lDuty : double;
  lDutyAcc, lHandlingAcc : string;
  p : TProductCostImport;
begin
  inherited;
  if POAmount =0 then begin
    MessageDlgXP_Vista('This PO is either a Backorder or a 0 value Order.'+#13+#10+'It is not Possible to Create Bills for a  0 Value PurchaseOrder', mtWarning, [mbOK], 0);
    Exit
  end;

  lDuty := 0.0;
  lHandling := 0.0;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(qryExpenseCosts.Connection);
  try

    if (AppEnv.CompanyPrefs.DutiesAccount = 0) or (AppEnv.CompanyPrefs.BrokerHandlingAccount = 0) then
    begin
      MessageDlgXP_VISTA('Cannot Create Bills as Either "Duty Account" or "Handling Account" is Not Defined in Preferences.'+NL+
                         'Choose Utilities->Preferences->Purchases to Set Them Up', mtWarning, [mbOk], 0);
      exit;
    end;

    lHandlingAcc := GetAccountName(AppEnv.CompanyPrefs.BrokerHandlingAccount);
    lDutyAcc := GetAccountName(AppEnv.CompanyPrefs.DutiesAccount);


    closedb(Qry);
    Qry.SQL.Clear;
(*    Qry.SQL.Add(' SELECT PL.productID, count(IP.ID) ctr ' +
                ' from tblPurchaseLines PL ' +
                ' inner join tblImportProducts IP on IP.ProductId=PL.ProductId ' +
                ' where PL.PurchaseOrderId = ' + IntToStr(KeyId)+' ' +
                ' group by PL.productID ' +
                ' having ctr>1');*)
    Qry.SQL.Add(' Select * from ( '+
                ' SELECT PL.PurchaseOrderId, PL.productID, ' +
                ' (select count(ID) from tblImportProducts IP where IP.ProductId=PL.ProductId  and ifnull(Duty,0)<> 0) as dutyctr, ' +
                ' (select count(ID) from tblImportProducts IP where IP.ProductId=PL.ProductId  and ifnull(Handling,0)<> 0) as Handlingctr ' +
                ' from tblPurchaseLines PL ' +
                ' where PL.PurchaseOrderId =  ' + IntToStr(KeyId)+') pp where ifnull(dutyctr,0)>1 or ifnull(Handlingctr,0)>1');
    Opendb(Qry);

    if Qry.RecordCount>0 then begin
        fdDuty:= 0;
        fdHandling := 0;
        fiDutySupplier:= 0;
        fiHandlingSupplier := 0;
        ChoosenHandlingnDuty := False;
        try
          OpenERPListFormSingleselectModal('TDutynHandlingListGUI' , ChooseHandlingnDuty , InitHandlingndutyList);
          if not ChoosenHandlingnDuty then exit;
          if(fdDuty= 0) and (fdHandling = 0) and (fiDutySupplier= 0) and (fiHandlingSupplier = 0) then exit; // nothing selected
        finally
          ChoosenHandlingnDuty := False;
        end;
        Closedb(Qry);
        qry.SQL.Clear;
        qry.SQL.Add('Select DutySupplierId , HandlingSupplierId, ProductId, ProductName, AccountName, ForeignTotalLineAmount, Duty, Handling FROM (');
        qry.SQL.Add('SELECT ' + inttostr(fiDutySupplier)+' as DutySupplierId, null as HandlingSupplierId ,  PL.ProductId, PL.ProductName, AC.AccountName, PL.ForeignTotalLineAmount,');
        qry.SQL.Add('sum(PL.TotalLineAmountInc  * (ifnull(' +floattostr(fdDuty) +', 0)) / 100) as Duty,');
        qry.SQL.Add('null  as Handling');
        qry.SQL.Add('from tblPurchaseLines PL');
        qry.SQL.Add('inner join tblPurchaseOrders O on O.PurchaseOrderId = PL.PurchaseOrderId');
        qry.SQL.Add('inner join tblChartOfAccounts AC on O.AccountId=AC.AccountId');
        qry.SQL.Add('where PL.PurchaseOrderId = ' + IntToStr(KeyId));
        qry.SQL.Add('group by PL.ProductId');
        qry.SQL.Add('union all ');
        qry.SQL.Add('SELECT null as DutySupplierId, ' + inttostr(fiHandlingSupplier)+' as HandlingSupplierId ,  PL.ProductId, PL.ProductName, AC.AccountName, PL.ForeignTotalLineAmount,');
        qry.SQL.Add('null  as Duty,');
        qry.SQL.Add('sum(PL.TotalLineAmountInc * (ifnull(' +floattostr(fdHandling) +', 0)) / 100) as Handling');
        qry.SQL.Add('from tblPurchaseLines PL');
        qry.SQL.Add('inner join tblPurchaseOrders O on O.PurchaseOrderId = PL.PurchaseOrderId');
        qry.SQL.Add('inner join tblChartOfAccounts AC on O.AccountId=AC.AccountId');
        qry.SQL.Add('where PL.PurchaseOrderId = ' + IntToStr(KeyId));
        qry.SQL.Add('group by PL.ProductId');
        qry.SQL.Add(') T where Duty <> 0 or Handling <> 0 Order by DutySupplierId , HandlingSupplierId');
    end else begin
        Closedb(Qry);
        qry.SQL.Clear;
        qry.SQL.Add('Select DutySupplierId, HandlingSupplierId, ');
        qry.SQL.Add('ProductId, ProductName, AccountName, ForeignTotalLineAmount,sum( Duty) as Duty, Sum(Handling) as Handling');
        qry.SQL.Add('FROM (');
        qry.SQL.Add('SELECT if(ifnull(IP.Duty, 0) <> 0 , supplierId , 0) as DutySupplierId, ');
        qry.SQL.Add('if(ifnull(IP.Handling, 0) <> 0 , supplierId , 0) as HandlingSupplierId,');
        qry.SQL.Add('PL.ProductId, PL.ProductName, AC.AccountName, PL.ForeignTotalLineAmount, ');
        qry.SQL.Add('(PL.TotalLineAmountInc * (ifnull(IP.Duty, 0)) / 100) as Duty,');
        qry.SQL.Add('(pl.TotalLineAmountInc * (ifnull(IP.Handling, 0)) / 100) as Handling');
        qry.SQL.Add('from tblPurchaseLines PL');
        qry.SQL.Add('inner join tblPurchaseOrders O on O.PurchaseOrderId = PL.PurchaseOrderId');
        qry.SQL.Add('inner join tblChartOfAccounts AC on O.AccountId=AC.AccountId');
        qry.SQL.Add('left join tblImportProducts IP on IP.ProductId=PL.ProductId ');
        qry.SQL.Add('where PL.PurchaseOrderId = ' + IntToStr(KeyId));
        qry.SQL.Add('');
        qry.SQL.Add(') T where Duty <> 0 or Handling <> 0 group by  DutySupplierId  , HandlingSupplierId , ProductId Order by DutySupplierId , HandlingSupplierId');
    end;

    qry.Open;

    if (qry.RecordCount = 0) then begin
      if MessageDlgXP_Vista('The Purchase Order Either Does Not Contain Products, or Products Do Not Have Duty And Handling Set up.'#13#10 +
                         'Check The Product Cards', mtWarning, [mbOk], 0 , nil, '', '', false, nil , 'Open Handling and Duty List') =100 then begin
                          OpenERPListForm('TDutynHandlingListGUI' , nil);
                          Self.Close;
      end;
      exit;
    end;

//    Products.InitCosts;

    qry.First;
    while not qry.eof do         begin
        BillObj := TBill.Create(Self);
        try
          BillObj.Connection := TMyDacDataConnection.create(BillObj);
          BillObj.Connection.Connection := MyConnection; //GetNewMyDacConnection(self);
          BillObj.Load(0);
          BillObj.New;
          BillObj.SupplierId := iif(qry.fieldbyname('DutySupplierId').AsInteger<>0 , qry.fieldbyname('DutySupplierId').AsInteger, qry.fieldbyname('HandlingSupplierId').AsInteger);
          BillObj.OrderDate := Trunc(now);
          BillObj.Comments := 'Duties/Handling Bill- Created From Purchase Order ' + IntToStr(KeyId);
            while not qry.eof  and (iif(qry.fieldbyname('DutySupplierId').AsInteger<>0 , qry.fieldbyname('DutySupplierId').AsInteger, qry.fieldbyname('HandlingSupplierId').AsInteger)= BillObj.SupplierId ) do begin
              p := Products.ImportedProduct(qry.FieldByName('ProductId').AsInteger);
              if (qry.fieldbyname('Duty').asFloat<>0) or (qry.fieldbyname('Handling').asFloat<>0) then begin
                  if qry.FieldByName('Duty').AsFloat <> 0 then begin
                      BillObj.Lines.New;
                      BillObj.Lines.AccountName := lDutyAcc;
                      BillObj.Lines.ProductID := qry.FieldByName('ProductId').AsInteger;
                      BillObj.Lines.ProductDescription := 'Duty On: ' + qry.FieldByName('ProductName').asString;
                      BillObj.Lines.LineTaxRate := 0;
                      BillObj.Lines.LineTaxTotal := 0;
                      BillObj.Lines.LineCost := qry.FieldByName('Duty').AsFloat;
                      BillObj.Lines.LineCostInc := qry.FieldByName('Duty').AsFloat;
                      lDuty := lDuty + qry.FieldByName('Duty').AsFloat;
                      BillObj.Lines.RelatedPOID := KeyId;
//                      BillObj.Lines.ProductID := qry.FieldByName('ProductId').AsInteger;
//                      BillObj.Lines.LineTaxRate := 0;
//                      BillObj.Lines.LineTaxTotal := 0;
                      BillObj.Lines.TotalLineAmount := qry.FieldByName('Duty').asFloat;
                      BillObj.Lines.TotalLineAmountInc := qry.FieldByName('Duty').asFloat;
                      BillObj.Lines.PostDb;
                      p.Duty := p.Duty +  qry.FieldByName('Duty').AsFloat;
                  end;

                  if qry.FieldByName('Handling').AsFloat <> 0 then begin
                      BillObj.Lines.New;
                      BillObj.Lines.AccountName := lHandlingAcc;
                      BillObj.Lines.ProductID := qry.FieldByName('ProductId').AsInteger;
                      BillObj.Lines.ProductDescription := 'Handling On: ' + qry.FieldByName('ProductName').asString;
                      BillObj.Lines.LineTaxRate := 0;
                      BillObj.Lines.LineTaxTotal := 0;
                      BillObj.Lines.LineCost := qry.FieldByName('Handling').AsFloat;
                      BillObj.Lines.LineCostInc := qry.FieldByName('Handling').AsFloat;
                      lHandling := lHandling + qry.FieldByName('Handling').AsFloat;
//                      BillObj.Lines.ProductID := qry.FieldByName('ProductId').AsInteger;
                      BillObj.Lines.RelatedPOID := KeyId;
//                      BillObj.Lines.LineTaxRate := 0;
//                      BillObj.Lines.LineTaxTotal := 0;
                      BillObj.Lines.TotalLineAmount := qry.FieldByName('Handling').asFloat;
                      BillObj.Lines.TotalLineAmountInc := qry.FieldByName('Handling').asFloat;
                      BillObj.Lines.PostDb;
                      p.Handling := p.Handling + qry.FieldByName('Handling').asFloat;
                  end;
              end;
              if assigned(p) then      // ???
                p.LineAmount := 0;
              qry.Next;
            end;
            BillObj.comments := '';
            if lDuty     >0 then BillObj.comments := BillObj.comments +'Duty total : '     + floattostr(lDuty)     +NL;
            if lHandling >0 then BillObj.comments := BillObj.comments +'Handling total : ' + floattostr(lHandling) +NL;
            BillObj.PostDB;
            lDuty     :=0;
            lHandling := 0;

            BillObj.CalcOrderTotals;
            BillObj.Billtotal := BillObj.TotalAmountInc;
            if not BillObj.Save  then
              MessageDLGXP_Vista('Error on Creating Broker Handling Bill'#13#13 + BillObj.ResultStatus.Messages, mtWarning, [mbOk], 0);
          finally
            Freeandnil(BillObj);
          end;
    end;

  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;

  if qryExpenseCosts.state <> dsBrowse  then
    qryExpenseCosts.Post;
  Self.CommitTransaction;
  qryExpenseCosts.Close;
  qryExpenseCosts.Open;
  PerformExpensesCalcTotals;
  BeginTransaction;

end;

procedure TImportCostGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  self.RollbackTransaction;
  Self.Close;
end;

procedure TImportCostGUI.btnGridDeleteClick(Sender: TObject);
begin
  inherited;
  //
  OpenExpenseForm;
end;

procedure TImportCostGUI.qryExpenseCostsRelatedPOIDUsedChange(Sender: TField);
begin
  inherited;

  PerformExpensesCalcTotals;
end;



procedure TImportCostGUI.UpdateMe;
begin
  inherited;

end;

procedure TImportCostGUI.UpdateMe(const Cancelled: boolean;
  const aObject: TObject);
begin
  inherited;
  if (not Cancelled) and ((aObject is TfmCheque) or (aObject is TBillGUI)) then begin
    qryExpenseCosts.Refresh;
    self.LoadProducts;
  end;
end;

{ TPOImportList }

procedure TPOImportList.Add(AProduct: TProductCostImport);
begin
  if assigned(AProduct) then
    List.Add(AProduct);
end;

function TPOImportList.Amount(AProductId: integer): double;
var
  p : TProductCostImport;
begin
  p := ImportedProduct(AProductId);
  if assigned(p) then
    Result := p.POAmount
  else
    Result := 0;
end;

constructor TPOImportList.Create;
begin
  inherited;
  List := TObjectList.Create(true);
end;

destructor TPOImportList.Destroy;
begin
  List.Free;
  inherited;
end;

function TPOImportList.ImportedProduct(AProductId: integer): TProductCostImport;
var
  idx : integer;
begin
  for idx := 0 to List.Count - 1 do
    if TProductCostImport(List[idx]).ProductId = AProductId then
    begin
      Result := TProductCostImport(List[idx]);
      exit;
    end;
  Result := nil;
end;

procedure TPOImportList.InitCosts;
var
  idx : integer;
  p : TProductCostImport;
begin
  for idx := 0 to List.Count - 1 do
  begin
    p :=   TProductCostImport(List[idx]);
    p.Duty := 0;
    p.Handling := 0;
    p.LineAmount := 0;
    p.CostsAdded := false;
  end;
end;

function TPOImportList.LandedCost(AProductId: integer): double;
var
  p : TProductCostImport;
begin
  p := ImportedProduct(AProductId);
  if not assigned(p) then
    Result := 0
  else if p.Duty + P.Handling = p.LineAmount then
    Result := p.LineAmount
  else if p.LineAmount = 0 then
   Result := p.Duty + P.Handling
  else
    Result := p.LineAmount;
end;

procedure TPOImportList.Clear;
begin
  fList.Clear;
end;

function TPOImportList.CostsExistForProduct(AProductId: integer): boolean;
var
  idx : integer;
begin
  result := false;
  for idx := 0 to List.Count - 1 do begin
    if TProductCostImport(List[idx]).ProductId = AProductID then begin
      result := TProductCostImport(List[idx]).CostsAdded;
      exit;
    end;
  end;
end;

function TPOImportList.TotalLandedCost: double;
var
  p : TProductCostImport;
  idx : integer;
begin
  Result := 0;
  for idx := 0 to List.Count - 1 do
  begin
    p := TProductCostImport(List[idx]);
    if assigned(p) then
    begin
      if p.Duty + p.Handling <> p.LineAmount then
      begin
        if p.LineAmount <> 0 then
          Result := Result + p.LineAmount
        else
          Result := Result + p.Duty + p.Handling;
      end
      else
        Result := Result + P.LineAmount;
    end;
  end;
end;

Initialization
  RegisterClassOnce(TImportCostGUI);

end.
