unit BusObjBankCode;

interface


uses BusObjBase, DB, Classes, MyAccess;


type
  TBankCode = class(TMSBusObj)
  private
    function GetBankCode       : string    ;
    function GetBankName       : string    ;
    function GetBankNumber     : string    ;
    function GetActive         : Boolean   ;
    procedure SetBankCode       (const Value: string    );
    procedure SetBankName       (const Value: string    );
    procedure SetBankNumber     (const Value: string    );
    procedure SetActive         (const Value: Boolean   );
    function GetRegionID: Integer;
    procedure SetRegionID(const Value: Integer);
    function GetRegion: string;
    procedure SetRegion(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    procedure DoFieldOnChange(Sender: TField);                          override;
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    class function GetKeyStringField: string; override;
    class function BankCodeUnique(const aBankCode: string;
                                  const aBankCodeId: integer;
                                  Connection: TCustomMyConnection = nil): boolean;
    class function BankNameUnique(const aBankName: string;
                                  const aBankCodeId: integer;
                                  Connection: TCustomMyConnection = nil): boolean;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property BankCode        :string      read GetBankCode      write SetBankCode   ;
    property BankName        :string      read GetBankName      write SetBankName   ;
    property BankNumber      :string      read GetBankNumber    write SetBankNumber ;
    property Active          :Boolean     read GetActive        write SetActive     ;
    property RegionID: Integer read GetRegionID write SetRegionID;
    property Region: string read GetRegion write SetRegion;
  end;


implementation


uses
  tcDataUtils, CommonLib, CommonDbLib, sysutils, BusObjectListObj, BusObjRegionalOptions;

  {TBankCodes}

constructor TBankCode.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'BankCodes';
  fSQL := 'SELECT * FROM tblbankcodes';
  ExportExcludeList.Add('regionid');
end;


destructor TBankCode.Destroy;
begin
  inherited;
end;


function TBankCode.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if BankCode = '' then begin
    AddResult(false,rssError,0,'Bank Code can not be blank');
    exit;
  end;
  if BankName = '' then begin
    AddResult(false,rssError,0,'Bank Name can not be blank');
    exit;
  end;
  if Id < 1 then PostDb;
  if not BankCodeUnique(BankCode,Id,Connection.Connection) then begin
    AddResult(false,rssError,0,'Bank Code is not unique');
    exit;
  end;
  if not BanknameUnique(BankName,Id,Connection.Connection) then begin
    AddResult(false,rssError,0,'Bank Name is not unique');
    exit;
  end;
  if RegionID < 1 then begin
    Resultstatus.AddItem(False, rssWarning, 0, 'Region is either blank or does not exist in Region list');
    Result := False;
    Exit;
  end;
  Result := True;
end;


function TBankCode.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TBankCode.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TBankCode.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


class function TBankCode.GetIDField: string;
begin
  Result := 'CodeID'
end;


class function TBankCode.GetBusObjectTablename: string;
begin
  Result:= 'tblbankcodes';
end;


function TBankCode.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TBankCode.GetBankCode   : string    ; begin Result := GetStringField('BankCode');end;
function  TBankCode.GetBankName   : string    ; begin Result := GetStringField('BankName');end;
function  TBankCode.GetBankNumber : string    ; begin Result := GetStringField('BankNumber');end;
function  TBankCode.GetActive     : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TBankCode.SetBankCode   (const Value: string    ); begin SetStringField('BankCode'    , Value);end;
procedure TBankCode.SetBankName   (const Value: string    ); begin SetStringField('BankName'    , Value);end;
procedure TBankCode.SetBankNumber (const Value: string    ); begin SetStringField('BankNumber'  , Value);end;
procedure TBankCode.SetActive     (const Value: Boolean   ); begin SetBooleanField('Active'      , Value);end;
function  TBankCode.GetRegionID: Integer;begin  Result := GetIntegerField('RegionID');end;
procedure TBankCode.SetRegionID(const Value: Integer);begin  SetIntegerField('RegionID', Value);end;
function  TBankCode.GetRegion: string;begin  Result := TRegionalOptions.IDToggle(RegionID, Connection.Connection);end;
procedure TBankCode.SetRegion(const Value: string);begin  RegionID := TRegionalOptions.IDToggle(Value, Connection.Connection);end;


class function TBankCode.GetKeyStringField: string;
begin
  result:= 'BankCode';
end;

class function TBankCode.BankCodeUnique(const aBankCode: string;
  const aBankCodeId: integer; Connection: TCustomMyConnection): boolean;
var
  qry: TMyQuery;
begin
  qry:= TMyQuery.Create(nil);
  try
    if Assigned(Connection) then qry.Connection:= Connection
    else qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select * from tblbankcodes');
    qry.SQL.Add('where BankCode = ' + QuotedStr(aBankCode));
    qry.SQL.Add('and CodeID <> ' + IntToStr(aBankCodeId));
    qry.Open;
    result:= qry.IsEmpty;
  finally
    qry.Free;
  end;
end;

class function TBankCode.BankNameUnique(const aBankName: string;
  const aBankCodeId: integer; Connection: TCustomMyConnection): boolean;
var
  qry: TMyQuery;
begin
  qry:= TMyQuery.Create(nil);
  try
    if Assigned(Connection) then qry.Connection:= Connection
    else qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select * from tblbankcodes');
    qry.SQL.Add('where BankName = ' + QuotedStr(aBankName));
    qry.SQL.Add('and CodeID <> ' + IntToStr(aBankCodeId));
    qry.Open;
    result:= qry.IsEmpty;
  finally
    qry.Free;
  end;
end;

initialization
  RegisterClass(TBankCode);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Bank Code','TBankCode','TfrmBankCodeList');


end.
