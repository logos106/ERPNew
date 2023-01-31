unit BusobjVS1DashboardPreferences;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  01/03/22  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  Tvs1charts = class(TMSBusObj)
  private
    function GetChartName           : string    ;
    function GetChartGroup          : string    ;
    function GetActive              : Boolean   ;

    procedure SetChartName           (const Value: string    );
    procedure SetChartGroup          (const Value: string    );
    procedure SetActive              (const Value: Boolean   );

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;

  public
    class function  GetIDField                   : string;              override;
    class function GetKeyStringField: string; Override;
    class function  GetBusObjectTablename        : string;              override;
    Class Function ChartGroupForID (Const aChartID:Integer ):String;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;

  published
    property ChartName  :string      read GetChartName          write SetChartName       ;
    property ChartGroup :string      read GetChartGroup         write SetChartGroup      ;
    property Active     :Boolean     read GetActive             write SetActive          ;
  end;

  TVs1TabGroups = class(TMSBusObj)
  private
    function GetDescription           : string    ;
    function GetTabGroup              : Integer   ;
    function GetSkinsGroup            : string    ;
    Procedure SetDescription          (Const Value : string    );
    Procedure SetTabGroup             (Const Value : Integer   );
    Procedure SetSkinsGroup           (Const Value : string    );
  protected

    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function GetKeyStringField: string; Override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  Published
    property Description :string  read GetDescription Write SetDescription       ;
    property TabGroup    :Integer read GetTabGroup    Write SetTabGroup          ;
    property SkinsGroup  :string  read GetSkinsGroup  Write SetSkinsGroup        ;
  end;

  TVs1Forms = class(TMSBusObj)
  Private
    function GetFormName              : string    ;
    function GetBusinessObjectName    : string    ;
    function GetIsForm                : Boolean   ;
    function GetAccessLevels          : Boolean   ;
    Function getTabGroupID            : Integer;
    procedure SetFormName              (const Value: string    );
    procedure SetBusinessObjectName    (const Value: string    );
    procedure SetIsForm                (const Value: Boolean   );
    procedure SetAccessLevels          (const Value: Boolean   );
    Procedure SetTabGroupID            (Const Value:Integer);
  public
    constructor  Create(AOwner: TComponent);                            override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
  published
    property FormName               :string      read GetFormName             write SetFormName          ;
    property BusinessObjectName     :string      read GetBusinessObjectName   write SetBusinessObjectName;
    property IsForm                 :Boolean     read GetIsForm               write SetIsForm            ;
    property AccessLevels           :Boolean     read GetAccessLevels         write SetAccessLevels      ;
    Property TabGroupID             :Integer     read getTabGroupID           write setTabGroupID;
  end;

  Tvs1dashboardpreferences = class(TMSBusObj)
  private
    function GetEmployeeID          : Integer   ;
    function GetTabGroup            : Integer   ;
    function GetPosition            : Integer   ;
    function GetChartWidth          : Integer   ;
    function GetChartHeight         : Integer   ;
    function GetChartID             : Integer   ;
    function GetActive              : Boolean   ;
    function getchartName           : String;
    function getEmployeename        : String;
    function getChartGroup          : String;
    procedure SetEmployeeID          (const Value: Integer   );
    procedure SetTabGroup            (const Value: Integer   );
    procedure SetPosition            (const Value: Integer   );
    procedure SetChartWidth          (const Value: Integer   );
    procedure SetChartHeight         (const Value: Integer   );
    procedure SetChartID             (const Value: Integer   );
    procedure SetActive              (const Value: Boolean   );
    procedure SetChartName           (const Value: String);
    procedure SetEmployeename        (const Value: String);

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;

  public
    class function  GetIDField                   : string;              override;
    class function GetKeyStringField: string; Override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;
                                            override;
  published
    property Active       :Boolean     read GetActive             write SetActive          ;
    Property ChartGroup   :String      read GetChartGroup;
    Property ChartName    :String      read GetchartName          write SetChartName       ;
    property ChartID      :Integer     read GetChartID            write SetChartID         ;
    property ChartWidth   :Integer     read GetChartWidth         write SetChartWidth      ;
    property ChartHeight  :Integer     read GetChartHeight        write SetChartHeight     ;
    property EmployeeID   :Integer     read GetEmployeeID         write SetEmployeeID      ;
    Property Employeename :String      read getEmployeename       write SetEmployeename    ;
    property Position     :Integer     read GetPosition           write SetPosition        ;
    property TabGroup     :Integer     read GetTabGroup           write SetTabGroup        ;

  end;


implementation


uses tcDataUtils, CommonLib, BusObjEmployee;



  {Tvs1charts}

class function Tvs1charts.ChartGroupForID(const aChartID: Integer): String;
begin
  With Tvs1charts.CreateWithSharedConn(nil) do try
    Load(aChartID);
    REsult := ChartGroup;
  finally
    Free;
  end;
end;

constructor Tvs1charts.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'vs1charts';
  fSQL := 'SELECT * FROM tblvs1charts';
end;


destructor Tvs1charts.Destroy;
begin
  inherited;
end;


procedure Tvs1charts.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ChartName');
  SetPropertyFromNode(node,'ChartGroup');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure Tvs1charts.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ChartName' ,ChartName);
  AddXMLNode(node,'ChartGroup' ,ChartGroup);
  AddXMLNode(node,'Active' ,Active);
end;


function Tvs1charts.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Tvs1charts.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tvs1charts.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tvs1charts.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tvs1charts.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function Tvs1charts.GetIDField: string;
begin
  Result := 'ID'
end;

class function Tvs1charts.GetKeyStringField: string;
begin
  Result := 'ID'; //'Chartname';
end;
class function Tvs1charts.GetBusObjectTablename: string;
begin
  Result:= 'tblvs1charts';
end;

function Tvs1charts.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{Property Functions}
function  Tvs1charts.GetChartName       : string    ; begin Result := GetStringField('ChartName');end;
function  Tvs1charts.GetChartGroup      : string    ; begin Result := GetStringField('ChartGroup');end;
function  Tvs1charts.GetActive          : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure Tvs1charts.SetChartName       (const Value: string    ); begin SetStringField('ChartName'        , Value);end;
procedure Tvs1charts.SetChartGroup      (const Value: string    ); begin SetStringField('ChartGroup'       , Value);end;
procedure Tvs1charts.SetActive          (const Value: Boolean   ); begin SetBooleanField('Active'           , Value);end;


  {TVs1TabGroups}

constructor TVs1TabGroups.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'TVS1tabgroups';
  fSQL := 'SELECT * FROM tblvs1tabgroups';
end;


destructor TVs1TabGroups.Destroy;
begin
  inherited;
end;


procedure TVs1TabGroups.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'TabGroup');
  SetPropertyFromNode(node,'SkinsGroup');
end;


procedure TVs1TabGroups.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'TabGroup' ,TabGroup);
  AddXMLNode(node,'SkinsGroup' ,SkinsGroup);
end;


function TVs1TabGroups.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TVs1TabGroups.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TVs1TabGroups.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TVs1TabGroups.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TVs1TabGroups.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TVs1TabGroups.GetIDField: string;
begin
  Result := 'ID'
end;

class function TVs1TabGroups.GetKeyStringField: string;
begin
  Result := 'SkinsGroup';
end;

class function TVs1TabGroups.GetBusObjectTablename: string;
begin
  Result:= 'tblvs1tabgroups';
end;


function TVs1TabGroups.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
{Property Functions}
function  TVs1TabGroups.GetDescription       : string    ; begin Result := GetStringField('Description');end;
function  TVs1TabGroups.GetTabGroup          : Integer   ; begin Result := GetIntegerField('TabGroup');end;
function  TVs1TabGroups.GetSkinsGroup        : string    ; begin Result := GetStringField('SkinsGroup');end;
Procedure  TVs1TabGroups.SetDescription       (Const Value : string    );begin SetStringField('Description', Value );end;
Procedure  TVs1TabGroups.SetTabGroup          (Const Value : Integer   );begin SetIntegerField('TabGroup', Value );end;
Procedure  TVs1TabGroups.SetSkinsGroup        (Const Value : string    );begin SetStringField('SkinsGroup', Value );end;


  {Tvs1dashboardpreferences}

constructor Tvs1dashboardpreferences.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'vs1dashboardpreferences';
  fSQL := 'SELECT * FROM tblvs1dashboardpreferences';
end;


destructor Tvs1dashboardpreferences.Destroy;
begin
  inherited;
end;


procedure Tvs1dashboardpreferences.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'TabGroup');
  SetPropertyFromNode(node,'Position');
  SetPropertyFromNode(node,'ChartWidth');
  SetPropertyFromNode(node,'ChartHeight');
  SetPropertyFromNode(node,'ChartID');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure Tvs1dashboardpreferences.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'TabGroup' ,TabGroup);
  AddXMLNode(node,'Position' ,Position);
  AddXMLNode(node,'ChartWidth' ,ChartWidth);
  AddXMLNode(node,'ChartHeight' ,ChartHeight);
  AddXMLNode(node,'ChartID' ,ChartID);
  AddXMLNode(node,'Active' ,Active);
end;


function Tvs1dashboardpreferences.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function Tvs1dashboardpreferences.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tvs1dashboardpreferences.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tvs1dashboardpreferences.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tvs1dashboardpreferences.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tvs1dashboardpreferences.GetIDField: string;
begin
  Result := 'ID'
end;
class function Tvs1dashboardpreferences.GetKeyStringField: string;
begin
  Result := '';
end;

class function Tvs1dashboardpreferences.GetBusObjectTablename: string;
begin
  Result:= 'tblvs1dashboardpreferences';
end;

function Tvs1dashboardpreferences.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{Property Functions}
function  Tvs1dashboardpreferences.GetEmployeeID      : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
function  Tvs1dashboardpreferences.GetTabGroup        : Integer   ; begin Result := GetIntegerField('TabGroup');end;
function  Tvs1dashboardpreferences.GetPosition        : Integer   ; begin Result := GetIntegerField('Position');end;
function  Tvs1dashboardpreferences.GetChartWidth      : Integer   ; begin Result := GetIntegerField('ChartWidth');end;
function  Tvs1dashboardpreferences.GetChartHeight     : Integer   ; begin Result := GetIntegerField('ChartHeight');end;
function  Tvs1dashboardpreferences.GetChartID         : Integer   ; begin Result := GetIntegerField('ChartID');end;
function  Tvs1dashboardpreferences.GetActive          : Boolean   ; begin Result := GetBooleanField('Active');end;
function  Tvs1dashboardpreferences.GetchartName       : String    ; begin Result := Tvs1charts.IDToggle(ChartID); end;
function  Tvs1dashboardpreferences.GetChartGroup      : String    ; begin Result := Tvs1charts.ChartGroupForID(ChartID); end;
function  Tvs1dashboardpreferences.GetEmployeename    : String    ; begin Result := TEmployee.IDToggle(EmployeeID); end;
procedure Tvs1dashboardpreferences.SetEmployeeID      (const Value: Integer   ); begin SetIntegerField('EmployeeID'       , Value);end;
procedure Tvs1dashboardpreferences.SetTabGroup        (const Value: Integer   ); begin SetIntegerField('TabGroup'         , Value);end;
procedure Tvs1dashboardpreferences.SetPosition        (const Value: Integer   ); begin SetIntegerField('Position'         , Value);end;
procedure Tvs1dashboardpreferences.SetChartWidth      (const Value: Integer   ); begin SetIntegerField('ChartWidth'       , Value);end;
procedure Tvs1dashboardpreferences.SetChartHeight     (const Value: Integer   ); begin SetIntegerField('ChartHeight'      , Value);end;
procedure Tvs1dashboardpreferences.SetChartID         (const Value: Integer   ); begin SetIntegerField('ChartID'          , Value);end;
procedure Tvs1dashboardpreferences.SetActive          (const Value: Boolean   ); begin SetBooleanField('Active'           , Value);end;
procedure Tvs1dashboardpreferences.SetChartName       (const Value: String    ); begin SetIntegerField('ChartID'          , Tvs1charts.IDToggle(Value));end;
procedure Tvs1dashboardpreferences.SetEmployeename    (const Value: String    ); begin SetIntegerField('EmployeeID'       , TEmployee.IDToggle(Value));end;
{ TVs1Forms }

constructor TVs1Forms.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'vs1forms';
  fSQL := 'SELECT * FROM tblvs1forms';
end;

procedure TVs1Forms.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'FormName');
  SetPropertyFromNode(node,'BusinessObjectName');
  SetBooleanPropertyFromNode(node,'IsForm');
  SetBooleanPropertyFromNode(node,'AccessLevels');
  SetPropertyFromNode(node,'TabGroupID');
end;

procedure TVs1Forms.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'FormName' ,FormName);
  AddXMLNode(node,'BusinessObjectName' ,BusinessObjectName);
  AddXMLNode(node,'IsForm' ,IsForm);
  AddXMLNode(node,'AccessLevels' ,AccessLevels);
  AddXMLNode(node,'TabGroupID' , TabGroupID);
end;
{TVs1Forms}
{Property Functions}
function  TVs1Forms.GetFormName          : string    ; begin Result := GetStringField('FormName');end;
function  TVs1Forms.GetBusinessObjectName: string    ; begin Result := GetStringField('BusinessObjectName');end;
function  TVs1Forms.GetIsForm            : Boolean   ; begin Result := GetBooleanField('IsForm');end;
function  TVs1Forms.GetAccessLevels      : Boolean   ; begin Result := GetBooleanField('AccessLevels');end;
function  TVs1Forms.GetTabGroupID        : Integer   ; begin REsult := getIntegerfield('TabGroupID');end;
procedure TVs1Forms.SetFormName          (const Value: string    ); begin SetStringField('FormName'           , Value);end;
procedure TVs1Forms.SetBusinessObjectName(const Value: string    ); begin SetStringField('BusinessObjectName' , Value);end;
procedure TVs1Forms.SetIsForm            (const Value: Boolean   ); begin SetBooleanField('IsForm'            , Value);end;
procedure TVs1Forms.SetAccessLevels      (const Value: Boolean   ); begin SetBooleanField('AccessLevels'      , Value);end;
Procedure TVs1Forms.SetTabGroupID        (const Value: Integer   ); begin SetIntegerfield('TabGroupID'        , value);end;

initialization
  RegisterClass(Tvs1dashboardpreferences);
  RegisterClass(TVs1TabGroups);
  RegisterClass(Tvs1charts);
end.

