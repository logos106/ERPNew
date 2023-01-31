unit frmHiringTimes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, DNMSpeedButton, StdCtrls, wwdbdatetimepicker,
  DBCtrls, Shader, DNMPanel, Menus, MemDS, DBAccess, MyAccess, ERPdbComponents , BusobjHire , BaseInputForm,
  ProgressDialog, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,ERPTimeCombo;

type
  TfmHiringTimes = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    DBText1: TDBText;
    dsHireLines: TDataSource;
    Label79: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;

    dtHireFrom: TwwDBDateTimePicker;
    dtHireTo: TwwDBDateTimePicker;
    dtActualHireTo: TwwDBDateTimePicker;
    dtActualHireFrom: TwwDBDateTimePicker;
    tmHireFrom: TwwDBDateTimePicker;
    tmActualHireFrom: TwwDBDateTimePicker;
    tmHireTo: TwwDBDateTimePicker;
    tmActualHireTo: TwwDBDateTimePicker;

    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Bevel1: TBevel;
    tmedHireFrom: TErpDbTimeCombo;
    tmedActualHireFrom: TErpDbTimeCombo;
    tmedHireTo: TErpDbTimeCombo;
    tmedActualHireTo: TErpDbTimeCombo;
    lbltimeToHint: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmedHireFromDropDown(Sender: TObject);
    procedure tmedHireToDropDown(Sender: TObject);
    procedure tmedActualHireFromDropDown(Sender: TObject);
    procedure tmedActualHireToDropDown(Sender: TObject);
    procedure tmedHireFromChange(Sender: TObject);
  private
    fHireObj: Thire;
    function getHireLinesdataset: TDataset;
    procedure setHireLinesdataset(const Value: TDataset);
    procedure SetHireObj(const Value: Thire);
    { Private declarations }
  public
    Property HireLinesdataset:TDataset read getHireLinesdataset write setHireLinesdataset;
    property HireObj :Thire read fHireObj write SetHireObj;
  end;

implementation

uses timelib, CommonLib;


{$R *.dfm}

{ TfmHiringTimes }

procedure TfmHiringTimes.btnCancelClick(Sender: TObject);
begin
  inherited;
  HireObj.Connection.RollbackNestedTransaction;
  Self.Close;
end;

procedure TfmHiringTimes.btnSaveClick(Sender: TObject);
begin
  inherited;
  HireObj.Connection.CommitNestedTransaction;
  Self.Close;
end;

procedure TfmHiringTimes.FormCreate(Sender: TObject);
begin
  inherited;
  (*InitTimecombo(tmedHireFrom);
  InitTimecombo(tmedHireTo);
  InitTimecombo(tmedActualHireFrom);
  InitTimecombo(tmedActualHireTo);*)

    dtHireFrom.DisplayFormat        := FormatSettings.ShortDateFormat;
    dtHireTo.DisplayFormat          := FormatSettings.ShortDateFormat;
    dtActualHireTo.DisplayFormat    := FormatSettings.ShortDateFormat;
    dtActualHireFrom.DisplayFormat  := FormatSettings.ShortDateFormat;

    tmHireFrom.DisplayFormat        := FormatSettings.ShortTimeFormat;
    tmActualHireFrom.DisplayFormat  := FormatSettings.ShortTimeFormat;
    tmHireTo.DisplayFormat          := FormatSettings.ShortTimeFormat;
    tmActualHireTo.DisplayFormat    := FormatSettings.ShortTimeFormat;

end;

procedure TfmHiringTimes.FormShow(Sender: TObject);
begin
  inherited;
  HireObj.Connection.BeginNestedTransaction;
  tmHireFrom.readonly       := HireObj.HireLines.hirefrom       = 0;
  tmActualHireFrom.readonly := HireObj.HireLines.ActualhireFrom = 0;
  tmHireTo.readonly         := HireObj.HireLines.HireTo         = 0;
  tmActualHireTo.readonly   := HireObj.HireLines.ActualhireTo   = 0;
  lbltimeToHint.visible := HireObj.HireLines.ActualhireTo   = 0;

  tmedHireFrom.readonly       := HireObj.HireLines.hirefrom       = 0;
  tmedActualHireFrom.readonly := HireObj.HireLines.ActualhireFrom = 0;
  tmedHireTo.readonly         := HireObj.HireLines.HireTo         = 0;
  tmedActualHireTo.readonly   := HireObj.HireLines.ActualhireTo   = 0;

end;

function TfmHiringTimes.getHireLinesdataset: TDataset;
begin
  REsult := dsHireLines.DataSet;
end;

procedure TfmHiringTimes.setHireLinesdataset(const Value: TDataset);
begin
  dsHireLines.DataSet := Value;
end;

procedure TfmHiringTimes.SetHireObj(const Value: Thire);
begin
  fHireObj := Value;
  HireLinesdataset := Value.HireLines.Dataset;
end;

procedure TfmHiringTimes.tmedActualHireFromDropDown(Sender: TObject);begin  inherited;  LocateTime(Sender , HireObj.Hirelines.ActualHirefromTime );end;
procedure TfmHiringTimes.tmedActualHireToDropDown(Sender: TObject);begin  inherited;LocateTime(Sender , HireObj.Hirelines.actualHiretoTime );end;
procedure TfmHiringTimes.tmedHireFromChange(Sender: TObject);
begin
  inherited;
//  HireObj.Hirelines.ActualHirefromTime := tmedHireFrom.text;
end;

procedure TfmHiringTimes.tmedHireFromDropDown(Sender: TObject);begin  inherited;  LocateTime(Sender , HireObj.Hirelines.HirefromTime );end;
procedure TfmHiringTimes.tmedHireToDropDown(Sender: TObject);begin  inherited;  LocateTime(Sender , HireObj.Hirelines.HireToTime );end;

end.
