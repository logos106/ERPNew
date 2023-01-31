unit BaseHintForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SelectionDialog, AppEvnts, DB,  StdCtrls,
  wwcheckbox, DNMSpeedButton, ExtCtrls, frmBase, Menus;

type
  TBaseHintGUI = class(TfrmBaseGUI)
    chkDontShowHint: TwwCheckBox;
    Label1: TLabel;
    Panel1: TPanel;
    HintMemo: TMemo;
    HintHeader: TLabel;
    Image1: TImage;
    btnClose: TDNMSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
    fsHintWindowTitle: string;
    fsHintTitle: string;
    fsHintMemo: string;
    fbDontShowHint: boolean;
  public
    { Public declarations }
    procedure RefreshHintDisplay;
    property HintWindowTitle: string read fsHintWindowTitle write fsHintWindowTitle;
    property HintTitle: string read fsHintTitle write fsHintTitle;
    property HintMemoString: string read fsHintMemo write fsHintMemo;
    property DontShowHint: boolean read fbDontShowHint write fbDontShowHint;
  end;

var
  BaseHintGUI: TBaseHintGUI;

implementation

uses CommonDbLib;

{$R *.dfm}

procedure TBaseHintGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;


procedure TBaseHintGUI.RefreshHintDisplay;
begin
  Caption := fsHintWindowTitle;
  HintHeader.Caption := fsHintTitle;
  HintMemo.Lines.Text := fsHintMemo;
  chkDontShowHint.Checked := fbDontShowHint;
end;

procedure TBaseHintGUI.FormPaint(Sender: TObject);
begin
  PaintGradientColor(Self);
end;

end.
