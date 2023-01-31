unit BusObjTaxCodes;

{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 06/10/05  1.00.01 IJB  Added TTaxCode business object.
 08/06/06  1.00.02 BJ   LoadFromXML and SavetoXML introduced
}

interface

uses
  MyAccess,ERPdbComponents, DB, Dialogs, SysUtils, Variants, Classes,
  BusObjBase, XMLDoc, XMLIntf, commonlib;

const
  AMOUNT_EX= 'Selling Price';

type

  TTaxcode = Class;

  TTaxcodeLocations = class(TMSBusObj)
  private
    fsTaxcodeName:String;
    fsLocationCategory :STring;
    function GetTaxCodeID           : Integer   ;
    function GetLocationValue       : string    ;
    function GetActive              : Boolean   ;
    procedure SetTaxCodeID           (const Value: Integer   );
    procedure SetLocationValue       (const Value: string    );
    procedure SetActive              (const Value: Boolean   );
    //function LocationCategory: String;
    Procedure SetTaxCodeName(const Value:STring);
    function getTaxcode: TTaxcode;
    function getLocationCategory: String;
    Function getTaxCodeName :String;
    function getLocationCategorydesc: String;
    procedure setLocationCategorydesc(const Value: String);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;

  public
    procedure DoFieldOnChange(Sender: TField);                          override;
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    property     TaxCodeID            :Integer     read GetTaxCodeID          write SetTaxCodeID       ;
    Property Taxcode :TTaxcode REad getTaxcode;
    class function GetKeyStringProperty: string; Override;
    Property LocationCategory     :String      read getLocationCategory   write fsLocationCategory;
  published
    property LocationValue        :string      read GetLocationValue      write SetLocationValue   ;
    property Active               :Boolean     read GetActive             write SetActive          ;
    property TaxCodeName          :String      read getTaxCodeName        write setTaxCodeName;
    Property LocationCategoryDesc     :String      read getLocationCategorydesc   write setLocationCategorydesc;

  end;

  TSubTaxCode = class(TMSBusObj)
  private
    function GetCode           : string    ;
    function GetDescription    : string    ;
    function GetCategory       : String;
    function GetActive         : Boolean   ;
    function GetRegionID       : Integer   ;
    procedure SetCode           (const Value: string    );
    procedure SetDescription    (const Value: string    );
    Procedure SetCategory       (Const Value :String);
    procedure SetActive         (const Value: Boolean   );
    procedure SetRegionID       (const Value: Integer   );
    function GetRegionName: string;
    procedure SetRegionName(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;             override;
  public
    procedure DoFieldOnChange(Sender: TField);                          override;
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
    Class function   GetKeyStringField       : string;                   override;
    Class function  Load4code(AOwner:TComponent;const aCode: String;  CreatenewifnotExits: boolean = true; ConfirmCreate:Boolean =true): TSubTaxCode;
    Class function  MakeSubTaxCode(AOwner:TComponent;aCode , aDescription, aCategory, acountry :String; Conn: TMyDacDataConnection= nil): integer;

  published
    property Code            :string      read GetCode          write SetCode       ;
    property Description     :string      read GetDescription   write SetDescription;
    Property Category        :String      read getCategory      write setCategory;
    property Active          :Boolean     read GetActive        write SetActive     ;
    property RegionID        :Integer     read GetRegionID      write SetRegionID   ;
    property RegionName: string read GetRegionName write SetRegionName;
  end;


  TTaxCodeLineBase = class(TMSBusObj)
  private
    function GetTaxCodeID      : Integer   ;
    function GetSubTaxID       : Integer   ;
    function GetSubTaxCode     : string    ;
    function GetPercentage     : Double    ;
    procedure SetTaxCodeID      (const Value: Integer   );
    procedure SetSubTaxID       (const Value: Integer   );
    procedure SetSubTaxCode     (const Value: string    );
    procedure SetPercentage     (const Value: Double    );
    function getPercentageOn: String;
    procedure setPercentageOn(const Value: String);
    function getPercentageOnID: Integer;
    procedure setPercentageOnID(const Value: Integer);
    function getTaxCode: string;
    procedure SetTaxcode(const Value: string);
    function GetCapAmount: double;
    procedure SetCapAmount(const Value: double);
    function GetAmountPerUnit: double;
    function GetThresholdAmount: double;
    function GetUOM: string;
    procedure SetAmountPerUnit(const Value: double);
    procedure SetThresholdAmount(const Value: double);
    procedure SetUOM(const Value: string);

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Function  DoAfterDelete(Sender :TDatasetBusObj): Boolean;           override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;            override;
  public
    procedure DoFieldOnChange(Sender: TField);                          override;
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;

    function ValidatePercentageOn(PercentID:Integer):Boolean;
    property TaxCodeID       :Integer     read GetTaxCodeID     write SetTaxCodeID  ;
    class function _Schema: string; override;
  published
    property SubTaxID        :Integer     read GetSubTaxID      write SetSubTaxID   ;
    property SubTaxCode      :string      read GetSubTaxCode    write SetSubTaxCode ;
    property Percentage      :Double      read GetPercentage    write SetPercentage ;
    property PercentageOn    :String      read getPercentageOn  write setPercentageOn;
    property PercentageOnID  :Integer     read getPercentageOnID write setPercentageOnID;
    Property TaxCode         :string      read getTaxCode        Write SetTaxcode;
    property CapAmount: double read GetCapAmount write SetCapAmount;
    property AmountPerUnit: double read GetAmountPerUnit write SetAmountPerUnit;
    property UOM: string read GetUOM write SetUOM;
    property ThresholdAmount: double read GetThresholdAmount write SetThresholdAmount;
  end;

  TTaxCodeLines = class(TTaxCodeLineBase)

  end;

  TTaxCode = class(TMSBusObj)
  private
    AllLinesValid:Boolean;
    function GetCodeName        : String;
    function GetLocationCategory: String;
    function GetDescription     : String;
    function GetRate            : Double;
    function GetTaxCodeId       : Integer;
    function GetActive          : Boolean;
    function GetPublishOnVS1    : Boolean;
    Function GetRegionID        : Integer;
    function GetRegionName      : string;
    function GetIsPurchase      : Boolean;
    function GetIsSales         : Boolean;

    procedure SetCodeName         (Const Value : String);
    procedure SetLocationCategory (Const Value : String);
    procedure SetDescription      (Const Value : String);
    procedure SetRate             (Const Value : Double);
    Procedure SetActive           (Const value : Boolean);
    Procedure SetPublishOnVS1     (Const value : Boolean);
    Procedure SetRegionID         (Const Value : Integer);
    procedure SetRegionName       (Const Value : string);
    procedure SetIsPurchase       (Const Value : Boolean);
    procedure SetIsSales          (Const Value : Boolean);

    procedure CalcRateCallback(const Sender: TBusObj; var Abort: boolean);
    procedure ValidateDatacallback(const Sender: TBusObj; var Abort: boolean);
    function GetTaxCodeLines: TTaxCodeLines;
    Procedure DoCalcRate(fid: Integer;var fdTotalLineAmount:Double; var fdTax:Double);
    function getTTaxcodeLocations: TTaxcodeLocations;
    function getLocationCategoryDesc: String;
    procedure setLocationCategoryDesc(const Value: String);

  protected
    function    DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function    DoAfterPost(Sender: TDatasetBusObj)  : Boolean; override;
    function    DoBeforePost(Sender: TDatasetBusObj) : Boolean; override;
    function    GetSQL                              : String;       Override;
    Function    ValidateXMLData(Const Node :IXMLNode)     : Boolean ;     Override;
    Function    ExportsubClasses(Const Node: IXMLNode)    : Boolean;      Override;
    Function    ImportsubClasses(Const node: IXMLNode)    : Boolean;      Override;

  public
    procedure   DoFieldOnChange(Sender: TField);                    Override;
    class function GetBusObjectTablename: string; override;
    class function  GetIDField: string;                                   override;
    class function GetKeyStringField: string; override;
    class function IdForCode(const aCode: string; const aRegionId: integer; Conn: TCustomMyConnection = nil): integer;
    Constructor Create(AOwner: TComponent);     Override;
    destructor  Destroy;                        Override;
    function    FindByCode(Const aTaxCode: String): Boolean;
    Procedure   LoadFromXMLNode(Const node: IXMLNode);Override;
    procedure   SaveToXMLNode(Const node: IXMLNode);  Override;
    function    ValidateData :Boolean ;         Override;
    function    Save :Boolean ;                 Override;
    Procedure CalcRate;
    property TaxCodeID  : Integer   Read GetTaxCodeId;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
    class function LocationCodetoDesc(const code: String): String;
    class function LocationDesctocode(const Desc: String): String;
    class function RateForCodeName(aCodeName: string; aRegionId: integer = 0): double;
    function isOverSeasTaxcode:Boolean;
    property LocationCategory: String    Read GetLocationCategory Write SetLocationCategory;
    Class Function  MakeaTaxcodeLine(AOwner:TComponent;var fsmsg:String;aTaxCode:Integer; aSubTaxCode:Integer; aPercentage :double; UseTaxCodeRate:Boolean = True; aConnection :TERPConnection= nil) :Boolean;
    Class Function  MakeaTaxcode(AOwner:TComponent;aTaxCode, aDescription:String; aTaxRate :double) :Boolean;

  Published
    property CodeName             : String    Read GetCodeName      Write SetCodeName;
    property Description          : String    Read GetDescription   Write SetDescription;
    property Rate                 : Double    Read GetRate          Write SetRate;
    Property Active               : Boolean   Read GetActive        Write SetActive;
    Property PublishOnVS1         : Boolean   Read GetPublishOnVS1  Write SetPublishOnVS1;
    property RegionName           : string    read GetRegionName    write SetRegionName;
    property RegionID             : Integer   Read GetRegionID      Write SetRegionID;
    property LocationCategoryDesc : String    Read getLocationCategorydesc Write setLocationCategoryDesc;
    property Lines            : TTaxCodeLines     read GetTaxCodeLines;
    property TaxcodeLocations : TTaxcodeLocations Read getTTaxcodeLocations;
    property IsDefaultPurchase    : Boolean   Read GetIsPurchase    Write SetIsPurchase;
    property IsDefaultSales       : Boolean   Read GetIsSales       Write SetIsSales;

  end;

implementation

uses
   tcDataUtils, AppEnvironment, BusObjRegionalOptions,
   CommonDbLib, BusObjConst,  DNMLib, BusObjectListObj, BusObjSchemaLib,
   BusobjCountries, BusObjLocation, DbSharedObjectsObj, tcConst, Controls;


 { TTaxCode }

procedure TTaxCode.CalcRate;
begin
  Rate :=0;
  Lines.Iteraterecords(CalcRateCallback);
  Rate := Rate/100;
  SendEvent(BusObjEvent_Change, BusObjEventVal_Rate);
end;

procedure TTaxCode.CalcRateCallback(const Sender: TBusObj; var Abort: boolean);
var
  fdTax:Double;
  fdTotalLineAmount:Double;
begin
  if not(Sender is TTaxCodeLines) then exit;
  if TTaxCodeLines(Sender).PercentageOnId =0 then begin
    Rate := Rate + TTaxCodeLines(Sender).Percentage;
  end else begin
    fdTax:= 0;
    fdTotalLineAmount:=1;
    DoCalcRate(TTaxCodeLines(Sender).ID , fdTotalLineAmount, fdTax);
    Rate :=Rate+ (fdTax*100);
  end;
end;

Procedure TTaxcode.DoCalcRate(fid:Integer;var fdTotalLineAmount:Double; var fdTax:Double);
var
  Obj :TTaxCodeLineBase;
begin
  obj := TTaxCodeLineBase.create(self);
  try
    Obj.connection := Self.Connection;
    Obj.Load(fid);
    if Obj.PercentageOnId =0 then begin
      fdTax := GetTaxAmount(fdTotalLineAmount , obj.Percentage/100);
      fdTotalLineAmount := fdTotalLineAmount +fdTax;
    end else begin
      DoCalcRate(Obj.PercentageOnId, fdTotalLineAmount, fdTax);
      fdTax :=GetTaxAmount(fdTotalLineAmount , Obj.Percentage/100);
      fdTotalLineAmount := fdTotalLineAmount +fdTax;
    end;
  finally
    Freeandnil(Obj);
  end;
end;
function TTaxCode.GetTaxCodeLines: TTaxCodeLines;
begin
  Result := TTaxCodeLines(getContainerComponent(TTaxCodeLines, 'TaxCodeID = ' +IntToStr(ID)));
end;

Constructor TTaxCode.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSql := 'SELECT * FROM tblTaxCodes WHERE RegionID = ' + IntToStr(AppEnv.RegionalOptions.ID);
  ExportExcludeList.Add('taxcodeid');
  ExportExcludeList.Add('regionid');
end;

destructor TTaxCode.Destroy;
begin
  inherited;
end;

class function TTaxCode.GetBusObjectTablename: string;
begin
  Result := 'tblTaxCodes';
end;

class function  TTaxCode.GetIDField :String;
begin
    REsult := 'TaxCodeID';
end;

procedure TTaxCode.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if sametext(Sender.FieldName , 'TaxcodeLocationCategory') then begin
      SendEvent(BusObjEvent_Change, BusObjEventVal_TaxcodeLocationChanged, self);
      TaxcodeLocations.DeleteAll;
  end;
end;

Function  TTaxCode.ValidateXMLData(Const Node :IXMLNode) :Boolean ;
var
    fiRegionId :Integer;
    fsForeignKey :String;
begin
    Result      := inherited ValidateXMLData(Node);
    fiRegionId  := 0;
    if not Result then Exit;
    if not ImportingFromXMLFile then Exit;
    XMLSearchRecorddesc := 'Name ='  + QuotedStr(GetXMLNodeStringValue(Node, 'CodeName')) +
                            ' and region = ' + GetXMLNodeStringValue(Node, 'RegionName');
    REsult      := False;
    //foreign key validations
    fsForeignKey :='RegionName';
    if GetXMLNodeStringValue(Node, fsForeignKey) <> '' then begin
        fiRegionId		:= tcDatautils.GetRegion(GetXMLNodeStringValue   (Node, fsForeignKey));
        if fiRegionId = 0 then begin
            ErrRecordNotfound(fsForeignKey , GetXMLNodeStringValue(Node, fsForeignKey));
            Exit;
        end;
    end;

    Result := true;
    XMLSearchRecord := 'Name ='  + QuotedStr(GetXMLNodeStringValue(Node, 'CodeName')) + ' and regionId = ' + IntToStr(fiRegionId) ;
    LocateXMLRecord;

end;
class function TTaxCode._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TRegionalOptions','RegionalOptions_1','RegionName','Region');
  TBOSchema.AddRefType(result,'TRegionalOptions','RegionalOptions_1','RegionID','ID');
end;

Function  TTaxCode.ExportsubClasses(Const Node: IXMLNode):Boolean;begin    Result := True;end;
Function  TTaxCode.ImportsubClasses(Const node: IXMLNode):Boolean;begin    Result := True;end;
function TTaxCode.isOverSeasTaxcode: Boolean;
begin
  result := LocationCategory = 'O';
end;

function TTaxCode.GetCodeName: String;begin  Result := GetStringField('Name');end;
function TTaxCode.GetLocationCategory: String;begin  Result := GetStringField('TaxcodeLocationCategory');end;
function TTaxCode.getTTaxcodeLocations: TTaxcodeLocations;
begin
  Result := TTaxcodeLocations(getContainerComponent(TTaxcodeLocations, 'TaxCodeID = ' +IntToStr(ID)));
end;

function TTaxCode.GetDescription: String;begin  Result := GetStringField('Description');end;
function TTaxCode.GetRate: Double;begin  Result := GetFloatField('Rate');end;
function TTaxCode.GetSQL: String;begin    Result := inherited GetSQL;end;
function TTaxCode.GetTaxCodeId: Integer;begin  Result := GetIntegerField('TaxCodeID');end;
function TTaxCode.GetActive :Boolean;begin    REsult := GetBooleanfield('Active');end;
function TTaxCode.GetPublishOnVS1 :Boolean;begin    REsult := GetBooleanfield('PublishOnVS1');end;
function TTaxCode.GetRegionID :Integer;begin    Result := GetIntegerField('RegionID');end;
function TTaxCode.GetIsPurchase: Boolean; begin Result := GetBooleanField('IsDefaultPurchase');end;
function TTaxCode.GetIsSales: Boolean; begin Result := GetBooleanField('IsDefaultSales');end;

procedure TTaxCode.SetCodeName(Const Value: String);begin  SetStringField('Name', Value);end;
procedure TTaxCode.SetLocationCategory(Const Value: String);begin  SetStringField('TaxcodeLocationCategory', Value);end;
procedure TTaxCode.setLocationCategoryDesc(const Value: String);
begin
  LocationCategory := LocationDesctocode(Value);
end;
procedure TTaxCode.SetDescription(Const Value: String);begin  SetStringField('Description', Value);end;
procedure TTaxCode.SetRate(Const Value: Double);begin  SetFloatField('Rate', Value);end;
Procedure TTaxCode.SetActive(Const value :Boolean);begin    SetBooleanField('Active' , Value);end;
Procedure TTaxCode.SetPublishOnVS1(Const value :Boolean);begin    SetBooleanField('PublishOnVS1' , Value);end;
Procedure TTaxCode.SetRegionID(Const Value :Integer);begin    SetIntegerField('RegionID' , Value);end;
Procedure TTaxCode.SetIsPurchase(Const Value: Boolean); begin SetBooleanField('IsDefaultPurchase', Value);end;
Procedure TTaxCode.SetIsSales(Const Value: Boolean); begin SetBooleanField('IsDefaultSales', Value);end;


function TTaxCode.FindByCode(Const aTaxCode: String): Boolean;
begin
  self.LoadSelect('Name = ' + QuotedStr(aTaxCode));
  Result := Dataset.RecordCount > 0;
end;
procedure TTaxCode.LoadFromXMLNode(Const node: IXMLNode);
begin
    inherited;
    SetPropertyFromNode(Node,'CodeName');
    SetPropertyFromNode(Node,'LocationCategory');
    SetPropertyFromNode(Node,'Description');
    SetPropertyFromNode(Node,'Rate');
    SetBooleanPropertyFromNode(Node , 'Active');
    SetBooleanPropertyFromNode(Node , 'PublishOnVS1');
    SetPropertyFromNode(Node,'RegionId');
end;
procedure TTaxCode.SaveToXMLNode(Const node: IXMLNode);
begin
    inherited;
    AddXMLNode(node , 'CodeName',      CodeName);
    AddXMLNode(node , 'LocationCategory',   LocationCategory);
    AddXMLNode(node , 'Description',   Description);
    AddXMLNode(node , 'Rate',          Rate);
    AddXMLNode(node , 'Active',        Active);
    AddXMLNode(node , 'PublishOnVS1',        PublishOnVS1);
    AddXMLNode(Node , 'RegionId'   ,RegionID);
end;

function TTaxCode.ValidateData :Boolean ;
var
  CleanCodeName: string;
begin
  result := inherited ValidateData;
  if not result then Exit;

    Result := False;
    Resultstatus.Clear;
    if Trim(CodeName) = '' then begin
        AddResult(False,rssWarning,0,'Taxcode name should not be blank');
        Exit;
    end;
    if RegionId = 0 then begin
        RegionId := AppEnv.RegionalOptions.ID;
    end;

    CleanCodeName:= self.GetXMLNodeStringValue(self.GetCleanXMLNode, 'CodeName');
    if (CleanCodeName <> '') and (CleanCodeName <> CodeName) then begin
      AddResult(False,rssWarning,0,
        'Taxcode "' +CleanCodeName+ '" can not be renamed to "' +
        CodeName+ '" for existing record');
      Exit;
    end;

    if not IsUnique(ID , 'Name = ' + quotedstr(CodeName) +' and REgionId = ' + inttostr(RegionID)) then begin
      self.AddResult(false, rssWarning, 0, 'Record already exists for Taxcode "' + CodeName + '"');
      Exit;
    end;

    AllLinesValid:=True;
    Lines.IterateRecords(ValidateDatacallback);
    Result := AllLinesValid;
    if not result then exit;
    AllLinesValid:=True;
    TaxcodeLocations.IterateRecords(ValidateDatacallback);
    Result := AllLinesValid;
    if not result then exit;

end;
procedure TTaxCode.ValidateDatacallback(const Sender: TBusObj; var Abort: boolean);
begin
  if not(Sender is TTaxCodeLines ) then exit;
  if not (TTaxCodeLines(Sender).ValidateData) then begin
    AllLinesValid:= False;
    Abort := True;
  end;
end;

function    TTaxCode.Save :Boolean ;
begin
    Result := False;
    if not ValidateData then Exit;
    result := inherited Save;
end;

function TTaxCode.GetRegionName: string;
begin
  result:= TRegionalOptions.IDToggle(RegionID,Connection.Connection);
end;

procedure TTaxCode.SetRegionName(const Value: string);
begin
  if Value <> '' then
    RegionID:= TRegionalOptions.IDToggle(Value,Connection.Connection)
  else
    RegionID:= 0;
end;

function TTaxCode.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoAfterInsert(Sender);
  if not result then exit;
  RegionId:= AppEnv.RegionalOptions.ID;
  LocationCategory :='C';
  PublishOnVS1 := False;
end;

function TTaxCode.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterPost(Sender);
  if not result then exit;
  if TaxcodeLocations.Count = 0 then begin
    if LocationCategory = 'C' then begin
      TaxcodeLocations.New;
      TaxcodeLocations.LocationValue := TCountries.IDToggle(Appenv.RegionalOptions.CountryId);
      TaxcodeLocations.PostDB;
    end;
  end;
end;

function TTaxCode.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforePost(Sender);
  if not(Result) then exit;
end;

class function TTaxCode.GetKeyStringField: string;
begin
  result:= 'Name';
end;

class function TTaxCode.GetKeyStringProperty: string;
begin
  result:= 'CodeName';
end;

function TTaxCode.getLocationCategorydesc: String;
begin
  result := LocationCodetoDesc(LocationCategory);
end;
Class function TTaxCode.LocationCodetoDesc(const code:String): String;
begin
        if code ='C' then result := 'Country'
  else  if code ='S' then result := appenv.RegionalOptions.StateName
  else  if code ='L' then result := Appenv.RegionalOptions.SuburbName
  else  if code ='P' then result := 'Postcode'
  else  Result := 'Overseas';
end;
class function TTaxCode.LocationDesctocode(const Desc: String): String;
begin
        if Desc = 'Country'                         then result := 'C'
  else  if Desc = appenv.RegionalOptions.StateName  then result := 'S'
  else  if Desc = Appenv.RegionalOptions.SuburbName then result := 'L'
  else  if Desc = 'Postcode'                        then result := 'P'
  else  Result := 'O';
end;

class function TTaxCode.MakeaTaxcode(AOwner: TComponent; aTaxCode, aDescription: String;  aTaxRate: double): Boolean;
var
  aTaxCodeObj :TTaxCode;
begin
  REsult := False;
  aTaxCodeObj := TTaxCode.CreateWithNewConn(AOwner);
  try
    if (aTaxCode ='') then exit;
    aTaxCodeObj.LoadSelect('Name =' + quotedstr(aTaxCode) +' and RegionID =' + IntToStr(AppEnv.RegionalOptions.ID));
    if aTaxCodeObj.count =0 then begin
        aTaxCodeObj.connection.BeginTransaction;
        try
            aTaxCodeObj.New;
            aTaxCodeObj.CodeName    := aTaxCode;
            aTaxCodeObj.RegionId    := AppEnv.RegionalOptions.ID;
            aTaxCodeObj.Rate        := aTaxRate;
            aTaxCodeObj.Active      := True;
            aTaxCodeObj.Description := aDescription;
            aTaxCodeObj.PostDB;
            aTaxCodeObj.connection.CommitTransaction;
        Except
          on E:Exception do begin
            aTaxCodeObj.connection.RollbackTransaction;
            Exit;
          end;
        end;
    end;
    Result := True;
  finally
    Freeandnil(aTaxCodeObj);
  end;
end;

class Function  TTaxCode.MakeaTaxcodeLine(AOwner:TComponent; var fsmsg:String;aTaxCode:Integer; aSubTaxCode:Integer; aPercentage :double; UseTaxCodeRate:Boolean = True; aConnection :TERPConnection= nil) :Boolean;
var
  aTaxCodeObj :TTaxCode;
  aSubTaxCodeObj:TSubTaxcode;
begin
  REsult := False;
  aTaxCodeObj := TTaxCode.CreateWithNewConn(AOwner);
  aSubTaxCodeObj := TSubTaxCode.Create(AOwner);
  try
    if (aTaxCode =0) or (aSubTaxCode=0) then exit;
    aTaxCodeObj.Load(aTaxCode);
    if aTaxCodeObj.count =0 then exit;

    aSubTaxCodeObj.connection := aTaxCodeObj.connection;
    aSubTaxCodeObj.Load(asubtaxcode);
    if aSubTaxCodeObj.count =0 then exit;

    aTaxCodeObj.connection.BeginTransaction;
    try
        if not aTaxCodeObj.lines.locate('TaxCodeID;SubTaxID' , vararrayof([aTaxCodeObj.ID,aSubTaxCodeObj.ID]), []) then begin
          if aTaxCodeObj.Lock then try
              aTaxCodeObj.Lines.new;
              aTaxCodeObj.Lines.TaxCodeId := aTaxCodeObj.Id;
              aTaxCodeObj.Lines.SubTaxID := aSubTaxCodeObj.Id;
              aTaxCodeObj.Lines.Percentage := aPercentage;
              //if UseTaxCodeRate then aTaxCodeObj.Lines.Percentage := aTaxCodeObj.Lines.Percentage /100;
              aTaxCodeObj.Lines.PostDB;
              if not aTaxCodeObj.Save then begin
                aTaxCodeObj.connection.RollbackTransaction;
                Exit;
              end;
              aTaxCodeObj.connection.CommitTransaction;
              Result := True;
              if fsmsg <> '' then fsmsg := fsmsg +NL;
              fsmsg := fsmsg + aTaxCodeObj.CodeName+'.'+aSubTaxCodeObj.Code;
              Exit;
          finally
            aTaxCodeObj.Unlock;
          end;
        end;
        aTaxCodeObj.connection.RollbackTransaction;
    Except
      on E:Exception do begin
        aTaxCodeObj.connection.RollbackTransaction;
      end;
    end;
  finally
    Freeandnil(aTaxCodeObj);
    Freeandnil(aSubTaxCodeObj);
  end;
end;

class function TTaxCode.RateForCodeName(aCodeName: string;
  aRegionId: integer): double;
var
  qry: TERPQuery;
  RegId: integer;
begin
  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
    RegId := aRegionId;
    if RegId = 0 then
      RegId := AppEnv.RegionalOptions.ID;
    qry.SQL.Clear;
    qry.SQL.Add('select Rate from tblTaxCodes where Name = ' + QuotedStr(aCodeName));
    qry.SQL.Add('and RegionID = ' + IntToStr(RegId));
    qry.Open;
    result := qry.FieldByName('Rate').AsFloat;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
end;

class function TTaxCode.IdForCode(const aCode: string;
  const aRegionId: integer; Conn: TCustomMyConnection): integer;
var
  qry: TMyQuery;
begin
  qry:= TMyQuery.Create(nil);
  try
    if Assigned(Conn) then
      qry.Connection:= conn
    else
      qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text:= 'select TaxCodeId from tbltaxcodes where Name = ' +
      QuotedStr(aCode) + ' and RegionId = ' + IntToStr(aRegionId);
    qry.Open;
    result:= qry.FieldByName('TaxCodeId').AsInteger;
  finally
    qry.Free;
  end;
end;

 {TTaxCodeLineBase}
constructor TTaxCodeLineBase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'TaxCodeLines';
  fSQL := 'SELECT * FROM tbltaxcodelines';
  ExportExcludeList.Add('subtaxidid');
  ExportExcludeList.Add('SubTaxID');
  fIsList := true;
end;


destructor TTaxCodeLineBase.Destroy;
begin
  inherited;
end;


procedure TTaxCodeLineBase.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'TaxCodeID');
  SetPropertyFromNode(node,'SubTaxID');
  SetPropertyFromNode(node,'SubTaxCode');
  SetPropertyFromNode(node,'Percentage');
  SetPropertyFromNode(node,'PercentageOnID');
  SetPropertyFromNode(node,'PercentageOn');
  SetPropertyFromNode(node,'CapAmount');
  SetPropertyFromNode(node, 'AmountPerUnit');
  SetPropertyFromNode(node, 'UOM');
  SetPropertyFromNode(node, 'ThresholdAmount');
end;


procedure TTaxCodeLineBase.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'TaxCodeID' ,TaxCodeID);
  AddXMLNode(node,'SubTaxID' ,SubTaxID);
  AddXMLNode(node,'SubTaxCode' ,SubTaxCode);
  AddXMLNode(node,'Percentage' ,Percentage);
  AddXMLNode(node,'PercentageOnID' ,PercentageOnID);
  AddXMLNode(node,'PercentageOn' ,PercentageOn);
  AddXMLNode(node,'CapAmount', CapAmount);
  AddXMLNode(node, 'AmountPerUnit', AmountPerUnit);
  AddXMLNode(node, 'UOM', UOM);
  AddXMLNode(node, 'ThresholdAmount', ThresholdAmount);
end;


function TTaxCodeLineBase.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if TaxCodeID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Tax Code should not be blank' , True );
    Exit;
  end;
  if SubTaxID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Sub Tax should not be blank' , True );
    Exit;
  end;
  if (Percentage = 0) and (UOM = '') then begin
    Resultstatus.AddItem(False , rssError , 0,  'Either a Percentage or UOM must be specified' , True );
    Exit;
  end;
  if PercentageOn = '' then
    PercentageOn := AMOUNT_EX //'[AMOUNT_EX]'
  else if ValidatePercentageOn(PercentageOnID) = False then begin
    Resultstatus.AddItem(False , rssError , 0,  'This will Make Circular Reference.' , true );
    PercentageOn := AMOUNT_EX; //'[AMOUNT_EX]';
    PercentageOnID:=0;
  end;
  Result := True;
end;


function TTaxCodeLineBase.ValidatePercentageOn(PercentID:Integer): Boolean;
begin
  if PercentId =0 then begin
    result := true;
  end else begin
    if ID = PercentId then begin
      REsult := False;
    end else begin
      With getNewDataset('Select PercentageOnID from tbltaxcodelines where Id = ' +intToStr(PercentID) , true) do try
        result := ValidatePercentageOn(fieldbyname('PercentageOnID').asInteger);
      finally
        if active then close;
        Free;
      end;
    end;
  end;
end;

class function TTaxCodeLineBase._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TSubTaxCode','SubTaxCodeObj','SubTaxID','ID');
  TBOSchema.AddRefType(result,'TSubTaxCode','SubTaxCodeObj','SubTaxCode','Code');
  TBOSchema.AddRefType(result,'TSubTaxCode','PercentageOnObj','PercentageOnID','ID');
end;

function TTaxCodeLineBase.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TTaxCodeLineBase.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TTaxCodeLineBase.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if SameText(Sender.fieldName,'PercentageOnID') then begin
    if not RawMode then begin
      if not ValidatePercentageOn(PercentageOnID) then begin
        Resultstatus.AddItem(False , rssError , 0,  'This will Make Circular Reference.' , true );
        PercentageOn := Amount_Ex;
        PercentageOnID:=0;
      end;
    end;
  end else if SameText(Sender.fieldName,'SubTaxCode') then begin
    if Sender.AsString <> '' then
      SubTaxID:= TSubTaxCode.IDToggle(Sender.AsString, Connection.Connection)
  end else if SameText(Sender.fieldName,'SubTaxID') then begin
    if Sender.AsInteger >0 then
      SubTaxCode:= TSubTaxCode.IDToggle(Sender.AsInteger, Connection.Connection)
  end;

  {CapAmount,AmountPerUnit , UOM , ThresholdAmount, percentageon - only one of these field is applicable  }
  if SameText(Sender.fieldName,'CapAmount'      ) or
     SameText(Sender.fieldName,'AmountPerUnit'  ) or
     SameText(Sender.fieldName,'ThresholdAmount') or
     SameText(Sender.fieldName,'PercentageOnID' ) or
     SameText(Sender.fieldName,'UOM'            ) or
     SameText(Sender.fieldName,'PercentageOn'   ) then begin
     if (SameText(Sender.fieldName,'CapAmount'      ) and (CapAmount      <>0 )) or
        (SameText(Sender.fieldName,'AmountPerUnit'  ) and (AmountPerUnit  <>0 )) or
        (SameText(Sender.fieldName,'ThresholdAmount') and (ThresholdAmount<>0 )) or
        (SameText(Sender.fieldName,'PercentageOnID' ) and (PercentageOnID <>0 )) or
        (SameText(Sender.fieldName,'UOM'            ) and (UOM            <>'')) or
        (SameText(Sender.fieldName,'PercentageOn'   ) and (PercentageOn   <>'')) then begin

         if not(SameText(Sender.fieldName,'CapAmount'      )) then CapAmount := 0;
         if not(SameText(Sender.fieldName,'ThresholdAmount')) then ThresholdAmount:= 0;
         if not(SameText(Sender.fieldName,'PercentageOnID' )) and
            not(SameText(Sender.fieldName,'PercentageOn'   )) then begin
               PercentageOnID :=0;
               PercentageOn   := '';
         end;
         if not(SameText(Sender.fieldName,'AmountPerUnit' )) and
            not(SameText(Sender.fieldName,'UOM'   )) then begin
               AmountPerUnit :=0;
               UOM   := '';
         end;
     end;
  end;
end;


function TTaxCodeLineBase.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TTaxCodeLineBase.GetIDField: string;
begin
  Result := 'ID'
end;

function TTaxCodeLineBase.GetAmountPerUnit: double;
begin
  result := GetFloatField('AmountPerUnit');
end;

class function TTaxCodeLineBase.GetBusObjectTablename: string;
begin
  Result:= 'tbltaxcodelines';
end;

function TTaxCodeLineBase.GetCapAmount: double;
begin
  result := GetFloatField('CapAmount');
end;

function TTaxCodeLineBase.DoAfterDelete(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterDelete(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if Owner is TTaxcode then
      TTaxcode(Owner).CalcRate;
end;

function TTaxCodeLineBase.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if Owner is TTaxCode then
      TaxCodeID := TTaxCode(Owner).Id;
  PercentageOn := AMOUNT_EX;
end;

function TTaxCodeLineBase.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if Owner is TTaxcode then
      TTaxcode(Owner).CalcRate;
end;


function TTaxCodeLineBase.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoBeforePost(Sender);
  if not result then exit;
  if   (SubTaxCode = '') and  ( Percentage =0) then  begin
    Cancel;
    Abort;
  end;
end;

{Property Functions}
function  TTaxCodeLineBase.GetTaxCodeID  : Integer   ; begin Result := GetIntegerField('TaxCodeID');end;

function TTaxCodeLineBase.GetThresholdAmount: double;
begin
  result := GetFloatField('ThresholdAmount');
end;

function TTaxCodeLineBase.GetUOM: string;
begin
  result := GetStringField('UOM');
end;

function  TTaxCodeLineBase.GetSubTaxID   : Integer   ; begin Result := GetIntegerField('SubTaxID');end;

function TTaxCodeLineBase.getTaxCode: string;
begin
  result:= TTaxCode.IDToggle(TaxcodeID, Connection.Connection,'RegionID = ' + IntToStr(AppEnv.RegionalOptions.ID));
end;

function  TTaxCodeLineBase.GetSubTaxCode : string    ; begin Result := GetStringField('SubTaxCode');end;
function  TTaxCodeLineBase.GetPercentage : Double    ; begin Result := GetFloatField('Percentage');end;
function TTaxCodeLineBase.getPercentageOn: String;
begin
  REsult:= getStringfield('PercentageOn');
end;

function TTaxCodeLineBase.getPercentageOnID: Integer;
begin
  Result := GetIntegerField('PercentageOnID');
end;

procedure TTaxCodeLineBase.SetTaxcode(const Value: string);
begin
  TaxcodeID := TTaxCode.IDToggle(Value);
end;

procedure TTaxCodeLineBase.SetTaxCodeID  (const Value: Integer   ); begin SetIntegerField('TaxCodeID'   , Value);end;
procedure TTaxCodeLineBase.SetThresholdAmount(const Value: double);
begin
  SetFloatField('ThresholdAmount',value);
end;

procedure TTaxCodeLineBase.SetUOM(const Value: string);
begin
  SetStringField('UOM',Value);
end;

procedure TTaxCodeLineBase.SetSubTaxID   (const Value: Integer   ); begin SetIntegerField('SubTaxID'    , Value);end;
procedure TTaxCodeLineBase.SetSubTaxCode (const Value: string    ); begin SetStringField('SubTaxCode' , Value);end;
procedure TTaxCodeLineBase.SetAmountPerUnit(const Value: double);
begin
  SetFloatField('AmountPerUnit',Value);
end;

procedure TTaxCodeLineBase.SetCapAmount(const Value: double);
begin
  SetFloatField('CapAmount', value);
end;

procedure TTaxCodeLineBase.SetPercentage (const Value: Double    ); begin SetFloatField('Percentage' , Value);end;

procedure TTaxCodeLineBase.setPercentageOn(const Value: String);
begin
  if Value = '' then
    SetStringField('PercentageOn' , AMOUNT_EX)
  else
    SetStringField('PercentageOn' , Value);
end;

procedure TTaxCodeLineBase.setPercentageOnID(const Value: Integer);
begin
  SetIntegerField('PercentageOnID', Value);
end;

{TSubTaxCode}
constructor TSubTaxCode.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SubTaxCode';
  fSQL := 'SELECT * FROM tblsubtaxcode';
  ExportExcludeList.Add('regionid');
end;


destructor TSubTaxCode.Destroy;
begin
  inherited;
end;


class function TSubTaxCode.Load4code(AOwner:TComponent;const aCode: String;  CreatenewifnotExits: boolean = true; ConfirmCreate:Boolean =true): TSubTaxCode;
begin
  result := TSubTaxCode.CreateWithNewConn(AOwner);
  result.loadselect('Code =' + Quotedstr(aCode));
  if (result.count =0) then
   if CreatenewifnotExits then
     if not(confirmcreate) or
        (MessageDlgXP_Vista('Sub TaxCode '+ Quotedstr(aCode)+' Doesn''t Exists. Do You wish To Create a New Record?', mtconfirmation, [mbYes, mbNo],0) = mryes) then begin
        result.Connection.BeginTransaction;
        try
          result.new;
          result.Code := aCode;
          result.Description := aCode;
          result.PostDB;
          if not result.save then begin
            result.Connection.RollbackTransaction;
            Exit;
          end;
          result.Connection.CommitTransaction;
        Except
          on E:Exception do begin
            result.Connection.RollbackTransaction;
            MessageDlgXP_vista('Creating Sub TaxCode Failed', mtWarning, [mbOK], 0);
            Exit;
          end;
        end;
    end;
end;


procedure TSubTaxCode.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Code');
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'Category');
  SetBooleanPropertyFromNode(node,'Active');
  SetPropertyFromNode(node,'RegionID');
end;


class function TSubTaxCode.MakeSubTaxCode(AOwner:TComponent;aCode, aDescription, aCategory,  acountry: String; Conn: TMyDacDataConnection = nil): integer;
var
  SubTaxCode : TSubTaxCode;
  aConn: TMyDacDataConnection;
begin
  Result := 0;
  SubTaxCode := TSubTaxCode.Create(AOwner);
  try
      if conn = nil then begin
        aconn:= TMyDAcDataconnection.Create(SubTaxCode);
        aconn.Connection := GetNewMyDacConnection(SubTaxCode);
        aconn.begintransaction;
      end else begin
        aconn := conn;
      end;
      try
        SubTaxCode.connection := aConn;
        SubTaxCode.LoadSelect('Code =' + quotedstr(aCode)+' and Description =' + quotedstr(aDescription));
        if SubTaxCode.count =0 then begin
          aconn.beginnestedtransaction;
          try
              SubTaxCode.New;
              SubTaxCode.Code := aCode;
              SubTaxCode.Description := aDescription;

                   if sametext(aCategory ,'County') then SubTaxCode.Category := 'C'
              else if sametext(aCategory ,'City'  ) then SubTaxCode.Category := 'T'
              else if sametext(aCategory ,'State' ) then SubTaxCode.Category := 'S'
              else SubTaxCode.Category := 'O';

              SubTaxCode.RegionID := GetRegionIDForCountry(acountry);
              if not SubTaxCode.Save then begin
                SubTaxCode.connection.Rollbacknestedtransaction;
                Exit;
              end;
              SubTaxCode.connection.Commitnestedtransaction;
          Except
            on E:Exception do begin
              SubTaxCode.connection.Rollbacknestedtransaction;
            end;
          end;
        end;
        REsult := SubTaxCode.ID;
      finally
        // connection is owned by SubTaxCode, so will be freed automatically
      end;
  finally
    Freeandnil(SubTaxCode);
  end;
end;

procedure TSubTaxCode.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Code' ,Code);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'Category' ,Category);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'RegionID' ,RegionID);
end;


function TSubTaxCode.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if RegionId = 0 then begin
    RegionId := AppEnv.RegionalOptions.ID;
  end;
  if Code = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'Sub Tax Code should not be blank' , True );
    Exit;
  end;
  if Description = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'Sub Tax Description should not be blank' , True );
    Exit;
  end;
  if Category = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'Sub Tax Has to have a Category - City, State, County or Other.' , True );
    Exit;
  end;

  if RegionId = 0 then  RegionId := AppEnv.RegionalOptions.ID;

  Result := True;
end;


class function TSubTaxCode._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TRegionalOptions','RegionObj','RegionID','ID');
  TBOSchema.AddRefType(result,'TRegionalOptions','RegionObj','RegionName','Region');
end;

function TSubTaxCode.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSubTaxCode.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TSubTaxCode.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TSubTaxCode.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSubTaxCode.GetIDField: string;
begin
  Result := 'ID'
end;


class function TSubTaxCode.GetKeyStringField: string;
begin
  Result := 'Code';
end;

class function TSubTaxCode.GetKeyStringProperty: string;
begin
  result:= 'Code';
end;

class function TSubTaxCode.GetBusObjectTablename: string;
begin
  Result:= 'tblsubtaxcode';
end;


function TSubTaxCode.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then exit;
  Active := True;
end;

function TSubTaxCode.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{Property Functions}
function  TSubTaxCode.GetCode       : string    ; begin Result := GetStringField('Code');end;
function  TSubTaxCode.GetDescription: string    ; begin Result := GetStringField('Description');end;
function  TSubTaxCode.GetCategory: string    ; begin Result := GetStringField('Category');end;
function  TSubTaxCode.GetActive     : Boolean   ; begin Result := GetBooleanField('Active');end;
function  TSubTaxCode.GetRegionID   : Integer   ; begin Result := GetIntegerField('RegionID');end;
function TSubTaxCode.GetRegionName: string;
begin
  result:= TRegionalOptions.IDToggle(RegionID, Connection.Connection);
end;

procedure TSubTaxCode.SetCode       (const Value: string    ); begin SetStringField('Code'        , Value);end;
procedure TSubTaxCode.SetDescription(const Value: string    ); begin SetStringField('Description' , Value);end;
procedure TSubTaxCode.SetCategory(const Value: string    ); begin SetStringField('Category' , Value);end;
procedure TSubTaxCode.SetActive     (const Value: Boolean   ); begin SetBooleanField('Active'      , Value);end;
procedure TSubTaxCode.SetRegionID   (const Value: Integer   ); begin SetIntegerField('RegionID'    , Value);end;


procedure TSubTaxCode.SetRegionName(const Value: string);
begin
  RegionID:= TRegionalOptions.IDToggle(Value, Connection.Connection);
end;

  {TTaxcodeLocations}

constructor TTaxcodeLocations.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'TaxcodeLocations';
  fSQL := 'SELECT * FROM tbltaxcodelocations  ';
  if not(assigned(Owner)) or (not (Owner is TTaxcode)) then
    fSQL := fSQL +'  WHERE TAXCODEID IN (SELECT TAXCODEiD FROM tbltaxcodes WHERE REGIONID = '+IntToStr(AppEnv.RegionalOptions.ID)+ ')';
  fsTaxcodeName:='';
  fsLocationCategory:= '';
end;


destructor TTaxcodeLocations.Destroy;
begin
  inherited;
end;


procedure TTaxcodeLocations.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'TaxCodeID');
  SetPropertyFromNode(node,'LocationValue');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure TTaxcodeLocations.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'TaxCodeID' ,TaxCodeID);
  AddXMLNode(node,'LocationValue' ,LocationValue);
  AddXMLNode(node,'Active' ,Active);
end;

function TTaxcodeLocations.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if TaxCodeID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'TaxCodeID should not be 0'  );
    Exit;
  end;
  if (fsLocationCategory <> '') and (not Sametext(LocationCategory ,fsLocationCategory)) then begin
    Resultstatus.AddItem(False , rssError , 0,
                            'Location Category ' +quotedstr(TTaxcode.LocationCodetoDesc(fsLocationCategory)) +' doesn''t match with the '+
                            'Taxcode (' + Quotedstr(TaxcodeName)+')''s Location category ' + Quotedstr(LocationCategorydesc)+'.'  );
    Exit;
  end;
  if (LocationCategory<>'C') and (LocationCategory<>'S') and (LocationCategory<>'L') and (LocationCategory<>'P') and (LocationCategory<>'O') then begin
    Resultstatus.AddItem(False , rssError , 0,  'Please select a valid Category - Country / ' + appenv.RegionalOptions.StateName +' / ' + appenv.RegionalOptions.SuburbName+' / Postcode.'  );
    Exit;
  end;
  if (LocationCategory <>'O') and (LocationValue = '') then begin
    Resultstatus.AddItem(False , rssError , 0,  'Please select a ' + TTaxcode.LocationCodetoDesc(LocationCategory)+'.'  );
    Exit;
  end;
  if TaxCodeID < 0 then begin
    if fsTaxcodeName <> '' then
      Resultstatus.AddItem(False , rssError , 0,  'TaxCode ' + quotedstr(fsTaxcodeNAme) +' doesn''t Exist'  )
    else
      Resultstatus.AddItem(False , rssError , 0,  'Unknown Taxcode'  );
    Exit;
  end;

  if LocationCategory = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'Please provide the Location Category'  );
    Exit;
  end;
  if not TLocation.ValidLocation(LocationValue , LocationCategory, Appenv.regionalOptions.ID) then begin
    Resultstatus.AddItem(False , rssError , 0,  TTaxcode.LocationCodetoDesc(LocationCategory) +' ' + Quotedstr(LocationValue)+ ' doesn''t exists.'  );
    Exit;
  end;
  Result := True;
end;


function TTaxcodeLocations.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TTaxcodeLocations.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  fsTaxcodeName := '';
  fsLocationCategory :='';
end;


procedure TTaxcodeLocations.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TTaxcodeLocations.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


function TTaxcodeLocations.getTaxcode: TTaxcode;
begin
  if Assigned(Owner) and (Owner is TTaxcode) then result := TTaxcode(Owner)
  else Result := TTaxcode(getContainerComponent(TTaxcode, 'TaxCodeID = ' +IntToStr(TaxCodeID)));
end;

class function TTaxcodeLocations.GetIDField: string;
begin
  Result := 'ID'
end;



class function TTaxcodeLocations.GetKeyStringProperty: string;
begin
  result:= 'LocationValue,TaxCodeName';
end;

function TTaxcodeLocations.getLocationCategory: String;
begin
  result := Taxcode.LocationCategory;
end;

function TTaxcodeLocations.getLocationCategorydesc: String;
begin
  result := TTaxcode.LocationCodetoDesc(LocationCategory);
end;

class function TTaxcodeLocations.GetBusObjectTablename: string;
begin
  Result:= 'tbltaxcodelocations';
end;


function TTaxcodeLocations.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
   result:= inherited DoAfterInsert(Sender);
   if not(result) then exit;
   if Assigned(Owner) then
    if owner is TTaxcode then begin
      TTaxcode(Owner).PostDB;
      TaxcodeId := TTaxcode(Owner).ID;
    end;
   Active := true;
end;

function TTaxcodeLocations.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TTaxcodeLocations.GetTaxCodeID       : Integer   ; begin Result := GetIntegerField('TaxCodeID');end;
function TTaxcodeLocations.getTaxCodeName: String;
begin
  result := Taxcode.CodeName;
end;

function  TTaxcodeLocations.GetLocationValue   : string    ; begin Result := GetStringField('LocationValue');end;
function  TTaxcodeLocations.GetActive          : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TTaxcodeLocations.SetTaxCodeID       (const Value: Integer   ); begin SetIntegerField('TaxCodeID'        , Value);end;
procedure TTaxcodeLocations.setLocationCategorydesc(const Value: String);
begin
  LocationCategory := TTaxcode.LocationDesctocode(Value);
end;

procedure TTaxcodeLocations.SetTaxCodeName(const Value:STring);begin fsTaxcodeName:=Value; TaxcodeId := TTaxcode.idToggle(Value); if (TaxcodeId =0) and (Value <> '') then TaxcodeId := -1;   end;

procedure TTaxcodeLocations.SetLocationValue   (const Value: string    ); begin SetStringField('LocationValue'    , Value);end;
procedure TTaxcodeLocations.SetActive          (const Value: Boolean   ); begin SetBooleanField('Active'           , Value);end;


initialization
  RegisterClass(TSubTaxCode);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Sub Taxcode','TSubTaxCode','TSubTaxcodesGUI');
  RegisterClassOnce(TTaxCode);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Taxcode','TTaxCode','TTaxCodeListGUI');
  RegisterClass(TTaxCodeLines);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Tax code Lines','TTaxCodeLines','');
  RegisterClass(TTaxcodeLocations);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Tax code Locations','TTaxcodeLocations','');
end.

