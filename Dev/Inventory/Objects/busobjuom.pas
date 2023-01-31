unit BusobjUOM;

interface

uses
  BusobjProductProperties, ProgressDialog, Busobjbase,  DB,SysUtils,Classes, XMLDoc, MyAccess, ERPdbComponents, XMLIntf;

Type

  TTransLinesUOMDetails = class(TMSBusObj)
  private
    function GetHeight    : Double    ;
    function GetWidth     : Double    ;
    function GetLength    : Double    ;
    function GetWeight    : Double    ;
    Function getNoOfBoxes : Integer   ;
    function GetVolume    : Double    ;
    function GetUnitID    : Integer   ;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
  published
    property Height     :Double      read GetHeight;
    property Width      :Double      read GetWidth ;
    property Length     :Double      read GetLength;
    property Weight     :Double      read GetWeight;
    Property NoOfBoxes  :Integer     read getNoOfBoxes;
    property Volume     :Double      read GetVolume;
    property UnitID     :Integer     read GetUnitID;
  end;

  TUnitOfMeasureInfo = record
    Name: string;
    Multiplier: double;
  end;

  TUnitOfMeasure = class(TMSBusObj)
  private
    fbCopyingUOM: Boolean;
    //fQryClean :TERPQuery;
    function GetBaseUnitName: String;
    function getSalesDefault :Boolean;
    function getPurchasesDefault :Boolean;
    function getUseforAutoSplitQtyinSales :Boolean;
    function GetMultiplier: Double;
    function GetUnitDescription: String;
    function GetUnitName: String;
    procedure	setBaseUnitName(const Value: String);
    Procedure SetSalesDefault(const Value :Boolean);
    Procedure SetPurchasesDefault(const Value :Boolean);
    Procedure SetUseforAutoSplitQtyinSales(const Value :Boolean);
    procedure	setMultiplier(const Value: Double);
    procedure	setUnitDescription(const Value: String);
    procedure	setUnitName(const Value: String);
    function GetUnitId: Integer;
    function GetBaseUnitID: Integer;
    procedure	setBaseUnitID(const Value: Integer);
    procedure	setPArtId (Const value :Integer);
    function GetPartID:Integer;
    function GetActive          : boolean;
    procedure SetActive         (const Value: boolean);
    function getHeight: double;
    function getLength: double;
    function getvolume: double;
    function getWeight: double;
    function getNoOfBoxes:Integer;
    function getwidth: double;
    procedure setHeight(const Value: double);
    procedure Setlength(const Value: double);
    procedure setvolume(const Value: double);
    procedure setWeight(const Value: double);
    Procedure SetNoOfBoxes(const Value:Integer);
    procedure setwidth(const Value: double);
    function GetProductName: string;
    procedure SetProductName(const Value: string);
    function GetUnitProductKeyName: string;
    procedure SetUnitProductKeyName(const Value: string);
    function GetBaseUnitProductKeyName: string;
    procedure SetBaseUnitProductKeyName(const Value: string);
    //function QryClean :TERPQuery;
  protected
    function 	GetSQL: String; override;
    Function ValidateXMLData(Const node :IXMLNode) :Boolean ; override;
    procedure DoFieldOnChange(Sender: TField); override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterOpen(Sender :TDatasetBusObj): Boolean; override;
    procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); Override;

  public
    fUOMDefaulttype :TUOMDefaulttype;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetId: Integer; override;
    class function GetIDField: string; override;
    class function GetKeyStringField: string; override;
    class function GetBusObjectTablename: string; Override;
    function LocateByID(fUnitID: Integer): Boolean;
    function LocateByName(const aUnitName: string): Boolean;
    function 	GetUnitMultiplier(UnitID: Integer): Double;
    procedure LoadFromXMLNode(Const node: IXMLNode); override;
    procedure SaveToXMLNode(Const node: IXMLNode); override;
    Function CreateUOM(fsUnitname:String;fdMultiplier:double;fiPartsId:Integer;fibaseUnitID:Integer;acceptBlankPartID:Boolean=False):Integer;
    Class procedure SetUOMasDefault(const Ids:String; const UOMDefaulttype:TUOMDefaulttype); Overload;
    Procedure SetUOMAsDefault; overload;
    Procedure SetUOMasDefaultCallback(Const Sender: TBusObj; var Abort: Boolean);
    class function MultiplierForUnitID(const aUnitID: integer; Conn: TCustomMyConnection = nil): double;
    class function IdForNameAndMult(const aUnitName: string; aMultiplier: double;PartSId:Integer): integer;
    class function IdForNameAndProductId(const aUnitName: string; aProductId: integer; Conn: TCustomMyConnection = nil): integer;
    class function NameforID(Const aUnitID:Integer; Conn: TCustomMyConnection = nil): String;
    function ValidateData: boolean; override;
    class function BaseUnitIDForName(const aBaseName: string; aProductId: integer; Conn: TCustomMyConnection = nil): integer;
    class function IsParentUOM(const aUnitID: integer; Conn: TCustomMyConnection = nil): boolean;
    class function GetUOMInfo(const aUnitID: integer; Conn: TCustomMyConnection = nil): TUnitOfMeasureInfo;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
    Function Save:Boolean; override;
    class function CreateNewUOM(const uomXML:String; fPartsID:Integer):Boolean;overload;
    class function CreateNewUOM(AOwner:TComponent; fPartsID:Integer;fsUOMName:String;fConnection :TMyDacDataConnection = nil):Integer;overload;
    class function CreateNewUOM(AOwner:TComponent; fPartsID:Integer;fsUOMName:String;fMultiplier:Double;fsUOMDesc:STring; fsBaseuom:String; Connection :TMyDacDataConnection = nil):Integer;overload;
    class function ReadnCreateNewUOM(AOwner:TComponent; fPartsID:Integer;fsUOMName:String;fMultiplier:Double;fsUOMDesc:STring; fsBaseuom:String; Connection :TMyDacDataConnection = nil):TUnitOfMeasure;
    function CreateNewUOM(fPartsID:Integer;fsUOMName:String;fMultiplier:Double;fsUOMDesc:STring; fsBaseuom:String):Integer;overload;
    Property CopyingUOM:Boolean read fbCopyingUOM write fbCopyingUOM;
    Class function  InitBaseUnitID(fsUnitname:String;fdMultiplier:double;fiPartsId:Integer;fibaseUnitID:Integer;Connection :TERPConnection = nil):Integer;
    function IsOkToMerge(Const UOMrectoMerge:TERPQuery; var Msg:String):Boolean;
    Class Function UOMDetails(Const aUOMID:Integer):String;
    Class Function UOMDesc(Const aUOMID:Integer):String;
    Class Function UOMBaseUOM(Const aUOMID:Integer):String;
  Published
    property UnitId: Integer read GetUnitId;
    property UOMName: String read GetUnitName Write SetUnitName;
    property UnitDescription: String read GetUnitDescription Write SetUnitDescription;
    property Multiplier: Double read GetMultiplier Write SetMultiplier;
    property BaseUnitID: Integer read GetBaseUnitID Write SetBaseUnitID;
    property BaseUnitName: String read GetBaseUnitName Write SetBaseUnitName;
    property BaseUnitProductKeyName: string read GetBaseUnitProductKeyName write SetBaseUnitProductKeyName;
    Property SalesDefault :Boolean read getSalesDefault Write SetSalesDefault;
    Property PurchasesDefault :Boolean read getPurchasesDefault Write SetPurchasesDefault;
    Property UseforAutoSplitQtyinSales :Boolean read getUseforAutoSplitQtyinSales Write SetUseforAutoSplitQtyinSales;
    Property PartId :Integer read getPartId Write SetPartID;
    property ProductName: string read GetProductName write SetProductName;
    property Active : boolean read GetActive Write SetActive;
    Property Height :double read getHeight Write setHeight;
    Property Width :double read getwidth Write setwidth;
    Property Length :double read getLength Write setLength;
    Property Volume :double read getvolume Write setvolume;
    Property Weight :double read getWeight Write setWeight;
    Property NoOfBoxes :Integer read getNoOfBoxes write setNoOfBoxes;
    property UnitProductKeyName: string read GetUnitProductKeyName; // write SetUnitProductKeyName;
  end;



implementation

uses CommonDbLib, BusObjStock , variants, BusObjUtils, tcDataUtils,
  ProductQtyLib, BusObjConst, tcConst, BusObjectListObj, BusObjSchemaLib,
  CommonLib, AppEnvironment, DbSharedObjectsObj;
  {TTransLinesUOMDetails}

constructor TTransLinesUOMDetails.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SalesLinesUOMDetails';
  fSQL := 'SELECT UnitID , Height, Width, Length, Weight, Volume , NoOfBoxes FROM tblunitsofmeasure';
end;





class function TTransLinesUOMDetails.GetIDField: string;
begin
  Result := 'UnitID'
end;

class function TTransLinesUOMDetails.GetBusObjectTablename: string;
begin
  Result:= 'tblunitsofmeasure';
end;

{Property Functions}
function  TTransLinesUOMDetails.GetHeight: Double    ; begin Result := GetFloatField('Height');end;
function  TTransLinesUOMDetails.GetWidth : Double    ; begin Result := GetFloatField('Width');end;
function  TTransLinesUOMDetails.GetLength: Double    ; begin Result := GetFloatField('Length');end;
function  TTransLinesUOMDetails.GetWeight: Double    ; begin Result := GetFloatField('Weight'); end;
function  TTransLinesUOMDetails.getNoOfBoxes:Integer ; begin Result := GetIntegerfield('NoOfBoxes');end;
function  TTransLinesUOMDetails.GetVolume: Double    ; begin Result := GetFloatField('Volume');end;
function  TTransLinesUOMDetails.GetUnitID: Integer   ; begin Result := GetIntegerField('UnitID');end;
{TUnitOfMeasure }

Constructor TUnitOfMeasure.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL:= 'SELECT * FROM tblUnitsOfMeasure';
  ExportExcludeList.Add('baseunitid');
  ExportExcludeList.Add('partid');
  ExportExcludeList.Add('unitid');
  fbCopyingUOM := False;
  //fQryClean:= nil;
end;
function TUnitOfMeasure.CreateNewUOM(fPartsID:Integer;fsUOMName:String;fMultiplier:Double;fsUOMDesc:STring; fsBaseuom:String):Integer;
var
  fiBaseUnitID:Integer;
begin
  fiBaseUnitID := 0;
      if fsBaseuom <> '' then
        fiBaseUnitID := CreateNewUOM(fpartsID , fsBaseuom , 1, '' ,'');
      LoadSelect('UnitName =' +quotedstr(fsUOMName) +' and ifnull(PartID,0)='+inttostr(fPartsID));
      if count =0 then begin
         UOMName := fsUOMName;
        PartID := fPartsID;
      end;
      if fMultiplier <> 0 then
        if Multiplier <> fMultiplier then Multiplier := fMultiplier;

      if Multiplier =1 then begin
        BaseUnitID:= 0;
        BaseUnitName:= '';
      end else begin
        BaseUnitID:= fiBaseUnitID;
        BaseUnitName:=  fsBaseuom;
      end;
      Active := True;
      PostDB;
      result := ID;
end;
class function TUnitOfMeasure.ReadnCreateNewUOM(AOwner:TComponent; fPartsID:Integer;fsUOMName:String;fMultiplier:Double;fsUOMDesc:STring; fsBaseuom:String; Connection :TMyDacDataConnection = nil):TUnitOfMeasure;
begin
  if connection = nil then
    Result := TUnitOfMeasure.CreateWithNewConn(AOwner)
  else begin
    Result := TUnitOfMeasure.create(AOwner);
    Result.Connection:= Connection;
  end;
  Result.CreateNewUOM(fPartsID, fsUOMName, fMultiplier, fsUOMDesc, fsBaseuom );
end;
class function TUnitOfMeasure.CreateNewUOM(AOwner:TComponent; fPartsID:Integer;fsUOMName:String;fMultiplier:Double;fsUOMDesc:STring;fsBaseuom:String; Connection :TMyDacDataConnection = nil):Integer;
var
  uom :TUnitOfMeasure;
begin
  try
    UOM := TUnitOfMeasure.ReadnCreateNewUOM(AOwner,fPartsID,fsUOMName,fMultiplier,fsUOMDesc,fsBaseuom,Connection);
    Result := UOM.ID;
  finally
    Freeandnil(UOM);
  end;

  (*if connection = nil then
    uom := TUnitOfMeasure.CreateWithNewConn(AOwner)
  else begin
    uom := TUnitOfMeasure.create(AOwner);
    uom.Connection:= Connection;
  end;
  try
    result := UOM.CreateNewUOM(fPartsID, fsUOMName, fMultiplier, fsUOMDesc, fsBaseuom );
  finally
    Freeandnil(UOM);
  end;*)
end;

class function TUnitOfMeasure.CreateNewUOM(AOwner: TComponent; fPartsID: Integer;fsUOMName: String; fConnection: TMyDacDataConnection = nil):Integer;
var
  uom :TUnitOfMeasure;
  uomXML:String;
  fUOMDs:TERPQuery;
begin
  Result:= 0;
  if fconnection = nil then
    uom := TUnitOfMeasure.CreateWithNewConn(AOwner)
  else begin
    uom := TUnitOfMeasure.create(AOwner);
    uom.Connection := fConnection;
  end;
  uom.IgnoreAccesslevel := true;

  fUOMDs:= DbSharedObj.GetQuery(UOM.connection.connection);
  try
        uom.Dataset := fUOMDs;
        With uom do begin
          LoadSelect('UnitName =' +quotedstr(fsUOMName) +' and ifnull(PartID,0)='+inttostr(fPartsID));
          if count>0 then begin
            Result:= ID;
            Exit;
          end;
          if not userlock.LockAll('tblunitsofmeasure') then begin
            ResultStatus.AddItem(False , rssWarning, 0 , replacestr(replacestr(userlock.LockMessage , 'Unable to update data.' , 'Unable to create new Unit of measure for the product'),'this record' ,'Unit of Measure') , true);
            exit;
          end;
          try
              LoadSelect('UnitName =' +quotedstr(fsUOMName) +' and ifnull(PartID,0)='+inttostr(0));
              if count>0 then begin
                uomXML:= XML;
                connection.BeginNestedTransaction;
                try
                  Load(0);
                  New;
                  CopyingUOM := true;
                  XML := uomXML;
                  PartId := fPartsID;
                  MsUpdateSiteCode :=AppEnv.Branch.SiteCode;
                  Postdb;
                  connection.CommitnestedTransaction;
                  if fconnection = nil then connection.CommitTransaction;
                  Result:= Id;
                Except
                  Connection.RollbacknestedTransaction;
                  if fconnection = nil then connection.RollbackTransaction;
                end;
              end else begin
                connection.BeginNestedTransaction;
                try
                  Load(0);
                  New;
                  CopyingUOM := true;
                  PartId := fPartsID;
                  UOMName := fsUOMName;
                  Multiplier:= 1;
                  MsUpdateSiteCode :=AppEnv.Branch.SiteCode;
                  Postdb;
                  connection.CommitnestedTransaction;
                  if fconnection = nil then connection.CommitTransaction;
                  Result:= Id;
                Except
                  Connection.RollbacknestedTransaction;
                  if fconnection = nil then connection.RollbackTransaction;
                end;
              end;
          finally
            if fconnection = nil then
                userlock.unlock('tblunitsofmeasure' , 0);
          end;
        end;
  finally
    try
      Freeandnil(UOM);
      DbSharedObj.ReleaseObj(fUOMDs);
    except
    end;
  end;
end;

class function TUnitOfMeasure.CreateNewUOM(const uomXML: String;  fPartsID: Integer): Boolean;
begin
  Result:= False;
  With TUnitOfMeasure.CreateWithNewConn(nil) do try
    if not userlock.LockAll('tblunitsofmeasure') then begin
      ResultStatus.AddItem(False , rssWarning, 0 , replacestr(replacestr(userlock.LockMessage , 'Unable to update data.' , 'Unable to create new Unit of measure for the product'),'this record' ,'Unit of Measure') , true);
      result:= False;
      exit;
    end;
    connection.BeginTransaction;
    try
      Load(0);
      New;
      CopyingUOM := true;
      PartId := fPartsID;
      XML := uomXML;
      MsUpdateSiteCode :=AppEnv.Branch.SiteCode;
      Postdb;
      connection.CommitTransaction;
      Result:= True;
    Except
      Connection.RollbackTransaction;
    end;
  finally
    Free;
  end;
end;

Destructor TUnitOfMeasure.Destroy;
begin
(*  if fQryClean<> nil then DbSharedObj.ReleaseObj(fQryClean);//fQryClean.closenfree;
  fQryClean := nil;*)
  inherited;
end;
function TUnitOfMeasure.GetSalesDefault :Boolean;
begin
    result := getbooleanField('SalesDefault');
end;
function TUnitOfMeasure.GetPurchasesDefault :Boolean;
begin
    result := getbooleanField('PurchasesDefault');
end;
function TUnitOfMeasure.GetUseforAutoSplitQtyinSales :Boolean;
begin
    result := getbooleanField('UseforAutoSplitQtyinSales');
end;
function TUnitOfMeasure.GetBaseUnitName: String;
begin
  Result:= GetStringField('BaseUnitName');
end;

function TUnitOfMeasure.GetBaseUnitProductKeyName: string;
begin
  result:= TUnitOfMeasure.IDToggle(BaseUnitID, Connection.Connection);
end;

function TUnitOfMeasure.GetId: Integer;
begin
  Result:= UnitId;
end;
class Function TUnitOfMeasure.GetIDField :String ;
begin
    Result :='UnitID';
end;

class function TUnitOfMeasure.GetBusObjectTablename: string;
begin
  Result := 'tblUnitsOfMeasure';
end;

function TUnitOfMeasure.GetMultiplier: Double;
begin
  Result:= GetFloatField('Multiplier');
end;

function TUnitOfMeasure.GetSQL: String;
begin
  Result:= inherited GetSQL;
end;

function TUnitOfMeasure.GetUnitDescription: String;
begin
  Result:= GetStringField('UnitDescription');
end;

function TUnitOfMeasure.GetUnitId: Integer;
begin
  Result:= GetIntegerField('UnitId');
end;

function TUnitOfMeasure.LocateByID(fUnitID: Integer): Boolean;
begin
  Result:= false;
  if DSReadOk then begin
    Result:= Dataset.Locate('UnitID',fUnitID,[loCaseInsensitive]);
  end;
end;

function TUnitOfMeasure.LocateByName(const aUnitName: string): Boolean;
var
  ProdId: integer;
begin
  if Assigned(Owner) and (Owner is TProduct) then ProdId:= TProduct(Owner).Id
  else ProdId:= 0;
  result:= dataset.Locate('UnitName;PartID',VarArrayOf([aUnitName,ProdId]),[loCaseInsensitive]);
  if (not result) and (ProdId > 0) then
    { try with productId = 0 (ie global Unit Name) }
    result:= dataset.Locate('UnitName;PartID',VarArrayOf([aUnitName,0]),[loCaseInsensitive]);
end;

function TUnitOfMeasure.GetUnitMultiplier(UnitID: Integer): Double;
begin
  Result:= 1;
  if LocateByID(UnitID) then begin
    Result:= Multiplier;
  end;
end;

function TUnitOfMeasure.GetUnitName: String;begin  Result:= GetStringField('UnitName');end;
function TUnitOfMeasure.GetUnitProductKeyName: string;begin  result:= GetStringField('UnitProductKeyName');end;

class function TUnitOfMeasure.GetUOMInfo(const aUnitID: integer;
  Conn: TCustomMyConnection): TUnitOfMeasureInfo;
var
  qry: TERPQuery;
begin
  if Assigned(Conn) then qry := DbSharedObj.GetQuery(Conn)
  else qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('select * from tblunitsofmeasure');
    qry.SQL.Add('where UnitID = ' + IntToStr(aUnitID));
    qry.Open;
    result.Name := qry.FieldByName('UnitName').AsString;
    result.Multiplier := qry.FieldByName('Multiplier').AsFloat;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

Procedure TUnitOfMeasure.SetSalesDefault(const Value :Boolean);begin    SetBooleanField('SalesDefault' , Value);end;
Procedure TUnitOfMeasure.SetPurchasesDefault(const Value :Boolean);begin    SetBooleanField('PurchasesDefault' , Value);end;
Procedure TUnitOfMeasure.SetUseforAutoSplitQtyinSales(const Value :Boolean);begin    SetBooleanField('UseforAutoSplitQtyinSales' , Value);end;
procedure TUnitOfMeasure.SetBaseUnitName(const Value: String);begin  SetStringField('BaseUnitName', Value);end;
procedure TUnitOfMeasure.SetBaseUnitProductKeyName(const Value: string);begin  BaseUnitID:= TUnitOfMeasure.IDToggle(Value, Connection.Connection);end;
procedure TUnitOfMeasure.SetMultiplier(const Value: Double);begin  SetFloatField('Multiplier', Value);end;
procedure TUnitOfMeasure.SetUnitDescription(const Value: String);begin  SetStringField('UnitDescription', Value);end;
procedure TUnitOfMeasure.SetUnitName(const Value: String);begin  SetStringField('UnitName', Value);end;
function TUnitOfMeasure.GetBaseUnitID: Integer;begin  Result := GetIntegerField('BaseUnitID');end;
procedure TUnitOfMeasure.SetBaseUnitID(const Value: Integer);begin  SetIntegerField('BaseUnitID', Value);end;
Procedure TUnitOfMeasure.SetPArtId (Const value :Integer);begin    SetIntegerfield('PartID' , value);end;
Function TUnitOfMeasure.getPartID:Integer;begin    Result := GetIntegerfield('PartID');end;
function TUnitOfMeasure.GetActive: boolean;begin  Result := GetBooleanField('Active');end;
procedure TUnitOfMeasure.SetActive(const Value: boolean);begin  SetBooleanField('Active', Value);end;
function TUnitOfMeasure.getHeight: double;begin  result := getfloatfield('Height');end;
function TUnitOfMeasure.getLength: double;begin result := getfloatfield('Length');end;
function TUnitOfMeasure.getvolume: double;begin result := getfloatfield('Volume');end;
function TUnitOfMeasure.getWeight: double;begin result := getfloatfield('Weight');end;
function TUnitOfMeasure.getNoOfBoxes ;begin result:= GetIntegerField('NoOfBoxes');end;
function TUnitOfMeasure.getwidth: double;begin result := getfloatfield('Width');end;
procedure TUnitOfMeasure.setHeight(const Value: double);begin  setfloatfield('height' , Value );end;
procedure TUnitOfMeasure.Setlength(const Value: double);begin  setfloatfield('Length' , Value );end;
procedure TUnitOfMeasure.setvolume(const Value: double);begin  setfloatfield('Volume' , Value );end;
procedure TUnitOfMeasure.setWeight(const Value: double);begin  setfloatfield('Weight' , Value );end;
Procedure TUnitOfMeasure.SetNoOfBoxes(const Value:Integer);begin SetIntegerField('NoOfBoxes' , value);end;
procedure TUnitOfMeasure.setwidth(const Value: double);begin  setfloatfield('width' , Value );end;
Class Function TUnitOfMeasure.UOMBaseUOM(Const aUOMID:Integer):String;
begin
  result := '';
  With TUnitOfMeasure.CreateWithNewConn(nil) do try
    Load(aUOMID);
    if count =1 then
      result := BaseUnitName;
  finally
    Free;
  end;
end;
class function TUnitOfMeasure.UOMDesc(const aUOMID: Integer): String;
begin
  result := '';
  With TUnitOfMeasure.CreateWithNewConn(nil) do try
    Load(aUOMID);
    if count =1 then begin
      result :=  UOMName;
      if Multiplier <> 1 then result := result + '(' + FloattoStrF(Multiplier , ffGeneral, 15,2)+' '+ BaseUnitName+')';
    end;
  finally
    Free;
  end;

end;

class function TUnitOfMeasure.UOMDetails(const aUOMID: Integer): String;
begin
  result := '';
  With TUnitOfMeasure.CreateWithNewConn(nil) do try
    Load(aUOMID);
    if count =1 then
      result :=  '1 ' + UOMName +' = ' + FloattoStrF(Multiplier , ffGeneral, 15,2)+' '+ BaseUnitName;
  finally
    Free;
  end;
end;

Function TUnitOfMeasure.ValidateXMLData(Const node :IXMLNode) :Boolean ;
var
    iPartID :Integer;
begin
    Result := inherited ValidateXMLData(node);
    if not Result then Exit;
    if not ImportingFromXMLFile then Exit;


    XMLSearchRecorddesc := '';
    if GetXMLNodeStringValue(Node, 'ProductName')  <> '' then XMLSearchRecordDesc := 'Product = ' + GetXMLNodeStringValue(Node, 'ProductName') ;
    if XMLSearchRecorddesc <> '' then XMLSearchRecorddesc := XMLSearchRecorddesc + ' and ';
    XMLSearchRecorddesc := XMLSearchRecorddesc + ' unitname = ' + QuotedStr(GetXMLNodeStringValue(Node, 'UnitName'));

    REsult := false;
{Foreign keys}
    {UOM can have blank PartsId which is common for all the parts}
    iPartId := 0;
    if GetXMLNodeStringValue(Node, 'ProductName') <> '' then begin
        iPartId := checkProduct(Self, node, 'ProductName');
        if  iPartID = 0 then begin
            ErrRecordNotfound('ProductName' , GetXMLNodeStringValue(Node, 'ProductName'));
            Exit;
        End;
    end;
    {base unit will have multiplier 1 always, baseunit can be blank too}
    if GetXMLNodeStringValue(Node, 'BaseUnitName') <> '' then
        if GetXMLNodeStringValue(Node, 'BaseUnitProductName') <> '' then
            if tcdataUtils.GetUnitOfMeasureID(GetXMLNodeStringValue(Node, 'BaseUnitName') , tcDatautils.getproduct(GetXMLNodeStringValue(Node, 'BaseUnitProductName'))) = 0 then begin
                ErrRecordNotfound('Base Unit' , GetXMLNodeStringValue(Node, 'BaseUnitName'));
                Exit;
            end;
    Result := True;

{Duplicate records}
    {if all valid then generate the where clause to search for the record}
    XMLSearchRecord := '';
    if iPartId <> 0 then XMLSearchRecord := 'PartId = ' + IntToStr(iPartID);
    if XMLSearchRecord <> '' then XMLSearchRecord := XMLSearchRecord + ' and ';
    XMLSearchRecord := XMLSearchRecord + ' unitname = ' + QuotedStr(GetXMLNodeStringValue(Node, 'UnitName'));
    LocateXMLRecord; // stores the recordcount
end;


class function TUnitOfMeasure._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TProductWeb','ProductObj','PartID','ID');
  TBOSchema.AddRefType(result,'TProductWeb','ProductObj','ProductName','ProductName');
  TBOSchema.AddRefType(result,'TUnitOfMeasure','BaseUnitObj','BaseUnitID','ID');
  TBOSchema.AddRefType(result,'TUnitOfMeasure','BaseUnitObj','BaseUnitProductKeyName','UnitProductKeyName');
end;

procedure TUnitOfMeasure.LoadFromXMLNode(Const node: IXMLNode);
begin
    inherited;
    if CopyingUOM =false then
      if not  ImportingFromXMLFile then begin
        SetPropertyFromNode(Node,'BaseUnitID');
        SetPropertyFromNode(Node,'PartId');
      end else begin
        if GetXMLNodeStringValue(Node, 'BaseUnitName') <> '' then
            if GetXMLNodeStringValue(Node, 'BaseUnitProductName') <> '' then
                BaseUnitID:= tcdataUtils.GetUnitOfMeasureID(GetXMLNodeStringValue(Node, 'BaseUnitName') , tcDatautils.getproduct(GetXMLNodeStringValue(Node, 'BaseUnitProductName')));
        PartID := CheckProduct(Self, node,'ProductName');
      End;
    SetPropertyFromNode(Node,'UOMName');
    SetPropertyFromNode(Node,'UnitDescription');
    SetPropertyFromNode(Node,'Multiplier');
    SetPropertyFromNode(Node,'BaseUnitName');
    SetBooleanPropertyFromNode(Node, 'SalesDefault');
    SetBooleanPropertyFromNode(Node, 'PurchasesDefault');
    SetBooleanPropertyFromNode(Node, 'UseforAutoSplitQtyinSales');
    SetPropertyFromNode(Node,'Width');
    SetPropertyFromNode(Node,'Length');
    SetPropertyFromNode(Node,'height');
    SetPropertyFromNode(Node,'volume');
    SetPropertyFromNode(Node,'Weight');
    SetPropertyFromNode(Node,'NoOfBoxes');
    SetPropertyFromNode(Node,'UnitProductKeyName');

end;

function TUnitOfMeasure.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TUnitOfMeasure.SaveToXMLNode(Const node: IXMLNode);
begin
    inherited;
    if CopyingUOM =false then
      if not SavingXMLTofile then begin
        AddXMLNode(node , 'BaseUnitID', 	 BaseUnitID);
          AddXMLNode(node , 'PartId', 		     PartId);
      end else begin
          AddXMLNode(node , 'ProductName', 		     getProduct(PartId));
          AddXMLNode(node , 'BaseUnitProductName',   getUnitProductName(baseUnitID));
      end;
    AddXMLNode(node , 'UOMName', 	 UOMName);
	  AddXMLNode(node , 'UnitDescription',   UnitDescription);
	  AddXMLNode(node , 'Multiplier', 	 Multiplier);
	  AddXMLNode(node , 'BaseUnitName',  BaseUnitName);
    AddXMLNode(node , 'SalesDefault',  SalesDefault);
    AddXMLNode(node , 'PurchasesDefault',  PurchasesDefault);
    AddXMLNode(node , 'UseforAutoSplitQtyinSales',  UseforAutoSplitQtyinSales);
    AddXMLNode(node , 'Width', Width);
    AddXMLNode(node , 'Length', Length);
    AddXMLNode(node , 'height', height);
    AddXMLNode(node , 'volume', volume);
    AddXMLNode(node , 'Weight', Weight);
    AddXMLNode(node , 'NoOfBoxes', NoOfBoxes);
    AddXMLNode(node , 'UnitProductKeyName', UnitProductKeyName);
end;

class function TUnitOfMeasure.IdForNameAndMult(const aUnitName: string;
  aMultiplier: double;PartSId:Integer): integer;
var
  qry: TMyQuery;
begin
  REsult := 0;
  qry:= TMyQuery.Create(nil);
  try
    qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    Qry.SQL.add('select PartId, UnitId from tblUnitsOfMeasure '+
                ' where UnitName = ' + QuotedStr(aUnitName) +
                ' and Multiplier = ' + FloatToStr(aMultiplier)+
                ' and (ifnull(PartId,0) = ' +inttostr(PartSId) +' or ifnull(Partid,0) =0) '+
                ' order by partID desc');
    qry.Open;
    if Qry.recordcount >0 then begin
      qry.First;
      result:= qry.FieldByName('UnitId').AsInteger;
    end;
  finally
    qry.Free;
  end;
end;
class function TUnitOfMeasure.NameforID(Const aUnitID:Integer; Conn: TCustomMyConnection = nil): String;
var
  qry: TERPQuery;
begin
  if Assigned(Conn) then
    qry := DbSharedObj.GetQuery(Conn)
  else
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('SELECT * FROM tblunitsofmeasure');
    qry.SQL.Add('WHERE unitId = ' +inttostr(aUnitID));
    qry.Open;
    result := qry.FieldByName('UnitName').asString;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;

end;
class function TUnitOfMeasure.IdForNameAndProductId(const aUnitName: string;
  aProductId: integer; Conn: TCustomMyConnection): integer;
var
  qry: TERPQuery;
begin
  if Assigned(Conn) then
    qry := DbSharedObj.GetQuery(Conn)
  else
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('SELECT * FROM tblunitsofmeasure');
    qry.SQL.Add('WHERE ( PartID = ' + IntToStr(aProductID) + ' OR PartID = 0)');
    qry.SQL.Add('AND UnitName = ' + QuotedStr(aUnitName));
    qry.SQL.Add('AND Active = "T"');
    qry.SQL.Add('Order by PartID desc ');
    qry.Open;
    result := qry.FieldByName('UnitID').AsInteger;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

function TUnitOfMeasure.GetProductName: string;
begin
  if Assigned(Owner) and (Owner is TProduct) then
    result:= TProduct(Owner).ProductName
  else
    result:= TProduct.IDToggle(PartID, Connection.Connection);
end;

procedure TUnitOfMeasure.SetProductName(const Value: string);
begin
  PartID:= TProduct.IDToggle(Value,Connection.Connection);
end;

function TUnitOfMeasure.ValidateData: boolean;
var
  msg: string;

  function CleanMultiplier: double;
  begin
    //result :=QryClean.fieldbyname('Multiplier').asFloat;
    Result := GetXMLNodeFloatValue(CleanXMLNode, 'Multiplier');
  end;

  function CleanUnitProductKeyName:String;
  begin
    //result :=QryClean.fieldbyname('UnitProductKeyName').asString;
    Result := GetXMLNodeStringValue(CleanXMLNode, 'UnitProductKeyName');
  end;

begin
  Result:= inherited ValidateData;
  if not Result then exit;

  (*if UnitDescription = '' then begin
    Result:= false;
    AddResult(false, rssWarning, 0,'Unit Description should not be blank');
    exit;
  end;*)
  if Multiplier <= 0 then begin
    Result:= false;
    AddResult(false, rssWarning, 0,'Multiplier must be a value greater than zero');
    exit;
  end;
  if (Multiplier > 1) and (BaseUnitID < 1) then begin
    Result:= false;
    AddResult(false, rssWarning, 0,'For Multipliers greater than one there must be a Base UOM specified');
    exit;
  end;
  if (Multiplier = 1) and ((BaseUnitID > 0) or (BaseUnitName <> '')) then begin
    Result:= false;
    AddResult(false, rssWarning, 0,'With a Multiplier = 1 there can not be a Base UOM specified');
    exit;
  end;
  if (BaseUnitName <> '') and (BaseUnitID = 0) then begin
    Result:= false;
    AddResult(false, rssWarning, 0,'Unable to find Base Unit "' +
      BaseUnitName + '" with a Multiplier of 1 and a matching Product Id (or Product Id of 0)');
    exit;
  end;
  //CleanUnitProductKeyName:=GetXMLNodeStringValue(CleanXMLNode, 'UnitProductKeyName');
  if (CleanUnitProductKeyName <> '') and (CleanUnitProductKeyName <> UnitProductKeyName) then begin
        self.AddResult(false, rssWarning, 0, 'Unit Of Measure Name cannot be changed for and existing record.');
        Exit;
  end;


  //CleanMultiplier:= GetXMLNodeFloatValue(CleanXMLNode,'Multiplier');
  if (CleanMultiplier > 0) and (CleanMultiplier <> Multiplier) then begin
    if TUnitOfMeasure.IsParentUOM(ID) then begin
      Result:= false;
      AddResult(false, rssWarning, 0,'Multiplier must equal 1 as there are other Units Of Measure that use this as a Base UOM');
      exit;
    end;
  end;
  if not Active then begin
    with CommonDbLib.TempMyQuery do try
      SQL.add(SQL4ProductAvailableQty(0, self.UOMName));
      Open;
      if RecordCount > 0 then begin
        msg:= '';
        First;
        while not Eof do begin
          if ((self.PartId = 0) or (self.PartId = FieldByName('PartsID').AsInteger)) and
          ((fieldByname('Qty').asfloat <> 0) or (fieldByname('UOMQty').asfloat <> 0)) then begin
            if msg <> '' then msg := msg +chr(13);
            msg:= msg + '      ' + fieldByname('Partname').asString;
          end;
          Next;
        end;
        if msg <> '' then begin
          msg := 'This record can''t be made inactive as Has Avaialble Stock For The Following Products:' +chr(13) +chr(13) + msg;
          AddResult(false, rssWarning, 0, msg);
          result:= false;
          Exit;
        end;
      end;
    finally
      free;
    end;
  end
end;

function TUnitOfMeasure.DoAfterOpen(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoAfterOpen(Sender);
  if not result then exit;
  //QryClean;
end;

function TUnitOfMeasure.DoBeforePost(Sender: TDatasetBusObj): Boolean;
var
  s:String;
begin
  Result := inherited DoBeforePost(Sender);
  if not Result then Exit;
  s:=UOMName +':' ;
  if PartID <> 0 then s:= s  + TProduct.IdToggle(PartID, Connection.Connection);
  if UnitProductKeyName <> s then SetUnitProductKeyName(s);
end;

Class function  TUnitOfMeasure.InitBaseUnitID(fsUnitname:String;fdMultiplier:double;fiPartsId:Integer;fibaseUnitID:Integer;Connection :TERPConnection = nil):Integer;
var
  UOM:TUnitOfMeasure;
begin
  UOM:= TUnitOfMeasure.CreateWithNewConn(nil);
  try
    if Connection <> nil then UOM.Connection.Connection := Connection
    else UOM.Connection.Connection := GetNewMyDacConnection(UOM);
    UOM.Load(0);
    result:= UOM.CreateUOM(fsUnitname , fdMultiplier, fiPartsId , fibaseUnitID , False);
  finally
    Freeandnil(UOM);
  end;
end;

procedure TUnitOfMeasure.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.fieldName, 'Multiplier') then begin
    if not RawMode then begin
      if Multiplier = 1 then begin
        BaseUnitName := '';
        BaseUnitID := 0;
      end;
    end;
  end  else if Sysutils.SameText(Sender.fieldName, 'BaseUnitID') then begin
    BaseUnitName := TUnitOfMeasure.IDToggle(Sender.AsInteger,Connection.Connection);
  end else if Sysutils.SameText(Sender.fieldName, 'BaseUnitName') then begin
    BaseUnitID := initBaseUnitId(BaseUnitName , 1, PartID , 0 );
    //BaseUnitID := TUnitOfMeasure.BaseUnitIDForName(Sender.AsString,PartId, Connection.Connection);
  end  else if Sysutils.SameText(Sender.fieldName, 'PartID') then begin
    if BaseUnitName <> '' then
      BaseUnitID := initBaseUnitId(BaseUnitName , 1, PartID , 0 );
      //BaseUnitID := TUnitOfMeasure.BaseUnitIDForName(Sender.AsString,PartID, Connection.Connection);
    SetUnitProductKeyName(UOMName + ':' + ProductName);
  end  else if Sysutils.SameText(Sender.fieldName, 'UnitName') then begin
    SetUnitProductKeyName(UOMName + ':' + ProductName);
  end  else if Sysutils.SameText(Sender.fieldName, 'UseforAutoSplitQtyinSales') then begin
    if UseforAutoSplitQtyinSales then begin
      if not IsUnique(ID , 'partId = ' + inttostr(partId) +' and UseforAutoSplitQtyinSales ="T" and Multiplier  = ' +FloatTostr(Multiplier), Self.Connection.Connection) then begin
        ResultStatus.AddItem(False , rssWarning, 0 , 'Another Unit of measure exists for this product with the same Multiplier and  ''Use for Auto Split Qty in Sales'' turned on.'+NL+
                                                      'It is not possible to have more than one UOM for a product with the same Multiplier using for the Auto spit', true);
        UseforAutoSplitQtyinSales := False;
      end;
    end;
  end;
end;

class function TUnitOfMeasure.GetKeyStringField: string;
begin
  result := 'UnitProductKeyName';
end;

class function TUnitOfMeasure.GetKeyStringProperty: string;
begin
  result:= 'UnitProductKeyName';
end;

Function TUnitOfMeasure.CreateUOM(fsUnitname:String;fdMultiplier:double;fiPartsId:Integer;fibaseUnitID:Integer;acceptBlankPartID:Boolean=False):Integer;
begin
  REsult := 0;
  if fsUnitname = '' then exit;
  if fdMultiplier = 0 then exit;
  LoadSelect('unitName= ' +quotedstr(fsUnitName) +
              ' and ifnull(PartID,0) = ' +intToStr(fiPartsID));
  if count <> 0 then begin
    Result :=ID;
    exit;
  end;
  if acceptBlankPartID then begin
      LoadSelect('unitName= ' +quotedstr(fsUnitName) +
              ' and ifnull(PartID,0) = 0 ' +
              ' and Multiplier = ' +FloattoStr(fdMultiplier));
      if count <> 0 then begin
        Result :=ID;
        exit;
      end;
  end;
  Connection.BeginNestedTransaction;
  try
    New;
    UOMName := fsUnitname;
    PartId := fiPartsId;
    if fdMultiplier =0 then Multiplier :=1 else Multiplier := fdMultiplier;
    if Multiplier = 1 then BaseUnitID := 0
    else
      if fibaseUnitID = 0 then BaseUnitID := tcdatautils.GetUnitOfMeasureID(AppEnv.DefaultClass.DefaultUOM , 0)
      else BaseUnitID := fibaseUnitID;
    PostDB;
    Result :=ID;
    if Save then connection.CommitNestedTransaction else Connection.RollbackNestedTransaction;
  except
      connection.RollbackNestedTransaction;
  end;
end;

class procedure TUnitOfMeasure.SetUOMasDefault(const Ids:String; const UOMDefaulttype:TUOMDefaulttype);
var
  UOM:TUnitOfMeasure;
begin
  if Ids='' then exit;
  if UOMDefaulttype = tUOMdefaultNone then exit;

  UOM:=TUnitOfMeasure.create(nil);
  try
    UOM.connection := TMyDacDataConnection.Create(UOM);
    UOM.Connection.Connection:= GetNewMyDacConnection(UOM);
    UOM.LoadSelect('UnitID in (' +ids+')');
    if UOM.count = 0 then exit;
    UOM.fUOMDefaulttype :=  UOMDefaulttype;
    UOM.SetUOMAsDefault;
  finally
      FreeandNil(UOM);
  end;
end;

procedure TUnitOfMeasure.SetUOMasDefaultCallback(const Sender: TBusObj;var Abort: Boolean);
var
  s:String;
  UOM:TUnitOfMeasure;
begin
  DoStepProgressbar;
  if not Active then exit;

  if not Lock('SetUOMasDefault') then Exit;
  try
    connection.BeginNestedTransaction;
    try
      if PartId <> 0 then
        UOM:=  TUnitOfMeasure.create(Self) ;
        try
          UOM.connection := Self.Connection;
          s:=' PartID = ' +intToStr(Self.PartId)+' and UnitID <> '+intToStr(ID);

               if  Self.fUOMDefaulttype = tUOMSalesDefault then s := s + ' and SalesDefault ="T"'
          else if  Self.fUOMDefaulttype = tUOMPODefault    then s := s + ' and PurchasesDefault ="T"';

          UOM.LoadSelect(s);
          if UOM.count >0 then begin
            if not UOM.lock('SetUOMasDefault') then Exit;
            try
              if  fUOMDefaulttype = tUOMSalesDefault then  UOM.SalesDefault := False;
              if  fUOMDefaulttype = tUOMPODefault    then  UOM.PurchasesDefault:= False;
              UOM.PostDB;
            finally
                UOM.unlock;
            end;
          end;
        finally
            FreeandNil(UOM);
        end;
      if  fUOMDefaulttype = tUOMSalesDefault then  SalesDefault     := true;
      if  fUOMDefaulttype = tUOMPODefault    then  PurchasesDefault := true;
      PostDB;
      connection.CommitNestedTransaction;
    except
        Connection.RollbackNestedTransaction;
    end;
  finally
      unlock;
  end;
end;

procedure TUnitOfMeasure.SetUnitProductKeyName(const Value: string);
begin
  SetStringField('UnitProductKeyName', Value);
end;

procedure TUnitOfMeasure.SetUOMasDefault;
begin
  DoShowProgressbar(Self.Count , 'Upating the Sales/Purchase Default');
  try
    Connection.BeginTransaction;
    try
      IterateRecords(SetUOMasDefaultCallback , False);
      Connection.CommitTransaction;
    except
        Connection.RollbackTransaction;
    end;
  finally
      DoHideProgressbar;
  end;
end;

class function TUnitOfMeasure.MultiplierForUnitID(const aUnitID: integer;
  Conn: TCustomMyConnection): double;
var
  qry: TMyQuery;
begin
  result:= 1;
  qry:= TMyQuery.CReate(nil);
  try
    if Assigned(Conn) then
      qry.Connection:= Conn
    else
      qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text:= 'select Multiplier from tblunitsofmeasure where unitid = ' + IntToStr(aUnitID);
    qry.Open;
    if not qry.IsEmpty then
      result:= qry.FieldByName('Multiplier').AsFloat;
  finally
    qry.Free;
  end;
end;

procedure TUnitOfMeasure.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
(*  IF fQryClean <> nil then begin
    DbSharedObj.ReleaseObj(fQryClean);
    fQryClean:= nil;
  end;*)
  //Qryclean;
end;

(*function TUnitOfMeasure.QryClean: TERPQuery;
begin
  if (fQryClean = nil) or (fQryClean.active=False) then begin
    if fQryClean<> nil then DbSharedObj.ReleaseObj(fQryClean);//fQryClean.closenfree;
    //fQryClean := TERPQuery(getnewdataset(SQL,False));
    fQryClean := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection, SQL);
  end;
  fQryClean.locate(IDfieldname , ID, []);
  result := fQryClean;
end;*)

class function TUnitOfMeasure.BaseUnitIDForName(const aBaseName: string;
  aProductId: integer; Conn: TCustomMyConnection): integer;
var
  qry: TMyQuery;
begin
  qry:= TMyQuery.Create(nil);
  try
    if Assigned(Conn) then qry.Connection:= Conn
    else qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select * from tblunitsofmeasure');
    qry.SQL.Add('where UnitName = ' + QuotedStr(aBaseName));
    qry.SQL.Add('and Multiplier = 1');
    qry.SQL.Add('and ((PartID = 0) or (PartID = ' + IntToStr(aProductId) + '))');
//    qry.SQL.Add('and Active = "T"');
    qry.SQL.Add('order by PartID DESC');
    qry.Open;
    { get the first rec, this will be rec with product id > 0 if there is one
      else will get rec with prod id 0 }
    result:= qry.FieldByName('UnitID').AsInteger;
  finally
    qry.Free;
  end;
end;

function TUnitOfMeasure.IsOkToMerge(const UOMrectoMerge: TERPQuery; var Msg:String): Boolean;
begin
  REsult := False;
  try
      Msg := '';
      if (UOMrectoMerge.RecordCount=0) or (UOMrectoMerge.FieldByName('unitId').AsInteger =0) then exit;
      if Sysutils.SameText(UOMrectoMerge.fieldByname('UnitName').asString, AppEnv.DefaultClass.DefaultUOM)
        and (UOMrectoMerge.fieldByname('PartID').asInteger=0) and (UOMrectoMerge.fieldByname('Multiplier').asFloat = 1) then begin
        Msg := 'Default UOM ' + quotedstr(AppEnv.DefaultClass.DefaultUOM)+' cannot be merged';
        exit;
      end;
      if Multiplier <> UOMrectoMerge.fieldByname('Multiplier').asFloat then begin
        Msg := 'Multiplier is different : ' + uomname +' (' +floattostr(Multiplier)+') and '+ UOMrectoMerge.fieldByname('unitname').AsString +' ('+ floattostr(UOMrectoMerge.fieldByname('Multiplier').asFloat)+')';
        exit;
      end;
      if (PartId <> 0) and (PartId <> UOMrectoMerge.fieldByname('PartID').AsInteger) then begin
        Msg := 'Linked Products are different : ' + uomname +' (' +ProductName+') and '+ UOMrectoMerge.fieldByname('unitname').AsString +' ('+ getProduct(UOMrectoMerge.fieldByname('PartId').asInteger)+')';
        Exit;
      end;
      if (Volume <> UOMrectoMerge.fieldByname('volume').asFloat)  then begin
        Msg := 'Volume is different : ' + uomname +' (' +floattostr(Volume)+') and '+ UOMrectoMerge.fieldByname('unitname').AsString +' ('+ floattostr(UOMrectoMerge.fieldByname('Volume').asFloat)+')';
        Exit;
      end;
      if (Height <> UOMrectoMerge.fieldByname('height').asFloat)  then begin
        Msg := 'Height is different : ' + uomname +' (' +floattostr(Height)+') and '+ UOMrectoMerge.fieldByname('unitname').AsString +' ('+ floattostr(UOMrectoMerge.fieldByname('Height').asFloat)+')';
        Exit;
      end;
      if (width  <> UOMrectoMerge.fieldByname('width').asFloat)   then begin
        Msg := 'width is different : ' + uomname +' (' +floattostr(width)+') and '+ UOMrectoMerge.fieldByname('unitname').AsString +' ('+ floattostr(UOMrectoMerge.fieldByname('width').asFloat)+')';
        Exit;
      end;
      if (Length <> UOMrectoMerge.fieldByname('Length').asFloat)  then begin
        Msg := 'Length is different : ' + uomname +' (' +floattostr(Length)+') and '+ UOMrectoMerge.fieldByname('unitname').AsString +' ('+ floattostr(UOMrectoMerge.fieldByname('Length').asFloat)+')';
        Exit;
      end;
      Result := True;
  Except
    on E:Exception do begin
      Result := False;
    end;
  end;
end;

class function TUnitOfMeasure.IsParentUOM(const aUnitID: integer;
  Conn: TCustomMyConnection): boolean;
var
  qry: TMyQuery;
begin
  if  aUnitID=0 then begin {new unit}
      REsult := false;
      Exit;
  end;

  qry:= TMyQuery.Create(nil);
  try
    if Assigned(Conn) then qry.Connection:= Conn
    else qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select Count(UnitId) from tblunitsofmeasure');
    qry.SQL.Add('where ifnull(BaseUnitId,0) = ' + IntToStr(aUnitID));
    qry.SQL.Add('and UnitId <> ' + IntToStr(aUnitID));
    qry.SQL.Add('and Active = "T"');
    qry.Open;
    result:= qry.Fields[0].AsInteger > 0;
  finally
    qry.Free;
  end;
end;
initialization
  RegisterClass(TTransLinesUOMDetails);
  RegisterClass(TUnitOfMeasure);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Product Unit of Measure','TUnitOfMeasure','TUnitsOfMeasureListGUI');
end.

