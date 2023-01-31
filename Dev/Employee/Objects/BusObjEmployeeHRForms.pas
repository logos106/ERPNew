unit BusObjEmployeeHRForms;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  07/02/17  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TEmployeeHrForms = class(TMSBusObj)
  private
    function GetEmployeeId          : Integer   ;
    function GetHRformID            : Integer   ;
    function GetHRFormname          : string    ;
    function GetTemplateName        : string    ;
    function GetPrintedOn           : TDateTime ;
    function GetPrintedBy           : Integer   ;
    procedure SetEmployeeId          (const Value: Integer   );
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
    property EmployeeId           :Integer     read GetEmployeeId         write SetEmployeeId      ;
    property HRformID             :Integer     read GetHRformID           write SetHRformID        ;
    property HRFormname           :string      read GetHRFormname         write SetHRFormname      ;
    property TemplateName         :string      read GetTemplateName       write SetTemplateName    ;
    property PrintedOn            :TDateTime   read GetPrintedOn          write SetPrintedOn       ;
    property PrintedBy            :Integer     read GetPrintedBy          write SetPrintedBy       ;
  end;


implementation


uses tcDataUtils, CommonLib, AppEnvironment, SysUtils;



  {TEmployeeHrForms}

constructor TEmployeeHrForms.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'EmployeeHrForms';
  fSQL := 'SELECT * FROM tblemployeehrforms';
end;


destructor TEmployeeHrForms.Destroy;
begin
  inherited;
end;


procedure TEmployeeHrForms.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'HRformID');
  SetPropertyFromNode(node,'EmployeeId');
  SetPropertyFromNode(node,'HRFormname');
  SetPropertyFromNode(node,'TemplateName');
  SetDateTimePropertyFromNode(node,'PrintedOn');
  SetPropertyFromNode(node,'PrintedBy');
end;


procedure TEmployeeHrForms.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'HRformID' ,HRformID);
  AddXMLNode(node,'EmployeeId' ,EmployeeId);
  AddXMLNode(node,'HRFormname' ,HRFormname);
  AddXMLNode(node,'TemplateName' ,TemplateName);
  AddXMLNode(node,'PrintedOn' ,PrintedOn);
  AddXMLNode(node,'PrintedBy' ,PrintedBy);
end;


function TEmployeeHrForms.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if HRformID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'HRform should be Selcted' , False );
    Exit;
  end;
  if EmployeeId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Employee should be Selected' , False );
    Exit;
  end;
  if PrintedBy = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'PrintedBy should not be Blank' , False );
    Exit;
  end;
  Result := True;
end;


function TEmployeeHrForms.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TEmployeeHrForms.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TEmployeeHrForms.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TEmployeeHrForms.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TEmployeeHrForms.GetIDField: string;
begin
  Result := 'ID'
end;


class function TEmployeeHrForms.GetBusObjectTablename: string;
begin
  Result:= 'tblemployeehrforms';
end;


function TEmployeeHrForms.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not(result) then exit;
  PrintedOn := now;
  PrintedBy := Appenv.Employee.employeeId;
end;

function TEmployeeHrForms.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TEmployeeHrForms.GetHRformID        : Integer   ; begin Result := GetIntegerField('HRformID');end;
function  TEmployeeHrForms.GetEmployeeId      : Integer   ; begin Result := GetIntegerField('EmployeeId');end;
function  TEmployeeHrForms.GetHRFormname      : string    ; begin Result := GetStringField('HRFormname');end;
function  TEmployeeHrForms.GetTemplateName    : string    ; begin Result := GetStringField('TemplateName');end;
function  TEmployeeHrForms.GetPrintedOn       : TDateTime ; begin Result := GetDateTimeField('PrintedOn');end;
function  TEmployeeHrForms.GetPrintedBy       : Integer   ; begin Result := GetIntegerField('PrintedBy');end;
procedure TEmployeeHrForms.SetHRformID        (const Value: Integer   ); begin SetIntegerField('HRformID'         , Value);end;
procedure TEmployeeHrForms.SetEmployeeId      (const Value: Integer   ); begin SetIntegerField('EmployeeId'       , Value);end;
procedure TEmployeeHrForms.SetHRFormname      (const Value: string    ); begin SetStringField('HRFormname'       , Value);end;
procedure TEmployeeHrForms.SetTemplateName    (const Value: string    ); begin SetStringField('TemplateName'     , Value);end;
procedure TEmployeeHrForms.SetPrintedOn       (const Value: TDateTime ); begin SetDateTimeField('PrintedOn'        , Value);end;
procedure TEmployeeHrForms.SetPrintedBy       (const Value: Integer   ); begin SetIntegerField('PrintedBy'        , Value);end;


initialization
  RegisterClass(TEmployeeHrForms);


end.
