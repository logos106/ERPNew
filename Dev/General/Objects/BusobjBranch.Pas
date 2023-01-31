unit BusobjBranch;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  11/02/09  1.00.00  BJ  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TBranch = class(TMSBusObj)
  private
    function GetSiteCode              : string    ;
    function GetSiteDesc              : string    ;
    function GetBEDefault             : Boolean   ;
    function GetEmailCount            : Integer   ;
    function GetSentID                : Integer   ;
    function GetSentStamp             : TDateTime ;
    function GetReceivedID            : Integer   ;
    function GetReceivedStamp         : TDateTime ;
    function GetEmailAddressData      : string    ;
    function GetEmailUsername         : string    ;
    function GetEmailPassword         : string    ;
    function GetConflictTodoUserId    : Integer   ;
    function GetLastPC                : string    ;
    function GetLastUserID            : Integer   ;
    function GetServername            : string    ;
    function GetDatabaseName          : string    ;
    procedure SetSiteCode              (const Value: string    );
    procedure SetSiteDesc              (const Value: string    );
    procedure SetBEDefault             (const Value: Boolean   );
    procedure SetEmailCount            (const Value: Integer   );
    procedure SetSentID                (const Value: Integer   );
    procedure SetSentStamp             (const Value: TDateTime );
    procedure SetReceivedID            (const Value: Integer   );
    procedure SetReceivedStamp         (const Value: TDateTime );
    procedure SetEmailAddressData      (const Value: string    );
    procedure SetEmailUsername         (const Value: string    );
    procedure SetEmailPassword         (const Value: string    );
    procedure SetConflictTodoUserId    (const Value: Integer   );
    procedure SetLastPC                (const Value: string    );
    procedure SetLastUserID            (const Value: Integer   );
    procedure SetServername            (const Value: string    );
    procedure SetDatabaseName          (const Value: string    );
    function getCleanSiteCode: String;
    function Isduplicate:Boolean;
    Procedure BEDefaultCallbak(Const Sender: TBusObj; var Abort: boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    procedure DoFieldOnChange(Sender: TField);                          override;
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property CleanSiteCode:String read getCleanSiteCode;
  published
    property SiteCode               :string      read GetSiteCode             write SetSiteCode          ;
    property SiteDesc               :string      read GetSiteDesc             write SetSiteDesc          ;
    property BEDefault              :Boolean     read GetBEDefault            write SetBEDefault         ;
    property EmailCount             :Integer     read GetEmailCount           write SetEmailCount        ;
    property SentID                 :Integer     read GetSentID               write SetSentID            ;
    property SentStamp              :TDateTime   read GetSentStamp            write SetSentStamp         ;
    property ReceivedID             :Integer     read GetReceivedID           write SetReceivedID        ;
    property ReceivedStamp          :TDateTime   read GetReceivedStamp        write SetReceivedStamp     ;
    property EmailAddressData       :string      read GetEmailAddressData     write SetEmailAddressData  ;
    property EmailUsername          :string      read GetEmailUsername        write SetEmailUsername     ;
    property EmailPassword          :string      read GetEmailPassword        write SetEmailPassword     ;
    property ConflictTodoUserId     :Integer     read GetConflictTodoUserId   write SetConflictTodoUserId;
    property LastPC                 :string      read GetLastPC               write SetLastPC            ;
    property LastUserID             :Integer     read GetLastUserID           write SetLastUserID        ;
    property Servername             :string      read GetServername           write SetServername        ;
    property DatabaseName           :string      read GetDatabaseName         write SetDatabaseName      ;
  end;


implementation


uses tcDataUtils, CommonLib, BusobjDirty, sysutils;



  {TBranch}

constructor TBranch.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Branch';
  fSQL := 'SELECT * FROM tblmsbackendid';
end;


destructor TBranch.Destroy;
begin
  inherited;
end;


procedure TBranch.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'SiteCode');
  SetPropertyFromNode(node,'SiteDesc');
  SetBooleanPropertyFromNode(node,'BEDefault');
  SetPropertyFromNode(node,'EmailCount');
  SetPropertyFromNode(node,'SentID');
  SetDateTimePropertyFromNode(node,'SentStamp');
  SetPropertyFromNode(node,'ReceivedID');
  SetDateTimePropertyFromNode(node,'ReceivedStamp');
  SetPropertyFromNode(node,'EmailAddressData');
  SetPropertyFromNode(node,'EmailUsername');
  SetPropertyFromNode(node,'EmailPassword');
  SetPropertyFromNode(node,'ConflictTodoUserId');
  SetPropertyFromNode(node,'LastPC');
  SetPropertyFromNode(node,'LastUserID');
  SetPropertyFromNode(node,'Servername');
  SetPropertyFromNode(node,'DatabaseName');
end;


procedure TBranch.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'SiteCode' ,SiteCode);
  AddXMLNode(node,'SiteDesc' ,SiteDesc);
  AddXMLNode(node,'BEDefault' ,BEDefault);
  AddXMLNode(node,'EmailCount' ,EmailCount);
  AddXMLNode(node,'SentID' ,SentID);
  AddXMLNode(node,'SentStamp' ,SentStamp);
  AddXMLNode(node,'ReceivedID' ,ReceivedID);
  AddXMLNode(node,'ReceivedStamp' ,ReceivedStamp);
  AddXMLNode(node,'EmailAddressData' ,EmailAddressData);
  AddXMLNode(node,'EmailUsername' ,EmailUsername);
  AddXMLNode(node,'EmailPassword' ,EmailPassword);
  AddXMLNode(node,'ConflictTodoUserId' ,ConflictTodoUserId);
  AddXMLNode(node,'LastPC' ,LastPC);
  AddXMLNode(node,'LastUserID' ,LastUserID);
  AddXMLNode(node,'Servername' ,Servername);
  AddXMLNode(node,'DatabaseName' ,DatabaseName);
end;


function TBranch.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if isduplicate then begin
     ResultStatus.AddItem(False , rssWarning, 0 , 'Site code [' + sitecode +'] already exists');
     Exit;
  end;
  Result := True;
end;


function TBranch.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TBranch.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TBranch.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;
    if Sysutils.SameText(Sender.fieldname , 'BEDefault') then begin
      if not RawMode then begin
        if BEDefault then begin
            Iteraterecords(BEDefaultCallbak);
            BEDefault:= True;
            PostDB;
        end;
      end;
    end
    else if Sysutils.SameText(Sender.fieldname , 'SiteCode') then begin
      if not RawMode then begin
        Sender.AsString:= Uppercase(Sender.AsString);
      end;
    end;
end;


function TBranch.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TBranch.GetIDField: string;
begin
  Result := 'BackEndID'
end;


class function TBranch.GetBusObjectTablename: string;
begin
  Result:= 'tblmsbackendid';
end;


function TBranch.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
  if sitecode= '' then exit;
  (*if not(TDirty.SiteAdded(SiteCode,connection.connection)) then begin
      TDirty.AddSite(SiteCode, connection.Connection);
  end;*)
end;


{Property Functions}
function  TBranch.GetSiteCode          : string    ; begin Result := GetStringField('SiteCode');end;
function  TBranch.GetSiteDesc          : string    ; begin Result := GetStringField('SiteDesc');end;
function  TBranch.GetBEDefault         : Boolean   ; begin Result := GetBooleanField('BEDefault');end;
function  TBranch.GetEmailCount        : Integer   ; begin Result := GetIntegerField('EmailCount');end;
function  TBranch.GetSentID            : Integer   ; begin Result := GetIntegerField('SentID');end;
function  TBranch.GetSentStamp         : TDateTime ; begin Result := GetDateTimeField('SentStamp');end;
function  TBranch.GetReceivedID        : Integer   ; begin Result := GetIntegerField('ReceivedID');end;
function  TBranch.GetReceivedStamp     : TDateTime ; begin Result := GetDateTimeField('ReceivedStamp');end;
function  TBranch.GetEmailAddressData  : string    ; begin Result := GetStringField('EmailAddressData');end;
function  TBranch.GetEmailUsername     : string    ; begin Result := GetStringField('EmailUsername');end;
function  TBranch.GetEmailPassword     : string    ; begin Result := GetStringField('EmailPassword');end;
function  TBranch.GetConflictTodoUserId: Integer   ; begin Result := GetIntegerField('ConflictTodoUserId');end;
function  TBranch.GetLastPC            : string    ; begin Result := GetStringField('LastPC');end;
function  TBranch.GetLastUserID        : Integer   ; begin Result := GetIntegerField('LastUserID');end;
function  TBranch.GetServername        : string    ; begin Result := GetStringField('Servername');end;
function  TBranch.GetDatabaseName      : string    ; begin Result := GetStringField('DatabaseName');end;
procedure TBranch.SetSiteCode          (const Value: string    ); begin SetStringField('SiteCode'           , Value);end;
procedure TBranch.SetSiteDesc          (const Value: string    ); begin SetStringField('SiteDesc'           , Value);end;
procedure TBranch.SetBEDefault         (const Value: Boolean   ); begin SetBooleanField('BEDefault'          , Value);end;
procedure TBranch.SetEmailCount        (const Value: Integer   ); begin SetIntegerField('EmailCount'         , Value);end;
procedure TBranch.SetSentID            (const Value: Integer   ); begin SetIntegerField('SentID'             , Value);end;
procedure TBranch.SetSentStamp         (const Value: TDateTime ); begin SetDateTimeField('SentStamp'          , Value);end;
procedure TBranch.SetReceivedID        (const Value: Integer   ); begin SetIntegerField('ReceivedID'         , Value);end;
procedure TBranch.SetReceivedStamp     (const Value: TDateTime ); begin SetDateTimeField('ReceivedStamp'      , Value);end;
procedure TBranch.SetEmailAddressData  (const Value: string    ); begin SetStringField('EmailAddressData'   , Value);end;
procedure TBranch.SetEmailUsername     (const Value: string    ); begin SetStringField('EmailUsername'      , Value);end;
procedure TBranch.SetEmailPassword     (const Value: string    ); begin SetStringField('EmailPassword'      , Value);end;
procedure TBranch.SetConflictTodoUserId(const Value: Integer   ); begin SetIntegerField('EmailPassword'      , Value);end;
procedure TBranch.SetLastPC            (const Value: string    ); begin SetStringField('LastPC'             , Value);end;
procedure TBranch.SetLastUserID        (const Value: Integer   ); begin SetIntegerField('LastUserID'         , Value);end;
procedure TBranch.SetServername        (const Value: string    ); begin SetStringField('Servername'         , Value);end;
procedure TBranch.SetDatabaseName      (const Value: string    ); begin SetStringField('DatabaseName'       , Value);end;


function TBranch.getCleanSiteCode: String;
begin
  result:= GetXMLNodeStringValue(CleanXMLNode, 'siteCode');
end;

function TBranch.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not result then exit;
  if Isduplicate then begin
    ResultStatus.AddItem(False , rssWarning, 0 , 'Site code [' + sitecode +'] already exists');
    Abort;
  end;

end;

function TBranch.Isduplicate: Boolean;
begin
  With getNewDataset('SELECT BackEndID FROM tblmsbackendid Where BackEndID <> ' + IntToStr(ID) + ' and SiteCode = ' +quotedStr(SiteCode) , true) do try
    Result := Recordcount >0;
  finally
    if active then close;
    Free;
  end;
end;

procedure TBranch.BEDefaultCallbak(const Sender: TBusObj;
  var Abort: boolean);
begin
  if not (sender is TBranch) then Exit;
  TBranch(SendeR).BEDefault := False;
  TBranch(SendeR).PostDB;
end;

initialization
  RegisterClass(TBranch);


end.
