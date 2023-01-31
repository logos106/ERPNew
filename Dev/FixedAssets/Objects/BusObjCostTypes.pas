unit BusObjCostTypes;

{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 22/09/30 1.00.01 Wang  Added TCostTypes business object.
}

interface

uses
  MyAccess,ERPdbComponents, DB, Dialogs, SysUtils, Variants, Classes,
  BusObjBase, XMLDoc, XMLIntf, commonlib;

type

  TCostTypes = class(TMSBusObj)
  private
    function GetTypeName            : String;
    function GetDescription         : String;

    procedure SetTypeName           (Const Value : String);
    procedure SetDescription        (Const Value : String);

  protected
    function  DoAfterInsert(Sender: TDatasetBusObj)   : Boolean;    Override;
    function  DoAfterPost(Sender: TDatasetBusObj)     : Boolean;    Override;
    function  DoBeforePost(Sender: TDatasetBusObj)    : Boolean;    Override;
    function  GetSQL                                  : String;     Override;

  public
    constructor     Create(AOwner: TComponent);             Override;
    destructor      Destroy;                                Override;
    procedure       DoFieldOnChange(Sender: TField);        Override;
    class function  GetBusObjectTablename: string;          Override;
    class function  GetIDField: string;                     Override;
    function        GetId: Integer;                         Override;
    procedure       LoadFromXMLNode(Const node: IXMLNode);  Override;
    procedure       SaveToXMLNode(Const node: IXMLNode);    Override;
    function        ValidateData :Boolean ;                 Override;
    function        Save :Boolean ;                         Override;

  Published
    property TypeName:      String        read GetTypeName      write SetTypeName;
    property Description:   String        read GetDescription   write SetDescription;

  end;

implementation

uses
   tcDataUtils, AppEnvironment, BusObjRegionalOptions,
   CommonDbLib, BusObjConst,  DNMLib, BusObjectListObj, BusObjSchemaLib,
   BusobjCountries, BusObjLocation, DbSharedObjectsObj, tcConst, Controls;


 { TCostTypes }
Constructor TCostTypes.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSql := 'SELECT * FROM tblCostTypes';
end;

destructor TCostTypes.Destroy;
begin
  inherited;
end;

class function TCostTypes.GetBusObjectTablename: string;
begin
  Result := 'tblCostTypes';
end;

function TCostTypes.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function  TCostTypes.GetIDField :String;
begin
    Result := 'TypeID';
end;

procedure TCostTypes.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

  inherited;
end;

function TCostTypes.GetID                  : Integer;    begin Result := GetIntegerField('TypeID');             end;
function TCostTypes.GetTypeName            : String;     begin Result := GetStringField('TypeName');            end;
function TCostTypes.GetDescription         : String;     begin Result := GetStringField('Description');         end;

procedure TCostTypes.SetTypeName    (Const Value: String);    begin SetStringField('TypeName', Value);         end;
procedure TCostTypes.SetDescription (Const Value: String);    begin SetStringField('Description', Value);       end;

procedure TCostTypes.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node, 'TypeName');
  SetPropertyFromNode(Node, 'Description');
end;

procedure TCostTypes.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;

  AddXMLNode(node, 'TypeName',            TypeName);
  AddXMLNode(node, 'Description',         Description);
end;

function TCostTypes.ValidateData: Boolean;
var
  CleanCodeName: string;
begin
  Result := inherited ValidateData;
  if not Result then Exit;

  Result := False;
  Resultstatus.Clear;

  Result := True;
end;

function TCostTypes.Save :Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

function TCostTypes.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result:= inherited DoAfterInsert(Sender);
  if not Result then exit;
end;

function TCostTypes.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then Exit;
end;

function TCostTypes.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not(Result) then Exit;
end;

initialization
  RegisterClassOnce(TCostTypes);
end.

