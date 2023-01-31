unit BusObjEmployeeLeaveRequests;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  03/08/15  1.00.00  A.  Initial Version.
  }


interface


uses ERPdbComponents, BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TEmpLeaveRequests = class(TMSBusObj)

  private
    function GetEmployeeId          : Integer   ;
    function GetLeavetypeID          : Integer   ;
    function GetLeaveDate           : TDateTime ;
    function GetStarttime           : TDateTime ;
    function GetEndtime             : TDateTime ;
    function GetHours               : Double   ;
    function GetActive              : Boolean   ;
    function GetEmployeeName        : String;
    function GetLeavetype        : String;
    procedure SetEmployeeId          (const Value: Integer   );
    procedure SetLeavetypeID          (const Value: Integer   );
    procedure SetLeaveDate           (const Value: TDateTime );
    procedure SetStarttime           (const Value: TDateTime );
    procedure SetEndtime             (const Value: TDateTime );
    procedure SetHours               (const Value: Double   );
    procedure SetActive              (const Value: Boolean   );
    Procedure SetEmployeeName        (const Value: String    );
    Procedure SetLeavetype        (const Value: String    );


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
    function Isworkingday(Dt:TDateTime):Boolean;
(*    Class function LeaveRequest(KeyID:Integer;DtFrom,DtTo:TDateTime; fiemployeeID:Integer ;fdHours:Double = 7.5;fconnection :TERPconnection=nil;AOwner:Tcomponent =nil):Boolean;Overload;
    function LeaveRequest(DtFrom,DtTo:TDateTime; fiemployeeID:Integer ;fdHours:Double = 7.5):Boolean;Overload;*)

  published
    property EmployeeId           :Integer     read GetEmployeeId         write SetEmployeeId      ;
    property LeavetypeID           :Integer     read GetLeavetypeID         write SetLeavetypeID      ;
    property LeaveDate            :TDateTime   read GetLeaveDate          write SetLeaveDate       ;
    property Starttime            :TDateTime   read GetStarttime          write SetStarttime       ;
    property Endtime              :TDateTime   read GetEndtime            write SetEndtime         ;
    property Hours                :Double     read GetHours              write SetHours           ;
    property Active               :Boolean     read GetActive             write SetActive          ;
    Property EmployeeName         :String      read GetEmployeeName       Write setEmployeeName    ;
    Property Leavetype         :String      read GetLeavetype       Write setLeavetype    ;

  end;


implementation


uses tcDataUtils, CommonLib , Sysutils, BusObjEmployee, BusObjLeavetypes,
  ManufactureLib,dateutils, AppEnvironment, BusObjConst;



  {TEmpLeaveRequests}

constructor TEmpLeaveRequests.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'EmpLeaveRequests';
  fSQL := 'SELECT * FROM tblEmployeeLeaveRequests';
end;


destructor TEmpLeaveRequests.Destroy;
begin
  inherited;
end;


(*Class function TEmpLeaveRequests.LeaveRequest(KeyID:Integer;DtFrom,DtTo:TDateTime; fiemployeeID:Integer ;fdHours:Double = 7.5;fconnection :TERPconnection=nil;AOwner:Tcomponent =nil):Boolean;
var
  EmpLeaveRequests : TEmpLeaveRequests;
begin
  EmpLeaveRequests := TEmpLeaveRequests.CreateWithNewConn(AOwner);
  try
    if Assigned(fConnection) then EmpLeaveRequests.Connection.Connection := fConnection;
    EmpLeaveRequests.Load(KeyID);
    Result := EmpLeaveRequests.LeaveRequest(DtFrom,DtTo,fiemployeeID,fdHours);
  finally
    FreeandNil(EmpLeaveRequests);
  end;
end;*)

{function TEmpLeaveRequests.LeaveRequest(DtFrom, DtTo: TDateTime;fiemployeeID: Integer; fdHours: Double): Boolean;
var
  dt:TDateTime;
  leavecreated:Boolean;
  fiSecs :Integer;
  Procedure UpdateLeaveRec;
  begin
            if DtTo <> DtFrom then New;
            if incSecond(DtTo, fisecs) > DayEnd(DtTo) then begin
                Leavedate := DtTo;
                starttime := DtTo;
                EmployeeId := fiEmployeeID;
                hours := SecondsBetween(DtTo , DayEnd(DtTo))/60/60;
                PostDB;
                fisecs := fisecs -SecondsBetween(DtTo , DayEnd(DtTo));
                DtTo := DayStart(incday(DtTo));
            end else begin
                Leavedate := DtTo;
                starttime := DtTo;
                EmployeeId := fiEmployeeID;
                hours := fisecs/60/60;
                PostDB;
                DtTo := incSecond(DtTo, fisecs);
                fisecs := 0;
            end;

  end;
begin
    Result:= False;
    connection.BeginNestedTransaction;
    try

          fiSecs := trunc(fdHours*60*60);
          DtTo := DtFrom;
          While fiSecs >0 do begin
            UpdateLeaveRec;
            Connection.CommitNestedTransaction;
          end;
    Except
      on E:Exception do begin
        Connection.RollbackNestedTransaction;
      end;
    end;
    (*try
      if (dtFrom =0) or (DtTo =0) or (dtFrom > DtTo) then begin
        Resultstatus.AddItem(False , rssError , 0,  'Date Range Selected is Invalid.' , True);
        Exit;
      end;

      Leavedate := dtFrom;
      starttime := dtFrom;
      EmployeeId := fiEmployeeID;
      hours := fdhours;
      PostDB;

      dt := StartofTheDay(incday(dtFrom, 1));
      leavecreated:=False;
      while dt <= DtTo do begin
        if Isworkingday(dt) then begin
          New;
          Leavedate  := dt;
          EmployeeId := fiEmployeeID;
          hours := fdhours;
          PostDB;
        end;
        dt := incday(dt,1);
        leavecreated := true;
      end;
      if leavecreated then begin
        Connection.CommitNestedTransaction;
        Result := True;
      end else begin
        Connection.RollbackNestedTransaction;
      end;
    Except
      on E:Exception do begin
        Connection.RollbackNestedTransaction;
      end;
    end;*)
end;    }

procedure TEmpLeaveRequests.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'EmployeeId');
  SetPropertyFromNode(node,'LeavetypeID');
  SetDateTimePropertyFromNode(node,'LeaveDate');
  SetDateTimePropertyFromNode(node,'Starttime');
  SetDateTimePropertyFromNode(node,'Endtime');
  SetPropertyFromNode(node,'Hours');
  SetBooleanPropertyFromNode(node,'Active');
  SetPropertyFromNode(node,'EmployeeName');
  SetPropertyFromNode(node,'Leavetype');
end;


procedure TEmpLeaveRequests.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'EmployeeId' ,EmployeeId);
  AddXMLNode(node,'LeavetypeID' ,LeavetypeID);
  AddXMLNode(node,'LeaveDate' ,LeaveDate);
  AddXMLNode(node,'Starttime' ,Starttime);
  AddXMLNode(node,'Endtime' ,Endtime);
  AddXMLNode(node,'Hours' ,Hours);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'EmployeeName' ,EmployeeName);
  AddXMLNode(node,'Leavetype' ,Leavetype);
end;


function TEmpLeaveRequests.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if EmployeeId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'EmployeeId should not be blank' , True);
    Exit;
  end;
  if LeaveDate = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'LeaveDate should not be blank' , True);
    Exit;
  end;
  if StartTime =0 then starttime := Leavedate + TimeOf(AppEnv.CompanyPrefs.StartOfDay);
  if endTime =0 then
    if hours <> 0 then endTime := incsecond(Starttime, trunc(hours*60*60))
    else begin
      endtime := Leavedate + TimeOf(AppEnv.CompanyPrefs.EndOfDay);
      hours := hoursbetween(Starttime,endtime);
    end;
  Result := True;
end;

function TEmpLeaveRequests.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TEmpLeaveRequests.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TEmpLeaveRequests.DoFieldOnChange(Sender: TField);
var
  fiSecs:Integer;
begin
  If (Sender.FieldKind <> FkData) Or Dataset.ControlsDisabled Then
    If Not DoFieldChangewhenDisabled Then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName, 'Employeename') then begin
    EmployeeID := TEmployee.IDToggle(EmployeeName, Connection.Connection);
  end else if Sysutils.SameText(Sender.FieldName, 'EmployeeID') then begin
    EmployeeName := TEmployee.IDToggle(EmployeeID, Connection.Connection);
  end else if Sysutils.SameText(Sender.FieldName, 'Leavetype') then begin
    LeavetypeID := TLeavetypes.IDToggle(Leavetype, Connection.Connection);
  end else if Sysutils.SameText(Sender.FieldName, 'LeavetypeID') then begin
     Leavetype:= TLeavetypes.IDToggle(LeavetypeID, Connection.Connection);
  end else if sametext(sender.FieldName , 'Hours') then begin
    fiSecs := trunc(hours*60*60);
    endtime := StartTime;
    While fiSecs >0 do begin
      if incSecond(endtime, fisecs) > DayEnd(endtime) then begin
        fisecs := fisecs -SecondsBetween(endtime , DayEnd(endtime));
        endtime := DayStart(incday(endTime));
      end else begin
        endtime := incSecond(endtime, fisecs);
        fisecs := 0;
      end;
    end;
    (*fiDays := trunc(Divzer(Hours, Appenv.CompanyPrefs.SecondsInaday /60/60));
    fiSecs := trunc(Hours*60*60 -  fidays*Appenv.CompanyPrefs.SecondsInaday);
    endtime  := Starttime;
    if fiDays >= 1 then endtime := incDay(endtime,fiDays);
    if fiSecs > 0 then endtime :=incSecond(endtime , fiSecs);*)
    SendEvent(BusobjEvent_change,Busobjeventval_LeaveDate, self);
  end else if sametext(sender.FieldName , 'Starttime') then begin
    LEaveDate := dateof(starttime);
    DoFieldOnChange(Dataset.FindField('LeaveDate'));
  end else if sametext(sender.FieldName , 'LeaveDate') then begin
    //while not(Isworkingday(LeaveDate)) do LeaveDate := incday(LeaveDate);
    try
      if (starttime =0) or (dateof(starttime) <> Leavedate) then starttime := DayStart(Leavedate );
      endtime := Dayend(Leavedate );
      hours := hoursbetween(Starttime,endtime);
      SendEvent(BusobjEvent_change,Busobjeventval_LeaveDate, self);
    Except
      on E:Exception do begin
        Resultstatus.AddItem(False , rssError , 0,  E.Message , True);
      end;
    end;
  end;
end;

function TEmpLeaveRequests.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

function TEmpLeaveRequests.Isworkingday(Dt: TDateTime): Boolean;
begin
  REsult := not(IsHoliday(dt)) and not(IsWeekendday(DayOfTheWeek(dt)));
end;

class function TEmpLeaveRequests.GetIDField: string;
begin
  Result := 'ID'
end;

class function TEmpLeaveRequests.GetBusObjectTablename: string;
begin
  Result:= 'tblEmployeeLeaveRequests';
end;

function TEmpLeaveRequests.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterInsert(Sender);
  if not(Result) then exit;
  LeaveDate := DayStart(incday(date,1));
end;

function TEmpLeaveRequests.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{Property Functions}
function  TEmpLeaveRequests.GetEmployeeId      : Integer   ; begin Result := GetIntegerField('EmployeeId');end;
function  TEmpLeaveRequests.GetLeavetypeID     : Integer   ; begin Result := GetIntegerField('LeavetypeID');end;
function  TEmpLeaveRequests.GetLeaveDate       : TDateTime ; begin Result := GetDateTimeField('LeaveDate');end;
function  TEmpLeaveRequests.GetStarttime       : TDateTime ; begin Result := GetDateTimeField('Starttime');end;
function  TEmpLeaveRequests.GetEndtime       : TDateTime ; begin Result := GetDateTimeField('Endtime');end;
function  TEmpLeaveRequests.GetHours           : Double    ; begin Result := GetFloatField('Hours');end;
function  TEmpLeaveRequests.GetActive          : Boolean   ; begin Result := GetBooleanField('Active');end;
Function  TEmpLeaveRequests.getEmployeeName    : String    ; begin Result := GetStringField('EmployeeName');end;
Function  TEmpLeaveRequests.getLeavetype       : String    ; begin Result := GetStringField('Leavetype');end;
procedure TEmpLeaveRequests.SetEmployeeId      (const Value: Integer   ); begin SetIntegerField('EmployeeId'       , Value);end;
procedure TEmpLeaveRequests.SetLeavetypeID     (const Value: Integer   ); begin SetIntegerField('LeavetypeID'       , Value);end;
procedure TEmpLeaveRequests.SetLeaveDate       (const Value: TDateTime ); begin SetDateTimeField('LeaveDate'        , Value);end;
procedure TEmpLeaveRequests.SetStarttime       (const Value: TDateTime ); begin SetDateTimeField('Starttime'        , Value);end;
procedure TEmpLeaveRequests.SetEndtime       (const Value: TDateTime ); begin SetDateTimeField('Endtime'        , Value);end;
procedure TEmpLeaveRequests.SetHours           (const Value: Double    ); begin SetFloatField('Hours'            , Value);end;
procedure TEmpLeaveRequests.SetActive          (const Value: Boolean   ); begin SetBooleanField('Active'           , Value);end;
Procedure TEmpLeaveRequests.SetEmployeeName    (Const Value: String    ); begin SetStringField('EmployeeName' , Value);end;
Procedure TEmpLeaveRequests.SetLeavetype       (Const Value: String    ); begin SetStringField('Leavetype' , Value);end;



initialization

  RegisterClass(TEmpLeaveRequests);


end.
