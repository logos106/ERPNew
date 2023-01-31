unit BusObjPayRate;
{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 18/10/05  1.00.01 AL   Added TPayRate business object

}

interface

uses XMLDoc, XMLIntf, BusObjBase, DB, Classes, ERPDbComponents, MyAccess;

type
  TPayRate = class(TMSBusObj)
  private
    fMultiplierParentGlobalRef: string;
    function GetDescription: string;
    function GetIsLeave: boolean;
    function GetIsPayRate: boolean;
    function GetMultiplier: double;
    function GetMultiplierParentID: integer;
    function GetRateID: integer;
    procedure SetDescription(const Value: string);
    procedure SetIsLeave(const Value: boolean);
    procedure SetIsPayRate(const Value: boolean);
    procedure SetMultiplier(const Value: double);
    procedure SetMultiplierParentID(const Value: integer);
    function getIsSuperEnabled: Boolean;
    procedure setIsSuperEnabled(const Value: Boolean);
    function GetAccrueLeave: boolean;
    function GetExtraLeaveAccrual: boolean;
    function GetExtraLeaveMultiplier: double;
    function GetExtraLeaveTypeID: integer;
    procedure SetAccrueLeave(const Value: boolean);
    procedure SetExtraLeaveAccrual(const Value: boolean);
    procedure SetExtraLeaveMultiplier(const Value: double);
    procedure SetExtraLeaveTypeID(const Value: integer);
    function GetMultiplierParentGlobalRef: string;
    procedure SetMultiplierParentGlobalRef(const Value: string);
  protected
    procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetId: integer; override;
    property RateID: integer read GetRateID;
    function ValidateData: boolean; override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    { pay rates have non standard chars in name eg 1/2 2/3 etc that don't work as part of URL }
//    class function GetKeyStringField: string; override;
//    class function GetKeyStringProperty: string; override;
    Class function IDToggle(const ID: Integer; Connection: TCustomMyConnection = nil; const AndSQL: string = ''): string; overload; override;
    Class function IDToggle(const KeyString: string; Connection: TCustomMyConnection = nil; const AndSQL: string = ''): Integer; overload; override;
    class function _Schema: string; override;
  Published
    property Description: string read GetDescription write SetDescription;
    property Multiplier: double read GetMultiplier write SetMultiplier;
    property IsPayRate: boolean read GetIsPayRate write SetIsPayRate;
    property IsLeave: boolean read GetIsLeave write SetIsLeave;
    property MultiplierParentID: integer read GetMultiplierParentID write SetMultiplierParentID;
    property MultiplierParentGlobalRef: string read GetMultiplierParentGlobalRef write SetMultiplierParentGlobalRef;
    property IsSuperEnabled :Boolean read getIsSuperEnabled Write setIsSuperEnabled;
    property AccrueLeave: boolean read GetAccrueLeave write SetAccrueLeave;
    property ExtraLeaveAccrual: boolean read GetExtraLeaveAccrual write SetExtraLeaveAccrual;
    property ExtraLeaveTypeID: integer read GetExtraLeaveTypeID write SetExtraLeaveTypeID;
    property ExtraLeaveMultiplier: double read GetExtraLeaveMultiplier write SetExtraLeaveMultiplier;
  end;

  TPayRatetype = class(TMSBusObj)
  private
    function GetDescription         : string    ;
    procedure SetDescription         (const Value: string    );
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
    class function GetKeyStringField: string; override;
  published
    property Description          :string      read GetDescription        write SetDescription     ;
  end;


implementation

uses
  CommonLib, CommonDbLib, BusObjSchemaLib, SysUtils;

{ TPayRate }

constructor TPayRate.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SQL := 'SELECT * FROM tblPayRates';
  ExportExcludeLIst.Add('multiplierparentid');
end;

destructor TPayRate.Destroy;
begin
  inherited;
end;

procedure TPayRate.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TPayRate.GetDescription: string;
begin
  Result := GetStringField('Description');
end;

function TPayRate.GetExtraLeaveAccrual: boolean;
begin
  result:= GetBooleanField('ExtraLeaveAccrual');
end;

function TPayRate.GetExtraLeaveMultiplier: double;
begin
  result:= GetFloatField('ExtraLeaveMultiplier');
end;

function TPayRate.GetExtraLeaveTypeID: integer;
begin
  result:= GetIntegerField('ExtraLeaveTypeID');
end;

function TPayRate.GetId: integer;
begin
  Result := RateID;
end;
class Function TPayRate.GetIDField :String ;
begin
    Result :='RateID';
end;

function TPayRate.GetAccrueLeave: boolean;
begin
  result:= GetBooleanField('AccrueLeave');
end;

class function TPayRate.GetBusObjectTablename: string;
begin
  Result := 'tblPayRates';
end;

function TPayRate.GetIsLeave: boolean;
begin
  Result := GetBooleanField('IsLeave');
end;

function TPayRate.GetIsPayRate: boolean;
begin
  Result := GetBooleanField('IsPayRate');
end;

//class function TPayRate.GetKeyStringField: string;
//begin
//  result:= 'Description';
//end;

//class function TPayRate.GetKeyStringProperty: string;
//begin
//  result:= 'Description';
//end;

function TPayRate.GetMultiplier: double;
begin
  Result := GetFloatField('Multiplier');
end;

function TPayRate.GetMultiplierParentGlobalRef: string;
begin
  if MultiplierParentID > 0 then
    result:= TPayRAte.IDGlobalRefToggle(MultiplierParentID, Connection.Connection)
  else
    result:= '';
end;

function TPayRate.GetMultiplierParentID: integer;
begin
  Result := GetIntegerField('MultiplierParentID');
end;

function TPayRate.GetRateID: integer;
begin
  Result := GetIntegerField('RateID');
end;

class function TPayRate.IDToggle(const ID: Integer;
  Connection: TCustomMyConnection; const AndSQL: string): string;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    if Assigned(Connection) then qry.Connection := Connection
    else qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select Description from tblPayRates');
    qry.SQL.Add('where RateId = ' + IntToStr(ID));
    if AndSQL <> '' then
      qry.SQL.Add('and ' + AndSQL);
    qry.Open;
    result:= qry.FieldByName('Description').AsString;
  finally
    qry.Free;
  end;
end;

class function TPayRate.IDToggle(const KeyString: string;
  Connection: TCustomMyConnection; const AndSQL: string): Integer;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    if Assigned(Connection) then qry.Connection := Connection
    else qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select RateID from tblPayRates');
    qry.SQL.Add('where Description = ' + QuotedStr(KeyString));
    if AndSQL <> '' then
      qry.SQL.Add('and ' + AndSQL);
    qry.Open;
    result:= qry.FieldByName('RateID').AsInteger;
  finally
    qry.Free;
  end;
end;

procedure TPayRate.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TPayRate.SetAccrueLeave(const Value: boolean);
begin
  SetBooleanField('AccrueLeave',Value);
end;

procedure TPayRate.SetDescription(const Value: string);
begin
  SetStringField('Description', Value);
end;

procedure TPayRate.SetExtraLeaveAccrual(const Value: boolean);
begin
  SetBooleanField('ExtraLeaveAccrual',Value);
end;

procedure TPayRate.SetExtraLeaveMultiplier(const Value: double);
begin
  SetFloatField('ExtraLeaveMultiplier',Value);
end;

procedure TPayRate.SetExtraLeaveTypeID(const Value: integer);
begin
  SetIntegerField('ExtraLeaveTypeID',Value);
end;

procedure TPayRate.SetIsLeave(const Value: boolean);
begin
  SetBooleanField('IsLeave', Value);
end;

procedure TPayRate.SetIsPayRate(const Value: boolean);
begin
  SetBooleanField('IsPayRate', Value);
end;

procedure TPayRate.SetMultiplier(const Value: double);
begin
  SetFloatField('Multiplier', Value);
end;

procedure TPayRate.SetMultiplierParentGlobalRef(const Value: string);
begin
  self.fMultiplierParentGlobalRef:= Value;
  if Value <> '' then
    MultiplierParentID := TPayRAte.IDGlobalRefToggle(Value, Connection.Connection)
  else
    MultiplierParentID := 0;
end;

procedure TPayRate.SetMultiplierParentID(const Value: integer);
begin
  SetIntegerField('MultiplierParentID', Value);
end;

function TPayRate.ValidateData: boolean;
begin
  result:= false;
  ResultStatus.Clear;
  if self.Description = '' then begin
		AddResult(false, rssWarning, 0, 'Description is blank');
		exit;
  end;
  if (self.fMultiplierParentGlobalRef <> '') and (MultiplierParentID = 0) then begin
		AddResult(false, rssWarning, 0, 'Multiplier Parent Pay Rate "' + fMultiplierParentGlobalRef + '" not found');
		exit;
  end;

  result:= true;
end;

class function TPayRate._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TLeaveTypes','LeaveTypeObj','ExtraLeaveTypeID','ID');
end;

function TPayRate.getIsSuperEnabled: Boolean;
begin
  Result := GetBooleanField('IsSuperEnabled');
end;

procedure TPayRate.setIsSuperEnabled(const Value: Boolean);
begin
  SetBooleanField('IsSuperEnabled' , value);
end;
  {TPayRatetype}

constructor TPayRatetype.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'payratetype';
  fSQL := 'SELECT * FROM tblpayratetype';
end;


destructor TPayRatetype.Destroy;
begin
  inherited;
end;


procedure TPayRatetype.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Description');
end;


procedure TPayRatetype.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Description' ,Description);
end;


function TPayRatetype.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TPayRatetype.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TPayRatetype.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TPayRatetype.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TPayRatetype.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TPayRatetype.GetIDField: string;
begin
  Result := 'TypeID'
end;


class function TPayRatetype.GetKeyStringField: string;
begin
  Result :='Description';
end;

class function TPayRatetype.GetBusObjectTablename: string;
begin
  Result:= 'tblpayratetype';
end;


function TPayRatetype.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TPayRatetype.GetDescription     : string    ; begin Result := GetStringField('Description');end;
procedure TPayRatetype.SetDescription     (const Value: string    ); begin SetStringField('Description'      , Value);end;


initialization
  RegisterClass(TPayRatetype);
  RegisterClassOnce(TPayRate);
end.
