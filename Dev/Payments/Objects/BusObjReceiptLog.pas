unit BusObjReceiptLog;

{
   Date     Version  Who    What
  -------- -------- ---     ------------------------------------------------------
  15/12/22  1.00.00  Wang   Initial Version.
}

interface

uses
  MyAccess,ERPdbComponents, DB, Dialogs, SysUtils, Variants, Classes,
  BusObjBase, XMLDoc, XMLIntf, commonlib;

type

  TReceiptLog = class(TMSBusObj)
  private
    function GetModule        : String;
    function GetUserID        : Integer;
    function GetUserName      : String;
    function GetLogTime       : TDateTime;
    function GetReceiptInfo   : String;

    procedure SetUserID       (const Value: Integer);
    procedure SetModule       (const Value: String);
    procedure SetUserName     (const Value: String);
    procedure SetLogTime      (const Value: TDateTIme);
    procedure SetReceiptInfo  (const Value: String);

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Function  DoAfterDelete(Sender :TDatasetBusObj): Boolean;           override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;            override;

  public
    procedure       DoFieldOnChange(Sender: TField);                    override;
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor     Create(AOwner: TComponent);                         override;
    destructor      Destroy;                                            override;
    procedure       LoadFromXMLNode(const node: IXMLNode);              override;
    procedure       SaveToXMLNode(const node: IXMLNode);                override;
    function        ValidateData: Boolean ;                             override;
    function        Save: Boolean ;                                     override;
    property        Module: String                  read GetModule          write SetModule;

  published
    property UserID         : Integer               read GetUserID          write SetUserID;
    property UserName       : String                read GetUserName        write SetUserName;
    property LogTime        : TDateTime             read GetLogTime         write SetLogTime;
    property ReceiptInfo    : String                read GetReceiptInfo     write SetReceiptInfo;

  end;

implementation

uses
   tcDataUtils, AppEnvironment, BusObjRegionalOptions,
   CommonDbLib, BusObjConst,  DNMLib, BusObjectListObj, BusObjSchemaLib,
   BusobjCountries, BusObjLocation, DbSharedObjectsObj, tcConst, Controls;


 {TReceiptLog.}
constructor TReceiptLog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'Logs for Customer Recipt';
  fSQL := 'SELECT * FROM tbllog WHERE Module="Customer Receipt"';
end;

destructor TReceiptLog.Destroy;
begin
  inherited;
end;

procedure TReceiptLog.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

  SetPropertyFromNode(node, 'UserID');
  SetPropertyFromNode(node, 'UserName');
  SetPropertyFromNode(node, 'LogTime');
  SetPropertyFromNode(node, 'ReceiptInfo');
end;

procedure TReceiptLog.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;

  AddXMLNode(node, 'UserID', UserID);
  AddXMLNode(node, 'UserName', UserName);
  AddXMLNode(node, 'LogTime', LogTime);
  AddXMLNode(node, 'ReceiptInfo', ReceiptInfo);
end;

function TReceiptLog.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;

  if UserID < 0 then begin
    AddResult(False, rssError, 0, 'User ID should not be 0', True);
    Exit;
  end;

  if UserName = '' then begin
    AddResult(False, rssError, 0, 'User Name should not be empty', True);
    Exit;
  end;

  Result := True;
end;

function TReceiptLog.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;

  Self.Module := 'Customer Receipt';
  Result := inherited Save;
end;

procedure TReceiptLog.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TReceiptLog.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
end;

function TReceiptLog.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TReceiptLog.GetIDField: string;
begin
  Result := 'LogID'
end;

class function TReceiptLog.GetBusObjectTablename: string;
begin
  Result:= 'tbllog';
end;

function TReceiptLog.DoAfterDelete(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterDelete(Sender);
end;

function TReceiptLog.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterInsert(Sender);
  if not Result then Exit;
end;

function TReceiptLog.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function TReceiptLog.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoBeforePost(Sender);
  if not result then exit;
end;

{Property Functions}
function TReceiptLog.GetModule      : String;     begin Result := GetStringField('Module');         end;
function TReceiptLog.GetUserID      : Integer;    begin Result := GetIntegerField('UserID');        end;
function TReceiptLog.GetUserName    : String;     begin Result := GetStringField('UserName');       end;
function TReceiptLog.GetLogTime     : TDateTime;  begin Result := GetDateTimeField('LogTime');      end;
function TReceiptLog.GetReceiptInfo : String;     begin Result := GetStringField('Log');            end;

procedure TReceiptLog.SetModule     (const Value: String);    begin SetStringField('Module', Value);    end;
procedure TReceiptLog.SetUserID     (const Value: Integer);   begin SetIntegerField('UserID', Value);   end;
procedure TReceiptLog.SetUserName   (const Value: String);    begin SetStringField('UserName', Value);  end;
procedure TReceiptLog.SetLogTime    (const Value: TDateTime); begin SetDateTimeField('LogTime', Value); end;
procedure TReceiptLog.SetReceiptInfo(const Value: String);    begin SetStringField('Log', Value);       end;


initialization
  RegisterClass(TReceiptLog);
end.


