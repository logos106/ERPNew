unit frmBaseListtimerMsg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWExtCtrls, Menus, ExtCtrls, StdCtrls, DNMSpeedButton  ;

type
  TfmBaseListtimerMsg = class(TfrmBaseGUI)
    lblMsg: TLabel;
    tmrReportTableMsg: TTimer;
    chkHideMsg: TCheckBox;
    Shape1: TShape;
    btnsynchreporttables: TDNMSpeedButton;
    procedure tmrReportTableMsgTimer(Sender: TObject);
    procedure lblMsgDblClick(Sender: TObject);
    procedure chkHideMsgClick(Sender: TObject);
    procedure btnsynchreporttablesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fsTimerMsg: String;
    fbShowReportTablesMsg :Boolean;
    procedure SetTimerMsg(const Value: String);
    function Listform : TForm;
  public
    Property TimerMsg:String read fsTimerMsg Write SetTimerMsg;
  end;

implementation

uses BaseListingForm, MAIN, LogLib, GuiPrefsObj, AppEnvironment, CommonLib;





{$R *.dfm}

procedure TfmBaseListtimerMsg.btnsynchreporttablesClick(Sender: TObject);
begin
  inherited;
  TBaseListingGUI(Listform).rptsynchreporttablesClick(TBaseListingGUI(Listform).rptsynchreporttables);
end;

procedure TfmBaseListtimerMsg.chkHideMsgClick(Sender: TObject);
begin
  inherited;
  if fbShowReportTablesMsg then exit;
  fbShowReportTablesMsg := true;
  try
      if screen.activecontrol = chkHidemsg then begin
        try
          AppEnv.Employee.ShowReportTablesMsg  := not(chkHidemsg.checked);
        Except
        end;
      end;
  finally
    fbShowReportTablesMsg := False;
  end;
end;

procedure TfmBaseListtimerMsg.FormCreate(Sender: TObject);
begin
  inherited;
  fbShowReportTablesMsg := False;
end;

procedure TfmBaseListtimerMsg.lblMsgDblClick(Sender: TObject);
begin
  inherited;
  tmrReportTableMsgTimer(tmrReportTableMsg);
end;

function TfmBaseListtimerMsg.Listform: TForm;
begin
  Result := nil;
  if Assigned(Owner)then
    if Owner is TForm then
      result := TForm(Owner);
end;

procedure TfmBaseListtimerMsg.SetTimerMsg(const Value: String);
begin
  try
    fsTimerMsg := Value;
    lblMsg.caption := value;
    lblMsg.Refresh;
    tmrReportTableMsg.enabled := true;
    top :=TBaseListingGUI(Listform).top +
          MainForm.MainToolBar.Height +250;
    Left :=trunc((TBaseListingGUI(Listform).Width - Self.Width)/2);
    Width :=900;

    color :=TBaseListingGUI(Listform).color;
     Self.color :=TBaseListingGUI(Listform).Color;
     btnsynchreporttables.caption :=TBaseListingGUI(Listform).rptsynchreporttables.Caption;
     btnsynchreporttables.visible := True;
     Self.show;
     Bringtofront;
  Except
    on E:Exception do begin
    end;
  end;
end;

procedure TfmBaseListtimerMsg.tmrReportTableMsgTimer(Sender: TObject);
begin
  inherited;
  try
    Setcontrolfocus(TBaseListingGUI(Listform).grdmain);
  Except
    on E:Exception do begin
    end;
  end;
  Self.Close;
  tmrReportTableMsg.enabled := False;
end;

end.
