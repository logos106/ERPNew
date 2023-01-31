{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 28/06/2005  1.00.01 BJ Initital version. When the appointment is rescheduled,
                        this form comes up to specify the action for the rescheduled
                        dates of the repeated appointments}
unit frmRescheduleAppt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseInputForm, DataState, DBAccess, MyAccess,ERPdbComponents, SelectionDialog,
  AppEvnts, DB,  StdCtrls, Buttons, DNMSpeedButton, ExtCtrls, Menus, AdvMenus,
  Shader, DNMPanel, BusObjAppointments, MemDS, ImgList;

type
  TfmRescheduleAppt = class(TBaseInputGUI)
    Panel2: TPanel;
    rgSaturday: TRadioGroup;
    Panel3: TPanel;
    rgSunday: TRadioGroup;
    Panel4: TPanel;
    rgHoliday: TRadioGroup;
    bbOK: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure bbOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    procedure GetRescheduleActions(const Value: TRescheduleActions);
    procedure SetRescheduleActions(const Value: TRescheduleActions);
  end;

implementation

uses
  Forms, CommonLib;



{$R *.dfm}

procedure TfmRescheduleAppt.bbOKClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfmRescheduleAppt.FormShow(Sender: TObject);
begin
  //  inherited;
end;

procedure TfmRescheduleAppt.GetRescheduleActions(const Value: TRescheduleActions);
begin
  Value.Saturday := TRescheduleAction(rgSaturday.ItemIndex);
  Value.Sunday := TRescheduleAction(rgSunday.ItemIndex);
  Value.Holiday := TRescheduleAction(rgHoliday.ItemIndex);
end;

procedure TfmRescheduleAppt.SetRescheduleActions(const Value: TRescheduleActions);
begin
  rgSaturday.ItemIndex := Integer(Value.Saturday);
  rgSunday.ItemIndex := Integer(Value.Sunday);
  rgHoliday.ItemIndex := Integer(Value.Holiday);
end;

initialization
  RegisterClassOnce(TfmRescheduleAppt);

end.
