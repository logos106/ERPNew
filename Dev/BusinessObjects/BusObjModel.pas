unit BusObjModel;
{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  11/11/11  1.00.00  A.  Initial Version.
}

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, MyAccess;

type
  TModel = class(TMSBusObj)
  private
    function GetModelName: string;
    function GetActive: Boolean;
    function GetCreatedOn: TDateTime;
    procedure SetModelName(const Value: string);
    procedure SetActive(const Value: Boolean);
    procedure SetCreatedOn(const Value: TDateTime);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
  public
    procedure DoFieldOnChange(Sender: TField); override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    class function GetKeyStringField: string; override;
    class function GetKeyStringProperty: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    class function AddNewModel(const aModel: string; var msg: string; Conn: TCustomMyConnection = nil): boolean;
    class function _Schema: string; override;
  published
    property ModelName: string read GetModelName write SetModelName;
    property Active: Boolean read GetActive write SetActive;
    property CreatedOn: TDateTime read GetCreatedOn write SetCreatedOn;
  end;

implementation

uses tcDataUtils, CommonLib, CommonDbLib, BusObjectListObj, SysUtils;

{ TModel }

class function TModel.AddNewModel(const aModel: string;
  var msg: string; Conn: TCustomMyConnection = nil): boolean;
var
  model: TModel;
begin
  model:= TModel.Create(nil);
  try
    try
      model.Connection:= TMyDacDataConnection.Create(model);
      if Assigned(Conn) then model.Connection.Connection:= Conn
      else model.Connection.Connection:= CommonDbLib.GetSharedMyDacConnection;
      model.LoadSelect('name = ' + QuotedStr(aModel));
      if model.Count = 0 then begin
        model.New;
        model.ModelName:= aModel;
        model.CreatedOn:= now;
        model.PostDb;
        if model.Save then
          result:= true
        else begin
          result:= false;
          msg:= model.ResultStatus.Messages;
        end;
      end
      else begin
        result:= false;
        msg:= 'The value "' + aModel + '" already exists in the Model list.';
      end;
    except
      on e: exception do begin
        result:= false;
        msg:= 'Error: ' + e.Message;
      end;
    end;
  finally
    model.Free;
  end;
end;

constructor TModel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'Model';
  fSQL := 'SELECT * FROM tblmodel';
end;

destructor TModel.Destroy;
begin
  inherited;
end;

procedure TModel.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'Name');
  SetBooleanPropertyFromNode(node, 'Active');
  SetDateTimePropertyFromNode(node, 'CreatedOn');
end;

procedure TModel.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'Name', name);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'CreatedOn', CreatedOn);
end;

function TModel.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if ModelName = ''  then begin
    AddResult(false, rssError, 0, 'Model Name should not be blank');
    exit;
  end;
  Result := True;
end;

class function TModel._Schema: string;
begin
  result:= inherited;
end;

function TModel.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TModel.OnDataIDChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TModel.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TModel.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TModel.GetIDField: string;
begin
  Result := 'ID'
end;

class function TModel.GetKeyStringField: string;
begin
  result:= 'Name';
end;

class function TModel.GetKeyStringProperty: string;
begin
  result:= 'ModelName';
end;

class function TModel.GetBusObjectTablename: string;
begin
  Result := 'tblmodel';
end;

function TModel.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TModel.GetModelName: string;
begin
  Result := GetStringField('Name');
end;

function TModel.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

function TModel.GetCreatedOn: TDateTime;
begin
  Result := GetDateTimeField('CreatedOn');
end;

procedure TModel.SetModelName(const Value: string);
begin
  SetStringField('Name', Value);
end;

procedure TModel.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TModel.SetCreatedOn(const Value: TDateTime);
begin
  SetDateTimeField('CreatedOn', Value);
end;

initialization

  RegisterClass(TModel);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Model','TModel','');

end.
