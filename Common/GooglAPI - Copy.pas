unit GooglAPI;

interface

uses
  JsonObject, Contnrs, IdHttp, IDSSLOpenSSL, Classes, Generics.Collections;

type
  TTaskLists = class;


  TGoogleAPIConnection = class
  private
    fClient: TIdHttp;
    fConnected: boolean;
    function AddKey(aURL: string): string;
  public
    constructor Create;
    destructor Destroy; override;
    function Connect(aEmailAddress, aPassword: string): boolean;
    property Connected: boolean read fConnected;
    procedure Disconnect;
    function Get(aURL: string): string;
    function Post(aURL: string; stream: TStream): string; overload;
    function Post(aURL: string; data: string): string; overload;
    function Put(aURL: string; stream: TStream): string; overload;
    function Put(aURL: string; data: string): string; overload;
    procedure Delete(aURL: string);
  end;

  TCalendarList = class;

  TGoogle = class(TObject)
  private
    fConnection: TGoogleAPIConnection;
    fTaskLists: TTaskLists;
    fCalendarList: TCalendarList;
  public
    constructor Create;
    destructor Destroy; override;
    property Connection: TGoogleAPIConnection read fConnection;
    property TaskLists: TTaskLists read fTaskLists;
    property CalendarList: TCalendarList read fCalendarList;
  end;

  TGoogleBase = class(TObject)
  private
    fConnection: TGoogleAPIConnection;
    fLocalData,
    fAssignedData: TJsonObject;
    function GetAsString: string;
    function GetData: TJsonObject;
    function GetETag: string;
    function GetKind: string;
  protected
    procedure SetAsString(const Value: string); virtual;
    procedure SetData(const Value: TJsonObject); virtual;
  public
    constructor Create(aConnection: TGoogleAPIConnection); virtual;
    destructor Destroy; override;
    property Connection: TGoogleAPIConnection read fConnection;
    property Data: TJsonObject read GetData write SetData;
    property AsString: string read GetAsString write SetAsString;
    property kind: string read GetKind;
    property etag: string read GetETag;
  end;

  TGoogleIdBase = class(TGoogleBase)
  private
    function GetId: string;
    procedure SetId(const Value: string);
  public
    property id: string read GetId write SetId;
  end;

  TTasks = class;

  TTaskList = class(TGoogleIdBase)
  private
    fTasks: TTasks;
    fIsDefault: boolean;
    function GetselfLink: string;
    function GetTitle: string;
    function GetUpdated: TDateTime;
    procedure SetTitle(const Value: string);
    procedure SetUpdated(const Value: TDateTime);
  public
    constructor Create(aConnection: TGoogleAPIConnection); override;
    destructor Destroy; override;
    property title: string read GetTitle write SetTitle;
    property updated: TDateTime read GetUpdated write SetUpdated;
    property selfLink: string read GetselfLink;
    property IsDefault: boolean read fIsDefault write fIsDefault;
    property Tasks: TTasks read fTasks;
  end;


  TTaskLists = class(TGoogleBase)
  private
    fList: TObjectList<TTaskList>;
  protected
    procedure SetAsString(const Value: string); override;
  public
    function List: TObjectList<TTaskList>;
    procedure Insert(aTaskList: TTaskList);
    procedure Update(aTaskList: TTaskList);
    procedure Delete(aId: string);
    function ListByTitle(aTitle: string): TTaskList;
    function ListById(aId: string): TTaskList;
    function DefaultList: TTaskList;
    procedure ClearList;
    constructor Create(aConnection: TGoogleAPIConnection); override;
    destructor Destroy; override;
  end;

  TTaskLink = class(TObject)
  private
    function GetDescription: string;
    function GetLink: string;
    function GetLinkType: string;
    procedure SetDescription(const Value: string);
    procedure SetLink(const Value: string);
    procedure SetLinkType(const Value: string);
  public
    Data: TJsonObject;
    property linkType: string read GetLinkType write SetLinkType;   { eg email }
    property description: string read GetDescription write SetDescription; { The description. In HTML speak: Everything between <a> and </a> }
    property link: string read GetLink write SetLink; { the URL }
  end;


  TTask = class(TGoogleIdBase)
  private
    fLinkList: TObjectList<TTaskLink>;
    function GetCompleted: TDateTime;
    function GetDeleted: boolean;
    function GetDue: TDateTime;
    function GetHidden: boolean;
    function GetLinks: TObjectList<TTaskLink>;
    function GetNotes: string;
    function GetParent: string;
    function Getposition: string;
    function GetSelfLink: string;
    function GetStatus: string;
    function GetTitle: string;
    function GetUpdated: TDateTime;
    procedure SetCompleted(const Value: TDateTime);
    procedure SetDeleted(const Value: boolean);
    procedure SetDue(const Value: TDateTime);
    procedure SetHidden(const Value: boolean);
    procedure SetNotes(const Value: string);
    procedure SetParent(const Value: string);
    procedure SetPosition(const Value: string);
    procedure SetSelfLink(const Value: string);
    procedure SetStatus(const Value: string);
    procedure SetTitle(const Value: string);
    procedure SetUpdated(const Value: TDateTime);
  protected
    procedure SetAsString(const Value: string); override;
  public
    constructor Create(aConnection: TGoogleAPIConnection); override;
    destructor Destroy; override;
    property title : string read GetTitle write SetTitle;
    property updated: TDateTime read GetUpdated write SetUpdated;
    property selfLink: string read GetSelfLink write SetSelfLink;
    property parent: string read GetParent write SetParent;
    property position: string read Getposition write SetPosition;
    property notes: string read GetNotes write SetNotes;
    property status: string read GetStatus write SetStatus;
    property due: TDateTime read GetDue write SetDue;
    property completed: TDateTime read GetCompleted write SetCompleted;
    property deleted: boolean read GetDeleted write SetDeleted;
    property hidden: boolean read GetHidden write SetHidden;
    property links: TObjectList<TTaskLink> read GetLinks;
    procedure AddLink(aLinkType, aDescription, aLink: string);
  end;

  TTasks = class(TGoogleBase)
  private
    fList: TObjectList<TTask>;
    fOwner: TTaskList;
    FShowHidden: boolean;
    FShowCompleted: boolean;
    FShowDeleted: boolean;
    function GetList: TObjectList<TTask>;
    procedure SetShowCompleted(const Value: boolean);
    procedure SetShowHidden(const Value: boolean);
    procedure SetShowDeleted(const Value: boolean);
  public
    constructor Create(aOwner: TTaskList); reintroduce;
    destructor Destroy; override;
    property list: TObjectList<TTask> read GetList;
    procedure insert(aTask: TTask); overload;
    procedure insert(aTitle, aNotes: string); overload;
    procedure update(aTask: TTask);
    procedure delete(aId: string);
    function TaskById(aId: string): TTask;
    property ShowCompleted: boolean read FShowCompleted write SetShowCompleted;
    property ShowHidden: boolean read FShowHidden write SetShowHidden;
    property ShowDeleted: boolean read FShowDeleted write SetShowDeleted;
  end;

  TReminder = class(TObject)
  private
    fData: TJsonObject;
    function GetMethod: string;
    function GetMinutes: integer;
    procedure SetMethod(const Value: string);
    procedure SetMinutes(const Value: integer);
    function GetData: TJsonObject;
    procedure SetData(const Value: TJsonObject);
  published
  public
    constructor Create;
    property Data: TJsonObject read GetData write SetData;
    property method: string read GetMethod write SetMethod; { email, sms, popup }
    property minutes: integer read GetMinutes write SetMinutes;
  end;

  TCalendarEventList = class;

  TCalendarListEntry = class(TGoogleIdBase)
  private
    fDefaultReminders: TObjectList<TReminder>;
    fEventList: TCalendarEventList;
    function GetAccessRole: string;
    function GetBackgroundColor: string;
    function GetColorId: string;
    function GetForgroundColor: string;
    function GetPrimary: boolean;
    function GetSelected: boolean;
    function GetSummary: string;
    function GetTimeZone: string;
    procedure SetAccessRole(const Value: string);
    procedure SetBackgroundColor(const Value: string);
    procedure SetColorId(const Value: string);
    procedure SetForgroundColor(const Value: string);
    procedure SetPrimary(const Value: boolean);
    procedure SetSelected(const Value: boolean);
    procedure SetSummary(const Value: string);
    procedure SetTimeZone(const Value: string);
    function GetDefaultReminders: TObjectList<TReminder>;
  protected
    procedure SetAsString(const Value: string); override;
    procedure SetData(const Value: TJsonObject); override;
  public
    constructor Create(aConnection: TGoogleAPIConnection); override;
    destructor Destroy; override;
    property summary: string read GetSummary write SetSummary;
    property timeZone: string read GetTimeZone write SetTimeZone;
    property colorId: string read GetColorId write SetColorId;
    property backgroundColor: string read GetBackgroundColor write SetBackgroundColor;
    property forgroundColor: string read GetForgroundColor write SetForgroundColor;
    property selected: boolean read GetSelected write SetSelected;
    property accessRole: string read GetAccessRole write SetAccessRole; { freeBusyReader, reader, writer, owner }
    property primary: boolean read GetPrimary write SetPrimary;
    property defaultReminders: TObjectList<TReminder> read GetDefaultReminders;
    procedure AddDefaultReminder(aMethod: string; aMinutes: integer);
    property EventList: TCalendarEventList read fEventList;
  end;

  TCalendarList = class(TGoogleBase)
  private
    fList: TObjectList<TCalendarListEntry>;
    FshowHidden: boolean;
    function GetList: TObjectList<TCalendarListEntry>;
    procedure SetshowHidden(const Value: boolean);
  public
    constructor Create(aConnection: TGoogleAPIConnection); override;
    destructor Destroy; override;
    property list: TObjectList<TCalendarListEntry> read GetList;
    property showHidden: boolean read FshowHidden write SetshowHidden;
    function PrimaryCalendarListEntry: TCalendarListEntry;
    function ItemByName(aName: string): TCalendarListEntry;  { summary = aName }
  end;

  TGetJsonFunc = function: TJsonObject of object;

  TTaskEntity = class(TObject)
  private
    fDataFunc: TGetJsonFunc;
    function GetDisplayName: string;
    function GetEmail: string;
    function GetId: string;
    function GetSelf: boolean;
    procedure SetDisplayName(const Value: string);
    procedure SetEmail(const Value: string);
    procedure SetId(const Value: string);
    procedure SetSelf(const Value: boolean);
  public
    Constructor Create(DataFunc: TGetJsonFunc);
    property id: string read GetId write SetId;
    property email: string read GetEmail write SetEmail;
    property displayName: string read GetDisplayName write SetDisplayName;
    property self: boolean read GetSelf write SetSelf;
  end;

  TTaskStartEnd = class(TObject)
  private
    fDataFunc: TGetJsonFunc;
    function GetDate: TDate;
    function GetDateTime: TDateTime;
    function GetTimeZone: string;
    procedure SetDate(const Value: TDate);
    procedure SetDateTime(const Value: TDateTime);
    procedure SetTimeZone(const Value: string);
  public
    Constructor Create(DataFunc: TGetJsonFunc);
    property date: TDate read GetDate write SetDate;
    property dateTime: TDateTime read GetDateTime write SetDateTime;
    property timeZone: string read GetTimeZone write SetTimeZone;
  end;

  TAttendee = class(TObject)
  private
    fData: TJsonObject;
    function GetadditionalGuests: integer;
    function GetComment: string;
    function GetData: TJsonObject;
    function GetDisplayName: string;
    function GetEmail: string;
    function GetId: string;
    function GetOptional: boolean;
    function GetOrganizer: boolean;
    function GetResource: boolean;
    function GetResponseStatus: string;
    function GetSelf: boolean;
    procedure SetadditionalGuests(const Value: integer);
    procedure SetComment(const Value: string);
    procedure SetData(const Value: TJsonObject);
    procedure SetDisplayName(const Value: string);
    procedure SetEmail(const Value: string);
    procedure SetId(const Value: string);
    procedure SetOptional(const Value: boolean);
    procedure SetOrganizer(const Value: boolean);
    procedure SetResource(const Value: boolean);
    procedure SetResponseStatus(const Value: string);
    procedure SetSelf(const Value: boolean);
  public
    constructor Create;
    property Data: TJsonObject read GetData write SetData;
    property id: string read GetId write SetId;
    property email: string read GetEmail write SetEmail;
    property displayName: string read GetDisplayName write SetDisplayName;
    property organizer: boolean read GetOrganizer  write SetOrganizer;
    property self: boolean read GetSelf write SetSelf;
    property resource: boolean read GetResource write SetResource;
    property optional: boolean read GetOptional write SetOptional;
    property responseStatus: string read GetResponseStatus write SetResponseStatus;
    property comment: string read GetComment write SetComment;
    property additionalGuests: integer read GetadditionalGuests write SetadditionalGuests;
  end;

  TTaskReminders = class(TObject)
  private
    fDataFunc: TGetJsonFunc;
    fOverrides: TObjectList<TReminder>;
    function GetOverrides: TObjectList<TReminder>;
    function GetUseDefault: boolean;
    procedure SetUseDefault(const Value: boolean);
    procedure DoOnOverridesNotify(Sender: TObject; const Item: TReminder; Action: TCollectionNotification);
  public
    constructor Create(DataFunc: TGetJsonFunc);
    destructor Destroy; override;
    property useDefault: boolean read GetUseDefault write SetUseDefault;
    property Overrides: TObjectList<TReminder> read GetOverrides;
  end;

  TTaskSource = class(TObject)
  private
    fDataFunc: TGetJsonFunc;
    function GetTitle: string;
    function GetUrl: string;
    procedure SetTitle(const Value: string);
    procedure SetUrl(const Value: string);
  public
    Constructor Create(DataFunc: TGetJsonFunc);
    property url: string read GetUrl write SetUrl;
    property title: string read GetTitle write SetTitle;
  end;


  TCalendarEvent = class(TGoogleIdBase)
  private
    fCreator: TTaskEntity;
    fOrganizer: TTaskEntity;
    fStartTime: TTaskStartEnd;
    fEndTime: TTaskStartEnd;
    fRecurrence: TStringList;
    foriginalStartTime: TTaskStartEnd;
    fattendees: TObjectList<TAttendee>;
    FReminders: TTaskReminders;
    fSource: TTaskSource;
    function GetColorId: string;
    function GetCreated: TDateTime;
    function GetDescription: string;
    function GetHtmlLink: string;
    function GetLocation: string;
    function GetStatus: string;
    function GetSummary: string;
    function GetUpdated: TDateTime;
    procedure SetColorId(const Value: string);
    procedure SetCreated(const Value: TDateTime);
    procedure SetDescription(const Value: string);
    procedure SetHtmlLink(const Value: string);
    procedure SetLocation(const Value: string);
    procedure SetStatus(const Value: string);
    procedure SetSummary(const Value: string);
    procedure SetUpdated(const Value: TDateTime);
    function GetCreatorData: TJsonObject;
    function GetOrganizerData: TJsonObject;
    function GetStartTimeData: TJsonObject;
    function GetEndTimeData: TJsonObject;
    function GetRecurrence: TStringList;
    procedure DoRecurrenceOnChange(Sender: TObject);
    function GetOriginalStartTimeData: TJsonObject;
    function Getattendees: TObjectList<TAttendee>;
    function GetiCalUID: string;
    function Getsequence: integer;
    function Gettransparency: string;
    function Getvisibility: string;
    procedure SetiCalUID(const Value: string);
    procedure Setsequence(const Value: integer);
    procedure Settransparency(const Value: string);
    procedure Setvisibility(const Value: string);
    procedure DoOnAttendeesNotify(Sender: TObject; const Item: TAttendee; Action: TCollectionNotification);
    function GetanyoneCanAddSelf: boolean;
    function GetattendeesOmitted: boolean;
    function GetguestsCanInviteOthers: boolean;
    function GetguestsCanModify: boolean;
    function GetguestsCanSeeOtherGuests: boolean;
    function GethangoutLink: string;
    function Getlocked: boolean;
    function GetprivateCopy: boolean;
    procedure SetanyoneCanAddSelf(const Value: boolean);
    procedure SetattendeesOmitted(const Value: boolean);
    procedure SetguestsCanInviteOthers(const Value: boolean);
    procedure SetguestsCanModify(const Value: boolean);
    procedure SetguestsCanSeeOtherGuests(const Value: boolean);
    procedure SethangoutLink(const Value: string);
    procedure Setlocked(const Value: boolean);
    procedure SetprivateCopy(const Value: boolean);
    function GetRemindersData: TJsonObject;
    function GetSourceData: TJsonObject;
  public
    constructor Create(aConnection: TGoogleAPIConnection); override;
    destructor Destroy; override;
    property status: string read GetStatus write SetStatus;
    property htmlLink: string read GetHtmlLink write SetHtmlLink;
    property created: TDateTime read GetCreated write SetCreated;
    property updated: TDateTime read GetUpdated write SetUpdated;
    property summary: string read GetSummary write SetSummary;
    property description: string read GetDescription write SetDescription;
    property location: string read GetLocation write SetLocation;
    property colorId: string read GetColorId write SetColorId;
    property creator: TTaskEntity read fCreator;
    property organizer: TTaskEntity read fOrganizer;
    property startTime: TTaskStartEnd read fStartTime;
    property endTime: TTaskStartEnd read fEndTime;
    property recurrence: TStringList read GetRecurrence;
    property originalStartTime: TTaskStartEnd read foriginalStartTime;
    property transparency: string read Gettransparency write Settransparency;
    property visibility: string read Getvisibility write Setvisibility;
    property iCalUID: string read GetiCalUID write SetiCalUID;
    property sequence: integer read Getsequence write Setsequence;
    property attendees: TObjectList<TAttendee> read Getattendees;
    property attendeesOmitted: boolean read GetattendeesOmitted write SetattendeesOmitted;
   {property extendedProperties}
    property hangoutLink: string read GethangoutLink write SethangoutLink;
   {property gaget}
    property anyoneCanAddSelf: boolean read GetanyoneCanAddSelf write SetanyoneCanAddSelf;
    property guestsCanInviteOthers: boolean read GetguestsCanInviteOthers write SetguestsCanInviteOthers;
    property guestsCanModify: boolean read GetguestsCanModify write SetguestsCanModify;
    property guestsCanSeeOtherGuests: boolean read GetguestsCanSeeOtherGuests write SetguestsCanSeeOtherGuests;
    property privateCopy: boolean read GetprivateCopy write SetprivateCopy;
    property locked: boolean read Getlocked write Setlocked;
    property reminders: TTaskReminders read FReminders;
    property source: TTaskSource read fSource;
  end;

  TCalendarEventList = class(TGoogleBase)
  private
    fCalendarId: string;
    fList: TObjectList<TCalendarEvent>;
    ForderBy: string;
    FshowHiddenInvitations: boolean;
    FupdatedMin: TDateTime;
    FtimeMax: TDateTime;
    Fq: string;
    FtimeMin: TDateTime;
    FshowDeleted: boolean;
    FsingleEvents: boolean;
    function GetList: TObjectList<TCalendarEvent>;
    procedure SetorderBy(const Value: string);
    procedure Setq(const Value: string);
    procedure SetshowDeleted(const Value: boolean);
    procedure SetshowHiddenInvitations(const Value: boolean);
    procedure SettimeMax(const Value: TDateTime);
    procedure SettimeMin(const Value: TDateTime);
    procedure SetupdatedMin(const Value: TDateTime);
    procedure SetsingleEvents(const Value: boolean);
  public
    constructor Create(aConnection: TGoogleAPIConnection; aCalendarId: string); reintroduce;
    destructor Destroy; override;
    property list: TObjectList<TCalendarEvent> read GetList;
    property orderBy: string read ForderBy write SetorderBy; {startTime, updated or blank}
    property q: string read Fq write Setq; {Free text search terms to find events that match these terms in any field, except for extended properties. Optional.}
    property showDeleted: boolean read FshowDeleted write SetshowDeleted;
    property showHiddenInvitations: boolean read FshowHiddenInvitations write SetshowHiddenInvitations;
    property timeMax: TDateTime read FtimeMax write SettimeMax;
    property timeMin: TDateTime read FtimeMin write SettimeMin;
    property updatedMin: TDateTime read FupdatedMin write SetupdatedMin;
    property singleEvents: boolean read FsingleEvents write SetsingleEvents;
    property CalendarId: string read fCalendarId write fCalendarId;
    procedure insert(aEvent: TCalendarEvent);
    procedure update(aEvent: TCalendarEvent);
    procedure delete(aId: string);
    function EventById(aId: string): TCalendarEvent;
  end;


implementation

uses
  DateTimeUtils, SysUtils, URILib, StringUtils;

const
  fVersion = '12.0.0.0';
  fUserAgent = 'TrueERP/' + fVersion + ' (compatible; Indy Library)';
  fAPIKey = 'AIzaSyC0_PSP02PRqWmjAhm0ng4if1zWzDg0FHc';


{ TGoogleAPIConnection }

function TGoogleAPIConnection.AddKey(aURL: string): string;
begin
  if Pos('?',aURL) = 0 then
    result := aURL + '?key=' + fAPIKey
  else
    result := aURL + '&key=' + fAPIKey;
end;

function TGoogleAPIConnection.Connect(aEmailAddress,
  aPassword: string): boolean;
var
  sl, authSL: TStringList;
  fAuth: string;
begin
  fConnected := false;
  if aEmailAddress = '' then begin
    raise exception.Create(self.ClassName + ' - No Email Address specified');
  end;
  if aPassword = '' then begin
    raise exception.Create(self.ClassName + ' - No Password specified');
  end;
  SL := TStringList.Create;
  authSL := TStringList.Create;
  try
    fClient.Request.ContentType := 'application/x-www-form-urlencoded';
    try
      authSL.Values['accountType']:= 'HOSTED_OR_GOOGLE';
      authSL.Values['Email']:= aEmailAddress;
      authSL.Values['Passwd']:= aPassword;
      authSL.Values['source']:= fUserAgent;
      authSL.Values['service']:= 'cl'; {calendar api}
      sl.Text := fClient.Post('https://www.google.com/accounts/ClientLogin',authSL);
      fAuth := sl.Values['Auth'];
      //fSID := sl.Values['SID'];
      //fLSID := sl.Values['LSID'];
      fClient.Request.CustomHeaders.Values['Authorization'] := 'GoogleLogin auth='+ fAuth;
      fConnected := true;
    finally
      fClient.Request.ContentType := 'application/json';
    end;
  finally
    authSL.Free;
    SL.Free;
  end;
  result := fConnected;
end;

constructor TGoogleAPIConnection.Create;
var
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
begin
  fConnected:= false;
  fClient := TIdHttp.Create(nil);
  SSLHandler:= TIdSSLIOHandlerSocketOpenSSL.Create(fClient);
  fClient.IOHandler:= SSLHandler;
//  fClient.Request.ContentType := 'application/x-www-form-urlencoded';
  fClient.Request.ContentType := 'application/json';
end;

procedure TGoogleAPIConnection.Delete(aURL: string);
begin
  if not Connected then raise Exception.Create(self.ClassName + ' - Not connected');
  fClient.Delete(AddKey(aURL));
end;

destructor TGoogleAPIConnection.Destroy;
begin
  fClient.Free;
  inherited;
end;

procedure TGoogleAPIConnection.Disconnect;
begin
  fConnected := false;
end;

function TGoogleAPIConnection.Get(aURL: string): string;
begin
  if not Connected then raise Exception.Create(self.ClassName + ' - Not connected');
  result := fClient.Get(AddKey(aURL));
end;

function TGoogleAPIConnection.Post(aURL: string; stream: TStream): string;
begin
  if not Connected then raise Exception.Create(self.ClassName + ' - Not connected');
  result := fClient.Post(AddKey(aURL), stream);
end;

function TGoogleAPIConnection.Post(aURL, data: string): string;
var
  sl: TStringList;
begin
  if not Connected then raise Exception.Create(self.ClassName + ' - Not connected');
  sl := TStringList.Create;
  try
    sl.Text := data;
    result := fClient.Post(AddKey(aURL), sl);
  finally
    sl.Free;
  end;
end;

function TGoogleAPIConnection.Put(aURL: string; stream: TStream): string;
begin
  if not Connected then raise Exception.Create(self.ClassName + ' - Not connected');
  result := fClient.Put(AddKey(aURL), stream);
end;

function TGoogleAPIConnection.Put(aURL, data: string): string;
var
  stream: TStringStream;
begin
  if not Connected then raise Exception.Create(self.ClassName + ' - Not connected');
  stream := TStringStream.Create(data);
  try
    result := Put(aURL,stream);
  finally
    stream.Free;
  end;
end;

{ TGoogle }

constructor TGoogle.Create;
begin
  fConnection := TGoogleAPIConnection.Create;
  fTaskLists := TTaskLists.Create(self.Connection);
  fCalendarList := TCalendarList.Create(self.Connection);
end;


destructor TGoogle.Destroy;
begin
  fTaskLists.Free;
  fConnection.Free;
  inherited;
end;

{ TGoogleBase }

constructor TGoogleBase.Create(aConnection: TGoogleAPIConnection);
begin
  fConnection := aConnection;
  fAssignedData := nil;
  fLocalData := nil;
end;

destructor TGoogleBase.Destroy;
begin
  flocalData.Free;
  inherited;
end;

function TGoogleBase.GetAsString: string;
begin
  result := Data.AsString;
end;

function TGoogleBase.GetData: TJsonObject;
begin
  if Assigned(fAssignedData) then
    result := fAssignedData
  else begin
    if not Assigned(fLocalData) then
      fLocalData := JO;
    result := fLocalData;
  end;
end;

function TGoogleBase.GetETag: string;
begin
  result := Data.S['etag'];
end;

function TGoogleBase.GetKind: string;
begin
  result := Data.S['kind'];
end;

procedure TGoogleBase.SetAsString(const Value: string);
begin
  Data.AsString := Value;
end;

procedure TGoogleBase.SetData(const Value: TJsonObject);
begin
  fAssignedData := Value;
end;

{ TGoogleIdBase }

function TGoogleIdBase.GetId: string;
begin
  result := Data.S['id'];
end;

procedure TGoogleIdBase.SetId(const Value: string);
begin
  Data.S['id'] := Value;
end;


{ TTaskList }

constructor TTaskList.Create(aConnection: TGoogleAPIConnection);
begin
  inherited;
  fTasks := TTasks.Create(self);
  IsDefault := false;
end;

destructor TTaskList.Destroy;
begin
  fTasks.Free;
  inherited;
end;

function TTaskList.GetselfLink: string;
begin
  result := Data.S['selfLink'];
end;

function TTaskList.GetTitle: string;
begin
  result :=Data.S['title'];
end;

function TTaskList.GetUpdated: TDateTime;
begin
  result := RFC3339StrToDateTimeLocal(data.S['updated']);
end;

procedure TTaskList.SetTitle(const Value: string);
begin
  Data.S['title'] := Value;
end;

procedure TTaskList.SetUpdated(const Value: TDateTime);
begin
  Data.S['updated'] := DateTimeLocalToRFC3339Str(Value);
end;

{ TTaskLists }

procedure TTaskLists.ClearList;
begin
  fList.Clear;
end;

constructor TTaskLists.Create(aConnection: TGoogleAPIConnection);
begin
  inherited;
  fList := TObjectList<TTaskList>.Create(true);
end;

function TTaskLists.DefaultList: TTaskList;
var
  defList: TTaskList;
begin
  result := nil;
  for defList in List do begin
    if defList.IsDefault then begin
      result := defList;
      break;
    end;
  end;
end;

procedure TTaskLists.Delete(aId: string);
var
  item: TTaskList;
begin
  fConnection.Delete('https://www.googleapis.com/tasks/v1/users/@me/lists/' + aId);
  item := ListById(aId);
  if Assigned(item) then begin
    Data.A['list'].Delete(item);
    fList.Delete(fLIst.IndexOf(item));
  end;
end;

destructor TTaskLists.Destroy;
begin
  fList.Free;
  inherited;
end;

procedure TTaskLists.Insert(aTaskList: TTaskList);
var
  j: TJsonObject;
begin
  List; { force loading of list }
  j := JO;
  j.AsString := fConnection.Post('https://www.googleapis.com/tasks/v1/users/@me/lists',StringReplace(aTaskLIst.AsString,#13#10,'',[rfReplaceAll]));
  Data.A['items'].Add(j);
  aTaskList.Data := j;
  fList.Add(aTaskList);
end;

function TTaskLists.List: TObjectLIst<TTaskList>;
var
  j, newJ: TJsonObject;
  x: integer;
  taskList: TTaskList;
  npToken: string;
begin
  if fList.Count = 0 then begin
    j := JO;
    try
      self.AsString := fConnection.Get('https://www.googleapis.com/tasks/v1/users/@me/lists');
      if Data.StringExists('nextPageToken') then begin
        npToken := Data.S['nextPageToken'];
        repeat
          j.AsString := fConnection.Get('https://www.googleapis.com/tasks/v1/users/@me/lists?pageToken=' + npToken);
          npToken := j.S['nextPageToken'];
          for x := 0 to J.A['items'].Count -1 do begin
            newJ := JO;
            newJ.Assign(J.A['items'].Items[x].AsObject);
            Data.A['items'].Add(newJ);
          end;
        until npToken <> '';
      end;
      for x := 0 to Data.A['items'].Count -1 do begin
        taskList := TTaskList.Create(fConnection);
        taskList.Data := Data.A['items'].Items[x].AsObject;
        fList.Add(taskList);
      end;
      { get the default }
      J.AsString := fConnection.Get('https://www.googleapis.com/tasks/v1/users/@me/lists/%40default');
      taskList := self.ListById(J.S['id']);
      if Assigned(taskList) then
        taskList.IsDefault := true;

    finally
      j.Free;
    end;
  end;
  result := fList;
end;

function TTaskLists.ListById(aId: string): TTaskList;
var
  item: TTaskList;
begin
  result := nil;
  for item in List do begin
    if SameText(item.id, aId) then begin
      result := item;
      break;
    end;
  end;
end;

function TTaskLists.ListByTitle(aTitle: string): TTaskList;
var
  item: TTaskList;
begin
  result := nil;
  for item in List do begin
    if SameText(item.title, aTitle) then begin
      result := item;
      break;
    end;
  end;
end;

procedure TTaskLists.SetAsString(const Value: string);
begin
  inherited;
end;

procedure TTaskLists.Update(aTaskList: TTaskList);
var
  j: TJsonObject;
begin
  j := JO;
  try
    j.AsString := fConnection.Put('https://www.googleapis.com/tasks/v1/users/@me/lists/'+aTaskList.id,StringReplace(aTaskLIst.AsString,#13#10,'',[rfReplaceAll]));
    aTaskList.Data.Assign(j);
  finally
    j.Free;
  end;
end;

{ TTaskLink }

function TTaskLink.GetDescription: string;
begin
  result := data.S['description'];
end;

function TTaskLink.GetLink: string;
begin
  result := data.S['link'];
end;

function TTaskLink.GetLinkType: string;
begin
  result := data.S['type'];
end;

procedure TTaskLink.SetDescription(const Value: string);
begin
  data.S['description'] := Value;
end;

procedure TTaskLink.SetLink(const Value: string);
begin
  data.S['link'] := Value;
end;

procedure TTaskLink.SetLinkType(const Value: string);
begin
  data.S['type'] := Value;
end;


{ TTask }

procedure TTask.AddLink(aLinkType, aDescription, aLink: string);
var
  item: TTaskLink;
  j: TJsonObject;
begin
  j := JO;
  item := TTaskLink.Create;
  item.Data := j;
  item.linkType := aLinkType;
  item.description := aDescription;
  item.link := aLink;
  fLinkList.Add(item);
end;

constructor TTask.Create(aConnection: TGoogleAPIConnection);
begin
  inherited;
  fLinkList := TObjectList<TTaskLink>.CReate(true);
end;

destructor TTask.Destroy;
begin
  fLinkList.Free;
  inherited;
end;

function TTask.GetCompleted: TDateTime;
begin
  result := RFC3339StrToDateTimeLocal(Data.S['completed']);
end;

function TTask.GetDeleted: boolean;
begin
  result := Data.B['deleted'];
end;

function TTask.GetDue: TDateTime;
begin
  result := RFC3339StrToDateTimeLocal(Data.S['due']);
end;

function TTask.GetHidden: boolean;
begin
  result := Data.B['hidden'];
end;

function TTask.GetLinks: TObjectList<TTaskLink>;
begin
  result := fLinkList;
end;

function TTask.GetNotes: string;
begin
  result := Data.S['notes'];
end;

function TTask.GetParent: string;
begin
  result := Data.S['parent'];
end;

function TTask.Getposition: string;
begin
  result := Data.S['position'];
end;

function TTask.GetSelfLink: string;
begin
  result := Data.S['selfLink'];
end;

function TTask.GetStatus: string;
begin
  result := Data.S['status'];
end;

function TTask.GetTitle: string;
begin
  result := Data.S['title'];
end;

function TTask.GetUpdated: TDateTime;
begin
  result := RFC3339StrToDateTimeLocal(Data.S['updated']);
end;

procedure TTask.SetAsString(const Value: string);
var
  x: integer;
  item: TTaskLink;
begin
  inherited;
  fLinkList.Clear;
  for x := 0 to Data.A['links'].Count -1 do begin
    item:= TTaskLink.Create;
    item.Data := Data.A['links'].Items[x].AsObject;
    fLinkList.Add(item);
  end;
end;

procedure TTask.SetCompleted(const Value: TDateTime);
begin
  Data.S['completed'] := DateTimeLocalToRFC3339Str(Value);
end;

procedure TTask.SetDeleted(const Value: boolean);
begin
  Data.B['deleted'] := Value;
end;

procedure TTask.SetDue(const Value: TDateTime);
begin
  Data.S['due'] := DateTimeLocalToRFC3339Str(Value);
end;

procedure TTask.SetHidden(const Value: boolean);
begin
  Data.B['hidden'] := Value;
end;

procedure TTask.SetNotes(const Value: string);
begin
  Data.S['notes'] := Value;
end;

procedure TTask.SetParent(const Value: string);
begin
  Data.S['parent'] := Value;
end;

procedure TTask.SetPosition(const Value: string);
begin
  Data.S['position'] := Value;
end;

procedure TTask.SetSelfLink(const Value: string);
begin
  Data.S['selfLink'] := Value;
end;

procedure TTask.SetStatus(const Value: string);
begin
  Data.S['status'] := Value;
end;

procedure TTask.SetTitle(const Value: string);
begin
  Data.S['title'] := Value;
end;

procedure TTask.SetUpdated(const Value: TDateTime);
begin
  Data.S['updated'] := DateTimeLocalToRFC3339Str(Value);
end;

{ TTasks }

constructor TTasks.Create(aOwner: TTaskList);
begin
  fOwner := aOwner;
  fList := TObjectList<TTask>.Create(true);
  FShowCompleted := true;
  FShowHidden := false;
  FShowDeleted := true;
end;

procedure TTasks.delete(aId: string);
var
  item: TTask;
begin
  fConnection.Delete('https://www.googleapis.com/tasks/v1/lists/'+ fOwner.id + '/tasks/'+ aId);
  item := TaskById(aId);
  if Assigned(item) then begin
    Data.A['list'].Delete(item);
    fList.Delete(fLIst.IndexOf(item));
  end;
end;

destructor TTasks.Destroy;
begin
  fList.Free;
  inherited;
end;

function TTasks.GetList: TObjectList<TTask>;
var
  url: string;
  npToken: string;
  j, newJ: TJsonObject;
  x: integer;
  item: TTask;
begin
  if fList.Count = 0 then begin
    url := 'https://www.googleapis.com/tasks/v1/lists/' + fOwner.id + '/tasks' +
        '?showCompleted=' + Lowercase(BoolToStr(ShowCompleted,true)) +
        '&showDeleted=' + Lowercase(BoolToStr(ShowDeleted,true)) +
        '&showHidden=' + Lowercase(BoolToStr(ShowHidden,true));

    J := JO;
    try
      Data.AsString := fOwner.Connection.Get(url);
      npToken := Data.S['nextPageToken'];
      while npToken <> '' do begin
        J.AsString := fOwner.Connection.Get(url+ '&pageToken=' + npToken);
        npToken := J.S['nextPageToken'];
        for x := 0 to J.A['items'].Count -1 do begin
          newJ := JO;
          newJ.Assign(J.A['items'].Items[x].AsObject);
          Data.A['items'].Add(newJ);
        end;
      end;
    finally
      J.Free;
    end;
    for x := 0 to Data.A['items'].Count -1 do begin
      item := TTask.Create(fOwner.Connection);
      item.Data := Data.A['items'].Items[x].AsObject;
      fList.Add(item);
    end;
  end;
  result := fList;
end;

procedure TTasks.insert(aTitle, aNotes: string);
var
  newTask: TTask;
begin
  inherited;
  newTask := TTask.Create(self.fOwner.Connection);
  newTask.title := aTitle;
  newTask.notes := aNotes;
  insert(newTask);
end;

procedure TTasks.insert(aTask: TTask);
var
  j: TJsonObject;
begin
  List; { force loading of list }
  j := JO;
  j.AsString := fConnection.Post('https://www.googleapis.com/tasks/v1/lists/'+fOwner.id+'/tasks',StringReplace(aTask.AsString,#13#10,'',[rfReplaceAll]));
  Data.A['items'].Add(j);
  aTask.Data := j;
  fList.Add(aTask);
end;

procedure TTasks.SetShowCompleted(const Value: boolean);
begin
  FShowCompleted := Value;
  fList.Clear;
end;

procedure TTasks.SetShowDeleted(const Value: boolean);
begin
  FShowDeleted := Value;
end;

procedure TTasks.SetShowHidden(const Value: boolean);
begin
  FShowHidden := Value;
  fList.Clear;
end;

function TTasks.TaskById(aId: string): TTask;
var
  aTask: TTask;
begin
  result := nil;
  for aTask in List do begin
    if aTask.id = aId then begin
      result := aTask;
      break;
    end;
  end;
end;

procedure TTasks.update(aTask: TTask);
var
  j: TJsonObject;
begin
  j := JO;
  try
    j.AsString := fConnection.Put('https://www.googleapis.com/tasks/v1/lists/'+ fOwner.id +'/tasks/'+aTask.id,StringReplace(aTask.AsString,#13#10,'',[rfReplaceAll]));
    aTask.Data.Assign(j);
  finally
    j.Free;
  end;
end;

{ TReminder }

constructor TReminder.Create;
begin
  fData := nil;
end;

function TReminder.GetData: TJsonObject;
begin
  if not Assigned(fData) then
    fData := JO;
  result := fData;
end;

function TReminder.GetMethod: string;
begin
  result := Data.S['method'];
end;

function TReminder.GetMinutes: integer;
begin
  result := Data.I['minutes'];
end;

procedure TReminder.SetData(const Value: TJsonObject);
begin
  fData.Free;
  fData := Value;
end;

procedure TReminder.SetMethod(const Value: string);
begin
  Data.S['method'] := Value;
end;

procedure TReminder.SetMinutes(const Value: integer);
begin
  Data.I['minutes'] := Value;
end;

{ TCalendarListEntry }

procedure TCalendarListEntry.AddDefaultReminder(aMethod: string;
  aMinutes: integer);
var
  rem: TReminder;
begin
  rem := TReminder.Create;
  rem.Data := JO;
  rem.method := aMethod;
  rem.minutes := aMinutes;
  Data.A['defaultReminders'].Add(rem.Data);
  fDefaultReminders.Add(rem);
end;

constructor TCalendarListEntry.Create(aConnection: TGoogleAPIConnection);
begin
  inherited;
  fDefaultReminders := nil;
  fEventList := TCalendarEventList.Create(fConnection,self.id);
end;

destructor TCalendarListEntry.Destroy;
begin
  fDefaultReminders.Free;
  inherited;
end;

function TCalendarListEntry.GetAccessRole: string;
begin
  result := Data.S['accessRole'];
end;

function TCalendarListEntry.GetBackgroundColor: string;
begin
  result := Data.S['backgroundColor'];
end;

function TCalendarListEntry.GetColorId: string;
begin
  result := Data.S['colorId'];
end;

function TCalendarListEntry.GetDefaultReminders: TObjectList<TReminder>;
var
  x: integer;
  rem: TReminder;
begin
  if not Assigned(fDefaultReminders) then begin
    fDefaultReminders := TObjectList<TReminder>.Create(true);
    for x := 0 to Data.A['defaultReminders'].Count -1 do begin
      rem := TReminder.Create;
      rem.Data := Data.A['defaultReminders'].Items[x].AsObject;
      fDefaultReminders.Add(rem);
    end;
  end;
  result := fDefaultReminders;
end;

function TCalendarListEntry.GetForgroundColor: string;
begin
  result := Data.S['forgroundColor'];
end;

function TCalendarListEntry.GetPrimary: boolean;
begin
  result := Data.B['primary'];
end;

function TCalendarListEntry.GetSelected: boolean;
begin
  result := Data.B['selected'];
end;

function TCalendarListEntry.GetSummary: string;
begin
  result := Data.S['summary'];
end;

function TCalendarListEntry.GetTimeZone: string;
begin
  result := Data.S['timeZone'];
end;

procedure TCalendarListEntry.SetAccessRole(const Value: string);
begin
  Data.S['accessRole'] := Value;
end;

procedure TCalendarListEntry.SetAsString(const Value: string);
begin
  inherited;
  FreeAndNil(fDefaultReminders);
  EventList.CalendarId := id;
end;

procedure TCalendarListEntry.SetBackgroundColor(const Value: string);
begin
  Data.S['backgroundColor'] := Value;
end;

procedure TCalendarListEntry.SetColorId(const Value: string);
begin
  Data.S['colorId'] := Value;
end;

procedure TCalendarListEntry.SetData(const Value: TJsonObject);
begin
  inherited;
  EventList.CalendarId := id;
  FreeAndNil(fDefaultReminders);
end;

procedure TCalendarListEntry.SetForgroundColor(const Value: string);
begin
  Data.S['forgroundColor'] := Value;
end;

procedure TCalendarListEntry.SetPrimary(const Value: boolean);
begin
  Data.B['primary'] := Value;
end;

procedure TCalendarListEntry.SetSelected(const Value: boolean);
begin
  Data.B['selected'] := Value;
end;

procedure TCalendarListEntry.SetSummary(const Value: string);
begin
  Data.S['summary'] := Value;
end;

procedure TCalendarListEntry.SetTimeZone(const Value: string);
begin
  Data.S['timeZone'] := Value;
end;

{ TCalendarList }

constructor TCalendarList.Create(aConnection: TGoogleAPIConnection);
begin
  inherited;
  fList := TObjectList<TCalendarListEntry>.Create(true);
  FShowHidden := false;
end;

destructor TCalendarList.Destroy;
begin

  inherited;
end;

function TCalendarList.GetList: TObjectList<TCalendarListEntry>;
var
  url: string;
  npToken: string;
  j, newJ: TJsonObject;
  x: integer;
  item: TCalendarListEntry;
begin
  if fList.Count = 0 then begin
    url := 'https://www.googleapis.com/calendar/v3/users/me/calendarList' +
        '?showHidden=' + Lowercase(BoolToStr(ShowHidden,true));

    J := JO;
    try
      Data.AsString := fConnection.Get(url);
      npToken := Data.S['nextPageToken'];
      while npToken <> '' do begin
        J.AsString := fConnection.Get(url+ '&pageToken=' + npToken);
        npToken := J.S['nextPageToken'];
        for x := 0 to J.A['items'].Count -1 do begin
          newJ := JO;
          newJ.Assign(J.A['items'].Items[x].AsObject);
          Data.A['items'].Add(newJ);
        end;
      end;
    finally
      J.Free;
    end;
    for x := 0 to Data.A['items'].Count -1 do begin
      item := TCalendarListEntry.Create(fConnection);
      item.Data := Data.A['items'].Items[x].AsObject;
      fList.Add(item);
    end;
  end;
  result := fList;
end;

function TCalendarList.ItemByName(aName: string): TCalendarListEntry;
var
  item: TCalendarListEntry;
begin
  result := nil;
  for item in List do begin
    if SameText(item.summary, aName) then begin
      result := item;
      break;
    end;
  end;
end;

function TCalendarList.PrimaryCalendarListEntry: TCalendarListEntry;
var
  item: TCalendarListEntry;
begin
  result := nil;
  for item in List do begin
    if item.primary then begin
      result := item;
      break;
    end;
  end;
end;

procedure TCalendarList.SetshowHidden(const Value: boolean);
begin
  FshowHidden := Value;
  fList.Clear;
end;

{ TTaskEntity }

constructor TTaskEntity.Create(DataFunc: TGetJsonFunc);
begin
  fDataFunc:= DataFunc;
end;

function TTaskEntity.GetDisplayName: string;
begin
  result := fDataFunc.S['displayName'];
end;

function TTaskEntity.GetEmail: string;
begin
  result := fDataFunc.S['email'];
end;

function TTaskEntity.GetId: string;
begin
  result := fDataFunc.S['id'];
end;

function TTaskEntity.GetSelf: boolean;
begin
  result := fDataFunc.B['self'];
end;

procedure TTaskEntity.SetDisplayName(const Value: string);
begin
  fDataFunc.S['displayName'] := Value;
end;

procedure TTaskEntity.SetEmail(const Value: string);
begin
  fDataFunc.S['email'] := Value;
end;

procedure TTaskEntity.SetId(const Value: string);
begin
  fDataFunc.S['id'] := Value;
end;

procedure TTaskEntity.SetSelf(const Value: boolean);
begin
  fDataFunc.B['self'] := Value;
end;

{ TTaskStartEnd }

constructor TTaskStartEnd.Create(DataFunc: TGetJsonFunc);
begin
  fDataFunc := DataFunc;
end;

function TTaskStartEnd.GetDate: TDate;
begin
  result := 0;
  if (fDataFunc.StringExists('date')) and (fDataFunc.S['date'] <> '') then
    result := Trunc(RFC3339StrToDateTimeLocal(fDataFunc.S['date']));
end;

function TTaskStartEnd.GetDateTime: TDateTime;
begin
  result := 0;
  if (fDataFunc.StringExists('dateTime')) and (fDataFunc.S['dateTime'] <> '') then
    result := RFC3339StrToDateTimeLocal(fDataFunc.S['dateTime']);
end;

function TTaskStartEnd.GetTimeZone: string;
begin
  result := '';
  if fDataFunc.StringExists('timeZone') then
    result := fDataFunc.S['timeZone']
end;

procedure TTaskStartEnd.SetDate(const Value: TDate);
begin
  if Value > 0 then begin
    { we are using date (whole day) so delete dateTime }
    fDataFunc.Delete('dateTime');
    fDataFunc.S['date'] := DateTimeLocalToRFC3339Str(Value);
  end
  else
   fDataFunc.Delete('date');  { delete date }
end;

procedure TTaskStartEnd.SetDateTime(const Value: TDateTime);
begin
  if Value > 0 then begin
    { we are using dateTime so delete date }
    fDataFunc.Delete('date');
    fDataFunc.S['dateTime'] := DateTimeLocalToRFC3339Str(Value);
  end
  else
   fDataFunc.Delete('dateTime');  { delete dateTime }
end;

procedure TTaskStartEnd.SetTimeZone(const Value: string);
begin
  if Value <> '' then
    fDataFunc.S['timeZone'] := Value;
end;

{ TAttendee }

constructor TAttendee.Create;
begin
  fData := nil;
end;

function TAttendee.GetadditionalGuests: integer;
begin
  result := Data.I['additionalGuests'];
end;

function TAttendee.GetComment: string;
begin
  result := Data.S['comment'];
end;

function TAttendee.GetData: TJsonObject;
begin
  if not Assigned(fData) then
    fData:= JO;
  result := fData;
end;

function TAttendee.GetDisplayName: string;
begin
  result := Data.S['displayName'];
end;

function TAttendee.GetEmail: string;
begin
  result := Data.S['email'];
end;

function TAttendee.GetId: string;
begin
  result := Data.S['id'];
end;

function TAttendee.GetOptional: boolean;
begin
  result := Data.B['optional'];
end;

function TAttendee.GetOrganizer: boolean;
begin
  result := Data.B['organizer'];
end;

function TAttendee.GetResource: boolean;
begin
  result := Data.B['resource'];
end;

function TAttendee.GetResponseStatus: string;
begin
  result := Data.S['responseStatus'];
end;

function TAttendee.GetSelf: boolean;
begin
  result := Data.B['self'];
end;

procedure TAttendee.SetadditionalGuests(const Value: integer);
begin
  Data.I['additionalGuests'] := Value;
end;

procedure TAttendee.SetComment(const Value: string);
begin
  Data.S['comment'] := Value;
end;

procedure TAttendee.SetData(const Value: TJsonObject);
begin
  fData.Free;
  fData := Value;
end;

procedure TAttendee.SetDisplayName(const Value: string);
begin
  Data.S['displayName'] := Value;
end;

procedure TAttendee.SetEmail(const Value: string);
begin
  Data.S['email'] := Value;
end;

procedure TAttendee.SetId(const Value: string);
begin
  Data.S['id'] := Value;
end;

procedure TAttendee.SetOptional(const Value: boolean);
begin
  Data.B['optional'] := Value;
end;

procedure TAttendee.SetOrganizer(const Value: boolean);
begin
  Data.B['organizer'] := Value;
end;

procedure TAttendee.SetResource(const Value: boolean);
begin
  Data.B['resource'] := Value;
end;

procedure TAttendee.SetResponseStatus(const Value: string);
begin
  Data.S['responseStatus'] := Value;
end;

procedure TAttendee.SetSelf(const Value: boolean);
begin
  Data.B['self'] := Value;
end;

{ TTaskReminders }

constructor TTaskReminders.Create(DataFunc: TGetJsonFunc);
begin
  fDataFunc := DataFunc;
  fOverrides := nil;
end;

destructor TTaskReminders.Destroy;
begin
  fOverrides.Free;
  inherited;
end;

procedure TTaskReminders.DoOnOverridesNotify(Sender: TObject;
  const Item: TReminder; Action: TCollectionNotification);
begin
  case Action of
    cnAdded: fDataFunc.A['overrides'].Add(Item.Data);
    cnRemoved,
    cnExtracted: fDataFunc.A['overrides'].Delete(Item.Data);
  end;
end;

function TTaskReminders.GetOverrides: TObjectList<TReminder>;
var
  x: integer;
  rem: TReminder;
begin
  if not Assigned(fOverrides) then begin
    fOverrides := TObjectList<TReminder>.Create(true);
    for x := 0 to fDataFunc.A['overrides'].Count -1 do begin
      rem := TReminder.Create;
      rem.Data := fDataFunc.A['overrides'].Items[x].AsObject;
      fOverrides.Add(rem);
    end;
    fOverrides.OnNotify := DoOnOverridesNotify;
  end;
  result := fOverrides;
end;

function TTaskReminders.GetUseDefault: boolean;
begin
  result := fDataFunc.B['useDefault'];
end;

procedure TTaskReminders.SetUseDefault(const Value: boolean);
begin
  fDataFunc.B['useDefault']:= Value;
end;

{ TCalendarEvent }

constructor TCalendarEvent.Create(aConnection: TGoogleAPIConnection);
begin
  inherited;
  fCreator := TTaskEntity.Create(GetCreatorData);
  fOrganizer := TTaskEntity.Create(GetOrganizerData);
  fStartTime := TTaskStartEnd.Create(GetStartTimeData);
  fEndTime := TTaskStartEnd.Create(GetEndTimeData);
  fRecurrence := nil;
  fOriginalStartTime := TTaskStartEnd.Create(GetOriginalStartTimeData);
  fReminders := TTaskReminders.Create(GetRemindersData);
  fSource := TTaskSource.Create(GetSourceData);
end;

destructor TCalendarEvent.Destroy;
begin
  fCreator.Free;
  fOrganizer.Free;
  fStartTime.Free;
  fEndTime.Free;
  fRecurrence.Free;
  fOriginalStartTime.Free;
  fReminders.Free;
  fSource.Free;
  inherited;
end;

procedure TCalendarEvent.DoOnAttendeesNotify(Sender: TObject;
  const Item: TAttendee; Action: TCollectionNotification);
begin
  case Action of
    cnAdded: Data.A['attendees'].Add(Item.Data);
    cnRemoved,
    cnExtracted: Data.A['attendees'].Delete(Item.Data);
  end;
end;

procedure TCalendarEvent.DoRecurrenceOnChange(Sender: TObject);
var
  x: integer;
begin
  Data.A['recurrence'].Clear;
  for x := 0 to fRecurrence.Count -1 do
    Data.A['recurrence'].Add(fRecurrence[x]);
end;

function TCalendarEvent.GetanyoneCanAddSelf: boolean;
begin
  result := Data.B['anyoneCanAddSelf'];
end;

function TCalendarEvent.Getattendees: TObjectList<TAttendee>;
var
  att: TAttendee;
  x: integer;
begin
  if not Assigned(fattendees) then begin
    fattendees := TObjectList<TAttendee>.Create(true);
    for x := 0 to Data.A['attendees'].Count -1 do begin
      att := TAttendee.Create;
      att.Data := Data.A['attendees'].Items[x].AsObject;
      fattendees.Add(att);
    end;
    fattendees.OnNotify := DoOnAttendeesNotify;
  end;
  result := fattendees;
end;

function TCalendarEvent.GetattendeesOmitted: boolean;
begin
  result := Data.B['attendeesOmitted'];
end;

function TCalendarEvent.GetColorId: string;
begin
  result := Data.S['colorId'];
end;

function TCalendarEvent.GetCreated: TDateTime;
begin
  result := RFC3339StrToDateTimeLocal(Data.S['created']);
end;

function TCalendarEvent.GetCreatorData: TJsonObject;
begin
  result := Data.O['creator'];
end;

function TCalendarEvent.GetDescription: string;
begin
  result := Data.S['description'];
end;

function TCalendarEvent.GetEndTimeData: TJsonObject;
begin
  result := Data.O['end'];
end;

function TCalendarEvent.GetguestsCanInviteOthers: boolean;
begin
  result := Data.B['guestsCanInviteOthers'];
end;

function TCalendarEvent.GetguestsCanModify: boolean;
begin
  result := Data.B['guestsCanModify'];
end;

function TCalendarEvent.GetguestsCanSeeOtherGuests: boolean;
begin
  result := Data.B['guestsCanSeeOtherGuests'];
end;

function TCalendarEvent.GethangoutLink: string;
begin
  result := Data.S['hangoutLink'];
end;

function TCalendarEvent.GetHtmlLink: string;
begin
  result := Data.S['htmlLink'];
end;

function TCalendarEvent.GetiCalUID: string;
begin
  result := Data.S['iCalUID'];
end;

function TCalendarEvent.GetLocation: string;
begin
  result := Data.S['location'];
end;

function TCalendarEvent.Getlocked: boolean;
begin
  result := Data.B['locked'];
end;

function TCalendarEvent.GetOrganizerData: TJsonObject;
begin
  result := Data.O['organizer'];
end;

function TCalendarEvent.GetOriginalStartTimeData: TJsonObject;
begin
  result := Data.O['originalStartTime'];
end;

function TCalendarEvent.GetprivateCopy: boolean;
begin
  result := Data.B['privateCopy'];
end;

function TCalendarEvent.GetRecurrence: TStringList;
var
  x: integer;
begin
  if not Assigned(fRecurrence) then begin
    fRecurrence := TStringList.Create;
    for x := 0 to Data.A['recurrence'].Count -1 do
      fRecurrence.Add(Data.A['recurrence'].Items[x].AsString);
    fRecurrence.OnChange := DoRecurrenceOnChange;
  end;
  result := fRecurrence;
end;

function TCalendarEvent.GetRemindersData: TJsonObject;
begin
  result := Data.O['reminders'];
end;

function TCalendarEvent.Getsequence: integer;
begin
  result := Data.I['sequence'];
end;

function TCalendarEvent.GetSourceData: TJsonObject;
begin
  result := Data.O['source'];
end;

function TCalendarEvent.GetStartTimeData: TJsonObject;
begin
  result := Data.O['start'];
end;

function TCalendarEvent.GetStatus: string;
begin
  result := Data.S['status'];
end;

function TCalendarEvent.GetSummary: string;
begin
  result := Data.S['summary'];
end;

function TCalendarEvent.Gettransparency: string;
begin
  result := Data.S['transparency'];
end;

function TCalendarEvent.GetUpdated: TDateTime;
begin
  result := RFC3339StrToDateTimeLocal(Data.S['updated']);
end;

function TCalendarEvent.Getvisibility: string;
begin
  result := Data.S['visibility'];
end;

procedure TCalendarEvent.SetanyoneCanAddSelf(const Value: boolean);
begin
  Data.B['anyoneCanAddSelf'] := Value;
end;

procedure TCalendarEvent.SetattendeesOmitted(const Value: boolean);
begin
  Data.B['attendeesOmitted'] := Value;
end;

procedure TCalendarEvent.SetColorId(const Value: string);
begin
  Data.S['colorId'] := Value;
end;

procedure TCalendarEvent.SetCreated(const Value: TDateTime);
begin
  Data.S['created'] := DateTimeLocalToRFC3339Str(Value);
end;

procedure TCalendarEvent.SetDescription(const Value: string);
begin
  Data.S['description'] := Value;
end;

procedure TCalendarEvent.SetguestsCanInviteOthers(const Value: boolean);
begin
  Data.B['guestsCanInviteOthers'] := Value;
end;

procedure TCalendarEvent.SetguestsCanModify(const Value: boolean);
begin
  Data.B['guestsCanModify'] := Value;
end;

procedure TCalendarEvent.SetguestsCanSeeOtherGuests(const Value: boolean);
begin
  Data.B['guestsCanSeeOtherGuests'] := Value;
end;

procedure TCalendarEvent.SethangoutLink(const Value: string);
begin
  Data.S['hangoutLink'] := Value;
end;

procedure TCalendarEvent.SetHtmlLink(const Value: string);
begin
  Data.S['htmlLink'] := Value;
end;

procedure TCalendarEvent.SetiCalUID(const Value: string);
begin
  Data.S['iCalUID'] := Value;
end;

procedure TCalendarEvent.SetLocation(const Value: string);
begin
  Data.S['location'] := Value;
end;

procedure TCalendarEvent.Setlocked(const Value: boolean);
begin
  Data.B['locked'] := Value;
end;

procedure TCalendarEvent.SetprivateCopy(const Value: boolean);
begin
  Data.B['privateCopy'] := Value;
end;

procedure TCalendarEvent.Setsequence(const Value: integer);
begin
  Data.I['sequence'] := Value;
end;

procedure TCalendarEvent.SetStatus(const Value: string);
begin
  Data.S['ststus'] := Value;
end;

procedure TCalendarEvent.SetSummary(const Value: string);
begin
  Data.S['summary'] := Value;
end;

procedure TCalendarEvent.Settransparency(const Value: string);
begin
  Data.S['transparency'] := Value;
end;

procedure TCalendarEvent.SetUpdated(const Value: TDateTime);
begin
  Data.S['updated'] := DateTimeLocalToRFC3339Str(Value);
end;

procedure TCalendarEvent.Setvisibility(const Value: string);
begin
  Data.S['visibility'] := Value;
end;

{ TTaskSource }

constructor TTaskSource.Create(DataFunc: TGetJsonFunc);
begin
  fDataFunc := DataFunc;
end;

function TTaskSource.GetTitle: string;
begin
  result := fDataFunc.S['title'];
end;

function TTaskSource.GetUrl: string;
begin
  result := fDataFunc.S['url'];
end;

procedure TTaskSource.SetTitle(const Value: string);
begin
  fDataFunc.S['title'] := Value;
end;

procedure TTaskSource.SetUrl(const Value: string);
begin
  fDataFunc.S['url'] := Value;
end;

{ TCalendarEventList }

constructor TCalendarEventList.Create(aConnection: TGoogleAPIConnection;
  aCalendarId: string);
begin
  inherited Create(aConnection);
  fCalendarId := aCalendarId;
  fList := TObjectList<TCalendarEvent>.Create(true);
  FsingleEvents := false;
  FshowHiddenInvitations := false;
  ForderBy := '';
  fupdatedMin := 0;
  ftimeMax := 0;
  ftimeMin := 0;
  Fq := '';
end;

procedure TCalendarEventList.delete(aId: string);
var
  item: TCalendarEvent;
begin
  fConnection.Delete('https://www.googleapis.com/calendar/v3/calendars/'+ CalendarId + '/events/'+ aId);
  item := EventById(aId);
  if Assigned(item) then begin
    Data.A['list'].Delete(item);
    fList.Delete(fLIst.IndexOf(item));
  end;
end;

destructor TCalendarEventList.Destroy;
begin
  fList.Free;
  inherited;
end;

function TCalendarEventList.EventById(aId: string): TCalendarEvent;
var
  item: TCalendarEvent;
begin
  result := nil;
  for item in List do begin
    if SameText(item.id, aId) then begin
      result := item;
      break;
    end;
  end;
end;

function TCalendarEventList.GetList: TObjectList<TCalendarEvent>;
var
  url: string;
  npToken: string;
  j, newJ: TJsonObject;
  x: integer;
  item: TCalendarEvent;
begin
  if fList.Count = 0 then begin
    url := 'https://www.googleapis.com/calendar/v3/calendars/'+fCalendarId+'/events' +
        '?showDeleted=' + Lowercase(BoolToStr(ShowDeleted,true));

    if showHiddenInvitations then
      url := url + '&showHiddenInvitations=true';

    if orderBy <> '' then
      url := url + '&orderBy=' + orderBy;

    if updatedMin > 0 then
      url := url + '&updatedMin=' + URILib.PercentEncode(DateTimeLocalToRFC3339Str(updatedMin));

    if timeMin > 0 then
      url := url + '&timeMin=' + URILib.PercentEncode(DateTimeLocalToRFC3339Str(timeMin));

    if timeMax > 0 then
      url := url + '&timeMax=' + URILib.PercentEncode(DateTimeLocalToRFC3339Str(timeMax));

    if q <> '' then
      url := url + '&q=' + StringUtils.ReplaceSpaceWithPlus(URILib.PercentEncode(q));

    J := JO;
    try
      Data.AsString := fConnection.Get(url);
      npToken := Data.S['nextPageToken'];
      while npToken <> '' do begin
        J.AsString := fConnection.Get(url+ '&pageToken=' + npToken);
        npToken := J.S['nextPageToken'];
        for x := 0 to J.A['items'].Count -1 do begin
          newJ := JO;
          newJ.Assign(J.A['items'].Items[x].AsObject);
          Data.A['items'].Add(newJ);
        end;
      end;
    finally
      J.Free;
    end;
    for x := 0 to Data.A['items'].Count -1 do begin
      item := TCalendarEvent.Create(fConnection);
      item.Data := Data.A['items'].Items[x].AsObject;
      fList.Add(item);
    end;
  end;
  result := fList;
end;

procedure TCalendarEventList.insert(aEvent: TCalendarEvent);
var
  j: TJsonObject;
begin
//  List; { force loading of list }
  j := JO;
  j.AsString := fConnection.Post('https://www.googleapis.com/calendar/v3/calendars/'+CalendarId+'/events',StringReplace(aEvent.AsString,#13#10,'',[rfReplaceAll]));
  Data.A['items'].Add(j);
  aEvent.Data := j;
  fList.Add(aEvent);
end;

procedure TCalendarEventList.SetorderBy(const Value: string);
begin
  if (Value <> '') or (Value <> 'startTime') or (Value <> 'updated') then
    raise Exception.Create(Self.ClassName + ' - Invalid oredrBy Value');

  ForderBy := Value;
  if (Value = 'startTime') then
    self.singleEvents := true;
  fList.Clear;
end;

procedure TCalendarEventList.Setq(const Value: string);
begin
  Fq := Value;
  fList.Clear;
end;

procedure TCalendarEventList.SetshowDeleted(const Value: boolean);
begin
  FshowDeleted := Value;
  fList.Clear;
end;

procedure TCalendarEventList.SetshowHiddenInvitations(const Value: boolean);
begin
  FshowHiddenInvitations := Value;
  fList.Clear;
end;

procedure TCalendarEventList.SetsingleEvents(const Value: boolean);
begin
  FsingleEvents := Value;
end;

procedure TCalendarEventList.SettimeMax(const Value: TDateTime);
begin
  FtimeMax := Value;
  fList.Clear;
end;

procedure TCalendarEventList.SettimeMin(const Value: TDateTime);
begin
  FtimeMin := Value;
  fList.Clear;
end;

procedure TCalendarEventList.SetupdatedMin(const Value: TDateTime);
begin
  FupdatedMin := Value;
  fList.Clear;
end;

procedure TCalendarEventList.update(aEvent: TCalendarEvent);
var
  j: TJsonObject;
begin
  j := JO;
  try
    j.AsString := fConnection.Put('https://www.googleapis.com/calendar/v3/calendars/'+ CalendarId +'/events/'+aEvent.id,StringReplace(aEvent.AsString,#13#10,'',[rfReplaceAll]));
    aEvent.AsString := j.AsString;
  finally
    j.Free;
  end;
end;

end.
