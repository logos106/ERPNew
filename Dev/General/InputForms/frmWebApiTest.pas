unit frmWebApiTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  DNMSpeedButton, StdCtrls, DNMPanel, JsonObject, wwcheckbox, Shader, HTMLabel,
  JsonRpcTcpClient, ProgressDialog, Grids, Wwdbigrd, Wwdbgrid, IntegerListObj;

type

  TProductRec = record
    Name: string;
    PriceEx: double;
    PriceInc: double;
    TaxCode: string;
    PurchTaxCode: string;
    CostEx: double;
    CostInc: double;
  end;

  TNameRec = record
    Name: string;
    Title: string;
    First: string;
    Last: string;
  end;

  TfmWebAPITest = class(TBaseInputGUI)
    pnlBottom: TDNMPanel;
    edtUser: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtPass: TEdit;
    Label3: TLabel;
    edtDatabase: TEdit;
    btnClose: TDNMSpeedButton;
    pnlRequest: TDNMPanel;
    Splitter1: TSplitter;
    pnlResult: TDNMPanel;
    pnlRequestTop: TDNMPanel;
    pnlResponceTop: TDNMPanel;
    memRequest: TMemo;
    memResponce: TMemo;
    MenuExamples: TPopupMenu;
    mnuCreateNewCustomer: TMenuItem;
    mnuCreateNewProduct: TMenuItem;
    mnuCreateNewQuote: TMenuItem;
    chkFormatJson: TwwCheckBox;
    mnuGetProductList: TMenuItem;
    mnuGetCustomerList: TMenuItem;
    mnuGetQuoteList: TMenuItem;
    mnuGetSalesOrderList: TMenuItem;
    mnuGetInvoiceList: TMenuItem;
    mnuGetProductPictureList: TMenuItem;
    pnlTop: TDNMPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label4: TLabel;
    cboURL: TComboBox;
    btnExamples: TDNMSpeedButton;
    btnPost: TDNMSpeedButton;
    btnGet: TDNMSpeedButton;
    btnHelp: TDNMSpeedButton;
    mnuCreateNewSalesOrder: TMenuItem;
    mnuCreateNewInvoice: TMenuItem;
    mnuCreatNewLead: TMenuItem;
    mnuGetTaskList: TMenuItem;
    mnuGetSupportLogList: TMenuItem;
    mnuMore: TMenuItem;
    lblPort: TLabel;
    btnRESTClient: TDNMSpeedButton;
    mnuCreateNewPurchaseOrder: TMenuItem;
    mnuCreateCustomerPrepayment1: TMenuItem;
    mnuCreateNewPOwithBatchNos: TMenuItem;
    mnuGetInternalSalesOrderList: TMenuItem;
    memResult: TMemo;
    mnuPrintInvoice: TMenuItem;
    pnlDevmode: TDNMPanel;
    pnlObjects: TDNMPanel;
    Lstobjects: TListBox;
    tmrProcess: TTimer;
    lblProcess: TLabel;
    pnlGTOptions: TDNMPanel;
    DNMSpeedButton8: TDNMSpeedButton;
    DNMSpeedButton9: TDNMSpeedButton;
    DNMSpeedButton10: TDNMSpeedButton;
    DNMSpeedButton11: TDNMSpeedButton;
    DNMSpeedButton12: TDNMSpeedButton;
    DNMSpeedButton13: TDNMSpeedButton;
    InputAPItype1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    BalanceSheet1: TMenuItem;
    N4: TMenuItem;
    ransactionJournal1: TMenuItem;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMSpeedButton2: TDNMSpeedButton;
    btnErpAdminCred: TDNMSpeedButton;
    btnDropdatabase: TDNMSpeedButton;
    DNMSpeedButton5: TDNMSpeedButton;
    btnCreateNewDatabase: TDNMSpeedButton;
    DNMSpeedButton4: TDNMSpeedButton;
    DNMSpeedButton3: TDNMSpeedButton;
    DNMSpeedButton6: TDNMSpeedButton;
    DNMSpeedButton7: TDNMSpeedButton;
    btnVS1renew: TDNMSpeedButton;
    tbnAddModules: TDNMSpeedButton;
    btnDBConnect: TDNMSpeedButton;
    btnChangeDatabase: TDNMSpeedButton;
    btnupdatecomppre: TDNMSpeedButton;
    btnRepeatAppt: TDNMSpeedButton;
    btnDashboard: TDNMSpeedButton;
    DNMSpeedButton14: TDNMSpeedButton;
    btnvs1credentisal: TDNMSpeedButton;
    DNMSpeedButton1: TDNMSpeedButton;
    btncoreEDi: TDNMSpeedButton;
    mnuExampleWithOptions: TMenuItem;
    N5: TMenuItem;
    btnbackuprestore: TDNMSpeedButton;
    procedure btnCloseClick(Sender: TObject);
    procedure btnGetClick(Sender: TObject);
    procedure btnPostClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cboURLExit(Sender: TObject);
    procedure edtUserExit(Sender: TObject);
    procedure edtPassExit(Sender: TObject);
    procedure edtDatabaseExit(Sender: TObject);
    procedure memRequestExit(Sender: TObject);
    procedure mnuCreateNewCustomerClick(Sender: TObject);
    procedure mnuCreateNewProductClick(Sender: TObject);
    procedure mnuCreateNewQuoteClick(Sender: TObject);
    procedure chkFormatJsonClick(Sender: TObject);
    procedure mnuGetProductListClick(Sender: TObject);
    procedure mnuGetCustomerListClick(Sender: TObject);
    procedure mnuGetQuoteListClick(Sender: TObject);
    procedure mnuGetSalesOrderListClick(Sender: TObject);
    procedure mnuGetInvoiceListClick(Sender: TObject);
    procedure mnuGetProductPictureListClick(Sender: TObject);
    procedure btnExamplesClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnHelpClick(Sender: TObject);
    procedure mnuCreateNewSalesOrderClick(Sender: TObject);
    procedure mnuCreateNewInvoiceClick(Sender: TObject);
    procedure mnuCreatNewLeadClick(Sender: TObject);
    procedure mnuGetTaskListClick(Sender: TObject);
    procedure mnuGetSupportLogListClick(Sender: TObject);
    procedure mnuMoreClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnRESTClientClick(Sender: TObject);
    procedure mnuCreateNewPurchaseOrderClick(Sender: TObject);
    procedure mnuCreateCustomerPrepayment1Click(Sender: TObject);
    procedure mnuCreateNewPOwithBatchNosClick(Sender: TObject);
    procedure mnuGetInternalSalesOrderListClick(Sender: TObject);
    procedure mnuPrintInvoiceClick(Sender: TObject);
    procedure btnvs1credentisalClick(Sender: TObject);
    procedure btnErpAdminCredClick(Sender: TObject);
    procedure DNMSpeedButton2Click(Sender: TObject);
    procedure btnCreateNewDatabaseClick(Sender: TObject);
    procedure DNMSpeedButton3Click(Sender: TObject);
    procedure LstobjectsDblClick(Sender: TObject);
    procedure DNMSpeedButton4Click(Sender: TObject);
    procedure DNMSpeedButton5Click(Sender: TObject);
    procedure DNMSpeedButton6Click(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure memResponceDblClick(Sender: TObject);
    procedure DNMSpeedButton7Click(Sender: TObject);
    procedure btnVS1renewClick(Sender: TObject);
    procedure tbnAddModulesClick(Sender: TObject);
    procedure DNMSpeedButton8Click(Sender: TObject);
    procedure DNMSpeedButton9Click(Sender: TObject);
    procedure DNMSpeedButton10Click(Sender: TObject);
    procedure DNMSpeedButton11Click(Sender: TObject);
    procedure DNMSpeedButton12Click(Sender: TObject);
    procedure DNMSpeedButton13Click(Sender: TObject);
    procedure InputAPItype1Click(Sender: TObject);
    procedure BalanceSheet1Click(Sender: TObject);
    procedure ransactionJournal1Click(Sender: TObject);
    procedure btnDropdatabaseClick(Sender: TObject);
    procedure btnDBConnectClick(Sender: TObject);
    procedure btnChangeDatabaseClick(Sender: TObject);
    procedure btnupdatecomppreClick(Sender: TObject);
    procedure btnRepeatApptClick(Sender: TObject);
    procedure btnDashboardClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure DNMSpeedButton14Click(Sender: TObject);
    procedure btncoreEDiClick(Sender: TObject);
    procedure mnuExampleWithOptionsClick(Sender: TObject);
    procedure btnbackuprestoreClick(Sender: TObject);
  private
    Config: TJsonObject;
    FormClosing: boolean;
    FirstHttpError: boolean;
    fsdb, fsServer, fsclient:String;
    fEmployeeIds, fformIds:TIntegerList;
    fiAptID:Integer;
    fbIgnorecheckSettings: Boolean;
    procedure LoadConfig;
    procedure SaveConfig;
    procedure DoRequest(const RequestType: string);
    procedure UpdateResult(ResultCode: string; ErrorMessage: string = '');
    function GetExistingCustomerName: string;
    function GetExistingSupplierName: string;
    function GetExistingProduct(ExcludeProductName: string = ''; IsBatchProduct: boolean = false): TProductRec;
    function GetExistingSalesCategory: string;
    function GetNewCustomer(IsMarketingContact: boolean = false): TNameRec;
    function GetNewProductName: string;
    function GetExistingEmployeeName: string;
    procedure CheckSettings(CheckServer: boolean);
    function ConnectToUtilsModule(Client: TJsonRpcTcpClient;
      Server, ModuleName: string; var msg: string): boolean;
    function GetWebAPIConfig(aServer: string; var aConfig: TJsonObject; var msg: string): boolean;
    function ExtractServer(aURL: string): string;
    function CheckDBUser(UserName, aDatabase: string): string;
    function GetServer: string;
    procedure SetServer(const Value: string);
    function GetUseSSL: boolean;
    procedure SetUseSSL(const Value: boolean);
    function GetPort: integer;
    procedure SetPort(const Value: integer);
    procedure ChooseDatabase(Sender: TwwDbGrid);
    procedure ChooseDatabaseinmemo(Sender: TwwDbGrid);
    procedure chooseEmployees(Sender: TwwDBGrid);
    procedure Chooseforms(Sender: TwwDBGrid);
    procedure StsDefaults;
    function ChooseAptID: Integer;
    procedure OnSelectChooseAptID(Sender: TwwDbGrid);
    property Server: string read GetServer write SetServer;
    property UseSSL: boolean read GetUseSSL write SetUseSSL;
    property Port: integer read GetPort write SetPort;
    function GetLastInvoiceNumber: integer;
    procedure OpenReport;
  public
    procedure AddClassToURL(aClassName: string);
    Property IgnorecheckSettings:Boolean read fbIgnorecheckSettings write fbIgnorecheckSettings;
  end;

var
  fmWebAPITest: TfmWebAPITest;

implementation

{$R *.dfm}

uses
  commonLib, AppEnvironment, IdHTTP, IdSSLOpenSSL, BusObjPreference,
  CommonDbLib, BusObjBase, ShellAPI, UtilsServerUtils, JsonRPCConst,
  SimpleEncrypt, frmPopupSelect, IdURI, HTTPConst, SystemLib, idCoderMIME,
  utVS1Const, CommonFormLib, LogLib, ModuleConst, BusObjVS1_Cloud,
  DbSharedObjectsObj,dateutils, BaseListingForm, tcConst, utGTConst,
  Clipbrd, utCloudconst, frmComboInput, MySQLConst, ClientList , AppointmentListForm;

  const
  Firsts: array[0..14] of string = ('Ian','Peter','Tom','Frank','John','Matt','Tim','Rob','Terry','Richard','Bob','Steve','Ian','Fred','William');
  Lasts: array[0..12] of string = ('Smith','Brown','White','Black','Jones','Johnston','Franks','Baldwin','Richards','Baskins','Allwood','Banks','Robertson');

procedure FormatJson(xStrings: TStrings);
var
  x: integer;
  ident: integer;
  isObj: boolean;
  sl: TStringList;

  function PadStr: string;
  var y: integer;
  begin
    result:= '';
    for y:= 0 to ident -1 do
      result:= result + '    ';
  end;

begin
  sl := TStringList.Create;
  try
    sl.Text := xStrings.Text;
    ident:= 0;
    for x:= 0 to sl.Count-1 do begin
      if (Pos('}',sl[x]) = 1) and (ident > 0) then
        dec(ident);
      isObj:= Pos('{',sl[x]) = 1;
      sl[x]:= PadStr + sl[x];
      if IsObj then Inc(ident);
    end;
    xStrings.Text := sl.Text;
  finally
    sl.Free;
  end;
end;

  { TfmWebAPITest }

procedure TfmWebAPITest.mnuCreateCustomerPrepayment1Click(Sender: TObject);
var
  amount: integer;
begin
  inherited;
  amount := 0;
  while amount < 10 do
    amount := Random(1000);
  AddClassToURL('TCustomerPrepayment');
  with memRequest.Lines do begin
    Clear;
    Add('{');
    Add('"type":"TCustomerPrepayment",');
    Add('"fields":');
    Add('    {');
    Add('    "CompanyName":"'+ self.GetExistingCustomerName +'",');
    Add('    "PayMethodName":"Cash",');
    Add('    "PayAmount":' + IntToStr(amount));
    Add('    }');
    Add('}');
  end;
end;

procedure TfmWebAPITest.mnuCreateNewCustomerClick(Sender: TObject);
var
  NameRec: TNameRec;
begin
  inherited;
  NameRec:= self.GetNewCustomer;
  AddClassToURL('TCustomer');
  with memRequest.Lines do begin
    Clear;
    Add('{');
    Add('"type":"TCustomer",');
    Add('"fields":');
    Add('    {');
    Add('    "ClientName":"'+NameRec.Name+'",');
    Add('    "Title":"'+NameRec.Title+'",');
    Add('    "FirstName":"'+NameRec.First+'",');
    Add('    "LastName":"'+NameRec.Last+'",');
    Add('    "Street":"Unit 12",');
    Add('    "Street2":"Level 3",');
    Add('    "Street3":"12 Main Street",');
    Add('    "Suburb":"SURFERS PARADISE",');
    Add('    "Postcode":"4217",');
    Add('    "State":"QLD",');
    Add('    "Country":"Australia",');
    Add('    "Phone":"07 5555 5555",');
    Add('    "Faxnumber":"07 5555 5555",');
    Add('    "Email":"admin@XYZ.com.au",');
    Add('    "Mobile":"0405 555555",');
    Add('    "ClientTypeName":"Default",');
    Add('    "SourceName":"Radio"');
    Add('    }');
    Add('}');
  end;
end;

procedure TfmWebAPITest.mnuCreateNewInvoiceClick(Sender: TObject);
var
  Prod1, Prod2: TProductRec;
  totEx, totInc: double;
begin
  inherited;
  Prod1:= self.GetExistingProduct();
  Prod2:= self.GetExistingProduct(Prod1.Name);
  totEx:= Round((2 * Prod1.PriceEx) + (1 * Prod2.PriceEx),2);
  totInc:= Round((2 * Prod1.PriceInc) + (1 * Prod2.PriceInc),2);

  AddClassToURL('TInvoice');
  with memRequest.Lines do begin
    Clear;
    Add('{');
    Add('    "type":"TInvoice",');
    Add('    "fields":');
    Add('    {');
    Add('        "GLAccountName":"Accounts Receivable",');
    Add('        "CustomerName":"' + GetExistingCustomerName + '",');
    Add('        "TermsName":"COD",');
    Add('        "EmployeeName":"Admin .",');
    Add('        "SaleClassName":"Default",');
    Add('        "SaleDate":"' + FormatDateTime('yyyy-mm-dd',now) + '",');
    Add('        "ShipToDesc":"XYZ Pty Ltd\r\n12 Mud Drive\r\nROTTNEST ISLAND WA 6161\r\nAustralia",');
    Add('        "SalesCategory":"' + self.GetExistingSalesCategory + '",');
    Add('        "Lines":[');
    Add('        {');
    Add('            "type":"TInvoiceLine",');
    Add('            "fields":');
    Add('            {');
    Add('                "ProductName":"' + Prod1.Name + '",');
    Add('                "UnitOfMeasure":"Units",');
    Add('                "UOMQtySold":2,');
    Add('                "LinePrice":' + FloatToStr(Prod1.PriceEx) + ',');
    Add('                "LineTaxCode":"' + Prod1.TaxCode + '",');
    Add('                "LinePriceInc":' + FloatToStr(Prod1.PriceInc) + ',');
    Add('                "TotalLineAmount":' + FloatToStr(Round(2 * Prod1.PriceEx,2)) + ',');
    Add('                "TotalLineAmountInc":' + FloatToStr(Round(2 * Prod1.PriceInc,2)));
    Add('            }');
    Add('        },');
    Add('        {');
    Add('            "type":"TInvoiceLine",');
    Add('            "fields":');
    Add('            {');
    Add('                "ProductName":"' + Prod2.Name + '",');
    Add('                "UnitOfMeasure":"Units",');
    Add('                "UOMQtySold":1,');
    Add('                "LinePrice":' + FloatToStr(Prod2.PriceEx) + ',');
    Add('                "LineTaxCode":"' + Prod2.TaxCode + '",');
    Add('                "LinePriceInc":' + FloatToStr(Prod2.PriceInc) + ',');
    Add('                "TotalLineAmount":' + FloatToStr(Round(1 * Prod2.PriceEx,2)) + ',');
    Add('                "TotalLineAmountInc":' + FloatToStr(Round(1 * Prod2.PriceInc,2)));
    Add('            }');
    Add('        }],');
    Add('        "Comments":"This is comment line one\r\nand this is comment line two.",');
    Add('        "TotalAmount":' + FloatToStr(totEx) + ',');
    Add('        "TotalAmountInc":' + FloatToStr(totInc));
    Add('    }');
    Add('}');
  end;
end;

procedure TfmWebAPITest.mnuCreateNewProductClick(Sender: TObject);
var
  Prod: string;
begin
  inherited;
  Prod:= GetNewProductName;
  AddClassToURL('TProductWeb');
  with memRequest.Lines do begin
    Clear;
    Add('{');
    Add('"type":"TProductWeb",');
    Add('"fields":');
    Add('    {');
    Add('    "ProductType":"INV",');
    Add('    "ProductName":"'+Prod+'",');
    Add('    "PurchaseDescription":"'+Prod+'",');
    Add('    "SalesDescription":"'+Prod+'",');
    Add('    "AssetAccount":"Inventory Asset",');
    Add('    "CogsAccount":"Cost of Goods Sold",');
    Add('    "IncomeAccount":"Sales",');
    Add('    "BuyQty1":1,');
    Add('    "BuyQty1Cost":5.00000,');
    Add('    "BuyQty2":1,');
    Add('    "BuyQty2Cost":5.00000,');
    Add('    "BuyQty3":1,');
    Add('    "BuyQty3Cost":5.00000,');
    Add('    "SellQty1":1,');
    Add('    "SellQty1Price":10.00000,');
    Add('    "SellQty2":1,');
    Add('    "SellQty2Price":10.00000,');
    Add('    "SellQty3":1,');
    Add('    "SellQty3Price":10.00000,');
    Add('    "TaxCodePurchase":"NCG",');
    Add('    "TaxCodeSales":"GST",');
    Add('    "UOMPurchases":"Units",');
    Add('    "UOMSales":"Units"');
    Add('    }');
    Add('}');
  end;
end;

procedure TfmWebAPITest.mnuCreateNewPurchaseOrderClick(Sender: TObject);
var
  Prod1, Prod2: TProductRec;
  totEx, totInc: double;
begin
  inherited;
  Prod1:= self.GetExistingProduct();
  Prod2:= self.GetExistingProduct(Prod1.Name);
  totEx:= Round((2 * Prod1.CostEx) + (1 * Prod2.CostEx),2);
  totInc:= Round((2 * Prod1.CostInc) + (1 * Prod2.CostInc),2);

  AddClassToURL('TPurchaseOrder');
  with memRequest.Lines do begin
    Clear;
    Add('{');
    Add('    "type":"TPurchaseOrder",');
    Add('    "fields":');
    Add('    {');
    Add('        "GLAccountName":"Accounts Payable",');
    Add('        "ClientName":"' + GetExistingSupplierName + '",');
    Add('        "EmployeeName":"Admin .",');
    Add('        "OrderDate":"' + FormatDateTime('yyyy-mm-dd',now) + '",');
    Add('        "ShipTo":"XYZ Pty Ltd\r\n12 Mud Drive\r\nROTTNEST ISLAND WA 6161\r\nAustralia",');
    Add('        "CustPONumber":"XYZ11-234",');
    Add('        "Lines":[');
    Add('        {');
    Add('            "type":"TPurchaseOrderLine",');
    Add('            "fields":');
    Add('            {');
    Add('                "ProductName":"' + Prod1.Name + '",');
    Add('                "UnitOfMeasure":"Units",');
    Add('                "UOMQtySold":2,');
    Add('                "UOMQtyShipped":2,');
    Add('                "LineCost":' + FloatToStr(Prod1.CostEx) + ',');
    Add('                "LineTaxCode":"' + Prod1.PurchTaxCode + '",');
    Add('                "LineCostInc":' + FloatToStr(Prod1.CostInc) + ',');
    Add('                "TotalLineAmount":' + FloatToStr(Round(2 * Prod1.CostEx,2)) + ',');
    Add('                "TotalLineAmountInc":' + FloatToStr(Round(2 * Prod1.CostInc,2)));
    Add('            }');
    Add('        },');
    Add('        {');
    Add('            "type":"TPurchaseOrderLine",');
    Add('            "fields":');
    Add('            {');
    Add('                "ProductName":"' + Prod2.Name + '",');
    Add('                "UnitOfMeasure":"Units",');
    Add('                "UOMQtySold":1,');
    Add('                "UOMQtyShipped":1,');
    Add('                "LineCost":' + FloatToStr(Prod2.CostEx) + ',');
    Add('                "LineTaxCode":"' + Prod2.PurchTaxCode + '",');
    Add('                "LineCostInc":' + FloatToStr(Prod2.CostInc) + ',');
    Add('                "TotalLineAmount":' + FloatToStr(Round(2 * Prod2.CostEx,2)) + ',');
    Add('                "TotalLineAmountInc":' + FloatToStr(Round(2 * Prod2.CostInc,2)));
    Add('            }');
    Add('        }],');
    Add('        "Comments":"This is comment line one\r\nand this is comment line two.",');
    Add('        "TotalAmount":' + FloatToStr(totEx) + ',');
    Add('        "TotalAmountInc":' + FloatToStr(totInc));
    Add('    }');
    Add('}');
  end;
end;

procedure TfmWebAPITest.mnuCreateNewPOwithBatchNosClick(Sender: TObject);
var
  Prod1: TProductRec;
  totEx, totInc: double;
begin
  inherited;
  Prod1:= self.GetExistingProduct('',true);
  totEx:= Round((2 * Prod1.CostEx),2);
  totInc:= Round((2 * Prod1.CostInc),2);

  AddClassToURL('TPurchaseOrder');
  with memRequest.Lines do begin
    Clear;
    Add('{');
    Add('    "type":"TPurchaseOrder",');
    Add('    "fields":');
    Add('    {');
    Add('        "GLAccountName":"Accounts Payable",');
    Add('        "ClientName":"' + GetExistingSupplierName + '",');
    Add('        "EmployeeName":"Admin .",');
    Add('        "OrderDate":"' + FormatDateTime('yyyy-mm-dd',now) + '",');
    Add('        "ShipTo":"XYZ Pty Ltd\r\n12 Mud Drive\r\nROTTNEST ISLAND WA 6161\r\nAustralia",');
    Add('        "CustPONumber":"XYZ11-234",');
    Add('        "Lines":[');
    Add('        {');
    Add('            "type":"TPurchaseOrderLine",');
    Add('            "fields":');
    Add('            {');
    Add('                "ProductName":"' + Prod1.Name + '",');
    Add('                "UnitOfMeasure":"Units",');
    Add('                "UOMQtySold":2,');
    Add('                "UOMQtyShipped":2,');
    Add('                "LineCost":' + FloatToStr(Prod1.CostEx) + ',');
    Add('                "LineTaxCode":"' + Prod1.PurchTaxCode + '",');
    Add('                "LineCostInc":' + FloatToStr(Prod1.CostInc) + ',');
    Add('                "TotalLineAmount":' + FloatToStr(Round(2 * Prod1.CostEx,2)) + ',');
    Add('                "TotalLineAmountInc":' + FloatToStr(Round(2 * Prod1.CostInc,2)) + ',');
    Add('                "PQA":{');
    Add('                    "type":"TPQA",');
    Add('                    "fields":{');
    Add('                        "PQABatch":[');
    Add('                            {');
    Add('                                "type":"TPQABatch",');
    Add('                                "fields":{');
    Add('                                    "BatchExpiryDate":"",');
    Add('                                    "BatchNo":"CUST-BATCH-AB123",');
    Add('                                    "UOMQty":1,');
    Add('                                    "BOUOMQty":0');
    Add('                                }');
    Add('                            },');
    Add('                            {');
    Add('                                "type":"TPQABatch",');
    Add('                                "fields":{');
    Add('                                    "BatchExpiryDate":"",');
    Add('                                    "BatchNo":"CUST-BATCH-AB124",');
    Add('                                    "UOMQty":1,');
    Add('                                    "BOUOMQty":0');
    Add('                                }');
    Add('                            }');
    Add('                        ]');
    Add('                    }');
    Add('                }');
    Add('            }');
    Add('        }');
    Add('        ],');
    Add('        "Comments":"This is comment line one\r\nand this is comment line two.",');
    Add('        "TotalAmount":' + FloatToStr(totEx) + ',');
    Add('        "TotalAmountInc":' + FloatToStr(totInc));
    Add('    }');
    Add('}');
  end;
end;

procedure TfmWebAPITest.mnuCreateNewQuoteClick(Sender: TObject);
var
  Prod1, Prod2: TProductRec;
  totEx, totInc: double;
begin
  inherited;
  Prod1:= self.GetExistingProduct();
  Prod2:= self.GetExistingProduct(Prod1.Name);
  totEx:= Round((2 * Prod1.PriceEx) + (1 * Prod2.PriceEx),2);
  totInc:= Round((2 * Prod1.PriceInc) + (1 * Prod2.PriceInc),2);

  AddClassToURL('TQuote');
  with memRequest.Lines do begin
    Clear;
    Add('{');
    Add('    "type":"TQuote",');
    Add('    "fields":');
    Add('    {');
    Add('        "GLAccountName":"Accounts Receivable",');
    Add('        "CustomerName":"' + GetExistingCustomerName + '",');
    Add('        "TermsName":"COD",');
    Add('        "EmployeeName":"Admin .",');
    Add('        "SaleClassName":"Default",');
    Add('        "SaleDate":"' + FormatDateTime('yyyy-mm-dd',now) + '",');
    Add('        "ShipToDesc":"XYZ Pty Ltd\r\n12 Mud Drive\r\nROTTNEST ISLAND WA 6161\r\nAustralia",');
    Add('        "SalesCategory":"' + self.GetExistingSalesCategory + '",');
    Add('        "Lines":[');
    Add('        {');
    Add('            "type":"TQuoteLine",');
    Add('            "fields":');
    Add('            {');
    Add('                "ProductName":"' + Prod1.Name + '",');
    Add('                "UnitOfMeasure":"Units",');
    Add('                "UOMQtySold":2,');
    Add('                "LinePrice":' + FloatToStr(Prod1.PriceEx) + ',');
    Add('                "LineTaxCode":"' + Prod1.TaxCode + '",');
    Add('                "LinePriceInc":' + FloatToStr(Prod1.PriceInc) + ',');
    Add('                "TotalLineAmount":' + FloatToStr(Round(2 * Prod1.PriceEx,2)) + ',');
    Add('                "TotalLineAmountInc":' + FloatToStr(Round(2 * Prod1.PriceInc,2)));
    Add('            }');
    Add('        },');
    Add('        {');
    Add('            "type":"TQuoteLine",');
    Add('            "fields":');
    Add('            {');
    Add('                "ProductName":"' + Prod2.Name + '",');
    Add('                "UnitOfMeasure":"Units",');
    Add('                "UOMQtySold":1,');
    Add('                "LinePrice":' + FloatToStr(Prod2.PriceEx) + ',');
    Add('                "LineTaxCode":"' + Prod2.TaxCode + '",');
    Add('                "LinePriceInc":' + FloatToStr(Prod2.PriceInc) + ',');
    Add('                "TotalLineAmount":' + FloatToStr(Round(1 * Prod2.PriceEx,2)) + ',');
    Add('                "TotalLineAmountInc":' + FloatToStr(Round(1 * Prod2.PriceInc,2)));
    Add('            }');
    Add('        }],');
    Add('        "Comments":"This is comment line one\r\nand this is comment line two.",');
    Add('        "TotalAmount":' + FloatToStr(totEx) + ',');
    Add('        "TotalAmountInc":' + FloatToStr(totInc));
    Add('    }');
    Add('}');
  end;
end;

procedure TfmWebAPITest.mnuCreateNewSalesOrderClick(Sender: TObject);
var
  Prod1, Prod2: TProductRec;
  totEx, totInc: double;
begin
  inherited;
  Prod1:= self.GetExistingProduct();
  Prod2:= self.GetExistingProduct(Prod1.Name);
  totEx:= Round((2 * Prod1.PriceEx) + (1 * Prod2.PriceEx),2);
  totInc:= Round((2 * Prod1.PriceInc) + (1 * Prod2.PriceInc),2);

  AddClassToURL('TSalesOrder');
  with memRequest.Lines do begin
    Clear;
    Add('{');
    Add('    "type":"TSalesOrder",');
    Add('    "fields":');
    Add('    {');
    Add('        "GLAccountName":"Accounts Receivable",');
    Add('        "CustomerName":"' + GetExistingCustomerName + '",');
    Add('        "TermsName":"COD",');
    Add('        "EmployeeName":"Admin .",');
    Add('        "SaleClassName":"Default",');
    Add('        "SaleDate":"' + FormatDateTime('yyyy-mm-dd',now) + '",');
    Add('        "ShipToDesc":"XYZ Pty Ltd\r\n12 Mud Drive\r\nROTTNEST ISLAND WA 6161\r\nAustralia",');
    Add('        "SalesCategory":"' + self.GetExistingSalesCategory + '",');
    Add('        "Lines":[');
    Add('        {');
    Add('            "type":"TSalesOrderLine",');
    Add('            "fields":');
    Add('            {');
    Add('                "ProductName":"' + Prod1.Name + '",');
    Add('                "UnitOfMeasure":"Units",');
    Add('                "UOMQtySold":2,');
    Add('                "LinePrice":' + FloatToStr(Prod1.PriceEx) + ',');
    Add('                "LineTaxCode":"' + Prod1.TaxCode + '",');
    Add('                "LinePriceInc":' + FloatToStr(Prod1.PriceInc) + ',');
    Add('                "TotalLineAmount":' + FloatToStr(Round(2 * Prod1.PriceEx,2)) + ',');
    Add('                "TotalLineAmountInc":' + FloatToStr(Round(2 * Prod1.PriceInc,2)));
    Add('            }');
    Add('        },');
    Add('        {');
    Add('            "type":"TSalesOrderLine",');
    Add('            "fields":');
    Add('            {');
    Add('                "ProductName":"' + Prod2.Name + '",');
    Add('                "UnitOfMeasure":"Units",');
    Add('                "UOMQtySold":1,');
    Add('                "LinePrice":' + FloatToStr(Prod2.PriceEx) + ',');
    Add('                "LineTaxCode":"' + Prod2.TaxCode + '",');
    Add('                "LinePriceInc":' + FloatToStr(Prod2.PriceInc) + ',');
    Add('                "TotalLineAmount":' + FloatToStr(Round(1 * Prod2.PriceEx,2)) + ',');
    Add('                "TotalLineAmountInc":' + FloatToStr(Round(1 * Prod2.PriceInc,2)));
    Add('            }');
    Add('        }],');
    Add('        "Comments":"This is comment line one\r\nand this is comment line two.",');
    Add('        "TotalAmount":' + FloatToStr(totEx) + ',');
    Add('        "TotalAmountInc":' + FloatToStr(totInc));
    Add('    }');
    Add('}');
  end;
end;

procedure TfmWebAPITest.mnuCreatNewLeadClick(Sender: TObject);
var
  NameRec: TNameRec;
  rep: string;
begin
  inherited;
  NameRec:= self.GetNewCustomer(true);
  rep:= GetExistingEmployeeName;
  AddClassToURL('TLeads');
  with memRequest.Lines do begin
    Clear;
    Add('{');
    Add('"type":"TLeads",');
    Add('"fields":');
    Add('    {');
    Add('    "Company":"'+ NameRec.Name +'",');
    Add('    "EnteredByEmployee":"' + rep + '",');
    Add('    "IsLead":true,');
    Add('    "RepName":"' + rep + '",');
    Add('    "MarketingContacts":');
    Add('    {');
    Add('        "type":"TMarketingContact",');
    Add('        "fields":');
    Add('        {');
    Add('            "Company":"' + NameRec.Name + '",');
    Add('            "Title":"' + NameRec.Title + '",');
    Add('            "FirstName":"' + NameRec.First + '",');
    Add('            "LastName":"' + NameRec.Last + '",');
    Add('            "Email":"' + NameRec.First + '@nowhere.com.au",');
    Add('            "Phone":"07 5555 5555",');
    Add('            "Faxnumber":"07 5555 5555",');
    Add('            "Mobile":"0405 555555",');
    Add('            "Street":"Unit 12",');
    Add('            "Street2":"Level 3",');
    Add('            "Street3":"12 Main Street",');
    Add('            "Suburb":"SURFERS PARADISE",');
    Add('            "Postcode":"4217",');
    Add('            "State":"QLD",');
    Add('            "Country":"Australia"');
    Add('        }');
    Add('    },');
    Add('    "Lines":[');
    Add('    {');
    Add('        "type":"TLeadLines",');
    Add('        "fields":');
    Add('        {');
    Add('            "ActionTypeName":"Follow-up",');
    Add('            "ActionDate":"' + FormatDateTime('yyyy-mm-dd',now) + '",');
    Add('            "CreatedBy":"' + rep + '",');
    Add('            "EmployeeName":"' + rep + '",');
    Add('            "Notes":"Please contact me for a demonstration of ERP software."');
    Add('        }');
    Add('    }]');
    Add('    }');
    Add('}');
  end;
end;

procedure TfmWebAPITest.mnuExampleWithOptionsClick(Sender: TObject);
begin
  inherited;
  with memRequest.Lines do begin
    Clear;
    Add('with Field Names : erpapi/TProductWeb?PropertyList="chartname,chartgroup,active');
    Add('With field Names and ID Filter : erpapi/TProductWeb/1?PropertyList="chartname,chartgroup,active');
    Add('With field Names and ID Filter : erpapi/TProductWeb/1?PropertyList="chartname,chartgroup,active');
    Add('With Multiple Conditions : erpapi/BalanceSheetReport?&datefrom=''2021-01-01''&DateTo=''2022-01-01''');
    Add('Where Clause:  erpapi/T_VS1_Report_Productmovement?select=[ProductID]=''286''');
  end;
end;

procedure TfmWebAPITest.mnuGetCustomerListClick(Sender: TObject);
begin
  inherited;
  AddClassToURL('TCustomer');
  with memRequest.Lines do begin
    Clear;
  end;
  DoRequest('GET');
end;

procedure TfmWebAPITest.mnuGetInternalSalesOrderListClick(Sender: TObject);
begin
  inherited;
  AddClassToURL('TSalesOrder?select=[IsInternalOrder]=true');
  memRequest.Lines.Clear;
  DoRequest('GET');
end;

procedure TfmWebAPITest.mnuGetInvoiceListClick(Sender: TObject);
begin
  inherited;
  AddClassToURL('TInvoice');
  with memRequest.Lines do begin
    Clear;
  end;
  DoRequest('GET');
end;

procedure TfmWebAPITest.mnuGetProductListClick(Sender: TObject);
begin
  inherited;
  AddClassToURL('TProductWeb');
  with memRequest.Lines do begin
    Clear;
  end;
  DoRequest('GET');
end;

procedure TfmWebAPITest.mnuGetProductPictureListClick(Sender: TObject);
begin
  inherited;
  AddClassToURL('TProductJPGPicture');
  with memRequest.Lines do begin
    Clear;
  end;
  DoRequest('GET');
end;

procedure TfmWebAPITest.mnuGetQuoteListClick(Sender: TObject);
begin
  inherited;
  AddClassToURL('TQuote');
  with memRequest.Lines do begin
    Clear;
  end;
  DoRequest('GET');
end;

procedure TfmWebAPITest.mnuGetSalesOrderListClick(Sender: TObject);
begin
  inherited;
  AddClassToURL('TSalesOrder');
  with memRequest.Lines do begin
    Clear;
  end;
  DoRequest('GET');
end;

procedure TfmWebAPITest.mnuGetSupportLogListClick(Sender: TObject);
begin
  inherited;
  AddClassToURL('TPhoneSupportLog');
  with memRequest.Lines do begin
    Clear;
  end;
  DoRequest('GET');
end;

procedure TfmWebAPITest.mnuGetTaskListClick(Sender: TObject);
begin
  inherited;
  AddClassToURL('TTasks');
  with memRequest.Lines do begin
    Clear;
  end;
  DoRequest('GET');
end;

procedure TfmWebAPITest.mnuMoreClick(Sender: TObject);
begin
  inherited;
  btnHelp.Click;
end;

procedure TfmWebAPITest.mnuPrintInvoiceClick(Sender: TObject);
begin
  inherited;
  AddClassToURL('TFunc_Print');
  with memRequest.Lines do begin
    Clear;
    Add('{');
    Add('  "TemplateName":"Invoice",');
    Add('  "ReportType":"Invoice",');
    Add('  "ID":'+ IntToStr(GetLastInvoiceNumber));
//    Add('  "FileType":"PDF"');
    Add('}');
  end;
end;

procedure TfmWebAPITest.OpenReport;
var
  json: TJsonObject;
  MIMEDecoder: TIdDecoderMIME;
  stream: TFileStream;
  aFileName: string;

  procedure SearchForReport(obj: TJsonObject);
  var
    I, x: integer;
    s: string;
  begin
    for I := 0 to obj.Count -1 do begin
      if (obj[I].Value is TJsonString) and SameText(obj[I].Name, 'MimeEncodedFile') then begin
        s:= '';
        if obj.StringExists('TemplateName') then s := obj.S['TemplateName'];
        if obj.StringExists('FileExt') then begin
          if s <> '' then s := s + ' ';

          s := s + '(' + obj.S['FileExt'] + ')';
        end
        else
          continue;
        if CommonLib.MessageDlgXP_Vista('Would you like to view the returned report '+s+' ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
          aFileName := GetTempFileName('','.' + obj.S['FileExt']);
          MIMEDecoder := TIdDecoderMIME.Create(nil);
          stream := TFileStream.Create(aFileName, fmCReate);
          try
            MIMEDecoder.DecodeBegin(stream);
            try
              MIMEDecoder.Decode(obj.S['MimeEncodedFile']);
            finally
              MIMEDecoder.DecodeEnd;
            end;
          finally
            stream.Free;
            MIMEDecoder.Free;
          end;
          ShellExecute(Handle, 'Open', PChar(aFileName),
            '', '', SW_SHOWNORMAL);
        end;
      end
      else if (obj[I].Value is TJsonObject) then begin
        SearchForReport(obj[I].Value.AsObject);
      end
      else if (obj[I].Value is TJsonArray) and (TJsonArray(obj[I].Value).Count > 0) then begin
        for x := 0 to TJsonArray(obj[I].Value).Count -1 do begin
          if TJsonArray(obj[I].Value)[x].IsTypeObject then
            SearchForReport(TJsonArray(obj[I].Value)[x].AsObject);
        end;
      end;
    end;
  end;

begin
  json := JO;
  try
    try
      json.AsString := memResponce.Text;
      SearchForReport(json);
    except
    end;
  finally
    json.Free;
  end;
end;

procedure TfmWebAPITest.ransactionJournal1Click(Sender: TObject);
var
  aClientName:String;
begin
  inherited;
  aClientName:= TClientListGUI.SelectAclient(False);
  AddClassToURL('TTransactionListReport'+
                '?DateFrom="' + FormatDateTime(mysqldateformat , incyear(date, -1))+'"'+
                '&DateTo="' + FormatDateTime(mysqldatetimeformat , IncSecond(incmonth(date, 1),-1))+'"'+
                iif(trim(aClientName)<>'', '&ClientName="'+aClientName+'"', ''));
  with memRequest.Lines do begin
    Clear;
  end;
  DoRequest('GET');
end;

procedure TfmWebAPITest.AddClassToURL(aClassName: string);
var
  url, http, svr: string;
  x: integer;
begin
  http:= '';
  svr:= '';
  url:= cboURL.Text;
  x:= Pos('//',url);
  if x > 0 then begin
    http:= copy(url,1,x+1);
    url:= Copy(url,Length(http)+1, Length(url));
    x:= Pos('/',url);
    if x > 0 then begin
      svr:= Copy(url,0,x-1);

    end;
  end;
  if (http <> '') and (svr <> '') then
    cboURL.Text:= http + svr + '/erpapi/' + aClassName
end;

procedure TfmWebAPITest.BalanceSheet1Click(Sender: TObject);
begin
  inherited;
  AddClassToURL('BalanceSheetReport');
  with memRequest.Lines do begin
    Clear;
  end;
  DoRequest('GET');
end;

procedure TfmWebAPITest.btnbackuprestoreClick(Sender: TObject);
begin
  inherited;
  edtUser.text := ERP_CLOUD_ADMIN_USER;
  edtPass.text := ERP_CLOUD_ADMIN_TOKEN;
  edtDatabase.text := VS1ClientdbDBName;
  memRequest.Lines.clear;
  case MessageDlgXP_Vista('Backup / Backup list / Restore', mtConfirmation, [], 0 , nil , '' , '' , False, nil , 'Backup,Backup list,Restore') of
    100: begin
        AddClassToURL('VS1_Cloud_Task/Method?Name=VS1_DatabaseBackup');
        memRequest.Lines.Add('"jsonin":{');
        memRequest.Lines.Add('   "name":"VS1_DatabaseBackup",');
        memRequest.Lines.Add('"databasename":"aus_sample_company"');
        memRequest.Lines.Add('}');
    end;
    101: begin
        AddClassToURL('VS1_Cloud_Task/Method?Name=VS1_BackupList');
        memRequest.Lines.clear;
        memRequest.Lines.Add('"jsonin":{');
        memRequest.Lines.Add('   "name":"VS1_BackupList",');
        memRequest.Lines.Add('   "databasename":"aus_sample_company",');
        memRequest.Lines.Add('   "AllDBBackups":true');
        memRequest.Lines.Add('}');
    end;
    102: begin
        AddClassToURL('VS1_Cloud_Task/Method?Name=VS1_DatabaseRestore');
        memRequest.Lines.clear;
        memRequest.Lines.Add('"jsonin":{');
        memRequest.Lines.Add('   "name":"VS1_DatabaseRestore",');
        memRequest.Lines.Add('   "params":{');
        memRequest.Lines.Add('      "ArchiveName":"aus_sample_company_2022.2.1.0_Backup_2022-03-08_20-55.7z",');
        memRequest.Lines.Add('      "BackupFirst":true,');
        memRequest.Lines.Add('      "databasename":"aus_sample_company"');
        memRequest.Lines.Add('   }');
        memRequest.Lines.Add('}');
    end;
  end;
end;

procedure TfmWebAPITest.btnChangeDatabaseClick(Sender: TObject);
var
  dbname:STring;
begin
  inherited;
  btnErpAdminCred.click;
  memRequest.lines.clear;
(*  memRequest.lines.add('{');
  memRequest.lines.add('"'+ TAG_JsonIN +'":');
  memRequest.lines.add('{');
  memRequest.lines.add('"'+TAG_MethodName+'":"'+TASK_VS1_ChangeDatabase+'",');
  memRequest.lines.add('"'+TAG_CLOUD_Params+'":');
  memRequest.lines.add('{');
  memRequest.lines.add('"'+VS1_TAG_ServerName   +'":"Holie-PC",');
  memRequest.lines.add('"'+VS1_TAG_DatabaseName +'":"asahi_diamonds_industrial_australia",');
  memRequest.lines.add('"'+VS1_TAG_DatabaseNameToChange +'":"VS1_Cloud_DB_cacb_ab_bb_Ne9Lpj",');
  memRequest.lines.add('"'+VS1_TAG_VS1UserName  +'":"Asahi",');
  memRequest.lines.add('"'+VS1_TAG_VS1Password  +'":"Diamonds",');
  memRequest.lines.add('"'+VS1_TAG_APIPort      +'":443,');
  memRequest.lines.add('"'+VS1_TAG_HTTPS        +'":true,');
  memRequest.lines.add('"'+VS1_TAG_EmployeeDetails+'":');
  memRequest.lines.add('{');
  memRequest.lines.add('"'+VS1_TAG_FirstName   +'":"Admin",');
  memRequest.lines.add('"'+VS1_TAG_Lastname   +'":".",');
  memRequest.lines.add('"'+VS1_TAG_PhoneNumber   +'":"34478957345389"');
  memRequest.lines.add('}');
  memRequest.lines.add('}');
  memRequest.lines.add('}');
  memRequest.lines.add('}');*)

  memRequest.lines.add('{');
  memRequest.lines.add('"'+TAG_MethodName+'":"'+TASK_VS1_ChangeDatabase+'",');
  memRequest.lines.add('"'+TAG_CLOUD_Params+'":');
  memRequest.lines.add('{');
  //memRequest.lines.add('"'+VS1_TAG_ServerName           +'":"'+inputBox('New Server :' ,'' ,'Hollie-PC')+'",');
  //dbname := inputBox('New Database :' ,'' ,'asahi_diamonds_industrial_australia');
  memRequest.lines.add('"'+VS1_TAG_ServerName           +'":"'+inputBox('New Server :' ,'' ,'110.142.175.245')+'",');
  dbname := inputBox('New Database :' ,'' ,'ERP_Company');
  memRequest.lines.add('"'+VS1_TAG_DatabaseName         +'":"'+dbname+'",');
  memRequest.lines.add('"'+VS1_TAG_DatabaseNameToChange +'":"'+inputBox('Database to Drop :' ,'' ,'')+'",');
  memRequest.lines.add('"'+VS1_TAG_VS1UserName          +'":"'+inputBox('Existing ERP User in New Database :' ,'' ,'Admin')+'",');
  memRequest.lines.add('"'+VS1_TAG_VS1Password          +'":"'+inputBox('Existing ERP Password in New Database :' ,'' ,'Admin')+'",');
  memRequest.lines.add('"'+VS1_TAG_APIPort              +'":'+inputBox('API Port of New Database :' ,'' ,'888')+',');
  memRequest.lines.add('"'+VS1_TAG_HTTPS                +'":'+inputBox('HTTPs New Database :' ,'' ,'false')+',');
  memRequest.lines.add('"'+VS1_TAG_EmployeeDetails+'":');
  memRequest.lines.add('{');
  memRequest.lines.add('"'+VS1_TAG_FirstName   +'":"'+inputBox('Firstname:' ,'', copy(dbname,1,20) )+'",');
  memRequest.lines.add('"'+VS1_TAG_Lastname    +'":"'+inputBox('lastname:' ,'', copy(dbname,1,10) )+'",');
  memRequest.lines.add('"'+VS1_TAG_PhoneNumber +'":"457345437853",');
  memRequest.lines.add('"'+VS1_TAG_DateStarted +'":"2021-01-01",');
  memRequest.lines.add('"'+VS1_TAG_DOB +'":"2021-01-01",');
  memRequest.lines.add('"'+VS1_TAG_Sex +'":"F",');
  memRequest.lines.add('"'+VS1_TAG_Email +'":"vv@vv.com",');
  memRequest.lines.add('"'+VS1_TAG_EmailsFromEmployeeAddress +'":false');
  memRequest.lines.add('},');
  memRequest.lines.add('"'+VS1_TAG_ERPLoginDetails+'":');
  memRequest.lines.add('{');
  memRequest.lines.add('"'+VS1_TAG_FirstName   +'":"'+inputBox('VS1 License username for new USer:' ,'', copy(dbname,1,20) )+'",');
  memRequest.lines.add('"'+VS1_TAG_Lastname    +'":"'+inputBox('VS1 License Password for new USer:' ,'', copy(dbname,1,10) )+'",');
  memRequest.lines.add('}');
  memRequest.lines.add('}');
  memRequest.lines.add('}');
  memRequest.lines.add('}');
  AddClassToURL('VS1_Cloud_Task/Method?Name="'+TASK_VS1_ChangeDatabase+'"');
end;

procedure TfmWebAPITest.btnCloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfmWebAPITest.btncoreEDiClick(Sender: TObject);
begin
  inherited;
  cboURL.Text := 'https://110.145.181.218:4433/erpapi/'
end;

procedure TfmWebAPITest.btnExamplesClick(Sender: TObject);
var
  p: TPoint;
begin
  inherited;
  p.X:= 0;
  p.Y:= 0;
  p:= memRequest.ClientToScreen(p);
  self.MenuExamples.Popup(p.X + 20, p.Y + 20);
end;

procedure TfmWebAPITest.btnGetClick(Sender: TObject);
var
  dt: TDateTime;
begin
  inherited;
  lblProcess.caption := '';
  dt := Now;
  try
    Processingcursor(True);
    try
      Self.memResponce.Lines.clear;
      Self.memResult.Lines.Text := 'Result Code:';
      Application.ProcessMessages;
      DoRequest('GET');
    finally
      Processingcursor(False);
    end;
  finally
    lblProcess.caption := FormatSeconds(secondsBetween(now,dt))
  end;
end;

procedure TfmWebAPITest.btnHelpClick(Sender: TObject);
begin
  inherited;
  ShellExecute(0,'open',PChar('http://www.trueerp.com/wiki/Web_API'),nil,nil,SW_NORMAL)
end;

procedure TfmWebAPITest.btnPostClick(Sender: TObject);
var
  dt:TDateTime;
begin
  inherited;
  lblProcess.caption := '';
  dt:= now;
  try
    Processingcursor(True);
    try
        self.memResponce.Lines.clear;
        self.memResult.Lines.Text := 'Result Code:';
        Application.ProcessMessages;
        DoRequest('POST');
    finally
        Processingcursor(False);
    end;
  finally
    lblProcess.caption := FormatSeconds(secondsBetween(now,dt))
  end;
end;

procedure TfmWebAPITest.btnRepeatApptClick(Sender: TObject);
begin
  inherited;
  memRequest.lines.clear;
  memRequest.lines.add('"'+ TAG_JsonIN +'":{');
  memRequest.lines.add('"'+ TAG_MethodName +'":"'+TASK_VS1_RepeatAppointment+'",');
  memRequest.lines.add('"'+ TAG_CLOUD_Params +'":{');
  memRequest.lines.add('   "' + VS1_TAG_CloudUserName +'":"' + inputBox('User name :'   ,'' ,'')+'",');
  memRequest.lines.add('   "' + VS1_TAG_CloudPassword +'":"' + inputBox('Password :'   ,'' ,'')+'",');
  memRequest.lines.add('"'+VS1_TAG_AppointID+'":'+ inttostr(ChooseAptID)+',');
  memRequest.lines.add('"'+VS1_TAG_Repeat_Frequency+'":1,');
  memRequest.lines.add('"'+VS1_TAG_Repeat_Period+'":0,');
  memRequest.lines.add('"'+VS1_TAG_Repeat_BaseDate+'":"'+ formatdatetime(mysqldateformat, incday(date,10)) +'",');
  memRequest.lines.add('"'+VS1_TAG_Repeat_FinalDate+'":"'+ formatdatetime(mysqldateformat, incday(date,20)) +'",');
  memRequest.lines.add('"'+VS1_TAG_Repeat_Saturday+'":0,');
  memRequest.lines.add('"'+VS1_TAG_Repeat_sunday+'":0,');
  memRequest.lines.add('"'+VS1_TAG_Repeat_Monday+'":0,');
  memRequest.lines.add('"'+VS1_TAG_Repeat_Tuesday+'":0,');
  memRequest.lines.add('"'+VS1_TAG_Repeat_Wednesday+'":0,');
  memRequest.lines.add('"'+VS1_TAG_Repeat_Thursday+'":0,');
  memRequest.lines.add('"'+VS1_TAG_Repeat_Friday+'":0,');
  memRequest.lines.add('"'+VS1_TAG_Repeat_holiday+'":0,');
  memRequest.lines.add('"'+VS1_TAG_Repeat_Weekday+'":0,');
  memRequest.lines.add('"'+VS1_TAG_Repeat_MonthOffset+'":0');

  memRequest.lines.add('    }');
  memRequest.lines.add('}');
  memRequest.lines.add('}');
  AddClassToURL('VS1_Cloud_Task/Method?Name="'+TASK_VS1_RepeatAppointment+'"');
  highlightcontrol(btnPost);

end;
Procedure TfmWebAPITest.OnSelectChooseAptID(Sender: TwwDbGrid);
begin
  try
      fiAptID := Sender.datasource.dataset.findfield('AppointID').asInteger;
  Except
    on E:Exception do begin

    end;
  end;
end;
Function TfmWebAPITest.ChooseAptID:Integer;
begin
  fiAptID:=0;
  OpenERPListFormSingleselectModal('TAppointmentListGUI' , OnSelectChooseAptID, nil,true);
  result := fiAptID;
end;
procedure TfmWebAPITest.btnRESTClientClick(Sender: TObject);
begin
  inherited;
  ShellExecute(0,'open',PChar('https://chrome.google.com/webstore/detail/advanced-rest-client/hgmloofddffdnphfgcellkdfbfbjeloo'),nil,nil,SW_NORMAL)
end;

procedure TfmWebAPITest.btnupdatecomppreClick(Sender: TObject);
begin
  inherited;
  memRequest.lines.clear;
  memRequest.lines.add('"'+ TAG_JsonIN +'":{');
  memRequest.lines.add('"'+ TAG_MethodName +'":"'+TASK_VS1_UpdateCompPref+'",');
  memRequest.lines.add('"'+ TAG_CLOUD_Params +'":{');
  memRequest.lines.add('   "' + VS1_TAG_CloudUserName +'":"' + inputBox('User name :'   ,'' ,'')+'",');
  memRequest.lines.add('   "' + VS1_TAG_CloudPassword +'":"' + inputBox('Password :'   ,'' ,'')+'",');
  memRequest.lines.add('   "'+VS1_TAG_CompanyPreferenceList+'":[');
  memRequest.lines.add('{"Name":"ShowSundayinApptCalendar","FieldValue":"F"},');
  memRequest.lines.add('{"Name":"ShowMondayinApptCalendar","FieldValue":"T"},');
  memRequest.lines.add('{"Name":"ShowTuesdayinApptCalendar","FieldValue":"T"},');
  memRequest.lines.add('{"Name":"ShowWednesdayinApptCalendar","FieldValue":"T"},');
  memRequest.lines.add('{"Name":"ShowThursdayinApptCalendar","FieldValue":"T"},');
  memRequest.lines.add('{"Name":"ShowFridayinApptCalendar","FieldValue":"T"},');
  memRequest.lines.add('{"Name":"ShowSaturdayinApptCalendar","FieldValue":"F"},');
  memRequest.lines.add('{"Name":"ApptStartTime"               , "Fieldvalue":"08:30 AM"},');
  memRequest.lines.add('{"Name":"ApptEndtime"                 , "Fieldvalue":"05:30 PM"},');
  memRequest.lines.add('{"Name":"DefaultApptDuration"         , "Fieldvalue":"120"},');
  memRequest.lines.add('{"Name":"RoundApptDurationTo"         , "FieldValue":"30"},');
  memRequest.lines.add('{"Name":"ShowApptDurationin"          , "Fieldvalue":"60"},');
  memRequest.lines.add('{"Name":"DefaultServiceProduct"       , "Fieldvalue":"Labour"},');
  memRequest.lines.add('{"Name":"MinimumChargeAppointmentTime", "Fieldvalue":"0"}');
  memRequest.lines.add('    ]');
  memRequest.lines.add('}');
  memRequest.lines.add('}');
  AddClassToURL('VS1_Cloud_Task/Method?Name="'+TASK_VS1_UpdateCompPref+'"');
  highlightcontrol(btnPost);

end;

function TfmWebAPITest.CheckDBUser(UserName, aDatabase: string): string;
var
  qry: TERPQuery;
  conn: TERPConnection;
begin
  result:= '';
  if aDatabase = '' then exit;
  
  conn:= CommonDbLib.GetNewMyDacConnection(nil);
  qry:= TERPQuery.Create(nil);
  try
    conn.Disconnect;
    conn.Database := aDatabase;
    try
      conn.Connect;
      qry.Connection := conn;
      qry.SQL.Add('select * from tblPassword where Logon_Name = ' + QuotedStr(UserName));
      qry.Open;
      if not qry.IsEmpty then
        result := DeCrypt(qry.FieldByName('Logon_Password').AsString, 'z');
    except
      on e: exception do begin
        MessageDlgXP_Vista('Error connecting to database "' + aDatabase + '": ' + e.Message,
          mtWarning,[mbOk],0);
      end;
    end;
  finally
    qry.Free;
    conn.Free;
  end;
end;

procedure TfmWebAPITest.CheckSettings(CheckServer: boolean);
var
  json: TJsonObject;
  msg: string;
  aDatabase, aPassword: string;
  aPort: integer;

  function CheckApiConfig(ApiConfig: TJsonObject): boolean;
  begin
    result := true;
    if ApiConfig.B['UseSSL'] and (ApiConfig.I['DefaultSSLPort'] = 0) then begin
      MessageDlgXP_Vista('The Server SSL Port is not set on the WebAPI Module ' +
        'that you are connected to (' + AppEnv.AppDb.Server + ').' + #13#10 + #13#10 +
        'You will not be able to communicate with the WebAPI.', mtWarning,[mbOk],0);
      result := false;
      exit;
    end
    else if (ApiConfig.I['DefaultPort'] = 0) then begin
      MessageDlgXP_Vista('The Server Port is not set on the WebAPI Module ' +
        'that you are connected to (' + AppEnv.AppDb.Server + ').' + #13#10 + #13#10 +
        'You will not be able to communicate with the WebAPI.', mtWarning,[mbOk],0);
      result := false;
      exit;
    end;
    if (ApiConfig.S['WebUserName'] = '') then begin
      MessageDlgXP_Vista('The Web User Name is not set on the WebAPI Module ' +
        'that you are connected to (' + AppEnv.AppDb.Server + ').' + #13#10 + #13#10 +
        'You will not be able to communicate with the WebAPI.', mtWarning,[mbOk],0);
      result := false;
      exit;
    end;
    if not ApiConfig.B['Active'] then begin
      MessageDlgXP_Vista('The WebAPI Module is not Active (not running) on the Server ' +
        'that you are connected to (' + AppEnv.AppDb.Server + ').' + #13#10 + #13#10 +
        'You will not be able to communicate with the WebAPI.', mtWarning,[mbOk],0);
    end
  end;

begin
  if FormClosing then Exit;

  if IgnorecheckSettings then Exit;

  if (cboURL.Text = '') then begin
    try
      { no url specified so use currently connected server }
      if not ModuleInstalled(AppEnv.AppDb.Server, 'ERPWebService') then begin
        MessageDlgXP_Vista('The WebAPI Module is not installed on the ERP Server ' +
          'that you are connected to (' + AppEnv.AppDb.Server + ').', mtWarning,[mbOk],0);
        exit;
      end;
    except
      on e: exception do begin
        MessageDlgXP_Vista('Unable to connect to the ERP Utilities Service on your server ' +
          '(' + AppEnv.AppDb.Server + ').' + #10#10 + 'The error was:' + #13#10 +
          e.Message, mtWarning,[mbOk],0);
        exit;
      end;
    end;
    json:= JO;
    try
      if GetWebAPIConfig(AppEnv.AppDb.Server,json,msg) then begin
        if not CheckApiConfig(json) then exit;
        if edtUser.Text = '' then begin
          { user not set so set it  }
          edtUser.Text := json.S['WebUserName'];
          Config.S['ERPUserName']:= edtUser.Text;
          SaveConfig;
        end;
        { check database .. }
        if edtDatabase.Text = '' then begin
          { datbasae not set }
          if frmPopupSelect.SelectDatabase(aDatabase) then begin
            edtDatabase.Text := aDatabase;
            Config.S['ERPDatabase']:= edtDatabase.Text;
            SaveConfig;
          end;
        end;
        if edtDatabase.Text <> '' then begin
          aPassword := CheckDBUser(Config.S['ERPUserName'], edtDatabase.Text);
          if aPassword <> '' then begin
            edtPass.Text := aPassword;
            Config.S['ERPUserPassword']:= edtPass.Text;
            SaveConfig;
          end
          else begin
            MessageDlgXP_Vista('There is no user (' + Config.S['ERPUserName'] +
              ') configured for the Database (' + edtDatabase.Text +
              ') on your server, the WebAPI Module will not be able to process your requests.',
              mtWarning,[mbOk],0);
            exit;
          end;
        end
        else begin
          MessageDlgXP_Vista('Database is blank, the WebAPI Module will not be able to process your requests.',
            mtInformation,[mbOk],0);
          exit;
        end;
      end
      else begin
        MessageDlgXP_Vista('Unable to read WebAPI Module configuration information.' + #13#10 +#13#10 +
          'Returned error:' + #13#10 + msg, mtWarning, [mbOk],0);
        exit;
      end;

      { now build the url }
      if json.B['UseSSL'] then
        cboURL.Text := 'https://' + AppEnv.AppDb.Server + ':' + IntToStr(json.I['DefaultSSLPort'])
      else
        cboURL.Text := 'http://' + AppEnv.AppDb.Server + ':' + IntToStr(json.I['DefaultPort']);
      cboURL.Text := cboURL.Text + '/erpapi/';
      lblPort.Caption := 'Port: ' + IntToStr(Port);

    finally
      json.Free;
    end;
  end
  else begin
    if CheckServer and (not SameText(AppEnv.AppDb.Server,ExtractServer(cboURL.Text))) then begin
      { ask user if they want to chage URL to match current server }
      if MessageDlgXP_Vista('The server listed in the Request URL (' + Server + '), ' +
        'does not match the server ERP is connected to (' +  AppEnv.AppDb.Server + '), ' +
        'would you like to change this to match your ERP Server?', mtConfirmation, [mbYes, mbNo],0) = mrYes then begin
        Server := AppEnv.AppDb.Server;
      end;
    end;
    if SameText(AppEnv.AppDb.Server, Server) then begin
      { check all other settings }
      try
        { no url specified so use currently connected server }
        if not ModuleInstalled(AppEnv.AppDb.Server, 'ERPWebService') then begin
          MessageDlgXP_Vista('The WebAPI Module is not installed on the ERP Server ' +
            'that you are connected to (' + AppEnv.AppDb.Server + ').', mtWarning,[mbOk],0);
          exit;
        end;
      except
        on e: exception do begin
          MessageDlgXP_Vista('Unable to connect to the ERP Utilities Service on your server ' +
            '(' + AppEnv.AppDb.Server + ').' + #10#10 + 'The error was:' + #13#10 +
            e.Message, mtWarning,[mbOk],0);
          exit;
        end;
      end;

      json:= JO;
      try
        if GetWebAPIConfig(AppEnv.AppDb.Server, json,msg) then begin
          if not CheckApiConfig(json) then exit;

          if not SameText(edtUser.Text, json.S['WebUserName']) then begin
            if MessageDlgXP_Vista('Do you want to change the User Name to match the Web User Name ' +
              'set in the WebAPI Module configuration (' + json.S['WebUserName'] + ')?',
              mtConfirmation, [mbYEs,mbNo],0) = mrYes then begin
              edtUser.Text := json.S['WebUserName'];
              Config.S['ERPUserName']:= edtUser.Text;
              SaveConfig;
            end;
          end;

          if not SameText(edtDatabase.Text, appEnv.AppDb.Connection.Database) then begin
            if MessageDlgXP_Vista('Do you want to change the Database to match ' +
              'the ERP Database you are currently logged in to?',
              mtConfirmation, [mbYes,mbNo],0) = mrYes then begin
              edtDatabase.Text := appEnv.AppDb.Connection.Database;
              Config.S['ERPDatabase']:= edtDatabase.Text;
              SaveConfig;
            end;
          end;

          aPassword := CheckDBUser(edtUser.Text, edtDatabase.Text);
          if aPassword = '' then begin
            if MessageDlgXP_Vista('Could not find the user (' + json.S['WebUserName'] + ') ' +
              'in the database (' + edtDatabase.Text + '), would you like to select a different database?',
              mtConfirmation, [mbYes,mbNo],0) = mrYes then begin
             if frmPopupSelect.SelectDatabase(aDatabase) then begin
               edtDatabase.Text := aDatabase;
               Config.S['ERPDatabase']:= edtDatabase.Text;
               SaveConfig;
               CheckSettings(false);
               exit;
             end
             else
               exit;
            end;
          end
          else begin
            if not SameText(aPassword,edtPass.Text) then begin
//              if MessageDlgXP_Vista('Do you want to change the Password to match the Password (' +
//                aPassword + ') for the database (' + edtDatabase.Text + ')?', mtConfirmation,
//                [mbYEs,mbNo],0) = mrYes then begin
//                edtPass.Text := aPassword;
//                Config.S['ERPUserPassword']:= edtPass.Text;
//                SaveConfig;
//              end;
              MessageDlgXP_Vista('Warning, the Password does not match the Password ' +
                'for the database (' + edtDatabase.Text + ').', mtInformation,
                [mbOk],0);
            end;
          end;

          if json.B['UseSSL'] then
            aPort := json.I['DefaultSSLPort']
          else
            aPort := json.I['DefaultPort'];

          { check SSL and Port }
          if (UseSSL <> json.B['UseSSL']) or (Port <> aPort) then begin
            if MessageDlgXP_Vista('Do you want to change the Request URL to match the ' +
              'Security (SSL) and Port settings of the WebAPI Module?',mtConfirmation, [mbYes,mbNo],0) = mrYes then begin
              UseSSL:= json.B['UseSSL'];
              Port:= aPort;
            end;
          end;
        end;

      finally
        json.Free;
      end;
    end;
  end;

end;

procedure TfmWebAPITest.chkFormatJsonClick(Sender: TObject);
begin
  inherited;
  if Config.B['FormatJSON'] <> chkFormatJSON.Checked  then begin
    Config.B['FormatJSON']:= chkFormatJSON.Checked;
    SaveConfig;
  end;
end;

function TfmWebAPITest.ConnectToUtilsModule(Client: TJsonRpcTcpClient; Server,
  ModuleName: string; var msg: string): boolean;
//var
//  o, resp: TJsonObject;
begin
  Result := True;
  Client.ServerName := Server;
  Client.Port := DEFAULT_TCP_PORT;   { use default }
  try
    Client.Connected := True;
  except
    on e: exception do begin
      Result := False;
      msg := e.Message;
      Exit;
    end;
  end;

//  o:= JO;
//  o.S['sessiontype']:= 'config';
//
//  resp:= Client.SendRequest(ModuleName + '.StartSession',o);
//  if Assigned(resp) then begin
//    try
//      if resp.StringExists('result') and (resp.S['result'] = 'ok') then begin
//        { All Good! }
//
//      end
//      else begin
//        { failed to establisg a session }
//        result:= false;
//        Client.Connected:= false;
//        msg:= 'Invalid responce to the Start Session request.';
//      end;
//    finally
//      resp.Free;
//    end;
//  end
//  else begin
//    result:= false;
//    msg:= 'The Module did not respond to a Start Session request.';
//  end;
end;

procedure TfmWebAPITest.btnvs1credentisalClick(Sender: TObject);
begin
  inherited;
  edtUser.text := ERP_CLOUD_ADMIN_USER;
  edtPass.text := ERP_CLOUD_ADMIN_TOKEN;
  edtDatabase.text :=  VS1_Admin_DB_Sandbox;
end;

procedure TfmWebAPITest.btnVS1renewClick(Sender: TObject);
begin
  inherited;
  btnvs1credentisal.click;
  AddClassToURL('VS1_Cloud_Task/Method?Name="VS1_Renew"');
  btnvs1credentisal.click;
  memRequest.lines.clear;
  memRequest.lines.add('"'+ TAG_JsonIN +'":{');
  memRequest.lines.add('"'+ TAG_MethodName +'":"VS1_Renew",');
  memRequest.lines.add('"'+ TAG_CLOUD_Params +'":{');
  memRequest.lines.add('   "' + VS1_TAG_CloudUserName +'":"' + inputBox('User name :'   ,'' ,'')+'",');
  memRequest.lines.add('   "' + VS1_TAG_CloudPassword +'":"' + inputBox('Password :'   ,'' ,'')+'",');
  memRequest.lines.add('   "'+VS1_TAG_Paymentamount+'":900,');
  memRequest.lines.add('   "'+VS1_TAG_PayMethod+'":"Cash",');

  memRequest.lines.add('}');
  memRequest.lines.add('}');
  highlightcontrol(btnPost);
end;

procedure TfmWebAPITest.DNMSpeedButton10Click(Sender: TObject);
begin
  inherited;
  memRequest.lines.clear;
  memRequest.lines.add('            { ');
  memRequest.lines.add('               "type":"TStSStrain",');
  memRequest.lines.add('               "fields":{');
  memRequest.lines.add('                  "CBD_Content":62,');
  memRequest.lines.add('                  "Indica":82,');
  memRequest.lines.add('                  "ISEmpty":false,');
  memRequest.lines.add('                  "KeyValue":"",');
  memRequest.lines.add('                  "Sativa":63,');
  memRequest.lines.add('                  "Strainname":"Cannabis",');
  memRequest.lines.add('                  "Tested":true,');
  memRequest.lines.add('                  "TestedBy":"Metrc",');
  memRequest.lines.add('                  "TestedInHouse":true,');
  memRequest.lines.add('                  "THC_Content":38,');
  if MessageDlgXP_Vista('Use Default Productname? ', mtConfirmation, [mbYes, mbNo], 0) = mryes then begin
    memRequest.lines.add('                  "CreateDefaultProducts":true,');
  end else begin
    memRequest.lines.add('                  "ImmatureProductName":"I-Cannabis",');
    memRequest.lines.add('                  "VegetativeProductName":"V-Cannabis",');
    memRequest.lines.add('                  "FloweringProductName":"F-Cannabis",');
    memRequest.lines.add('                  "HarvestProductName":"H-Cannabis",');
    memRequest.lines.add('               }}');
  end;

  AddClassToURL('TStsStrain');
  highlightcontrol(btnPost);

end;

procedure TfmWebAPITest.DNMSpeedButton11Click(Sender: TObject);
begin
  inherited;
  memRequest.lines.clear;
  memRequest.lines.add('            {');
  memRequest.lines.add('               "type":"TDeptClass",');
  memRequest.lines.add('               "fields":{');
  memRequest.lines.add('                  "Active":true,');
  memRequest.lines.add('                  "AutoCreateRepair":false,');
  memRequest.lines.add('                  "AutoCreateSmartOrder":false,');
  memRequest.lines.add('                  "Country":"",');
  memRequest.lines.add('                  "DeptClassGroup":"",');
  memRequest.lines.add('                  "DeptClassName":"STS Store-4",');
  memRequest.lines.add('                  "Description":"",');
  memRequest.lines.add('                  "Level1":"STS Store-4",');
  memRequest.lines.add('                  "Level2":"",');
  memRequest.lines.add('                  "Level3":"",');
  memRequest.lines.add('                  "Level4":"",');
  memRequest.lines.add('                  "LocationCode":"",');
  memRequest.lines.add('                  "Postcode":"",');
  memRequest.lines.add('                  "SiteCode":"SS4",');
  memRequest.lines.add('                  "State":"",');
  memRequest.lines.add('                  "Street":"",');
  memRequest.lines.add('                  "Street2":"",');
  memRequest.lines.add('                  "Street3":"",');
  memRequest.lines.add('                  "StSClass":{');
  memRequest.lines.add('                     "type":"TStSClass",');
  memRequest.lines.add('                     "fields":{');
  memRequest.lines.add('                        "DefaultBinLocation":"SS4",');
  memRequest.lines.add('                        "DefaultBinNumber":"1",');
  memRequest.lines.add('                        "LicenseNumber":"45906746",');
  memRequest.lines.add('                        "PrincipleContactName":"dklfjdslfksj",');
  memRequest.lines.add('                        "PrincipleContactPhone":"8734968745"');
  memRequest.lines.add('                        }');
  memRequest.lines.add('                  },');
  memRequest.lines.add('                  "Suburb":"",');
  memRequest.lines.add('                  "TaxCodeName":"",');
  memRequest.lines.add('                  "TaxID":0,');
  memRequest.lines.add('                  "UseAddress":false');
  memRequest.lines.add('               }');
  memRequest.lines.add('            }');

  AddClassToURL('TDeptClass');
  highlightcontrol(btnPost);
end;

procedure TfmWebAPITest.DNMSpeedButton12Click(Sender: TObject);
begin
  inherited;
  memRequest.lines.clear;
  memRequest.lines.add('"'+ TAG_JsonIN +'":');
  memRequest.lines.add('{');
  memRequest.lines.add('"'+ TAG_MethodName +'":"'+TASK_GT_AllocatePlantTag+'"');
  memRequest.lines.add('"'+ TAG_CLOUD_Params +'":{');
  memRequest.lines.add('"'+GT_TAG_StSTag      +'":"'+inputBox('Tag :'   ,'' ,'')+'",');
  memRequest.lines.add('"'+GT_TAG_StrainName  +'":"'+inputBox('StrainName :'   ,'' ,'Cannabis')+'",');
  memRequest.lines.add('"'+GT_TAG_Sourcetype  +'":"'+inputBox('Sourcetype :'   ,'' ,'Seeds')+'",');
  memRequest.lines.add('"'+GT_TAG_Plantcount  +'":'+inputBox('Plantcount :'   ,'' ,'20')+',');
  memRequest.lines.add('"'+GT_TAG_StSPhase    +'":"'+inputBox('Phase :'   ,'' ,'I')+'",');
  memRequest.lines.add('"'+GT_TAG_UsedOn      +'":"2020/11/01",');
  memRequest.lines.add('"'+GT_TAG_RoomLocation+'":"'+inputBox('Location :'   ,'' ,'Room')+'",');
  memRequest.lines.add('"'+GT_TAG_RoomNumber  +'":"'+inputBox('number :'   ,'' ,'1')+'"');
  memRequest.lines.add('}');
  memRequest.lines.add('}');
  AddClassToURL(GT_Cloud_Task+'/Method?Name="'+TASK_GT_AllocatePlantTag+'"');
  highlightcontrol(btnPost);
end;

procedure TfmWebAPITest.DNMSpeedButton13Click(Sender: TObject);
begin
  inherited;
  memRequest.lines.clear;
  memRequest.lines.add('"'+ TAG_JsonIN +'":');
  memRequest.lines.add('{');
  memRequest.lines.add('"'+ TAG_MethodName +'":"'+TASK_GT_ChangeTagPhase+'"');
  memRequest.lines.add('"'+ TAG_CLOUD_Params +'":{');
  memRequest.lines.add('"'+ GT_TAG_StSTag      +'":"'+inputBox('Tag :'   ,'' ,'')+'",');
  memRequest.lines.add('"'+ GT_TAG_StSPhase      +'":"'+inputBox('New Phase :'   ,'' ,'')+'",');
  memRequest.lines.add('"'+ VS1_TAG_DateStarted +'":"2020-01-01",');
  memRequest.lines.add('}');
  memRequest.lines.add('}');
  AddClassToURL(GT_Cloud_Task+'/Method?Name="'+TASK_GT_AllocatePlantTag+'"');
  highlightcontrol(btnPost);

end;

procedure TfmWebAPITest.DNMSpeedButton14Click(Sender: TObject);
begin
  inherited;
  memRequest.lines.clear;
  memRequest.lines.add('"'+ TAG_JsonIN +'":{');
  memRequest.lines.add('"'+ TAG_MethodName +'":"'+TASK_VS1_RepeatAppointment+'",');
  memRequest.lines.add('"'+ TAG_CLOUD_Params +'":{');
  memRequest.lines.add('   "' + VS1_TAG_CloudUserName +'":"' + inputBox('User name :'   ,'' ,'')+'",');
  memRequest.lines.add('   "' + VS1_TAG_CloudPassword +'":"' + inputBox('Password :'   ,'' ,'')+'",');
  memRequest.lines.add('"'+VS1_TAG_AppointID+'":'+ inttostr(ChooseAptID)+',');
  memRequest.lines.add('"'+VS1_TAG_Repeat_Dates+'":[');
  memRequest.lines.add('{"'+VS1_TAG_Dates+'":"' + formatDateTime('yyyy-mm-dd' ,incday(date,1))+'"},');
  memRequest.lines.add('{"'+VS1_TAG_Dates+'":"' + formatDateTime('yyyy-mm-dd' ,incday(date,4))+'"},');
  memRequest.lines.add('{"'+VS1_TAG_Dates+'":"' + formatDateTime('yyyy-mm-dd' ,incday(date,8))+'"},');
  memRequest.lines.add('{"'+VS1_TAG_Dates+'":"' + formatDateTime('yyyy-mm-dd' ,incday(date,9))+'"},');
  memRequest.lines.add('{"'+VS1_TAG_Dates+'":"' + formatDateTime('yyyy-mm-dd' ,incday(date,10))+'"},');
  memRequest.lines.add('{"'+VS1_TAG_Dates+'":"' + formatDateTime('yyyy-mm-dd' ,incday(date,12))+'"},');
  memRequest.lines.add('{"'+VS1_TAG_Dates+'":"' + formatDateTime('yyyy-mm-dd' ,incday(date,17))+'"},');
  memRequest.lines.add('{"'+VS1_TAG_Dates+'":"' + formatDateTime('yyyy-mm-dd' ,incday(date,18))+'"},');
  memRequest.lines.add('{"'+VS1_TAG_Dates+'":"' + formatDateTime('yyyy-mm-dd' ,incday(date,19))+'"}');
  memRequest.lines.add(']');
  memRequest.lines.add('    }');
  memRequest.lines.add('}');
  memRequest.lines.add('}');
  AddClassToURL('VS1_Cloud_Task/Method?Name="'+TASK_VS1_RepeatAppointment+'"');
  highlightcontrol(btnPost);

end;

procedure TfmWebAPITest.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  btnvs1credentisal.click;
  AddClassToURL('VS1_Cloud_Task/Method?Name="'+TASK_VS1_ChangePassword+'"');
  btnvs1credentisal.click;
  memRequest.lines.clear;
  memRequest.lines.add('"'+ TAG_JsonIN +'":{');
  memRequest.lines.add('"'+ TAG_MethodName +'":"'+TASK_VS1_ChangePassword+'",');
  memRequest.lines.add('"'+ TAG_CLOUD_Params +'":{');
(*  memRequest.lines.add('   "'+ VS1_TAG_FirstName+'":"'     + inputBox('First name :' ,'' ,'')+'",');
  memRequest.lines.add('   "'+ VS1_TAG_LastName+'":"'      + inputBox('Last Name :'  ,'' ,'')+'",');
  memRequest.lines.add('   "'+ VS1_TAG_EmployeeName+'":"'  + inputBox('Employee Name  :'  ,'' ,'')+'",');*)
  memRequest.lines.add('   "'+ VS1_TAG_ERPLoginDetails +'":{');
  memRequest.lines.add('   "'+ TAG_ERPUserName  +'":"' + inputBox('User to Change Password:'   ,'' ,'')+'",');
  memRequest.lines.add('   "'+ VS1_TAG_NewPassword  +'":"' + inputBox('New Password :'   ,'' ,'')+'",');
  memRequest.lines.add('}');
  memRequest.lines.add('}');
  memRequest.lines.add('}');
  highlightcontrol(btnPost);
end;

procedure TfmWebAPITest.btnDashboardClick(Sender: TObject);
begin
  inherited;
  AddClassToURL('VS1_Dashboard');
  highlightcontrol(btnGET);

end;

procedure TfmWebAPITest.btnDBConnectClick(Sender: TObject);
begin
  inherited;
  btnErpAdminCred.click;
  memRequest.lines.clear;
  memRequest.lines.add('"'+ TAG_JsonIN +'":');
  memRequest.lines.add('{');
  memRequest.lines.add('"'+TAG_MethodName+'":"'+TASK_VS1_DbConnectTest+'",');
  memRequest.lines.add('"'+TAG_CLOUD_Params+'"');
  memRequest.lines.add('{');
  memRequest.lines.add('"'+VS1_TAG_ServerName   +'":"dev2",');
  memRequest.lines.add('"'+VS1_TAG_DatabaseName +'":"aus_sample_company",');
  memRequest.lines.add('"'+VS1_TAG_VS1UserName  +'":"Admin",');
  memRequest.lines.add('"'+VS1_TAG_VS1Password  +'":"Admin",');
  memRequest.lines.add('"'+VS1_TAG_APIPort      +'":888,');
  memRequest.lines.add('"'+VS1_TAG_HTTPS        +'":false"');
  memRequest.lines.add('}');
  memRequest.lines.add('}');
  AddClassToURL('VS1_Cloud_Task/Method?Name="'+TASK_VS1_DbConnectTest+'"');
end;

procedure TfmWebAPITest.btnCreateNewDatabaseClick(Sender: TObject);
begin
  inherited;
  btnErpAdminCred.click;
  memRequest.lines.clear;
  memRequest.lines.add('"'+ TAG_JsonIN +'":');
  memRequest.lines.add('{');
  memRequest.lines.add('"'+ TAG_MethodName +'":"CreateDatabase"');
  memRequest.lines.add('"'+ VS1_TAG_IsVS1Database +'":true');
  memRequest.lines.add('"'+VS1_TAG_DatabaseName+'":"'+ inputBox('Database Name:','','')+'"');
  memRequest.lines.add('}');
  //cboURL.text :=  'http://Localhost:888/erpapi/system/method?Name="CreateDatabase"';
  AddClassToURL('system/method?Name="CreateDatabase"');
end;

procedure TfmWebAPITest.btnDropdatabaseClick(Sender: TObject);
begin
  inherited;
  btnErpAdminCred.click;
  memRequest.lines.clear;
  memRequest.lines.add('"'+ TAG_JsonIN +'":');
  memRequest.lines.add('{');
  memRequest.lines.add('"'+ TAG_MethodName +'":"DropDatabase"');
  memRequest.lines.add('"dbname":"'+ inputBox('Database Name:','','')+'"');
  memRequest.lines.add('}');
  AddClassToURL('system/method?Name="DropDatabase"');
end;

procedure TfmWebAPITest.DNMSpeedButton2Click(Sender: TObject);
var
  qry:TERPQuery;
  fiLicenseLevel:Integer;
begin
  inherited;
  btnvs1credentisal.click;
  memRequest.lines.clear;
  memRequest.lines.add('"'+ TAG_JsonIN +'":{');
  memRequest.lines.add('"'+ TAG_MethodName                      +'":"'+TASK_VS1_NewRego+'",');
  memRequest.lines.add('"'+ TAG_CLOUD_Params                   +'":{');
  memRequest.lines.add('   "'+ VS1_TAG_ClientName              +'":"'    + inputBox('Clientname :' ,'' ,'')+'",');
(*  memRequest.lines.add('   "'+ VS1_TAG_ERPDBServerName         +'":"'    + inputBox('Servername :' ,'' ,'Hollie-PC')+'",');
  memRequest.lines.add('   "'+ VS1_TAG_ERPDBDatabaseName       +'":"'    + inputBox('Databasename :' ,'' ,'asahi_diamonds_industrial_australia')+'",');
  memRequest.lines.add('   "'+ VS1_TAG_ERPDBPortnumber         +'":'    + inputBox('Portnumebr :' ,'' ,'443')+',');
  memRequest.lines.add('   "'+ VS1_TAG_ERPDBIsPortHttps        +'":"'    + inputBox('Is Https :' ,'' ,'T')+'",');*)
  memRequest.lines.add('   "'+ VS1_TAG_CloudUserName            +'":"' + inputBox('User Name :'  ,'' ,'')+'",');
  memRequest.lines.add('   "'+ VS1_TAG_CloudPassword            +'":"' + inputBox('Password :'   ,'' ,'')+'",');
  memRequest.lines.add('   "'+ VS1_TAG_FirstName                +'":"'     + inputBox('First name :' ,'' ,'')+'",');
  memRequest.lines.add('   "'+ VS1_TAG_LastName                 +'":"'      + inputBox('Last Name :'  ,'' ,'')+'",');
  memRequest.lines.add('   "'+ VS1_TAG_PhoneNumber              +'":"'   + inputBox('Phone Number:','' ,'')+'",');
  memRequest.lines.add('   "'+ VS1_TAG_RegionName               +'":"'    + inputBox('Region'       ,'' ,'Australia')+'",');
  memRequest.lines.add('   "'+ VS1_TAG_CreditCardType           +'":"Visa",');
  memRequest.lines.add('   "'+ VS1_TAG_CreditCardCardHolderName +'":"xxxxxxxxxxxxxxxxxx",');
  memRequest.lines.add('   "'+ VS1_TAG_CreditCardNumber         +'":"999999999999999",');
  memRequest.lines.add('   "'+ VS1_TAG_CreditCardNotes          +'":"",');
  memRequest.lines.add('   "'+ VS1_TAG_CreditCardCVC            +'":"999",');
  memRequest.lines.add('   "'+ VS1_TAG_LicenseRenewDurationType +'":"M",');
  memRequest.lines.add('   "'+ VS1_TAG_LicenseRenewDuration     +'":3,');
  memRequest.lines.add('   "'+ VS1_TAG_CreditCardExpirymonth    +'":03,');
  memRequest.lines.add('   "'+ VS1_TAG_CreditCardExpiryyear     +'":2020,');
  memRequest.lines.add('   "'+ VS1_TAG_Paymentamount            +'":900,');
  memRequest.lines.add('   "'+ VS1_TAG_PayMethod                +'":"Cash",');
  memRequest.lines.add('   "'+ VS1_TAG_CreateNewDB              +'":"'    + inputBox('CreateNewDB'       ,'' ,'T')+'",');
  memRequest.lines.add('   "'+ VS1_TAG_Price                    +'":100,');
  memRequest.lines.add('   "'+ VS1_TAG_DiscountedPrice          +'":0,');
  memRequest.lines.add('   "'+ VS1_TAG_DiscountDesc             +'":"100% - 1 Month",');
  memRequest.lines.add('   "'+ VS1_TAG_Renew_Price             +'":100,');
  memRequest.lines.add('   "'+ VS1_TAG_Renew_DiscountedPrice   +'":100,');
  memRequest.lines.add('   "'+ VS1_TAG_Renew_DiscountDesc      +'":"",');

  if MessageDlgXP_Vista('Enable StS?', mtConfirmation, [mbYes, mbNo], 0) = mryes then begin
    memRequest.lines.add('   "'+ VS1_TAG_EnableStS              +'":true,');
    (*memRequest.lines.add('   "StSDefaults":{"'+GT_TAG_StSPackageTagProduct  + '":"Package Product",');
    memRequest.lines.add('                  "'+GT_TAG_StSPlantTagProduct    + '":"Plant Product",');
    memRequest.lines.add('                  "'+GT_TAG_StSSupplier           + '":"Metrc",');
    memRequest.lines.add('                  "'+GT_TAG_StSDefaultWeightUOM   + '":"KG",');
    memRequest.lines.add('                  "'+GT_TAG_StSDefaultClass       + '":"Default",');
    memRequest.lines.add('                  "'+GT_TAG_StSUseSeedtoSale      + '":true},');*)
    stsDefaults;
  end;
  fiLicenseLevel := 0;
  Case MessageDlgXP_Vista('License type', mtConfirmation, [], 0, nil, '', '', false, nil,'Simple Start,Essentials,PLUS') of
    100: fiLicenseLevel:= Tvs1_licenselevels.idtoggle('Simple Start');
    101: fiLicenseLevel:= Tvs1_licenselevels.idtoggle('Essentials');
    102: fiLicenseLevel:= Tvs1_licenselevels.idtoggle('PLUS');
  End;
  memRequest.lines.add('   "LicenseLevel":'+inttostr(fiLicenseLevel)+',');
  memRequest.lines.add('   "ExtraModules":[');
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    qry.sql.text := 'SELECT modulename FROM tblVS1_modules WHERE licenselevel = '+inttostr(fiLicenseLevel)+' AND isextra ="T" ORDER BY modulename';
    qry.open;
    if qry.recordcount>0 then begin
      qry.first;
      While qry.eof = false do begin
        memRequest.lines.add('           {"'+ VS1_TAG_ModuleName+'":"'+trim(qry.fieldbyname('Modulename').asString)+'",');
        memRequest.lines.add('                  "'+ VS1_TAG_Price                    +'":100,' );
        memRequest.lines.add('                  "'+ VS1_TAG_DiscountedPrice          +'":0,'   );
        memRequest.lines.add('                  "'+ VS1_TAG_DiscountDesc             +'":"100% - 1 Month",');
        memRequest.lines.add('                  "'+ VS1_TAG_Renew_Price              +'":100,' );
        memRequest.lines.add('                  "'+ VS1_TAG_Renew_DiscountedPrice    +'":100,' );
        memRequest.lines.add('                  "'+ VS1_TAG_Renew_DiscountDesc       +'":""}'+iif(qry.recno=qry.recordcount , '', ','));
        qry.Next;
      end;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
  memRequest.lines.add('    ]');
  memRequest.lines.add('}');
  memRequest.lines.add('}');
  memRequest.lines.add('}');
  AddClassToURL('VS1_Cloud_Task/Method?Name="'+TASK_VS1_NewRego+'"');
  highlightcontrol(btnPost);
end;

procedure TfmWebAPITest.DNMSpeedButton3Click(Sender: TObject);
begin
  inherited;
  OpenERPListFormSingleselectModal('TERPDatabasesListGUI' , ChooseDatabase);
end;
procedure TfmWebAPITest.DNMSpeedButton4Click(Sender: TObject);
begin
  inherited;
  btnvs1credentisal.click;
  AddClassToURL('Vs1_Logon?Vs1UserName='+ Inputbox('UserName' , '', '')+
                '&vs1Password='+Inputbox('Password' , '', ''));
  highlightcontrol(btnGet);
end;

procedure TfmWebAPITest.DNMSpeedButton5Click(Sender: TObject);
begin
  inherited;
  btnvs1credentisal.click;
  AddClassToURL('VS1_Cloud_Task/Method?Name="VS1_NewUser"');
  btnvs1credentisal.click;
  memRequest.lines.clear;
  memRequest.lines.add('"'+ TAG_JsonIN +'":{');
  memRequest.lines.add('"'+ TAG_MethodName +'":"VS1_NewUser",');
  memRequest.lines.add('"'+ TAG_CLOUD_Params +'":{');
  memRequest.lines.add('   "'+ VS1_TAG_VS1UserName  +'":"' + inputBox('User name :'   ,'' ,'')+'",');
  memRequest.lines.add('   "'+ VS1_TAG_VS1Password  +'":"' + inputBox('Password :'   ,'' ,'')+'",');
  memRequest.lines.add('   "'+ VS1_TAG_ModuleName   +'":"Add Extra User",');
  memRequest.lines.add('   "'+ VS1_TAG_Paymentamount+'":200.0,');
  memRequest.lines.add('   "'+ VS1_TAG_PayMethod    +'":"Cash",');
  memRequest.lines.add('   "'+ VS1_TAG_EmployeeDetails+'":{');
  memRequest.lines.add('   "'+ VS1_TAG_FirstName+'":"'     + inputBox('First name :' ,'' ,'')+'",');
  memRequest.lines.add('   "'+ VS1_TAG_LastName+'":"'      + inputBox('Last Name :'  ,'' ,'')+'",');
  memRequest.lines.add('   "'+ VS1_TAG_PhoneNumber+'":"'   + inputBox('Phone Number:','' ,'')+'",');
  memRequest.lines.add('   "'+ VS1_TAG_DateStarted+'":"2020-01-01",');
  memRequest.lines.add('   "'+ VS1_TAG_DOB+'":"1979-01-01",');
  memRequest.lines.add('   "'+ VS1_TAG_Sex+'":"F"');
  memRequest.lines.add('},');
  OpenERPListFormSingleselectModal('TVs1DatabaseListGUI' , ChooseDatabaseinmemo);
  memRequest.lines.add('}');
  memRequest.lines.add('}');
  highlightcontrol(btnPost);
end;
procedure TfmWebAPITest.DNMSpeedButton6Click(Sender: TObject);
begin
  inherited;
  btnvs1credentisal.click;
  memRequest.lines.clear;
  OpenERPListFormSingleselectModal('TVs1DatabaseListGUI' , ChooseDatabaseinmemo);
  AddClassToURL('VS1SysInfo?'+ VS1_TAG_DatabaseName+'='+ Quotedstr(fsDB)+
                '&'+VS1_TAG_Servername +'='+Quotedstr(fsServer));
end;
procedure TfmWebAPITest.chooseEmployees(Sender:TwwDBGrid);
begin
   if sender.Owner is TBaseListingGUI then
    TBaseListingGUI(sender.Owner).SelectedIDs('employeeId', fEmployeeIds, true );
end;
procedure TfmWebAPITest.Chooseforms(Sender:TwwDBGrid);
begin
   if sender.Owner is TBaseListingGUI then
    TBaseListingGUI(sender.Owner).SelectedIDs('formId', fformIds, true);
end;
procedure TfmWebAPITest.DNMSpeedButton7Click(Sender: TObject);
var
  fiaccessId:Integer;
  ctr1, ctr2:Integer;
begin
  inherited;
  AddClassToURL('VS1_Cloud_Task/Method?Name="VS1EmployeeAccess"');


  fEmployeeIds := TIntegerList.create;
  fformIds := TIntegerList.create;
  try
    if MessageDlgXP_Vista('Employees for AccessLevel',mtconfirmation,[],0,nil,'','',False,nil,'All,Choose Employee(s)') =100 then fEmployeeIds.add(0)
    else OpenERPListFormultiselectModal('TEmployeeExpresslistGUI', nil, chooseEmployees);

    if MessageDlgXP_Vista('forms',mtconfirmation,[],0,nil,'','',False,nil,'All,Choose Form(s)') =100 then fformIds.add(0)
    else OpenERPListFormultiselectModal('TVS1FormsGUI', nil, Chooseforms);

    case MessageDlgXP_Vista('Accesslevel',mtconfirmation,[],0,nil,'','',False,nil,replacestr(ACC_LVL_MSG_1,',',' ') +','+
                                                                                  replacestr(ACC_LVL_MSG_2,',',' ') +','+
                                                                                  replacestr(ACC_LVL_MSG_3,',',' ') +','+
                                                                                  replacestr(ACC_LVL_MSG_4,',',' ') +','+
                                                                                  replacestr(ACC_LVL_MSG_5,',',' ') +','+
                                                                                  replacestr(ACC_LVL_MSG_6,',',' ') ) of
        100: fiaccessId:= 1;
        101: fiaccessId:= 2;
        102: fiaccessId:= 3;
        103: fiaccessId:= 4;
        104: fiaccessId:= 5;
        else fiaccessId:= 6;
    end;
    memRequest.Lines.Clear;
    memRequest.lines.add('"'+ TAG_JsonIN +'":{');
    memRequest.lines.add('      "'+ TAG_MethodName +'":"VS1EmployeeAccess",');
    memRequest.lines.add('      "'+ TAG_CLOUD_Params +'":{');
    memRequest.lines.add('               "VS1EmployeeAccessList":[');

    for ctr1 := 0 to fEmployeeIds.count-1 do begin
      for ctr2 := 0 to fformIds.count-1 do begin
          memRequest.lines.add('                   {"EmployeeId":'+ inttostr(fEmployeeIds[ctr1])+',');
          memRequest.lines.add('                   "formID":'+ inttostr(fformIds[ctr2])+',');
          memRequest.lines.add('                   "Access":'+ inttostr(fiaccessId)+'  }' + iif((ctr1< fEmployeeIds.count-1) and (ctr2<fformIds.count-1  ), ',' , ''));
      end;
    end;

    memRequest.lines.add('               ]');
    memRequest.lines.add('         }');
    memRequest.lines.add('  }');



  finally
      freeandnil(fEmployeeIds);
      freeandnil(fformIds);

  end;
end;

procedure TfmWebAPITest.DNMSpeedButton8Click(Sender: TObject);
begin
  inherited;
  btnvs1credentisal.click;
  memRequest.lines.clear;
  memRequest.lines.add('"'+ TAG_JsonIN +'":{');
  memRequest.lines.add('"'+ TAG_MethodName +'":"'+TASK_GT_InitDBForStS+'",');
  memRequest.lines.add('"'+ TAG_CLOUD_Params +'":{');
  memRequest.lines.add('   "'+GT_TAG_StSUseSeedtoSale       + '":true,');
  memRequest.lines.add('   "'+GT_TAG_StSInitWithDefaults    + '":true,');
  memRequest.lines.add('   "'+GT_TAG_StSPackageTagProduct   + '":"StS Package Tag",');
  memRequest.lines.add('   "'+GT_TAG_StSPlantTagProduct     + '":"StS Plant Tag",');
  memRequest.lines.add('   "'+GT_TAG_StSSupplier            + '":"StS Metrc",');
  memRequest.lines.add('   "'+GT_TAG_StSStockAccount        + '":"StS Plant Stock",');
  memRequest.lines.add('   "'+GT_TAG_StSUsesBins            + '":true,');
  memRequest.lines.add('   "'+GT_TAG_StSSimpleMode          + '":true,');
  memRequest.lines.add('   "'+GT_TAG_StSDefaultClass        + '":"Sts1",');
  memRequest.lines.add('   "'+GT_TAG_StSDefaultWeightUOM    + '":"KG"');
  memRequest.lines.add('}');
  memRequest.lines.add('}');
  AddClassToURL(GT_Cloud_Task+'/Method?Name="'+TASK_GT_InitDBForStS+'"');
  highlightcontrol(btnPost);
end;

procedure TfmWebAPITest.DNMSpeedButton9Click(Sender: TObject);
begin
  inherited;
  btnvs1credentisal.click;
  memRequest.lines.clear;
  memRequest.lines.add('"'+ TAG_JsonIN +'":{');
  memRequest.lines.add('"'+ TAG_MethodName +'":"'+TASK_VS1_AddModules+'",');
  memRequest.lines.add('"'+ TAG_CLOUD_Params +'":{');
  memRequest.lines.add('   "' + VS1_TAG_CloudUserName +'":"' + inputBox('User name :'   ,'' ,'')+'",');
  memRequest.lines.add('   "' + VS1_TAG_CloudPassword +'":"' + inputBox('Password :'   ,'' ,'')+'",');
  memRequest.lines.add('   "'+VS1_TAG_Paymentamount+'":900,');
  memRequest.lines.add('   "'+VS1_TAG_PayMethod+'":"Cash",');
  memRequest.lines.add('   "LicenseLevel":3,');
  memRequest.lines.add('   "ExtraModules":[');
  memRequest.lines.add('           {"ModuleName":"Seed To Sale"}');
  memRequest.lines.add('    ],');
  StsDefaults;
  memRequest.lines.add('}');
  memRequest.lines.add('}');
  memRequest.lines.add('}');
  memRequest.lines.add('}');
  AddClassToURL('VS1_Cloud_Task/Method?Name="'+TASK_VS1_AddModules+'"');
  highlightcontrol(btnPost);
end;
Procedure TfmWebAPITest.StsDefaults;
begin
  memRequest.lines.add('    "StSDefaults":{');
  memRequest.lines.add('            "UseSeedtoSale":true,');
  if MessageDlgXP_Vista('Default Values? ', mtConfirmation, [mbYes, mbNo], 0) = mryes then begin
      memRequest.lines.add('            "StSInitWithDefaults":true,');
  end else begin
      memRequest.lines.add('            "StSPackageTagProduct":"StS Package Tag",');
      memRequest.lines.add('            "StSPlantTagProduct":"StS Plant Tag",');
      memRequest.lines.add('            "StSSupplier":"StS Metrc",');
      memRequest.lines.add('            "StSStockAccount":"StS Plant Stock",');
      memRequest.lines.add('            "StSUsesBins":true,');
      memRequest.lines.add('            "StSSimpleMode":true,');
      memRequest.lines.add('            "StSDefaultClass":"Sts1",');
      memRequest.lines.add('            "StSDefaultWeightUOM":"KG"');
  end;

end;
procedure TfmWebAPITest.ChooseDatabaseinmemo(Sender: TwwDbGrid);
begin
  fsdb :=Sender.Datasource.dataset.fieldbyname('Databasename').asString;
  fsServer:=Sender.Datasource.dataset.fieldbyname('ServerName').asString;
  //fsclient:=Sender.Datasource.dataset.fieldbyname('VS1ClientName').asString;
  memRequest.lines.add('   "ClientName":"'    + Sender.Datasource.dataset.fieldbyname('VS1ClientName').asString+'",');
  memRequest.lines.add('   "DatabaseName":"' + Sender.Datasource.dataset.fieldbyname('Databasename').asString+'",');
  memRequest.lines.add('   "ServerName":"' + Sender.Datasource.dataset.fieldbyname('ServerName').asString+'",');
  memRequest.lines.add('"'+VS1_TAG_ERPLoginDetails+'":{');
  memRequest.lines.add('   "ERPUserName":"' + Sender.Datasource.dataset.fieldbyname('username').asString+'",');
  memRequest.lines.add('   "ERPPassword":"' + Sender.Datasource.dataset.fieldbyname('Password').asString+'"');
  memRequest.lines.add('}');
end;
procedure TfmWebAPITest.ChooseDatabase(Sender: TwwDbGrid);
begin
  edtDatabase.TExt := Sender.Datasource.dataset.fieldbyname('Databasename').asString;
  edtUser.TExt := Sender.Datasource.dataset.fieldbyname('Logon_Name').asString;
  edtPass.TExt := Sender.Datasource.dataset.fieldbyname('DPassword').asString;
  Setcontrolfocus(cboURL);
end;
procedure TfmWebAPITest.btnErpAdminCredClick(Sender: TObject);
begin
  inherited;
  edtUser.text := ERP_ADMIN_USER;
  edtPass.text := ERP_ADMIN_TOKEN;
end;

procedure TfmWebAPITest.DoRequest(const RequestType: string);
var
  Client: TIdHTTP;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  res: string;
  stream: TMemoryStream;
//  InStream: TStringStream;
  InStream: TFileStream;
  TimeStart: TDateTime;
  sl: TStringList;
  s: string;
  TempFileName: string;
//  json: TJsonObject;
begin
  if edtDatabase.Text = '' then begin
    MessageDlgXP_Vista('Please enter the ERP Database Name to use for the request.', mtInformation, [mbOk],0);
    SetControlFocus(edtDatabase);
    exit;
  end;
  if edtUser.Text = '' then begin
    MessageDlgXP_Vista('Please enter the ERP User Name to use for the request.', mtInformation, [mbOk],0);
    SetControlFocus(edtUser);
    exit;
  end;
  if edtPass.Text = '' then begin
    MessageDlgXP_Vista('Please enter the ERP User Password to use for the request.', mtInformation, [mbOk],0);
    SetControlFocus(edtPass);
    exit;
  end;
  if not ((Pos('HTTP://', Uppercase(cboURL.Text)) = 1) or (Pos('HTTPS://', Uppercase(cboURL.Text)) = 1)) then begin
    MessageDlgXP_Vista('The request URL is not correct, it must begin with:' + #13#10 +
      'HTTP://' + #13#10 +
      'or' + #13#10 +
      'HTTPS://', mtInformation, [mbOk],0);
    SetControlFocus(cboURL);
    exit;
  end;
  if (Pos('ERPAPI', Uppercase(cboURL.Text)) < 1) then begin
    MessageDlgXP_Vista('The request URL format is not correct, the format is:' + #13#10 +
      'HTTPS://[server][:Optional Port]/erpapi/[Object Name][/Optional ID]' + #13#10 + #13#10 +
      'For example to get a product list' + #13#10 +
      'HTTPS://' + AppEnv.AppDb.Server + '/erpapi/TProductWeb' + #13#10 + #13#10 +
      'or to get customer details for customer with id 1:' + #13#10 +
      'HTTPS://' + AppEnv.AppDb.Server + '/erpapi/TCustomer/1', mtInformation, [mbOk],0);
    SetControlFocus(cboURL);
    Exit;
  end;
  if (RequestType = 'POST') and (memRequest.Lines.Count = 0) then begin
    MessageDlgXP_Vista('Please enter the Json formatted data to send with the request.', mtInformation, [mbOk],0);
    SetControlFocus(memRequest);
    Exit;
  end;

  memResponce.Clear;
  UpdateResult('');

  Client := TIdHTTP.Create(nil);
//  InStream:= TMemoryStream.Create;
//  InStream:= TStringStream.Create(s, TEncoding.UTF8);
  TempFileName := SystemLib.GetTempFileName('', '.json', True);
  InStream := TFileStream.Create(TempFileName, fmOpenReadWrite);
  try
    Client.Request.UserAgent := HTTPConst.TrueERPUserAgent;
    if Pos('HTTPS', Uppercase(cboURL.Text)) = 1 then begin
      SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(client);
      client.IOHandler:= SSLHandler;
      client.Request.BasicAuthentication:= true;
      Client.Request.Username:= edtUser.Text;
      Client.Request.Password:= edtPass.Text;
    end
    else begin
      Client.Request.CustomHeaders.AddValue('username', edtUser.Text);
      Client.Request.CustomHeaders.AddValue('password', edtPass.Text);
    end;

    Client.ReadTimeout := (1000 * 60 * 2);
//      (StrToInt(Copy(edtWaitTime.Text, 1, Pos(':',edtWaitTime.Text)-1)) * 60 * 1000) +
//      (StrToInt(Copy(edtWaitTime.Text, Pos(':',edtWaitTime.Text)+1, 256)) * 1000);

//    Client.ReadTimeout:= 1000 * 60 * 5;
    Client.Request.CustomHeaders.AddValue('database', edtDatabase.Text);
    res:= '';
    if RequestType = 'GET' then begin
      TimeStart := now;
      try
//        res:= client.Get(cboURL.Text);
      try
        Client.Get(cboURL.Text, InStream);
      Except
         on E:Exception do begin
          MessageDlgXP_Vista(e.message, mtWarning, [mbOK], 0);
         end;
      end;
        UpdateResult(IntToStr(Client.Response.ResponseCode) + ' (Time: ' + FormatDateTime('nn:ss-zzz', now-TimeStart) + ')');
//        memResponce.Lines.Add(res);
//        InStream.Position := 0;
//        json:= TJsonObject.Create;
//        try
//          json.readfromstream(InStream);
//          json.savetofile('c:\temp\temp.txt');
//        finally
//          json.free;
//        end;

        InStream.Position := 0;
        try
          memResponce.Lines.LoadFromStream(InStream);
        except
          on e: exception do begin
            if Pos('out of memory', Lowercase(e.Message)) > 0 then begin
              CommonLib.MessageDlgXP_Vista('The data returned is to large to display and has been saved into the following file:' +
                #13#10 + #13#10 + TempFileName, mtInformation, [mbOk],0);
            end
            else
              raise;
          end;

        end;
        if chkFormatJSON.Checked then begin
          memResponce.Lines.BeginUpdate;
          try
            FormatJson(memResponce.Lines);
          finally
            memResponce.Lines.EndUpdate;
          end;
        end;
      except
        on e: exception do begin
          if FirstHttpError and (Pos('Software caused connection abort', e.Message) > 0) then begin
            FirstHttpError := false;
            DoRequest(RequestType);
          end
          else begin
            if Client.Response.RawHeaders.Values['errormessage'] <> '' then
              UpdateResult(IntToStr(Client.Response.ResponseCode) + ' (Time: ' + FormatDateTime('nn:ss-zzz', now-TimeStart) + ')', Client.Response.RawHeaders.Values['errormessage'])
            else
              UpdateResult(IntToStr(Client.Response.ResponseCode) + ' (Time: ' + FormatDateTime('nn:ss-zzz', now-TimeStart) + ')', e.Message);
          end;
        end;
      end;
    end
    else if RequestType = 'POST' then begin
      TimeStart:= now;
      try
        stream := TMemoryStream.Create;
        try
          memRequest.Lines.SaveToStream(stream);
          res := client.Post(cboURL.Text, stream);
          UpdateResult(IntToStr(Client.Response.ResponseCode) + ' (Time: ' + FormatDateTime('nn:ss-zzz',now-TimeStart) + ')');
          memResponce.Lines.Add(res);
          OpenReport;
        finally
          stream.Free;
        end;
      except
        on e: exception do begin
          if FirstHttpError and (Pos('Software caused connection abort',e.Message) > 0) then begin
            FirstHttpError := false;
            DoRequest(RequestType);
          end
          else begin
            if Client.Response.RawHeaders.Values['errormessage'] <> '' then
              UpdateResult(IntToStr(Client.Response.ResponseCode) + ' (Time: ' + FormatDateTime('nn:ss-zzz',now-TimeStart) + ')', Client.Response.RawHeaders.Values['errormessage'])
            else
              UpdateResult(IntToStr(Client.Response.ResponseCode) + ' (Time: ' + FormatDateTime('nn:ss-zzz',now-TimeStart) + ')', e.Message);
          end;
        end;
      end;
    end;
    if res <> '' then begin
      try
        if chkFormatJSON.Checked then begin
          sl:= TStringList.Create;
          try
            sl.Text := res;
            FormatJson(sl);
            memResponce.Lines.Assign(sl);
          finally
            sl.Free;
          end;
        end
        else begin
          memResponce.Lines.Text := res;
        end;
      except
        on e: exception do begin
          memResponce.Clear;
          memResponce.Lines.Text := res;
        end;
      end;
    end;
  finally
    Client.Free;
    InStream.Free;
  end;
end;

procedure TfmWebAPITest.edtDatabaseExit(Sender: TObject);
begin
  inherited;
  if Config.S['ERPDatabase'] <> edtDatabase.Text then begin
    Config.S['ERPDatabase']:= edtDatabase.Text;
    SaveConfig;
    self.CheckSettings(false);
  end;
end;

procedure TfmWebAPITest.edtPassExit(Sender: TObject);
begin
  inherited;
  if Config.S['ERPUserPassword'] <> edtPass.Text then begin
    Config.S['ERPUserPassword']:= edtPass.Text;
    SaveConfig;
    self.CheckSettings(false);
  end;
end;

procedure TfmWebAPITest.cboURLExit(Sender: TObject);
begin
  if Config.S['URL'] <> cboURL.Text then begin
    Config.S['URL'] := cboURL.Text;
    if (cboURL.Items.IndexOf(cboURL.Text) < 0) then
    begin
      cboURL.Items.Add(cboURL.Text);
      Config.S['URLHistory'] := cboURL.Items.Text;
    end;
    SaveConfig;
    self.CheckSettings(false);
    lblPort.Caption := 'Port: ' + IntToStr(Port);
  end;
end;

procedure TfmWebAPITest.edtUserExit(Sender: TObject);
begin
  inherited;
  if Config.S['ERPUserName'] <> edtUser.Text then begin
    Config.S['ERPUserName']:= edtUser.Text;
    SaveConfig;
    self.CheckSettings(false);
  end;
end;

function TfmWebAPITest.ExtractServer(aURL: string): string;
var
  x: integer;
  s: string;
begin
  result:= '';
  s:= StringReplace(aURL,'http://','',[rfIgnoreCase]);
  s:= StringReplace(s,'https://','',[rfIgnoreCase]);
  for x:= 1 to Length(s) do begin
    if CharInSet(s[x],[':', ' ', '/'])  then
      break
    else
      result:= result + s[x];
  end;
end;

procedure TfmWebAPITest.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action:= caFree;
end;

procedure TfmWebAPITest.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  FormClosing:= true;
end;

procedure TfmWebAPITest.FormCreate(Sender: TObject);
begin
  inherited;
  IgnorecheckSettings:= False;
  //  edtWaitTime.Visible := DevMode;
  FormClosing:= false;
  FirstHttpError := true;
  Config:= TJsonObject.Create;
  LoadConfig;
  pnlDevmode.visible := Devmode;
  pnlObjects.visible := Devmode;
  pnlGTOptions.visible := Devmode;
  mnuExampleWithOptions.visible := Devmode;
  N4.visible := Devmode;
end;

procedure TfmWebAPITest.FormDestroy(Sender: TObject);
begin
  inherited;
  Config.Free;
end;

procedure TfmWebAPITest.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  lblProcess.caption := '';
  if Key = VK_F1 then
     ShellExecute(0,'open',PChar('http://www.trueerp.com/wiki/Web_API'),nil,nil,SW_NORMAL)
end;

procedure TfmWebAPITest.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  lblProcess.caption :='';
end;

procedure TfmWebAPITest.FormShow(Sender: TObject);
begin
  inherited;
  self.CheckSettings(true);
  lblProcess.caption := '';
  {$IFDEF DEBUG}
  if (Tag = 1) then
    Exit;
  Tag := 1;
  // Width := 3 * Width div 2;
  //   Height := 5 * Height div 3;
  {$ENDIF}
end;

function TfmWebAPITest.GetExistingCustomerName: string;
var
  qry: TERPQuery;
  move: integer;
begin
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select Company from tblclients');
    qry.SQL.Add('where Customer = "T"');
    qry.SQL.Add('and IsJob = "F"');
    qry.SQL.Add('and Company <> "Cash Customer"');
    qry.SQL.Add('and Company <> "Workshop"');
    qry.SQL.Add('limit 100');
    qry.Open;
    move := Random(qry.RecordCount -1);
    qry.MoveBy(move);
    result:= qry.FieldByName('Company').AsString;
  finally
    qry.Free;
  end;
end;

function TfmWebAPITest.GetExistingEmployeeName: string;
var
  qry: TERPQuery;
begin
  result:= 'Fred Smith';
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select EmployeeName from tblEmployees');
    qry.SQL.Add('where EmployeeName like "%web%user%"');
    qry.SQL.Add('and Active = "T"');
    qry.Open;
    if not qry.IsEmpty then begin
      result:= qry.FieldByName('EmployeeName').AsString;
      exit;
    end;
    qry.Close;
    qry.SQL.Add('select EmployeeName from tblEmployees');
    qry.SQL.Add('where Active = "T"');
    qry.Open;
    if not qry.IsEmpty then
      result:= qry.FieldByName('EmployeeName').AsString;
  finally
    qry.Free;
  end;
end;

function TfmWebAPITest.GetExistingProduct(
  ExcludeProductName: string; IsBatchProduct: boolean): TProductRec;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select PartName, Price1, PriceInc1, TaxCode, Cost1, CostInc1, PurchTaxCode from tblparts');
    qry.SQL.Add('where PartType = "INV"');
    qry.SQL.Add('and Active = "T"');
    if ExcludeProductName <> '' then
      qry.SQL.Add('and PartName <> "' + ExcludeProductName + '"');
    if IsBatchProduct then
      qry.SQL.Add('and batch = "T"');
    qry.Open;
    while not qry.Eof do begin
      if qry.FieldByName('PriceInc1').AsFloat > 0 then
        break;
      qry.Next;
    end;
    result.Name:= qry.FieldByName('PartName').AsString;
    result.PriceInc:= qry.FieldByName('PriceInc1').AsFloat;
    result.PriceEx:= qry.FieldByName('Price1').AsFloat;
    result.TaxCode:= qry.FieldByName('TaxCode').AsString;
    result.PurchTaxCode:= qry.FieldByName('PurchTaxCode').AsString;
    result.CostInc:= qry.FieldByName('CostInc1').AsFloat;
    result.CostEx:= qry.FieldByName('Cost1').AsFloat;
  finally
    qry.Free;
  end;
end;

function TfmWebAPITest.GetExistingSalesCategory: string;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select Name from tblsimpletypes where TypeCode = "SalesCategory"');
    qry.Open;
    result := qry.FieldByName('Name').AsString;
  finally
    qry.Free;
  end;
end;

function TfmWebAPITest.GetExistingSupplierName: string;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select Company from tblclients');
    qry.SQL.Add('where Supplier = "T"');
    qry.SQL.Add('and IsJob = "F"');
    qry.SQL.Add('and Company <> "Cash Customer"');
    qry.SQL.Add('and Company <> "Workshop"');
    qry.SQL.Add('and (IfNull(ForeignExchangeSellCode,"") = "" or ' +
      'IfNull(ForeignExchangeSellCode,"") = (select tblregionaloptions.ForeignExDefault from tblregionaloptions where tblregionaloptions.Region = (select FieldValue from tbldbpreferences where Name = "CompanyRegion")))');
    qry.SQL.Add('limit 1');
    qry.Open;
    result:= qry.FieldByName('Company').AsString;
  finally
    qry.Free;
  end;
end;

function TfmWebAPITest.GetLastInvoiceNumber: integer;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('SELECT SaleID FROM tblsales');
    qry.SQL.Add('WHERE IsInvoice = "T" AND Cancelled = "F" AND Deleted = "F"');
    qry.SQL.Add('ORDER BY SaleID DESC LIMIT 1');
    qry.Open;
    result := qry.FieldByName('SaleID').AsInteger;
  finally
    qry.Free;
  end;
end;

function TfmWebAPITest.GetNewCustomer(IsMarketingContact: boolean = false): TNameRec;
var
  qry: TERPQuery;
  x: integer;
begin
  result.Title:= 'Mr';
  Randomize;
  result.First:= Firsts[Random(15)];
  result.Last:= Lasts[Random(13)];
  result.Name:= result.First + ' ' + result.Last;
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    x:= 0;
    while true do begin
      qry.Close;
      if IsMarketingContact then
        qry.SQL.Text:= 'select Company from tblMarketingContacts where Company = "' + result.Name + '"'
      else
        qry.SQL.Text:= 'select Company from tblClients where Company = "' + result.Name + '"';
      qry.Open;
      if qry.IsEmpty then
        break
      else begin
        Inc(x);
        result.Name:= result.First + ' ' + result.Last + IntToStr(x);
      end;
    end;
  finally
    qry.Free;
  end;
end;

function TfmWebAPITest.GetNewProductName: string;
var
  x: integer;
  qry: TERPQuery;
begin
  x:= 0;
  result:= 'New Product';
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    while true do begin
      qry.Close;
      qry.SQL.Text:= 'select PartName from tblParts where PartName = "' + result + '"';
      qry.Open;
      if qry.IsEmpty then
        break
      else begin
        Inc(x);
        result:= 'New Product ' + IntToStr(x);
      end;
    end;
  finally
    qry.Free;
  end;

end;

function TfmWebAPITest.GetPort: integer;
var
  aURI: TIdURI;
  defPort: integer;
begin
  aURI:= TIdURI.Create(cboURL.Text);
  try
    if SameText(aURI.Protocol,'https') then
      defPort:= 443
    else if SameText(aURI.Protocol,'http') then
      defPort:= 8080
    else
      defPort:= 0;

    result:= StrToIntDef(aURI.Port,defPort);
  finally
    aURI.Free;
  end;
end;

function TfmWebAPITest.GetServer: string;
begin
  result := ExtractServer(cboURL.Text);
end;

function TfmWebAPITest.GetUseSSL: boolean;
begin
  result := Pos('https',Trim(Lowercase(cboURL.Text))) = 1;
end;

function TfmWebAPITest.GetWebAPIConfig(aServer: string;
  var aConfig: TJsonObject; var msg: string): boolean;
var
  Client: TJsonRpcTcpClient;
//  o,
  resp: TJsonObject;
begin
  Result := true;
  Client := TJsonRpcTcpClient.Create;
  try
    Client.RequestWaitSecs:= 30;
    if not ConnectToUtilsModule(Client, aServer, 'ERPModWebAPI', msg) then begin
      Result := False;
      Exit;
    end;

//    o:= JO('{"classname":"THTTPServerConfig"}');
    resp := Client.SendRequest('ERPWebService.GetConfig', nil);
    try
      if Assigned(resp) then begin
        if resp.Exists('result') then begin
          aConfig.Assign(resp.O['result']);
        end;
      end
      else begin
        Result := false;
        msg := 'The server did not returned a result.';
      end;
    finally
      resp.Free;
    end;
  finally
    Client.Free;
  end;

end;

procedure TfmWebAPITest.InputAPItype1Click(Sender: TObject);
var
  fs:String;
  fi:Integer;
  FileName:String;
begin
  inherited;
  if Sender = nil then exit;

  FileName:= SystemLib.ExeDir + 'Last API Name.txt';
  fs:= ComboInput(filename, 'API Type' , 'API Type' , true);
  if fs='' then exit;
  try
    if FindClass(fs) = nil then begin
      MessageDlgXP_Vista('API Type "'+fs+'" Doesn''t Exists', mtWarning, [mbOK], 0);
      Exit;
    end;
  Except
    on E:Exception do begin
      MessageDlgXP_Vista('API Type "'+fs+'" Doesn''t Exists', mtWarning, [mbOK], 0);
      Exit;
    end;
  end;

  fi:=CustomInputinteger(fs +' # ', fs +' # ','');
  if fi <> 0 then fs:=fs+ '/'+ trim(inttostr(fi));

  if fs = '' then Exit;
  AddClassToURL(fs);

  with memRequest.Lines do begin
    Clear;
  end;
  DoRequest('GET');

end;

procedure TfmWebAPITest.LstobjectsDblClick(Sender: TObject);
begin
  inherited;
  if Lstobjects.ItemIndex <0 then exit;
  if sametext(Lstobjects.Items[Lstobjects.ItemIndex] , 'VS1 Clients') then begin
    AddClassToURL('TVS1_Clients');
  end else if sametext(Lstobjects.Items[Lstobjects.ItemIndex] , 'VS1 Databases') then begin
    AddClassToURL('TVS1_databases');
  end else if sametext(Lstobjects.Items[Lstobjects.ItemIndex] , 'VS1 Users') then begin
    AddClassToURL('TVS1_ClientUsers');
  end;
end;

procedure TfmWebAPITest.LoadConfig;
const
  APIHistoryLimit = 40;
var
  Pref: TPreference;
begin
  Config.Clear;

  Pref:= TPreference.Create(nil);
  try
    Pref.Connection:= TMyDacDataConnection.Create(Pref);
    Pref.Connection.Connection:= CommonDbLib.GetSharedMyDacConnection;
    Pref.Load(0,'General',Self.ClassName,'');
    if Pref.Count > 0 then
      Config.AsString:= Pref.PrefValue;
  finally
    Pref.Free;
  end;

//  if Config.Count = 0 then begin
//    { set defaults }
//    Config.S['ERPDatabase']:= 'sample_company';
//    Config.S['ERPUserName']:= 'WebUser';
//    Config.S['ERPUserPassword']:= 'WebUser';
//    Config.S['URL']:= 'HTTPS://' + AppEnv.AppDb.Server + ':443/erpapi/';
//    Config.B['FormatJSON']:= true;
//  end;


//  if (Config.S['URLHistory'] = '') then
//  begin
//    Config.S['URLHistory'] := Config.S['URLText'];
//    SaveConfig;
//  end;

  cboURL.Items.Text := Config.S['URLHistory'];
  while (cboURL.Items.Count > APIHistoryLimit) do
    cboURL.Items.Delete(0);
  cboURL.Text := Config.S['URL'];

  lblPort.Caption := 'Port: ' + IntToStr(Port);
  edtUser.Text:= Config.S['ERPUserName'];
  edtPass.Text:= Config.S['ERPUserPassword'];
  edtDatabase.Text:= Config.S['ERPDatabase'];
  memRequest.Lines.Text:= Config.S['RequestJson'];
  chkFormatJSON.Checked:= Config.B['FormatJSON'];
end;

procedure TfmWebAPITest.memRequestExit(Sender: TObject);
begin
  inherited;
  if Config.S['RequestJson'] <> memRequest.Lines.Text then begin
    Config.S['RequestJson']:= memRequest.Lines.Text;
    if Config.S['URL'] <> cboURL.Text then
      Config.S['URL']:= cboURL.Text;
    SaveConfig;
  end;
end;

procedure TfmWebAPITest.memResponceDblClick(Sender: TObject);
var
  fsFilename:String;
begin
  inherited;

  case MessageDlgXP_Vista('Copy Result Json', mtConfirmation, [], 0 , nil,'','',False,nil,'Copy To Clipboard,Save To file, Cancel') of
  100 : begin
          Clipboard.asText:= memResponce.lines.Text;
        end;
  101 : begin
          if not GuiPrefs.Node.Exists('Options.JsonResultFilename') then GuiPrefs.Node['Options.JsonResultFilename'].asString := '';
          fsFilename := Savefilename('json', GuiPrefs.Node['Options.JsonResultFilename'].asString);
          if fsFilename = '' then exit;
          memResponce.lines.savetofile(fsFilename);
          GuiPrefs.Node['Options.JsonResultFilename'].asString := fsFilename;
        end;
  end;
end;

procedure TfmWebAPITest.SaveConfig;
var
  Pref: TPreference;
begin
  Pref:= TPreference.Create(nil);
  try
    Pref.Connection:= TMyDacDataConnection.Create(Pref);
    Pref.Connection.Connection:= CommonDbLib.GetSharedMyDacConnection;
    Pref.Load(0,'General',Self.ClassName,'');
    Pref.PrefValue:= Config.AsString;
    Pref.Save;
  finally
    Pref.Free;
  end;
end;

procedure TfmWebAPITest.SetPort(const Value: integer);
var
  aURI: TIdURI;
begin
  aURI:= TIdURI.Create(cboURL.Text);
  try
    if Value = 0 then
      aURI.Port := ''
    else
      aURI.Port := IntToStr(Value);

    cboURL.Text := aURI.URI;
    Config.S['URL']:= cboURL.Text;
    SaveConfig;
    lblPort.Caption := 'Port: ' + IntToStr(Value);
  finally
    aURI.Free;
  end;
end;

procedure TfmWebAPITest.SetServer(const Value: string);
var
  s: string;
begin
  s:= ExtractServer(cboURL.Text);
  if s <> '' then
    cboURL.Text := StringReplace(cboURL.Text,s,Value,[])
  else
    cboURL.Text := 'https://' + Value + '/erpapi/';
end;

procedure TfmWebAPITest.SetUseSSL(const Value: boolean);
var
  idx: integer;
begin
  if value then begin
    { use SSL }
    idx:= Pos('https',Trim(Lowercase(cboURL.Text)));
    if idx = 1 then exit;
    idx:= Pos('http',Trim(Lowercase(cboURL.Text)));
    if idx = 1 then
      cboURL.Text := StringReplace(cboURL.Text,'http','https',[rfIgnoreCase]);
  end
  else begin
    { don't use SSL }
    idx:= Pos('https',Trim(Lowercase(cboURL.Text)));
    if idx = 1 then
      cboURL.Text := StringReplace(cboURL.Text,'https','http',[rfIgnoreCase]);
  end;
end;

procedure TfmWebAPITest.tbnAddModulesClick(Sender: TObject);
var
  fiLicenseLevel:Integer;
  Qry :TERPQuery;
begin
  inherited;
  btnvs1credentisal.click;
  memRequest.lines.clear;
  memRequest.lines.add('"'+ TAG_JsonIN +'":{');
  memRequest.lines.add('"'+ TAG_MethodName +'":"'+TASK_VS1_AddModules+'",');
  memRequest.lines.add('"'+ TAG_CLOUD_Params +'":{');
  memRequest.lines.add('   "' + VS1_TAG_CloudUserName +'":"' + inputBox('User name :'   ,'' ,'')+'",');
  memRequest.lines.add('   "' + VS1_TAG_CloudPassword +'":"' + inputBox('Password :'   ,'' ,'')+'",');
  memRequest.lines.add('   "'+VS1_TAG_Paymentamount+'":900,');
  memRequest.lines.add('   "'+VS1_TAG_PayMethod+'":"Cash",');
  fiLicenseLevel := 0;
  Case MessageDlgXP_Vista('License type', mtConfirmation, [], 0, nil, '', '', false, nil,'Simple Start,Essentials,PLUS') of
    100: fiLicenseLevel:= Tvs1_licenselevels.idtoggle('Simple Start');
    101: fiLicenseLevel:= Tvs1_licenselevels.idtoggle('Essentials');
    102: fiLicenseLevel:= Tvs1_licenselevels.idtoggle('PLUS');
  End;
  memRequest.lines.add('   "LicenseLevel":'+inttostr(fiLicenseLevel)+',');
  memRequest.lines.add('                  "'+ VS1_TAG_Price                    +'":70,' );
  memRequest.lines.add('                  "'+ VS1_TAG_DiscountedPrice          +'":70,'   );
  memRequest.lines.add('                  "'+ VS1_TAG_DiscountDesc             +'":"",');
  memRequest.lines.add('                  "'+ VS1_TAG_Renew_Price              +'":70,' );
  memRequest.lines.add('                  "'+ VS1_TAG_Renew_DiscountedPrice    +'":70,' );
  memRequest.lines.add('                  "'+ VS1_TAG_Renew_DiscountDesc       +'":""}');



  memRequest.lines.add('   "ExtraModules":[');
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    qry.sql.text := 'SELECT modulename FROM tblVS1_modules WHERE licenselevel = '+inttostr(fiLicenseLevel)+' AND isextra ="T" ORDER BY modulename';
    qry.open;
    if qry.recordcount>0 then begin
      qry.first;
      While qry.eof = false do begin
        //memRequest.lines.add('           {"ModuleName":"'+trim(qry.fieldbyname('Modulename').asString)+'"}'+ iif(qry.recno=qry.recordcount , '', ','));
        memRequest.lines.add('           {"'+ VS1_TAG_ModuleName+'":"'+trim(qry.fieldbyname('Modulename').asString)+'",');
        memRequest.lines.add('                  "'+ VS1_TAG_Price                    +'":20,' );
        memRequest.lines.add('                  "'+ VS1_TAG_DiscountedPrice          +'":0,'   );
        memRequest.lines.add('                  "'+ VS1_TAG_DiscountDesc             +'":"",');
        memRequest.lines.add('                  "'+ VS1_TAG_Renew_Price              +'":20,' );
        memRequest.lines.add('                  "'+ VS1_TAG_Renew_DiscountedPrice    +'":20,' );
        memRequest.lines.add('                  "'+ VS1_TAG_Renew_DiscountDesc       +'":""}'+iif(qry.recno=qry.recordcount , '', ','));


        qry.Next;
      end;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
  memRequest.lines.add('    ]');
  memRequest.lines.add('}');
  memRequest.lines.add('}');
  memRequest.lines.add('}');
  AddClassToURL('VS1_Cloud_Task/Method?Name="'+TASK_VS1_AddModules+'"');
  highlightcontrol(btnPost);
end;

procedure TfmWebAPITest.UpdateResult(ResultCode: string; ErrorMessage: string = '');
begin
  memResult.Lines.Text:= 'Result Code: ' + ResultCode;
  if ErrorMessage <> '' then
    memResult.Lines.Add('Message: ' + ErrorMessage);
end;

initialization
  RegisterClass(TfmWebAPITest);

finalization

end.
