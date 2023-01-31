unit UtilsServerConfigObj;

interface

uses
  classes, ModuleConst, LogMessageTypes;

type
  {$M+}
  TUtilsServerConfig = class
  private
    FLoggingLevel: TLoggingLevel;
    fOnChange: TNotifyEvent;
    fNextUpdateCheckTime: TDateTime;
    procedure SetNextUpdateCheckTime(const Value: TDateTime);
  protected
    procedure SetLoggingLevel(const Value: TLoggingLevel); virtual;
  public
    property OnChange: TNotifyEvent read fOnChange write fOnChange;
  published
    property LoggingLevel: TLoggingLevel read FLoggingLevel write SetLoggingLevel;
    property NextUpdateCheckTime: TDateTime read fNextUpdateCheckTime write SetNextUpdateCheckTime;
  end;
  {$M-}

implementation

{ TUtilsServerConfig }

procedure TUtilsServerConfig.SetLoggingLevel(const Value: TLoggingLevel);
begin
  if FLoggingLevel <> Value then begin
    FLoggingLevel := Value;
    if Assigned(fOnChange) then
      fOnChange(self);
  end;
end;

procedure TUtilsServerConfig.SetNextUpdateCheckTime(const Value: TDateTime);
begin
  if fNextUpdateCheckTime <> Value then begin
    fNextUpdateCheckTime := Value;
    if Assigned(fOnChange) then
      fOnChange(self);
  end;
end;

end.
