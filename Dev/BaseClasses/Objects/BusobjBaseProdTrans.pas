unit BusobjBaseProdTrans;

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf , busobjstock;

Type
  TProdTransQtyCalcFormulaDetails = class(TMSBusObj)
  private
    function GetTransID                   : Integer   ;
    function GetTransLineID               : Integer   ;
    function GetTransType                 : string    ;
    function GetPartCalcformula           : string    ;
    function GetPartCalcformulaUOMID      : Integer   ;
    function GetPartCalcformulaUOMMult    : Double    ;
    function GetPartCalcFormulaMult       : Double    ;
    procedure SetTransID                   (const Value: Integer   );
    procedure SetTransLineID               (const Value: Integer   );
    procedure SetTransType                 (const Value: string    );
    procedure SetPartCalcformula           (const Value: string    );
    procedure SetPartCalcformulaUOMID      (const Value: Integer   );
    procedure SetPartCalcformulaUOMMult    (const Value: Double    );
    procedure SetPartCalcFormulaMult       (const Value: Double    );
    function getPartCalcformulaUOM: String;

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    procedure CreateInstance;Override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property PartCalcFormulaUOM:String read getPartCalcformulaUOM;
  published
    property TransID                    :Integer     read GetTransID                  write SetTransID               ;
    property TransLineID                :Integer     read GetTransLineID              write SetTransLineID           ;
    property TransType                  :string      read GetTransType                write SetTransType             ;
    property PartCalcformula            :string      read GetPartCalcformula          write SetPartCalcformula       ;
    property PartCalcformulaUOMID       :Integer     read GetPartCalcformulaUOMID     write SetPartCalcformulaUOMID  ;
    property PartCalcformulaUOMMult     :Double      read GetPartCalcformulaUOMMult   write SetPartCalcformulaUOMMult;
    property PartCalcFormulaMult        :Double      read GetPartCalcFormulaMult      write SetPartCalcFormulaMult   ;
  end;

  TProdTrans = Class(TMSBusObj)
    Private
      fbLookupsUseConnection: Boolean;
      function GetProduct: TProduct;
      function getQtyCalcFormulaDetails: TProdTransQtyCalcFormulaDetails;
      function getQtyCalcFormulaDetailsToClone: TProdTransQtyCalcFormulaDetails;


    Protected
      function GetHeaderID: Integer; virtual;
      function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
      function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
      procedure DoFieldOnChange(Sender: TField); override;
      function DoBeforeDelete(Sender: TDatasetBusObj): Boolean; override;
      procedure CopyformulaDetails;virtual;

      procedure SetActive(const Value: Boolean); virtual; abstract;
      function GetActive: Boolean; virtual; abstract;
      function GetUnitOfMeasureID: Integer; virtual; abstract;
      procedure SetUnitOfMeasureID(const Value: Integer); virtual; abstract;
      function GetUOMMultiplier: Double; virtual; abstract;
      procedure SetUOMMultiplier(const Value: Double); virtual; abstract;
      function GetUnitOfMeasure: string; virtual; abstract;
      procedure SetUnitOfMeasure(const Value: string); virtual; abstract;

      Function GetFormulaQtyValue :Double;Virtual;
      Function GetFormulaQtyValue1 :Double;Virtual;
      Function GetFormulaQtyValue2 :Double;Virtual;
      Function GetFormulaQtyValue3 :Double;Virtual;
      Function GetFormulaQtyValue4 :Double;Virtual;
      Function GetFormulaQtyValue5 :Double;Virtual;
      Procedure SetFormulaQtyValue(const Value:Double);Virtual;
      Procedure SetFormulaQtyValue1(const Value:Double);Virtual;
      Procedure SetFormulaQtyValue2(const Value:Double);Virtual;
      Procedure SetFormulaQtyValue3(const Value:Double);Virtual;
      Procedure SetFormulaQtyValue4(const Value:Double);Virtual;
      Procedure SetFormulaQtyValue5(const Value:Double);Virtual;

      Function GetFormulaQtySoldValue :Double;Virtual;
      Function GetFormulaQtySoldValue1 :Double;Virtual;
      Function GetFormulaQtySoldValue2 :Double;Virtual;
      Function GetFormulaQtySoldValue3 :Double;Virtual;
      Function GetFormulaQtySoldValue4 :Double;Virtual;
      Function GetFormulaQtySoldValue5 :Double;Virtual;
      Procedure SetFormulaQtySoldValue(const Value:Double);Virtual;
      Procedure SetFormulaQtySoldValue1(const Value:Double);Virtual;
      Procedure SetFormulaQtySoldValue2(const Value:Double);Virtual;
      Procedure SetFormulaQtySoldValue3(const Value:Double);Virtual;
      Procedure SetFormulaQtySoldValue4(const Value:Double);Virtual;
      Procedure SetFormulaQtySoldValue5(const Value:Double);Virtual;

      Function GetFormulaQtyShippedValue :Double;Virtual;
      Function GetFormulaQtyShippedValue1 :Double;Virtual;
      Function GetFormulaQtyShippedValue2 :Double;Virtual;
      Function GetFormulaQtyShippedValue3 :Double;Virtual;
      Function GetFormulaQtyShippedValue4 :Double;Virtual;
      Function GetFormulaQtyShippedValue5 :Double;Virtual;
      Procedure SetFormulaQtyShippedValue(const Value:Double);Virtual;
      Procedure SetFormulaQtyShippedValue1(const Value:Double);Virtual;
      Procedure SetFormulaQtyShippedValue2(const Value:Double);Virtual;
      Procedure SetFormulaQtyShippedValue3(const Value:Double);Virtual;
      Procedure SetFormulaQtyShippedValue4(const Value:Double);Virtual;
      Procedure SetFormulaQtyShippedValue5(const Value:Double);Virtual;

      function GetProductID: Integer; virtual; abstract;
      function GetProductName: string; virtual; abstract;
      function GetProductPrintName: string; virtual;
      procedure SetProductID(const Value: Integer); virtual; abstract;
      procedure SetProductName(const Value: string); virtual; abstract;
      procedure SetProductPrintName(const Value: string); virtual;

    Public
        constructor Create(AOwner: TComponent); override;
        Function Hasformula :Boolean;

        property Product: TProduct read getProduct;
        Property QtyCalcFormulaDetailsToClone:TProdTransQtyCalcFormulaDetails REad getQtyCalcFormulaDetailsToClone; // this object is used for cloning. for all other purpose use 'QtyCalcFormulaDetails' as it creates the record if there are none
        property HeaderID: Integer read GetHeaderID;
        Property LookupsUseConnection : Boolean read fbLookupsUseConnection write fbLookupsUseConnection;
        Property FormulaQtyValue  :Double read GetFormulaQtyValue  write SetFormulaQtyValue;
        Property FormulaQtyValue1 :Double read GetFormulaQtyValue1 write SetFormulaQtyValue1;
        Property FormulaQtyValue2 :Double read GetFormulaQtyValue2 write SetFormulaQtyValue2;
        Property FormulaQtyValue3 :Double read GetFormulaQtyValue3 write SetFormulaQtyValue3;
        Property FormulaQtyValue4 :Double read GetFormulaQtyValue4 write SetFormulaQtyValue4;
        Property FormulaQtyValue5 :Double read GetFormulaQtyValue5 write SetFormulaQtyValue5;
        Property FormulaQtySoldValue  :Double read GetFormulaQtySoldValue  write SetFormulaQtySoldValue;
        Property FormulaQtySoldValue1 :Double read GetFormulaQtySoldValue1 write SetFormulaQtySoldValue1;
        Property FormulaQtySoldValue2 :Double read GetFormulaQtySoldValue2 write SetFormulaQtySoldValue2;
        Property FormulaQtySoldValue3 :Double read GetFormulaQtySoldValue3 write SetFormulaQtySoldValue3;
        Property FormulaQtySoldValue4 :Double read GetFormulaQtySoldValue4 write SetFormulaQtySoldValue4;
        Property FormulaQtySoldValue5 :Double read GetFormulaQtySoldValue5 write SetFormulaQtySoldValue5;
        Property FormulaQtyShippedValue  :Double read GetFormulaQtyShippedValue  write SetFormulaQtyShippedValue;
        Property FormulaQtyShippedValue1 :Double read GetFormulaQtyShippedValue1 write SetFormulaQtyShippedValue1;
        Property FormulaQtyShippedValue2 :Double read GetFormulaQtyShippedValue2 write SetFormulaQtyShippedValue2;
        Property FormulaQtyShippedValue3 :Double read GetFormulaQtyShippedValue3 write SetFormulaQtyShippedValue3;
        Property FormulaQtyShippedValue4 :Double read GetFormulaQtyShippedValue4 write SetFormulaQtyShippedValue4;
        Property FormulaQtyShippedValue5 :Double read GetFormulaQtyShippedValue5 write SetFormulaQtyShippedValue5;

    Published
        property ProductID: Integer read GetProductID write SetProductID;
        property ProductName: string read GetProductName write SetProductName;
        property ProductPrintName: string read GetProductPrintName write SetProductPrintName;
        property Active: Boolean read GetActive write SetActive;
        property UnitOfMeasureID: Integer read GetUnitOfMeasureID write SetUnitOfMeasureID;
        Property QtyCalcFormulaDetails :TProdTransQtyCalcFormulaDetails REad getQtyCalcFormulaDetails;
        property UOMMultiplier: Double read GetUOMMultiplier write SetUOMMultiplier;
        property UnitOfMeasure: string read GetUnitOfMeasure write SetUnitOfMeasure;
  End;

implementation

uses tcDataUtils, CommonLib , sysutils, BusObjUtils;



{ TProdTrans }
function TProdTrans.getProduct: TProduct;
var
  s: string;
  s1: string;
begin
  if ID = 0 then PostDb; // BJ: this is to get the id if in insert mode
  if Self.ProductName <> '' then begin
    s := 'PartName = ' + Quotedstr(StringDataForSQL(ProductName));
    s1 := 'PARTSID = ' + inttostr(Self.ProductID);
    Result := TProduct(getContainerComponent(TProduct, ProductName,'PartName' ,  Self.SilentMode, LookupsUseConnection, True, s1, True));
  end else begin
    s := 'PARTSID = ' + inttostr(Self.ProductID);
    s1 := 'PartName = ' + Quotedstr(StringDataForSQL(ProductName));
    Result := TProduct(getContainerComponent(TProduct, ProductID,'PARTSID' ,  Self.SilentMode, LookupsUseConnection, True, s1, True));
  end;
//  self.ResultStatus.Clear;
  //Result := TProduct(getContainerComponent(TProduct, s, Self.SilentMode, False, True, s1, True));
end;


procedure TProdTrans.CopyformulaDetails;
begin
  CreateInstance;
  if ObjInstanceToClone.classnameis('TSmartOrderLine') then
  else if ObjInstanceToClone is  TProdTrans then begin
    TProdTrans(ObjInstanceToClone).QtyCalcFormulaDetailsToClone.deleteall;
    if QtyCalcFormulaDetailsToClone.count>0  then QtyCalcFormulaDetailsToClone.Clonebusobj('' , '' , False);
  end;
end;

function TProdTrans.GetProductPrintName: string;begin  REsult := GetStringField('ProductPrintName');end;
Function TProdTrans.GetFormulaQtySoldValue :Double;begin Result := 0;end;
Function TProdTrans.GetFormulaQtySoldValue1 :Double;begin Result := 0;end;
Function TProdTrans.GetFormulaQtySoldValue2 :Double;begin Result := 0;end;
Function TProdTrans.GetFormulaQtySoldValue3 :Double;begin Result := 0;end;
Function TProdTrans.GetFormulaQtySoldValue4 :Double;begin Result := 0;end;
Function TProdTrans.GetFormulaQtySoldValue5 :Double;begin Result := 0;end;
procedure TProdTrans.SetProductPrintName(const Value: string);begin  SetStringfield('ProductPrintName' , Value);end;
Procedure TProdTrans.SetFormulaQtySoldValue(const Value:Double);begin end;
Procedure TProdTrans.SetFormulaQtySoldValue1(const Value:Double);begin end;
Procedure TProdTrans.SetFormulaQtySoldValue2(const Value:Double);begin  end;
Procedure TProdTrans.SetFormulaQtySoldValue3(const Value:Double);begin  end;
Procedure TProdTrans.SetFormulaQtySoldValue4(const Value:Double);begin  end;
Procedure TProdTrans.SetFormulaQtySoldValue5(const Value:Double);begin end;

Function TProdTrans.GetFormulaQtyShippedValue :Double;begin Result :=0;end;
Function TProdTrans.GetFormulaQtyShippedValue1 :Double;begin Result :=0;end;
Function TProdTrans.GetFormulaQtyShippedValue2 :Double;begin Result := 0;end;
Function TProdTrans.GetFormulaQtyShippedValue3 :Double;begin Result := 0;end;
Function TProdTrans.GetFormulaQtyShippedValue4 :Double;begin Result := 0;end;
Function TProdTrans.GetFormulaQtyShippedValue5 :Double;begin Result := 0;end;
Procedure TProdTrans.SetFormulaQtyShippedValue(const Value:Double);begin end;
Procedure TProdTrans.SetFormulaQtyShippedValue1(const Value:Double);begin end;
Procedure TProdTrans.SetFormulaQtyShippedValue2(const Value:Double);begin end;
Procedure TProdTrans.SetFormulaQtyShippedValue3(const Value:Double);begin end;
Procedure TProdTrans.SetFormulaQtyShippedValue4(const Value:Double);begin end;
Procedure TProdTrans.SetFormulaQtyShippedValue5(const Value:Double);begin end;


Function TProdTrans.GetFormulaQtyValue :Double;begin Result :=GetFloatField('FormulaQtyValue');end;
Function TProdTrans.GetFormulaQtyValue1 :Double;begin Result :=GetFloatField('FormulaQtyValue1');end;
Function TProdTrans.GetFormulaQtyValue2 :Double;begin Result :=GetFloatField('FormulaQtyValue2');end;
Function TProdTrans.GetFormulaQtyValue3 :Double;begin Result :=GetFloatField('FormulaQtyValue3');end;
Function TProdTrans.GetFormulaQtyValue4 :Double;begin Result :=GetFloatField('FormulaQtyValue4');end;
Function TProdTrans.GetFormulaQtyValue5 :Double;begin Result :=GetFloatField('FormulaQtyValue5');end;
Procedure TProdTrans.SetFormulaQtyValue(const Value:Double);begin   SetFloatfield('FormulaQtyValue'  , value); end;
Procedure TProdTrans.SetFormulaQtyValue1(const Value:Double);begin  SetFloatfield('FormulaQtyValue1' , value); end;
Procedure TProdTrans.SetFormulaQtyValue2(const Value:Double);begin  SetFloatfield('FormulaQtyValue2' , value); end;
Procedure TProdTrans.SetFormulaQtyValue3(const Value:Double);begin  SetFloatfield('FormulaQtyValue3' , value); end;
Procedure TProdTrans.SetFormulaQtyValue4(const Value:Double);begin  SetFloatfield('FormulaQtyValue4' , value); end;
Procedure TProdTrans.SetFormulaQtyValue5(const Value:Double);begin  SetFloatfield('FormulaQtyValue5' , value); end;


constructor TProdTrans.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  LookupsUseConnection := false;
  ImportFieldsPriorityList.Add('ProductName');
  FieldChangetoIgnoreInRawMode('Linecost');
  FieldChangetoIgnoreInRawMode('LinecostInc');
  FieldChangetoIgnoreInRawMode('LinePrice');
  FieldChangetoIgnoreInRawMode('LinePriceInc');
  FieldChangetoIgnoreInRawMode('totalLineamount');
  FieldChangetoIgnoreInRawMode('totalLineamountinc');
  FieldChangetoIgnoreInRawMode('Discounts');
  FieldChangetoIgnoreInRawMode('DiscountPercent');
  FieldChangetoIgnoreInRawMode('Markup');
  FieldChangetoIgnoreInRawMode('Margin');
  FieldChangetoIgnoreInRawMode('MarkupPercent');
  FieldChangetoIgnoreInRawMode('MarginPercent');
  FieldChangetoIgnoreInRawMode('LineTax');
  FieldChangetoIgnoreInRawMode('QtySold');
  FieldChangetoIgnoreInRawMode('UnitofMeasureQtySold');
  FieldChangetoIgnoreInRawMode('Shipped');
  FieldChangetoIgnoreInRawMode('UnitofMeasureShipped');
  FieldChangetoIgnoreInRawMode('BackOrder');
  FieldChangetoIgnoreInRawMode('UnitofMeasureBackorder');
  FieldChangetoIgnoreInRawMode('ForeignCurrencyLineCost');
  FieldChangetoIgnoreInRawMode('ForeignTotalLineAmount');

end;


function TProdTrans.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
end;

function TProdTrans.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;

end;

function TProdTrans.DoBeforeDelete(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforeDelete(Sender);
  if not Result then Exit;
  if QtyCalcFormulaDetails.count > 0 then QtyCalcFormulaDetails.Delete;
end;

procedure TProdTrans.DoFieldOnChange(Sender: TField);
var
  fQtyCalcFormulaDetails : TProdTransQtyCalcFormulaDetails;
  tmpAccessLevel: integer;
  procedure DoOnProductChange;
  begin
    if (ProductID <> 0) and (not RawMode) then begin
      ProductPrintName := Product.ProductPrintName;
      fQtyCalcFormulaDetails  := QtyCalcFormulaDetails;
      if (not(hasformula)) then begin
        if fQtyCalcFormulaDetails.count > 0  then fQtyCalcFormulaDetails.Deleteall;
      end else begin
        tmpAccessLevel := fQtyCalcFormulaDetails.AccessManager.AccessLevel;
        try
          fQtyCalcFormulaDetails.AccessManager.AccessLevel := 1;
          if fQtyCalcFormulaDetails.TransID                 <> HeaderID                       then fQtyCalcFormulaDetails.TransID                 := HeaderID;
          if fQtyCalcFormulaDetails.PartCalcformula         <> Product.PartCalcformula        then fQtyCalcFormulaDetails.PartCalcformula         := Product.PartCalcformula;
          if fQtyCalcFormulaDetails.PartCalcformulaUOMID    <> Product.PartCalcformulaUOMID   then fQtyCalcFormulaDetails.PartCalcformulaUOMID    := Product.PartCalcformulaUOMID;
          if fQtyCalcFormulaDetails.PartCalcformulaUOMMult  <> Product.PartCalcformulaUOMMult then fQtyCalcFormulaDetails.PartCalcformulaUOMMult  := Product.PartCalcformulaUOMMult;
          if fQtyCalcFormulaDetails.PartCalcFormulaMult     <> Product.PartCalcFormulaMult    then fQtyCalcFormulaDetails.PartCalcFormulaMult     := Product.PartCalcFormulaMult;
          fQtyCalcFormulaDetails.PostDB;
        finally
          fQtyCalcFormulaDetails.AccessManager.AccessLevel := tmpAccessLevel;
        end;
      end;
    end;
  end;

begin

  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;

  if SameText(Sender.fieldname, 'ProductID') or SameText(Sender.fieldname, 'PartsId') or SameText(Sender.fieldname, 'PartId') then begin
    if ProductID > 0 then begin
      self.ProductName := TProduct.IDToggle(ProductID, Connection.Connection);
      self.ResultStatus.Clear;
      DoOnProductChange;
    end
    else begin
      if ProductName <> '' then begin
        { we have probably received a ProductID of 0 through API .. so change it to match ProductName }
        ProductID := TProduct.IDToggle(ProductName, Connection.Connection);
      end;
    end;
  end else if SameText(Sender.fieldname, 'Productname') or SameText(Sender.fieldname, 'Partsname') or SameText(Sender.fieldname, 'Partname') then begin
    if not ComboLinkedPropBlank(self.ProductName) then
      self.ProductID := TProduct.IDToggle(ProductName, Connection.Connection)
    else
      self.ProductID := 0;
    DoOnProductChange;
(*  end else if SameText(Sender.fieldname, 'productprintname') then begin
    Productname := ProductNameForPrintname(productprintname);
    Dofieldonchange(dataset.findfield('Productname'));*)
  end;
end;

function TProdTrans.GetHeaderID: Integer;
begin
  Result := 0;
  if Self.Owner is TBusObj then Result := TBusObj(Self.Owner).ID;
end;
function TProdTrans.getQtyCalcFormulaDetails: TProdTransQtyCalcFormulaDetails;
begin
  REsult := QtyCalcFormulaDetailsToClone;
  if result = nil then exit;

  if not RawMode then begin
    if (ID <> 0) and (Result.count = 0) and (Hasformula) then begin
      Result.New;
    end;
  end;
end;

function TProdTrans.getQtyCalcFormulaDetailsToClone: TProdTransQtyCalcFormulaDetails;
begin
  try
    if ID = 0 then PostnEditDB;
  Except
  end;
  Result := TProdTransQtyCalcFormulaDetails(getContainerComponent(TProdTransQtyCalcFormulaDetails, 'TRansLineID = ' + inttostr(Self.ID) + ' and ifnull(TransType,"") = ' + Quotedstr(Self.Classname)));
end;

function TProdTrans.Hasformula: Boolean;
begin
  result := False;
  if ProductID= 0 then exit;
  if Product.PartCalcformula = '' then exit;
  Result := TRue;
end;


{TProdTransQtyCalcFormulaDetails}

constructor TProdTransQtyCalcFormulaDetails.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ProductTrans';
  fSQL := 'SELECT * FROM tblproducttrans';
  fIsChild := true;
  FieldsnotToclone :=ExcludeFromclone+','+
                        QuotedStr('TransID')+',' +
                        QuotedStr('TransLineID')+',' +
                        QuotedStr('TransType');
end;


destructor TProdTransQtyCalcFormulaDetails.Destroy;
begin
  inherited;
end;


procedure TProdTransQtyCalcFormulaDetails.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'TransID');
  SetPropertyFromNode(node,'TransLineID');
  SetPropertyFromNode(node,'TransType');
  SetPropertyFromNode(node,'PartCalcformula');
  SetPropertyFromNode(node,'PartCalcformulaUOMID');
  SetPropertyFromNode(node,'PartCalcformulaUOMMult');
  SetPropertyFromNode(node,'PartCalcFormulaMult');
end;


procedure TProdTransQtyCalcFormulaDetails.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'TransID' ,TransID);
  AddXMLNode(node,'TransLineID' ,TransLineID);
  AddXMLNode(node,'TransType' ,TransType);
  AddXMLNode(node,'PartCalcformula' ,PartCalcformula);
  AddXMLNode(node,'PartCalcformulaUOMID' ,PartCalcformulaUOMID);
  AddXMLNode(node,'PartCalcformulaUOMMult' ,PartCalcformulaUOMMult);
  AddXMLNode(node,'PartCalcFormulaMult' ,PartCalcFormulaMult);
end;


function TProdTransQtyCalcFormulaDetails.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if TransID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'TransID should not be 0' , False );
    Exit;
  end;
  if TransLineID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'TransLineID should not be 0' , False );
    Exit;
  end;
  if PartCalcformulaUOMID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'PartCalcformulaUOMID should not be 0' , False );
    Exit;
  end;
  if PartCalcformulaUOMMult = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'PartCalcformulaUOMMult should not be 0' , False );
    Exit;
  end;
  if PartCalcFormulaMult = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'PartCalcFormulaMult should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TProdTransQtyCalcFormulaDetails.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TProdTransQtyCalcFormulaDetails.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TProdTransQtyCalcFormulaDetails.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
end;


function TProdTransQtyCalcFormulaDetails.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TProdTransQtyCalcFormulaDetails.GetIDField: string;
begin
  Result := 'ID'
end;


class function TProdTransQtyCalcFormulaDetails.GetBusObjectTablename: string;
begin
  Result:= 'tblproducttrans';
end;


function TProdTransQtyCalcFormulaDetails.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
  if Self.Owner is TProdTrans then begin
    TransLineId := TProdTrans(Self.Owner).ID;
    TransID := TProdTrans(Self.Owner).HeaderID;
    Transtype := TProdTrans(Self.Owner).Classname;
    PostDb;
    EditDB;
  end;
end;

function TProdTransQtyCalcFormulaDetails.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

procedure TProdTransQtyCalcFormulaDetails.CreateInstance;
begin
  inherited;
  if Owner is TProdTrans then
    if Assigned(TProdTrans(Owner).ObjInstanceToClone) and (TProdTrans(Owner).ObjInstanceToClone is TProdTrans) then
      ObjInstanceToClone := TProdTrans(TProdTrans(Owner).ObjInstanceToClone).QtyCalcFormulaDetailsToClone;
end;

{Property Functions}
function  TProdTransQtyCalcFormulaDetails.GetTransID               : Integer   ; begin Result := GetIntegerField('TransID');end;
function  TProdTransQtyCalcFormulaDetails.GetTransLineID           : Integer   ; begin Result := GetIntegerField('TransLineID');end;
function  TProdTransQtyCalcFormulaDetails.GetTransType             : string    ; begin Result := GetStringField('TransType');end;
function  TProdTransQtyCalcFormulaDetails.GetPartCalcformula       : string    ; begin Result := GetStringField('PartCalcformula');end;
function  TProdTransQtyCalcFormulaDetails.GetPartCalcformulaUOMID  : Integer   ; begin Result := GetIntegerField('PartCalcformulaUOMID');end;
function  TProdTransQtyCalcFormulaDetails.GetPartCalcformulaUOMMult: Double    ; begin Result := GetFloatField('PartCalcformulaUOMMult');end;
function  TProdTransQtyCalcFormulaDetails.GetPartCalcFormulaMult   : Double    ; begin Result := GetFloatField('PartCalcFormulaMult');if result =0 then result := 1; end;
function  TProdTransQtyCalcFormulaDetails.getPartCalcformulaUOM    : String    ; begin REsult := GetUOMName(PartCalcformulaUOMID);end;
procedure TProdTransQtyCalcFormulaDetails.SetTransID               (const Value: Integer   ); begin SetIntegerField('TransID'                , Value);end;
procedure TProdTransQtyCalcFormulaDetails.SetTransLineID           (const Value: Integer   ); begin SetIntegerField('TransLineID'            , Value);end;
procedure TProdTransQtyCalcFormulaDetails.SetTransType             (const Value: string    ); begin SetStringField('TransType'              , Value);end;
procedure TProdTransQtyCalcFormulaDetails.SetPartCalcformula       (const Value: string    ); begin SetStringField('PartCalcformula'        , Value);end;
procedure TProdTransQtyCalcFormulaDetails.SetPartCalcformulaUOMID  (const Value: Integer   ); begin SetIntegerField('PartCalcformulaUOMID'   , Value);end;
procedure TProdTransQtyCalcFormulaDetails.SetPartCalcformulaUOMMult(const Value: Double    ); begin SetFloatField('PartCalcformulaUOMMult' , Value);end;
procedure TProdTransQtyCalcFormulaDetails.SetPartCalcFormulaMult   (const Value: Double    ); begin SetFloatField('PartCalcFormulaMult'    , Value);end;


initialization
  RegisterClass(TProdTransQtyCalcFormulaDetails);
end.


