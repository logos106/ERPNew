unit BusobjDbPreferences4AuditTrail;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  03/08/18  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf , BusobjPersonalPreference;


type
  TDbPreferences = class(TMSBusObj)
  private
    function GetPrefType            : string    ;
    function GetName                : string    ;
    function GetRefType             : string    ;
    function GetLocalPref           : Boolean   ;
    function GetFieldType           : string    ;
    function GetFieldSize           : Integer   ;
    function GetFieldValue          : string    ;
    function GetDefaultValue        : string    ;
    procedure SetPrefType            (const Value: string    );
    procedure SetName                (const Value: string    );
    procedure SetRefType             (const Value: string    );
    procedure SetLocalPref           (const Value: Boolean   );
    procedure SetFieldType           (const Value: string    );
    procedure SetFieldSize           (const Value: Integer   );
    procedure SetFieldValue          (const Value: string    );
    procedure SetDefaultValue        (const Value: string    );
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
    property PrefType             :string      read GetPrefType           write SetPrefType        ;
    property Name                 :string      read GetName               write SetName            ;
    property RefType              :string      read GetRefType            write SetRefType         ;
    property LocalPref            :Boolean     read GetLocalPref          write SetLocalPref       ;
    property FieldType            :string      read GetFieldType          write SetFieldType       ;
    property FieldSize            :Integer     read GetFieldSize          write SetFieldSize       ;
    property FieldValue           :string      read GetFieldValue         write SetFieldValue      ;
    property DefaultValue         :string      read GetDefaultValue       write SetDefaultValue    ;
  end;
  TPersonalPreferences4AuditTrail  = class(TPersonalPreferences)
  private
    function getDbPreferences: TDbPreferences;
  Protected
    Function ExportsubClasses(Const Node: IXMLNode): Boolean; Override;
    Function ImportsubClasses(const node: IXMLNode):Boolean; Override;
    procedure SaveToXMLNode(Const Node: IXMLNode); override;
    procedure LoadFromXMLNode(Const Node: IXMLNode); override;
  Published
    Property DbPreferences : TDbPreferences read getDbPreferences;
  end;


implementation


uses tcDataUtils, CommonLib;



  {TDbPreferences}

constructor TDbPreferences.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'DbPreferences';
  fSQL := 'SELECT * FROM tbldbpreferences';
end;


destructor TDbPreferences.Destroy;
begin
  inherited;
end;


procedure TDbPreferences.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'PrefType');
  SetPropertyFromNode(node,'Name');
  SetPropertyFromNode(node,'RefType');
  SetBooleanPropertyFromNode(node,'LocalPref');
  SetPropertyFromNode(node,'FieldType');
  SetPropertyFromNode(node,'FieldSize');
  SetPropertyFromNode(node,'FieldValue');
  SetPropertyFromNode(node,'DefaultValue');
end;


procedure TDbPreferences.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'PrefType' ,PrefType);
  AddXMLNode(node,'Name' ,Name);
  AddXMLNode(node,'RefType' ,RefType);
  AddXMLNode(node,'LocalPref' ,LocalPref);
  AddXMLNode(node,'FieldType' ,FieldType);
  AddXMLNode(node,'FieldSize' ,FieldSize);
  AddXMLNode(node,'FieldValue' ,FieldValue);
  AddXMLNode(node,'DefaultValue' ,DefaultValue);
end;


function TDbPreferences.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TDbPreferences.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TDbPreferences.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TDbPreferences.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TDbPreferences.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TDbPreferences.GetIDField: string;
begin
  Result := 'PrefID'
end;


class function TDbPreferences.GetBusObjectTablename: string;
begin
  Result:= 'tbldbpreferences';
end;


function TDbPreferences.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TDbPreferences.GetPrefType        : string    ; begin Result := GetStringField('PrefType');end;
function  TDbPreferences.GetName            : string    ; begin Result := GetStringField('Name');end;
function  TDbPreferences.GetRefType         : string    ; begin Result := GetStringField('RefType');end;
function  TDbPreferences.GetLocalPref       : Boolean   ; begin Result := GetBooleanField('LocalPref');end;
function  TDbPreferences.GetFieldType       : string    ; begin Result := GetStringField('FieldType');end;
function  TDbPreferences.GetFieldSize       : Integer   ; begin Result := GetIntegerField('FieldSize');end;
function  TDbPreferences.GetFieldValue      : string    ; begin Result := GetStringField('FieldValue');end;
function  TDbPreferences.GetDefaultValue    : string    ; begin Result := GetStringField('DefaultValue');end;
procedure TDbPreferences.SetPrefType        (const Value: string    ); begin SetStringField('PrefType'         , Value);end;
procedure TDbPreferences.SetName            (const Value: string    ); begin SetStringField('Name'             , Value);end;
procedure TDbPreferences.SetRefType         (const Value: string    ); begin SetStringField('RefType'          , Value);end;
procedure TDbPreferences.SetLocalPref       (const Value: Boolean   ); begin SetBooleanField('LocalPref'        , Value);end;
procedure TDbPreferences.SetFieldType       (const Value: string    ); begin SetStringField('FieldType'        , Value);end;
procedure TDbPreferences.SetFieldSize       (const Value: Integer   ); begin SetIntegerField('FieldSize'        , Value);end;
procedure TDbPreferences.SetFieldValue      (const Value: string    ); begin SetStringField('FieldValue'       , Value);end;
procedure TDbPreferences.SetDefaultValue    (const Value: string    ); begin SetStringField('DefaultValue'     , Value);end;


{ TPersonalPreferences4AuditTrail }

function TPersonalPreferences4AuditTrail.ExportsubClasses(
  const Node: IXMLNode): Boolean;
begin
  DbPreferences.XMLPropertyNode := Node.AddChild(DbPreferences.XMLBranchName);
  DbPreferences.XMLPropertyName := DbPreferences.XMLNodeName;
  DbPreferences.IterateRecords(GetPropertyXMLCallback);

end;

function TPersonalPreferences4AuditTrail.getDbPreferences: TDbPreferences;
begin
  Result := TDbPreferences(Getcontainercomponent(TDbPreferences, 'Name <> ""'));
end;

function TPersonalPreferences4AuditTrail.ImportsubClasses(const node: IXMLNode): Boolean;
Var
  X        : Integer;
  Singlerec: IXMLNode;
Begin
  Result          := False;
  ImportFailed    := False;
  XMLPropertyName := DbPreferences.XMLBranchName;
  XMLPropertyNode := Node.ChildNodes.FindNode(XMLPropertyName);
  If Assigned(XMLPropertyNode) Then Begin
    For X                        := 0 To XMLPropertyNode.ChildNodes.Count - 1 Do Begin
      DbPreferences.ImportingFromXMLFile := True;
      Singlerec                  := XMLPropertyNode.ChildNodes[X];
      DbPreferences.ImportFromXML(SingleRec);
      ImportFailed := DbPreferences.ImportFailed;
      If Error Then Exit;
    End;
  End;
  ImportFailed := False;
  Result       := True;
end;
procedure TPersonalPreferences4AuditTrail.SaveToXMLNode(Const Node: IXMLNode);
begin
  inherited SaveToXMLNode(node);
  ExportsubClasses(node);
end;
procedure TPersonalPreferences4AuditTrail.LoadFromXMLNode(Const Node: IXMLNode);
begin
  inherited LoadFromXMLNode(node);
  ImportsubClasses(node);
end;

initialization
  RegisterClass(TDbPreferences);


end.
