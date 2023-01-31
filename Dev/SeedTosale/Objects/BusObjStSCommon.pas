unit BusObjStSCommon;

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;

Type
  TStSClass = class(TMSBusObj)
  private
    fsDefaultBinLocation       : string    ;
    fsDefaultBinNumber         : string    ;
    function GetClassId                  : Integer   ;
    function GetPrincipleContactID       : Integer   ;
    function GetDefaultStSBinID          : Integer   ;
    function GetPrincipleContact         : string    ;
    function GetPrincipleContactPhone    : string    ;
    function GetLicenseNumber            : string    ;
    function GetDefaultBinLocation       : string    ;
    function GetDefaultBinNumber         : string    ;
    function GetPrincipleContactName     : string    ;
    procedure SetClassId                  (const Value: Integer   );
    procedure SetPrincipleContactID       (const Value: Integer   );
    procedure SetDefaultStSBinID          (const Value: Integer   );
    procedure SetPrincipleContact         (const Value: string    );
    procedure SetPrincipleContactPhone    (const Value: string    );
    procedure SetLicenseNumber            (const Value: string    );
    procedure SetDefaultBinLocation       (const Value: string    );
    procedure SetDefaultBinNumber         (const Value: string    );
    procedure SetPrincipleContactName     (const Value: string    );
    procedure initDefaultStSBinID;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    DoFieldOnChange(Sender: TField);                          override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Class Function DefaultStSBinIDForDept(AOwner:TComponent; aClassID:Integer):Integer;
  published
    property ClassId                   :Integer     read GetClassId                 write SetClassId              ;
    property PrincipleContactID        :Integer     read GetPrincipleContactID      write SetPrincipleContactID   ;
    property DefaultStSBinID           :Integer     read GetDefaultStSBinID         write SetDefaultStSBinID      ;
    property PrincipleContact          :string      read GetPrincipleContact        write SetPrincipleContact     ;
    property PrincipleContactPhone     :string      read GetPrincipleContactPhone   write SetPrincipleContactPhone;
    property LicenseNumber             :string      read GetLicenseNumber           write SetLicenseNumber        ;
    property DefaultBinLocation        :string      read GetDefaultBinLocation      write SetDefaultBinLocation   ;
    property DefaultBinNumber          :string      read GetDefaultBinNumber        write SetDefaultBinNumber     ;
    property PrincipleContactName      :string      read GetPrincipleContactName    write SetPrincipleContactName ;
  end;


implementation


uses tcDataUtils, CommonLib, sysutils, BusObjProductbin, BusObjClass,
  BusObjEmployee;



  {TStSClass}

constructor TStSClass.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'sts_class';
  fSQL := 'SELECT * FROM tblstsclass';
  fsDefaultBinLocation  := '';
  fsDefaultBinNumber    := '';
end;


class function TStSClass.DefaultStSBinIDForDept(AOwner: TComponent;aClassID: Integer): Integer;
var
  aStSClass: TStSClass;
begin
  aStSClass:= TStSClass.CreateWithNewConn(AOwner);
  try
    aStSClass.loadselect('Classid =' + inttostr(aClassID));
    result := aStSClass.DefaultStSBinID;
  finally
    Freeandnil(aStSClass);
  end;
end;

destructor TStSClass.Destroy;
begin
  inherited;
end;


procedure TStSClass.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ClassId');
  SetPropertyFromNode(node,'PrincipleContactID');
  SetPropertyFromNode(node,'DefaultStSBinID');
  SetPropertyFromNode(node,'PrincipleContact');
  SetPropertyFromNode(node,'PrincipleContactPhone');
  SetPropertyFromNode(node,'LicenseNumber');
  SetPropertyFromNode(node,'DefaultBinLocation');
  SetPropertyFromNode(node,'DefaultBinNumber');
  SetPropertyFromNode(node,'PrincipleContactName');
end;


procedure TStSClass.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ClassId' ,ClassId);
  AddXMLNode(node,'PrincipleContactID' ,PrincipleContactID);
  AddXMLNode(node,'DefaultStSBinID' ,DefaultStSBinID);
  AddXMLNode(node,'PrincipleContact' ,PrincipleContact);
  AddXMLNode(node,'PrincipleContactPhone' ,PrincipleContactPhone);
  AddXMLNode(node,'LicenseNumber' ,LicenseNumber);
  AddXMLNode(node,'DefaultBinLocation' ,DefaultBinLocation);
  AddXMLNode(node,'DefaultBinNumber' ,DefaultBinNumber);
  AddXMLNode(node,'PrincipleContactName' ,PrincipleContactName);
end;


function TStSClass.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if ClassId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'ClassId should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TStSClass.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TStSClass.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  fsDefaultBinLocation  := '';
  fsDefaultBinNumber    := '';
end;


procedure TStSClass.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TStSClass.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TStSClass.GetIDField: string;
begin
  Result := 'ID'
end;


class function TStSClass.GetBusObjectTablename: string;
begin
  Result:= 'tblstsclass';
end;


function TStSClass.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if owner is TDeptClass then
      ClassId := TDeptClass (Owner).ID;
end;

function TStSClass.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TStSClass.GetClassId              : Integer   ; begin Result := GetIntegerField('ClassId');end;
function  TStSClass.GetPrincipleContactID   : Integer   ; begin Result := GetIntegerField('PrincipleContactID');end;
function  TStSClass.GetDefaultStSBinID      : Integer   ; begin Result := GetIntegerField('DefaultStSBinID');end;
function  TStSClass.GetPrincipleContact     : string    ; begin Result := GetStringField('PrincipleContact');end;
function  TStSClass.GetPrincipleContactPhone: string    ; begin Result := GetStringField('PrincipleContactPhone');end;
function  TStSClass.GetLicenseNumber        : string    ; begin Result := GetStringField('LicenseNumber');end;
function  TStSClass.GetDefaultBinLocation   : string    ; begin Result := tcdatautils.GetBinLocation(DefaultStSBinID);end;
function  TStSClass.GetDefaultBinNumber     : string    ; begin Result := tcdatautils.GetBinnumber(DefaultStSBinID);end;
function  TStSClass.GetPrincipleContactName : string    ; begin Result := TEmployee.EmployeeNameForID(PrincipleContactID);end;
procedure TStSClass.SetClassId              (const Value: Integer   ); begin SetIntegerField('ClassId'               , Value);end;
procedure TStSClass.SetPrincipleContactID   (const Value: Integer   ); begin SetIntegerField('PrincipleContactID'    , Value);end;
procedure TStSClass.SetDefaultStSBinID      (const Value: Integer   ); begin SetIntegerField('DefaultStSBinID'       , Value);end;
procedure TStSClass.SetPrincipleContact     (const Value: string    ); begin SetStringField('PrincipleContact'      , Value);end;
procedure TStSClass.SetPrincipleContactPhone(const Value: string    ); begin SetStringField('PrincipleContactPhone' , Value);end;
procedure TStSClass.SetLicenseNumber        (const Value: string    ); begin SetStringField('LicenseNumber'         , Value);end;
procedure TStSClass.SetDefaultBinLocation   (const Value: string    ); begin fsDefaultBinLocation := value; initDefaultStSBinID; end;
procedure TStSClass.SetDefaultBinNumber     (const Value: string    ); begin fsDefaultBinNumber   := value; initDefaultStSBinID;end;
procedure TStSClass.SetPrincipleContactName (const Value: string    ); begin PrincipleContactID:= tcdatautils.getemployeeID(Value);end;
procedure TStSClass.initDefaultStSBinID;
begin
  if (trim(fsDefaultBinLocation) <> '') and (trim(fsDefaultBinNumber)<> '') then begin
    DefaultStSBinID  :=   GetBinID(fsDefaultBinLocation, fsDefaultBinNumber, classid);
    if (DefaultStSBinID =0) then
      DefaultStSBinID:= TProductBin.MakebinforClass(self, classid, fsDefaultBinLocation, fsDefaultBinNumber,1 );
  end;
end;
initialization
  RegisterClass(TStSClass);


end.

