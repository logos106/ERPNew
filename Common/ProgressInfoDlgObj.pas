unit ProgressInfoDlgObj;

interface

uses
  ProgressInfoObj, ProgressDialog;

type

  TProgressInfoDlgClass = class of TProgressInfoDlg;

  TProgressInfoDlg = class(TProgressInfo)
  private
    Dlg: TProgressDialog;
  protected
    function GetCaption: string; override;
    function GetMaxValue: integer;  override;
    function GetMessage: string; override;
    function GetMinValue: integer; override;
    function GetStep: integer; override;
    function GetValue: integer; override;
    procedure SetCaption(const Value: string); override;
    procedure SetMaxValue(const Value: integer); override;
    procedure SetMessage(const Value: string); override;
    procedure SetMinValue(const Value: integer); override;
    procedure SetStep(const Value: integer); override;
    procedure SetValue(const Value: integer); override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Execute; override;
    procedure StepIt; override;
    procedure CloseDialog; override;
  end;


implementation

uses
  Classes, SysUtils;

{ TProgressInfoDlg }

procedure TProgressInfoDlg.CloseDialog;
begin
  Dlg.CloseDialog;
//  FreeAndNil(Dlg);
end;

constructor TProgressInfoDlg.Create;
begin
  inherited;
  Dlg := TProgressDialog.Create(nil);
end;

destructor TProgressInfoDlg.Destroy;
begin
  Dlg.Free;
  inherited;
end;

procedure TProgressInfoDlg.Execute;
begin
  if Assigned(Dlg) then
    Dlg.Execute;
end;

function TProgressInfoDlg.GetCaption: string;
begin
  result := '';
  if Assigned(Dlg) then
    result := Dlg.Caption;
end;

function TProgressInfoDlg.GetMaxValue: integer;
begin
  result := 0;
  if Assigned(Dlg) then
    result := Dlg.MaxValue;
end;

function TProgressInfoDlg.GetMessage: string;
begin
  result := '';
  if Assigned(Dlg) then
    result := Dlg.Message;
end;

function TProgressInfoDlg.GetMinValue: integer;
begin
  result := 0;
  if Assigned(Dlg) then
    result := Dlg.MinValue;
end;

function TProgressInfoDlg.GetStep: integer;
begin
  result := 0;
  if Assigned(Dlg) then
    result := Dlg.Step;
end;

function TProgressInfoDlg.GetValue: integer;
begin
  result := 0;
  if Assigned(Dlg) then
    result := Dlg.Value;
end;

procedure TProgressInfoDlg.SetCaption(const Value: string);
begin
  if Assigned(Dlg) then
    Dlg.Caption := Value;
end;

procedure TProgressInfoDlg.SetMaxValue(const Value: integer);
begin
  if Assigned(Dlg) then
    Dlg.MaxValue := Value;
end;

procedure TProgressInfoDlg.SetMessage(const Value: string);
begin
  if Assigned(Dlg) then
    Dlg.Message := Value;
end;

procedure TProgressInfoDlg.SetMinValue(const Value: integer);
begin
  if Assigned(Dlg) then
    Dlg.MinValue := Value;
end;

procedure TProgressInfoDlg.SetStep(const Value: integer);
begin
  if Assigned(Dlg) then
    Dlg.Step := Value;
end;

procedure TProgressInfoDlg.SetValue(const Value: integer);
begin
  if Assigned(Dlg) then
    Dlg.Value := Value;
end;

procedure TProgressInfoDlg.StepIt;
begin
  if Assigned(Dlg) then
    Dlg.StepIt;
end;

initialization

  RegisterClass(TProgressInfoDlg);

end.
