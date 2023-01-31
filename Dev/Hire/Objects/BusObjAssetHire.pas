unit BusObjAssetHire;

interface


uses
  BusObjBase, DB, Classes, XMLDoc, XMLIntf, BusObjHirePricingLine, MyAccess,
  ERPDbComponents, IntegerListObj;

type
  TAssetHire = class(TMSBusObj)
  private
    fAllLinesValid: boolean;
    function GetActive: boolean;
    function GetAssetId: integer;
    function GetHireIncomeAccountID: integer;
    function GetHireIncomeAccountName: string;
    function GetMinHirePeriodQty: integer;
    function GetMinHirePeriodType: string;
    procedure SetActive(const Value: boolean);
    procedure SetAssetId(const Value: integer);
    procedure SetHireIncomeAccountID(const Value: integer);
    procedure SetHireIncomeAccountName(const Value: string);
    procedure SetMinHirePeriodQty(const Value: integer);
    procedure SetMinHirePeriodType(const Value: string);
    function GetPriceLines: THirePricingLine;
    function AllLinesValid: boolean;
    procedure LineValidationCallback(const Sender: TBusObj; var Abort: Boolean);
    function GetHireProductName: string;
    function GetHirePrintProductname: string;
    procedure SetHireProductName(const Value: string);
    procedure SetHirePrintProductname(const Value: string);
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
    class function GetKeyStringField: string; Override;
    { returns the DurationId }
//    function CalcDurationAndQty(TimeFrom, TimeTo: TDateTime; var aQty, aRate: double; var aDurationName: string): integer;
    class function AssetCodeForID(aAssetID: integer; Connection: TCustomMyConnection = nil): string;
    { returns the number of weekend days between the 2 dates }
    class function WeekendDays(aDateTimeFrom, aDateTimeTo: TDateTime): integer;
    function Delete: boolean; overload; override;
    class function CalcHireToDate(aHireFrom: TDateTime; aDurationId: integer; aQty: double; Conn: TCustomMyConnection = nil): TDateTime;
    class function NewWeekendDayList: TIntegerList;
    class function CalcHireQty(fromDate, ToDate: TDateTime; DurationIdList: string; var Qty: double): integer;
    class function HireProductForAssetId(aAssetId: integer;  Conn: TCustomMyConnection = nil): string;
    class function HasDurationPrice(aAssetId, aDurationId: integer; Conn: TCustomMyConnection = nil): boolean;
  published
    property AssetId: integer read GetAssetId write SetAssetId;
    property MinHirePeriodQty: integer read GetMinHirePeriodQty write SetMinHirePeriodQty;
    { H:Hour, D:Day,W:Week,M:Month,Y:Year }
    property MinHirePeriodType: string read GetMinHirePeriodType write SetMinHirePeriodType;
    property HireIncomeAccountID: integer read GetHireIncomeAccountID write SetHireIncomeAccountID;
    property HireIncomeAccountName: string read GetHireIncomeAccountName write SetHireIncomeAccountName;
    property HireProductName: string read GetHireProductName write SetHireProductName;
    property HirePrintProductname: string read GetHirePrintProductname write SetHirePrintProductname;
    property Active: boolean read GetActive write SetActive;
    property PriceLines: THirePricingLine read GetPriceLines;
  end;

implementation

uses
  SysUtils, BusObjGLAccount, BusObjFixedAsset,
  DbSharedObjectsObj, DateUtils, AppEnvironment, CommonLib, BusObjDuration,
  CommonDbLib, DateTimeUtils;

{ TAssetHire }

function TAssetHire.AllLinesValid: boolean;
begin
  fAllLinesValid := true;
  try
    PriceLines.PostDb;
    if PriceLines.Count = 0 then
      fAllLinesValid := true
    else
      fAllLinesValid:= true;
      PriceLines.IterateRecords(LineValidationCallback);
  finally
    result := fAllLinesValid;
  end;
end;

class function TAssetHire.AssetCodeForID(aAssetID: integer;
  Connection: TCustomMyConnection): string;
begin
  result := TFixedAssets.AssetCodeForID(aAssetID, Connection);
end;

//function TAssetHire.CalcDurationAndQty(TimeFrom, TimeTo: TDateTime;
//  var aQty, aRate: double; var aDurationName: string): integer;
//var
//  qry: TERPQuery;
//  RangeHours: double;
//  HoursPerDay: double;
//  DaysPerWeek: integer;
//  NoWeekendDays: integer;
//  RangeTime: double;
//  Days: integer;
//  dt: TDateTime;
//  DurationType: string;
//  DurationQty: double;
//begin
//  result := 0;
//  aQty := 0;
//  aRate := 0;
//  aDurationName := '';
//  if TimeTo <= TimeFrom then exit;
//  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(self.Connection.Connection);
//  try
//    qry.SQL.Add('set @DaysPerWeekend = (select FieldValue from tbldbpreferences where Name = "NoOfWeekendDays");');
//    qry.SQL.Add('set @DaysPerWeek = 7 - @DaysPerWeekend;');
//    qry.SQL.Add('set @HousPerDay = Round(((select FieldValue from tbldbpreferences where Name = "EndOfDay") - (select FieldValue from tbldbpreferences where Name = "StartOfDay")) * 24,2);');
//    qry.SQL.Add('set @WeeksPerYear = Round(365 / 7,2);');
//    qry.SQL.Add('set @WeeksPerMonth = Round(@WeeksPerYear / 12,2);');
//    qry.SQL.Add('select tblhirepricinglines.HirePriceLineId, tblhirepricinglines.DurationID, tblhirepricinglines.DurationName, tblhirepricinglines.Rate, tblduration.DurationType, tblduration.Qty,');
//    qry.SQL.Add('case tblduration.DurationType');
//    qry.SQL.Add('  when "H" then tblduration.Qty');
//    qry.SQL.Add('  when "D" then tblduration.Qty * @HousPerDay');
//    qry.SQL.Add('  when "W" then tblduration.Qty * @DaysPerWeek * @HousPerDay');
//    qry.SQL.Add('  when "M" then tblduration.Qty * @WeeksPerMonth * @DaysPerWeek * @HousPerDay');
//    qry.SQL.Add('  when "Y" then tblduration.Qty * @WeeksPerYear * @DaysPerWeek * @HousPerDay');
//    qry.SQL.Add('  else 0');
//    qry.SQL.Add('end as Hours,');
//    qry.SQL.Add('case tblassethire.MinHirePeriodType');
//    qry.SQL.Add('  when "H" then tblassethire.MinHirePeriodQty');
//    qry.SQL.Add('  when "D" then tblassethire.MinHirePeriodQty * @HousPerDay');
//    qry.SQL.Add('  when "W" then tblassethire.MinHirePeriodQty * @DaysPerWeek * @HousPerDay');
//    qry.SQL.Add('  when "M" then tblassethire.MinHirePeriodQty * @WeeksPerMonth * @DaysPerWeek * @HousPerDay');
//    qry.SQL.Add('  when "Y" then tblassethire.MinHirePeriodQty * @WeeksPerYear * @DaysPerWeek * @HousPerDay');
//    qry.SQL.Add('  else 0');
//    qry.SQL.Add('end as MinHours');
//    qry.SQL.Add('from tblhirepricinglines');
//    qry.SQL.Add('inner join tblduration on tblhirepricinglines.DurationID = tblduration.DurationId and tblhirepricinglines.Active = "T" and tblduration.Active = "T"');
//    qry.SQL.Add('inner join tblassethire on tblhirepricinglines.AssetHireId = tblassethire.AssetHireId');
//    qry.SQL.Add('where tblhirepricinglines.AssetHireId = ' + IntToStr(self.ID));
//    qry.SQL.Add('order by Hours DESC');
//    qry.Open;
//    if not qry.IsEmpty then begin
//      HoursPerDay := (AppEnv.CompanyPrefs.EndOfDay - AppEnv.CompanyPrefs.StartOfDay) * 24;
//      DaysPerWeek := 7 - AppEnv.CompanyPrefs.NoofWeekendDays;
//      NoWeekendDays := WeekendDays(TimeFrom,TimeTo);
//
//      Days := DaysBetween(TimeTo,TimeFrom);
//      dt := (TimeTo - TimeFrom) - Days;
//      Days := Days - NoWeekendDays;
//
//      RangeHours := CommonLib.Round((Days * HoursPerDay) + (dt * 24),2);
//
//      while not qry.Eof do begin
//        if (qry.FieldByName('Hours').AsFloat <= RangeHours) and (RangeHours >= qry.FieldByName('MinHours').AsFloat) then begin
//          result := qry.FieldByName('DurationId').AsInteger;
//          aQty := CommonLib.Round(RangeHours/qry.FieldByName('Hours').AsFloat,2);
//          aRate := qry.FieldByName('Rate').AsFloat;
//          aDurationName := qry.FieldByName('DurationName').AsString;
//          DurationType := qry.FieldByName('DurationType').AsString;
//          DurationQty := qry.FieldByName('Qty').AsFloat;
//          break;
//        end;
//        qry.Next;
//      end;
//      qry.Close;
//    end;
//  finally
//    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
//  end;
//end;

class function TAssetHire.CalcHireQty(fromDate, ToDate: TDateTime;
  DurationIdList: string; var Qty: double): integer;
var
  days: integer;
  hours: double;
  span: double;
  hoursPerDay: double;
  qry: TERPQuery;
begin
  result := 0;
  if AppEnv.CompanyPrefs.StartOfDay >= AppEnv.CompanyPrefs.EndOfDay then exit;

  span := ToDate - FromDate;
  days := Trunc(Span) - TAssetHire.WeekendDays(fromDate,ToDate);
  hours := DivZer(Frac(span),OneHour);
  if days > 0 then begin
    hoursPerDay := (AppEnv.CompanyPrefs.EndOfDay - AppEnv.CompanyPrefs.StartOfDay) / OneHour;
    hours := hours + (days * hoursPerDay);
  end;
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('set @DaysPerWeekend = (select FieldValue from tbldbpreferences where Name = "NoOfWeekendDays");');
    qry.SQL.Add('set @DaysPerWeek = 7 - @DaysPerWeekend;');
    qry.SQL.Add('set @HousPerDay = Round(((select FieldValue from tbldbpreferences where Name = "EndOfDay") - (select FieldValue from tbldbpreferences where Name = "StartOfDay")) * 24,2);');
    qry.SQL.Add('set @WeeksPerYear = Round(365 / 7,2);');
    qry.SQL.Add('set @WeeksPerMonth = Round(@WeeksPerYear / 12,2);');
    qry.SQL.Add('select tblduration.DurationId, tblduration.DurationType, tblduration.Qty,');
    qry.SQL.Add('if(IfNull(tblduration.StepQty,0) > 0 and IfNull(tblduration.StepDurationType,"") <> "",');
    qry.SQL.Add('case tblduration.StepDurationType');
    qry.SQL.Add('  when "H" then tblduration.StepQty');
    qry.SQL.Add('  when "D" then tblduration.StepQty * @HousPerDay');
    qry.SQL.Add('  when "W" then tblduration.StepQty * @DaysPerWeek * @HousPerDay');
    qry.SQL.Add('  when "M" then tblduration.StepQty * @WeeksPerMonth * @DaysPerWeek * @HousPerDay');
    qry.SQL.Add('  when "Y" then tblduration.StepQty * @WeeksPerYear * @DaysPerWeek * @HousPerDay');
    qry.SQL.Add('  else 0');
    qry.SQL.Add('end,');
    qry.SQL.Add('case tblduration.DurationType');
    qry.SQL.Add('  when "H" then tblduration.Qty');
    qry.SQL.Add('  when "D" then tblduration.Qty * @HousPerDay');
    qry.SQL.Add('  when "W" then tblduration.Qty * @DaysPerWeek * @HousPerDay');
    qry.SQL.Add('  when "M" then tblduration.Qty * @WeeksPerMonth * @DaysPerWeek * @HousPerDay');
    qry.SQL.Add('  when "Y" then tblduration.Qty * @WeeksPerYear * @DaysPerWeek * @HousPerDay');
    qry.SQL.Add('  else 0');
    qry.SQL.Add('end) as Hours,');
    qry.SQL.Add('case tblduration.DurationType');
    qry.SQL.Add('  when "H" then tblduration.Qty');
    qry.SQL.Add('  when "D" then tblduration.Qty * @HousPerDay');
    qry.SQL.Add('  when "W" then tblduration.Qty * @DaysPerWeek * @HousPerDay');
    qry.SQL.Add('  when "M" then tblduration.Qty * @WeeksPerMonth * @DaysPerWeek * @HousPerDay');
    qry.SQL.Add('  when "Y" then tblduration.Qty * @WeeksPerYear * @DaysPerWeek * @HousPerDay');
    qry.SQL.Add('  else 0');
    qry.SQL.Add('end as ActualHours');
    qry.SQL.Add('from tblduration');
    qry.SQL.Add('where tblduration.Active = "T"');
    if DurationIdList <> '' then
      qry.SQL.Add('and tblduration.DurationId in (' + DurationIdList + ')');
    qry.SQL.Add('order by Hours DESC');
    qry.Open;
    if qry.IsEmpty then exit;
    while not qry.Eof do begin
      if qry.FieldByName('Hours').AsFloat <= hours then begin
        result := qry.FieldByName('DurationId').AsInteger;
        qty := Round(DivZer(hours, qry.FieldByName('ActualHours').AsFloat),2);
        break;
      end;
      qry.Next;
    end;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

class function TAssetHire.CalcHireToDate(aHireFrom: TDateTime;
  aDurationId: integer; aQty: double;
  Conn: TCustomMyConnection): TDateTime;
var
  Dur: TDuration;
  fQty: double;
  WeekendDayList: TIntegerList;
  dt: TDateTime;
begin
  result := 0;
//  WeekendDays := 0;
  if aDurationId = 0 then exit;
  if aHireFrom = 0 then exit;
  Dur := TDuration.CreateWithNewConn(nil);
  try
    if Assigned(Conn) then Dur.Connection.Connection := Conn
    else Dur.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
    Dur.Load(aDurationId);

    fQty := aQty * Dur.Qty;
    if SameText(Dur.DurationType, 'H') then
      fQty := trunc(fQty);

    if SameText(Dur.DurationType, 'Y') then begin
      result := IncYears(aHireFrom, fQty) -1;
      result := Trunc(result) + Frac(AppEnv.CompanyPrefs.EndOfDay);
    end
    else if SameText(Dur.DurationType, 'M') then begin
      result := IncMonths(aHireFrom, fQty) -1;
      result := Trunc(result) + Frac(AppEnv.CompanyPrefs.EndOfDay);
    end
    else if SameText(Dur.DurationType, 'W') then begin
      result := IncWeeks(aHireFrom, fQty) -1;
      result := Trunc(result) + Frac(AppEnv.CompanyPrefs.EndOfDay);
    end
    else if SameText(Dur.DurationType, 'D') then begin
      result := IncDay(aHireFrom, Trunc(fQty));
      if Frac(fQty) > 0 then begin
        { we have a fraction of a day }
        result := result + ((Frac(AppEnv.CompanyPrefs.EndOfDay) - Frac(AppEnv.CompanyPrefs.StartOfDay)) /2);
      end
      else begin
        { end of business day }
        result := Trunc(result -1) + Frac(AppEnv.CompanyPrefs.EndOfDay);
      end;
    end
    else if SameText(Dur.DurationType, 'H') then
      result := IncHour(aHireFrom, trunc(fQty));

    if SameText(Dur.DurationType, 'D') then begin
      if (AppEnv.CompanyPrefs.NoOfWeekendDays > 0) and (result - aHireFrom > 1) then begin
        { check for weekend days between dates }
        WeekendDayList := NewWeekendDayList;
        try
          dt := Trunc(aHireFrom) + 1;
          while dt <= Trunc(result) do begin
            if WeekendDayList.InList(DayOfTheWeek(dt)) then begin
              result := result + 1;
//              WeekendDays := WeekendDays + 1;
            end;
            dt := dt + 1;
          end;
        finally
          WeekendDayList.Free;
        end;
      end;
    end;
  finally
    Dur.Free;
  end;
end;

constructor TAssetHire.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription:= 'AssetHire';
  fSQL := 'SELECT * FROM tblAssetHire';
end;

function TAssetHire.Delete: boolean;
begin
//  result := true;
  try
    while PriceLines.Count > 0 do
      PriceLines.Delete;
  except
    result := false;
    exit;
  end;
  result := inherited Delete;
end;

destructor TAssetHire.Destroy;
begin

  inherited;
end;

function TAssetHire.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  if Assigned(Owner) and (Owner is TFixedAssets) then
    AssetId := TFixedAssets(Owner).ID;
end;

function TAssetHire.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;

end;

procedure TAssetHire.DoFieldOnChange(Sender: TField);
begin
  inherited;
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;

    if SysUtils.SameText(Sender.fieldName , 'HireIncomeAccountID') then begin
      HireIncomeAccountName := TAccount.IDToggle(HireIncomeAccountID, Connection.Connection);
    end
    else if SysUtils.SameText(Sender.fieldName , 'HireIncomeAccountName') then begin
      HireIncomeAccountID := TAccount.IDToggle(HireIncomeAccountName, Connection.Connection);
    end;
end;

function TAssetHire.GetActive: boolean;
begin
  result := GetBooleanField('Active');
end;

function TAssetHire.GetAssetId: integer;
begin
  result := GetIntegerField('AssetId');
end;

class function TAssetHire.GetBusObjectTablename: string;
begin
  result := 'tblAssetHire';
end;

function TAssetHire.GetHireIncomeAccountID: integer;
begin
  result := GetIntegerField('HireIncomeAccountID');
end;

function TAssetHire.GetHireIncomeAccountName: string;
begin
  result := GetStringField('HireIncomeAccountName');
end;

function TAssetHire.GetHireProductName: string;
begin
  result := GetStringField('HireProductName');
end;
function TAssetHire.GetHirePrintProductname: string;
begin
  result := GetStringField('HirePrintProductname');
end;

class function TAssetHire.GetIDField: string;
begin
  result := 'AssetHireID';
end;

class function TAssetHire.GetKeyStringField: string;
begin
  result := inherited;
end;

function TAssetHire.GetMinHirePeriodQty: integer;
begin
  result := GetIntegerField('MinHirePeriodQty');
end;

function TAssetHire.GetMinHirePeriodType: string;
begin
  result := GetStringField('MinHirePeriodType');
end;

function TAssetHire.GetPriceLines: THirePricingLine;
begin
  Result := THirePricingLine(GetContainerComponent(THirePricingLine, 'AssetHireId =' + inttostr(ID),
    self.SilentMode, true, True));
end;

function TAssetHire.GetSQL: string;
begin
  result := inherited;
end;

class function TAssetHire.HasDurationPrice(aAssetId, aDurationId: integer;
  Conn: TCustomMyConnection): boolean;
var
  qry: TERPQuery;
begin
  if Assigned(Conn) then
    qry := DbSharedObj.GetQuery(Conn)
  else
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('select * from tblhirepricingLines');
    qry.SQL.Add('inner join tblassethire on tblassethire.AssetHireId = tblhirepricingLines.AssetHireId and tblassethire.AssetId = ' + IntToStr(aAssetId));
    qry.SQL.Add('where tblhirepricingLines.DurationID = ' + IntToStr(aDurationId));
    qry.SQL.Add('and tblhirepricingLines.Active = "T"');
    qry.Open;
    result := not qry.IsEmpty;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

class function TAssetHire.HireProductForAssetId(aAssetId: integer;
  Conn: TCustomMyConnection): string;
var
  qry: TERPQuery;
begin
  if Assigned(Conn) then
    qry := DbSharedObj.GetQuery(Conn)
  else
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('select HireProductName from tblassethire');
    qry.SQL.Add('where AssetId = ' + IntToStr(aAssetId));
    qry.Open;
    result := qry.FieldByName('HireProductName').AsString;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TAssetHire.LineValidationCallback(const Sender: TBusObj;
  var Abort: Boolean);
begin
  if not THirePricingLine(Sender).ValidateData then begin
    fAllLinesValid:= False;
    Abort := true;
  end;
end;

procedure TAssetHire.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

end;

procedure TAssetHire.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;

end;

function TAssetHire.Save: Boolean;
begin
  PostDb;
  result := inherited;
  if not result then
    exit;
  result := PriceLines.Save;
end;

procedure TAssetHire.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;

end;

procedure TAssetHire.SetActive(const Value: boolean);
begin
  SetBooleanField('Active',Value);
end;

procedure TAssetHire.SetAssetId(const Value: integer);
begin
  SetIntegerField('AssetId',Value);
end;

procedure TAssetHire.SetHireIncomeAccountID(const Value: integer);
begin
  SetIntegerField('HireIncomeAccountID',Value);
end;

procedure TAssetHire.SetHireIncomeAccountName(const Value: string);
begin
  SetStringField('HireIncomeAccountName',Value);
end;

procedure TAssetHire.SetHireProductName(const Value: string);
begin
  SetStringField('HireProductName',Value);
end;
procedure TAssetHire.SetHirePrintProductname(const Value: string);
begin
  SetStringField('HirePrintProductname',Value);
end;

procedure TAssetHire.SetMinHirePeriodQty(const Value: integer);
begin
  SetIntegerField('MinHirePeriodQty',Value);
end;

procedure TAssetHire.SetMinHirePeriodType(const Value: string);
begin
  SetStringField('MinHirePeriodType',Value);
end;

function TAssetHire.ValidateData: Boolean;
begin
  PostDB;
  result := inherited;
  if not result then Exit;
  PostDb;
  if Count = 0 then exit;
  if not Active then exit;
  result := false;
  if Active and (HireProductName = '') then begin
    AddResult(false,rssWarning,0,'Hire Product Name is Missing');
    exit;
  end;

  result := AllLinesValid;
end;

class function TAssetHire.NewWeekendDayList: TIntegerList;
var
  x: integer;
  dayNo: integer;
begin
  result := TIntegerList.Create;
  dayNo := 0;
  for x := 0 to AppEnv.CompanyPrefs.NoOfWeekendDays -1 do begin
    if x = 0 then
      dayNo := AppEnv.CompanyPrefs.StartWorkWeekDay - 1
    else
      dayNo := dayNo - 1;
    if dayNo = 0 then
      dayNo := 7;
    result.Add(dayNo);
  end;
end;

class function TAssetHire.WeekendDays(aDateTimeFrom,
  aDateTimeTo: TDateTime): integer;
var
  WeekendDayList: TIntegerList;
  x: integer;
begin
  result := 0;
  if AppEnv.CompanyPrefs.NoOfWeekendDays = 0 then exit; // 7 day operation
  WeekendDayList := NewWeekendDayList;
  try
    for x := Trunc(aDateTimeFrom) to Trunc(aDateTimeTo) do begin
      if WeekendDayList.InList(DayOfTheWeek(x)) then
        Inc(result);
    end;
  finally
    WeekendDayList.Free;
  end;
end;

initialization
  RegisterClass(TAssetHire);

end.
