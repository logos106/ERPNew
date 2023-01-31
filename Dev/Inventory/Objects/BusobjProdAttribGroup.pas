unit BusobjProdAttribGroup;
  {
   Date     Version  Who     What
  -------- -------- ---     ------------------------------------------------------
  12/06/08  1.00.01  Ianos  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, BusObjStock, XMLDoc, XMLIntf, ComCtrls, BusobjAttribProduct;


type
  TProdAttribGroups = class;

  TProdAtribValue = class(TMSBusObj)
  private
    function GetPAN_ID      : Integer;
    function GetValue       : string;
    function GetAbbreviation: string;
    function GetActive      : Boolean;

    procedure SetPAN_ID         (const Value: Integer);
    procedure SetValue          (const Value: string);
    procedure SetAbbreviation   (const Value: string);
    procedure SetActive         (const Value: Boolean);
    function getproductattributenames: String;
    function getPagID: Integer;
    Function makeAbbreviation:String;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);override;
    procedure DoFieldOnChange(Sender: TField);                        override;
    function  GetSQL: string;                                         override;
    function  DoAfterPost(Sender: TDatasetBusObj): Boolean;           override;
    function  DoBeforePost(Sender: TDatasetBusObj): Boolean;          override;
    function  DoBeforeEdit(Sender: TDatasetBusObj): Boolean;          override;
    Function  DoAfterInsert(Sender:TDatasetBusObj):boolean;           Override;
    Function  DoBeforeInsert(Sender:TDatasetBusObj):boolean;           Override;
    procedure InitializeNewObject;                                    override;
    Procedure CreateInstance; override;
  public
    constructor     Create(AOwner: TComponent);                       override;
    destructor      Destroy;                                          override;
    procedure       LoadFromXMLNode (const node: IXMLNode);         override;
    procedure       SaveToXMLNode   (const node: IXMLNode);         override;
    function        ValidateData          : Boolean;                  override;
    function        Save                  : Boolean;                  override;
    class function  GetIDField            : string;                   override;
    class function  GetKeyStringField     : string;                   override;
    class function  GetBusObjectTablename : string;                   override;
    Property        AttributeName         : String    REad getproductattributenames;
    Property        PAG_ID                :Integer    Read getPagID;

  published
    property PAN_ID       : Integer read GetPAN_ID        write SetPAN_ID;
    property Value        : string  read GetValue         write SetValue;
    property Abbreviation : string  read GetAbbreviation  write SetAbbreviation;
    property Active       : Boolean read GetActive        write SetActive;
  end;

  TProdAtribName = class(TMSBusObj)
  private
    AllLinesValid : Boolean;
    function GetPAG_ID                : Integer;
    function GetAttribName            : string;
    function GetActive                : Boolean;
    function GetProductAttributeValues: TProdAtribValue;
    function getproductattributegroups: TProdAttribGroups;

    procedure SetPAG_ID               (const Value: Integer);
    procedure SetAttribName           (const Value: string);
    procedure SetActive               (const Value: Boolean);
    Procedure AttributeNamesStringList(Const Sender: Tbusobj; Var Abort :Boolean);
    Procedure ValidateAttributeValues(Const Sender: Tbusobj; Var Abort :Boolean);
    procedure CloneLines(const Sender: TBusObj; var Abort: boolean);
  protected
    procedure OnDataIdChange  (const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange (Sender: TField); override;
    procedure InitializeNewObject; override;
    function  GetSQL: string; override;
    function  DoAfterPost(Sender: TDatasetBusObj)     : Boolean; override;
    function  DoBeforePost(Sender: TDatasetBusObj)     : Boolean; override;
    function  DoBeforeEdit(Sender: TDatasetBusObj)    : Boolean; override;
    Function  DoAfterInsert(Sender:TDatasetBusobj)    : Boolean; Override;
    Function  DoBeforeInsert(Sender:TDatasetBusobj)   : Boolean; Override;
    Function  ExportsubClasses(Const node: IXMLNode): Boolean; Override;
    Function  ImportsubClasses(const node: IXMLNode): Boolean; Override;
    Procedure ClonePropertyObjects; Override;
    Procedure CreateInstance; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure   LoadFromXMLNode(const node: IXMLNode); override;
    procedure   SaveToXMLNode(const node: IXMLNode); override;
    function    ValidateData: Boolean; override;
    function    Save: Boolean; override;
    class function GetIDField: string; override;
    class function GetKeyStringField: string; override;
    class function GetBusObjectTablename: string; override;
    property ProductAttributeValues: TProdAtribValue read GetProductAttributeValues;
    Property productattributegroups: TProdAttribGroups Read getproductattributegroups; 
  published
    property PAG_ID: Integer read GetPAG_ID write SetPAG_ID;
    property AttribName: string read GetAttribName write SetAttribName;
    property Active: Boolean read GetActive write SetActive;
  end;

  TAttributeProduct = Class(TProduct)
  Private
    fsDesc :String;
    function getProductAttributes: TProductAttributes;
    function getProdDesc: STring;
    Procedure callbackProdDesc(const Sender: TBusObj; var Abort: boolean);
  Public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    Property ProductAttributes :TProductAttributes Read getProductAttributes;
    Property ProdDesc :STring read getProdDesc;
  End;

  TProdAttribGroups = class(TMSBusObj)
  private
    AllLinesValid :boolean;
    fProgressbar: TProgressbar;
    fsOrderbyAttributeName :String;
    fsAllAttibuteIDsExceptOrderby : String;
    function GetGroupName: string;
    function GetActive: Boolean;
    procedure SetGroupName(const Value: string);
    procedure SetActive(const Value: Boolean);
    function getXAxisAttributeID: Integer;
    procedure SetXAxisAttributeID(const Value: Integer);
    function getYAxisAttributeID: Integer;
    function getOrderbyAttributeID: Integer;
    procedure setYAxisAttributeID(const Value: Integer);
    procedure setOrderbyAttributeID(const Value: Integer);
    Procedure AssignXnYAttibsCallback(Const Sender: Tbusobj; Var Abort :Boolean);
    Procedure ValidateAttributeNames(Const Sender: Tbusobj; Var Abort :Boolean);
    function GrouphasStock :Boolean;
    function ChangeActiveofAllProducts :Boolean;
    Procedure LockParts(Const Sender: Tbusobj; Var Abort :Boolean);
    Procedure ChangeActiveofAllProductsCallback(Const Sender: Tbusobj; Var Abort :Boolean);
    Procedure ChangePrrodDescofAllProductsCallback(Const Sender: Tbusobj; Var Abort :Boolean);
    function getAttributeProducts: TProductAttributes;
    function checkExistingProducts: Boolean;
    function getAttributeName: TProdAtribName;
    procedure CloneLines(const Sender: TBusObj; var Abort: boolean);
    function getGroupNAmeForthecopy: STring;
    function getParttype: String;
    procedure SetParttype(const Value: String);
    function getProdDesc: String;
    procedure setProdDesc(const Value: String);
    function getCleanProdDesc: String;
    function getAttributeproduct: TAttributeproduct;
    procedure OrderbyAttributeNameCallback(const Sender: Tbusobj; var Abort: Boolean);
    function getOrderbyAttributeNameIds: String;
    procedure AllAttibuteIDsExceptOrderbyCallback(const Sender: Tbusobj; var Abort: Boolean);
    function GetCustFld1: string;
    function GetCustFld10: string;
    function GetCustFld11: string;
    function GetCustFld12: string;
    function GetCustFld13: string;
    function GetCustFld14: string;
    function GetCustFld15: string;
    function GetCustFld2: string;
    function GetCustFld3: string;
    function GetCustFld4: string;
    function GetCustFld5: string;
    function GetCustFld6: string;
    function GetCustFld7: string;
    function GetCustFld8: string;
    function GetCustFld9: string;
    function GetCustDate1: TDateTime;
    function GetCustDate2: TDateTime;
    function GetCustDate3: TDateTime;
    function GetNotes: string;
    function GetSpecialInstructions: string;
    procedure SetCustFld1(const Value: string);
    procedure SetCustFld10(const Value: string);
    procedure SetCustFld11(const Value: string);
    procedure SetCustFld12(const Value: string);
    procedure SetCustFld13(const Value: string);
    procedure SetCustFld14(const Value: string);
    procedure SetCustFld15(const Value: string);
    procedure SetCustFld2(const Value: string);
    procedure SetCustFld3(const Value: string);
    procedure SetCustFld4(const Value: string);
    procedure SetCustFld5(const Value: string);
    procedure SetCustFld6(const Value: string);
    procedure SetCustFld7(const Value: string);
    procedure SetCustFld8(const Value: string);
    procedure SetCustFld9(const Value: string);
    procedure SetCustDate1(const Value: TDateTime);
    procedure SetCustDate2(const Value: TDateTime);
    procedure SetCustDate3(const Value: TDateTime);
    procedure SetNotes(const Value: string);
    procedure SetSpecialInstructions(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function  GetSQL: string; override;
    function  DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function  DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    procedure InitializeNewObject; override;
    Function  ExportsubClasses(Const node: IXMLNode): Boolean; Override;
    Function  ImportsubClasses(const node: IXMLNode): Boolean; Override;
    Procedure ClonePropertyObjects; Override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    class function GetIDField: string; override;
    class function GetKeyStringField: string; override;
    class function GetBusObjectTablename: string; override;
    function GetAttributeNames:TStringList;
    Procedure AssignXnYAttibs;
    function Lock:boolean; override;
    Property AttributeProducts :TProductAttributes read getAttributeProducts;
    Property AttributeNames    :TProdAtribName REad getAttributeName;
    Function LockProduct(fTablename :String;const fProductID:Integer;Const fProductname:STring;const fLockgroupname:String):Boolean;
    Property cleanProdDesc:String read getCleanProdDesc;
    function ChangePrrodDescofAllProducts:Boolean;
    Property AttribProducts: TAttributeproduct read getAttributeproduct;
    Procedure EnableProgressbar(visible :Boolean; Max :Integer);
    Procedure StepProgress;
    Function OrderbyAttributeName:String;
    Property OrderbyAttributeNameIds:String read getOrderbyAttributeNameIds;
  published
    property GroupName: string read GetGroupName write SetGroupName;
    Property PartType :String Read getParttype Write SetParttype;
    Property ProdDesc :String Read getProdDesc Write setProdDesc;
    property Active: Boolean read GetActive write SetActive;
    Property XAxisAttributeID :Integer Read getXAxisAttributeID Write SetXAxisAttributeID;
    Property YAxisAttributeID :Integer read getYAxisAttributeID Write setYAxisAttributeID;
    Property OrderbyAttributeID :Integer read getOrderbyAttributeID Write setOrderbyAttributeID;
    Property ProductsExist    :Boolean Read checkExistingProducts;
    Property GroupNAmeForthecopy :STring REad getGroupNAmeForthecopy;
    property Progressbar :TProgressbar read fProgressbar write fProgressbar;
    property CUSTFLD1: string read GetCustFld1 write SetCustFld1;
    property CUSTFLD2: string read GetCustFld2 write SetCustFld2;
    property CUSTFLD3: string read GetCustFld3 write SetCustFld3;
    property CUSTFLD4: string read GetCustFld4 write SetCustFld4;
    property CUSTFLD5: string read GetCustFld5 write SetCustFld5;
    property CUSTFLD6: string read GetCustFld6 write SetCustFld6;
    property CUSTFLD7: string read GetCustFld7 write SetCustFld7;
    property CUSTFLD8: string read GetCustFld8 write SetCustFld8;
    property CUSTFLD9: string read GetCustFld9 write SetCustFld9;
    property CUSTFLD10: string read GetCustFld10 write SetCustFld10;
    property CUSTFLD11: string read GetCustFld11 write SetCustFld11;
    property CUSTFLD12: string read GetCustFld12 write SetCustFld12;
    property CUSTFLD13: string read GetCustFld13 write SetCustFld13;
    property CUSTFLD14: string read GetCustFld14 write SetCustFld14;
    property CUSTFLD15: string read GetCustFld15 write SetCustFld15;
    property CUSTDATE1: TDateTime read GetCustDate1 write SetCustDate1;
    property CUSTDATE2: TDateTime read GetCustDate2 write SetCustDate2;
    property CUSTDATE3: TDateTime read GetCustDate3 write SetCustDate3;
    property Notes: string read GetNotes write SetNotes;
    property SpecialInstructions: string read GetSpecialInstructions write SetSpecialInstructions;
  end;

  TProductAttributeGroupHelper = class(TMSBusObj)
  private
    function GetGroupId: integer;
    function GetGroupName: string;
    function GetProductID: integer;
    function GetProductName: string;
  protected
    function GetMsTimeStamp: TDateTime; override;
    function GetMsUpdateSiteCode: string; override;
    function GetGlobalRef: string; override;
    function GetId: integer; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function  GetIDField            : string;                   override;
    class function  GetBusObjectTablename : string;                   override;
    function APIListDefaultProperties: string; override;
  published
    property GroupName: string read GetGroupName;
    property GroupID: integer read GetGroupId;
    property ProductName: string read GetProductName;
    property ProductID: integer read GetProductID;
  end;

implementation


uses  CommonLib, BusObjConst, sysutils, ProductQtyLib,
  UserLockObj, tcConst, CommonDbLib , PQALib;

var
  tmpStringList: TStringList;

{ TProdAtribValue }

constructor TProdAtribValue.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'Product Attribute Values';
  fSQL := 'SELECT * FROM tblproductattributevalues ';
   FieldsnotToclone := 'ID';
end;


class function TProdAtribValue.GetIDField: string;
begin
  Result := 'PAV_ID'
end;


class function TProdAtribValue.GetKeyStringField: string;
begin
  Result := ''
end;


class function TProdAtribValue.GetBusObjectTablename: string;
begin
  Result := 'tblproductattributevalues'
end;


destructor TProdAtribValue.Destroy;
begin
  inherited;
end;


procedure TProdAtribValue.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'PAN_ID');
  SetPropertyFromNode(node, 'Value');
  SetPropertyFromNode(node, 'Abbreviation');
  SetPropertyFromNode(node, 'Active');
end;


procedure TProdAtribValue.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'PAN_ID', PAN_ID);
  AddXMLNode(node, 'Value', Value);
  AddXMLNode(node, 'Abbreviation', Abbreviation);
  AddXMLNode(node, 'Active', Active);
end;


function TProdAtribValue.ValidateData: Boolean;
var
  strSQL:String;
begin
  Result := false;
  Resultstatus.Clear;
  if Value = '' then begin
    Resultstatus.AddItem(false, rssError, 0, 'Attribute Value must not be blank', True);
    Exit;
  end;
  strSQL := 'Select PAV_ID from tblproductattributevalues where (Value = ' +quoteDStr(Value) +
            ' or  Abbreviation = ' +quotedStr(Abbreviation)+ ')' +
            ' and PAV_ID <> ' +IntToStr(ID) + ' and PAN_ID = ' + IntToStr(PAN_ID);
  with getNewDataset(strSql , True) do try
    if recordcount > 0 then begin
        ResultStatus.AddItem(False , rsswarning, 0 , 'Value / Abbrevation is not unique for ' + AttributeName);
        Exit;
    end;
  finally
      if active then close;
      Free;
  end;
  if Abbreviation = '' then begin
      ResultStatus.AddItem(False , rssInfo, 0 , 'Abbreviation is blank for ' + Value +' of '  + AttributeName);
      Result := False;
      Exit;
  end;
  Result := true;
end;


function TProdAtribValue.Save: Boolean;
begin
  Result := false;
  if Not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TProdAtribValue.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  
end;


procedure TProdAtribValue.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.fieldName , 'Value') then begin
      if Abbreviation = '' then Abbreviation := makeAbbreviation;
  end;
end;


function TProdAtribValue.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


function TProdAtribValue.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then Exit;
  if Value = '' then begin
    delete;
    Exit;
  End;

end;


{Property functions}
function TProdAtribValue.GetValue       : string    ;begin  Result := GetStringField('Value')                         ;end;
function TProdAtribValue.GetActive      : Boolean   ;begin  Result := GetBooleanField('Active')                       ;end;
function TProdAtribValue.GetAbbreviation: string    ;begin  Result := GetStringField('Abbreviation')                  ;end;
function TProdAtribValue.GetPAN_ID      : Integer   ;begin  Result := GetIntegerField('PAN_ID')                       ;end;
function TProdAttribGroups.GetCustDate1   : TDateTime ;begin  Result := GetDateTimeField('CUSTDATE1')                   ;end;
function TProdAttribGroups.GetCustDate2   : TDateTime ;begin  Result := GetDateTimeField('CUSTDATE2')                   ;end;
function TProdAttribGroups.GetCustDate3   : TDateTime ;begin  Result := GetDateTimeField('CUSTDATE3')                   ;end;
function TProdAttribGroups.GetCustFld1    : string    ;begin  Result := GetStringField('CUSTFLD1')                      ;end;
function TProdAttribGroups.GetCustFld10   : string    ;begin  Result := GetStringField('CUSTFLD10')                     ;end;
function TProdAttribGroups.GetCustFld11   : string    ;begin  Result := GetStringField('CUSTFLD11')                     ;end;
function TProdAttribGroups.GetCustFld12   : string    ;begin  Result := GetStringField('CUSTFLD12')                     ;end;
function TProdAttribGroups.GetCustFld13   : string    ;begin  Result := GetStringField('CUSTFLD13')                     ;end;
function TProdAttribGroups.GetCustFld14   : string    ;begin  Result := GetStringField('CUSTFLD14')                     ;end;
function TProdAttribGroups.GetCustFld15   : string    ;begin  Result := GetStringField('CUSTFLD15')                     ;end;
function TProdAttribGroups.GetCustFld2    : string    ;begin  Result := GetStringField('CUSTFLD2')                      ;end;
function TProdAttribGroups.GetCustFld3    : string    ;begin  Result := GetStringField('CUSTFLD3')                      ;end;
function TProdAttribGroups.GetCustFld4    : string    ;begin  Result := GetStringField('CUSTFLD4')                      ;end;
function TProdAttribGroups.GetCustFld5    : string    ;begin  Result := GetStringField('CUSTFLD5')                      ;end;
function TProdAttribGroups.GetCustFld6    : string    ;begin  Result := GetStringField('CUSTFLD6')                      ;end;
function TProdAttribGroups.GetCustFld7    : string    ;begin  Result := GetStringField('CUSTFLD7')                      ;end;
function TProdAttribGroups.GetCustFld8    : string    ;begin  Result := GetStringField('CUSTFLD8')                      ;end;
function TProdAttribGroups.GetCustFld9    : string    ;begin  Result := GetStringField('CUSTFLD9')                      ;end;
function TProdAttribGroups.GetNotes       : string    ;begin  Result := GetStringField('Notes')                         ;end;
function TProdAttribGroups.GetSpecialInstructions: string    ;begin  Result := GetStringField('SpecialInstructions')    ;end;

procedure TProdAtribValue.SetValue        (const Value: string)     ;begin  SetStringField('Value'        , Value);end;
procedure TProdAtribValue.SetActive       (const Value: Boolean)    ;begin  SetBooleanField('Active'      , Value);end;
procedure TProdAtribValue.SetPAN_ID       (const Value: Integer)    ;begin  SetIntegerField('PAN_ID'      , Value);end;
procedure TProdAtribValue.SetAbbreviation (const Value: string)     ;begin  SetStringField('Abbreviation' , Value);end;
procedure TProdAttribGroups.SetCustDate1    (const Value: TDateTime)  ;begin  SetDateTimeField('CUSTDATE1'  , Value);end;
procedure TProdAttribGroups.SetCustDate2    (const Value: TDateTime)  ;begin  SetDateTimeField('CUSTDATE2'  , Value);end;
procedure TProdAttribGroups.SetCustDate3    (const Value: TDateTime)  ;begin  SetDateTimeField('CUSTDATE3'  , Value);end;
procedure TProdAttribGroups.SetCustFld1     (const Value: string)     ;begin  SetStringField('CUSTFLD1'     , Value);end;
procedure TProdAttribGroups.SetCustFld10    (const Value: string)     ;begin  SetStringField('CUSTFLD10'    , Value);end;
procedure TProdAttribGroups.SetCustFld11    (const Value: string)     ;begin  SetStringField('CUSTFLD11'    , Value);end;
procedure TProdAttribGroups.SetCustFld12    (const Value: string)     ;begin  SetStringField('CUSTFLD12'    , Value);end;
procedure TProdAttribGroups.SetCustFld13    (const Value: string)     ;begin  SetStringField('CUSTFLD13'    , Value);end;
procedure TProdAttribGroups.SetCustFld14    (const Value: string)     ;begin  SetStringField('CUSTFLD14'    , Value);end;
procedure TProdAttribGroups.SetCustFld15    (const Value: string)     ;begin  SetStringField('CUSTFLD15'    , Value);end;
procedure TProdAttribGroups.SetCustFld2     (const Value: string)     ;begin  SetStringField('CUSTFLD2'     , Value);end;
procedure TProdAttribGroups.SetCustFld3     (const Value: string)     ;begin  SetStringField('CUSTFLD3'     , Value);end;
procedure TProdAttribGroups.SetCustFld4     (const Value: string)     ;begin  SetStringField('CUSTFLD4'     , Value);end;
procedure TProdAttribGroups.SetCustFld5     (const Value: string)     ;begin  SetStringField('CUSTFLD5'     , Value);end;
procedure TProdAttribGroups.SetCustFld6     (const Value: string)     ;begin  SetStringField('CUSTFLD6'     , Value);end;
procedure TProdAttribGroups.SetCustFld7     (const Value: string)     ;begin  SetStringField('CUSTFLD7'     , Value);end;
procedure TProdAttribGroups.SetCustFld8     (const Value: string)     ;begin  SetStringField('CUSTFLD8'     , Value);end;
procedure TProdAttribGroups.SetCustFld9     (const Value: string)     ;begin  SetStringField('CUSTFLD9'     , Value);end;
procedure TProdAttribGroups.SetNotes        (const Value: string)     ;begin  SetStringField('Notes'        , Value);end;
procedure TProdAttribGroups.SetSpecialInstructions(const Value: string)     ;begin  SetStringField('SpecialInstructions', Value);end;


procedure TProdAtribValue.InitializeNewObject;
begin
  inherited;
end;


function TProdAtribValue.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
  REsult := inherited DoAfterInsert(Sender);
  if not result then exit;

  if assigned(Self.Owner) then
    if self.Owner is TProdAtribName then begin
        TProdAtribName(self.Owner).postDB;
        Self.PAN_ID := TProdAtribName(Self.Owner).ID;
    End;
end;

function TProdAtribValue.getproductattributenames: String ;
begin
  result := '';
  if Assigned(Self.Owner) then
    if Self.Owner is  TProdAtribName then
      Result := TProdAtribName(Self.Owner).AttribName;
end;

function TProdAtribValue.getPagID: Integer;
begin
  result := 0;
  if Assigned(Self.Owner) and (Self.Owner is TProdAtribName) then
    REsult := TProdAtribName(Self.Owner).PAG_ID;
end;

function TProdAtribValue.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoBeforePost(Sender);
  if not result then exit;
  
end;

function TProdAtribValue.makeAbbreviation: String;
var
  strSQL, x:String;
  i, ii:Integer;

begin
  ii:= 3;
  if ii > char_length(Value) then ii := char_length(Value);
  for i := ii to char_length(Value)  do begin
    x := copy(Value , 0 , i);
    strSQL := 'Select PAV_ID from tblproductattributevalues ' +
            //' where (Value <> ' +quoteDStr(Value) +
            ' where Abbreviation = ' +quotedStr(x)+
            ' and PAV_ID <> ' +IntToStr(ID) + ' and PAN_ID = ' + IntToStr(PAN_ID);
    with getNewDataset(strSQL , true) do try
        if recordcount = 0 then begin
            REsult := x;
            break;
        end;
    finally
        if active then close;
        Free;
    end;
  end;

end;

function TProdAtribValue.DoBeforeEdit(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforeEdit(Sender);
  if not result then exit;
  if CleanId <> 0 then begin
    result := False;
    abort;
  end;
end;

function TProdAtribValue.DoBeforeInsert(Sender: TDatasetBusObj): boolean;
begin
  REsult := inherited DoBeforeInsert(Sender);
  if not result then exit;

  if assigned(Self.Owner) then
    if self.Owner is TProdAtribName then begin
        TProdAtribName(self.Owner).postDB;
        if TProdAtribName(Self.Owner).ID = 0 then begin
          REsult := False;
          Abort;
        end;
    End;

end;

procedure TProdAtribValue.CreateInstance;
begin
    if Owner is TProdAtribName then
        if Assigned(TProdAtribName(Owner).ObjInstanceToClone) then
            ObjInstanceToClone :=TProdAtribName(TProdAtribName(Owner).ObjInstanceToClone).ProductAttributeValues;
end;

{ TProdAtribName }

constructor TProdAtribName.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'Product Attribute Names';
  fSQL := 'SELECT * FROM tblproductattributenames';
   FieldsnotToclone := 'ID';
end;


class function TProdAtribName.GetIDField: string;
begin
  Result := 'PAN_ID'
end;


class function TProdAtribName.GetKeyStringField: string;
begin
  Result := ''
end;


class function TProdAtribName.GetBusObjectTablename: string;
begin
  Result := 'tblproductattributenames'
end;


destructor TProdAtribName.Destroy;
begin
  inherited;
end;


procedure TProdAtribName.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'PAG_ID');
  SetPropertyFromNode(node, 'AttribName');
  SetPropertyFromNode(node, 'Active');
  ImportsubClasses(node);
end;


procedure TProdAtribName.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'PAG_ID', PAG_ID);
  AddXMLNode(node, 'AttribName', AttribName);
  AddXMLNode(node, 'Active', Active);
  ExportsubClasses(Node);
end;


function TProdAtribName.ValidateData: Boolean;
begin
  Result := false;
  Resultstatus.Clear;
  if AttribName = '' then begin
    Resultstatus.AddItem(false, rssError, 0, 'Attribute Name must not be blank', True);
    Exit;
  end;

  if not self.IsUnique(ID,'Name = ' + QuotedStr(AttribName)+' and PAG_ID = ' + inttostr(PAG_ID) ,Connection.connection) then begin
    Resultstatus.AddItem(false, rssError, 0, 'Attribute Name '+ AttribName + ' Should be Unique', True);
    Exit;
  end;
  AllLinesValid := True;
  ProductAttributeValues.iterateRecords(ValidateAttributeValues);
  if not(AllLinesValid) then Exit;
  Result := true;
end;
procedure TProdAtribName.ValidateAttributeValues(const Sender: Tbusobj; var Abort: Boolean);
begin
  if not (Sender is TProdAtribValue) then exit;
  if not (TProdAtribValue(Sender).ValidateData) then begin
      AllLinesValid := False;
      abort := true;
  end;
end;


function TProdAtribName.Save: Boolean;
begin
  Result := false;
  if Not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TProdAtribName.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  ResultStatus.Clear;
  Self.ProductAttributeValues.closedb;
  Self.ProductAttributeValues;
end;


procedure TProdAtribName.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
end;
function TProdAtribName.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


function TProdAtribName.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
  if Attribname = '' then begin
//    delete;
    Exit;
  end else begin
    if Assigned(productattributegroups) then
      productattributegroups.AssignXnYAttibs;
    Self.ProductAttributeValues;
  end;
end;


{Property functions}
function TProdAtribName.GetPAG_ID: Integer; 
begin 
  Result := GetIntegerField('PAG_ID');
end;

function TProdAtribName.GetAttribName: string;
begin 
  Result := GetStringField('Name');
end;

function TProdAtribName.GetActive: Boolean; 
begin 
  Result := GetBooleanField('Active');
end;

procedure TProdAtribName.SetPAG_ID(const Value: Integer); 
begin 
  SetIntegerField('PAG_ID', Value);
end;

procedure TProdAtribName.SetAttribName(const Value: string);
begin 
  SetStringField('Name', Value);
end;

procedure TProdAtribName.SetActive(const Value: Boolean); 
begin 
  SetBooleanField('Active', Value);
end;

function TProdAtribName.GetProductAttributeValues: TProdAtribValue;
begin
  REsult := TProdAtribValue(getContainerComponent(TProdAtribValue , 'PAN_ID= '+ IntToStr(ID) ));
end;

procedure TProdAtribName.InitializeNewObject;
begin
  inherited;
end;

procedure TProdAtribName.AttributeNamesStringList( const Sender: Tbusobj; var Abort: Boolean);
begin
  If Assigned(tmpStringList) then Begin
    tmpStringList.Add(Self.AttribName);
  end;
end;

function TProdAtribName.getproductattributegroups: TProdAttribGroups;
begin
  Result := nil;
  if Assigned(Self.Owner) then
    if Self.Owner is TProdAttribGroups then
      REsult := TProdAttribGroups(Self.Owner);
end;

function TProdAtribName.DoAfterInsert(Sender: TDatasetBusobj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(productattributegroups) then begin
    productattributegroups.PostDB;
    PAG_ID := productattributegroups.ID;
  end;
  Self.ProductAttributeValues;
end;

function TProdAtribName.DoBeforeEdit(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforeEdit(Sender);
  if not result then exit;
  if productattributegroups.ProductsExist then begin
    result := false;
    Abort;
  end;
end;

function TProdAtribName.DoBeforeInsert(Sender: TDatasetBusobj): Boolean;
begin
  result := inherited DoBeforeInsert(Sender);
  if not result then exit;
  if productattributegroups.ProductsExist then begin
    result := false;
    Abort;
  end;
end;

function TProdAtribName.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforePost(Self);
  if not result then exit;

  if not self.IsUnique(ID,'Name = ' + QuotedStr(AttribName)+' and PAG_ID = ' + inttostr(PAG_ID) ,Connection.connection) then begin
    Resultstatus.AddItem(false, rssError, 0, 'Attribute Name '+ AttribName + ' Should be Unique', True);
    Result:= False;
    Abort;
  end;
end;

function TProdAtribName.ExportsubClasses(const node: IXMLNode): Boolean;
begin
    self.ProductAttributeValues.XMLPropertyNode := node.AddChild(ProductAttributeValues.XMLBranchname);
    self.ProductAttributeValues.XMLPropertyName:= 'Values';
    self.ProductAttributeValues.IterateRecords(GetPropertyXMLCallback);
    REsult := True;
end;

function TProdAtribName.ImportsubClasses(const node: IXMLNode): Boolean;
var
  x:Integer;
  Singlerec :IXMLNode;
begin
    Result := False;
    ImportFailed := False;
    ImportFailed := False;
    XMLPropertyName :='ProductAttributeValues';
    XMLPropertyNode := node.ChildNodes.FindNode(XMLPropertyName);
    if Assigned(XMLPropertyNode) then begin
        for x := 0 to XMLPropertyNode.ChildNodes.Count - 1 do begin
            ProductAttributeValues.ImportingFromXMLFile := True;
            Singlerec:= XMLPropertyNode.ChildNodes[x];
            ProductAttributeValues.ImportFromXML(SingleRec);
            ImportFailed :=ProductAttributeValues.ImportFailed;
            if Error then Exit;
        end;
    end;
end;

procedure TProdAtribName.ClonePropertyObjects;
begin
  inherited;
  ProductAttributeValues.IterateRecords(CloneLines);
end;

procedure TProdAtribName.CloneLines(const Sender:TBusObj;var Abort: boolean);
begin
  Sender.CloneBusObj(IDFieldNAme,ObjInstanceToClone.ID,False);
end;
procedure TProdAtribName.CreateInstance;
begin
    if Owner is TProdAttribGroups then
        if Assigned(TProdAttribGroups(Owner).ObjInstanceToClone) then
            ObjInstanceToClone :=TProdAttribGroups(TProdAttribGroups(Owner).ObjInstanceToClone).AttributeNames;
end;

{ TProdAttribGroups }
constructor TProdAttribGroups.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'Product Attribute Groups';
  fSQL := 'SELECT * FROM tblproductattributegroups';
  fProgressbar := nil;
  FieldsnotToclone := QuotedStr('ID') +','+
                      QuotedStr('XAxisAttributeID') +','+
                      QuotedStr('YAxisAttributeID')+',' +
                      QuotedStr('OrderbyAttributeID');
end;


class function TProdAttribGroups.GetIDField: string;
begin
  Result := 'PAG_ID';
end;


class function TProdAttribGroups.GetKeyStringField: string;
begin
  Result := 'name';
end;


class function TProdAttribGroups.GetBusObjectTablename: string;
begin
  Result := 'tblproductattributegroups';
end;


destructor TProdAttribGroups.Destroy;
begin
  inherited;
end;


procedure TProdAttribGroups.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'Groupname');
  SetPropertyFromNode(node, 'Active');
  SetPropertyFromNode(node, 'PartType');
  SetPropertyFromNode(node, 'ProdDesc');
  SetPropertyFromNode(node , 'CUSTFLD1');
  SetPropertyFromNode(node , 'CUSTFLD2');
  SetPropertyFromNode(node , 'CUSTFLD3');
  SetPropertyFromNode(node , 'CUSTFLD4');
  SetPropertyFromNode(node , 'CUSTFLD5');
  SetPropertyFromNode(node , 'CUSTFLD6');
  SetPropertyFromNode(node , 'CUSTFLD7');
  SetPropertyFromNode(node , 'CUSTFLD8');
  SetPropertyFromNode(node , 'CUSTFLD9');
  SetPropertyFromNode(node , 'CUSTFLD10');
  SetPropertyFromNode(node , 'CUSTFLD11');
  SetPropertyFromNode(node , 'CUSTFLD12');
  SetPropertyFromNode(node , 'CUSTFLD13');
  SetPropertyFromNode(node , 'CUSTFLD14');
  SetPropertyFromNode(node , 'CUSTFLD15');
  SetDateTimePropertyFromNode(node , 'CUSTDATE1');
  SetDateTimePropertyFromNode(node , 'CUSTDATE2');
  SetDateTimePropertyFromNode(node , 'CUSTDATE3');
  SetPropertyFromNode(node , 'Notes');
  SetPropertyFromNode(node , 'SpecialInstructions');
  ImportsubClasses(node);
end;


procedure TProdAttribGroups.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'Groupname', Groupname);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'PartType', partType);
  AddXMLNode(node, 'ProdDesc', ProdDesc);
  AddXMLNode(node , 'CUSTFLD1'         ,  CustFld1);
  AddXMLNode(node , 'CUSTFLD2'         ,  CustFld2);
  AddXMLNode(node , 'CUSTFLD3'         ,  CustFld3);
  AddXMLNode(node , 'CUSTFLD4'         ,  CustFld4);
  AddXMLNode(node , 'CUSTFLD5'         ,  CustFld5);
  AddXMLNode(node , 'CUSTFLD6'         ,  CustFld6);
  AddXMLNode(node , 'CUSTFLD7'         ,  CustFld7);
  AddXMLNode(node , 'CUSTFLD8'         ,  CustFld8);
  AddXMLNode(node , 'CUSTFLD9'         ,  CustFld9);
  AddXMLNode(node , 'CUSTFLD10'         ,  CustFld10);
  AddXMLNode(node , 'CUSTFLD11'         ,  CustFld11);
  AddXMLNode(node , 'CUSTFLD12'         ,  CustFld12);
  AddXMLNode(node , 'CUSTFLD13'         ,  CustFld13);
  AddXMLNode(node , 'CUSTFLD14'         ,  CustFld14);
  AddXMLNode(node , 'CUSTFLD15'         ,  CustFld15);
  AddXMLNode(node , 'CUSTDATE1'         ,  CustDate1);
  AddXMLNode(node , 'CUSTDATE2'         ,  CustDate2);
  AddXMLNode(node , 'CUSTDATE3'         ,  CustDate3);
  AddXMLNode(node , 'Notes'             ,  Notes);
  AddXMLNode(node , 'SpecialInstructions',  SpecialInstructions);
  ExportsubClasses(Node);
end;


function TProdAttribGroups.ValidateData: Boolean;
begin
  Result := false;
  Resultstatus.Clear;
  if Groupname = '' then begin
    Resultstatus.AddItem(false, rssError, 0, 'Attribute Group must not be blank', True);
    Exit;
  end;
  if Parttype = '' then Parttype := 'INV';
  AssignXnYAttibs;

  if AttributeNames.count >=1 then begin 
      if XAxisAttributeID= 0 then begin
         Resultstatus.AddItem(false, rssError, 0, 'X-Attribute is not selected', True);
         Exit;
      end;
      if AttributeNames.Dataset.Locate('Pan_Id' , XAxisAttributeID , []) then
        if AttributeNames.active = False then begin
         Resultstatus.AddItem(false, rssError, 0, 'Selected X-Attribute is inactive', True);
         Exit;
      end;
      if OrderbyAttributeID= 0 then begin
         Resultstatus.AddItem(false, rssError, 0, 'Order by Attribute is not selected', True);
         Exit;
      end;
      if AttributeNames.Dataset.Locate('PAN_ID' ,  OrderbyAttributeID , []) then
        if AttributeNames.Active = False then begin
         Resultstatus.AddItem(false, rssError, 0, 'Selected Order by Attribute is inactive', True);
         Exit;
      end;
  end;
  if AttributeNames.count >= 2 then begin
      if YAxisAttributeID= 0 then begin
         Resultstatus.AddItem(false, rssError, 0, 'Y-Attribute is not selected', True);
         Exit;
      end;
      if AttributeNames.Dataset.Locate('PAN_ID' ,  YAxisAttributeID , []) then
        if AttributeNames.Active = False then begin
         Resultstatus.AddItem(false, rssError, 0, 'Selected Y-Attribute is inactive', True);
         Exit;
      end;
  end;
  if  (YAxisAttributeID =  XAxisAttributeID) and (YAxisAttributeID <> 0) then begin
    Resultstatus.AddItem(false, rssError, 0, 'X-Attribute and Y-Attribute should be different', True);
    Exit;
  end;
  AllLinesValid := True;
  AttributeNames.IterateRecords(ValidateAttributeNames);
  if not AllLinesValid then Exit;
  Result := true;
end;
procedure TProdAttribGroups.ValidateAttributeNames(const Sender: Tbusobj; var Abort: Boolean);
begin
  if not(Sender is TProdAtribName) then exit;
  if not(TProdAtribName(Sender).ValidateData) then begin
      AllLinesValid := False;
      abort := True;
  end;
end;


function TProdAttribGroups.Save: Boolean;
begin
  Result := false;
  if Not ValidateData then Exit;
  Result := inherited Save;
  if not result then Exit;
  UserLock.Unlock(LockMsgDelPriceMtxProduct);

end;


procedure TProdAttribGroups.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  AssignXnYAttibs;
end;


function TProdAttribGroups.OrderbyAttributeName: String;
begin
  fsOrderbyAttributeName :='';
  AttributeNames.IterateRecords(OrderbyAttributeNameCallback);
  REsult:= fsOrderbyAttributeName;
  if result = '' then begin
    AttributeNames.first;
    result := AttributeNames.Attribname;
  end;
  if result = '' then
    REsult:= 'Groupname';
end;
Procedure TProdAttribGroups.OrderbyAttributeNameCallback(Const Sender: Tbusobj; Var Abort :Boolean);
begin
  if not(Sender is TProdAtribName) then exit;
  if TProdAtribName(Sender).ID = OrderbyAttributeID then begin
    fsOrderbyAttributeName :=TProdAtribName(Sender).AttribName;
    abort := True;
  end;

end;
procedure TProdAttribGroups.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if (self.ID < 1) and (self.Groupname <> '') then
    InitializeNewObject;
    
  if Sysutils.SameText(Sender.fieldName , 'Name') then Begin
    if ProdDesc = '' then ProdDesc := Groupname;
  end else if Sysutils.SameText(Sender.fieldName , 'ProdDesc') then Begin
    if cleanProdDesc <> ProdDesc then ChangePrrodDescofAllProducts;
  end else if Sysutils.SameText(Sender.fieldName , 'Active') then Begin
    if not Active then
      if GrouphasStock then begin
        REsultstatus.AddItem(False, rssWarning , 0 ,
                'This Group Can''t be made inactive' + chr(13) +chr(13) +
                'There is stock or transactions outstanding for some of the product(s) in the Group.' , true);
        Active := True;
        Exit;
      end;
      if not(ChangeActiveofAllProducts) then begin
        Active := True;
      end;;
  end else if (Sysutils.SameText(Sender.fieldname , 'XAxisAttribute')) then begin
    if  (YAxisAttributeID =  XAxisAttributeID) and (XAxisAttributeID <> 0) then begin
          REsultstatus.AddItem(true, rssInfo, 0, 'X-Attribute and Y-Attribute should be different', True);
          YAxisAttributeID := 0;
          PostDB;
          Exit;
      end;
  end else if (Sysutils.SameText(Sender.fieldname , 'YAxisAttribute')) then begin
      if  (YAxisAttributeID =  XAxisAttributeID) and (YAxisAttributeID <> 0) then begin
          REsultstatus.AddItem(true, rssInfo, 0, 'X-Attribute and Y-Attribute should be different', True);
          XAxisAttributeID := 0;
          PostDB;
          Exit;
      end;
  end;
end;


function TProdAttribGroups.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

function TProdAttribGroups.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
  if GroupName = '' then begin
  end else AssignXnYAttibs;
end;
{Property functions}
function TProdAttribGroups.GetGroupName: string;
begin
  Result := GetStringField('Name');
end;

function TProdAttribGroups.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

procedure TProdAttribGroups.SetGroupName(const Value: string);
begin 
  SetStringField('Name', Value);
end;

procedure TProdAttribGroups.SetActive(const Value: Boolean);
begin 
  SetBooleanField('Active', Value);
end;

procedure TProdAttribGroups.InitializeNewObject;
begin
  inherited;
  Self.PostDb;
  Self.AttributeNames;
  SendEvent(BusObjEventVal_AtrribGrp_New , Groupname);
end;


function TProdAttribGroups.GetAttributeNames: TStringList;
begin
  tmpStringList := TStringList.Create;
  AttributeNames.Iteraterecords(AttributeNames.AttributeNamesStringList);
  Result := tmpStringList;
  tmpStringList := nil;
end;

function TProdAttribGroups.getXAxisAttributeID: Integer;
begin
  Result := GetIntegerField('XAxisAttribute');
end;

procedure TProdAttribGroups.SetXAxisAttributeID(const Value: Integer);
begin
  setintegerField('XAxisAttribute' , Value);
end;

function TProdAttribGroups.getYAxisAttributeID: Integer;
begin
  REsult := GetIntegerField('YAxisAttribute');
end;
function TProdAttribGroups.getOrderbyAttributeID: Integer;
begin
  REsult := GetIntegerField('OrderbyAttribute');
end;
Procedure TProdAttribGroups.AllAttibuteIDsExceptOrderbyCallback(Const Sender: Tbusobj; Var Abort :Boolean);
begin
  if not (Sender is TProdAtribName) then exit;
  if sametext(TProdAtribName(Sender).AttribName  , fsOrderbyAttributeName) then exit;
  if fsAllAttibuteIDsExceptOrderby <> '' then fsAllAttibuteIDsExceptOrderby := fsAllAttibuteIDsExceptOrderby +',';
  fsAllAttibuteIDsExceptOrderby := fsAllAttibuteIDsExceptOrderby + '`' +TProdAtribName(Sender).AttribName +'_ID`';
end;

function TProdAttribGroups.getOrderbyAttributeNameIds: String;
var
  s:String;
  function AllAttibuteIDsExceptOrderby:String;
  begin
    fsAllAttibuteIDsExceptOrderby:= '';
    AttributeNames.Iteraterecords(AllAttibuteIDsExceptOrderbyCallback);
    result := fsAllAttibuteIDsExceptOrderby;
  end;
begin
  result :=OrderbyAttributeName;
  if result <> '' then result := '`' + result +'_ID`';
  s:= AllAttibuteIDsExceptOrderby;
  if s<> '' then begin
    if result <> '' then result := result +',';
    result := result +s;
  end;
end;

procedure TProdAttribGroups.setYAxisAttributeID(const Value: Integer);
begin
  SetIntegerField('YAxisAttribute' , Value);
end;
procedure TProdAttribGroups.setOrderbyAttributeID(const Value: Integer);
begin
  SetIntegerField('OrderbyAttribute' , Value);
end;

procedure TProdAttribGroups.AssignXnYAttibsCallback(const Sender: Tbusobj;var Abort: Boolean);
begin
  if not(Sender is TProdAtribName) then Exit;
  if (XAxisAttributeID = 0) and (TProdAtribName(Sender).ID <> YAxisAttributeID) then begin
      XAxisAttributeID := TProdAtribName(Sender).ID;
      PostDB;
  end;
  if (YAxisAttributeID = 0) and (TProdAtribName(Sender).ID <> XAxisAttributeID) then begin
      YAxisAttributeID := TProdAtribName(Sender).ID;
      PostDB;
  end;
  if (OrderbyAttributeID = 0) then begin
      OrderbyAttributeID := TProdAtribName(Sender).ID;
      PostDB;
  end;

  if (YAxisAttributeID <> 0) and (XAxisAttributeID <> 0) then Abort := True;
end;

procedure TProdAttribGroups.AssignXnYAttibs;
begin
  if ((YAxisAttributeID = 0) or  (XAxisAttributeID=0)) and (AttributeNames.count > 0) then
    AttributeNames.IterateRecords(AssignXnYAttibsCallback);
end;

function TProdAttribGroups.GrouphasStock: Boolean;
var
  strSQL:String;
begin
    strSQL := 'Select distinct PQA.ProductID,';
    strSQL := strSQL +' ' + ProductQtyLib.SQL4Qty(tInvBO)+ ' as AllocatedBOQty, ';
    strSQL := strSQL +' ' + ProductQtyLib.SQL4Qty(tSO)+ ' as SOQty, ';
    strSQL := strSQL +' ' + ProductQtyLib.SQL4Qty(tSOBO)+ ' as SOBOQty, ';
    strSQL := strSQL +' ' + ProductQtyLib.SQL4Qty(tInStock)+ ' as InstockQty, ';
    strSQL := strSQL +' ' + ProductQtyLib.SQL4Qty(tPOBO) + ' as POBOQty ';
    strSQL := strSQL +' ' + 'from tblPQA as PQA ';  //where PQA.ProductID = ' + IntToStr(PartsID);
    strSQL := strSQL +' ' + 'inner join tblproductattributeproducts PAP on PAP.ProductID = PQA.ProductID and PAP.PAG_ID = ' + InttoStr(ID);
    strSQL := strSQL +' ' +'group by PQA.ProductID';
    with getNewDataset(strSQl , true) do try
        Filter :=' (InstockQty <> 0) OR  (SOQty <> 0)  OR (AllocatedBOQty <> 0)  OR (POBOQty <> 0) OR (SOBOQty <> 0)';
        Filtered :=  True;
        result := Recordcount>0;
    finally
        if Active then Close;
        Free;
    end;
end;

function TProdAttribGroups.ChangeActiveofAllProducts: Boolean;
var
  strSQL:String;
begin
    result := True;
    strSQL:= 'PartsId in (Select ProductId  from tblproductattributeproducts PAP ' +
            ' where PAG_ID = ' + InttoStr(ID)+')';
      if AttribProducts.count = 0 then Exit;
      AllLinesValid := True;
      AttribProducts.IterateRecords(LockParts);
      if not(AllLinesValid) then begin
           REsult := FAlse;
           Exit;
      end;
      AttribProducts.DoFieldChange := False;
      AttribProducts.IterateRecords(ChangeActiveofAllProductsCallback);
      REsult := True;
end;
function TProdAttribGroups.LockProduct(fTablename: String;  const fProductID: Integer; Const fProductname:STring;const fLockgroupname: String): Boolean;
var
  ErrMsg:String;
begin
  result := True;
  if not(UserLock.Lock(fTablename,fProductID, fLockgroupname)) then begin
      ErrMsg := UserLock.LockMessage;
      ErrMsg := StringReplace(ErrMsg, 'Unable to update data.', 'This Group/Product Can''t be made inactive.', [rfIgnoreCase]);
      ErrMsg := StringReplace(ErrMsg, 'this record', fProductname+ ' of this group ', [rfIgnoreCase]);
      Resultstatus.AddItem(False, rssWarning , 0 ,ErrMsg , true);
      REsult := False;
   end;
end;
procedure TProdAttribGroups.LockParts(const Sender: Tbusobj;var Abort: Boolean);
begin
  StepProgress;
   if (Sender is TAttributeproduct) then begin
    if not (LockProduct(TAttributeproduct(Sender).GetBusObjectTablename,TAttributeproduct(Sender).ID,TAttributeproduct(Sender).ProductName, LockMsgDelPriceMtxProduct)) then begin
      abort:= True;
      AllLinesValid := False;
    end;
   end else if Sender is TProductAttributes then
    if not (LockProduct(TProduct.GetBusObjectTablename,TProductAttributes(Sender).ProductID,TProductAttributes(Sender).ProductName, LockMsgDelPriceMtxProduct)) then begin
      abort:= True;
      AllLinesValid := False;
   end;
end;

procedure TProdAttribGroups.ChangeActiveofAllProductsCallback( const Sender: Tbusobj; var Abort: Boolean);
begin
  if not(Sender is TAttributeproduct) then Exit;
  TAttributeproduct(Sender).Active := Self.Active;
  TAttributeproduct(Sender).PostDB;
end;

function TProdAttribGroups.Lock: boolean;
begin
  REsult := inherited Lock;
  if not result then exit;
  //result := AttributeProducts.count = 0 ;
end;

function TProdAttribGroups.getAttributeProducts: TProductAttributes;
begin
  REsult := TProductAttributes(getContainerComponent(TProductAttributes , 'PAG_ID= '+ IntToStr(ID) ));
end;

function TProdAttribGroups.checkExistingProducts: Boolean;
var
  strSQL:String;
begin
  strSQL := 'select * from tblproductattributeproducts where PAG_ID = ' + intToStr(ID);
  with getNewDataset(strSQL, False) do try
    REsult := Recordcount > 0;
  finally
      if active then close;
      Free;
  end;
end;

function TProdAttribGroups.ExportsubClasses(const node: IXMLNode): Boolean;
begin
    self.AttributeNames.XMLPropertyNode := node.AddChild(AttributeNames.XMLBranchname);
    self.AttributeNames.XMLPropertyName:= 'Names';
    self.AttributeNames.IterateRecords(GetPropertyXMLCallback);
    Result := true;
end;

function TProdAttribGroups.getAttributeName: TProdAtribName;
begin
  REsult := TProdAtribName(getContainerComponent(TProdAtribName , 'PAG_ID= '+ IntToStr(ID) ));
end;

function TProdAttribGroups.ImportsubClasses(const node: IXMLNode): Boolean;
var
  x:Integer;
  Singlerec :IXMLNode;
begin
    Result := False;
    ImportFailed := False;
    ImportFailed := False;
    XMLPropertyName :='AttributeNames';
    XMLPropertyNode := node.ChildNodes.FindNode(XMLPropertyName);
    if Assigned(XMLPropertyNode) then begin
        for x := 0 to XMLPropertyNode.ChildNodes.Count - 1 do begin
            AttributeNames.ImportingFromXMLFile := True;
            Singlerec:= XMLPropertyNode.ChildNodes[x];
            AttributeNames.ImportFromXML(SingleRec);
            ImportFailed :=AttributeNames.ImportFailed;
            if Error then Exit;
        end;
    end;
end;

procedure TProdAttribGroups.ClonePropertyObjects;
begin
  AttributeNames.IterateRecords(CloneLines);
end;

procedure TProdAttribGroups.CloneLines(const Sender: TBusObj;var Abort: boolean);
begin
   Sender.CloneBusObj(IDFieldNAme , ObjInstanceToClone.ID, False);
end;

function TProdAttribGroups.getGroupNAmeForthecopy: STring;
var
  strSQL:String;
begin
  REsult := 'copy of '  ;
  While true do begin
    strSQL:= ' select * from ' + GetBusObjectTablename +' where name = ' +quotedStr(result +Groupname);
    with getNEwdataset(StrSQL, true) do try
      if recordcount = 0 then begin
        result := result +Groupname;
        Break;
      end else begin
          REsult := result + ' ';
      end;
    finally
        if active then close;
        Free;
    end;
  end;
end;




function TProdAttribGroups.getParttype: String;
begin
  REsult := GetStringField('PartType');
end;

procedure TProdAttribGroups.SetParttype(const Value: String);
begin
    SetStringfield('Parttype' , Value);
end;

function TProdAttribGroups.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited   DoAfterInsert(SendeR);
  if not result then exit;
  PartType := 'INV';
end;

function TProdAttribGroups.getProdDesc: String;
begin
  REsult := GetStringField('ProdDesc');
end;

procedure TProdAttribGroups.setProdDesc(const Value: String);
begin
    SetStringfield('ProdDesc' , Value);
end;


function TProdAttribGroups.getCleanProdDesc: String;
begin
     result:= GetXMLNodeStringValue(CleanXMLNode, 'ProdDesc');
end;

function TProdAttribGroups.ChangePrrodDescofAllProducts: Boolean;
begin
  Result := True;
  if AttribProducts.count = 0 then exit;

  AllLinesValid := True;
  EnableProgressbar(true,2);
  try
    AttribProducts.IterateRecords(LockParts);
    if not(AllLinesValid) then begin
      REsult := FAlse;
      Exit;
    end;
  finally
    EnableProgressbar(False,2);
  end;
  EnableProgressbar(true,AttribProducts.count);
  try
    AttribProducts.IterateRecords(ChangePrrodDescofAllProductsCallback);
  finally
       EnableProgressbar(False,0);
  end;
end;

procedure TProdAttribGroups.ChangePrrodDescofAllProductsCallback(
  const Sender: Tbusobj; var Abort: Boolean);
begin
  StepProgress;
  if not (Sender is TAttributeproduct) then exit;
  TAttributeproduct(Sender).PurchaseDescription := TAttributeproduct(Sender).ProdDesc;
  TAttributeproduct(Sender).SalesDescription:=TAttributeproduct(Sender).ProdDesc ;
  TAttributeproduct(Sender).PostDB;
end;

function TProdAttribGroups.getAttributeproduct: TAttributeproduct;
begin
  REsult :=  TAttributeproduct(getContainerComponent(TAttributeproduct , 'tblproductattributeproducts.PAG_ID = ' +intToStr(ID)));
end;

procedure TProdAttribGroups.EnableProgressbar(visible: Boolean;
  Max: Integer);
begin
  if not Assigned(fProgressbar) then exit;
  if visible then begin
    if max<1 then exit;
    fProgressbar.Min := 1;
    fProgressbar.Max := Max;
    fProgressbar.Position := 1;
    fProgressbar.step:= 1;
    fProgressbar.visible := true;
  end else fProgressbar.visible := False;
end;

procedure TProdAttribGroups.StepProgress;
begin
  if not Assigned(fProgressbar) then exit;
  fProgressbar.StepIt;
end;

{ TAttributeproduct }

procedure TAttributeproduct.callbackProdDesc(const Sender: TBusObj;
  var Abort: boolean);
begin
  if not(Sender is TProductAttributes) then exit;
  if fsDesc <> '(' then fsDesc := fsDEsc + ', ';
  fsDesc := fsDEsc +TProductAttributes(Sender).AttribName +':' + TProductAttributes(sender).attribValue;
end;

constructor TAttributeproduct.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'Attribute Products';
  fSQL := 'SELECT tblparts.*  '+
          ' FROM  tblproductattributeproducts '+
          ' Inner Join tblparts  ON tblproductattributeproducts.ProductID = tblparts.PARTSID';
end;

destructor TAttributeproduct.Destroy;
begin
  inherited;
end;

function TAttributeproduct.getProdDesc: STring;
begin
  Result := '';
  if Assigned(Self.Owner) then
    if Self.Owner is TProdAttribGroups then
      REsult := TProdAttribGroups(Self.Owner).ProdDesc;
  fsDesc := '(';
  ProductAttributes.IterateRecords(callbackProdDesc);
  if fsDesc <> '(' then fsDesc := fsDesc +')' else fsDesc := '';
  result := result + ' ' +fsDesc;
end;

function TAttributeproduct.getProductAttributes: TProductAttributes;
begin
  REsult := TProductAttributes(getContainerComponent(TProductAttributes , 'ProductID= '+ IntToStr(ID) ));
end;

{ TProductAttributeGroupHelper }

function TProductAttributeGroupHelper.APIListDefaultProperties: string;
begin
  result:= 'GroupName,GroupId,ProductName,ProductId';
end;

constructor TProductAttributeGroupHelper.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'Product Attribute Group Helper';
  fSQL :=
    'select distinct ' + //0 as ID, ' +
    'PAG_ID as GroupID, ' +
    'GroupName as GroupName, ' +
    'ProductID as ProductID, ' +
    'ProductName as ProductName ' +
    'from tblproductattributeproducts';

end;

destructor TProductAttributeGroupHelper.Destroy;
begin

  inherited;
end;

class function TProductAttributeGroupHelper.GetBusObjectTablename: string;
begin
  result := 'tblproductattributeproducts';
end;

function TProductAttributeGroupHelper.GetGlobalRef: string;
begin
  result := '';
end;

function TProductAttributeGroupHelper.GetGroupId: integer;
begin
  result := GetIntegerField('GroupID');
end;

function TProductAttributeGroupHelper.GetGroupName: string;
begin
  result := GetStringField('GroupName');
end;

function TProductAttributeGroupHelper.GetId: integer;
begin
  result := 0;
end;

class function TProductAttributeGroupHelper.GetIDField: string;
begin
  result := 'ID';
end;

function TProductAttributeGroupHelper.GetMsTimeStamp: TDateTime;
begin
  result := 0;
end;

function TProductAttributeGroupHelper.GetMsUpdateSiteCode: string;
begin
  result := '';
end;

function TProductAttributeGroupHelper.GetProductID: integer;
begin
  result := GetIntegerField('ProductID');
end;

function TProductAttributeGroupHelper.GetProductName: string;
begin
  result := GetStringField('ProductName');
end;

initialization
  RegisterClassOnce(TProdAtribValue);
  RegisterClassOnce(TProdAtribName);
  RegisterClassOnce(TProdAttribGroups);
  RegisterClass(TProductAttributeGroupHelper);
end.





