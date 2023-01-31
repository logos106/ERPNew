unit BusObjEmployeeServices;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  26/09/08  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TEmployeeServices = class(TMSBusObj)
  private
    fCurrentEmployeeID             : integer;
    ignoreRateValidation:Boolean;
    function GetEmployeeID         : Integer   ;
    function GetServiceName        : string    ;
    function GetRate               : Double    ;
    function GetActive             : Boolean   ;
    function GetIsFixed            : Boolean   ;
    function GetPartName           : string    ;
    function GetPartID             : Integer   ;
    function GetPartDescription    : string    ;
    procedure SetEmployeeID         (const Value: Integer   );
    procedure SetServiceName        (const Value: string    );
    procedure SetRate               (const Value: Double    );
    procedure SetActive             (const Value: Boolean   );
    procedure SetIsFixed            (const Value: Boolean   );
    procedure SetPartName           (const Value: string    );
    procedure SetPartID             (const Value: Integer   );
    procedure SetPartDescription    (const Value: string    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;           Override;
    function  DoBeforePost(Sender: TDatasetBusObj): boolean; Override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    property CurrentEmployeeID : integer read fCurrentEmployeeID write fCurrentEmployeeID;
    Class Function AddService(const fsServiceName:String; fiEmployeeID, fiPartsID:Integer):Integer;
  published
    property EmployeeID          :Integer     read GetEmployeeID        write SetEmployeeID     ;
    property ServiceName         :string      read GetServiceName       write SetServiceName    ;
    property Rate                :Double      read GetRate              write SetRate           ;
    property Active              :Boolean     read GetActive            write SetActive         ;
    property IsFixed             :Boolean     read GetIsFixed           write SetIsFixed        ;
    property PartName            :string      read GetPartName          write SetPartName       ;
    property PartID              :Integer     read GetPartID            write SetPartID         ;
    property PartDescription     :string      read GetPartDescription   write SetPartDescription;
  end;

implementation

uses tcDataUtils, CommonLib,BusObjConst,SysUtils;

  {TEmployeeServices}

constructor TEmployeeServices.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ignoreRateValidation:= False;
  fBusObjectTypeDescription:= 'EmployeeServices';
  fSQL := 'SELECT * FROM tblpaysemployeeservices';
end;
Class Function TEmployeeServices.AddService(const fsServiceName:String; fiEmployeeID, fiPartsID:Integer):Integer;
begin
  With TEmployeeServices.CreateWithNewConn(nil) do try
    Loadselect('EmployeeID =' + inttostr(fiEmployeeID) +' and ServiceName =' + Quotedstr(fsServiceName));
    if count =0 then begin
      New;
      EmployeeID:= fiEmployeeId;
      ServiceName := fsServiceName;
      Rate := ServiceStandardRate(ServiceName);
      PartID := fiPartsID;
      Active:= True;
      IsFixed:= False;
      ignoreRateValidation:= TRue;
      PostDB;
    end;
    Result:= Id;
  finally
    Free;
  end;
end;
procedure TEmployeeServices.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;

  if Sysutils.SameText(Sender.FieldName , 'PartID') then begin
    PartName := tcdatautils.GetProduct(PartID);
    PartDescription :=tcdatautils.GetProductDescription(PartID);
  end;

end;


destructor TEmployeeServices.Destroy;
begin
  inherited;
end;


procedure TEmployeeServices.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'ServiceName');
  SetPropertyFromNode(node,'Rate');
  SetBooleanPropertyFromNode(node,'Active');
  SetBooleanPropertyFromNode(node,'IsFixed');
  SetPropertyFromNode(node,'PartName');
  SetPropertyFromNode(node,'PartID');
  SetPropertyFromNode(node,'PartDescription');
end;


procedure TEmployeeServices.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'ServiceName' ,ServiceName);
  AddXMLNode(node,'Rate' ,Rate);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'IsFixed' ,IsFixed);
  AddXMLNode(node,'PartName' ,PartName);
  AddXMLNode(node,'PartID' ,PartID);
  AddXMLNode(node,'PartDescription' ,PartDescription);
end;


function TEmployeeServices.ValidateData: Boolean ;
var
  tmpResultStatus: TResultStatusItem;
begin
  Result := False;
  Resultstatus.Clear;
  if Self.Count = 0 then begin
    Result := True;
    exit;
  end;

  try
    if ServiceName = '' then begin
      Resultstatus.AddItem(False , rssError , BOR_No_EmpService_Name,  'Enter a Service Name.');
      Exit;
    end;
    if PartID = 0 then begin
      Resultstatus.AddItem(False , rssError , BOR_No_EmpService_Part,  'Select a Part'  );
      Exit;
    end;
    if ignoreRateValidation = False then
      if Rate = 0 then begin
        Resultstatus.AddItem(False , rssError , BOR_No_EmpService_Rate,  'Select a Rate.'  );
        Exit;
      end;
    Result := True;
  finally
    If not Result then Begin
      tmpResultStatus := ResultStatus.GetLastStatusItem;
      if Assigned(tmpResultStatus) then
        SendEvent(IntToStr(tmpResultStatus.Code),BusobjEventVal_FailedEmpServicesValidateData);
    end;
  end;
end;

function TEmployeeServices.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TEmployeeServices.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;



function TEmployeeServices.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TEmployeeServices.GetIDField: string;
begin
  Result := 'ID'
end;


class function TEmployeeServices.GetBusObjectTablename: string;
begin
  Result:= 'tblpaysemployeeservices';
end;


function TEmployeeServices.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

Function  TEmployeeServices.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    if CurrentEmployeeID <> 0 then EmployeeID := CurrentEmployeeID;
    Result := inherited DoAfterInsert(Sender);
end;

Function  TEmployeeServices.DoBeforePost(Sender :TDatasetBusObj ):Boolean;
begin
    if not ValidateData then begin
      Result := False;
      Abort;
    end else Result := inherited DoBeforeInsert(Sender);
end;

{Property Functions}
function  TEmployeeServices.GetEmployeeID     : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
function  TEmployeeServices.GetServiceName    : string    ; begin Result := GetStringField('ServiceName');end;
function  TEmployeeServices.GetRate           : Double    ; begin Result := GetFloatField('Rate');end;
function  TEmployeeServices.GetActive         : Boolean   ; begin Result := GetBooleanField('Active');end;
function  TEmployeeServices.GetIsFixed        : Boolean   ; begin Result := GetBooleanField('IsFixed');end;
function  TEmployeeServices.GetPartName       : string    ; begin Result := GetStringField('PartName');end;
function  TEmployeeServices.GetPartID         : Integer   ; begin Result := GetIntegerField('PartID');end;
function  TEmployeeServices.GetPartDescription: string    ; begin Result := GetStringField('PartDescription');end;
procedure TEmployeeServices.SetEmployeeID     (const Value: Integer   ); begin SetIntegerField('EmployeeID'      , Value);end;
procedure TEmployeeServices.SetServiceName    (const Value: string    ); begin SetStringField('ServiceName'     , Value);end;
procedure TEmployeeServices.SetRate           (const Value: Double    ); begin SetFloatField('Rate'            , Value);end;
procedure TEmployeeServices.SetActive         (const Value: Boolean   ); begin SetBooleanField('Active'          , Value);end;
procedure TEmployeeServices.SetIsFixed        (const Value: Boolean   ); begin SetBooleanField('IsFixed'         , Value);end;
procedure TEmployeeServices.SetPartName       (const Value: string    ); begin SetStringField('PartName'        , Value);end;
procedure TEmployeeServices.SetPartID         (const Value: Integer   ); begin SetIntegerField('PartID'          , Value);end;
procedure TEmployeeServices.SetPartDescription(const Value: string    ); begin SetStringField('PartDescription'          , Value);end;


initialization
  RegisterClass(TEmployeeServices);


end.
