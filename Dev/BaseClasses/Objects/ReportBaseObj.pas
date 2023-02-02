unit ReportBaseObj;

interface

uses
  classes, JsonObject, ERPWebAPIObjBase;

type
  TShowProgressBarProc = procedure (
    ProgressCount: integer; ProgressBarCaption: string;
    ProgressBarMessage: string; IsPercenage: boolean;
    aTimerUpdate: Boolean; OnCancelEvent: TNotifyEvent;
    aAllowCancel:Boolean) of object;

  TStepProgressbarProc = procedure (const ProgressBarMessage: String) of object;
  THideProgressbarProc = procedure() of object;



  TReportBaseClass = class of TReportBase;
  TReportBase = class(TERPWebAPIObjBase)
  private
    fAPIMode: boolean;
    fOnShowProgressBar: TShowProgressBarProc;
    fOnStepProgressBar: TStepProgressbarProc;
    fOnHideProgressBar: THideProgressbarProc;
    fsErrormsg: String;
    fbIsLimit0selection: Boolean;
    fsListClassname:String;
  protected
    procedure DoShowProgressbar(ProgressCount: integer; ProgressBarCaption: string;
                                ProgressBarMessage: string = '';
                                IsPercenage:boolean = true;
                                aTimerUpdate: Boolean = False;
                                OnCancelEvent :TNotifyEvent = nil;
                                aAllowCancel:Boolean = False);
    procedure DoStepProgressBar(const ProgressBarMessage: String = '');
    procedure DoHideProgressBar();
    function  GetPreDataJson: string; virtual;
    Function DateSQL(const aDate:TDateTime; paramname:String;isDateSet:Boolean): String;
  public
    constructor Create; Override;
    destructor Destroy; override;
    function  PopulateReportSQL(SQL: TStrings; var msg: string): boolean; virtual;
    procedure AssignParams(params: TJsonObject); virtual;
    property  APIMode: boolean read fAPIMode write fAPIMode;
    property  OnShowProgressBar: TShowProgressBarProc read fOnShowProgressBar write fOnShowProgressBar;
    property  OnStepProgressBar: TStepProgressbarProc read fOnStepProgressBar write fOnStepProgressBar;
    property  OnHideProgressBar: THideProgressbarProc read fOnHideProgressBar write fOnHideProgressBar;
    property  PreDataJson: string read GetPreDataJson;
    Property Errormsg :String read fsErrormsg write fsErrormsg;
    Property IsLimit0selection :Boolean read fbIsLimit0selection write fbIsLimit0selection;
    Property ListClassname :String read fsListClassname write fsListClassname;
  end;

   TReportWithDateRangeBase = class(TReportBase)
   Private
      fDateTo: TDateTime;
      fDateFrom: TDateTime;
      fbIgnoreDates: boolean;
      fbDateToSet: boolean;
      fbDateFromSet: boolean;

      fsOrderBy: string;
      fsSearch: string;

      function getDateTo: TDateTime;
      function getDateFrom: TDateTime;
      procedure SetDateFrom(const Value: TDateTime);
      procedure SetDateTo(const Value: TDateTime);

   Protected
      function DateFromSQL: string; Virtual;
      function DateToSQL: string; Virtual;
      Function ClassnamesTOIds(const Value: string): String;
      Function ProductNamesTOIds(const Value: string): String;

   Public
      constructor Create; override;
      destructor Destroy; override;

   Published
      property DateFrom: TDateTime read getDateFrom write SetDateFrom;
      property DateTo: TDateTime read getDateTo write SetDateTo;
      property IgnoreDates: Boolean read fbIgnoreDates write fbIgnoreDates;

      property OrderBy: string read fsOrderBy write fsOrderBy;
      property Search: string read fsSearch write fsSearch;

   end;



implementation

uses
  JsonToObject, SysUtils, DbSharedObjectsObj, dateutils, SystemLib, MySQLConst , ErpDBComponents,
  StringUtils;

{ TReportBase }

procedure TReportBase.AssignParams(params: TJsonObject);
begin
  try
    JsonToObj(params, Self);
  Except
    on E:Exception do begin
      Errormsg:= e.message;
    end;
  end;
end;

constructor TReportBase.Create;
begin
  inherited Create;
  fAPIMode := false;
  Errormsg := '';
  IsLimit0selection := false;
end;

function TReportBase.DateSQL(const aDate: TDateTime; paramname:String;isDateSet:Boolean): String;
var
  dt: TDateTime;
begin
  if not(APIMode) and (not isDateSet) then begin
    result := ':' + paramname;
    Exit;
  end else dt := aDate;

  if dateof(dt) = dt then
       result := '"' + FormatDateTime(MysqlDateFormat, dt) + '"'
  else result := '"' + FormatDateTime(MysqlDateTimeFormat, dt) + '"';

end;

destructor TReportBase.Destroy;
begin
  inherited;
end;

procedure TReportBase.DoHideProgressBar;
begin
  if Assigned(fOnHideProgressBar) then
    fOnHideProgressBar;
end;

procedure TReportBase.DoShowProgressbar(ProgressCount: integer;
  ProgressBarCaption, ProgressBarMessage: string; IsPercenage,
  aTimerUpdate: Boolean; OnCancelEvent: TNotifyEvent; aAllowCancel: Boolean);
begin
   if Assigned(fOnShowProgressBar) then
     fOnShowProgressBar(ProgressCount, ProgressBarCaption, ProgressBarMessage,
     IsPercenage, aTimerUpdate, OnCancelEvent, aAllowCancel);
end;

procedure TReportBase.DoStepProgressBar(const ProgressBarMessage: String);
begin
  if Assigned(fOnStepProgressBar) then
    fOnStepProgressBar(ProgressBarMessage);
end;

function TReportBase.GetPreDataJson: string;
var
  subJson: TJsonObject;
begin
  subJson := JO;
  try
    ObjToJson(self, subJson);
    Result := subJson.AsString;
  finally
    subJson.free;
  end;
end;

function TReportBase.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
begin
  Result := True;
  msg := '';
end;

constructor TReportWithDateRangeBase.Create;
begin
  inherited;
  fDateTo       := date;
  fDateFrom     := incday(Date, -30);
  fbIgnoreDates := False;
  fbDateToSet     := False;
  fbDateFromSet   := False;
end;

function TReportWithDateRangeBase.DateFromSQL: string;
begin
  Result := DateSQL(DateFrom, 'DateFrom', fbdatefromset);
end;

function TReportWithDateRangeBase.DateToSQL: string;
begin
  Result := DateSQL(DateTo, 'DateTo', fbdatetoset);
end;

destructor TReportWithDateRangeBase.Destroy;
begin
  inherited;
end;

function TReportWithDateRangeBase.getDateFrom: TDateTime;
begin
  if fbIgnoreDates then
       Result := ERPListMinDatetime
  else Result := dateof(fDateFrom);
end;

function TReportWithDateRangeBase.getDateTo: TDateTime;
begin
  if fbIgnoreDates then
       Result := ERPListMaxDatetime
  else Result := IncSecond(IncDay(dateof(fDateTo), 1), -1);
end;

procedure TReportWithDateRangeBase.SetDateFrom(const Value: TDateTime);
begin
  fdatefrom := Value;
  fbDateFromset := True;
end;

procedure TReportWithDateRangeBase.SetDateTo(const Value: TDateTime);
begin
  fdateto:= Value;
  fbDatetoset := True;
end;
Function TReportWithDateRangeBase.ClassnamesTOIds(const Value: string):String;
var
  qry: TERPQuery;
begin
  if Value = '' then begin
    result := '';
    Exit;
  end;
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := SharedConnection;
    qry.SQL.Add('select ClassID, ClassName from tblclass');
    qry.SQL.Add('where ClassName in (' + StringUtils.QuotedCommaText(Value) + ')');
    qry.Open;
    REsult := qry.Groupconcat('ClassID');
  finally
    qry.Free;
  end;
end;
Function TReportWithDateRangeBase.ProductNamesTOIds(const Value: string):String;
var
  qry: TERPQuery;
begin
  if Value = '' then begin
    result := '';
    Exit;
  end;
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := SharedConnection;
    qry.SQL.Add('select PartsId from tblparts');
    qry.SQL.Add('where Partname in (' + StringUtils.QuotedCommaText(Value) + ')');
    qry.Open;
    REsult := qry.Groupconcat('PartsId');
  finally
    qry.Free;
  end;
end;

end.
