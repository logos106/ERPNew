unit BusObjCustomData;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  15/09/08  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, ALXMLDoc;


type
  TCustomData = class(TMSBusObj)
  private
    function GetObjectName      : string    ;
    function GetObjectId        : Integer   ;
    function GetField1          : string    ;
    function GetField2          : string    ;
    function GetField3          : string    ;
    function GetField4          : string    ;
    function GetField5          : string    ;
    function GetField6          : string    ;
    function GetField7          : string    ;
    function GetField8          : string    ;
    function GetField9          : string    ;
    function GetField10         : string    ;
    procedure SetObjectName      (const Value: string    );
    procedure SetObjectId        (const Value: Integer   );
    procedure SetField1          (const Value: string    );
    procedure SetField2          (const Value: string    );
    procedure SetField3          (const Value: string    );
    procedure SetField4          (const Value: string    );
    procedure SetField5          (const Value: string    );
    procedure SetField6          (const Value: string    );
    procedure SetField7          (const Value: string    );
    procedure SetField8          (const Value: string    );
    procedure SetField9          (const Value: string    );
    procedure SetField10         (const Value: string    );
  protected
    procedure OnDataIDChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: TALXMLNode);                 override;
    procedure    SaveToXMLNode(const node: TALXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property ObjectName       :string      read GetObjectName     write SetObjectName  ;
    property ObjectId         :Integer     read GetObjectId       write SetObjectId    ;
    property Field1           :string      read GetField1         write SetField1      ;
    property Field2           :string      read GetField2         write SetField2      ;
    property Field3           :string      read GetField3         write SetField3      ;
    property Field4           :string      read GetField4         write SetField4      ;
    property Field5           :string      read GetField5         write SetField5      ;
    property Field6           :string      read GetField6         write SetField6      ;
    property Field7           :string      read GetField7         write SetField7      ;
    property Field8           :string      read GetField8         write SetField8      ;
    property Field9           :string      read GetField9         write SetField9      ;
    property Field10          :string      read GetField10        write SetField10     ;
  end;


implementation


uses tcDataUtils, CommonLib;



  {TCustomData}

constructor TCustomData.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'CustomData';
  fSQL := 'SELECT * FROM tblcustomdata';
end;


destructor TCustomData.Destroy;
begin
  inherited;
end;


procedure TCustomData.LoadFromXMLNode(const node: TALXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ObjectName');
  SetPropertyFromNode(node,'ObjectId');
  SetPropertyFromNode(node,'Field1');
  SetPropertyFromNode(node,'Field2');
  SetPropertyFromNode(node,'Field3');
  SetPropertyFromNode(node,'Field4');
  SetPropertyFromNode(node,'Field5');
  SetPropertyFromNode(node,'Field6');
  SetPropertyFromNode(node,'Field7');
  SetPropertyFromNode(node,'Field8');
  SetPropertyFromNode(node,'Field9');
  SetPropertyFromNode(node,'Field10');
end;


procedure TCustomData.SaveToXMLNode(Const node: TALXMLNode);
begin
  inherited;
  AddXMLNode(node,'ObjectName' ,ObjectName);
  AddXMLNode(node,'ObjectId' ,ObjectId);
  AddXMLNode(node,'Field1' ,Field1);
  AddXMLNode(node,'Field2' ,Field2);
  AddXMLNode(node,'Field3' ,Field3);
  AddXMLNode(node,'Field4' ,Field4);
  AddXMLNode(node,'Field5' ,Field5);
  AddXMLNode(node,'Field6' ,Field6);
  AddXMLNode(node,'Field7' ,Field7);
  AddXMLNode(node,'Field8' ,Field8);
  AddXMLNode(node,'Field9' ,Field9);
  AddXMLNode(node,'Field10' ,Field10);
end;


function TCustomData.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if ObjectId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'ObjectId should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TCustomData.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TCustomData.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TCustomData.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TCustomData.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TCustomData.GetIDField: string;
begin
  Result := 'CustomDataId'
end;


class function TCustomData.GetBusObjectTablename: string;
begin
  Result:= 'tblcustomdata';
end;


function TCustomData.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TCustomData.GetObjectName  : string    ; begin Result := GetStringField('ObjectName');end;
function  TCustomData.GetObjectId    : Integer   ; begin Result := GetIntegerField('ObjectId');end;
function  TCustomData.GetField1      : string    ; begin Result := GetStringField('Field1');end;
function  TCustomData.GetField2      : string    ; begin Result := GetStringField('Field2');end;
function  TCustomData.GetField3      : string    ; begin Result := GetStringField('Field3');end;
function  TCustomData.GetField4      : string    ; begin Result := GetStringField('Field4');end;
function  TCustomData.GetField5      : string    ; begin Result := GetStringField('Field5');end;
function  TCustomData.GetField6      : string    ; begin Result := GetStringField('Field6');end;
function  TCustomData.GetField7      : string    ; begin Result := GetStringField('Field7');end;
function  TCustomData.GetField8      : string    ; begin Result := GetStringField('Field8');end;
function  TCustomData.GetField9      : string    ; begin Result := GetStringField('Field9');end;
function  TCustomData.GetField10     : string    ; begin Result := GetStringField('Field10');end;
procedure TCustomData.SetObjectName  (const Value: string    ); begin SetStringField('ObjectName'   , Value);end;
procedure TCustomData.SetObjectId    (const Value: Integer   ); begin SetIntegerField('ObjectId'     , Value);end;
procedure TCustomData.SetField1      (const Value: string    ); begin SetStringField('Field1'       , Value);end;
procedure TCustomData.SetField2      (const Value: string    ); begin SetStringField('Field2'       , Value);end;
procedure TCustomData.SetField3      (const Value: string    ); begin SetStringField('Field3'       , Value);end;
procedure TCustomData.SetField4      (const Value: string    ); begin SetStringField('Field4'       , Value);end;
procedure TCustomData.SetField5      (const Value: string    ); begin SetStringField('Field5'       , Value);end;
procedure TCustomData.SetField6      (const Value: string    ); begin SetStringField('Field6'       , Value);end;
procedure TCustomData.SetField7      (const Value: string    ); begin SetStringField('Field7'       , Value);end;
procedure TCustomData.SetField8      (const Value: string    ); begin SetStringField('Field8'       , Value);end;
procedure TCustomData.SetField9      (const Value: string    ); begin SetStringField('Field9'       , Value);end;
procedure TCustomData.SetField10     (const Value: string    ); begin SetStringField('Field10'      , Value);end;


initialization
  RegisterClassOnce(TCustomData);


end.
