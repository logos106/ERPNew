unit BusObjProcResourceAvailabilityNDS;

interface

  uses Classes, BusObjNDSBase;

type

  TBusObjProcResourceAvailabilityNDS = class(TMSBusObjNDS)
  private
    FProcResourceAvailabilityId: integer;
    FProcResourceId: integer;
    FDescription: string;
    FTimeEnd: TDateTime;
    FTimeStart: TDateTime;
    procedure SetDescription(const Value: string);
    procedure SetProcResourceAvailabilityId(const Value: integer);
    procedure SetProcResourceId(const Value: integer);
    procedure SetTimeEnd(const Value: TDateTime);
    procedure SetTimeStart(const Value: TDateTime);
    function RecordExists: boolean;
  protected
    function GetId: integer; override;
    procedure SetId(const Value: integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    function ValidateData: boolean; override;
    procedure New; override;
  published
    property ProcResourceAvailabilityId: integer read FProcResourceAvailabilityId write SetProcResourceAvailabilityId;
    property ProcResourceId: integer read FProcResourceId write SetProcResourceId;
    property Description: string read FDescription write SetDescription;
    property TimeStart: TDateTime read FTimeStart write SetTimeStart;
    property TimeEnd: TDateTime read FTimeEnd write SetTimeEnd;
  end;

implementation

uses
  BusObjBase, CommonLib, FastFuncs, MyAccess,ERPdbComponents, SysUtils;

{ TBusObjProcResourceAvailabilityNDS }

constructor TBusObjProcResourceAvailabilityNDS.Create(AOwner: TComponent);
begin
  inherited;
  fIdFieldName:= 'ProcResourceAvailabilityId';
  fBusObjectTableName:= 'tblProcResourceAvailability';
end;

function TBusObjProcResourceAvailabilityNDS.GetId: integer;
begin
  result:= ProcResourceAvailabilityId;
end;

procedure TBusObjProcResourceAvailabilityNDS.New;
begin
  inherited;

end;

function TBusObjProcResourceAvailabilityNDS.RecordExists: boolean;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection:= self.Storer.Connection;
    qry.SQL.Add('select * from tblProcResourceAvailability');
    qry.SQL.Add('where ProcResourceId = ' + IntToStr(self.ProcResourceId));
    qry.SQL.Add('and TimeStart = ' + QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss',self.TimeStart)));
    qry.SQL.Add('and TimeEnd = ' + QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss',self.TimeEnd)));
    qry.Open;
    result:= not qry.IsEmpty;
  finally
    qry.Free;
  end;
end;

procedure TBusObjProcResourceAvailabilityNDS.SetDescription(
  const Value: string);
begin
  if FDescription <> Value then begin
    FDescription := Value;
    MakeDirty;
  end;
end;

procedure TBusObjProcResourceAvailabilityNDS.SetId(const Value: integer);
begin
  ProcResourceAvailabilityId:= Value;
end;

procedure TBusObjProcResourceAvailabilityNDS.SetProcResourceAvailabilityId(
  const Value: integer);
begin
  if FProcResourceAvailabilityId <> Value then begin
    FProcResourceAvailabilityId := Value;
    MakeDirty;
  end;
end;

procedure TBusObjProcResourceAvailabilityNDS.SetProcResourceId(
  const Value: integer);
begin
  if FProcResourceId <> Value then begin
    FProcResourceId := Value;
    MAkeDirty;
  end;
end;

procedure TBusObjProcResourceAvailabilityNDS.SetTimeEnd(
  const Value: TDateTime);
begin
  if FTimeEnd <> Value then begin
    FTimeEnd := Value;
    MakeDirty;
  end;
end;

procedure TBusObjProcResourceAvailabilityNDS.SetTimeStart(
  const Value: TDateTime);
begin
  if FTimeStart <> Value then begin
    FTimeStart := Value;
    MakeDirty;
  end;  
end;

function TBusObjProcResourceAvailabilityNDS.ValidateData: boolean;
begin
  result:= true;
  if ProcResourceId < 1 then begin
    result:= false;
    ResultStatus.AddItem(false, rssInfo, 0,
      'Missing resource');
    exit;
  end;
  if Description = '' then begin
    result:= false;
    ResultStatus.AddItem(false, rssInfo, 0,
      'Missing description');
    exit;
  end;
  if TimeStart = 0 then begin
    result:= false;
    ResultStatus.AddItem(false, rssInfo, 0,
      'Missing start time');
    exit;
  end;
  if TimeStart > TimeEnd then begin
    result:= false;
    ResultStatus.AddItem(false, rssInfo, 0,
      'End time is before start time');
    exit;
  end
  else if RecordExists then begin
    result:= false;
    ResultStatus.AddItem(false, rssInfo, 0,
      'A record already exists with these Start and End values');
    exit;
  end;
end;

initialization

  RegisterClassOnce(TBusObjProcResourceAvailabilityNDS);

end.
