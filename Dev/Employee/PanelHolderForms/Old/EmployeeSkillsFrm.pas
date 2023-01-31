unit EmployeeSkillsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBAccess, MyAccess, StdCtrls, wwdblook, ExtCtrls, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, MemDS, DNMPanel,BusObjEmployeePay;

type
  TEmployeeSkillsGUI = class(TForm)
    DNMPanel1: TDNMPanel;
    dsEmpSkills: TDataSource;
    grdEmpSkills: TwwDBGrid;
    grdEmpSkillsIButton: TwwIButton;
    Bevel1: TBevel;
    dsEmployeeProcessSteps: TDataSource;
    qryEmployeeProcessSteps: TMyQuery;
    qryEmployeeProcessStepsEmpProcessStepsID: TAutoIncField;
    qryEmployeeProcessStepsGlobalRef: TStringField;
    qryEmployeeProcessStepsEmployeeID: TIntegerField;
    qryEmployeeProcessStepsEmployeeName: TStringField;
    qryEmployeeProcessStepsProcessStepID: TIntegerField;
    qryEmployeeProcessStepsProcessStep: TStringField;
    qryEmployeeProcessStepsActive: TStringField;
    qryEmployeeProcessStepsmsTimeStamp: TDateTimeField;
    grdEmployeeProcessSteps: TwwDBGrid;
    grdEmployeeProcessStepsIButton: TwwIButton;
    Label6: TLabel;
    Label11: TLabel;
    cboSkills: TwwDBLookupCombo;
    cboProcessSteps: TwwDBLookupCombo;
    qrySkills: TMyQuery;
    qrySkillsSkill: TStringField;
    qrySkillsSkillID: TAutoIncField;
    MyConnectionSkills: TMyConnection;
    qryProcessSteps: TMyQuery;
    qryProcessStepsDescription: TStringField;
    qryProcessStepsID: TIntegerField;
    procedure SetSubEmpPay(Const Value :Temployeepay );
    procedure grdEmpSkillsIButtonClick(Sender: TObject);
    procedure grdEmployeeProcessStepsIButtonClick(Sender: TObject);
  private
    fSubEmpPay:Temployeepay;
  public
    { Public declarations }
    property SubEmpPay:Temployeepay  read fSubEmpPay write SetSubEmpPay ;
  end;


implementation

{$R *.dfm}
uses CommonLib;

procedure TEmployeeSkillsGUI.SetSubEmpPay(Const Value :Temployeepay);
begin
  fSubEmpPay := Value;
end;

procedure TEmployeeSkillsGUI.grdEmpSkillsIButtonClick(Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      if not Assigned(SubEmpPay) then exit;
      SubEmpPay.EmployeeSkills.Delete;
    finally
    end;
  end;
end;

procedure TEmployeeSkillsGUI.grdEmployeeProcessStepsIButtonClick(
  Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      if not Assigned(SubEmpPay) then exit;
    //  SubEmpPay.em  .Delete;
    finally
    end;
  end;
end;

initialization
  RegisterClass(TEmployeeSkillsGUI);
end.
