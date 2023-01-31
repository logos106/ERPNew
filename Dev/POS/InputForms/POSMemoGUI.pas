unit POSMemoGUI;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
     Buttons, DNMSpeedButton, ExtCtrls, frmBase;

type
  TPOSMemoPopUpFrm = class(TfrmBaseGUI)
    OKBtn: TDNMSpeedButton;
    CancelBtn: TDNMSpeedButton;
    Bevel1: TBevel;
    edtMemo: TMemo;
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonLib, CommonDbLib;

{$R *.dfm}

procedure TPOSMemoPopUpFrm.FormShow(Sender: TObject);
begin
  inherited;
  SetControlFocus(edtMemo);
end;
procedure TPOSMemoPopUpFrm.FormPaint(Sender: TObject);
begin
  PaintGradientColor(Self);
end;

initialization
  RegisterClassOnce(TPOSMemoPopUpfrm);
end.
