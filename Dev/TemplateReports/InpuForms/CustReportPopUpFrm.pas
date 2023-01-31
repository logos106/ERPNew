unit CustReportPopUpFrm;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 14/07/05  1.00.01 IJB  Changed "Purchase" to "Purchases" in selector list
  //                        to match hard coded group name.


interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, DNMSpeedButton, ExtCtrls, Mask, wwdbedit, Wwdotdot, Wwdbcomb,
  Shader, DNMPanel, frmBase;

type
  TCustReportPopUpGUI = class(TfrmBaseGUI)
    Bevel1: TBevel;
    edtReport: TEdit;
    ReportGUI: TLabel;
    OKBtn: TDNMSpeedButton;
    CancelBtn: TDNMSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    cboTabs: TwwDBComboBox;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
    bOkClicked: boolean;
  public
    { Public declarations }
  end;

//var
//  CustReportPopUpGUI: TCustReportPopUpGUI;

implementation

{$R *.dfm}
uses
  Dialogs, CommonLib;

procedure TCustReportPopUpGUI.FormShow(Sender: TObject);
begin
  inherited;
  bOkClicked := false;
  cboTabs.Text := '';
  cboTabs.ItemIndex := -1;
  SetControlFocus(edtReport);
end;

procedure TCustReportPopUpGUI.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if bOkClicked and Empty(edtReport.Text) then begin
    CommonLib.MessageDlgXP_Vista('You must provide a Report Name', mtWarning, [mbOK], 0);
    bOkClicked := false;
    SetControlFocus(edtReport);
    CanClose := false;
  end;
end;

procedure TCustReportPopUpGUI.OKBtnClick(Sender: TObject);
begin
  bOkClicked := true;
end;

end.
