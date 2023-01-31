unit BusObjClass;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 31/05/05  1.00.00 IJB  Initial version.

interface

uses
  classes, BusObjBase, XMLDoc, ERPdbComponents, MyAccess, DB, XMLIntf, BusObjTaxCodes , BusObjShippingAddress , BusObjStSCommon;

type

  TDeptClass = class(TMSBusObj)
  private
    function GetDeptClassGroup  : String;
    function GetDeptClassName   : String;
    function GetDescription     : String;
    function GetActive          : boolean;
//    Function GetSubClass	    : Boolean;
//    Function GetSubClassOf	  : String;
//    Function GetClassPercent	: Double;
    Function GetLevel1		      : String;
    Function GetLevel2		      : String;
    Function GetLevel3		      : String;
    Function GetLevel4		      : String;
    Function GetAutoCreateSOs	  : Boolean;
    Function GetUseAddress	    : Boolean;
    Function GetStreet		      : String;
    Function GetStreet2		      : String;
    Function GetStreet3		      : String;
    Function GetSuburb		      : String;
    Function GetState		        : String;
    Function GetPostcode	      : String;
    function GetAutoCreateRepair: boolean;
    Function GetCountry		      : String;
    function GetSiteCode        : string;
    function getAddress         : String;
    function GetTaxID           : Integer;
    function GetTaxCodeName     : string;
    function GetLocationCode    : string;

    procedure SetActive           (const Value: boolean);
    procedure SetDeptClassGroup   (const Value: String);
    procedure SetDeptClassName    (const Value: String);
    procedure SetDescription      (const Value: String);
//    Procedure SetSubClass	      (Const Value : Boolean);
//    Procedure SetSubClassOf	    (Const Value : String);
//    Procedure SetClassPercent	  (Const Value : Double);
    Procedure SetLevel1	          (Const Value : String);
    Procedure SetLevel2	          (Const Value : String);
    Procedure SetLevel3	          (Const Value : String);
    Procedure SetLevel4	          (Const Value : String);
    Procedure SetAutoCreateSOs	  (Const Value : Boolean);
    Procedure SetUseAddress	      (Const Value : Boolean);
    Procedure SetStreet	          (Const Value : String);
    Procedure SetStreet2	        (Const Value : String);
    Procedure SetStreet3	        (Const Value : String);
    Procedure SetSuburb	          (Const Value : String);
    Procedure SetState	          (Const Value : String);
    Procedure SetPostcode	        (Const Value : String);
    Procedure SetCountry	        (Const Value : String);
    procedure SetSiteCode         (const Value: string);
    procedure SetAutoCreateRepair (const Value: boolean);
    procedure SetTaxID            (const Value: Integer);
    procedure SetTaxCodeName      (const Value: string);
    procedure SetLocationCode     (const Value: string);
    function GetTaxCode: TTaxCode;
    function GetStSClass: TStSClass;
  protected
    function GetSQL: String; override;
    procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); override;
    Function  ValidateXMLData(Const Node :IXMLNode) :Boolean ;        Override;
    Function  ExportsubClasses(Const Node: IXMLNode):Boolean;         Override;
    Function  ImportsubClasses(Const node: IXMLNode):Boolean;         Override;
    Function  ForeignKeysValid(Const Node :IXMLNode):Boolean;     Override;
  public
    procedure DoFieldOnChange(Sender: TField); override;
    class function GetBusObjectTablename: string; override;
    class function  GetIDField: string; override;
    class function GetKeyStringField: string; override;
    class function SiteCodeUnique(const aSiteCode: string;
                                  const aClassID: integer;
                                  Connection: TCustomMyConnection = nil): boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function    ValidateData :Boolean ;         Override;
    function    Save :Boolean ;                 Override;
    procedure   SaveToXMLNode(Const Node: IXMLNode);  Override;
    procedure   LoadFromXMLNode(Const Node: IXMLNode);Override;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
    Property Address :String read getAddress;
    class function SiteCodeForClass(const aClass: string; Conn: TERPConnection = nil): string;
    class function ClassForSitecode(const aSitecode: string; Conn: TERPConnection = nil): string;
    property TaxCode               :TTaxCode         Read GetTaxCode;
    Class Procedure ReadShipToAddress(aClassId:Integer ; var fShipToAddressRec:TAddressRec; aConn :TMyDacDataConnection = nil);
    Class Function MakeDeptClass(aDeptClass:STring;aSiteCode:String;aConnection: TCustomMyconnection=nil):Integer;
  published
    property  DeptClassName       : String  Read GetDeptClassName     Write SetDeptClassName;
    property  DeptClassGroup      : String  Read GetDeptClassGroup    Write SetDeptClassGroup;
    property  Description         : String  Read GetDescription       Write SetDescription;
    property  Active              : boolean Read GetActive            Write SetActive;
    Property	Level1	            : String  Read GetLevel1	          Write SetLevel1;
    Property	Level2	            : String  Read GetLevel2	          Write SetLevel2;
    Property	Level3	            : String  Read GetLevel3	          Write SetLevel3;
    Property	Level4	            : String  Read GetLevel4	          Write SetLevel4;
    Property	AutoCreateSmartOrder: Boolean Read GetAutoCreateSOs	    Write SetAutoCreateSOs;
    property  AutoCreateRepair    : boolean read GetAutoCreateRepair  write SetAutoCreateRepair;
    Property	UseAddress	        : Boolean Read GetUseAddress	      Write SetUseAddress;
    Property	Street	            : String  Read GetStreet	          Write SetStreet;
    Property	Street2	            : String  Read GetStreet2	          Write SetStreet2;
    Property	Street3	            : String  Read GetStreet3	          Write SetStreet3;
    Property	Suburb	            : String  Read GetSuburb	          Write SetSuburb;
    Property	State	              : String  Read GetState	            Write SetState;
    Property	Postcode	          : String  Read GetPostcode	        Write SetPostcode;
    Property	Country	            : String  Read GetCountry	          Write SetCountry;
    property  SiteCode            : string  read GetSiteCode          write SetSiteCode;
    property  TaxID               :Integer  Read GetTaxID             Write SetTaxID;
    property  TaxCodeName         :string   Read GetTaxCodeName       Write SetTaxCodeName;
    property  LocationCode        :string   Read GetLocationCode      Write SetLocationCode;
    Property  StSClass : TStSClass read GetStSClass;
    (* the follow don't appear to be in use any more
    Property	SubClass        : Boolean Read GetSubClass	        Write SetSubClass;
    Property	SubClassOf	    : String  Read GetSubClassOf	    Write SetSubClassOf;
    Property	ClassPercent	: Double  Read GetClassPercent	    Write SetClassPercent;
    *)
  end;

implementation

uses Sysutils, tcDataUtils, CommonLib, CommonDbLib, AppEnvironment,
  BusObjectListObj;

  { TDeptClass }

function TDeptClass.GetDeptClassGroup : String; begin  Result := GetStringField('ClassGroup');end;
function TDeptClass.GetDeptClassName  : String; begin  Result := GetStringField('ClassName');end;
function TDeptClass.GetDescription    : String; begin  Result := GetStringField('Description');end;
Function TDeptClass.GetLevel1         : String; Begin	Result  :=getStringField('Level1');End;
Function TDeptClass.GetLevel2         : String; Begin	Result  :=getStringField('Level2');End;
Function TDeptClass.GetLevel3         : String; Begin	Result  :=getStringField('Level3');End;
Function TDeptClass.GetLevel4         : String; Begin	Result  :=getStringField('Level4');End;
Function TDeptClass.GetAutoCreateSOs  : Boolean;Begin	Result  :=getBooleanField('AutoCreateSmartOrders');End;
Function TDeptClass.GetUseAddress     : Boolean;Begin	Result  :=getBooleanField('UseAddress');End;
Function TDeptClass.GetStreet         : String; Begin	Result  :=getStringField('Street');End;
Function TDeptClass.GetStreet2        : String; Begin	Result  :=getStringField('Street2');End;
Function TDeptClass.GetStreet3        : String; Begin	Result  :=getStringField('Street3');End;
Function TDeptClass.GetSuburb         : String; Begin	Result  :=getStringField('Suburb');End;
Function TDeptClass.GetState          : String; Begin	Result  :=getStringField('State');End;
Function TDeptClass.GetPostcode       : String; Begin	Result  :=getStringField('Postcode');End;
Function TDeptClass.GetCountry        : String; Begin	Result  :=getStringField('Country');End;
function TDeptClass.GetTaxID          : Integer;begin Result  := GetIntegerField('TaxID');end;
function TDeptClass.GetTaxCodeName    : string; begin result  := GetStringField('Taxname'); end;
function TDeptClass.GetLocationCode   : string; begin result  := GetStringField('LocationCode'); end;

procedure TDeptClass.SetTaxID         (const Value: Integer );begin SetIntegerField('TaxID'       , Value);end;
procedure TDeptClass.SetTaxCodeName   (const Value: string  );begin SetStringField('Taxname'      ,Value); end;
procedure TDeptClass.SetLocationCode  (const Value: string  );begin SetStringField('LocationCode' ,Value); end;
Procedure TDeptClass.SetLevel1        (Const Value :String  );begin	SetStringField('Level1'       , Value );end;
Procedure TDeptClass.SetLevel2        (Const Value :String  );begin	SetStringField('Level2'       , Value );end;
Procedure TDeptClass.SetLevel3        (Const Value :String  );begin	SetStringField('Level3'       , Value );end;
Procedure TDeptClass.SetLevel4        (Const Value :String  );begin	SetStringField('Level4'       , Value );end;
Procedure TDeptClass.SetUseAddress    (Const Value :Boolean );begin	SetBooleanField('UseAddress'  , Value );end;
Procedure TDeptClass.SetStreet        (Const Value :String  );begin	SetStringField('Street'       , Value );end;
Procedure TDeptClass.SetStreet2       (Const Value :String  );begin	SetStringField('Street2'      , Value );end;
Procedure TDeptClass.SetStreet3       (Const Value :String  );begin	SetStringField('Street3'      , Value );end;
Procedure TDeptClass.SetSuburb        (Const Value :String  );begin	SetStringField('Suburb'       , Value );end;
Procedure TDeptClass.SetState         (Const Value :String  );begin	SetStringField('State'        , Value );end;
Procedure TDeptClass.SetPostcode      (Const Value :String  );begin	SetStringField('Postcode'     , Value );end;
Procedure TDeptClass.SetCountry       (Const Value :String  );begin	SetStringField('Country'      , Value );end;
procedure TDeptClass.SetActive        (const Value: boolean );begin SetBooleanField('Active'      , Value);end;
procedure TDeptClass.SetDeptClassGroup(const Value: String  );begin SetStringField('ClassGroup'   , Value);end;
procedure TDeptClass.SetDeptClassName (const Value: String  );begin SetStringField('ClassName'    , Value);end;
procedure TDeptClass.SetDescription   (const Value: String  );begin SetStringField('Description'  , Value);end;
Procedure TDeptClass.SetAutoCreateSOs (Const Value :Boolean );begin	SetBooleanField('AutoCreateSmartOrders' , Value );end;



constructor TDeptClass.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblClass';
end;

destructor TDeptClass.Destroy;
begin
  inherited;
end;

procedure TDeptClass.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;



function TDeptClass.GetActive: boolean;
begin
  Result := GetBooleanField('Active');
end;

function TDeptClass.getAddress: String;
begin
  Result := GetCompanyName;
  if Street <> '' then Result := Result + Chr(13) + Chr(10) + Street;
  if Street2 <> '' then Result := Result + Chr(13) + Chr(10) + Street2;
  if Street3 <> '' then Result := Result + Chr(13) + Chr(10) + Street3;
  if (Suburb <> '') or (State <> '') then begin
    Result := Result + Chr(13) + Chr(10);
    if (Suburb <> '') and (State <> '') then Result := Result + Suburb + ' ' + State
    else if Suburb = '' then Result := Result + State
    else Result := Result + Suburb;
  end;
  if Postcode <> '' then Result := Result + ' ' + Postcode;
end;

function TDeptClass.GetTaxCode: TTaxCode;
begin
  result := TTaxCode(GetContainerComponent(TTaxCode ,'TaxCodeID = ' + IntToStr(TaxID) ));
end;

function TDeptClass.GetStSClass: TStSClass;
begin
   result := TStSClass(GetContainerComponent(TStSClass ,'Classid = ' + IntToStr(ID) ));
end;

class Function TDeptClass.GetIDField :String ;begin    Result :='ClassId';end;
function TDeptClass.GetSQL: String;
begin
  Result := inherited GetSQL;
end;

class function TDeptClass.GetBusObjectTablename: string;begin  Result := 'tblclass';end;
Function  TDeptClass.ValidateXMLData(Const Node :IXMLNode) :Boolean ;
var
    fsXMLData :String;
    fiClassId :Integer;
begin
    Result := inherited ValidateXMLData(Node);

    if not Result then Exit;
    if not ImportingFromXMLFile then Exit;

    XMLSearchRecordDesc := 'ClassName='  + QuotedStr(GetXMLNodeStringValue(Node, 'ClassName'));
    Result := False;
    fsXMLData :=GetXMLNodeStringValue(Node, 'Level1');
    if fsXMLData <> '' then begin
        ficlassid :=GetDeptID(fsXMLData);
        if ficlassid = 0 then begin
            ErrRecordNotfound('Level1' , fsXMLData);
            Exit;
        end;
    End;
    fsXMLData :=GetXMLNodeStringValue(Node, 'Level2');
    if fsXMLData <> '' then begin
        ficlassid :=GetDeptID(fsXMLData);
        if ficlassid = 0 then begin
            ErrRecordNotfound('Level2' , fsXMLData);
            Exit;
        end;
    End;
    fsXMLData :=GetXMLNodeStringValue(Node, 'Level3');
    if fsXMLData <> '' then begin
        ficlassid :=GetDeptID(fsXMLData);
        if ficlassid = 0 then begin
            ErrRecordNotfound('Level3' , fsXMLData);
            Exit;
        end;
    End;
    Result := true;
    XMLSearchRecord := 'ClassName='  + QuotedStr(GetXMLNodeStringValue(Node, 'ClassName'));
    LocateXMLRecord;
End;
class function TDeptClass._Schema: string;
begin
  result:= inherited;
end;

Function  TDeptClass.ExportsubClasses(Const Node: IXMLNode):Boolean;
begin
    Result := true;
End;
Function    TDeptClass.ForeignKeysValid(Const Node :IXMLNode):Boolean;
begin
    Result := True;
end;
Function  TDeptClass.ImportsubClasses(Const node: IXMLNode):Boolean;
begin
    Result := true;
end;

function    TDeptClass.ValidateData :Boolean ;
var
  CleanDeptClassName: string;
begin
  result := inherited ValidateData;
  if not result then Exit;
  Result := False;
  Resultstatus.Clear;
  if Id < 1 then PostDb;

  if DeptClassName = '' then begin
    AddResult(False , rssWarning , 0,  'Department/Class Name should not be blank');
    Exit;
  end;

  if (not Active) and (AppEnv.DefaultClass.ClassID = ID) then begin
    AddResult(False, rssWarning, 0, 'Department/Class "' + DeptClassName + '" can not be set inactive as it is the system default Class');
    Exit;
  end;

  if self.SiteCode = '' then begin
    AddResult(False , rssWarning , 0,  'Site Code should not be blank');
    Exit;
  end;

  if self.SiteCode <> '' then begin
    if not SitecOdeUnique(SiteCode,Id,Connection.Connection) then begin
      AddResult(False , rssWarning , 0,  'Site Code is not unique');
      Exit;
    end
  end;

  if (Level2 <> '') and ((Level1 = '')) then begin
    AddResult(False, rssWarning, 0, 'Level 1 can not be blank when Level 2 has a value');
    Exit;
  end;

  if (Level3 <> '') and (Level2 = '') then begin
    AddResult(False, rssWarning, 0, 'Level 2 can not be blank when Level 3 has a value');
    Exit;
  end;

  if (Level4 <> '') and (Level3 = '') then begin
    AddResult(False, rssWarning, 0, 'Level 3 can not be blank when Level 4 has a value');
    Exit;
  end;

  CleanDeptClassName:= self.GetXMLNodeStringValue(self.CleanXMLNode,'DeptClassName');
  if (CleanDeptClassName <> '') and (CleanDeptClassName <> DeptClassName) then begin
    AddResult(False, rssWarning, 0, 'Can not change Class/Department Name to "' +
      DeptClassName + '" for existiong record "' + CleanDeptClassName + '"');
    Exit;
  end;

  Result := true;
end;

function TDeptClass.Save :Boolean ;
begin
  result:= ValidateData;
  if not result then
    exit;
  Result := Inherited Save;
end;
procedure   TDeptClass.SaveToXMLNode(Const Node: IXMLNode);
begin
    inherited;
    AddXMLNode(Node , 'DeptClassName',DeptClassName);
    AddXMLNode(Node , 'DeptClassGroup',DeptClassGroup);
    AddXMLNode(Node , 'Description',Description);
//    AddXMLNode(Node , 'SubClass',SubClass);
//    AddXMLNode(Node , 'SubClassOf',SubClassOf);
//    AddXMLNode(Node , 'ClassPercent',ClassPercent);
    AddXMLNode(Node , 'Level1',Level1);
    AddXMLNode(Node , 'Level2',Level2);
    AddXMLNode(Node , 'Level3',Level3);
    AddXMLNode(Node , 'Level4',Level4);
    AddXMLNode(Node , 'AutoCreateSmartOrder',AutoCreateSmartOrder);
    AddXMLNode(Node , 'AutoCreateRepair',AutoCreateRepair);
    AddXMLNode(Node , 'UseAddress',UseAddress);
    AddXMLNode(Node , 'Street',Street);
    AddXMLNode(Node , 'Street2',Street2);
    AddXMLNode(Node , 'Street3',Street3);
    AddXMLNode(Node , 'Suburb',Suburb);
    AddXMLNode(Node , 'State',State);
    AddXMLNode(Node , 'Postcode',Postcode);
    AddXMLNode(Node , 'Country',Country);
    AddXMLNode(Node , 'Active',Active);
    AddXMLNode(Node , 'SiteCode',SiteCode);
    AddXMLNode(Node, 'TAXID', TAXID);
    AddXMLNode(Node, 'taxcodename', taxcodename);
    AddXMLNode(Node, 'LocationCode', LocationCode);
end;
procedure   TDeptClass.LoadFromXMLNode(Const Node: IXMLNode);
begin
    inherited;
    SetPropertyFromNode(Node, 'DeptClassName');
    SetPropertyFromNode(Node, 'DeptClassGroup');
    SetPropertyFromNode(Node, 'Description');
//    SetPropertyFromNode(Node, 'SubClass');
//    SetPropertyFromNode(Node, 'SubClassOf');
//    SetPropertyFromNode(Node, 'ClassPercent');
    SetPropertyFromNode(Node, 'Level1');
    SetPropertyFromNode(Node, 'Level2');
    SetPropertyFromNode(Node, 'Level3');
    SetPropertyFromNode(Node, 'Level4');
    SetBooleanPropertyFromNode(Node, 'AutoCreateSmartOrder');
    SetBooleanPropertyFromNode(Node, 'AutoCreateRepair');
    SetBooleanPropertyFromNode(Node, 'UseAddress');
    SetPropertyFromNode(Node, 'Street');
    SetPropertyFromNode(Node, 'Street2');
    SetPropertyFromNode(Node, 'Street3');
    SetPropertyFromNode(Node, 'Suburb');
    SetPropertyFromNode(Node, 'State');
    SetPropertyFromNode(Node, 'Postcode');
    SetPropertyFromNode(Node, 'Country');
    SetBooleanPropertyFromNode(Node, 'Active');
    SetPropertyFromNode(Node, 'SiteCode');
    SetPropertyFromNode(Node, 'TAXID');
    SetPropertyFromNode(Node, 'taxcodename');
    SetPropertyFromNode(Node, 'LocationCode');
end;

class function TDeptClass.MakeDeptClass(aDeptClass, aSiteCode: String;aConnection: TCustomMyconnection=nil): Integer;
var
  DeptObj :TDeptClass;
begin
  REsult := 0;
  DeptObj := TDeptClass.createwithNewConn(nil);
  try
    if (aConnection <> nil) and (aConnection.Connected) then DeptObj.connection.connection := aConnection;
    DeptObj.loadselect('ClassName = ' + quotedstr(aDeptClass));
    if DeptObj.count =0 then begin
      DeptObj.New;
      DeptObj.DeptClassname := aDeptClass;
      DeptObj.Sitecode := aSiteCode;
      {first 3 characters default sitecode}
      if DeptObj.Sitecode  = '' then
        if TDeptClass.ClassForSitecode(copy(aDeptClass,1,3))='' then
          DeptObj.Sitecode := copy(aDeptClass,1,3);
      DeptObj.PostDB;
    end;
    Result := DeptObj.ID;
  finally
    Freeandnil(DeptObj);
  end;
end;


class function TDeptClass.GetKeyStringField: string;
begin
  result := 'ClassName';
end;

class function TDeptClass.GetKeyStringProperty: string;
begin
  result:= 'DeptClassName';
end;

function TDeptClass.GetSiteCode: string;
begin
  result:= GetStringField('SiteCode');
end;

procedure TDeptClass.SetSiteCode(const Value: string);
begin
  SetStringField('SiteCode',Value);
end;
Class Procedure TDeptClass.ReadShipToAddress(aClassId:Integer ; var fShipToAddressRec:TAddressRec; aConn :TMyDacDataConnection = nil);
var
  aDeptClass :TDeptClass;
begin
  if (aConn =nil) or (aConn.Connected =False) then begin
    aDeptClass := TDeptClass.CreateWithNewConn(nil);
  end else begin
    aDeptClass := TDeptClass.Create(nil);
    aDeptClass.Connection := aConn;
  end;
  aDeptClass.Load(aClassId);
  if aDeptClass.count <> 0 then begin
      if aDeptClass.UseAddress and ((trim(aDeptClass.Street)<>'') or (trim(aDeptClass.Suburb)<>''))  then begin
          fShipToAddressRec.Line1   := aDeptClass.Street;
          fShipToAddressRec.Line2   := aDeptClass.Street2;
          fShipToAddressRec.Line3   := aDeptClass.Street3;
          fShipToAddressRec.City    := aDeptClass.Suburb;
          fShipToAddressRec.State   := aDeptClass.State;
          fShipToAddressRec.Postcode:= aDeptClass.Postcode;
          fShipToAddressRec.Country := aDeptClass.Country;
      end else begin
          fShipToAddressRec.Line1   := AppEnv.CompanyInfo.Address;
          fShipToAddressRec.Line2   := AppEnv.CompanyInfo.Address2;
          fShipToAddressRec.Line3   := AppEnv.CompanyInfo.Address3;
          fShipToAddressRec.City    := AppEnv.CompanyInfo.City;
          fShipToAddressRec.State   := AppEnv.CompanyInfo.State;
          fShipToAddressRec.Postcode:= AppEnv.CompanyInfo.Postcode;
          fShipToAddressRec.Country := AppEnv.CompanyInfo.Country;
      end;
  end;
end;

class function TDeptClass.SiteCodeForClass(const aClass: string; Conn: TERPConnection = nil): string;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    if Assigned(Conn) then qry.Connection:= Conn
    else qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text:= 'select SiteCode from tblClass where classname = '  + QuotedStr(aClass);
    qry.Open;
    result:= qry.FieldByName('SiteCode').AsString;
  finally
    qry.Free;
  end;
end;
class function TDeptClass.ClassForSitecode(const aSitecode: string; Conn: TERPConnection = nil): string;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    if Assigned(Conn) then qry.Connection:= Conn
    else qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text:= 'select classname from tblClass where  SiteCode= '  + QuotedStr(aSitecode);
    qry.Open;
    result:= qry.FieldByName('classname').AsString;
  finally
    qry.Free;
  end;
end;

function TDeptClass.GetAutoCreateRepair: boolean;
begin
  result:= GetBooleanField('AutoCreateRepairs');
end;

procedure TDeptClass.SetAutoCreateRepair(const Value: boolean);
begin
  SetBooleanField('AutoCreateRepairs',Value);
end;

class function TDeptClass.SiteCodeUnique(const aSiteCode: string;
  const aClassID: integer; Connection: TCustomMyConnection): boolean;
begin
  result:= self.IsUnique(aClassID,'SiteCode = ' + QuotedStr(aSiteCode),Connection);
end;

procedure TDeptClass.DoFieldOnChange(Sender: TField);

  procedure BuildClassGroup;
  var s: string;
  begin
    s:= '';
    if (Level1 <> '') and (Level2 <> '') then s:= Level1;
    if (Level2 <> '') and (Level3 <> '') then s:= s + '^' + Level2;
    if (Level3 <> '') and (Level4 <> '') then s:= s + '^' + Level3;
    DeptClassGroup:= s;
  end;

begin
  inherited;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then Exit; // we are only interested in data fields.

  if SameText(Sender.FieldName , 'ClassName') then begin

  if Sysutils.SameText(Sender.fieldName, 'ClassName') then begin
    if DeptClassName <> trim(DeptClassName) then begin
      DeptClassName :=trim(DeptClassName) ;
      PostDB;
    end;
  end;

    if not RawMode then begin
      if Level1 = '' then Level1:= Sender.AsString
      else if (Level2 = '') and (Level1 <> Sender.AsString) then Level2:= Sender.AsString
      else if (Level3 = '') and (Level2 <> Sender.AsString) then Level3:= Sender.AsString
      else if (Level4 = '') and (Level3 <> Sender.AsString) then Level4:= Sender.AsString;
      BuildClassGroup;
    end;
  end
  else if SameText(Sender.FieldName , 'Level1') then begin
    if not RawMode then begin
      BuildClassGroup;
    end;
  end
  else if SameText(Sender.FieldName , 'Level2') then begin
    if not RawMode then begin
      BuildClassGroup;
    end;
  end
  else if SameText(Sender.FieldName , 'Level3') then begin
    if not RawMode then begin
      BuildClassGroup;
    end;
  end
  else if SameText(Sender.FieldName , 'Level4') then begin
    if not RawMode then begin
      BuildClassGroup;
    end;
  end else if Sysutils.SameText(Sender.fieldName , 'TaxID') then begin
    TaxCodeName:= TTaxCode.IDToggle(TaxID, Connection.Connection,'RegionID = ' + IntToStr(AppEnv.RegionalOptions.ID));
  end
  else if Sysutils.SameText(Sender.fieldName , 'Taxname') then begin
    TaxID:= TTaxCode.IDToggle(self.TaxCodeName, Connection.Connection,'RegionID = ' + IntToStr(AppEnv.RegionalOptions.ID));
  end;
end;

initialization
  RegisterClassOnce(TDeptClass);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Department','TDeptClass','TClassListGUI');
end.







