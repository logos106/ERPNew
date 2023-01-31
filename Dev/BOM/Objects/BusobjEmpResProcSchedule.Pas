unit BusobjEmpResProcSchedule;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  26/10/15  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type

  TEmpResProcScheduleDays = class(TMSBusObj)
  private
    function GetSunday       : TDateTime ;
    function GetMonday       : TDateTime ;
    function GetTuesday      : TDateTime ;
    function GetWednesday    : TDateTime ;
    function GetThursday     : TDateTime ;
    function GetFriday       : TDateTime ;
    function GetSaturday     : TDateTime ;
    procedure SetSunday       (const Value: TDateTime );
    procedure SetMonday       (const Value: TDateTime );
    procedure SetTuesday      (const Value: TDateTime );
    procedure SetWednesday    (const Value: TDateTime );
    procedure SetThursday     (const Value: TDateTime );
    procedure SetFriday       (const Value: TDateTime );
    procedure SetSaturday     (const Value: TDateTime );
    function GetFridayWeekdayNo: Integer;
    function GetMondayWeekdayNo: Integer;
    function GetSatudayWeekdayNo: Integer;
    function GetSundayWeekdayNo: Integer;
    function GetThursdayWeekdayNo: Integer;
    function GetTuesdayeWeekdayNo: Integer;
    function GetWednesdayWeekdayNo: Integer;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;

  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    property      SundayWeekdayNo :Integer read GetSundayWeekdayNo;
    property      MondayWeekdayNo :Integer read GetMondayWeekdayNo;
    property      TuesdayeWeekdayNo :Integer read GetTuesdayeWeekdayNo;
    property      WednesdayWeekdayNo :Integer read GetWednesdayWeekdayNo;
    property      ThursdayWeekdayNo :Integer read GetThursdayWeekdayNo;
    property      FridayWeekdayNo :Integer read GetFridayWeekdayNo;
    property      SatudayWeekdayNo :Integer read GetSatudayWeekdayNo;
    function WeekdayDate(Weekday:Integer):TdateTime;

  published
    property Sunday        :TDateTime   read GetSunday      write SetSunday   ;
    property Monday        :TDateTime   read GetMonday      write SetMonday   ;
    property Tuesday       :TDateTime   read GetTuesday     write SetTuesday  ;
    property Wednesday     :TDateTime   read GetWednesday   write SetWednesday;
    property Thursday      :TDateTime   read GetThursday    write SetThursday ;
    property Friday        :TDateTime   read GetFriday      write SetFriday   ;
    property Saturday      :TDateTime   read GetSaturday    write SetSaturday ;
  end;


  TEmpResProcRoster = class(TMSBusObj)
  private
    function GetPlannerId           : string    ;
    function GetEmployeeId          : Integer   ;
    function GetWeekDayNo           : Integer   ;
    function GetProcessStepId       : Integer   ;
    function GetResourceID          : Integer   ;
    function GetResourceDetailId    : Integer   ;
    function GetTimeFrom            : TDateTime ;
    function GetTimeTo              : TDateTime ;
    function GetActive              : Boolean   ;
    function GetProcessStep         : string    ;
    function GetResourceName        : string    ;
    function GetResourceDetailDescription    : string    ;
    procedure SetPlannerId           (const Value: string    );
    procedure SetEmployeeId          (const Value: Integer   );
    procedure SetWeekDayNo           (const Value: Integer   );
    procedure SetProcessStepId       (const Value: Integer   );
    procedure SetResourceID          (const Value: Integer   );
    procedure SetResourceDetailId    (const Value: Integer   );
    procedure SetTimeFrom            (const Value: TDateTime );
    procedure SetTimeTo              (const Value: TDateTime );
    procedure SetActive              (const Value: Boolean   );
    function WeekdayDate:TDatetime;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;            override;
    function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;            override;
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
    property PlannerId            :string      read GetPlannerId          write SetPlannerId       ;
    property EmployeeId           :Integer     read GetEmployeeId         write SetEmployeeId      ;
    property WeekDayNo            :Integer     read GetWeekDayNo          write SetWeekDayNo       ;
    property ProcessStepId        :Integer     read GetProcessStepId      write SetProcessStepId   ;
    property ResourceID           :Integer     read GetResourceID         write SetResourceID      ;
    property ResourceDetailId     :Integer     read GetResourceDetailId   write SetResourceDetailId;
    property TimeFrom             :TDateTime   read GetTimeFrom           write SetTimeFrom        ;
    property TimeTo               :TDateTime   read GetTimeTo             write SetTimeTo          ;
    property Active               :Boolean     read GetActive             write SetActive          ;
    property ProcessStep          :string      read GetProcessStep        ;
    property ResourceName         :string      read GetResourceName       ;
    property ResourceDetailDescription  :string      read GetResourceDetailDescription       ;
  end;

Function EmpResProcScheduleDays : TEmpResProcScheduleDays;

implementation


uses tcDataUtils, CommonLib , Forms, sysutils, dateutils;

var
  fEmpResProcScheduleDays : TEmpResProcScheduleDays;


Function EmpResProcScheduleDays : TEmpResProcScheduleDays;
begin
   if fEmpResProcScheduleDays = nil then begin
     fEmpResProcScheduleDays := TEmpResProcScheduleDays.CreateWithNewConn(Application);
     fEmpResProcScheduleDays.load;
   end;
   Result := fEmpResProcScheduleDays;
end;
  {TEmpResProcRoster}

constructor TEmpResProcRoster.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'EmpResProcSchedule';
  fSQL := 'SELECT * FROM tblempresprocschedule';
end;


destructor TEmpResProcRoster.Destroy;
begin
  inherited;
end;


procedure TEmpResProcRoster.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'PlannerId');
  SetPropertyFromNode(node,'EmployeeId');
  SetPropertyFromNode(node,'WeekDayNo');
  SetPropertyFromNode(node,'ProcessStepId');
  SetPropertyFromNode(node,'ResourceID');
  SetPropertyFromNode(node,'ResourceDetailId');
  SetDateTimePropertyFromNode(node,'TimeFrom');
  SetDateTimePropertyFromNode(node,'TimeTo');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure TEmpResProcRoster.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'PlannerId' ,PlannerId);
  AddXMLNode(node,'EmployeeId' ,EmployeeId);
  AddXMLNode(node,'WeekDayNo' ,WeekDayNo);
  AddXMLNode(node,'ProcessStepId' ,ProcessStepId);
  AddXMLNode(node,'ResourceID' ,ResourceID);
  AddXMLNode(node,'ResourceDetailId' ,ResourceDetailId);
  AddXMLNode(node,'TimeFrom' ,TimeFrom);
  AddXMLNode(node,'TimeTo' ,TimeTo);
  AddXMLNode(node,'Active' ,Active);
end;


function TEmpResProcRoster.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if EmployeeId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'EmployeeId should not be 0' , TRue);
    Exit;
  end;
  if WeekDayNo = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'WeekDayNo should not be 0' , TRue);
    Exit;
  end;
  Result := True;
end;


function TEmpResProcRoster.WeekdayDate: TDatetime;
begin
  REsult := EmpResProcScheduleDays.weekdaydate(WeekDayNo);
end;

function TEmpResProcRoster.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TEmpResProcRoster.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TEmpResProcRoster.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Self.Classnameis('TEmpResProcRoster') then begin
    if sametext(Sender.fieldname ,  'TimeFrom') then begin
      if Dateof(timefrom) <> WeekdayDate then
        TimeFrom :=WeekdayDate;
    end else if sametext(Sender.fieldname ,  'TimeTo') then begin
      if Dateof(TimeTo) <> WeekdayDate then
        TimeTo :=incday(WeekdayDate ,1);
    end;
  end;
end;


function TEmpResProcRoster.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TEmpResProcRoster.GetIDField: string;
begin
  Result := 'ID'
end;


class function TEmpResProcRoster.GetBusObjectTablename: string;
begin
  Result:= 'tblempresprocschedule';
end;


function TEmpResProcRoster.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
end;

function TEmpResProcRoster.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
  if PlannerId = '' then begin
    PlannerId := tcdatautils.NextUniqueValue(Inttostr(ID) , BusObjectTablename , 'PlannerID');
    if Dataset.State in [dsEdit,dsInsert] then
      Dataset.Post;
  end;
end;


function TEmpResProcRoster.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not result then exit;
end;

{Property Functions}
function  TEmpResProcRoster.GetPlannerId       : string    ; begin Result := GetStringField('PlannerId');end;
function  TEmpResProcRoster.GetEmployeeId      : Integer   ; begin Result := GetIntegerField('EmployeeId');end;
function  TEmpResProcRoster.GetWeekDayNo       : Integer   ; begin Result := GetIntegerField('WeekDayNo');end;
function  TEmpResProcRoster.GetProcessStepId   : Integer   ; begin Result := GetIntegerField('ProcessStepId');end;
function  TEmpResProcRoster.GetResourceID      : Integer   ; begin Result := GetIntegerField('ResourceID');end;
function  TEmpResProcRoster.GetResourceDetailId: Integer   ; begin Result := GetIntegerField('ResourceDetailId');end;
function  TEmpResProcRoster.GetTimeFrom        : TDateTime ; begin Result := GetDateTimeField('TimeFrom');end;
function  TEmpResProcRoster.GetTimeTo          : TDateTime ; begin Result := GetDateTimeField('TimeTo');end;
function  TEmpResProcRoster.GetActive          : Boolean   ; begin Result := GetBooleanField('Active');end;
function  TEmpResProcRoster.GetProcessStep     : string    ; begin Result := GetStringField('ProcessStep');end;
function  TEmpResProcRoster.GetResourceName    : string    ; begin Result := GetStringField('ResourceName');end;
function  TEmpResProcRoster.GetResourceDetailDescription    : string    ; begin Result := GetStringField('ResourceDetailDescription');end;
procedure TEmpResProcRoster.SetPlannerId       (const Value: string    ); begin SetStringField('PlannerId'        , Value);end;
procedure TEmpResProcRoster.SetEmployeeId      (const Value: Integer   ); begin SetIntegerField('EmployeeId'       , Value);end;
procedure TEmpResProcRoster.SetWeekDayNo       (const Value: Integer   ); begin SetIntegerField('WeekDayNo'        , Value);end;
procedure TEmpResProcRoster.SetProcessStepId   (const Value: Integer   ); begin SetIntegerField('ProcessStepId'    , Value);end;
procedure TEmpResProcRoster.SetResourceID      (const Value: Integer   ); begin SetIntegerField('ResourceID'       , Value);end;
procedure TEmpResProcRoster.SetResourceDetailId(const Value: Integer   ); begin SetIntegerField('ResourceDetailId' , Value);end;
procedure TEmpResProcRoster.SetTimeFrom        (const Value: TDateTime ); begin  SetDateTimeField('TimeFrom'         , Value);end;
procedure TEmpResProcRoster.SetTimeTo          (const Value: TDateTime ); begin SetDateTimeField('TimeTo'           , Value);end;
procedure TEmpResProcRoster.SetActive          (const Value: Boolean   ); begin SetBooleanField('Active'           , Value);end;


  {TEmpResProcScheduleDays}

constructor TEmpResProcScheduleDays.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'EmpResProcScheduleDays';
  fSQL := 'SELECT * FROM tblempresprocscheduledays';
end;


destructor TEmpResProcScheduleDays.Destroy;
begin
  inherited;
end;


procedure TEmpResProcScheduleDays.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetDateTimePropertyFromNode(node,'Sunday');
  SetDateTimePropertyFromNode(node,'Monday');
  SetDateTimePropertyFromNode(node,'Tuesday');
  SetDateTimePropertyFromNode(node,'Wednesday');
  SetDateTimePropertyFromNode(node,'Thursday');
  SetDateTimePropertyFromNode(node,'Friday');
  SetDateTimePropertyFromNode(node,'Saturday');
end;


procedure TEmpResProcScheduleDays.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Sunday' ,Sunday);
  AddXMLNode(node,'Monday' ,Monday);
  AddXMLNode(node,'Tuesday' ,Tuesday);
  AddXMLNode(node,'Wednesday' ,Wednesday);
  AddXMLNode(node,'Thursday' ,Thursday);
  AddXMLNode(node,'Friday' ,Friday);
  AddXMLNode(node,'Saturday' ,Saturday);
end;


function TEmpResProcScheduleDays.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TEmpResProcScheduleDays.WeekdayDate(Weekday: Integer): TdateTime;
begin
       if Weekday =1 then result := Sunday
  else if Weekday =2 then result := Monday
  else if Weekday =3 then result := Tuesday
  else if Weekday =4 then result := Wednesday
  else if Weekday =5 then result := Thursday
  else if Weekday =6 then result := Friday
  else if Weekday =7 then result := Saturday
  Else result := 0;


end;

function TEmpResProcScheduleDays.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TEmpResProcScheduleDays.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TEmpResProcScheduleDays.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TEmpResProcScheduleDays.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TEmpResProcScheduleDays.GetIDField: string;
begin
  Result := 'ID'
end;


class function TEmpResProcScheduleDays.GetBusObjectTablename: string;
begin
  Result:= 'tblempresprocscheduledays';
end;


function TEmpResProcScheduleDays.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;



{Property Functions}
function TEmpResProcScheduleDays.GetSundayWeekdayNo   : Integer;begin Result := DayOfWeek(Sunday)    ;end;
function TEmpResProcScheduleDays.GetMondayWeekdayNo   : Integer;begin Result := DayOfWeek(Monday)    ;end;
function TEmpResProcScheduleDays.GetTuesdayeWeekdayNo : Integer;begin Result := DayOfWeek(Tuesday)   ;end;
function TEmpResProcScheduleDays.GetWednesdayWeekdayNo: Integer;begin Result := DayOfWeek(Wednesday) ;end;
function TEmpResProcScheduleDays.GetThursdayWeekdayNo : Integer;begin Result := DayOfWeek(Thursday)  ;end;
function TEmpResProcScheduleDays.GetFridayWeekdayNo   : Integer;begin Result := DayOfWeek(Friday)    ;end;
function TEmpResProcScheduleDays.GetSatudayWeekdayNo  : Integer;begin Result := DayOfWeek(Saturday)  ;end;

function  TEmpResProcScheduleDays.GetSunday   : TDateTime ; begin Result := GetDateTimeField('Sunday')    ;end;
function  TEmpResProcScheduleDays.GetMonday   : TDateTime ; begin Result := GetDateTimeField('Monday')    ;end;
function  TEmpResProcScheduleDays.GetTuesday  : TDateTime ; begin Result := GetDateTimeField('Tuesday')   ;end;
function  TEmpResProcScheduleDays.GetWednesday: TDateTime ; begin Result := GetDateTimeField('Wednesday') ;end;
function  TEmpResProcScheduleDays.GetThursday : TDateTime ; begin Result := GetDateTimeField('Thursday')  ;end;
function  TEmpResProcScheduleDays.GetFriday   : TDateTime ; begin Result := GetDateTimeField('Friday')    ;end;
function  TEmpResProcScheduleDays.GetSaturday : TDateTime ; begin Result := GetDateTimeField('Saturday')  ;end;

procedure TEmpResProcScheduleDays.SetSunday   (const Value: TDateTime ); begin SetDateTimeField('Sunday'   , Value);end;
procedure TEmpResProcScheduleDays.SetMonday   (const Value: TDateTime ); begin SetDateTimeField('Monday'   , Value);end;
procedure TEmpResProcScheduleDays.SetTuesday  (const Value: TDateTime ); begin SetDateTimeField('Tuesday'  , Value);end;
procedure TEmpResProcScheduleDays.SetWednesday(const Value: TDateTime ); begin SetDateTimeField('Wednesday', Value);end;
procedure TEmpResProcScheduleDays.SetThursday (const Value: TDateTime ); begin SetDateTimeField('Thursday' , Value);end;
procedure TEmpResProcScheduleDays.SetFriday   (const Value: TDateTime ); begin SetDateTimeField('Friday'   , Value);end;
procedure TEmpResProcScheduleDays.SetSaturday (const Value: TDateTime ); begin SetDateTimeField('Saturday' , Value);end;


initialization
  RegisterClass(TEmpResProcRoster);
  fEmpResProcScheduleDays := nil;

end.
