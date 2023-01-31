unit WalmartRefundObj;

interface

Uses classes , JSONObject;

Type
  TMeta = class;
  TreturnOrders = class;

  TWalmartRefundJson = class(TJSONObject)
  Private
    function getMeta: TMeta;
    function getreturnOrders(Const index: integer): TreturnOrders;
    procedure SetReturnOrdersJson(const Value: String);
    function getReturnOrdersJson: String;
    function getreturnOrderscount: Integer;
  Public
    Property ReturnOrdersJson :String read getReturnOrdersJson  write SetReturnOrdersJson;
    Property Meta : TMeta read getMeta;
    Property returnOrders[Const index: integer]: TreturnOrders read getreturnOrders;
    Property returnOrderscount :Integer read getreturnOrderscount;
  end;


  TMeta = class(TJSONObject)
  Private
    function getlimit: Integer;
    function gettotalCount: Integer;
    procedure setlimit(const Value: Integer);
    procedure SettotalCount(const Value: Integer);
  Public
      Property totalCount :Integer read gettotalCount write SettotalCount;
      Property limit :Integer read getlimit write setlimit;
  end;
  TcustomerName = class(TJSONObject)
  Private
    function getfirstName: String;
    function getlastName: String;

    procedure setfirstName(const Value: String);
    procedure setlastName(const Value: String);
  Public
    Property firstName :String read getfirstName write setfirstName;
    Property lastName :String read getlastName write setlastName;
  end;
  TAmount = class(TJSONObject)
  Private
    function getcurrencyAmount: double;
    function getcurrencyUnit: String;
    procedure setcurrencyAmount(const Value: double);
    procedure setcurrencyUnit(const Value: String);
  Public
    Property currencyAmount :double read getcurrencyAmount write setcurrencyAmount;
    Property currencyUnit :String read getcurrencyUnit write setcurrencyUnit;
  end;
  TreturnLines= class(TJSONObject)
  Private
    function getreturnOrderLineNumber: Integer;
    procedure setreturnOrderLineNumber(const Value: Integer);
  Public
     Property returnOrderLineNumber :Integer read getreturnOrderLineNumber write setreturnOrderLineNumber;
  end;
  TcarrierInfoList= class(TJSONObject)
  Private
    function getcarrierId: String;
    function getcarrierName: String;
    function getserviceType: String;
    function gettrackingNo: String;

    procedure setcarrierId(const Value: String);
    procedure setcarrierName(const Value: String);
    procedure setserviceType(const Value: String);
    procedure settrackingNo(const Value: String);
  Public
    Property carrierId :String read getcarrierId write setcarrierId;
    Property carrierName :String read getcarrierName write setcarrierName;
    Property serviceType :String read getserviceType write setserviceType;
    Property trackingNo :String read gettrackingNo write settrackingNo;
  end;
  Tlabels= class(TJSONObject)
  Private
    function getlabelImageURL: String;
    function getcarrierInfoList(Const index: integer): TcarrierInfoList;
    procedure SetlabelImageURL(const Value: String);
    function getcarrierInfoListcount: Integer;
  Public
     Property labelImageURL :String read getlabelImageURL write SetlabelImageURL;
     Property carrierInfoList[Const index: integer]: TcarrierInfoList read getcarrierInfoList;
     Property carrierInfoListcount :Integer read getcarrierInfoListcount;
  end;
  TreturnLineGroups= class(TJSONObject)
  Private
    function getgroupNo: Integer;
    function getreturnExpectedFlag: Boolean;
    function getreturnLines(Const index: integer): TreturnLines;
    function getlabels(Const index: integer): Tlabels;
    procedure setgroupNo(const Value: Integer);
    procedure setreturnExpectedFlag(const Value: Boolean);
    function getlabelscount: Integer;
    function getreturnLinescount: Integer;
  Public
    Property groupNo:Integer read getgroupNo write setgroupNo;
    Property returnLines[Const index: integer]: TreturnLines read getreturnLines;
    Property returnLinescount :Integer read getreturnLinescount;
    Property labels[Const index: integer]: Tlabels read getlabels;
    Property labelscount :Integer read getlabelscount;
    Property returnExpectedFlag : Boolean read getreturnExpectedFlag write setreturnExpectedFlag;
  end;
  TUOM= class(TJSONObject)
  Private
    function getunitOfMeasure: String;
    procedure setunitOfMeasure(const Value: String);
    function getmeasurementValue: Double;
    procedure setmeasurementValue(const Value: Double);
  Public
    Property unitOfMeasure :String read getunitOfMeasure write setunitOfMeasure;
    Property measurementValue :Double read getmeasurementValue write setmeasurementValue;
  end;
  Titem = class(TJSONObject)
  Private
    function getsku: String;
    function getproductName: String;
    procedure setsku(const Value: String);
    procedure setproductName(const Value: String);
    function getitemWeight: TUOM;
  Public
    Property sku :String read getsku Write setsku;
    Property productName :String read getproductName Write setproductName;
    Property itemWeight :TUOM read getitemWeight;

  end;
  TchargePerUnit= class(TJSONObject)
  Private
    function getcurrencyAmount: double;
    procedure setcurrencyAmount(const Value: double);
    function getcurrencyUnit: String;
    procedure setcurrencyUnit(const Value: String);
  Public
    Property currencyAmount : double read getcurrencyAmount write setcurrencyAmount;
    Property currencyUnit :String read getcurrencyUnit write setcurrencyUnit;
  end;
  Ttax= class(TJSONObject)
  Private
    function gettaxName: String;
    function getexcessTax: TAmount;
    function gettaxPerUnit: TAmount;

    procedure settaxName(const Value: String);
  Public
    Property taxName :String read gettaxName write settaxName;
    Property excessTax :TAmount read getexcessTax;
    Property taxPerUnit :TAmount read gettaxPerUnit;


  end;
  Treferences= class(TJSONObject)
  Private
    function getrefname: String;
    function getrefValue: String;
    procedure setrefname(const Value: String);
    procedure setrefValue(const Value: String);
  Public
    Property refname :String read getrefname write setrefname;
    Property refValue :String read getrefValue write setrefValue;
  end;
  TCharges= class(TJSONObject)
  Private
    function getchargeCategory: String;
    function getchargeName: String;
    function getchargePerUnit: TchargePerUnit;
    function getisDiscount: Boolean;
    function getisBillable: Boolean;
    procedure setchargeCategory(const Value: String);
    procedure setchargeName(const Value: String);
    procedure setisDiscount(const Value: Boolean);
    procedure setisBillable(const Value: Boolean);
    function gettax(const index:integer): Ttax;
    function getexcessCharge: TAmount;
    function getreferences(const index:integer): Treferences;
    Function getreferencescount:Integer;
    function gettaxCount: Integer;
  Public
    Property chargeCategory :String read getchargeCategory write setchargeCategory;
    Property chargeName :String read getchargeName write setchargeName;
    Property chargePerUnit :TchargePerUnit read getchargePerUnit;
    Property isDiscount :Boolean read getisDiscount write setisDiscount;
    Property isBillable :Boolean read getisBillable write setisBillable;
    Property tax[const index:integer] :Ttax read gettax;
    Property taxCount :Integer read gettaxCount;
    Property excessCharge :TAmount read getexcessCharge;
    Property references[const index:integer] :Treferences read getreferences;
    Property referencescount:Integer read getreferencescount;

  end;
  TchargeTotals= class(TJSONObject)
  Private
    function getChargetotalName: String;
    procedure SetChargeTotalname(const Value: String);
    function getchargetotalValue: TAmount;
  Public
    Property ChargeTotalName:String read getChargetotalName write SetChargeTotalname;
    Property ChargetotalValue :TAmount read getchargetotalValue;
  end;
  TreturnTrackingDetail= class(TJSONObject)
  Private
    function getsequenceNo: Integer;
    function geteventTag: String;
    function geteventDescription: String;
    function geteventTime: String;

    procedure setsequenceNo(const Value: Integer);
    procedure seteventTag(const Value: String);
    procedure seteventDescription(const Value: String);
    procedure seteventTime(const Value: String);
    function getreferences(const index: Integer): Treferences;
    function getreferencescount: Integer;
  Public
    Property sequenceNo :Integer read getsequenceNo write setsequenceNo;
    Property eventTag:String read geteventTag write seteventTag;
    Property eventDescription:String read geteventDescription write seteventDescription;
    Property eventTime:String read geteventTime write seteventTime;
    Property references[const index:Integer]:Treferences read getreferences;
    Property referencescount :Integer read getreferencescount;
  end;
  TreturnOrderLines= class(TJSONObject)
  Private
    function getreturnOrderLineNumber: Integer;
    function getsalesOrderLineNumber: Integer;
    function getreturnReason: String;
    function getpurchaseOrderId: String;
    function getpurchaseOrderLineNumber: Integer;
    function getItem: TItem;
    function getcharges(const index: integer): TCharges;
    function getunitPrice: Tamount;
    function getchargeTotals(const index: Integer): TchargeTotals;
    function getcancellableQty: Double;
    function getquantity: TUOM;
    function getreturnExpectedFlag: Boolean;
    function getisFastReplacement: Boolean;
    function getisKeepIt: Boolean;
    function getlastItem: Boolean;
    function getrefundedQty: Double;
    function getrechargeableQty: Double;
    function getstatus: String;
    function getstatusTime: String;
    function getitemReturnSettings(const Index:Integer): TReferences;
    function getrefundChannel: String;

    procedure setreturnOrderLineNumber(const Value: Integer);
    procedure setsalesOrderLineNumber(const Value: Integer);
    procedure setreturnReason(const Value: String);
    procedure setpurchaseOrderId(const Value: String);
    procedure setpurchaseOrderLineNumber(const Value: Integer);
    procedure setcancellableQty(const Value: Double);
    procedure setreturnExpectedFlag(const Value: Boolean);
    procedure setisFastReplacement(const Value: Boolean);
    procedure setisKeepIt(const Value: Boolean);
    procedure setlastItem(const Value: Boolean);
    procedure setrefundedQty(const Value: Double);
    procedure setrechargeableQty(const Value: Double);
    function getreturnTrackingDetail(const index: Integer): TreturnTrackingDetail;
    procedure setstatus(const Value: String);
    procedure setstatusTime(const Value: String);
    procedure setrefundChannel(const Value: String);
    function getchargescount: integer;
    function getchargeTotalscount: Integer;
    function getitemReturnSettingscount: Integer;
    function getreturnTrackingDetailcount: Integer;
  Public
    Property returnOrderLineNumber : Integer read getreturnOrderLineNumber write setreturnOrderLineNumber;
    Property salesOrderLineNumber : Integer read getsalesOrderLineNumber write setsalesOrderLineNumber;
    Property returnReason :String read getreturnReason write setreturnReason;
    Property purchaseOrderId :String read getpurchaseOrderId write setpurchaseOrderId;
    Property purchaseOrderLineNumber : Integer read getpurchaseOrderLineNumber write setpurchaseOrderLineNumber;
    Property Item :TItem read getItem;
    Property charges[const index:integer]: TCharges read getcharges;
    Property chargescount :integer read getchargescount;
    Property unitPrice : Tamount read getunitPrice;
    Property chargeTotals[const index:Integer]: TchargeTotals read getchargeTotals;
    Property chargeTotalscount :Integer read getchargeTotalscount;
    Property cancellableQty :Double read getcancellableQty write setcancellableQty;
    Property quantity :TUOM read getquantity;
    Property returnExpectedFlag :Boolean read getreturnExpectedFlag write setreturnExpectedFlag;
    Property isFastReplacement :Boolean read getisFastReplacement write setisFastReplacement;
    Property isKeepIt :Boolean read getisKeepIt write setisKeepIt;
    Property lastItem :Boolean read getlastItem write setlastItem;
    Property refundedQty :Double read getrefundedQty write setrefundedQty;
    Property rechargeableQty :Double read getrechargeableQty write setrechargeableQty;
    Property returnTrackingDetail[const index:Integer]:TreturnTrackingDetail read getreturnTrackingDetail;
    Property returnTrackingDetailcount:Integer read getreturnTrackingDetailcount;
    Property status :String read getstatus write setstatus;
    Property statusTime :String read getstatusTime write setstatusTime;
    Property itemReturnSettings[const index :Integer] :TReferences read getitemReturnSettings;
    Property itemReturnSettingscount :Integer read getitemReturnSettingscount;
    Property refundChannel :String read getrefundChannel write setrefundChannel;

  end;
  TreturnChannel= class(TJSONObject)
  Private
    function getchannelName: String;
    procedure setchannelName(const Value: String);
  Public
    Property channelName :String read getchannelName write setchannelName;
  end;
  TreturnOrders = class(TJSONObject)
  Private
    function getreturnOrderId: String;
    function getcustomerEmailId: String;
    function getcustomerOrderId: String;
    function getreturnOrderDate: String;
    function getreturnByDate: String;

    procedure setreturnOrderId(const Value: String);
    procedure setcustomerEmailId(const Value: String);
    procedure setcustomerOrderId(const Value: String);
    procedure setreturnOrderDate(const Value: String);
    procedure setreturnByDate(const Value: String);

    function getcustomerName: TcustomerName;
    function gettotalRefundAmount: TAmount;
    function getreturnLineGroups(const index: integer): TreturnLineGroups;
    function getreturnOrderLines(const index: integer): TreturnOrderLines;
    function getreturnChannel: TreturnChannel;
    function getreturnLineGroupscount: Integer;
    function getreturnOrderLinescount: Integer;
  Public
    Property returnOrderId :String read getreturnOrderId write setreturnOrderId;
    Property customerEmailId :String read getcustomerEmailId write setcustomerEmailId;
    Property customerName : TcustomerName read getcustomerName;
    Property customerOrderId :String read getcustomerOrderId write setcustomerOrderId;
    Property returnOrderDate :String read getreturnOrderDate write setreturnOrderDate;
    Property returnByDate :String read getreturnByDate write setreturnByDate;
    Property totalRefundAmount : TAmount read gettotalRefundAmount;
    Property returnLineGroups[Const index: integer]: TreturnLineGroups read getreturnLineGroups;
    Property returnLineGroupscount :Integer read getreturnLineGroupscount;
    Property returnOrderLines[Const index: integer]: TreturnOrderLines read getreturnOrderLines;
    Property returnOrderLinescount :Integer read getreturnOrderLinescount;
    Property returnChannel :TreturnChannel read getreturnChannel;
  end;


implementation

uses sysutils;


{ TWalmartRefundJson }

function TWalmartRefundJson.getMeta : TMeta;begin  Result := TMeta(O['meta']);end;
function TWalmartRefundJson.getreturnOrders(Const index: integer): TreturnOrders;begin  Result := TreturnOrders(A['returnOrders'].items[index]);end;
function TWalmartRefundJson.getreturnOrderscount: Integer;begin  result := A['returnOrders'].Count;end;

function TWalmartRefundJson.getReturnOrdersJson: String;
begin
  result := Self.AsString;
end;

procedure TWalmartRefundJson.SetReturnOrdersJson(const Value: String);
begin
  Self.AsString := Value;
(*var
  ctr:Integer;
  WalmartOrder :TWalmartOrders;
begin
  Self.AsString := Value;
  if  returnOrders.Count =0 then exit;
  for ctr := 0 to returnOrders.Count -1 do begin
    if returnOrders[ctr].customerOrderId = '' then continue;
    WalmartOrder := TWalmartOrders.CreateWithNewConn(nil);

  end;*)
end;

{ TMeta }
function TMeta.getlimit     : Integer;begin  result := I['limit']     ; end;
function TMeta.gettotalCount: Integer;begin  result := I['totalCount']; end;
procedure TMeta.setlimit     (const Value: Integer);begin  I['limit']      := Value; end;
procedure TMeta.SettotalCount(const Value: Integer);begin  I['totalCount'] := Value; end;

{ TreturnOrders }

function TreturnOrders.getcustomerName: TcustomerName;begin  Result := TcustomerName(O['customerName']);end;
function TreturnOrders.gettotalRefundAmount: TAmount;begin  Result := TAmount(O['totalRefundAmount']);end;

function TreturnOrders.getreturnOrderId: String; begin result := S['returnOrderId']     ; end;
function TreturnOrders.getcustomerEmailId: String; begin result := S['customerEmailId']     ; end;
function TreturnOrders.getcustomerOrderId: String; begin result := S['customerOrderId']     ; end;
function TreturnOrders.getreturnOrderDate: String; begin result := S['returnOrderDate']     ; end;
function TreturnOrders.getreturnByDate: String; begin result := S['returnByDate']     ; end;
function TreturnOrders.getreturnChannel: TreturnChannel; begin   REsult := TreturnChannel(O['returnChannel']); end;
function TreturnOrders.getreturnLineGroups(const index: integer): TreturnLineGroups;begin Result := TreturnLineGroups(A['returnLineGroups'].items[index]);end;
function TreturnOrders.getreturnLineGroupscount: Integer;begin  result := A['returnLineGroups'].Count;end;

function TreturnOrders.getreturnOrderLines(const index: integer): TreturnOrderLines;begin Result := TreturnOrderLines(A['returnOrderLines'].items[index]);end;
function TreturnOrders.getreturnOrderLinescount: Integer;begin  result := A['returnOrderLines'].Count;end;

procedure TreturnOrders.setreturnOrderId(const Value: String); begin S['returnOrderId'] := Value; end;
procedure TreturnOrders.setcustomerEmailId(const Value: String); begin S['customerEmailId'] := Value; end;
procedure TreturnOrders.setcustomerOrderId(const Value: String); begin S['customerOrderId'] := Value; end;
procedure TreturnOrders.setreturnOrderDate(const Value: String); begin S['returnOrderDate'] := Value; end;
procedure TreturnOrders.setreturnByDate(const Value: String); begin S['returnByDate'] := Value; end;

{ TcustomerName }
function TcustomerName.getfirstName: String; begin  result := S['firstName']     ;end;
function TcustomerName.getlastName: String; begin  result := S['lastName']     ;end;
procedure TcustomerName.setfirstName(const Value: String);begin S['firstName']:= Value;end;
procedure TcustomerName.setlastName(const Value: String);begin S['lastName']:= Value;end;

{ TAmount }
function TAmount.getcurrencyAmount: double;begin   REsult := F['currencyAmount'];end;
function TAmount.getcurrencyUnit  : String;begin   REsult := S['currencyUnit']; end;
procedure TAmount.setcurrencyAmount(const Value: Double); begin F['currencyAmount']:= Value; end;
procedure TAmount.setcurrencyUnit  (const Value: String); begin S['currencyUnit'] := Value; end;

{ TreturnLineGroups }
function TreturnLineGroups.getgroupNo           : Integer; begin   Result := I['groupNo']; end;
function TreturnLineGroups.getreturnExpectedFlag: Boolean; begin   Result := B['returnExpectedFlag']; end;
function TreturnLineGroups.getreturnLines(Const index: integer): TreturnLines;begin  Result := TreturnLines(A['returnLines'].items[index]);end;
function TreturnLineGroups.getreturnLinescount: Integer;begin  result := A['returnLines'].Count;end;

function TreturnLineGroups.getlabels(Const index: integer): Tlabels;begin  Result := Tlabels(A['labels'].items[index]);end;
function TreturnLineGroups.getlabelscount: Integer;begin  result := A['labels'].Count;end;

procedure TreturnLineGroups.setgroupNo           (const Value: Integer); begin I['groupNo']            := Value; end;
procedure TreturnLineGroups.setreturnExpectedFlag(const Value: Boolean); begin B['returnExpectedFlag'] := Value; end;

{ TreturnLines }
function TreturnLines.getreturnOrderLineNumber: Integer; begin   Result := i['returnOrderLineNumber']; end;
procedure TreturnLines.setreturnOrderLineNumber(const Value: Integer); begin   I['returnOrderLineNumber'] := Value; end;

{ Tlabels }
function Tlabels.getcarrierInfoListcount: Integer;begin  result := A['carrierInfoList'].Count;end;

function Tlabels.getlabelImageURL: String;begin  result := S['labelImageURL'];end;
procedure Tlabels.SetlabelImageURL(const Value: String); begin   S['labelImageURL'] := Value; end;
function Tlabels.getcarrierInfoList(Const index: integer): TcarrierInfoList;begin  Result := TcarrierInfoList(A['carrierInfoList'].items[index]);end;

{ TcarrierInfoList }
function TcarrierInfoList.getcarrierId: String; begin   REsult := S['carrierId']; end;
function TcarrierInfoList.getcarrierName: String; begin   Result := S['carrierName']; end;
function TcarrierInfoList.getserviceType: String; begin   Result := S['serviceType']; end;
function TcarrierInfoList.gettrackingNo: String; begin   Result := S['trackingNo']; end;
procedure TcarrierInfoList.setcarrierId(const Value: String); begin   S['carrierId'] := Value; end;
procedure TcarrierInfoList.setcarrierName(const Value: String); begin   S['carrierName'] := Value; end;
procedure TcarrierInfoList.setserviceType(const Value: String); begin   S['serviceType'] := Value; end;
procedure TcarrierInfoList.settrackingNo(const Value: String); begin   S['trackingNo'] := Value; end;

{ TreturnOrderLines }
function TreturnOrderLines.getreturnExpectedFlag: Boolean; begin   result := B['returnExpectedFlag']; end;
function TreturnOrderLines.getisFastReplacement: Boolean; begin   result := B['isFastReplacement']; end;
function TreturnOrderLines.getisKeepIt: Boolean; begin   result := B['isKeepIt']; end;
function TreturnOrderLines.getlastItem: Boolean; begin   result := B['lastItem']; end;
function TreturnOrderLines.getreturnOrderLineNumber: Integer;begin   Result := I['returnOrderLineNumber']; end;
function TreturnOrderLines.getsalesOrderLineNumber: Integer;begin   Result := I['salesOrderLineNumber']; end;
function TreturnOrderLines.getunitPrice: Tamount; begin   Result := TAmount(O['unitPrice']); end;
function TreturnOrderLines.getreturnReason: String; begin Result := S['returnReason']; end;
function TreturnOrderLines.getstatusTime: String; begin Result := S['statusTime']; end;
function TreturnOrderLines.getrefundChannel: String; begin Result := S['refundChannel']; end;
function TreturnOrderLines.getstatus: String; begin Result := S['status']; end;
function TreturnOrderLines.getreturnTrackingDetail(const index: Integer): TreturnTrackingDetail; begin   Result := TreturnTrackingDetail(A['returnTrackingDetail'].items[index]); end;
function TreturnOrderLines.getreturnTrackingDetailcount: Integer;begin  result := A['returnTrackingDetail'].Count;end;

function TreturnOrderLines.getcancellableQty: Double; begin   Result := F['cancellableQty']; end;
function TreturnOrderLines.getrefundedQty: Double; begin   Result := F['refundedQty']; end;
function TreturnOrderLines.getrechargeableQty: Double; begin   Result := F['rechargeableQty']; end;
function TreturnOrderLines.getcharges(const index: integer): TCharges; begin   Result := TCharges(A['Charges'].items[index]); end;
function TreturnOrderLines.getchargescount: integer;begin  result := A['charges'].Count;end;

function TreturnOrderLines.getchargeTotals(const index: Integer): TchargeTotals;begin Result := TchargeTotals(A['chargeTotals'].items[index]); end;
function TreturnOrderLines.getchargeTotalscount: Integer;begin  result := A['chargeTotals'].Count;end;

function TreturnOrderLines.getItem: TItem;begin   Result := TItem(O['Item']); end;
function TreturnOrderLines.getitemReturnSettings(const Index:Integer): TReferences; begin   Result := Treferences(A['itemReturnSettings'].items[index]); end;
function TreturnOrderLines.getitemReturnSettingscount: Integer;begin  result := A['itemReturnSettings'].Count;end;

function TreturnOrderLines.getpurchaseOrderId: String; begin Result := S['purchaseOrderId']; end;
function TreturnOrderLines.getpurchaseOrderLineNumber: Integer;begin   Result := I['purchaseOrderLineNumber']; end;
function TreturnOrderLines.getquantity: TUOM; begin   Result := TUOM(O['quantity']); end;
procedure TreturnOrderLines.setreturnExpectedFlag(const Value: Boolean); begin   B['returnExpectedFlag'] := Value; end;
procedure TreturnOrderLines.setisFastReplacement(const Value: Boolean); begin   B['isFastReplacement'] := Value; end;
procedure TreturnOrderLines.setisKeepIt(const Value: Boolean); begin   B['isKeepIt'] := Value; end;
procedure TreturnOrderLines.setlastItem(const Value: Boolean); begin   B['lastItem'] := Value; end;
procedure TreturnOrderLines.setreturnOrderLineNumber(const Value: Integer); begin    I['returnOrderLineNumber'] := Value; end;
procedure TreturnOrderLines.setsalesOrderLineNumber(const Value: Integer); begin    I['salesOrderLineNumber'] := Value; end;
procedure TreturnOrderLines.setreturnReason(const Value: String); begin   S['returnReason'] := Value; end;
procedure TreturnOrderLines.setstatusTime(const Value: String); begin   S['statusTime'] := Value; end;
procedure TreturnOrderLines.setrefundChannel(const Value: String); begin   S['refundChannel'] := Value; end;
procedure TreturnOrderLines.setstatus(const Value: String); begin   S['status'] := Value; end;
procedure TreturnOrderLines.setcancellableQty(const Value: Double); begin   F['cancellableQty'] := Value; end;
procedure TreturnOrderLines.setrefundedQty(const Value: Double); begin   F['refundedQty'] := Value; end;
procedure TreturnOrderLines.setrechargeableQty(const Value: Double); begin   F['rechargeableQty'] := Value; end;
procedure TreturnOrderLines.setpurchaseOrderId(const Value: String); begin   S['purchaseOrderId'] := Value; end;
procedure TreturnOrderLines.setpurchaseOrderLineNumber(const Value: Integer); begin    I['purchaseOrderLineNumber'] := Value; end;

{ itemWeight }
function TUOM.getmeasurementValue: Double; begin   Result := F['measurementValue']; end;
function TUOM.getunitOfMeasure: String; begin   Result := S['unitOfMeasure']; end;
procedure TUOM.setmeasurementValue(const Value: Double); begin   F['measurementValue'] := Value; end;
procedure TUOM.setunitOfMeasure(const Value: String); begin   S['unitOfMeasure'] := Value;end;

{ Titem }
function Titem.getsku: String; begin   Result := S['sku']; end;
function Titem.getitemWeight: TUOM; begin   Result := TUOM(O['itemWeight']); end;
function Titem.getproductName: String; begin   Result := S['productName']; end;
procedure Titem.setsku(const Value: String); begin   S['sku'] := Value; end;
procedure Titem.setproductName(const Value: String); begin   S['productName'] := Value; end;

{ TCharges }
function TCharges.getchargeCategory: String; begin   Result := S['chargeCategory']; end;
function TCharges.getchargeName: String; begin   Result := S['chargeName']; end;
function TCharges.getchargePerUnit: TchargePerUnit; begin   REsult := TchargePerUnit(O['chargePerUnit']); end;
function TCharges.getexcessCharge: TAmount; begin   Result := TAmount(O['excessCharge']); end;
function TCharges.getisDiscount: Boolean; begin   Result := B['isDiscount']; end;
function TCharges.getreferences(const index:integer): Treferences; begin   Result := Treferences(A['references'].items[index]); end;
function TCharges.getreferencescount: Integer;begin result := A['references'].Count;end;

function TCharges.gettax(const index:integer): Ttax; begin   Result := Ttax(A['tax'].items[index]); end;
function TCharges.gettaxCount: Integer; begin result := A['tax'].Count; end;

function TCharges.getisBillable: Boolean; begin   Result := B['isBillable']; end;
procedure TCharges.setchargeCategory(const Value: String); begin    S['chargeCategory'] := Value; end;
procedure TCharges.setchargeName(const Value: String); begin    S['chargeName'] := Value; end;
procedure TCharges.setisDiscount(const Value: Boolean); begin   B['isDiscount'] := Value; end;
procedure TCharges.setisBillable(const Value: Boolean); begin   B['isBillable'] := Value; end;

{ TchargePerUnit }

function TchargePerUnit.getcurrencyAmount: double; begin   Result := F['currencyAmount']; end;
function TchargePerUnit.getcurrencyUnit: String; begin   Result := S['currencyUnit']; end;
procedure TchargePerUnit.setcurrencyAmount(const Value: double); begin   F['currencyAmount'] := Value; end;
procedure TchargePerUnit.setcurrencyUnit(const Value: String); begin   S['currencyUnit'] := Value; end;

{ Ttax }
function Ttax.getexcessTax: TAmount; begin   Result := TAmount(O['excessTax']); end;
function Ttax.gettaxPerUnit: TAmount; begin   Result := TAmount(O['taxPerUnit']); end;
function Ttax.gettaxName: String; begin   result := S['taxName']; end;
procedure Ttax.settaxName(const Value: String); begin   S['taxName'] := Value; end;

{ Treferences }
function Treferences.getrefname: String; begin   Result := S['name']; end;
function Treferences.getrefValue: String; begin   Result := S['value']; end;
procedure Treferences.setrefname(const Value: String); begin   S['name'] := Value; end;
procedure Treferences.setrefValue(const Value: String); begin   S['value'] := Value; end;

{ TchargeTotals }
function TchargeTotals.getChargetotalName: String; begin   Result := S['name']; end;
function TchargeTotals.getchargetotalValue: TAmount; begin   Result := TAmount(O['value']); end;
procedure TchargeTotals.SetChargeTotalname(const Value: String); begin   S['name'] := Value; end;

{ TreturnTrackingDetail }
function TreturnTrackingDetail.geteventTag: String; begin   Result := S['eventTag'];end;
function TreturnTrackingDetail.geteventDescription: String;begin   Result := S['eventDescription']; end;
function TreturnTrackingDetail.geteventTime: String; begin   Result := S['eventTime']; end;
function TreturnTrackingDetail.getreferences(const index: Integer): Treferences; begin   Result := Treferences(A['references'].items[index]); end;
function TreturnTrackingDetail.getreferencescount: Integer;begin result := A['references'].Count;end;

function TreturnTrackingDetail.getsequenceNo: Integer; begin   result := I['sequenceNo']; end;
procedure TreturnTrackingDetail.seteventTag(const Value: String); begin   S['eventTag'] := Value; end;
procedure TreturnTrackingDetail.seteventDescription(const Value: String);begin   S['eventDescription'] := Value; end;
procedure TreturnTrackingDetail.seteventTime(const Value: String); begin   S['eventTime'] := Value; end;
procedure TreturnTrackingDetail.setsequenceNo(const Value: Integer); begin   I['sequenceNo'] := value; end;

{ TreturnChannel }
function TreturnChannel.getchannelName: String; begin   Result := S['channelName']; end;
procedure TreturnChannel.setchannelName(const Value: String); begin   S['channelName']:= value;; end;

end.

