unit BusObjclientHRForms;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  07/02/17  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TClientHrForms = class(TMSBusObj)
  private
    function GetClientId            : Integer   ;
    function GetHRformID            : Integer   ;
    function GetHRFormname          : string    ;
    function GetTemplateName        : string    ;
    function GetPrintedOn           : TDateTime ;
    function GetPrintedBy           : Integer   ;
    procedure SetClientId            (const Value: Integer   );
    procedure SetHRformID            (const Value: Integer   );
    procedure SetHRFormname          (const Value: string    );
    procedure SetTemplateName        (const Value: string    );
    procedure SetPrintedOn           (const Value: TDateTime );
    procedure SetPrintedBy           (const Value: Integer   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
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
    property ClientId             :Integer     read GetClientId           write SetClientId        ;
    property HRformID             :Integer     read GetHRformID           write SetHRformID        ;
    property HRFormname           :string      read GetHRFormname         write SetHRFormname      ;
    property TemplateName         :string      read GetTemplateName       write SetTemplateName    ;
    property PrintedOn            :TDateTime   read GetPrintedOn          write SetPrintedOn       ;
    property PrintedBy            :Integer     read GetPrintedBy          write SetPrintedBy       ;
  end;


implementation


uses tcDataUtils, CommonLib, AppEnvironment ,SysUtils;



  {TClientHrForms}

constructor TClientHrForms.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ClientHrForms';
  fSQL := 'SELECT * FROM tblClienthrforms';
end;


destructor TClientHrForms.Destroy;
begin
  inherited;
end;


procedure TClientHrForms.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'HRformID');
  SetPropertyFromNode(node,'ClientId');
  SetPropertyFromNode(node,'HRFormname');
  SetPropertyFromNode(node,'TemplateName');
  SetDateTimePropertyFromNode(node,'PrintedOn');
  SetPropertyFromNode(node,'PrintedBy');
end;


procedure TClientHrForms.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'HRformID' ,HRformID);
  AddXMLNode(node,'ClientId' ,ClientId);
  AddXMLNode(node,'HRFormname' ,HRFormname);
  AddXMLNode(node,'TemplateName' ,TemplateName);
  AddXMLNode(node,'PrintedOn' ,PrintedOn);
  AddXMLNode(node,'PrintedBy' ,PrintedBy);
end;


function TClientHrForms.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if HRformID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'HRform should be Selcted' , False );
    Exit;
  end;
  if ClientId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Client should be Selected' , False );
    Exit;
  end;
  if PrintedBy = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'PrintedBy should not be Blank' , False );
    Exit;
  end;
  Result := True;
end;


function TClientHrForms.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TClientHrForms.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TClientHrForms.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TClientHrForms.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TClientHrForms.GetIDField: string;
begin
  Result := 'ID'
end;


class function TClientHrForms.GetBusObjectTablename: string;
begin
  Result:= 'tblClienthrforms';
end;


function TClientHrForms.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not(result) then exit;
  PrintedOn := now;
  PrintedBy := Appenv.Employee.EmployeeId;
end;

function TClientHrForms.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TClientHrForms.GetHRformID        : Integer   ; begin Result := GetIntegerField('HRformID');end;
function  TClientHrForms.GetClientId      : Integer   ; begin Result := GetIntegerField('ClientId');end;
function  TClientHrForms.GetHRFormname      : string    ; begin Result := GetStringField('HRFormname');end;
function  TClientHrForms.GetTemplateName    : string    ; begin Result := GetStringField('TemplateName');end;
function  TClientHrForms.GetPrintedOn       : TDateTime ; begin Result := GetDateTimeField('PrintedOn');end;
function  TClientHrForms.GetPrintedBy       : Integer   ; begin Result := GetIntegerField('PrintedBy');end;
procedure TClientHrForms.SetHRformID        (const Value: Integer   ); begin SetIntegerField('HRformID'         , Value);end;
procedure TClientHrForms.SetClientId      (const Value: Integer   ); begin SetIntegerField('ClientId'       , Value);end;
procedure TClientHrForms.SetHRFormname      (const Value: string    ); begin SetStringField('HRFormname'       , Value);end;
procedure TClientHrForms.SetTemplateName    (const Value: string    ); begin SetStringField('TemplateName'     , Value);end;
procedure TClientHrForms.SetPrintedOn       (const Value: TDateTime ); begin SetDateTimeField('PrintedOn'        , Value);end;
procedure TClientHrForms.SetPrintedBy       (const Value: Integer   ); begin SetIntegerField('PrintedBy'        , Value);end;


initialization
  RegisterClass(TClientHrForms);


end.
