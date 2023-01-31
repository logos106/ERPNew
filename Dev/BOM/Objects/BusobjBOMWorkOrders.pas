unit BusobjBOMWorkOrders;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  10/09/15  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TBOMWorkOrderLines = class(TMSBusObj)
  private
    function GetBOMWorkOrderID    : Integer   ;
    function GetProcessStepID     : Integer   ;
    function GetProcesstimeID     : Integer   ;
    function GetProctreeID        : Integer   ;
    function GetProcessPartID     : Integer   ;
    function GetEmployeeId        : Integer   ;
    function GetScheduledFrom     : TDateTime ;
    function GetScheduledTo       : TDateTime ;
    function GetDuration          : Integer   ;
    procedure SetBOMWorkOrderID   (const Value: Integer   );
    procedure SetProcessStepID    (const Value: Integer   );
    procedure SetProcesstimeID    (const Value: Integer   );
    procedure SetProctreeID       (const Value: Integer   );
    procedure SetProcessPartID    (const Value: Integer   );
    procedure SetEmployeeId       (const Value: Integer   );
    procedure SetScheduledFrom    (const Value: TDateTime );
    procedure SetScheduledTo      (const Value: TDateTime );
    procedure SetDuration         (const Value: Integer   );
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
    property BOMWorkOrderID     :Integer     read GetBOMWorkOrderID   write SetBOMWorkOrderID ;
    property ProcessStepID      :Integer     read GetProcessStepID    write SetProcessStepID ;
    property ProcesstimeID      :Integer     read GetProcesstimeID    write SetProcesstimeID ;
    property ProctreeID         :Integer     read GetProctreeID       write SetProctreeID ;
    property ProcessPartID      :Integer     read GetProcessPartID    write SetProcessPartID ;
    property EmployeeId         :Integer     read GetEmployeeId       write SetEmployeeId      ;
    property ScheduledFrom      :TDateTime   read GetScheduledFrom    write SetScheduledFrom            ;
    property ScheduledTo        :TDateTime   read GetScheduledTo      write SetScheduledTo            ;
    property Duration           :Integer     read GetDuration         write SetDuration        ;
  end;

  TBOMWorkOrder = class(TMSBusObj)
  private
    function GetEmployeeId          : Integer   ;
    function GetCreatedOn           : TDateTime ;
    procedure SetEmployeeId          (const Value: Integer   );
    procedure SetCreatedOn           (const Value: TDateTime );
    function getLines: TBOMWorkOrderLines;
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
    Property Lines :TBOMWorkOrderLines read getLines;
  published
    property EmployeeId           :Integer     read GetEmployeeId         write SetEmployeeId      ;
    property CreatedOn            :TDateTime   read GetCreatedOn          write SetCreatedOn       ;
  end;

implementation


uses tcDataUtils, CommonLib, Sysutils, AppEnvironment , dateutils;



  {TBOMWorkOrderLines}

constructor TBOMWorkOrderLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'BOMWorkOrderLines';
  fSQL := 'SELECT * FROM tblbomworkorderlines';
end;


destructor TBOMWorkOrderLines.Destroy;
begin
  inherited;
end;


procedure TBOMWorkOrderLines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'BOMWorkOrderID');
  SetPropertyFromNode(node,'ProcessStepID');
  SetPropertyFromNode(node,'ProcesstimeID');
  SetPropertyFromNode(node,'ProctreeID');
  SetPropertyFromNode(node,'ProcessPartID');
  SetPropertyFromNode(node,'EmployeeId');
  SetDateTimePropertyFromNode(node,'ScheduledFrom');
  SetDateTimePropertyFromNode(node,'ScheduledTo');
  SetPropertyFromNode(node,'Duration');
end;


procedure TBOMWorkOrderLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'BOMWorkOrderID' ,BOMWorkOrderID);
  AddXMLNode(node,'ProcessStepID' ,ProcessStepID);
  AddXMLNode(node,'ProcesstimeID' ,ProcesstimeID);
  AddXMLNode(node,'ProctreeID' ,ProctreeID);
  AddXMLNode(node,'ProcessPartID' ,ProcessPartID);
  AddXMLNode(node,'EmployeeId' ,EmployeeId);
  AddXMLNode(node,'ScheduledFrom' ,ScheduledFrom);
  AddXMLNode(node,'ScheduledTo' ,ScheduledTo);
  AddXMLNode(node,'Duration' ,Duration);
end;


function TBOMWorkOrderLines.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if EmployeeId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'EmployeeId should not be 0' , False );
    Exit;
  end;
  if ScheduledFrom = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Date should not be blank' , False );
    Exit;
  end;
  if Duration = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Duration should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TBOMWorkOrderLines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TBOMWorkOrderLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TBOMWorkOrderLines.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
           if Sysutils.SameText(Sender.FieldName, 'ScheduledFrom') then begin if Duration      <> 0 then ScheduledTo   := incSecond(ScheduledFrom ,Duration )   else if ScheduledTo    <> 0 then Duration      := Secondsbetween(ScheduledFrom , ScheduledTo);
  end else if Sysutils.SameText(Sender.FieldName, 'ScheduledTo')   then begin if Duration      <> 0 then ScheduledFrom := incSecond(ScheduledFrom ,0-Duration ) else if ScheduledFrom  <> 0 then Duration      := Secondsbetween(ScheduledFrom , ScheduledTo);
  end else if Sysutils.SameText(Sender.FieldName, 'Duration')      then begin if ScheduledFrom <> 0 then ScheduledTo   := incSecond(ScheduledFrom ,Duration )   else if ScheduledTo    <> 0 then ScheduledFrom := incSecond(ScheduledFrom ,0-Duration );
  end;
end;


function TBOMWorkOrderLines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TBOMWorkOrderLines.GetIDField: string;
begin
  Result := 'ID'
end;


class function TBOMWorkOrderLines.GetBusObjectTablename: string;
begin
  Result:= 'tblbomworkorderlines';
end;


function TBOMWorkOrderLines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not(result) then Exit;
  if Assigned(Owner) then
    if owner is  TBOMWorkOrder then
      BOMWorkOrderID := TBOMWorkOrder(Owner).ID;
end;

function TBOMWorkOrderLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TBOMWorkOrderLines.GetBOMWorkOrderID  : Integer   ; begin Result := GetIntegerField('BOMWorkOrderID');end;
function  TBOMWorkOrderLines.GetProcessStepID   : Integer   ; begin Result := GetIntegerField('ProcessStepID');end;
function  TBOMWorkOrderLines.GetProcesstimeID   : Integer   ; begin Result := GetIntegerField('ProcesstimeID');end;
function  TBOMWorkOrderLines.GetProctreeID      : Integer   ; begin Result := GetIntegerField('ProctreeID');end;
function  TBOMWorkOrderLines.GetProcessPartID   : Integer   ; begin Result := GetIntegerField('ProcessPartID');end;
function  TBOMWorkOrderLines.GetEmployeeId      : Integer   ; begin Result := GetIntegerField('EmployeeId');end;
function  TBOMWorkOrderLines.GetScheduledFrom    : TDateTime ; begin Result := GetDateTimeField('ScheduledFrom');end;
function  TBOMWorkOrderLines.GetScheduledTo    : TDateTime ; begin Result := GetDateTimeField('ScheduledTo');end;
function  TBOMWorkOrderLines.GetDuration        : Integer   ; begin Result := GetIntegerField('Duration');end;
procedure TBOMWorkOrderLines.SetBOMWorkOrderID  (const Value: Integer   ); begin SetIntegerField('BOMWorkOrderID' , Value);end;
procedure TBOMWorkOrderLines.SetProcessStepID   (const Value: Integer   ); begin SetIntegerField('ProcessStepID'  , Value);end;
procedure TBOMWorkOrderLines.SetProcesstimeID   (const Value: Integer   ); begin SetIntegerField('ProcesstimeID'  , Value);end;
procedure TBOMWorkOrderLines.SetProctreeID      (const Value: Integer   ); begin SetIntegerField('ProctreeID'     , Value);end;
procedure TBOMWorkOrderLines.SetProcessPartID   (const Value: Integer   ); begin SetIntegerField('ProcessPartID'  , Value);end;
procedure TBOMWorkOrderLines.SetEmployeeId      (const Value: Integer   ); begin SetIntegerField('EmployeeId'     , Value);end;
procedure TBOMWorkOrderLines.SetScheduledFrom    (const Value: TDateTime ); begin SetDateTimeField('ScheduledFrom'  , Value);end;
procedure TBOMWorkOrderLines.SetScheduledTo    (const Value: TDateTime ); begin SetDateTimeField('ScheduledTo'  , Value);end;
procedure TBOMWorkOrderLines.SetDuration        (const Value: Integer   ); begin SetIntegerField('Duration'       , Value);end;


{TBOMWorkOrder}


constructor TBOMWorkOrder.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'BOMWorkOrder';
  fSQL := 'SELECT * FROM tblbomworkorder';
end;


destructor TBOMWorkOrder.Destroy;
begin
  inherited;
end;


procedure TBOMWorkOrder.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'EmployeeId');
  SetDateTimePropertyFromNode(node,'CreatedOn');
end;


procedure TBOMWorkOrder.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'EmployeeId' ,EmployeeId);
  AddXMLNode(node,'CreatedOn' ,CreatedOn);
end;


function TBOMWorkOrder.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if EmployeeId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'EmployeeId should not be 0' , False );
    Exit;
  end;
  if CreatedOn = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'CreatedOn should not be blank' , False );
    Exit;
  end;
  Result := True;
end;


function TBOMWorkOrder.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TBOMWorkOrder.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TBOMWorkOrder.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TBOMWorkOrder.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TBOMWorkOrder.GetIDField: string;
begin
  Result := 'ID'
end;


function TBOMWorkOrder.getLines: TBOMWorkOrderLines;
begin
    Result := TBOMWorkOrderLines(Getcontainercomponent(TBOMWorkOrderLines, 'BOMWorkOrderID  = ' + inttostr(id)));
end;

class function TBOMWorkOrder.GetBusObjectTablename: string;
begin
  Result:= 'tblbomworkorder';
end;


function TBOMWorkOrder.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not(result) then Exit;
  CreatedOn := now;
  employeeID := Appenv.Employee.EmployeeID;
end;

function TBOMWorkOrder.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TBOMWorkOrder.GetEmployeeId      : Integer   ; begin Result := GetIntegerField('EmployeeId');end;
function  TBOMWorkOrder.GetCreatedOn       : TDateTime ; begin Result := GetDateTimeField('CreatedOn');end;
procedure TBOMWorkOrder.SetEmployeeId      (const Value: Integer   ); begin SetIntegerField('EmployeeId'     , Value);end;
procedure TBOMWorkOrder.SetCreatedOn       (const Value: TDateTime ); begin SetDateTimeField('CreatedOn'     , Value);end;


initialization
  RegisterClass(TBOMWorkOrder);
  RegisterClass(TBOMWorkOrderLines);


end.
