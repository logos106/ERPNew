unit BusObjCurFreqSettings;

{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 22/09/30 1.00.01 Wang  Added TCurrencyFrequencySettings business object.
}

interface

uses
  MyAccess,ERPdbComponents, DB, Dialogs, SysUtils, Variants, Classes,
  BusObjBase, XMLDoc, XMLIntf, commonlib;

type

  TCurrencyFrequencySettings = class(TMSBusObj)
  private
    function GetMEveryDay      : String;
    function GetMMonths        : String;
    function GetMStartDate     : TDate;
    function GetMStartTime     : TDateTime;
    function GetWEvery         : String;
    function GetWSelDays       : String;
    function GetWStartDate     : TDate;
    function GetWStartTime     : TDateTime;
    function GetDEvery         : String;
    function GetDEveryDay      : Boolean;
    function GetDStardDate     : TDate;
    function GetDStartTime     : TDateTime;
    function GetDWeekDays      : String;
    function GetOStartDate     : TDate;
    function GetOStartTime     : TDateTime;
    function GetEventLogout    : Boolean;
    function GetEventLogIn     : Boolean;
    function GetEmployeeID     : Integer;

    procedure SetMEveryDay     (Const Value : String);
    procedure SetMMonths       (Const Value : String);
    procedure SetMStartDate    (Const Value : TDate);
    procedure SetMStartTime    (Const Value : TDateTime);
    procedure SetwEvery        (Const Value : String);
    procedure SetWSelDays      (Const Value : String);
    procedure SetWStartDate    (Const Value : TDate);
    procedure SetWStartTime    (Const Value : TDateTime);
    procedure SetDEvery        (Const Value : String);
    procedure SetDEveryDay     (Const Value : Boolean);
    procedure SetDStardDate    (Const Value : TDate);
    procedure SetDStartTime    (Const Value : TDateTime);
    procedure SetDWeekDays     (Const Value : String);
    procedure SetOStartDate    (Const Value : TDate);
    procedure SetOStartTime    (Const Value : TDateTime);
    procedure SetEventLogout   (Const Value : Boolean);
    procedure SetEventLogIn    (Const Value : Boolean);
    procedure SetEmployeeID    (Const Value : Integer);

  protected
    function  DoAfterInsert(Sender: TDatasetBusObj)   : Boolean;    Override;
    function  DoAfterPost(Sender: TDatasetBusObj)     : Boolean;    Override;
    function  DoBeforePost(Sender: TDatasetBusObj)    : Boolean;    Override;
    function  GetSQL                                  : String;     Override;

  public
    Constructor     Create(AOwner: TComponent);             Override;
    destructor      Destroy;                                Override;
    procedure       DoFieldOnChange(Sender: TField);        Override;
    class function  GetBusObjectTablename: string;          Override;
    class function  GetIDField: string;                     Override;
    procedure       LoadFromXMLNode(Const node: IXMLNode);  Override;
    procedure       SaveToXMLNode(Const node: IXMLNode);    Override;
    function        ValidateData :Boolean ;                 Override;
    function        Save :Boolean ;                         Override;

  Published
    property MonthlyEveryDay      : String        read GetMEveryDay       write SetMEveryDay;
    property MonthlyOfMonths      : String        read GetMMonths         write SetMMonths;
    property MonthlyStartDate     : TDate         read GetMStartDate      Write SetMStartDate;
    Property MonthlyStartTime     : TDateTime     read GetMStartTime      write SetMStartTime;
    Property WeeklyEvery          : String        read GetwEvery          write SetwEvery;
    property WeeklySelectDays     : String        read GetWSelDays        write SetWSelDays;
    Property WeeklyStartDate      : TDate         read GetWStartDate      write SetWStartDate;
    Property WeeklyStartTime      : TDateTime     read GetWStartTime      write SetWStartTime;
    Property DailyEvery           : String        read GetDEvery          write SetDEvery;
    Property DailyEveryDay        : Boolean       read GetDEveryDay       write SetDEveryDay;
    Property DailyStartDate       : TDate         read GetDStardDate      write SetDStardDate;
    Property DailyStartTime       : TDateTime     read GetDStartTime      write SetDStartTime;
    Property DailyWeekDays        : String        read GetDWeekDays       write SetDWeekDays;
    Property OneTimeStartDate     : TDate         read GetOStartDate      write SetOStartDate;
    Property OneTimeStartTime     : TDateTime     read GetOStartTime      write SetOStartTime;
    Property OnEventLogOut        : Boolean       read GetEventLogout     write SetEventLogout;
    Property OnEventLogIn         : Boolean       read GetEventLogIn      write SetEventLogIn;
    Property EmployeeId           : Integer       read GetEmployeeID      write SetEmployeeID;

  end;

implementation

uses
   tcDataUtils, AppEnvironment, BusObjRegionalOptions,
   CommonDbLib, BusObjConst,  DNMLib, BusObjectListObj, BusObjSchemaLib,
   BusobjCountries, BusObjLocation, DbSharedObjectsObj, tcConst, Controls;


 { TCurrencyFrequencySettings }
Constructor TCurrencyFrequencySettings.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSql := 'SELECT * FROM tblcurfreqsettings';
  ExportExcludeList.Add('ID');
end;

destructor TCurrencyFrequencySettings.Destroy;
begin
  inherited;
end;

class function TCurrencyFrequencySettings.GetBusObjectTablename: string;
begin
  Result := 'tblcurfreqsettings';
end;

function TCurrencyFrequencySettings.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function  TCurrencyFrequencySettings.GetIDField :String;
begin
    Result := 'ID';
end;

procedure TCurrencyFrequencySettings.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

  inherited;
end;

function TCurrencyFrequencySettings.GetMEveryDay:   String;     begin Result := GetStringField('MEveryDay');        end;
function TCurrencyFrequencySettings.GetMMonths:     String;     begin Result := GetStringField('MMonths');          end;
function TCurrencyFrequencySettings.GetMStartDate:  TDate;      begin Result := GetDateTimeField('MStartDate');     end;
function TCurrencyFrequencySettings.GetMStartTime:  TDateTime;  begin Result := GetDateTimeField('MStartTime');     end;
function TCurrencyFrequencySettings.GetWEvery:      String;     begin Result := GetStringField('WEvery');           end;
function TCurrencyFrequencySettings.GetWSelDays:    String;     begin Result := GetStringField('WSelDays');        end;
function TCurrencyFrequencySettings.GetWStartDate:  TDate;      begin Result := GetDateTimeField('WStartDate');     end;
function TCurrencyFrequencySettings.GetWStartTime:  TDateTime;  begin Result := GetDateTimeField('WStartTime');     end;
function TCurrencyFrequencySettings.GetDEvery:      String;     begin Result := GetStringField('DEvery');           end;
function TCurrencyFrequencySettings.GetDEveryDay:   Boolean;    begin Result := GetBooleanField('DEveryDay');        end;
function TCurrencyFrequencySettings.GetDStardDate:  TDate;      begin Result := GetDateTimeField('DStartDate');     end;
function TCurrencyFrequencySettings.GetDStartTime:  TDateTime;  begin Result := GetDateTimeField('DStartTime');     end;
function TCurrencyFrequencySettings.GetDWeekDays:   String;     begin Result := GetStringField('DWeekDays');        end;
function TCurrencyFrequencySettings.GetOStartDate:  TDate;      begin Result := GetDateTimeField('OStartDate');     end;
function TCurrencyFrequencySettings.GetOStartTime:  TDateTime;  begin Result := GetDateTimeField('OStartTime');     end;
function TCurrencyFrequencySettings.GetEventLogout: Boolean;    begin Result := GetBooleanField('EventLogOut');      end;
function TCurrencyFrequencySettings.GetEventLogIn:  Boolean;    begin Result := GetBooleanField('EventLogIn');       end;
function TCurrencyFrequencySettings.GetEmployeeID:  Integer;    begin Result := GetIntegerField('EmployeeID');       end;

procedure TCurrencyFrequencySettings.SetMEveryDay   (Const Value: String);     begin SetStringField('MEveryDay', Value);        end;
procedure TCurrencyFrequencySettings.SetMMonths     (Const Value: String);     begin SetStringField('MMonths', Value);          end;
procedure TCurrencyFrequencySettings.SetMStartDate  (Const Value: TDate);      begin SetDateTimeField('MStartDate', Value);     end;
procedure TCurrencyFrequencySettings.SetMStartTime  (Const Value: TDateTime);  begin SetDateTimeField('MStartTime', Value);     end;
procedure TCurrencyFrequencySettings.SetWEvery      (Const Value: String);     begin SetStringField('WEvery', Value);           end;
procedure TCurrencyFrequencySettings.SetWSelDays    (Const Value: String);     begin SetStringField('WSelDays', Value);         end;
procedure TCurrencyFrequencySettings.SetWStartDate  (Const Value: TDate);      begin SetDateTimeField('WStartDate', Value);     end;
procedure TCurrencyFrequencySettings.SetWStartTime  (Const Value: TDateTime);  begin SetDateTimeField('WStartTime', Value);     end;
procedure TCurrencyFrequencySettings.SetDEvery      (Const Value: String);     begin SetStringField('DEvery', Value);           end;
procedure TCurrencyFrequencySettings.SetDEveryDay   (Const Value: Boolean);    begin SetBooleanField('DEveryDay', Value);       end;
procedure TCurrencyFrequencySettings.SetDStardDate  (Const Value: TDate);      begin SetDateTimeField('DStartDate', Value);     end;
procedure TCurrencyFrequencySettings.SetDStartTime  (Const Value: TDateTime);  begin SetDateTimeField('DStartTime', Value);     end;
procedure TCurrencyFrequencySettings.SetDWeekDays   (Const Value: String);     begin SetStringField('DWeekDays', Value);        end;
procedure TCurrencyFrequencySettings.SetOStartDate  (Const Value: TDate);      begin SetDateTimeField('OStartDate', Value);     end;
procedure TCurrencyFrequencySettings.SetOStartTime  (Const Value: TDateTime);  begin SetDateTimeField('OStartTime', Value);     end;
procedure TCurrencyFrequencySettings.SetEventLogout (Const Value: Boolean);    begin SetBooleanField('EventLogOut', Value);     end;
procedure TCurrencyFrequencySettings.SetEventLogIn  (Const Value: Boolean);    begin SetBooleanField('EventLogIn', Value);      end;
procedure TCurrencyFrequencySettings.SetEmployeeID  (Const Value: Integer);    begin SetIntegerField('EmployeeID', Value);      end;

procedure TCurrencyFrequencySettings.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'MEveryDay');
  SetPropertyFromNode(Node,'MMonths');
  SetPropertyFromNode(Node,'MStartDate');
  SetPropertyFromNode(Node,'MStartTime');
  SetPropertyFromNode(Node,'WEvery');
  SetPropertyFromNode(Node,'WSelDays');
  SetPropertyFromNode(Node,'WStartDate');
  SetPropertyFromNode(Node,'WStartTime');
  SetPropertyFromNode(Node,'DEvery');
  SetPropertyFromNode(Node,'DEveryDay');
  SetPropertyFromNode(Node,'DStartDate');
  SetPropertyFromNode(Node,'DStardTime');
  SetPropertyFromNode(Node,'DWeekDays');
  SetPropertyFromNode(Node,'OStartDate');
  SetPropertyFromNode(Node,'OStartTime');
  SetPropertyFromNode(Node,'EventLogout');
  SetPropertyFromNode(Node,'EventLogin');
  SetPropertyFromNode(Node,'EmployeeID');
end;

procedure TCurrencyFrequencySettings.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node , 'MEveryDay',    MonthlyEveryDay);
  AddXMLNode(node , 'MMonths',      MonthlyOfMonths);
  AddXMLNode(node , 'MStartDate',   MonthlyStartDate);
  AddXMLNode(node , 'MStartTime',   MonthlyStartTime);
  AddXMLNode(node , 'WEvery',       WeeklyEvery);
  AddXMLNode(node , 'WSelDays',     WeeklySelectDays);
  AddXMLNode(node , 'WStartDate',   WeeklyStartDate);
  AddXMLNode(node , 'WStartTime',   WeeklyStartTime);
  AddXMLNode(node , 'DEvery',       DailyEvery);
  AddXMLNode(node , 'DEveryDays',   DailyEveryDay);
  AddXMLNode(node , 'DStartDate',   DailyStartDate);
  AddXMLNode(node , 'DStartTime',   DailyStartTime);
  AddXMLNode(node , 'DWeekDays',    DailyWeekDays);
  AddXMLNode(node , 'OStartDate',   OneTimeStartDate);
  AddXMLNode(node , 'OStartTime',   OneTimeStartTime);
  AddXMLNode(node , 'EventLogOut',  OnEventLogout);
  AddXMLNode(node , 'EventLogIn',   OnEventLogIn);
  AddXMLNode(Node , 'EmployeeID',   EmployeeID);
end;

function TCurrencyFrequencySettings.ValidateData : Boolean;
var
  CleanCodeName: string;
begin
  Result := inherited ValidateData;
  if not Result then Exit;

  Result := False;
  Resultstatus.Clear;

  Result := True;
end;

function TCurrencyFrequencySettings.Save :Boolean ;
begin
    Result := False;
    if not ValidateData then Exit;
    result := inherited Save;
end;

function TCurrencyFrequencySettings.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result:= inherited DoAfterInsert(Sender);
  if not Result then exit;
end;

function TCurrencyFrequencySettings.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then Exit;
end;

function TCurrencyFrequencySettings.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not(Result) then Exit;
end;
initialization
  RegisterClassOnce(TCurrencyFrequencySettings);
end.

