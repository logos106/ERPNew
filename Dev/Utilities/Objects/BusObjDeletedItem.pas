unit BusObjDeletedItem;

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, MyAccess;

type
  TDeletedItem = class(TMSBusObj)
  private
    fDoDelete: boolean;
    function GetDeleteTableName: string;
    function GetDeletedGlobalRef: string;
    function GetEmployeeName: string;
    procedure SetDeleteTableName(const Value: string);
    procedure SetDeletedGlobalRef(const Value: string);
    procedure SetEmployeeName(const Value: string);
    function GetXRef: string;
    procedure SetXRef(const Value: string);
    function GetDeletedClassName: string;
    function GetDeletedID: integer;
    procedure SetDeletedClassName(const Value: string);
    procedure SetDeletedID(const Value: integer);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
  public
    procedure DoFieldOnChange(Sender: TField); override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
//    class function GetDeletedTablename: string; virtual;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    property DoDelete: boolean read fDoDelete write fDoDelete;
//    class function AddDeleted(aTableName, aClassName,
//      aGlobalRef: string; aID: integer;
//      Connection: TCustomMyConnection; var msg: string;
//      DoDelete: boolean = true; aXRef: string = ''): boolean; //overload;
    class function AddDeleted(aTableName, aClassName,
      aGlobalRef: string; aID: integer;
      Connection: TCustomMyConnection; var msg: string;
      DoDelete: boolean = true; aXRef: string = ''): boolean; overload;
    class function AddDeleted(Obj: TBusObj; var msg: string; DoDelete: boolean = true; aXRef: string = ''): boolean; overload;


      //    class function AddDeleted(aGlobalRef: string;
//      Connection: TCustomMyConnection; var msg: string;
//      DoDelete: boolean = true; aXRef: string = ''): boolean; overload;
  published
    property DeleteTableName: string read GetDeleteTableName write SetDeleteTableName;
    property DeletedGlobalRef: string read GetDeletedGlobalRef write SetDeletedGlobalRef;
    property DeletedID: integer read GetDeletedID write SetDeletedID;
    property DeletedClassName: string read GetDeletedClassName write SetDeletedClassName;
    property EmployeeName: string read GetEmployeeName write SetEmployeeName;
    property XRef: string read GetXRef write SetXRef;
  end;

implementation

uses tcDataUtils, CommonLib, AppEnvironment, ERPDBComponents, SysUtils;

{ TDeletedItem }

class function TDeletedItem.AddDeleted(aTableName, aClassName,
      aGlobalRef: string; aID: integer;
      Connection: TCustomMyConnection; var msg: string;
      DoDelete: boolean = true; aXRef: string = ''): boolean;
var
  Inst: TDeletedItem;
begin
  Inst:= TDeletedItem.Create(nil);
  try
    Inst.Connection:= TMyDacDataConnection.Create(Inst);
    Inst.SilentMode:= true;
    Inst.Connection.Connection:= Connection;
    Inst.DoDelete:= DoDelete;
    Inst.Load(0);
    Inst.New;
    Inst.DeleteTableName:= aTableName;
    Inst.DeletedClassName := aClassName;
    Inst.DeletedGlobalRef:= aGlobalRef;
    Inst.DeletedID := aID;
    Inst.EmployeeName:= AppEnv.Employee.EmployeeName;
    Inst.XRef := aXRef;
    Inst.PostDb;
    result:= Inst.Save;
    if not result then
      msg:= Inst.ResultStatus.Messages;
  finally
    Inst.Free;
  end;
end;

//class function TDeletedItem.AddDeleted(aGlobalRef: string;
//      Connection: TCustomMyConnection; var msg: string;
//      DoDelete: boolean = true; aXRef: string = ''): boolean;
//begin
//  if GetDeletedTablename = '' then
//    raise Exception.Create('TDeletedItem - Value for GetDeletedTablename is blank');
//  result := AddDeleted(GetDeletedTableName,aGlobalRef,Connection,msg,DoDelete, aXRef);
//end;

class function TDeletedItem.AddDeleted(Obj: TBusObj; var msg: string;
  DoDelete: boolean; aXRef: string): boolean;
var
 gRef: string;
begin
  gRef := '';
  if Obj is TMsBusObj then
    gRef := TMsBusObj(Obj).GlobalRef;

  if Obj is TDatasetBusObj then begin
    result := TDeletedItem.AddDeleted(Obj.GetBusObjectTablename,Obj.ClassName,
      gRef,Obj.ID,Obj.Connection.Connection,msg,false,aXRef);
    if Result and DoDelete then
      result := TDatasetBusObj(obj).Delete
  end
  else
    result := TDeletedItem.AddDeleted(Obj.GetBusObjectTablename,Obj.ClassName,
      gRef,Obj.ID,Obj.Connection.Connection,msg,DoDelete,aXRef);
end;

constructor TDeletedItem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'DeletedItem';
  fSQL := 'SELECT * FROM tbldeleteditem';
//  if GetDeletedTableName <> '' then
//    fSQL := fSQL + ' where TableName = ' + QuotedStr(GetDeletedTableName);
  fDoDelete:= true;
end;

destructor TDeletedItem.Destroy;
begin
  inherited;
end;

procedure TDeletedItem.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'DeleteTableName');
  SetPropertyFromNode(node, 'DeletedGlobalRef');
  SetPropertyFromNode(node, 'EmployeeName');
end;

procedure TDeletedItem.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'DeleteTableName', DeleteTableName);
  AddXMLNode(node, 'DeletedGlobalRef', DeletedGlobalRef);
  AddXMLNode(node, 'EmployeeName', EmployeeName);
end;

function TDeletedItem.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if TableName = '' then begin
    ResultStatus.AddItem(False, rssWarning, 0, 'Table Name missing');
    exit;
  end;
  if DeletedGlobalRef = '' then begin
    ResultStatus.AddItem(False, rssWarning, 0, 'DeletedGlobalRef missing');
    exit;
  end;

  Result := True;
end;

function TDeletedItem.Save: Boolean;
var
  cmd: TERPCommand;
begin
  Result := False;
  PostDb;
  if not ValidateData then Exit;
  if DoDelete then begin
    cmd:= TERPCommand.Create(nil);
    try
      cmd.Connection:= Self.Connection.Connection;
      cmd.SQL.Add('delete from ' + DeleteTableName);
      cmd.SQL.Add('where GlobalRef = ' + QuotedStr(DeletedGlobalRef));
      try
        cmd.Execute;
      except
        on e: exception do begin
          ResultStatus.AddItem(False, rssWarning, 0, 'Error deleting GlobalRef "' + DeletedGlobalRef + '" from ' + DeleteTableName + ' message: ' + e.Message);
          exit;
        end;
      end;
    finally
      cmd.Free;
    end;
  end;
  Result := inherited Save;
end;

procedure TDeletedItem.OnDataIDChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TDeletedItem.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TDeletedItem.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

function TDeletedItem.GetXRef: string;
begin
  result := GetStringField('XRef');
end;

class function TDeletedItem.GetIDField: string;
begin
  Result := 'DeletedItemID'
end;

class function TDeletedItem.GetBusObjectTablename: string;
begin
  Result := 'tbldeleteditem';
end;

function TDeletedItem.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TDeletedItem.GetDeleteTableName: string;
begin
  Result := GetStringField('TableName');
end;

function TDeletedItem.GetDeletedClassName: string;
begin
  result := GetStringField('DeletedClassName');
end;

function TDeletedItem.GetDeletedGlobalRef: string;
begin
  Result := GetStringField('DeletedGlobalRef');
end;

function TDeletedItem.GetDeletedID: integer;
begin
  result := GetIntegerField('DeletedID');
end;

//class function TDeletedItem.GetDeletedTablename: string;
//begin
//  result := '';
//end;

function TDeletedItem.GetEmployeeName: string;
begin
  Result := GetStringField('EmployeeName');
end;

procedure TDeletedItem.SetDEleteTableName(const Value: string);
begin
  SetStringField('TableName', Value);
end;

procedure TDeletedItem.SetDeletedClassName(const Value: string);
begin
  SetStringField('DeletedClassName', Value);
end;

procedure TDeletedItem.SetDeletedGlobalRef(const Value: string);
begin
  SetStringField('DeletedGlobalRef', Value);
end;

procedure TDeletedItem.SetDeletedID(const Value: integer);
begin
  SetIntegerField('DeletedID',Value);
end;

procedure TDeletedItem.SetEmployeeName(const Value: string);
begin
  SetStringField('EmployeeName', Value);
end;

procedure TDeletedItem.SetXRef(const Value: string);
begin
  SetStringField('XRef', Value);
end;

initialization

RegisterClass(TDeletedItem);

end.
