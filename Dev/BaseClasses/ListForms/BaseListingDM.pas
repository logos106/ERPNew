unit BaseListingDM;

interface

uses
  SysUtils, Classes, DB, MemDS, DBAccess, MyAccess, ERPdbComponents;

type
  TBaseListingDat = class(TDataModule)
    connMain: TERPConnection;
    qryMain: TERPQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    FDateTo: TDateTime;
    FDateFrom: TDateTime;
    FIgnoreDates: boolean;
    fFilter: string;
    procedure SetFilter(const Value: string);
  protected
    procedure SetDateFrom(const Value: TDateTime); virtual;
    procedure SetDateTo(const Value: TDateTime); virtual;
    procedure SetIgnoreDates(const Value: boolean); virtual;
  public
    property DateFrom: TDateTime read FDateFrom write SetDateFrom;
    property DateTo: TDateTime read FDateTo write SetDateTo;
    property IgnoreDates: boolean read FIgnoreDates write SetIgnoreDates;
    property Filter: string read fFilter write SetFilter;
  end;

var
  BaseListingDat: TBaseListingDat;

implementation

uses
  CommonDbLib;

{$R *.dfm}

procedure TBaseListingDat.DataModuleCreate(Sender: TObject);
begin
  fFilter := '';
  { clear design time connection props }
  ConnMain.Connected := false;
  ConnMain.Password := '';
  ConnMain.Username := '';
  ConnMain.Database := '';
  ConnMain.Server := '';

  qryMain.Connection := CommonDbLib.GetSharedMyDacConnection;
  IgnoreDates := true;
end;

procedure TBaseListingDat.SetDateFrom(const Value: TDateTime);
begin
  FDateFrom := Value;
  if qryMain.ParamExists('DateFrom') then
    qryMain.ParamByName('DateFrom').AsDateTime := Value;
end;

procedure TBaseListingDat.SetDateTo(const Value: TDateTime);
begin
  FDateTo := Value;
  if qryMain.ParamExists('DateTo') then
    qryMain.ParamByName('DateTo').AsDateTime := Value;
end;

procedure TBaseListingDat.SetFilter(const Value: string);
begin
  fFilter := Value;
  if Value = '' then begin
    qryMain.Filtered := false;
    qryMain.Filter := Value;
  end
  else begin
    qryMain.Filter := Value;
    qryMain.Filtered := true;
  end;
end;

procedure TBaseListingDat.SetIgnoreDates(const Value: boolean);
begin
  FIgnoreDates := Value;
  if Value then begin
    DateFrom := 0;
    DateTo := MaxDateTime;
  end
  else begin
    DateFrom := fDateFrom;
    DateTo := fDateTo;
  end;
end;

end.
