unit BusObjServiceLog;

{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 22/09/30 1.00.01 Wang  Added TServiceLog business object.
}

interface

uses
  MyAccess,ERPdbComponents, DB, Dialogs, SysUtils, Variants, Classes,
  BusObjBase, XMLDoc, XMLIntf, commonlib;

type

  TServiceLog = class(TMSBusObj)
  private
    function GetAssetID             : Integer;
    function GetAssetCode           : String;
    function GetAssetName           : String;
    function GetServiceProvider     : String;
    function GetServiceDate         : TDateTime;
    function GetNetServiceDate      : TDateTime;
    function GetServiceNotes        : String;
    function GetEmployeeID          : Integer;
    function GetEmployeeName        : String;
    function GetCreationDate        : TDateTime;
    function GetHoursForNextService : Integer;
    function GetKmsForNextService   : Integer;
    function GetDone                : Boolean;

    procedure SetAssetID            (Const Value : Integer);
    procedure SetAssetCode          (Const Value : String);
    procedure SetAssetName          (Const Value : String);
    procedure SetServiceProvider    (Const Value : String);
    procedure SetServiceDate        (Const Value : TDateTime);
    procedure SetNetServiceDate     (Const Value : TDateTime);
    procedure SetServiceNotes       (Const Value : String);
    procedure SetEmployeeID         (Const Value : Integer);
    procedure SetEmployeeName       (Const Value : String);
    procedure SetCreationDate       (Const Value : TDateTime);
    procedure SetHoursForNextService(Const Value : Integer);
    procedure SetKmsForNextService  (Const Value : Integer);
    procedure SetDone               (Const Value : Boolean);


  protected
    function  DoAfterInsert(Sender: TDatasetBusObj)   : Boolean;    Override;
    function  DoAfterPost(Sender: TDatasetBusObj)     : Boolean;    Override;
    function  DoBeforePost(Sender: TDatasetBusObj)    : Boolean;    Override;
    function  GetSQL                                  : String;     Override;

  public
    Constructor     Create(AOwner: TComponent);             Override;
    destructor      Destroy;                                Override;
    procedure       DoFieldOnChange(Sender: TField);        Override;
    class function  GetBusObjectTablename: string;          Override;
    class function  GetIDField: string;                     Override;
    function        GetId: Integer;                                Override;
    procedure       LoadFromXMLNode(Const node: IXMLNode);  Override;
    procedure       SaveToXMLNode(Const node: IXMLNode);    Override;
    function        ValidateData :Boolean ;                 Override;
    function        Save :Boolean ;                         Override;

  Published
    property AssetID              : Integer         read GetAssetID             write SetAssetID;
    property AssetCode            : String          read GetAssetCode           write SetAssetcode;
    property AssetName            : String          read GetAssetName           Write SetAssetName;
    property ServiceProvider      : String          read GetServiceProvider     Write SetServiceProvider;
    property ServiceDate          : TDateTime       read GetServiceDate         Write SetServiceDate;
    property NetServiceDate       : TDateTime       read GetNetServiceDate      Write SetNetServiceDate;
    property ServiceNotes         : String          read GetServiceNotes        Write SetServiceNotes;
    property EmployeeID           : Integer         read GetEmployeeID          Write SetEmployeeID;
    property EmployeeName         : String          read GetEmployeeName        Write SetEmployeeName;
    property CreationDate         : TDateTime       read GetCreationDate        Write SetCreationDate;
    property HoursForNextService  : Integer         read GetHoursForNextService Write SetHoursForNextService;
    property KmsForNextService    : Integer         read GetKmsForNextService   Write SetKmsForNextService;
    property Done                 : Boolean         read GetDone                Write SetDone;

  end;

implementation

uses
   tcDataUtils, AppEnvironment, BusObjRegionalOptions,
   CommonDbLib, BusObjConst,  DNMLib, BusObjectListObj, BusObjSchemaLib,
   BusobjCountries, BusObjLocation, DbSharedObjectsObj, tcConst, Controls;


 { TServiceLog }
Constructor TServiceLog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSql := 'SELECT * FROM tblFixedAssetServiceLog';
//  ExportExcludeList.Add('ID');
end;

destructor TServiceLog.Destroy;
begin
  inherited;
end;

class function TServiceLog.GetBusObjectTablename: string;
begin
  Result := 'tblFixedAssetServiceLog';
end;

function TServiceLog.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function  TServiceLog.GetIDField :String;
begin
    Result := 'ServiceID';
end;

procedure TServiceLog.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

  inherited;
end;

function TServiceLog.GetID                  : Integer;    begin Result := GetIntegerField('ServiceID');           end;
function TServiceLog.GetAssetID             : Integer;    begin Result := GetIntegerField('AssetID');             end;
function TServiceLog.GetAssetCode           : String;     begin Result := GetStringField('AssetCode');            end;
function TServiceLog.GetAssetName           : String;     begin Result := GetStringField('AssetName');            end;
function TServiceLog.GetServiceProvider     : String;     begin Result := GetstringField('ServiceProvidcer');     end;
function TServiceLog.GetServiceDate         : TDateTime;  begin Result := GetDateTimeField('SercieDate');         end;
function TServiceLog.GetNetServiceDate      : TDateTime;  begin Result := GetDateTimeField('NextServiceDate');    end;
function TServiceLog.GetServiceNotes        : String;     begin Result := GetStringField('SercieNotes');          end;
function TServiceLog.GetEmployeeID          : Integer;    begin Result := GetIntegerField('EmployeeID');          end;
function TServiceLog.GetEmployeeName        : String;     begin Result := GetStringField('EmployeeName');         end;
function TServiceLog.GetCreationDate        : TDateTime;  begin Result := GetDateTimeField('CreationDate');       end;
function TServiceLog.GetHoursForNextService : Integer;    begin Result := GetIntegerField('HoursForNextService'); end;
function TServiceLog.GetKmsForNextService   : Integer;    begin Result := GetIntegerField('KmsForNextService');   end;
function TServiceLog.GetDone                : Boolean;    begin Result := GetBooleanField('Done');                end;

procedure TServiceLog.SetAssetID             (Const Value: Integer);    begin SetIntegerField('AssetID', Value);              end;
procedure TServiceLog.SetAssetCode           (Const Value: String);     begin SetStringField('AssetCode', Value);             end;
procedure TServiceLog.SetAssetName           (Const Value: String);     begin SetStringField('AssetName', Value);             end;
procedure TServiceLog.SetServiceProvider     (Const Value: String);     begin SetStringField('ServiceProvider', Value);       end;
procedure TServiceLog.SetServiceDate         (Const Value: TDateTime);  begin SetDateTimeField('ServiceDate', Value);         end;
procedure TServiceLog.SetNetServiceDate      (Const Value: TDateTime);  begin SetDateTimeField('NextServiceDate', Value);     end;
procedure TServiceLog.SetServiceNotes        (Const Value: String);     begin SetStringField('ServiceNotes', Value);          end;
procedure TServiceLog.SetEmployeeID          (Const Value: Integer);    begin SetIntegerField('EmployeeID', Value);           end;
procedure TServiceLog.SetEmployeeName        (Const Value: String);     begin SetStringField('EmployeeName', Value);          end;
procedure TServiceLog.SetCreationDate        (Const Value: TDateTime);  begin SetDateTimeField('CreationDate', Value);        end;
procedure TServiceLog.SetHoursForNextService (Const Value: Integer);    begin SetIntegerField('HoursForNextService', Value);  end;
procedure TServiceLog.SetKmsForNextService   (Const Value: Integer);    begin SetIntegerField('KmsForNextService', Value);    end;
procedure TServiceLog.SetDone                (Const Value: Boolean);    begin SetBooleanField('Done', Value);                 end;


procedure TServiceLog.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node, 'AssetID');
  SetPropertyFromNode(Node, 'AssetCode');
  SetPropertyFromNode(Node, 'AssetName');
  SetPropertyFromNode(Node, 'ServiceProvider');
  SetPropertyFromNode(Node, 'ServiceDate');
  SetPropertyFromNode(Node, 'NetServiceDate');
  SetPropertyFromNode(Node, 'ServiceProvider');
  SetPropertyFromNode(Node, 'EmployeeID');
  SetPropertyFromNode(Node, 'EmployeeName');
  SetPropertyFromNode(Node, 'CreationDate');
  SetPropertyFromNode(Node, 'HoursForNextService');
  SetPropertyFromNode(Node, 'KmsForNextService');
  SetPropertyFromNode(Node, 'Done');

end;

procedure TServiceLog.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;

  AddXMLNode(node, 'AssetID',             AssetID);
  AddXMLNode(node, 'AssetCode',           AssetCode);
  AddXMLNode(node, 'AssetName',           AssetName);
  AddXMLNode(node, 'ServiceProvider',     ServiceProvider);
  AddXMLNode(node, 'SericeDate',          ServiceDate);
  AddXMLNode(node, 'NetServiceDate',      NetServiceDate);
  AddXMLNode(node, 'ServiceNotes',        ServiceNotes);
  AddXMLNode(node, 'EmployeeID',          EmployeeID);
  AddXMLNode(node, 'EmployeeName',        EmployeeName);
  AddXMLNode(node, 'CreationDate',        CreationDate);
  AddXMLNode(node, 'HoursForNextService', HoursForNextService);
  AddXMLNode(node, 'KmsForNextService',   KmsForNextService);
  AddXMLNode(node, 'Done',                Done);

end;

function TServiceLog.ValidateData : Boolean;
var
  CleanCodeName: string;
begin
  Result := inherited ValidateData;
  if not Result then Exit;

  Result := False;
  Resultstatus.Clear;

  Result := True;
end;

function TServiceLog.Save :Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

function TServiceLog.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result:= inherited DoAfterInsert(Sender);
  if not Result then exit;
end;

function TServiceLog.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then Exit;
end;

function TServiceLog.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not(Result) then Exit;
end;
initialization
  RegisterClassOnce(TServiceLog);
end.

