unit BusObjERPPreference;
{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  16/02/12  1.00.00  A.  Initial Version.
}

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;

type
  TERPPreference = class(TMSBusObj)
  private
    function GetPrefType: string;
    function GetPrefName: string;
    function GetFieldType: string;
    function GetFieldSize: Integer;
    function GetFieldValue: string;
    function GetDefaultValue: string;
    procedure SetPrefType(const Value: string);
    procedure SetPrefName(const Value: string);
    procedure SetFieldType(const Value: string);
    procedure SetFieldSize(const Value: Integer);
    procedure SetFieldValue(const Value: string);
    procedure SetDefaultValue(const Value: string);
    function GetLocalPref: boolean;
    function GetRefType: string;
    procedure SetLocalPref(const Value: boolean);
    procedure SetRefType(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    class function GetKeyStringField: string; override;
    class function GetKeyStringProperty: string; override;
    Class function SQLforPref(Const aPrefname:String):String;
  published
    property PrefType: string read GetPrefType write SetPrefType;
    property PrefName: string read GetPrefName write SetPrefName;
    property RefType: string read GetRefType write SetRefType;
    property LocalPref: boolean read GetLocalPref write SetLocalPref;
    property FieldType: string read GetFieldType write SetFieldType;
    property FieldSize: Integer read GetFieldSize write SetFieldSize;
    property FieldValue: string read GetFieldValue write SetFieldValue;
    property DefaultValue: string read GetDefaultValue write SetDefaultValue;
  end;
  TERPPreferenceExtra = class(TERPPreference)
    Private
    Protected
    Public
      constructor Create(AOwner: TComponent); override;
    published

  end;

implementation

uses tcDataUtils, CommonLib , SysUtils;

{ TERPPreference }

constructor TERPPreference.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'ERPPreference';
//  fSQL := 'SELECT * FROM tbldbpreferences where LocalPref = "F" and RefType = "None"';
  fSQL := 'SELECT * FROM tbldbpreferences where RefType = "None"';
end;

destructor TERPPreference.Destroy;
begin
  inherited;
end;

function TERPPreference.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if PrefType = '' then begin
    AddResult(false,rssWarning,0,'PrefType is blank.');
    exit;
  end;
  if PrefName = '' then begin
    AddResult(false,rssWarning,0,'PrefName is blank.');
    exit;
  end;

  Result := True;
end;

function TERPPreference.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TERPPreference.OnDataIDChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TERPPreference.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TERPPreference.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TERPPreference.GetIDField: string;
begin
  Result := 'PrefID'
end;

class function TERPPreference.GetKeyStringField: string;
begin
  result:= 'PrefType,Name';
end;

class function TERPPreference.GetKeyStringProperty: string;
begin
  result:= 'PrefType,PrefName';
end;

function TERPPreference.GetLocalPref: boolean;
begin
  result:= GetBooleanField('LocalPref');
end;

class function TERPPreference.GetBusObjectTablename: string;
begin
  Result := 'tbldbpreferences';
end;

function TERPPreference.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TERPPreference.GetPrefType: string;
begin
  Result := GetStringField('PrefType');
end;

function TERPPreference.GetRefType: string;
begin
  result:= GetStringField('RefType');
end;

function TERPPreference.GetPrefName: string;
begin
  Result := GetStringField('Name');
end;

function TERPPreference.GetFieldType: string;
begin
  Result := GetStringField('FieldType');
end;

function TERPPreference.GetFieldSize: Integer;
begin
  Result := GetIntegerField('FieldSize');
end;

function TERPPreference.GetFieldValue: string;
begin
  Result := GetStringField('FieldValue');
end;

function TERPPreference.GetDefaultValue: string;
begin
  Result := GetStringField('DefaultValue');
end;

procedure TERPPreference.SetPrefType(const Value: string);
begin
  SetStringField('PrefType', Value);
end;

procedure TERPPreference.SetRefType(const Value: string);
begin
  SetStringField('RefType',Value);
end;

class function TERPPreference.SQLforPref(const aPrefname: String): String;
begin
  result := 'SELECT * FROM tbldbpreferences where Name =' +quotedstr(aPrefName);
end;

procedure TERPPreference.SetPrefName(const Value: string);
begin
  SetStringField('Name', Value);
end;

procedure TERPPreference.SetFieldType(const Value: string);
begin
  SetStringField('FieldType', Value);
end;

procedure TERPPreference.SetFieldSize(const Value: Integer);
begin
  SetIntegerField('FieldSize', Value);
end;

procedure TERPPreference.SetFieldValue(const Value: string);
begin
  SetStringField('FieldValue', Value);
end;

procedure TERPPreference.SetLocalPref(const Value: boolean);
begin
  SetBooleanField('LocalPref',Value);
end;

procedure TERPPreference.SetDefaultValue(const Value: string);
begin
  SetStringField('DefaultValue', Value);
end;

{ TERPPreferenceExtra }

constructor TERPPreferenceExtra.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription := 'ERPPreference';
  fSQL := 'SELECT DB.PrefID, DB.Preftype, "DefaultServiceProduct" AS NAME, '+
                ' DB.reftype,DB.LocalPref, "ftString" AS Fieldtype,  '+
                ' 255 AS FieldSize, P.partname AS FieldValue,  '+
                ' NULL AS DefaultValue, NULL AS globalref, DB.mstimestamp, DB.msupdatesiteCode '+
                ' FROM tbldbpreferences  DB '+
                ' Left JOIN tblparts P ON DB.fieldvalue = P.partsId '+
                ' WHERE NAME = "DefaultServiceProductID"';
  IsReadonly := true;
end;

initialization

RegisterClass(TERPPreference);
RegisterClass(TERPPreferenceExtra);

end.
