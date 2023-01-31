unit BusobjProductFormula;
{ Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  11/08/06  1.00.00 BJ  Initial version. }

interface

uses busobjBase, Classes, XMLIntf, db;

type
  TFeFormulaTypes = class;
  TFeFormulaRelatedProducts = class;

  TFormulaEntry = class(TMSBusObj)
  private
    fiLastNo: Integer;
    fiLastOrderNo: Integer;
    function getFormulaEntryNo: Integer;
    function getFieldOrderno: Integer;
    function getformulaEntryName: string;
    function getActive: Boolean;
    function getIsQtyfield: Boolean;
    procedure SetFormulaEntryNo(const Value: Integer);
    procedure SetFieldOrderno(const Value: Integer);
    procedure SetformulaEntryName(const Value: string);
    procedure SetActive(const Value: Boolean);
    procedure SetIsQtyfield(const Value: Boolean);
    procedure findlastNo(const Sender: TBusObj; var Abort: Boolean);
    procedure TurnoffIsQtyfield(const Sender: TBusObj; var Abort: Boolean);
  protected
    function GetSQL: string; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforeInsert(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
    procedure DoFieldOnChange(Sender: TField); override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    class function GetKeyStringField: string; override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    class function GetKeyStringProperty: string; override;
    constructor Create(AOwner: TComponent); override;
  published
    property FormulaEntryNo: Integer read getFormulaEntryNo write SetFormulaEntryNo;
    property FieldOrderno: Integer read getFieldOrderno write SetFieldOrderno;
    property formulaEntryName: string read getformulaEntryName write SetformulaEntryName;
    property FormulaEntryActive: Boolean read getActive write SetActive;
    property IsQtyfield: Boolean read getIsQtyfield write SetIsQtyfield;
  end;

  TFormula = class(TMSBusObj)
  private
    function getFormulaName: string;
    function getformula: string;
    function getActive: Boolean;
    function getFormulaType: string;
    Function getFormulaTypeID:Integer;
    function getComments: string;
    Function getHasFe1DefaultValue :Boolean;
    Function getHasFe2DefaultValue :Boolean;
    Function getHasFe3DefaultValue :Boolean;
    Function getHasFe4DefaultValue :Boolean;
    Function getHasFe5DefaultValue :Boolean;
    Function GetFe1DefaultValue : double;
    Function GetFe2DefaultValue : double;
    Function GetFe3DefaultValue : double;
    Function GetFe4DefaultValue : double;
    Function GetFe5DefaultValue : double;

    procedure SetFormulaName(const Value: string);
    procedure Setformula(const Value: string);
    procedure SetActive(const Value: Boolean);
    procedure DoGetParserVariable(Sender: TObject; const VarName: string; var Value: extended; var FieldFound: Boolean);
    procedure SetFormulaType(const Value: string);
    Procedure SetFormulaTypeID(const Value :Integer);
    procedure SetComments(const Value: string);
    Procedure SetHasFe1DefaultValue(const Value:Boolean);
    Procedure SetHasFe2DefaultValue(const Value:Boolean);
    Procedure SetHasFe3DefaultValue(const Value:Boolean);
    Procedure SetHasFe4DefaultValue(const Value:Boolean);
    Procedure SetHasFe5DefaultValue(const Value:Boolean);
    Procedure SetFe1DefaultValue(const Value : double);
    Procedure SetFe2DefaultValue(const Value : double);
    Procedure SetFe3DefaultValue(const Value : double);
    Procedure SetFe4DefaultValue(const Value : double);
    Procedure SetFe5DefaultValue(const Value : double);
    function getFeFormulaType: TFeFormulaTypes;
    function getFormulaRelatedProducts: TFeFormulaRelatedProducts;

  protected
    function GetSQL: string; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    procedure DoFieldOnChange(Sender: TField); override;
  public
    class function GetIDField: string; override;
    class function GetKeyStringField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    class function GetKeyStringProperty: string; override;
    Property FeFormulaType : TFeFormulaTypes read getFeFormulaType;
    function LockInUse :Boolean ; override;
    Property FormulaRelatedProducts : TFeFormulaRelatedProducts read getFormulaRelatedProducts;
  published
    property FormulaName: string read getFormulaName write SetFormulaName;
    property Formula: string read getformula write Setformula;
    property FormulaActive: Boolean read getActive write SetActive;
    property FormulaType: string read getFormulaType write SetFormulaType;
    Property FormulaTypeId :Integer read getFormulaTypeId Write setFormulaTypeID;
    property Comments: string read getComments write SetComments;
    Property HasFe1DefaultValue :Boolean read getHasFe1DefaultValue write SetHasFe1DefaultValue;
    Property HasFe2DefaultValue :Boolean read getHasFe2DefaultValue write SetHasFe2DefaultValue;
    Property HasFe3DefaultValue :Boolean read getHasFe3DefaultValue write SetHasFe3DefaultValue;
    Property HasFe4DefaultValue :Boolean read getHasFe4DefaultValue write SetHasFe4DefaultValue;
    Property HasFe5DefaultValue :Boolean read getHasFe5DefaultValue write SetHasFe5DefaultValue;
    Property Fe1DefaultValue : Double read getFe1DefaultValue write setFe1DefaultValue;
    Property Fe2DefaultValue : Double read getFe2DefaultValue write setFe2DefaultValue;
    Property Fe3DefaultValue : Double read getFe3DefaultValue write setFe3DefaultValue;
    Property Fe4DefaultValue : Double read getFe4DefaultValue write setFe4DefaultValue;
    Property Fe5DefaultValue : Double read getFe5DefaultValue write setFe5DefaultValue;
  end;
  TFeFormulaTypes = class(TMSBusObj)
  private
    function GetFormulaType         : string    ;
    function GetFe1visible          : Boolean   ;
    function GetFe2visible          : Boolean   ;
    function GetFe3visible          : Boolean   ;
    function GetFe4visible          : Boolean   ;
    function GetFe5visible          : Boolean   ;
    function GetActive              : Boolean   ;
    procedure SetFormulaType         (const Value: string    );
    procedure SetFe1visible          (const Value: Boolean   );
    procedure SetFe2visible          (const Value: Boolean   );
    procedure SetFe3visible          (const Value: Boolean   );
    procedure SetFe4visible          (const Value: Boolean   );
    procedure SetFe5visible          (const Value: Boolean   );
    procedure SetActive              (const Value: Boolean   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;

  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property FormulaType          :string      read GetFormulaType        write SetFormulaType     ;
    property Fe1visible           :Boolean     read GetFe1visible         write SetFe1visible      ;
    property Fe2visible           :Boolean     read GetFe2visible         write SetFe2visible      ;
    property Fe3visible           :Boolean     read GetFe3visible         write SetFe3visible      ;
    property Fe4visible           :Boolean     read GetFe4visible         write SetFe4visible      ;
    property Fe5visible           :Boolean     read GetFe5visible         write SetFe5visible      ;
    property Active               :Boolean     read GetActive             write SetActive          ;
  end;
  TFeformulaNameorder = class(TMSBusObj)
  private
    function GetFormulaID           : Integer   ;
    function GetFeNameID            : Integer   ;
    function GetFieldOrderno        : Integer   ;
    procedure SetFormulaID           (const Value: Integer   );
    procedure SetFeNameID            (const Value: Integer   );
    procedure SetFieldOrderno        (const Value: Integer   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property FormulaID            :Integer     read GetFormulaID          write SetFormulaID       ;
    property FeNameID             :Integer     read GetFeNameID           write SetFeNameID        ;
    property FieldOrderno         :Integer     read GetFieldOrderno       write SetFieldOrderno    ;
  end;
  TFieldFormulaEntry = class(TFormulaEntry)
     {class designed for TfmProductFormulaEntryOrder
     Its a readonly object
     form runs update sttaement to change order}
     Private
    function getobjSQL: String;
     public
      constructor  Create(AOwner: TComponent);                            override;
      class function GetIDField: string; override;
      class function GetBusObjectTablename: string; override;
      Property objSQL:String read getobjSQL;
  end;
  TFeFormulaRelatedProducts = class(TMSBusObj)
  private
    function GetFormulaID           : Integer   ;
    function GetProductID           : Integer   ;
    function GetProductName         : string    ;
    function GetProductQty          : Double    ;
    procedure SetFormulaID           (const Value: Integer   );
    procedure SetProductID           (const Value: Integer   );
    procedure SetProductName         (const Value: string    );
    procedure SetProductQty          (const Value: Double    );
    function getActive: Boolean;
    procedure SetActive(const Value: Boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property FormulaID            :Integer     read GetFormulaID          write SetFormulaID       ;
    property ProductID            :Integer     read GetProductID          write SetProductID       ;
    property ProductName          :string      read GetProductName        write SetProductName     ;
    property ProductQty           :Double      read GetProductQty         write SetProductQty      ;
    Property Active               :Boolean     read getActive             Write SetActive;
  end;

implementation

uses ParserObj, Sysutils, CommonLib, BusobjSaleBase, BusObjFeTransLines,
  AppEnvironment, BusObjConst;

{ TFormulaEntry }
function TFormulaEntry.GetSQL: string;
begin
  REsult := inherited GetSQL;
end;

class function TFormulaEntry.GetIDField: string;
begin
  REsult := 'FormulaEntryID';
end;

class function TFormulaEntry.GetKeyStringField: string;
begin
  result:= 'FormulaEntryName';
end;

class function TFormulaEntry.GetKeyStringProperty: string;
begin
  result:= 'FormulaEntryName';
end;

class function TFormulaEntry.GetBusObjectTablename: string;
begin
  REsult := 'tblFENames';
end;

function TFormulaEntry.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  REsult := False;
  if not ValidateData then begin
    Abort;
    Exit;
  end;
  REsult := True;
end;

procedure TFormulaEntry.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
      if DoFieldChangewhenDisabled = False then Exit; // we are only interested in data fields.
      inherited;
      if Sysutils.SameText(Sender.FieldName, 'IsQtyfield') then begin
        if IsQtyfield then begin
          PostDb;
          Iteraterecords(TurnoffIsQtyfield);
          IsQtyfield := TRue;
          PostDB;
        end;
      end else if Sysutils.SameText(Sender.FieldName, 'formulaTypeId') then begin
        SendEvent(BusObjEvent_Change , BusObjEventVal_FormulaType, self);
      end;

end;
procedure TFormulaEntry.TurnoffIsQtyfield(const Sender: TBusObj;  var Abort: Boolean);
begin
  IsQtyfield := False;
  PostDB;
end;
function TFormulaEntry.DoBeforeInsert(Sender: TDatasetBusObj): Boolean;
var
  fiFiedcount: Integer;
begin
  with TFESalesLines.Create(Self) do
    try fiFiedcount := FieldEntrycount;
    finally Free;
    end;
  if fiFiedcount <= Count then begin
    REsult := False;
    Abort;
    Exit;
  end;
  fiLastNo := 0;
  fiLastOrderNo := 0;
  postDB;
  IterateREcords(findlastNo);
  REsult := True;
end;

constructor TFormulaEntry.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'Select * from tblFENames';
end;

function TFormulaEntry.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  FormulaEntryNo := fiLastNo + 1;
  FieldOrderno := fiLastOrderNo + 1;
  FormulaEntryActive := True;
  REsult := True;
end;

function TFormulaEntry.getFormulaEntryNo: Integer;
begin
  REsult := getIntegerField('FormulaEntryNo');
end;
function TFormulaEntry.getFieldOrderno: Integer;
begin
  REsult := getIntegerField('FieldOrderno');
end;

function TFormulaEntry.getformulaEntryName: string;
begin
  REsult := getStringField('formulaEntryName');
end;

function TFormula.getFormulaType: string;
begin
  REsult := getStringField('FormulaType');
end;
function TFormula.getFormulaTypeID: Integer;
begin
  REsult := getIntegerField('FormulaTypeID');
end;
function TFormula.getComments: string;
begin
  REsult := getStringField('Comments');
end;

function TFormulaEntry.getActive: Boolean;
begin
  REsult := getBooleanField('Active');
end;
function TFormulaEntry.getIsQtyfield: Boolean;
begin
  REsult := getBooleanField('IsQtyfield');
end;

procedure TFormulaEntry.SetFormulaEntryNo(const Value: Integer);
begin
  SetIntegerField('FormulaEntryNo', Value);
end;
procedure TFormulaEntry.SetFieldOrderno(const Value: Integer);
begin
  SetIntegerField('FieldOrderno', Value);
end;

procedure TFormulaEntry.SetformulaEntryName(const Value: string);
begin
  SetStringField('formulaEntryName', Value);
end;
procedure TFormula.SetFormulaType(const Value: string);
begin
  SetStringField('FormulaType', Value);
end;
procedure TFormula.SetFormulaTypeID(const Value: Integer);
begin
  SetIntegerField('FormulaTypeID', Value);
end;
procedure TFormula.SetComments(const Value: string);
begin
  SetStringField('Comments', Value);
end;

procedure TFormulaEntry.SetActive(const Value: Boolean);
begin
  SetBooleanfield('Active', Value);
end;
procedure TFormulaEntry.SetIsQtyfield(const Value: Boolean);
begin
  SetBooleanfield('IsQtyfield', Value);
end;

procedure TFormulaEntry.findlastNo(const Sender: TBusObj; var Abort: Boolean);
begin
  if fiLastNo < FormulaEntryNo then fiLastNo := FormulaEntryNo;
  if fiLastOrderNo < FieldOrderno then fiLastOrderNo := FieldOrderno;
end;

function TFormulaEntry.ValidateData: Boolean;
begin
  REsult := False;

  if formulaEntryName = '' then begin
    ResultStatus.AddItem(False, rssWarning, 0, 'Formula Entry name should not be blank');
    Exit;
  end;
  if FormulaEntryNo = 0 then begin
    ResultStatus.AddItem(False, rssWarning, 0, 'Formula Entry No should not be blank');
    Exit;
  end;
  if FieldOrderno = 0 then begin
    ResultStatus.AddItem(False, rssWarning, 0, 'Formula Order No should not be blank');
    Exit;
  end;
  if not Self.IsUnique(ID, 'formulaentryName = ' + QuotedStr(formulaEntryName), Connection.Connection) then begin
    ResultStatus.AddItem(False, rssWarning, 0, 'Formula Entry ''' + formulaEntryName + ''' already Exists');
    Exit;
  end;
  REsult := True;
end;

function TFormulaEntry.Save: Boolean;
begin
  REsult := False;
  postDB;
  if Dataset.Recordcount = 0 then begin
    REsult := True;
    Exit;
  end;
  if not ValidateData then Exit;
  SendEvent(BusobjEvent_ToDo , BusObjEventVal_OnAfterSave, self);
  Self.Dirty := False;
  REsult := True;
end;

{ TFormula }
function TFormula.GetSQL: string;
begin
  REsult := inherited GetSQL;
end;

function TFormula.LockInUse: Boolean;
begin
  REsult := inherited LockInUse;
  if not result then exit;
end;

class function TFormula.GetIDField: string;
begin
  REsult := 'FormulaID';
end;

class function TFormula.GetKeyStringField: string;
begin
  REsult := 'FormulaName';
end;

class function TFormula.GetKeyStringProperty: string;
begin
  REsult := 'FormulaName';
end;

class function TFormula.GetBusObjectTablename: string;
begin
  REsult := 'tblFEFormula';
end;

function TFormula.getFormulaName: string;
begin
  REsult := getStringField('FormulaName');
end;

function TFormula.getFormulaRelatedProducts: TFeFormulaRelatedProducts;
begin
  Result := TFeFormulaRelatedProducts(getContainercomponent(TFeFormulaRelatedProducts, 'FormulaID = ' + inttostr(ID)));
end;

function TFormula.getFeFormulaType: TFeFormulaTypes;
begin
  Result := TFeFormulaTypes(getContainercomponent(TFeFormulaTypes, 'FormulaTypeId = ' + inttostr(FormulaTypeId)));
end;

function TFormula.getformula: string;
begin
  REsult := getStringField('formula');
end;

function TFormula.getActive: Boolean;
begin
  REsult := getBooleanField('Active');
end;
function TFormula.getHasFe1DefaultValue: Boolean;begin  REsult := getBooleanField('HasFe1DefaultValue');end;
function TFormula.getHasFe2DefaultValue: Boolean;begin  REsult := getBooleanField('HasFe2DefaultValue');end;
function TFormula.getHasFe3DefaultValue: Boolean;begin  REsult := getBooleanField('HasFe3DefaultValue');end;
function TFormula.getHasFe4DefaultValue: Boolean;begin  REsult := getBooleanField('HasFe4DefaultValue');end;
function TFormula.getHasFe5DefaultValue: Boolean;begin  REsult := getBooleanField('HasFe5DefaultValue');end;
Function TFormula.getFe1DefaultValue:Double; begin REsult := getFloatfield('Fe1DefaultValue');end;
Function TFormula.getFe2DefaultValue:Double; begin REsult := getFloatfield('Fe2DefaultValue');end;
Function TFormula.getFe3DefaultValue:Double; begin REsult := getFloatfield('Fe3DefaultValue');end;
Function TFormula.getFe4DefaultValue:Double; begin REsult := getFloatfield('Fe4DefaultValue');end;
Function TFormula.getFe5DefaultValue:Double; begin REsult := getFloatfield('Fe5DefaultValue');end;

procedure TFormula.SetFormulaName(const Value: string);
begin
  SetStringField('FormulaName', Value);
end;

procedure TFormula.Setformula(const Value: string);
begin
  SetStringField('formula', Value);
end;

procedure TFormula.SetActive(const Value: Boolean);
begin
  SetBooleanfield('Active', Value);
end;
procedure TFormula.SetHasFe1DefaultValue(const Value: Boolean);begin  SetBooleanfield('HasFe1DefaultValue', Value);end;
procedure TFormula.SetHasFe2DefaultValue(const Value: Boolean);begin  SetBooleanfield('HasFe2DefaultValue', Value);end;
procedure TFormula.SetHasFe3DefaultValue(const Value: Boolean);begin  SetBooleanfield('HasFe3DefaultValue', Value);end;
procedure TFormula.SetHasFe4DefaultValue(const Value: Boolean);begin  SetBooleanfield('HasFe4DefaultValue', Value);end;
procedure TFormula.SetHasFe5DefaultValue(const Value: Boolean);begin  SetBooleanfield('HasFe5DefaultValue', Value);end;
procedure TFormula.SetFe1DefaultValue(Const Value :Double); begin SetFloatfield('Fe1DefaultValue', Value);end;
procedure TFormula.SetFe2DefaultValue(Const Value :Double); begin SetFloatfield('Fe2DefaultValue', Value);end;
procedure TFormula.SetFe3DefaultValue(Const Value :Double); begin SetFloatfield('Fe3DefaultValue', Value);end;
procedure TFormula.SetFe4DefaultValue(Const Value :Double); begin SetFloatfield('Fe4DefaultValue', Value);end;
procedure TFormula.SetFe5DefaultValue(Const Value :Double); begin SetFloatfield('Fe5DefaultValue', Value);end;

function TFormula.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  FormulaActive := True;
  REsult := True;
end;

procedure TFormula.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
      if DoFieldChangewhenDisabled = False then Exit; // we are only interested in data fields.
    inherited;
    if Sysutils.SameText(Sender.FieldName, 'formulaTypeId') then begin
        SendEvent(BusObjEvent_Change , BusObjEventVal_FormulaType, self);
    end;

end;

constructor TFormula.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'Select * from tblFEFormula';
end;

procedure TFormula.DoGetParserVariable(Sender: TObject; const VarName: string; var Value: extended; var FieldFound: Boolean);
var
  ds1: TDataset;
  tmpVarName: string;
  strSQL: string;
begin
  tmpVarName := ReplaceStr(VarName, 'Field', '');
  if not isnumeric(tmpVarName) then begin
    FieldFound := False;
    Exit;
  end;
  strSQL := 'Select FormulaEntryID from tblFENames where FormulaEntryNo = ' + tmpVarName;
  ds1 := getNewDataset(strSQL, True);
  try FieldFound := ds1.Recordcount = 1;
  finally
    ds1.close;
    freeandNil(ds1);
  end;
end;

function TFormula.ValidateData: Boolean;
var
  Parser: TMathParser;
begin
  Result := False;
  postDB;
  if Formula = '' then begin
    ResultStatus.AddItem(False, rssWarning, 0, 'Formula should not be blank');
    Exit;
  end;
  if FormulaName = '' then begin
    ResultStatus.AddItem(False, rssWarning, 0, 'Formula name should not be blank');
    Exit;
  end;
  if not Self.IsUnique(ID, 'formulaname = ' + QuotedStr(FormulaName), Connection.Connection) then begin
    ResultStatus.AddItem(False, rssWarning, 0, 'Formula ''' + FormulaName + ''' already Exists');
    Exit;
  end;
  Parser := TMathParser.Create(Self);
  try
    Parser.OnGetVar := DoGetParserVariable;
    Parser.ParseString := Formula;
    Parser.Parse;
    if Parser.ParseError then begin
      ResultStatus.AddItem(False, rssWarning, 0, Parser.ErrorMessage);
      Exit;
    end;
  finally
    freeandNil(Parser);
  end;
  REsult :=   FormulaRelatedProducts.ValidateDataList
end;

function TFormula.Save: Boolean;
begin
  REsult := False;
  postDB;
  if Dataset.Recordcount = 0 then begin
    REsult := True;
    Exit;
  end;
  FormulaRelatedProducts.PostDb;
  if not ValidateData then Exit;
  Self.Dirty := False;
  REsult := True;
end;

  {TFeFormulaTypes}

constructor TFeFormulaTypes.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Formula Types';
  fSQL := 'SELECT * FROM tblfeformulatypes';
end;


destructor TFeFormulaTypes.Destroy;
begin
  inherited;
end;


procedure TFeFormulaTypes.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'FormulaType');
  SetBooleanPropertyFromNode(node,'Fe1visible');
  SetBooleanPropertyFromNode(node,'Fe2visible');
  SetBooleanPropertyFromNode(node,'Fe3visible');
  SetBooleanPropertyFromNode(node,'Fe4visible');
  SetBooleanPropertyFromNode(node,'Fe5visible');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure TFeFormulaTypes.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'FormulaType' ,FormulaType);
  AddXMLNode(node,'Fe1visible' ,Fe1visible);
  AddXMLNode(node,'Fe2visible' ,Fe2visible);
  AddXMLNode(node,'Fe3visible' ,Fe3visible);
  AddXMLNode(node,'Fe4visible' ,Fe4visible);
  AddXMLNode(node,'Fe5visible' ,Fe5visible);
  AddXMLNode(node,'Active' ,Active);
end;


function TFeFormulaTypes.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TFeFormulaTypes.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TFeFormulaTypes.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TFeFormulaTypes.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TFeFormulaTypes.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TFeFormulaTypes.GetIDField: string;
begin
  Result := 'FormulaTypeId'
end;


class function TFeFormulaTypes.GetBusObjectTablename: string;
begin
  Result:= 'tblfeformulatypes';
end;


function TFeFormulaTypes.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
    Fe1visible           := AppEnv.CompanyPrefs.Fe1Visible;
    Fe2visible           := AppEnv.CompanyPrefs.Fe2Visible;
    Fe3visible           := AppEnv.CompanyPrefs.Fe3Visible;
    Fe4visible           := AppEnv.CompanyPrefs.Fe4Visible;
    Fe5visible           := AppEnv.CompanyPrefs.Fe5Visible;
end;

function TFeFormulaTypes.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TFeFormulaTypes.GetFormulaType     : string    ; begin Result := GetStringField('FormulaType');end;
function  TFeFormulaTypes.GetFe1visible      : Boolean   ; begin Result := GetBooleanField('Fe1visible');end;
function  TFeFormulaTypes.GetFe2visible      : Boolean   ; begin Result := GetBooleanField('Fe2visible');end;
function  TFeFormulaTypes.GetFe3visible      : Boolean   ; begin Result := GetBooleanField('Fe3visible');end;
function  TFeFormulaTypes.GetFe4visible      : Boolean   ; begin Result := GetBooleanField('Fe4visible');end;
function  TFeFormulaTypes.GetFe5visible      : Boolean   ; begin Result := GetBooleanField('Fe5visible');end;
function  TFeFormulaTypes.GetActive          : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TFeFormulaTypes.SetFormulaType     (const Value: string    ); begin SetStringField('FormulaType'      , Value);end;
procedure TFeFormulaTypes.SetFe1visible      (const Value: Boolean   ); begin SetBooleanField('Fe1visible'       , Value);end;
procedure TFeFormulaTypes.SetFe2visible      (const Value: Boolean   ); begin SetBooleanField('Fe2visible'       , Value);end;
procedure TFeFormulaTypes.SetFe3visible      (const Value: Boolean   ); begin SetBooleanField('Fe3visible'       , Value);end;
procedure TFeFormulaTypes.SetFe4visible      (const Value: Boolean   ); begin SetBooleanField('Fe4visible'       , Value);end;
procedure TFeFormulaTypes.SetFe5visible      (const Value: Boolean   ); begin SetBooleanField('Fe5visible'       , Value);end;
procedure TFeFormulaTypes.SetActive          (const Value: Boolean   ); begin SetBooleanField('Active'           , Value);end;


  {TFeformulaNameorder}

constructor TFeformulaNameorder.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Formula Name Order';
  fSQL := 'SELECT * FROM tblfeformulaNameorder';
end;


destructor TFeformulaNameorder.Destroy;
begin
  inherited;
end;


procedure TFeformulaNameorder.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'FormulaID');
  SetPropertyFromNode(node,'FeNameID');
  SetPropertyFromNode(node,'FieldOrderno');
end;


procedure TFeformulaNameorder.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'FormulaID' ,FormulaID);
  AddXMLNode(node,'FeNameID' ,FeNameID);
  AddXMLNode(node,'FieldOrderno' ,FieldOrderno);
end;


function TFeformulaNameorder.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TFeformulaNameorder.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TFeformulaNameorder.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TFeformulaNameorder.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TFeformulaNameorder.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TFeformulaNameorder.GetIDField: string;
begin
  Result := 'ID'
end;


class function TFeformulaNameorder.GetBusObjectTablename: string;
begin
  Result:= 'tblfeformulaNameorder';
end;


function TFeformulaNameorder.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TFeformulaNameorder.GetFormulaID       : Integer   ; begin Result := GetIntegerField('FormulaID');end;
function  TFeformulaNameorder.GetFeNameID        : Integer   ; begin Result := GetIntegerField('FeNameID');end;
function  TFeformulaNameorder.GetFieldOrderno    : Integer   ; begin Result := GetIntegerField('FieldOrderno');end;
procedure TFeformulaNameorder.SetFormulaID       (const Value: Integer   ); begin SetIntegerField('FormulaID'        , Value);end;
procedure TFeformulaNameorder.SetFeNameID        (const Value: Integer   ); begin SetIntegerField('FeNameID'          , Value);end;
procedure TFeformulaNameorder.SetFieldOrderno    (const Value: Integer   ); begin SetIntegerField('FieldOrderno'     , Value);end;


{ TFieldFormulaEntry }

constructor TFieldFormulaEntry.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  isreadonly := True;
  //fSQL := 'Select FEO.ID as ID,  FE.* , ifnull(FEO.FieldOrderno , FE.FieldOrderno) as FieldOrderno from tblFENames FE Left join tblfeformulaNameorder FEO on FE.formulaentryId = FEO.FeNameID';
  fSQL := objSQL;
  fSQLOrder := 'ActualFieldOrderno';
end;

class function TFieldFormulaEntry.GetBusObjectTablename: string;
begin
  REsult := 'tblfeformulaNameorder';
end;

class function TFieldFormulaEntry.GetIDField: string;
begin
  REsult :='ID';
end;

function TFieldFormulaEntry.getobjSQL: String;
begin
  Result := 'Select FEO.ID as ID,  FE.* , '+
            //'       ifnull(FEO.FieldOrderno , FE.FieldOrderno) as ActualFieldOrderno '+
            ' convert(ifnull(FEO.FieldOrderno , FE.FieldOrderno), unsigned) as ActualFieldOrderno '+
            ' from tblFENames FE Left join tblfeformulaNameorder FEO on FE.formulaentryId = FEO.FeNameID';
end;

  {TFeFormulaRelatedProducts}

constructor TFeFormulaRelatedProducts.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'FeFormulaRelatedProducts';
  fSQL := 'SELECT * FROM tblfeformularelatedproducts';
end;


destructor TFeFormulaRelatedProducts.Destroy;
begin
  inherited;
end;


procedure TFeFormulaRelatedProducts.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'FormulaID');
  SetPropertyFromNode(node,'ProductID');
  SetPropertyFromNode(node,'ProductName');
  SetPropertyFromNode(node,'ProductQty');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure TFeFormulaRelatedProducts.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'FormulaID' ,FormulaID);
  AddXMLNode(node,'ProductID' ,ProductID);
  AddXMLNode(node,'ProductName' ,ProductName);
  AddXMLNode(node,'ProductQty' ,ProductQty);
  AddXMLNode(node,'Active' ,Active);
end;


function TFeFormulaRelatedProducts.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TFeFormulaRelatedProducts.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TFeFormulaRelatedProducts.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TFeFormulaRelatedProducts.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;



function TFeFormulaRelatedProducts.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TFeFormulaRelatedProducts.GetIDField: string;
begin
  Result := 'ID'
end;


class function TFeFormulaRelatedProducts.GetBusObjectTablename: string;
begin
  Result:= 'tblfeformularelatedproducts';
end;


function TFeFormulaRelatedProducts.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if Owner is TFormula then
      FormulaID :=TFormula(Owner).ID;
end;

function TFeFormulaRelatedProducts.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TFeFormulaRelatedProducts.GetFormulaID       : Integer   ; begin Result := GetIntegerField('FormulaID'  );end;
function  TFeFormulaRelatedProducts.GetProductID       : Integer   ; begin Result := GetIntegerField('ProductID'  );end;
function  TFeFormulaRelatedProducts.GetProductName     : string    ; begin Result := GetStringField('ProductName' );end;
function  TFeFormulaRelatedProducts.GetProductQty      : Double    ; begin Result := GetFloatField('ProductQty'   );end;
function  TFeFormulaRelatedProducts.getActive          : Boolean   ; begin Result := GetBooleanField('Active'     );end;
procedure TFeFormulaRelatedProducts.SetFormulaID       (const Value: Integer   ); begin SetIntegerField('FormulaID'     , Value);end;
procedure TFeFormulaRelatedProducts.SetProductID       (const Value: Integer   ); begin SetIntegerField('ProductID'     , Value);end;
procedure TFeFormulaRelatedProducts.SetProductName     (const Value: string    ); begin SetStringField('ProductName'    , Value);end;
procedure TFeFormulaRelatedProducts.SetProductQty      (const Value: Double    ); begin SetFloatField('ProductQty'      , Value);end;
procedure TFeFormulaRelatedProducts.SetActive          (const Value: Boolean   ); begin SetBooleanField('Active'        , Value);end;


initialization
  RegisterClass(TFeFormulaRelatedProducts);
  RegisterClass(TFeformulaNameorder);
  RegisterClass(TFeFormulaTypes);
  RegisterClass(TFormulaEntry);
  RegisterClass(TFormula);

end.
