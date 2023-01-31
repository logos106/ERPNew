unit BusObjCustomDataConfig;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  15/09/08  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, ALXMLDoc;


type

//  TCustomDataFieldTypes = (Text, Boolean, Integer, Float, Date);

  TCustomDataConfig = class(TMSBusObj)
  private
    function GetObjectName            : string    ;
    function GetField1Caption         : string    ;
    function GetField1Active          : Boolean   ;
    function GetField1Required        : Boolean   ;
    function GetField1Type            : string    ;
    function GetField1Values          : string    ;
    function GetField2Caption         : string    ;
    function GetField2Active          : Boolean   ;
    function GetField2Required        : Boolean   ;
    function GetField2Type            : string    ;
    function GetField2Values          : string    ;
    function GetField3Caption         : string    ;
    function GetField3Active          : Boolean   ;
    function GetField3Required        : Boolean   ;
    function GetField3Type            : string    ;
    function GetField3Values          : string    ;
    function GetField4Caption         : string    ;
    function GetField4Active          : Boolean   ;
    function GetField4Required        : Boolean   ;
    function GetField4Type            : string    ;
    function GetField4Values          : string    ;
    function GetField5Caption         : string    ;
    function GetField5Active          : Boolean   ;
    function GetField5Required        : Boolean   ;
    function GetField5Type            : string    ;
    function GetField5Values          : string    ;
    function GetField6Caption         : string    ;
    function GetField6Active          : Boolean   ;
    function GetField6Required        : Boolean   ;
    function GetField6Type            : string    ;
    function GetField6Values          : string    ;
    function GetField7Caption         : string    ;
    function GetField7Active          : Boolean   ;
    function GetField7Required        : Boolean   ;
    function GetField7Type            : string    ;
    function GetField7Values          : string    ;
    function GetField8Caption         : string    ;
    function GetField8Active          : Boolean   ;
    function GetField8Required        : Boolean   ;
    function GetField8Type            : string    ;
    function GetField8Values          : string    ;
    function GetField9Caption         : string    ;
    function GetField9Active          : Boolean   ;
    function GetField9Required        : Boolean   ;
    function GetField9Type            : string    ;
    function GetField9Values          : string    ;
    function GetField10Caption        : string    ;
    function GetField10Active         : Boolean   ;
    function GetField10Required       : Boolean   ;
    function GetField10Type           : string    ;
    function GetField10Values         : string    ;
    procedure SetObjectName            (const Value: string    );
    procedure SetField1Caption         (const Value: string    );
    procedure SetField1Active          (const Value: Boolean   );
    procedure SetField1Required        (const Value: Boolean   );
    procedure SetField1Type            (const Value: string    );
    procedure SetField1Values          (const Value: string    );
    procedure SetField2Caption         (const Value: string    );
    procedure SetField2Active          (const Value: Boolean   );
    procedure SetField2Required        (const Value: Boolean   );
    procedure SetField2Type            (const Value: string    );
    procedure SetField2Values          (const Value: string    );
    procedure SetField3Caption         (const Value: string    );
    procedure SetField3Active          (const Value: Boolean   );
    procedure SetField3Required        (const Value: Boolean   );
    procedure SetField3Type            (const Value: string    );
    procedure SetField3Values          (const Value: string    );
    procedure SetField4Caption         (const Value: string    );
    procedure SetField4Active          (const Value: Boolean   );
    procedure SetField4Required        (const Value: Boolean   );
    procedure SetField4Type            (const Value: string    );
    procedure SetField4Values          (const Value: string    );
    procedure SetField5Caption         (const Value: string    );
    procedure SetField5Active          (const Value: Boolean   );
    procedure SetField5Required        (const Value: Boolean   );
    procedure SetField5Type            (const Value: string    );
    procedure SetField5Values          (const Value: string    );
    procedure SetField6Caption         (const Value: string    );
    procedure SetField6Active          (const Value: Boolean   );
    procedure SetField6Required        (const Value: Boolean   );
    procedure SetField6Type            (const Value: string    );
    procedure SetField6Values          (const Value: string    );
    procedure SetField7Caption         (const Value: string    );
    procedure SetField7Active          (const Value: Boolean   );
    procedure SetField7Required        (const Value: Boolean   );
    procedure SetField7Type            (const Value: string    );
    procedure SetField7Values          (const Value: string    );
    procedure SetField8Caption         (const Value: string    );
    procedure SetField8Active          (const Value: Boolean   );
    procedure SetField8Required        (const Value: Boolean   );
    procedure SetField8Type            (const Value: string    );
    procedure SetField8Values          (const Value: string    );
    procedure SetField9Caption         (const Value: string    );
    procedure SetField9Active          (const Value: Boolean   );
    procedure SetField9Required        (const Value: Boolean   );
    procedure SetField9Type            (const Value: string    );
    procedure SetField9Values          (const Value: string    );
    procedure SetField10Caption        (const Value: string    );
    procedure SetField10Active         (const Value: Boolean   );
    procedure SetField10Required       (const Value: Boolean   );
    procedure SetField10Type           (const Value: string    );
    procedure SetField10Values         (const Value: string    );
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
    property ObjectName             :string      read GetObjectName           write SetObjectName        ;
    property Field1Caption          :string      read GetField1Caption        write SetField1Caption     ;
    property Field1Active           :Boolean     read GetField1Active         write SetField1Active      ;
    property Field1Required         :Boolean     read GetField1Required       write SetField1Required    ;
    property Field1Type             :string      read GetField1Type           write SetField1Type        ;
    property Field1Values           :string      read GetField1Values         write SetField1Values      ;
    property Field2Caption          :string      read GetField2Caption        write SetField2Caption     ;
    property Field2Active           :Boolean     read GetField2Active         write SetField2Active      ;
    property Field2Required         :Boolean     read GetField2Required       write SetField2Required    ;
    property Field2Type             :string      read GetField2Type           write SetField2Type        ;
    property Field2Values           :string      read GetField2Values         write SetField2Values      ;
    property Field3Caption          :string      read GetField3Caption        write SetField3Caption     ;
    property Field3Active           :Boolean     read GetField3Active         write SetField3Active      ;
    property Field3Required         :Boolean     read GetField3Required       write SetField3Required    ;
    property Field3Type             :string      read GetField3Type           write SetField3Type        ;
    property Field3Values           :string      read GetField3Values         write SetField3Values      ;
    property Field4Caption          :string      read GetField4Caption        write SetField4Caption     ;
    property Field4Active           :Boolean     read GetField4Active         write SetField4Active      ;
    property Field4Required         :Boolean     read GetField4Required       write SetField4Required    ;
    property Field4Type             :string      read GetField4Type           write SetField4Type        ;
    property Field4Values           :string      read GetField4Values         write SetField4Values      ;
    property Field5Caption          :string      read GetField5Caption        write SetField5Caption     ;
    property Field5Active           :Boolean     read GetField5Active         write SetField5Active      ;
    property Field5Required         :Boolean     read GetField5Required       write SetField5Required    ;
    property Field5Type             :string      read GetField5Type           write SetField5Type        ;
    property Field5Values           :string      read GetField5Values         write SetField5Values      ;
    property Field6Caption          :string      read GetField6Caption        write SetField6Caption     ;
    property Field6Active           :Boolean     read GetField6Active         write SetField6Active      ;
    property Field6Required         :Boolean     read GetField6Required       write SetField6Required    ;
    property Field6Type             :string      read GetField6Type           write SetField6Type        ;
    property Field6Values           :string      read GetField6Values         write SetField6Values      ;
    property Field7Caption          :string      read GetField7Caption        write SetField7Caption     ;
    property Field7Active           :Boolean     read GetField7Active         write SetField7Active      ;
    property Field7Required         :Boolean     read GetField7Required       write SetField7Required    ;
    property Field7Type             :string      read GetField7Type           write SetField7Type        ;
    property Field7Values           :string      read GetField7Values         write SetField7Values      ;
    property Field8Caption          :string      read GetField8Caption        write SetField8Caption     ;
    property Field8Active           :Boolean     read GetField8Active         write SetField8Active      ;
    property Field8Required         :Boolean     read GetField8Required       write SetField8Required    ;
    property Field8Type             :string      read GetField8Type           write SetField8Type        ;
    property Field8Values           :string      read GetField8Values         write SetField8Values      ;
    property Field9Caption          :string      read GetField9Caption        write SetField9Caption     ;
    property Field9Active           :Boolean     read GetField9Active         write SetField9Active      ;
    property Field9Required         :Boolean     read GetField9Required       write SetField9Required    ;
    property Field9Type             :string      read GetField9Type           write SetField9Type        ;
    property Field9Values           :string      read GetField9Values         write SetField9Values      ;
    property Field10Caption         :string      read GetField10Caption       write SetField10Caption    ;
    property Field10Active          :Boolean     read GetField10Active        write SetField10Active     ;
    property Field10Required        :Boolean     read GetField10Required      write SetField10Required   ;
    property Field10Type            :string      read GetField10Type          write SetField10Type       ;
    property Field10Values          :string      read GetField10Values        write SetField10Values     ;
  end;


implementation


uses tcDataUtils, CommonLib;



  {TCustomDataConfig}

constructor TCustomDataConfig.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'CustomDataConfig';
  fSQL := 'SELECT * FROM tblcustomdataconfig';
end;


destructor TCustomDataConfig.Destroy;
begin
  inherited;
end;


procedure TCustomDataConfig.LoadFromXMLNode(const node: TALXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ObjectName');
  SetPropertyFromNode(node,'Field1Caption');
  SetBooleanPropertyFromNode(node,'Field1Active');
  SetBooleanPropertyFromNode(node,'Field1Required');
  SetPropertyFromNode(node,'Field1Type');
  SetPropertyFromNode(node,'Field1Values');
  SetPropertyFromNode(node,'Field2Caption');
  SetBooleanPropertyFromNode(node,'Field2Active');
  SetBooleanPropertyFromNode(node,'Field2Required');
  SetPropertyFromNode(node,'Field2Type');
  SetPropertyFromNode(node,'Field2Values');
  SetPropertyFromNode(node,'Field3Caption');
  SetBooleanPropertyFromNode(node,'Field3Active');
  SetBooleanPropertyFromNode(node,'Field3Required');
  SetPropertyFromNode(node,'Field3Type');
  SetPropertyFromNode(node,'Field3Values');
  SetPropertyFromNode(node,'Field4Caption');
  SetBooleanPropertyFromNode(node,'Field4Active');
  SetBooleanPropertyFromNode(node,'Field4Required');
  SetPropertyFromNode(node,'Field4Type');
  SetPropertyFromNode(node,'Field4Values');
  SetPropertyFromNode(node,'Field5Caption');
  SetBooleanPropertyFromNode(node,'Field5Active');
  SetBooleanPropertyFromNode(node,'Field5Required');
  SetPropertyFromNode(node,'Field5Type');
  SetPropertyFromNode(node,'Field5Values');
  SetPropertyFromNode(node,'Field6Caption');
  SetBooleanPropertyFromNode(node,'Field6Active');
  SetBooleanPropertyFromNode(node,'Field6Required');
  SetPropertyFromNode(node,'Field6Type');
  SetPropertyFromNode(node,'Field6Values');
  SetPropertyFromNode(node,'Field7Caption');
  SetBooleanPropertyFromNode(node,'Field7Active');
  SetBooleanPropertyFromNode(node,'Field7Required');
  SetPropertyFromNode(node,'Field7Type');
  SetPropertyFromNode(node,'Field7Values');
  SetPropertyFromNode(node,'Field8Caption');
  SetBooleanPropertyFromNode(node,'Field8Active');
  SetBooleanPropertyFromNode(node,'Field8Required');
  SetPropertyFromNode(node,'Field8Type');
  SetPropertyFromNode(node,'Field8Values');
  SetPropertyFromNode(node,'Field9Caption');
  SetBooleanPropertyFromNode(node,'Field9Active');
  SetBooleanPropertyFromNode(node,'Field9Required');
  SetPropertyFromNode(node,'Field9Type');
  SetPropertyFromNode(node,'Field9Values');
  SetPropertyFromNode(node,'Field10Caption');
  SetBooleanPropertyFromNode(node,'Field10Active');
  SetBooleanPropertyFromNode(node,'Field10Required');
  SetPropertyFromNode(node,'Field10Type');
  SetPropertyFromNode(node,'Field10Values');
end;


procedure TCustomDataConfig.SaveToXMLNode(Const node: TALXMLNode);
begin
  inherited;
  AddXMLNode(node,'ObjectName' ,ObjectName);
  AddXMLNode(node,'Field1Caption' ,Field1Caption);
  AddXMLNode(node,'Field1Active' ,Field1Active);
  AddXMLNode(node,'Field1Required' ,Field1Required);
  AddXMLNode(node,'Field1Type' ,Field1Type);
  AddXMLNode(node,'Field1Values' ,Field1Values);
  AddXMLNode(node,'Field2Caption' ,Field2Caption);
  AddXMLNode(node,'Field2Active' ,Field2Active);
  AddXMLNode(node,'Field2Required' ,Field2Required);
  AddXMLNode(node,'Field2Type' ,Field2Type);
  AddXMLNode(node,'Field2Values' ,Field2Values);
  AddXMLNode(node,'Field3Caption' ,Field3Caption);
  AddXMLNode(node,'Field3Active' ,Field3Active);
  AddXMLNode(node,'Field3Required' ,Field3Required);
  AddXMLNode(node,'Field3Type' ,Field3Type);
  AddXMLNode(node,'Field3Values' ,Field3Values);
  AddXMLNode(node,'Field4Caption' ,Field4Caption);
  AddXMLNode(node,'Field4Active' ,Field4Active);
  AddXMLNode(node,'Field4Required' ,Field4Required);
  AddXMLNode(node,'Field4Type' ,Field4Type);
  AddXMLNode(node,'Field4Values' ,Field4Values);
  AddXMLNode(node,'Field5Caption' ,Field5Caption);
  AddXMLNode(node,'Field5Active' ,Field5Active);
  AddXMLNode(node,'Field5Required' ,Field5Required);
  AddXMLNode(node,'Field5Type' ,Field5Type);
  AddXMLNode(node,'Field5Values' ,Field5Values);
  AddXMLNode(node,'Field6Caption' ,Field6Caption);
  AddXMLNode(node,'Field6Active' ,Field6Active);
  AddXMLNode(node,'Field6Required' ,Field6Required);
  AddXMLNode(node,'Field6Type' ,Field6Type);
  AddXMLNode(node,'Field6Values' ,Field6Values);
  AddXMLNode(node,'Field7Caption' ,Field7Caption);
  AddXMLNode(node,'Field7Active' ,Field7Active);
  AddXMLNode(node,'Field7Required' ,Field7Required);
  AddXMLNode(node,'Field7Type' ,Field7Type);
  AddXMLNode(node,'Field7Values' ,Field7Values);
  AddXMLNode(node,'Field8Caption' ,Field8Caption);
  AddXMLNode(node,'Field8Active' ,Field8Active);
  AddXMLNode(node,'Field8Required' ,Field8Required);
  AddXMLNode(node,'Field8Type' ,Field8Type);
  AddXMLNode(node,'Field8Values' ,Field8Values);
  AddXMLNode(node,'Field9Caption' ,Field9Caption);
  AddXMLNode(node,'Field9Active' ,Field9Active);
  AddXMLNode(node,'Field9Required' ,Field9Required);
  AddXMLNode(node,'Field9Type' ,Field9Type);
  AddXMLNode(node,'Field9Values' ,Field9Values);
  AddXMLNode(node,'Field10Caption' ,Field10Caption);
  AddXMLNode(node,'Field10Active' ,Field10Active);
  AddXMLNode(node,'Field10Required' ,Field10Required);
  AddXMLNode(node,'Field10Type' ,Field10Type);
  AddXMLNode(node,'Field10Values' ,Field10Values);
end;


function TCustomDataConfig.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TCustomDataConfig.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TCustomDataConfig.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TCustomDataConfig.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TCustomDataConfig.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TCustomDataConfig.GetIDField: string;
begin
  Result := 'CustomDataConfigId'
end;


class function TCustomDataConfig.GetBusObjectTablename: string;
begin
  Result:= 'tblcustomdataconfig';
end;


function TCustomDataConfig.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TCustomDataConfig.GetObjectName        : string    ; begin Result := GetStringField('ObjectName');end;
function  TCustomDataConfig.GetField1Caption     : string    ; begin Result := GetStringField('Field1Caption');end;
function  TCustomDataConfig.GetField1Active      : Boolean   ; begin Result := GetBooleanField('Field1Active');end;
function  TCustomDataConfig.GetField1Required    : Boolean   ; begin Result := GetBooleanField('Field1Required');end;
function  TCustomDataConfig.GetField1Type        : string    ; begin Result := GetStringField('Field1Type');end;
function  TCustomDataConfig.GetField1Values      : string    ; begin Result := GetStringField('Field1Values');end;
function  TCustomDataConfig.GetField2Caption     : string    ; begin Result := GetStringField('Field2Caption');end;
function  TCustomDataConfig.GetField2Active      : Boolean   ; begin Result := GetBooleanField('Field2Active');end;
function  TCustomDataConfig.GetField2Required    : Boolean   ; begin Result := GetBooleanField('Field2Required');end;
function  TCustomDataConfig.GetField2Type        : string    ; begin Result := GetStringField('Field2Type');end;
function  TCustomDataConfig.GetField2Values      : string    ; begin Result := GetStringField('Field2Values');end;
function  TCustomDataConfig.GetField3Caption     : string    ; begin Result := GetStringField('Field3Caption');end;
function  TCustomDataConfig.GetField3Active      : Boolean   ; begin Result := GetBooleanField('Field3Active');end;
function  TCustomDataConfig.GetField3Required    : Boolean   ; begin Result := GetBooleanField('Field3Required');end;
function  TCustomDataConfig.GetField3Type        : string    ; begin Result := GetStringField('Field3Type');end;
function  TCustomDataConfig.GetField3Values      : string    ; begin Result := GetStringField('Field3Values');end;
function  TCustomDataConfig.GetField4Caption     : string    ; begin Result := GetStringField('Field4Caption');end;
function  TCustomDataConfig.GetField4Active      : Boolean   ; begin Result := GetBooleanField('Field4Active');end;
function  TCustomDataConfig.GetField4Required    : Boolean   ; begin Result := GetBooleanField('Field4Required');end;
function  TCustomDataConfig.GetField4Type        : string    ; begin Result := GetStringField('Field4Type');end;
function  TCustomDataConfig.GetField4Values      : string    ; begin Result := GetStringField('Field4Values');end;
function  TCustomDataConfig.GetField5Caption     : string    ; begin Result := GetStringField('Field5Caption');end;
function  TCustomDataConfig.GetField5Active      : Boolean   ; begin Result := GetBooleanField('Field5Active');end;
function  TCustomDataConfig.GetField5Required    : Boolean   ; begin Result := GetBooleanField('Field5Required');end;
function  TCustomDataConfig.GetField5Type        : string    ; begin Result := GetStringField('Field5Type');end;
function  TCustomDataConfig.GetField5Values      : string    ; begin Result := GetStringField('Field5Values');end;
function  TCustomDataConfig.GetField6Caption     : string    ; begin Result := GetStringField('Field6Caption');end;
function  TCustomDataConfig.GetField6Active      : Boolean   ; begin Result := GetBooleanField('Field6Active');end;
function  TCustomDataConfig.GetField6Required    : Boolean   ; begin Result := GetBooleanField('Field6Required');end;
function  TCustomDataConfig.GetField6Type        : string    ; begin Result := GetStringField('Field6Type');end;
function  TCustomDataConfig.GetField6Values      : string    ; begin Result := GetStringField('Field6Values');end;
function  TCustomDataConfig.GetField7Caption     : string    ; begin Result := GetStringField('Field7Caption');end;
function  TCustomDataConfig.GetField7Active      : Boolean   ; begin Result := GetBooleanField('Field7Active');end;
function  TCustomDataConfig.GetField7Required    : Boolean   ; begin Result := GetBooleanField('Field7Required');end;
function  TCustomDataConfig.GetField7Type        : string    ; begin Result := GetStringField('Field7Type');end;
function  TCustomDataConfig.GetField7Values      : string    ; begin Result := GetStringField('Field7Values');end;
function  TCustomDataConfig.GetField8Caption     : string    ; begin Result := GetStringField('Field8Caption');end;
function  TCustomDataConfig.GetField8Active      : Boolean   ; begin Result := GetBooleanField('Field8Active');end;
function  TCustomDataConfig.GetField8Required    : Boolean   ; begin Result := GetBooleanField('Field8Required');end;
function  TCustomDataConfig.GetField8Type        : string    ; begin Result := GetStringField('Field8Type');end;
function  TCustomDataConfig.GetField8Values      : string    ; begin Result := GetStringField('Field8Values');end;
function  TCustomDataConfig.GetField9Caption     : string    ; begin Result := GetStringField('Field9Caption');end;
function  TCustomDataConfig.GetField9Active      : Boolean   ; begin Result := GetBooleanField('Field9Active');end;
function  TCustomDataConfig.GetField9Required    : Boolean   ; begin Result := GetBooleanField('Field9Required');end;
function  TCustomDataConfig.GetField9Type        : string    ; begin Result := GetStringField('Field9Type');end;
function  TCustomDataConfig.GetField9Values      : string    ; begin Result := GetStringField('Field9Values');end;
function  TCustomDataConfig.GetField10Caption    : string    ; begin Result := GetStringField('Field10Caption');end;
function  TCustomDataConfig.GetField10Active     : Boolean   ; begin Result := GetBooleanField('Field10Active');end;
function  TCustomDataConfig.GetField10Required   : Boolean   ; begin Result := GetBooleanField('Field10Required');end;
function  TCustomDataConfig.GetField10Type       : string    ; begin Result := GetStringField('Field10Type');end;
function  TCustomDataConfig.GetField10Values     : string    ; begin Result := GetStringField('Field10Values');end;
procedure TCustomDataConfig.SetObjectName        (const Value: string    ); begin SetStringField('ObjectName'         , Value);end;
procedure TCustomDataConfig.SetField1Caption     (const Value: string    ); begin SetStringField('Field1Caption'      , Value);end;
procedure TCustomDataConfig.SetField1Active      (const Value: Boolean   ); begin SetBooleanField('Field1Active'       , Value);end;
procedure TCustomDataConfig.SetField1Required    (const Value: Boolean   ); begin SetBooleanField('Field1Required'     , Value);end;
procedure TCustomDataConfig.SetField1Type        (const Value: string    ); begin SetStringField('Field1Type'         , Value);end;
procedure TCustomDataConfig.SetField1Values      (const Value: string    ); begin SetStringField('Field1Values'       , Value);end;
procedure TCustomDataConfig.SetField2Caption     (const Value: string    ); begin SetStringField('Field2Caption'      , Value);end;
procedure TCustomDataConfig.SetField2Active      (const Value: Boolean   ); begin SetBooleanField('Field2Active'       , Value);end;
procedure TCustomDataConfig.SetField2Required    (const Value: Boolean   ); begin SetBooleanField('Field2Required'     , Value);end;
procedure TCustomDataConfig.SetField2Type        (const Value: string    ); begin SetStringField('Field2Type'         , Value);end;
procedure TCustomDataConfig.SetField2Values      (const Value: string    ); begin SetStringField('Field2Values'       , Value);end;
procedure TCustomDataConfig.SetField3Caption     (const Value: string    ); begin SetStringField('Field3Caption'      , Value);end;
procedure TCustomDataConfig.SetField3Active      (const Value: Boolean   ); begin SetBooleanField('Field3Active'       , Value);end;
procedure TCustomDataConfig.SetField3Required    (const Value: Boolean   ); begin SetBooleanField('Field3Required'     , Value);end;
procedure TCustomDataConfig.SetField3Type        (const Value: string    ); begin SetStringField('Field3Type'         , Value);end;
procedure TCustomDataConfig.SetField3Values      (const Value: string    ); begin SetStringField('Field3Values'       , Value);end;
procedure TCustomDataConfig.SetField4Caption     (const Value: string    ); begin SetStringField('Field4Caption'      , Value);end;
procedure TCustomDataConfig.SetField4Active      (const Value: Boolean   ); begin SetBooleanField('Field4Active'       , Value);end;
procedure TCustomDataConfig.SetField4Required    (const Value: Boolean   ); begin SetBooleanField('Field4Required'     , Value);end;
procedure TCustomDataConfig.SetField4Type        (const Value: string    ); begin SetStringField('Field4Type'         , Value);end;
procedure TCustomDataConfig.SetField4Values      (const Value: string    ); begin SetStringField('Field4Values'       , Value);end;
procedure TCustomDataConfig.SetField5Caption     (const Value: string    ); begin SetStringField('Field5Caption'      , Value);end;
procedure TCustomDataConfig.SetField5Active      (const Value: Boolean   ); begin SetBooleanField('Field5Active'       , Value);end;
procedure TCustomDataConfig.SetField5Required    (const Value: Boolean   ); begin SetBooleanField('Field5Required'     , Value);end;
procedure TCustomDataConfig.SetField5Type        (const Value: string    ); begin SetStringField('Field5Type'         , Value);end;
procedure TCustomDataConfig.SetField5Values      (const Value: string    ); begin SetStringField('Field5Values'       , Value);end;
procedure TCustomDataConfig.SetField6Caption     (const Value: string    ); begin SetStringField('Field6Caption'      , Value);end;
procedure TCustomDataConfig.SetField6Active      (const Value: Boolean   ); begin SetBooleanField('Field6Active'       , Value);end;
procedure TCustomDataConfig.SetField6Required    (const Value: Boolean   ); begin SetBooleanField('Field6Required'     , Value);end;
procedure TCustomDataConfig.SetField6Type        (const Value: string    ); begin SetStringField('Field6Type'         , Value);end;
procedure TCustomDataConfig.SetField6Values      (const Value: string    ); begin SetStringField('Field6Values'       , Value);end;
procedure TCustomDataConfig.SetField7Caption     (const Value: string    ); begin SetStringField('Field7Caption'      , Value);end;
procedure TCustomDataConfig.SetField7Active      (const Value: Boolean   ); begin SetBooleanField('Field7Active'       , Value);end;
procedure TCustomDataConfig.SetField7Required    (const Value: Boolean   ); begin SetBooleanField('Field7Required'     , Value);end;
procedure TCustomDataConfig.SetField7Type        (const Value: string    ); begin SetStringField('Field7Type'         , Value);end;
procedure TCustomDataConfig.SetField7Values      (const Value: string    ); begin SetStringField('Field7Values'       , Value);end;
procedure TCustomDataConfig.SetField8Caption     (const Value: string    ); begin SetStringField('Field8Caption'      , Value);end;
procedure TCustomDataConfig.SetField8Active      (const Value: Boolean   ); begin SetBooleanField('Field8Active'       , Value);end;
procedure TCustomDataConfig.SetField8Required    (const Value: Boolean   ); begin SetBooleanField('Field8Required'     , Value);end;
procedure TCustomDataConfig.SetField8Type        (const Value: string    ); begin SetStringField('Field8Type'         , Value);end;
procedure TCustomDataConfig.SetField8Values      (const Value: string    ); begin SetStringField('Field8Values'       , Value);end;
procedure TCustomDataConfig.SetField9Caption     (const Value: string    ); begin SetStringField('Field9Caption'      , Value);end;
procedure TCustomDataConfig.SetField9Active      (const Value: Boolean   ); begin SetBooleanField('Field9Active'       , Value);end;
procedure TCustomDataConfig.SetField9Required    (const Value: Boolean   ); begin SetBooleanField('Field9Required'     , Value);end;
procedure TCustomDataConfig.SetField9Type        (const Value: string    ); begin SetStringField('Field9Type'         , Value);end;
procedure TCustomDataConfig.SetField9Values      (const Value: string    ); begin SetStringField('Field9Values'       , Value);end;
procedure TCustomDataConfig.SetField10Caption    (const Value: string    ); begin SetStringField('Field10Caption'     , Value);end;
procedure TCustomDataConfig.SetField10Active     (const Value: Boolean   ); begin SetBooleanField('Field10Active'      , Value);end;
procedure TCustomDataConfig.SetField10Required   (const Value: Boolean   ); begin SetBooleanField('Field10Required'    , Value);end;
procedure TCustomDataConfig.SetField10Type       (const Value: string    ); begin SetStringField('Field10Type'        , Value);end;
procedure TCustomDataConfig.SetField10Values     (const Value: string    ); begin SetStringField('Field10Values'      , Value);end;


initialization
  RegisterClassOnce(TCustomDataConfig);


end.
