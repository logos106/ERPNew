unit frmProcCapacityPlanDurationEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, AppEvnts, ExtCtrls, StdCtrls, Mask, AdvSpin,
  DNMSpeedButton, DNMPanel;

type
  TfmProcCapacityPlanDurationEdit = class(TBaseForm)
    pnlBottom: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    edtDuration: TMaskEdit;
    Label1: TLabel;
    ApplicationEvents1: TApplicationEvents;
    procedure FormShow(Sender: TObject);
    procedure edtDurationExit(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
  private
    function GetDuration: double;
    procedure SetDuration(const Value: double);
    { Private declarations }
  public
    property Duration: double read GetDuration write SetDuration;
  end;

var
  fmProcCapacityPlanDurationEdit: TfmProcCapacityPlanDurationEdit;

implementation

uses
  CommonLib, ProcessUtils, FastFuncs;

{$R *.dfm}

{ TfmProcCapacityPlanDurationEdit }

function TfmProcCapacityPlanDurationEdit.GetDuration: double;
begin
  result:= StrToProcTime(edtDuration.Text);
end;

procedure TfmProcCapacityPlanDurationEdit.SetDuration(const Value: double);
begin
  edtDuration.Text:= ProcTimeToStr(Value);
end;

procedure TfmProcCapacityPlanDurationEdit.FormShow(Sender: TObject);
begin
  inherited;
  SetControlFocus(edtDuration);
end;

procedure TfmProcCapacityPlanDurationEdit.edtDurationExit(Sender: TObject);
begin
  inherited;
  TMaskEdit(Sender).Text:=
    StringReplace(TMaskEdit(Sender).Text,' ','0',[rfReplaceAll]);
end;

procedure TfmProcCapacityPlanDurationEdit.ApplicationEvents1Exception(
  Sender: TObject; E: Exception);
begin
  inherited;
  if E is EDBEditError then begin
    if ActiveControl = edtDuration then
      MessageDlgXP_Vista('Duration time format is not correct (must be hh:mm), use Esc to cancel changes.',mtInformation,[mbOk],0);
  end
  else
    raise E;
end;

end.
