unit RepObjBase;

interface

uses
  Classes, JsonObject;

type

  TRepObjBase = class(TPersistent)
  private
  protected
    fJson: TJsonObject;
    fParams: TJsonObject;
//    FDateTo: TDateTime;
//    FDateFrom: TDateTime;
//    FIgnoreDates: boolean;
    function GetReportName: string; virtual; abstract;
//    procedure SetDateFrom(const Value: TDateTime); virtual;
//    procedure SetDateTo(const Value: TDateTime); virtual;
//    procedure SetIgnoreDates(const Value: boolean); virtual;
    procedure SetParams(const Value: TJsonObject); virtual;
    function GetJson: TJsonObject; virtual;
    procedure LoadJson(obj: TJsonObject); virtual;
  public
    constructor Create;
    destructor Destroy; override;
    property Json: TJsonObject read GetJson;
    property Params: TJsonObject read fParams write SetParams;
    function JsonResult: TJsonObject;
  published
//    property DateFrom: TDateTime read FDateFrom write SetDateFrom;
//    property DateTo: TDateTime read FDateTo write SetDateTo;
//    property IgnoreDates: boolean read FIgnoreDates write SetIgnoreDates;
    property ReportName: string read GetReportName;
  end;

implementation

{ TRepObjBase }

constructor TRepObjBase.Create;
begin
  fJson := nil;
  fParams := nil;
end;

destructor TRepObjBase.Destroy;
begin
  fJson.Free;
  inherited;
end;

function TRepObjBase.GetJson: TJsonObject;
begin
  if not Assigned(fJson) then begin
    fJson := TJsonObject.Create;
    LoadJson(fJson);
  end;
  result := fJson;
end;

function TRepObjBase.JsonResult: TJsonObject;
begin
  result := TJsonObject.Create;
  LoadJson(result);
end;

procedure TRepObjBase.LoadJson(obj: TJsonObject);
begin
  obj.S['ReportName']:= ReportName;
end;

procedure TRepObjBase.SetParams(const Value: TJsonObject);
begin
  fParams := Value;
end;

//procedure TRepObjBase.SetDateFrom(const Value: TDateTime);
//begin
//  FDateFrom := Value;
//end;
//
//procedure TRepObjBase.SetDateTo(const Value: TDateTime);
//begin
//  FDateTo := Value;
//end;
//
//procedure TRepObjBase.SetIgnoreDates(const Value: boolean);
//begin
//  FIgnoreDates := Value;
//end;

end.
