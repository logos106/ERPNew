unit frmPayPeriodPopUp;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, DNMSpeedButton, ExtCtrls, ComCtrls,AdvOfficeStatusBar, wwdbdatetimepicker,
  frmBase, Menus;

type
  TPayPeriodGUI = class(TfrmBaseGUI)
    Bevel1: TBevel;
    Label1: TLabel;
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    label2: TLabel;
    dtpCommence: TwwDBDateTimePicker;
    dtpDatePaid: TwwDBDateTimePicker;
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonDbLib, CommonLib;

{$R *.dfm}

procedure TPayPeriodGUI.FormShow(Sender: TObject);
begin
 inherited;
 dtpDatePaid.DateTime := Now;
end;

procedure TPayPeriodGUI.FormCreate(Sender: TObject);
begin
  inherited;
  dtpCommence.displayformat := FormatSettings.ShortDateFormat;
  dtpDatePaid.displayformat := FormatSettings.ShortDateFormat;
end;

procedure TPayPeriodGUI.FormPaint(Sender: TObject);
begin
  PaintGradientColor(Self);
end;

initialization
  RegisterClassOnce(TPayPeriodGUI);


end.
