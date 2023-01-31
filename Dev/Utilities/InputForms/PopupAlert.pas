unit PopupAlert;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseHintForm, StdCtrls, Buttons, DNMSpeedButton, ExtCtrls, wwcheckbox,
  Menus;

type
  TPopupAlertGUI = class(TBaseHintGUI)
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    fsMsgStr: string;
    fsHeaderMsgStr: string;
  public
    { Public declarations }
    //class function Instance: TPopupAlertGUI;
    property MsgStr: string read fsMsgStr write fsMsgStr;
    property HeaderMsgStr: string read fsHeaderMsgStr write fsHeaderMsgStr;
  end;

//var
//  PopupAlertGUI: TPopupAlertGUI;

implementation
    
uses FastFuncs,CommonLib;
{$R *.dfm}

const
  CRLF_STR = '{CRLF}';

procedure TPopupAlertGUI.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TPopupAlertGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TPopupAlertGUI.FormShow(Sender: TObject);
begin
  inherited;
  HintHeader.Caption := fsHeaderMsgStr;
  HintMemo.Lines.Clear;
  fsMsgStr := ReplaceStr(Trim(fsMsgStr), CRLF_STR, #13);
  HintMemo.Lines.SetText(PChar(fsMsgStr));
  SetControlFocus(btnClose);
end;

Initialization
  RegisterClassOnce(TPopupAlertGUI);

end.
