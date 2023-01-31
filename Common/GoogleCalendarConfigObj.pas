unit GoogleCalendarConfigObj;

interface
uses
  JsonDbPrefsConfigObj;

type

  TGoogleCalendarConfig = class(TJsonDbPefConfig)
  private
    function GetLastServerId: string;
    function GetSynchWithGoogleCalendar: boolean;
    procedure SetLastServerId(const Value: string);
    procedure SetSynchWithGoogleCalendar(const Value: boolean);
  public
    property SynchWithGoogleCalendar: boolean read GetSynchWithGoogleCalendar write SetSynchWithGoogleCalendar;
    property LastServerId: string read GetLastServerId write SetLastServerId;
  end;



implementation

{ TGoogleCalendarConfig }

function TGoogleCalendarConfig.GetLastServerId: string;
begin
  result := S['LastServerId'];
end;

function TGoogleCalendarConfig.GetSynchWithGoogleCalendar: boolean;
begin
  result := B['SynchWithGoogleCalendar'];
end;

procedure TGoogleCalendarConfig.SetLastServerId(const Value: string);
begin
  S['LastServerId'] := Value;
end;

procedure TGoogleCalendarConfig.SetSynchWithGoogleCalendar(const Value: boolean);
begin
  B['SynchWithGoogleCalendar'] := Value;
end;

end.
