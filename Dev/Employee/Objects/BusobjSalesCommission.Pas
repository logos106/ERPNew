unit BusobjSalesCommission;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  14/07/09  1.00.00  BJ  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, BusObjEmployeeDetails, BusObjSalebase,
      Busobjstock, busobjproductcommission(*, Progressdialog*);


type
  Tsalescommission = class(TMSBusObj)
  private
    fSalesObj                               : TSalesbase;
    fProduct                                : TProduct;
    function GetSaleId                      : Integer   ;
    function GetSalescommissionCalcId       : Integer   ;
    function GetEmployeeId                  : Integer   ;
    function GetSaleLineId                  : Integer   ;
    function GetProductID                   : Integer   ;

    function GetIsCommissionPercent         : Boolean   ;
    function GetDeleted                     : Boolean   ;
    function GetOverheadbaserate            : Double    ;
    function GetCommissionAmount            : Double    ;
    procedure SetSaleId                      (const Value: Integer   );
    procedure SetSalescommissionCalcId       (const Value: Integer   );
    procedure SetEmployeeId                  (const Value: Integer   );
    procedure SetSaleLineId                  (const Value: Integer   );
    procedure SetProductID                   (const Value: Integer   );
    procedure SetIsCommissionPercent         (const Value: Boolean   );
    procedure SetDeleted                     (const Value: Boolean   );
    procedure SetOverheadbaserate            (const Value: Double    );
    procedure SetCommissionAmount            (const Value: Double    );
    function getEmployee: TEmployeeDetails;
    Function soldQty :Double;
    Function TotalLineAmount:double;
    Function TotalLineAmountInc:double;
    Function TotalCost:Double;
    Function TotalCostinc:Double;
    Function DoProductcommissionCalc:string ;
    Function IsSalepaid:Boolean;
    function getSalesObj: TSalesbase;
    function getproduct: TProduct;
    function getProductcommissionobj: TProductcommission;
    function getIsCommissiononpaidInvoice: Boolean;
    procedure SetIsCommissiononpaidInvoice(const Value: Boolean);
    function getCommissionOn: String;
    procedure SetCommissionOn(const Value: String);
    function getCommissioninvoiceexprice: Boolean;
    procedure SetCommissioninvoiceexprice(const Value: Boolean);
    function getSaledate: TDatetime;
    procedure setSaledate(const Value: TDatetime);
    function getCommissionRate: Double;
    procedure setCommissionRate(const Value: Double);
    function getProductName: String;
    function getemployeeName: String;
    procedure setProductName(const Value: String);
    procedure setemployeeName(const Value: String);
    function getAmountPaID: double;
    function getBalanceamount: Double;
    Function SalesAmount:Double;
    function FloatToCurrency(const Value:Double; Description :String = ''):String;
    function FloatToNum(const Value:Double; Description :String = ''):String;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function DoAfterInsert(Sender:TDatasetBusobj):Boolean ;             Override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Function CalcProductCommission:String;
    Function  CalcEmployeeCommission:String;
    Property employee :TEmployeeDetails read getEmployee;
    Property SalesObj:TSalesbase read getSalesObj  write fSalesObj;
    Property Product :TProduct read getproduct write fProduct;
    Property Productcommissionobj :TProductcommission read getProductcommissionobj;
    Property AmountPaID :double read getAmountPaID;
    Property Balanceamount:Double read getBalanceamount;
    Function EmployeeCommissionDetails:String;
    function ProductcommissionDetails:String;
    Procedure DoCalc(const fSalesAmount,fCommissionRate,fcost,fOverheadbaserate,fLandedCost, fLatestCost:Double);
    Function Formula:String;
    Function ValueFormula(const fSalesAmount, fCommissionRate,fcost, fOverheadbaserate, fLandedCost, fLatestCost: Double) :String;
  published
    property SaleId                       :Integer     read GetSaleId                     write SetSaleId                  ;
    property SalescommissionCalcId        :Integer     read GetSalescommissionCalcId      write SetSalescommissionCalcId   ;
    Property Saledate                     :TDatetime   Read getSaledate                   Write setSaledate;
    property EmployeeId                   :Integer     read GetEmployeeId                 write SetEmployeeId              ;
    property SaleLineId                   :Integer     read GetSaleLineId                 write SetSaleLineId              ;
    property ProductID                    :Integer     read GetProductID                  write SetProductID               ;
    Property ProductName                  :String      read getProductName                Write setProductName;
    Property employeeName                 :String      read getemployeeName               Write setemployeeName;
    property IsCommissionPercent          :Boolean     read GetIsCommissionPercent        write SetIsCommissionPercent;
    property Deleted                      :Boolean     read GetDeleted                    write SetDeleted;
    property Overheadbaserate             :Double      read GetOverheadbaserate           write SetOverheadbaserate        ;
    Property CommissionRate               :Double      read getCommissionRate             write setCommissionRate;
    property CommissionAmount             :Double      read GetCommissionAmount           write SetCommissionAmount        ;
    Property IsCommissiononpaidInvoice             :Boolean     read getIsCommissiononpaidInvoice           Write SetIsCommissiononpaidInvoice;
    property CommissionOn                 :String      Read getCommissionOn               Write SetCommissionOn;
    Property Commissioninvoiceexprice     :Boolean     Read getCommissioninvoiceexprice   write SetCommissioninvoiceexprice;
  end;
  TSalesCommissionUpdate = class(TMSBusObj)
  private
    (*fProgressDialog: TProgressDialog;*)
    function GetCommissionCalculatedOn    : TDateTime ;
    function GetDateFrom                  : TDateTime ;
    function GetDateto                    : TDateTime ;
    function GetemployeeID                : Integer   ;
    procedure SetCommissionCalculatedOn    (const Value: TDateTime );
    procedure SetDateFrom                  (const Value: TDateTime );
    procedure SetDateto                    (const Value: TDateTime );
    procedure SetemployeeID                (const Value: Integer   );
    function  getsalescommission: Tsalescommission;
//    Function NegateCommissionIfEmployeeChanged(Const fSaleID:Integer; const femployeeId:Integer; const fSaleDate:TDatetime):Boolean;
//    Function Calculatecommission(Const ds:Tdataset):String;
    (*Procedure ShowProgressbar(const xCount:Integer);*)
    (*Procedure StepProgressbar;*)
    function getIgnoredateRange: Boolean;
    procedure setIgnoredateRange(const Value: Boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property salescommissions : Tsalescommission read getsalescommission;
    function doCalc:String;

    Function DeleteFlaggedlines:Boolean;
    (*Property ProgressDialog :TProgressDialog read fProgressDialog write fProgressDialog;*)
  published
    property CommissionCalculatedOn     :TDateTime   read GetCommissionCalculatedOn   write SetCommissionCalculatedOn;
    property DateFrom                   :TDateTime   read GetDateFrom                 write SetDateFrom              ;
    Property IgnoredateRange            :Boolean     read getIgnoredateRange          write setIgnoredateRange;
    property Dateto                     :TDateTime   read GetDateto                   write SetDateto                ;
    property employeeID                 :Integer     read GetemployeeID               write SetemployeeID            ;
  end;


implementation


uses sysutils,tcDataUtils, CommonLib, BusObjTrans, tcConst,
  BusObjSales, BusobjCash, ProductQtyLib, AppEnvironment,
  CalcSalescommission;



  {Tsalescommission}

constructor Tsalescommission.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'salescommission';
  fSQL := 'SELECT * FROM tblsalescommission';
  fSalesObj:= nil;
  fProduct := nil;
end;


destructor Tsalescommission.Destroy;
begin
try
  if assigned(fSalesObj) then if assigned(fSalesObj.owner) then IF fSalesObj.Owner = Self then FreeandNil(fSalesObj) else fSalesObj:= nil;
  if assigned(fProduct)    then if assigned(fProduct.Owner) then  IF fProduct.Owner    = Self then Freeandnil(fProduct)    else fProduct:= nil;
except
    //kill the exception
end;
  inherited;
end;


procedure Tsalescommission.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'SaleId');
  SetPropertyFromNode(node,'SalescommissionCalcId');
  SetDateTimePropertyFromNode(Node, 'Saledate');
  SetPropertyFromNode(node,'EmployeeId');
  SetPropertyFromNode(node,'SaleLineId');
  SetPropertyFromNode(node,'ProductID');
  SetPropertyfromnode(node,'ProductName');
  SetPropertyfromnode(node,'employeeName');
  SetBooleanPropertyFromNode(node,'CommissionInvoiceExPrice');
  SetBooleanPropertyFromNode(node,'IsCommissionPercent');
  SetBooleanPropertyFromNode(node,'Deleted');
  SetPropertyFromNode(node,'Overheadbaserate');
  SetPropertyFromNode(node,'CommissionRate');
  SetPropertyFromNode(node,'CommissionAmount');
  SetBooleanPropertyFromNode(node,'IsCommissiononpaidInvoice');
  SetPropertyFromNode(node,'CommissionOn');

end;


procedure Tsalescommission.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'SaleId' ,SaleId);
  AddXMLNode(node,'SalescommissionCalcId' ,SalescommissionCalcId);
  AddXMLNode(node,'Saledate' ,SaleDate);
  AddXMLNode(node,'EmployeeId' ,EmployeeId);
  AddXMLNode(node,'SaleLineId' ,SaleLineId);
  AddXMLNode(node,'ProductID' ,ProductID);
  AddXMLNode(node, 'ProductName' , ProductName);
  AddXMLNode(node, 'employeeName' , employeeName);
  AddXMLNode(node,'IsCommissionPercent' ,IsCommissionPercent);
  AddXMLNode(node,'Deleted' ,Deleted);
  AddXMLNode(node,'Overheadbaserate' ,Overheadbaserate);
  AddXMLNode(node,'CommissionRate' ,CommissionRate);
  AddXMLNode(node,'CommissionInvoiceExPrice' ,CommissionInvoiceExPrice);
  AddXMLNode(node,'CommissionAmount' ,CommissionAmount);
  AddXMLNode(node,'IsCommissiononpaidInvoice' ,IsCommissiononpaidInvoice);
  AddXMLNode(node,'CommissionOn' ,CommissionOn);
end;


function Tsalescommission.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if SaleId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'SaleId should not be 0' , False );
    Exit;
  end;
  if EmployeeId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'EmployeeId should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function Tsalescommission.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tsalescommission.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tsalescommission.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if Sysutils.SameText(Sender.Fieldname , 'ProductID') then begin
    Productname := tcdatautils.GetProduct(ProductID);
(*    CommissionRate := Productcommissionobj.CommissionRate;
    IsCommissionPercent :=Productcommissionobj.IsPercentage;
    CommissionInvoiceExPrice     := Productcommissionobj.CommissionInvoiceExPrice;
    IsCommissiononpaidInvoice    := Productcommissionobj.IsCommissiononpaidInvoice;
    CommissionOn                 := Productcommissionobj.CommissionOn;
    Overheadbaserate             := Productcommissionobj.Overheadbaserate;*)
    PostDB;
  end else if SameText(Sender.fieldName , 'CommissionAmount') then begin
  end else if SameText(Sender.fieldName , 'employeeID') then begin
    employeeName := tcdatautils.getemployeeName(employeeID);
(*    CommissionInvoiceExPrice     := Employee.CommissionInvoiceExPrice;
    IsCommissiononpaidInvoice    := Employee.IsCommissiononpaidInvoice;
    CommissionOn                 := Employee.CommissionOn;
    Overheadbaserate             := Employee.Overheadbaserate;
    CommissionRate               := Employee.CommissionFlatRate;
    IsCommissionPercent          := True;*)
    PostDB;
  end;
end;


function Tsalescommission.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tsalescommission.GetIDField: string;
begin
  Result := 'SalesCommissionId'
end;


class function Tsalescommission.GetBusObjectTablename: string;
begin
  Result:= 'tblsalescommission';
end;


function Tsalescommission.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Tsalescommission.GetSaleId                  : Integer   ; begin Result := GetIntegerField('SaleId');end;
function  Tsalescommission.GetSalescommissionCalcId   : Integer   ; begin Result := GetIntegerField('SalescommissionCalcId');end;
function  Tsalescommission.GetEmployeeId              : Integer   ; begin Result := GetIntegerField('EmployeeId');end;
function  Tsalescommission.GetSaleLineId              : Integer   ; begin Result := GetIntegerField('SaleLineId');end;
function  Tsalescommission.GetProductID               : Integer   ; begin Result := GetIntegerField('ProductID');end;
function  Tsalescommission.GetIsCommissionPercent     : Boolean   ; begin Result := GetBooleanField('IsCommissionPercent');end;
function  Tsalescommission.GetDeleted                 : Boolean   ; begin Result := GetBooleanField('Deleted');end;
function  Tsalescommission.GetOverheadbaserate        : Double    ; begin Result := GetFloatField('Overheadbaserate');end;
function  Tsalescommission.getCommissionRate          : Double    ; begin Result := GetFloatField('CommissionRate');end;
function  Tsalescommission.GetCommissionAmount        : Double    ; begin Result := GetFloatField('CommissionAmount');end;
function  Tsalescommission.getIsCommissiononpaidInvoice:Boolean   ; begin REsult := getBooleanField('IsCommissiononpaidInvoice');end;
function  Tsalescommission.getCommissionOn            : String    ; begin Result := getStringfield('CommissionOn');end;
function  Tsalescommission.getCommissioninvoiceexprice: Boolean   ; begin Result := getBooleanfield('Commissioninvoiceexprice');end;
function  Tsalescommission.getSaledate                : TDatetime ; begin Result := getdatetimefield('Saledate'); end;

procedure Tsalescommission.SetIsCommissiononpaidInvoice(const Value:Boolean   ); begin SetBooleanfield('IsCommissiononpaidInvoice' , Value);end;
procedure Tsalescommission.SetCommissioninvoiceexprice(const Value: Boolean   ); begin SetBooleanfield('Commissioninvoiceexprice' , Value);end;
procedure Tsalescommission.SetCommissionOn            (const Value: String    ); begin if value <> '' then SetStringField('CommissionOn'            , Value);end;
procedure Tsalescommission.SetSaleId                  (const Value: Integer   ); begin SetIntegerField('SaleId'                 , Value);end;
procedure Tsalescommission.SetSalescommissionCalcId   (const Value: Integer   ); begin SetIntegerField('SalescommissionCalcId'                 , Value);end;
procedure Tsalescommission.SetEmployeeId              (const Value: Integer   ); begin SetIntegerField('EmployeeId'             , Value);end;
procedure Tsalescommission.SetSaleLineId              (const Value: Integer   ); begin SetIntegerField('SaleLineId'             , Value);end;
procedure Tsalescommission.SetProductID               (const Value: Integer   ); begin SetIntegerField('ProductID'              , Value);end;
procedure Tsalescommission.SetIsCommissionPercent     (const Value: Boolean   ); begin SetBooleanField('IsCommissionPercent'                , Value);end;
procedure Tsalescommission.SetDeleted                 (const Value: Boolean   ); begin SetBooleanField('Deleted'                , Value);end;
procedure Tsalescommission.SetOverheadbaserate        (const Value: Double    ); begin SetFloatField('Overheadbaserate'         , Value);end;
procedure Tsalescommission.SetCommissionRate          (const Value: Double    ); begin SetFloatField('CommissionRate'   , Value);end;
procedure Tsalescommission.SetCommissionAmount        (const Value: Double    ); begin SetFloatField('CommissionAmount'        , Value);end;
procedure Tsalescommission.setSaledate                (const Value: TDatetime ); begin setdateTimeField('Saledate'              , Value);end;
function Tsalescommission.getEmployee: TEmployeeDetails;
begin
  Result := TEmployeeDetails(getContainerComponent(TEmployeeDetails , 'EmployeeID = ' + IntToStr(EmployeeID)))
end;

function Tsalescommission.soldQty: Double;
begin
  result := 0;
  if Assigned(Self.Owner) then
    if self.Owner is TSalesLineBase then
      REsult := TSalesLineBase(Self.Owner).QtyShipped;
end;


Function Tsalescommission.CalcEmployeeCommission:string ;
var
  saleAmount:Double;
  fdCommissionAmount :Double;
  Salestotalcost:Double;
  SalestotalcostOH:Double;
  saleAmountOH:Double;
  LogDetails :string ;
  LogDetailsFormula:String;
  fdcost:Double;

  Procedure LogResult(const Str:String); begin
    if LogDetails <> '' then LogDetails :=  LogDetails +chr(13);
    Logdetails := LogDetails + str;
  end;
begin
  try
    LogDetails := EmployeeCommissionDetails;
    if not validatedata then begin
      LogResult('Error : validation Failed');
      exit;
    end;
    fdCommissionAmount := 0;
    if Employee.EmployeeHasCommission = False then begin
      LogResult('Error : Employee has no commission');
      exit;
    end;
    if IsSalepaid = False then
      if IsCommissiononpaidInvoice then begin
        LogResult('Error : The Invoice is not paid');
        exit;
      end;

    if CommissionOn = 'I' then begin
      SaleAmount := salesAmount;
      fdCommissionAmount :=SaleAmount *CommissionRate/100;

      LogResult('Commission  := ' +FloatToCurrency(fdCommissionAmount));
      LogDetailsFormula := 'Employee Commission = ' +(*'Sales amount * ' + chr(13) +
                           '                     Commission rate /100' +chr(13) +
                           chr(13) +*)FloatToCurrency(SaleAmount, 'Sales Amount')+'*' +
                           FloatToNum(CommissionRate,'Commission Rate')+'/100 = '+
                           FloatToCurrency(fdCommissionAmount);

    end else if CommissionOn = 'G' then begin

      SaleAmount := salesAmount;
      SalesObj.CalcOrderTotals;
      fdcost :=SalesObj.TotalCost;
      fdCommissionAmount :=(SaleAmount -fdcost)*CommissionRate/100;

      LogResult('Total cost ' +FloatToCurrency(SaleAmount -fdcost));
      LogResult('Commission  : ' +FloatToCurrency(fdCommissionAmount));
      LogDetailsFormula :=  'Employee Commission = ' +(*'(Sales Amount - Total cost) * ' + chr(13) +
                           '                     Commission Rate/100' + chr(13)+chr(13) +
                            '(' +  *)FloatToCurrency(SaleAmount, 'Sales Amount')+'-' +
                                  FloatToCurrency(fdcost, 'Total cost')+')*' +
                                  FloatToNum(CommissionRate, 'Commission Rate') +'/100 = '+
                                  FloatToCurrency(fdCommissionAmount);
    end else if CommissionOn = 'GO' then begin
      SaleAmount := salesAmount;
      Salestotalcost:=SalesObj.TotalProductcost;
      SalestotalcostOH    := Salestotalcost + Salestotalcost *Overheadbaserate/100;
      fdCommissionAmount  :=(SaleAmount -SalestotalcostOH)*CommissionRate/100;


      LogResult('Total Cost                       :' +FloatToCurrency(Salestotalcost));
      LogResult('Total Cost with OH               :' +FloatToCurrency(SalestotalcostOH));
      LogResult('sales amount - Total Cost with OH:' +FloatToCurrency(SaleAmount -SalestotalcostOH));
      LogResult('Commission                       :' +FloatToCurrency(fdCommissionAmount));

      LogDetailsFormula := 'Employee Commission =' +FloatToCurrency(SaleAmount, 'Sales Amount')+' - ' +
                           '(' + FloatToCurrency(Salestotalcost, 'Total Cost')+' + ('+
                           FloatToCurrency(Salestotalcost, 'Total Cost')+'*'+
                           FloatToNum(Overheadbaserate, 'OH %age')+'/100))*'+
                           FloatToNum(CommissionRate, 'Commission Rate')+'/100 = ' +
                           FloatToCurrency(fdCommissionAmount);
     end else if CommissionOn = 'LO' then begin

      SaleAmount := salesAmount;
      Salestotalcost:=SalesObj.TotalLandedCost;
      SalestotalcostOH    := Salestotalcost + Salestotalcost *Overheadbaserate/100;
      fdCommissionAmount  :=(SaleAmount -SalestotalcostOH)*CommissionRate/100;


      LogResult('Total Cost                       :' +FloatToCurrency(Salestotalcost));
      LogResult('Total Cost with OH               :' +FloatToCurrency(SalestotalcostOH));
      LogResult('sales amount - Total Cost with OH:' +FloatToCurrency(SaleAmount -SalestotalcostOH));
      LogResult('Commission                       :' +FloatToCurrency(fdCommissionAmount));

      LogDetailsFormula := 'Employee Commission =' +FloatToCurrency(SaleAmount, 'Sales Amount')+' - ' +
                           '(' + FloatToCurrency(Salestotalcost, 'Total Cost')+' + ('+
                           FloatToCurrency(Salestotalcost, 'Total Cost')+'*'+
                           FloatToNum(Overheadbaserate, 'OH %age')+'/100))*'+
                           FloatToNum(CommissionRate, 'Commission Rate')+'/100 = ' +
                           FloatToCurrency(fdCommissionAmount);
    end else if CommissionOn = 'L' then begin

      SalesObj.CalcOrderTotals;
      saleAmount:=SalesObj.TotalLandedCost;
      saleAmountOH := saleAmount ;//+ saleAmount*Overheadbaserate/100;
      fdCommissionAmount :=saleAmountOH *CommissionRate/100;

      LogResult('Total Landed Cost:' +FloatToCurrency(SaleAmount));
      //LogResult('Total Landed Cost with OH:' +FloatToCurrency(saleAmountOH));
      LogResult('Commission:' +FloatToCurrency(fdCommissionAmount));
      LogDetailsFormula := 'Employee Commission = ' + (*'Landed cost + ' + chr(13) +
                           '                     (Landedcost * OH %age/100)* ' + chr(13) +
                           '                     commission Rate/100 ' + chr(13) +chr(13) +
                        *)'(' +FloatToCurrency(SaleAmount, 'Sales Amount')+' + ' +
                                FloatToCurrency(SaleAmount, 'Sales Amount')+ ' * ' +
                                (*FloatToNum(Overheadbaserate, 'OH %age')+'/100 ) *' +*)
                                FloatToNum(CommissionRate, 'Commission Rate')+'/100 = ' +
                                FloatToCurrency(fdCommissionAmount);

    end else if CommissionOn = 'LT' then begin
      SalesObj.CalcOrderTotals;
      saleAmount := SalesObj.TotalProductTotalLandedCost;
      saleAmountOH := saleAmount ;//+ saleAmount*Overheadbaserate/100;
      fdCommissionAmount :=(saleAmountOH *CommissionRate)/100;

      LogResult('Total Product Total Landed Cost:' +FloatToCurrency(SaleAmount));
      //LogResult('Total Landed Cost with OH:' +FloatToCurrency(saleAmountOH));
      LogResult('Commission:' +FloatToCurrency(fdCommissionAmount));
      LogDetailsFormula := 'Employee Commission = (' +FloatToCurrency(SaleAmount, 'Sales Amount')+' + ' +
                                FloatToCurrency(SaleAmount, 'Sales Amount')+ ' * ' +
                                FloatToNum(CommissionRate, 'Commission Rate')+'/100 = ' +
                                FloatToCurrency(fdCommissionAmount);
    end;

    if fdCommissionAmount <> CommissionAmount then begin
      CommissionAmount :=fdCommissionAmount;
      PostDB;
    end;
  finally
      REsult := LogDetailsFormula + chr(13) + chr(13) + Logdetails;
  end;
end;

Function Tsalescommission.CalcProductCommission:String;
var
  LogDetails:String;
  LogDetailsFormula :String;

  Procedure logResult(Const Value:STring);
  begin
    if LogDetails <> '' then LogDetails := LogDetails + chr(13) ;
    LogDetails := LogDetails + Value;
  end;
begin
  LogDetailsFormula := '';

  try
    if not ValidateData then begin
      LogResult('validation Failed');
      exit;
    end;
    CommissionAmount := 0;
    if  CommissionRate <> 0 then begin
        if IsCommissionPercent then begin
            LogDetails := DoProductcommissionCalc;
        end else begin
          if CommissionAmount <> CommissionRate * soldQty then  begin
              CommissionAmount := CommissionRate * soldQty;
              LogDetails := ProductcommissionDetails;
              LogDetailsFormula := 'Product Commission = ' +(*' CommissionRate * ' + chr(13) +
                           '                     Sold Qty' +chr(13) +chr(13) +
                                   *)FloatToNum(CommissionRate, 'Commission Rate')+'*' +
                                   'Quantity Sold['+ FloatToStr(soldQty) +']=' +
                                   FloatToCurrency(CommissionAmount);
              LogResult('Commission : ' +FloatToCurrency(CommissionAmount));
              postDB;
          end;
        end;
    end;
  finally
    result :=  LogDetailsFormula  + chr(13) + chr(13) + LogDetails;
  end;
end;


Function Tsalescommission.DoProductcommissionCalc:String ;
var
  saleAmount:Double;
  saleAmountOH:Double;
  fdCommissionAmount :Double;
  LogDetails:String;
  LogDetailsFormula :String;
  fdCost:double;

  Procedure logResult(Const Value:STring);
  begin
    if LogDetails <> '' then LogDetails := LogDetails + chr(13) ;
    LogDetails := LogDetails + Value;
  end;
begin
  LogDetails := ProductcommissionDetails;
  try
    fdCommissionAmount:= 0;
    if CommissionRate = 0 then begin
      LogResult('error : Product has no commission');
      exit;
    end;
    if IsSalepaid = False then
      if IsCommissiononpaidInvoice then begin
        LogResult('error : The Invoice is not paid');
        exit;
      end;

    if CommissionOn = 'I' then begin

      SaleAmount := salesAmount;
      fdCommissionAmount :=SaleAmount *CommissionRate/100;

      LogDetailsFormula :='Product Commission = ' +(*'Sales amount * ' + chr(13) +
                           '                     commission Rate/100' +chr(13) +chr(13) +
                          *)FloatToCurrency(SaleAmount, 'Sales Amount')+'*' +
                          FloatToNum(CommissionRate, 'Commission Rate')+'/100 = ' +
                          FloatToCurrency(fdCommissionAmount);
      LogResult('Commission :' +FloatToCurrency(fdCommissionAmount));

    end else if CommissionOn = 'G' then begin
      SaleAmount := salesAmount;
      if Commissioninvoiceexprice then fdCost:= totalcost  else fdCost:= totalcostinc ;
      fdCommissionAmount :=SaleAmount - fdCost *CommissionRate/100;

      LogResult('Sale Amount - Cost:' +FloatToCurrency(SaleAmount - fdCost));
      LogResult('Commission :' +FloatToCurrency(fdCommissionAmount));

      LogDetailsFormula :='Product Commission = ' + (*'(SalesAcount - Total cost) * ' + chr(13) +
                           '                     commission Rate /100' +chr(13) +chr(13) +
                          *)FloatToCurrency(SaleAmount, 'Sales Amount')+' - '+
                          FloatToCurrency(fdCost, 'Total cost')+' *' +
                          FloatToNum(CommissionRate, 'Commission Rate')+'/100 = ' +
                          FloatToCurrency(fdCommissionAmount);

    end else if CommissionOn = 'L' then begin

      saleAmount:=Product.LandedCost;

      if saleAmount = 0 then
        if Commissioninvoiceexprice then saleAmount:=totalcost  else saleAmount:=totalcostinc ;
      saleAmountOH := saleAmount + saleAmount*Overheadbaserate/100;
      fdCommissionAmount :=saleAmountOH *CommissionRate/100;
      LogResult('cost   :' +FloatToCurrency(saleAmount));
      LogResult('cost +OH  :' +FloatToCurrency(saleAmountOH));
      LogResult('Commission :' +FloatToCurrency(fdCommissionAmount));
      LogDetailsFormula :='Product Commission = ' +(*'(Landed cost + ' + chr(13) +
                           '                     LandedCost * OH %age /100)* ' + chr(13) +
                           '                     Commission Rate / 100 ' +chr(13) +chr(13) +
                          *)'(' +FloatToCurrency(SaleAmount, 'Sales Amount') +' + ' +
                          FloatToCurrency(SaleAmount, 'Sales Amount') +'*' +
                          FloatToNum(Overheadbaserate, 'OH %age') +'/100)*' +
                          FloatToNum(CommissionRate, 'Commission Rate') +'/100=' +
                          FloatToCurrency(fdCommissionAmount) ;
    end;
    if CommissionAmount <> fdCommissionAmount then begin
        CommissionAmount := fdCommissionAmount;
        PostDB;
    end;
  finally
      Result :=LogDetailsFormula + chr(13) + chr(13) +LogDetails;
  end;
end;

function Tsalescommission.IsSalepaid: Boolean;
begin
  result := SalesObj.IsPaid;
end;


function Tsalescommission.getSalesObj: TSalesbase;
begin
  if fSalesObj <> nil then begin
      result := fSalesObj;
      Exit;
  end;
  if Assigned(Self.Owner) and (Self.Owner is TSalesLineBase) and (Assigned(TSalesLineBase(Self.Owner).Owner)) and (TSalesLineBase(Self.Owner).Owner is TSalesbase) then
    fSalesObj :=TSalesbase(TSalesLineBase(Self.Owner).Owner);
  if fSalesObj = nil then begin
    fSalesObj:= TSalesbase.create(Self);
    fSalesObj.Load(SaleID);
  end;
  result := fSalesObj;
end;

function Tsalescommission.getproduct: TProduct;
begin
  if fProduct<> nil then begin
      result := fProduct;
      exit;
  end;
  if assigned(Self.Owner) then
    if self.Owner is TSalesLineBase then
      fProduct := TSalesLineBase(Self.Owner).Product;
  if fProduct = nil then begin
      fProduct := TProduct.create(Self);
      fProduct.Load(ProductID);
  end;
  result := fProduct;
end;

function Tsalescommission.getProductcommissionobj: TProductcommission;
begin
  result :=TProductcommission(getcontainercomponent(TProductcommission , 'PartsId = ' +IntToStr(ProductID) + ' and (ifnull(EmployeeId,0) = 0 or ifnull(EmployeeId,0) = ' +IntToStr(EmployeeId) +')'));
end;

function Tsalescommission.TotalLineAmount: double;
begin
  result := 0;
  if Assigned(Self.Owner) then
    if self.Owner is TSalesLineBase then
      REsult := TSalesLineBase(Self.Owner).TotalLineAmount
    else result := SalesObj.TotalAmount;
end;

function Tsalescommission.TotalLineAmountInc: double;
begin
  result := 0;
  if Assigned(Self.Owner) then
    if self.Owner is TSalesLineBase then
      REsult := TSalesLineBase(Self.Owner).TotalLineAmountInc
    else
      result := SalesObj.TotalAmountInc;
end;

function Tsalescommission.TotalCost: Double;
begin
  result := 0;
  if Assigned(Self.Owner) then
    if self.Owner is TSalesLineBase then
        REsult := TSalesLineBase(Self.Owner).Productcost*TSalesLineBase(Self.Owner).QtyShipped
end;

function Tsalescommission.TotalCostinc: Double;
begin
  result := 0;
  if Assigned(Self.Owner) then
    if self.Owner is TSalesLineBase then
      REsult := TSalesLineBase(Self.Owner).LineCostInc*TSalesLineBase(Self.Owner).QtyShipped;
end;
  function Tsalescommission.DoAfterInsert(Sender: TDatasetBusobj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then Exit;
  if Assigned(Self.Owner) then
    if self.owner is TSalesCommissionUpdate then
      SalescommissionCalcId := TSalesCommissionUpdate(Self.Owner).Id;
end;


function Tsalescommission.getProductName: String;
begin
  REsult := getStringfield('ProductName');
end;
function Tsalescommission.getemployeeName: String;
begin
  REsult := getStringfield('employeeName');
end;

procedure Tsalescommission.setProductName(const Value: String);
begin
  SetStringfield('ProductName' , Value);
end;
procedure Tsalescommission.setemployeeName(const Value: String);
begin
  SetStringfield('employeeName' , Value);
end;

function Tsalescommission.getAmountPaID: double;
begin
  with getNewdataset('select Sum(Commissionamount) as Commissionamount from tblpayscommissionlines where SalesCommissionId = ' +IntToStr(ID) , true) do try
    result := fieldbyname('Commissionamount').asFloat;
  finally
      if active then close;
      free;
  end;
end;

function Tsalescommission.getBalanceamount: Double;
begin
  result := CommissionAmount - amountPaid;
end;

function Tsalescommission.EmployeeCommissionDetails: String;
begin
  Result := 'Employee Name : ' + Self.employeeName +chr(13) +
            '--------------------------------------------------';

  if Commissioninvoiceexprice then
        result := result + chr(13) + 'Commission Amount         : Ex'
  else  result := result + chr(13) + 'Commission Amount         : Inc';


        result := result + chr(13) + 'sales Amount (Ex)          : ' + FloatToCurrency(SalesObj.TotalAmount);
        result := result + chr(13) + 'sales Amount (Inc)         : ' + FloatToCurrency(SalesObj.TotalAmountInc);

  if IsCommissiononpaidInvoice then
        result := result + chr(13) + 'Commission on Paid Invoice: Yes'
  else  result := result + chr(13) + 'Commission on Paid Invoice: No';

        result := result + chr(13) + 'Employee commission Rate  : ' + FloatToNum(CommissionRate);
        result := result + chr(13) + 'Employee OH Percentage    : ' + FloatToNum(Overheadbaserate);

  if CommissionOn = 'I' then begin
        result := result + chr(13) + 'Commission on             : Invoice Value';
  end else if CommissionOn = 'G' then begin
        result := result + chr(13) + 'Commission on             : Gross Profit';
  end else if CommissionOn = 'GO' then begin
        result := result + chr(13) + 'Commission on             : Gross Profit with OH';
  end else if CommissionOn = 'LO' then begin
        result := result + chr(13) + 'Commission on             : Landed Cost with OH';
  end else if CommissionOn = 'L' then begin
        result := result + chr(13) + 'Commission on             : Landed Cost'
  end else if CommissionOn = 'LT' then begin
        result := result + chr(13) + 'Commission on             : Total Landed Cost';
  end;
end;

function Tsalescommission.ProductcommissionDetails: String;
begin
  REsult := 'Product Commission :'+Self.ProductName+chr(13) +
            '--------------------------------------------------';
        result := result + chr(13) +'Commission Rate            : ' +FloatToNum(CommissionRate);
  if IsCommissionPercent then
        result := result + '%'
  else  result := result +'$';
        result := result + chr(13) +'Sold Qty                   : ' +FloatToStr(soldQty);
        result := result + chr(13) +'Total Line Amount (Ex)      : ' +FloatToCurrency(TotalLineAmount);
        result := result + chr(13) +'Total Line Amount (Inc)     : ' +FloatToCurrency(TotalLineAmountinc);

        result := result + chr(13) +'Total Cost (ex)             : ' +FloatToCurrency(totalcost);
        result := result + chr(13) +'Total cost (Inc)            : ' +FloatToCurrency(totalcostinc );
        result := result + chr(13) +'Product''s Landed cost     : ' +FloatToCurrency(Product.LandedCost);
end;

function Tsalescommission.SalesAmount: Double;
begin
  if Commissioninvoiceexprice then result := TotalLineAmount else result := TotalLineAmountinc;
end;

function Tsalescommission.FloatToCurrency(const Value:Double; Description :String = ''):String;
begin
  REsult := FloatToStrF(Round(Value,CurrencyRoundPlaces), ffCurrency, 15, CurrencyRoundPlaces);
  if Description <> '' then result := Description + ':' + result;
end;

function Tsalescommission.FloatToNum(const Value: Double; Description :String = ''): String;
begin
  result := FloatTostr(round(Value , OtherRoundPlaces));
  if Description <> '' then result := Description + ':' + result ;
end;

Procedure Tsalescommission.DoCalc(const fSalesAmount, fCommissionRate,
  fcost, fOverheadbaserate, fLandedCost, fLatestCost: Double);
var
  fdCommissionAmount, fdCostOH, saleAmountOH:double;
begin
    fdCommissionAmount:= 0;
    if not IsCommissionPercent then
        fdCommissionAmount :=fCommissionRate
    else begin
      if CommissionOn  = 'I' then begin
          fdCommissionAmount :=fSalesAmount *fCommissionRate/100;
      end else if CommissionOn  = 'G' then begin
          fdCommissionAmount :=(fSalesAmount -fcost)*fCommissionRate/100;
      end else if CommissionOn  = 'GO' then begin
          fdCostOH           := fcost + fcost*fOverheadbaserate;
          fdCommissionAmount :=(fSalesAmount -fdCostOH)*fCommissionRate/100;
      end else if CommissionOn  = 'LO' then begin
          saleAmountOH        := fLandedCost + fLandedCost*fOverheadbaserate;
          fdCommissionAmount :=(fSalesAmount -saleAmountOH)*fCommissionRate/100;
      end else if CommissionOn  = 'L' then begin
          fdCommissionAmount :=fLandedCost *fCommissionRate/100
      end else if CommissionOn  = 'LT' then begin
          fdCommissionAmount :=(fLandedCost + fLatestCost) *fCommissionRate/100;
      end;
    end;
    commissionamount := round(fdCommissionAmount , 2);
    PostDB;
end;


{TSalesCommissionUpdate}

constructor TSalesCommissionUpdate.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SalesCommissionUpdate';
  fSQL := 'SELECT * FROM tblsalescommissionupdates';
(*  fProgressDialog := nil;*)
end;


destructor TSalesCommissionUpdate.Destroy;
begin
  inherited;
end;


procedure TSalesCommissionUpdate.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetDateTimePropertyFromNode(node,'CommissionCalculatedOn');
  SetDateTimePropertyFromNode(node,'DateFrom');
  SetDateTimePropertyFromNode(node,'Dateto');
  SetBooleanPropertyFromnode(node, 'IgnoredateRange');
  SetPropertyFromNode(node,'employeeID');
end;


procedure TSalesCommissionUpdate.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'CommissionCalculatedOn' ,CommissionCalculatedOn);
  AddXMLNode(node,'DateFrom' ,DateFrom);
  AddXMLNode(node,'Dateto' ,Dateto);
  AddXMLNode(node, 'IgnoredateRange' , IgnoredateRange);
  AddXMLNode(node,'employeeID' ,employeeID);
end;


function TSalesCommissionUpdate.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TSalesCommissionUpdate.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSalesCommissionUpdate.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TSalesCommissionUpdate.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TSalesCommissionUpdate.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSalesCommissionUpdate.GetIDField: string;
begin
  Result := 'ID'
end;


class function TSalesCommissionUpdate.GetBusObjectTablename: string;
begin
  Result:= 'tblsalescommissionupdates';
end;


function TSalesCommissionUpdate.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TSalesCommissionUpdate.GetCommissionCalculatedOn: TDateTime ; begin Result := GetDateTimeField('CommissionCalculatedOn');end;
function  TSalesCommissionUpdate.GetDateFrom              : TDateTime ; begin Result := GetDateTimeField('DateFrom');end;
function  TSalesCommissionUpdate.GetDateto                : TDateTime ; begin Result := GetDateTimeField('Dateto');end;
function  TSalesCommissionUpdate.GetemployeeID            : Integer   ; begin Result := GetIntegerField('employeeID');end;
procedure TSalesCommissionUpdate.SetCommissionCalculatedOn(const Value: TDateTime ); begin SetDateTimeField('CommissionCalculatedOn', Value);end;
procedure TSalesCommissionUpdate.SetDateFrom              (const Value: TDateTime ); begin SetDateTimeField('DateFrom'               , Value);end;
procedure TSalesCommissionUpdate.SetDateto                (const Value: TDateTime ); begin SetDateTimeField('Dateto'                 , Value);end;
procedure TSalesCommissionUpdate.SetemployeeID            (const Value: Integer   ); begin SetIntegerField('employeeID'             , Value);end;


function TSalesCommissionUpdate.getsalescommission: Tsalescommission;
begin
  result := Tsalescommission(getContainerComponent(Tsalescommission, 'SalescommissionCalcId = ' + IntToStr(ID)));
end;

function TSalesCommissionUpdate.doCalc: String;
var
  CalcSalescommissionObj:TCalcSalescommissionObj;
begin
  CalcSalescommissionObj:= TCalcSalescommissionObj.create(Self);
  try
    CalcSalescommissionObj.connection := Connection;
    CalcSalescommissionObj.SalescommissionCalcId := ID;
    CalcSalescommissionObj.IgnoredateRange:= IgnoredateRange;
    CalcSalescommissionObj.DateFrom := DateFrom;
    CalcSalescommissionObj.Dateto := DateTo;
    CalcSalescommissionObj.doCalc(nil);
  finally
    Freeandnil(CalcSalescommissionObj);
  end;

(*var
  strSQL:String;
  ds: TDataset;
begin

  result := True;
  strSQL:=  ' Select S.SaleId ,S.employeeId, S.SaleDate, ' +
            'ifnull(S.IsPOS, "F") IsPOS, ' +
            'ifnull(S.IsRefund, "F") IsRefund,  ' +
            'ifnull(S.IsCashSale, "F") as IsCashSale , ' +
            'ifnull(S.IsInvoice, "F") IsInvoice ' +
            ' from tblSales  S ' +
            ' where S.customername <> '+ QuotedStr(CLIENT_CASH) ;
  if IgnoredateRange then
  else begin
      strSQL:= strSQL + ' and SaleDate between ' + QuotedStr(formatDateTime(MysqlDateFormat , DateFrom)) ;
      strSQL := strSQL + ' and  ' + QuotedStr(formatDateTime(MysqlDateFormat , DateTo)) ;
  end;
  strSQL:= strSQL +chr(13) +' and ('+
                          chr(13) +'(' + ISInvoice  + ') or '+
                          chr(13) +'(' + ISRefund   + ') or '+
                          chr(13) +'(' + IsLayby    + ') or '+
                          chr(13) +'(' + ISCashSale + ') ' +
                       chr(13) +' )';
  ds:= getnewDataset(strSQL, true) ;
  with ds do try
    if recordcount >0 then begin
        First;
        ShowProgressbar(recordcount+1);
        try
          while Eof = False do begin
            if not NegateCommissionIfEmployeeChanged(Fieldbyname('SaleID').asInteger, fieldbyname('employeeId').asInteger, fieldbyname('SaleDate').asDateTime) then begin
              Result := False;
              Exit;
            end;
            if Calculatecommission(ds)='' then begin
                Result := False;
                Exit;
            end;
            StepProgressbar;
            next;
          end;
          result := DeleteFlaggedlines;
        finally
            ShowProgressbar(0);
        end;
    end;
  finally
      if ds.active then ds.close;
      Freeandnil(ds);
  end;*)
end;

//function TSalesCommissionUpdate.NegateCommissionIfEmployeeChanged(const fSaleID: Integer; const femployeeId:Integer; const fSaleDate:TDatetime): Boolean;
//var
////  strSQL:string;
//  SC : TSalesCommission;
//begin
//  Result := True;
//  try
//    SC :=TSalesCommission.create(Self);
//    try
//      SC.connection := self.connection;
//      SC.LoadSelect('SaleId = ' +IntToStr(fSaleID)+' and employeeId <> ' +IntToStr(fEmployeeId) +' and Deleted = "F"');
//      if SC.count = 0 then Exit;
//      SC.first;
//      while SC.Eof = False do begin
//        if SC.AmountPaID = 0 then begin
//            SC.Deleted := True;
//            SC.PostDB;
//        end else begin
//          if SC.CommissionAmount <> 0 then SC.CommissionAmount := 0-SC.CommissionAmount;
//          SC.PostDB;
//        end;
//        SC.Next;
//      end;
//    finally
//        FreeandNil(SC);
//    end;
//  Except
//    on E:Exception do begin
//      ResultStatus.Additem(False, rssWarning , 0, 'Update Failed.' +chr(13) +chr(13) +E.Message ,true);
//      REsult := False;
//    end;
//  end;
//
//end;

function TSalesCommissionUpdate.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then Exit;
end;

//function TSalesCommissionUpdate.Calculatecommission(const ds:TDataset): String;
//var
////  strSQL:string;
//  salesObj:TSalesBase;
//begin
//  Result := '';
//  try
//    if ds.fieldbyname('Isinvoice').asBoolean then salesObj:=TInvoice.create(Self)
//    else if (ds.fieldbyname('isCashSale').asBoolean) or (ds.fieldbyname('ispos').asBoolean ) then salesObj:=TCashSale.create(Self)
//    else if ds.fieldbyname('Isrefund').asBoolean then salesObj:=TREfundSale.create(Self)
//    else exit;
//    try
//      salesObj.connection:= self.connection;
//      salesObj.Load(ds.FieldByname('SaleId').asInteger);
//      if salesObj.count = 0 then exit;
//      salesObj.SaleCommissionCalcId := Self.ID;
//      result := salesObj.CalcCommission;
//    finally
//        Freeandnil(salesObj);
//    end;
//  Except
//    on E:Exception do begin
//      ResultStatus.Additem(False, rssWarning , 0, 'Update Failed.' +chr(13) +chr(13) +E.Message ,true);
//      REsult :='';
//    end;
//  end;
//
//end;

Function TSalesCommissionUpdate.DeleteFlaggedlines:Boolean ;
var
  SC : TSalesCommission;
begin
  Result := True;
  try
    SC :=TSalesCommission.create(Self);
    try
      SC.connection := self.connection;
      SC.LoadSelect('Deleted = "T"');
      if SC.count = 0 then Exit;
      SC.DeleteAll;
    finally
      Freeandnil(SC);
    end;
  Except
      on E:Exception do begin
          REsultStatus.addItem(false, rssWarning,0 , 'Update Failed.' +chr(13)+chr(13) + E.Message , true);
          REsult := False;
      end;
  end;

end;

(*procedure TSalesCommissionUpdate.ShowProgressbar(const xCount: Integer);
begin
  if not (Assigned(fProgressDialog)) then exit;
  if xcount = 0 then
    fProgressDialog.CloseDialog
  else begin
    fProgressDialog.Maxvalue      := xCount;
    fProgressDialog.Value := 1;
    fProgressDialog.Execute;
  end;
end;*)

(*procedure TSalesCommissionUpdate.StepProgressbar;
begin
  if not (Assigned(fProgressDialog)) then exit;
  fProgressDialog.Stepit;
end;*)

function TSalesCommissionUpdate.getIgnoredateRange: Boolean;
begin
  result := getbooleanfield('IgnoredateRange');
end;

procedure TSalesCommissionUpdate.setIgnoredateRange(const Value: Boolean);
begin
  setbooleanField('IgnoredateRange' , Value);
end;

Function Tsalescommission.ValueFormula(const fSalesAmount, fCommissionRate,fcost, fOverheadbaserate, fLandedCost, fLatestCost: Double) :String;
  function roundnumber(const Value:Double):String;
  begin
      result := FloatToStrf(Value, ffFixed, 15, 2);
  end;
begin
    if CommissionOn  = 'I' then begin
        REsult := roundnumber(fSalesAmount)+' * '+roundnumber(fCommissionRate)+' /100 ';
    end else if CommissionOn  = 'G' then begin
        REsult :='('+roundnumber(fSalesAmount)+' - '+roundnumber(fCost) +' )* '+roundnumber(fCommissionRate)+' /100 ';
    end else if CommissionOn  = 'GO' then begin
        REsult :='('+roundnumber(fSalesAmount)+' - ('+roundnumber(fCost) +' + ('+roundnumber(fCost)+' * '+roundnumber(fOverheadbaserate) +'  /100)))*'+roundnumber(fCommissionRate)+' /100  ';
    end else if CommissionOn  = 'LO' then begin
        REsult :='('+roundnumber(fSalesAmount)+' - ('+roundnumber(fLandedCost) +' + ('+roundnumber(fLandedCost)+' * '+roundnumber(fOverheadbaserate) +'  /100)))*'+roundnumber(fCommissionRate)+' /100  ';
    end else if CommissionOn  = 'L' then begin
        REsult :=''+roundnumber(fLandedCost) +'  *'+roundnumber(fCommissionRate)+' /100   '
    end else if CommissionOn  = 'LT' then begin
        REsult :=''+roundnumber(fLandedCost + fLatestCost) +'  *'+roundnumber(fCommissionRate)+' /100   ';
    end;

end;

function Tsalescommission.Formula;
  function SalesAmountDesc :String;
  begin
      if CommissionInvoiceExPrice then
        result :='Sales Amount (ex)'
      else result :='Sales Amount (inc)';
  end;
begin
    if CommissionOn  = 'I' then begin
        Result :=SalesAmountDesc+' * Commission Rate /100 ';
    end else if CommissionOn  = 'G' then begin
        Result := '('+SalesAmountDesc+' - Total cost )* Commission Rate /100 ';
    end else if CommissionOn  = 'GO' then begin
        Result :='('+SalesAmountDesc+' - (Total Cost + (Total Cost * OH %age /100)))*Commission Rate /100  ';
    end else if CommissionOn  = 'LO' then begin
      Result :='('+SalesAmountDesc+' - (Landed Cost + (Landed Cost * OH %age /100)))*Commission Rate /100  ';
    end else if CommissionOn  = 'L' then begin
        Result := 'LandedCost  *Commission Rate /100   '
    end else if CommissionOn  = 'LT' then begin
        Result := '(LandedCost + LatestCost)  *Commission Rate /100   ';
    end;
end;

initialization
  RegisterClass(TSalesCommissionUpdate);
  RegisterClass(Tsalescommission);
end.
