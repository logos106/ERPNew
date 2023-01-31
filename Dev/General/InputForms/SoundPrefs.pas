unit SoundPrefs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BasePrefs, ExtCtrls, StdCtrls, DB, DataSourcePrefs, DNMPanel, DNMSpeedButton, Mask, wwdbedit,MessageConst, wwcheckbox,
  Menus, AdvScrollBox;

type
  TSoundPrefsGUI = class(TBasePrefsGUI)
    dsPrefs: TDataSourcePrefs;
    OpensoundfileDlg: TOpenDialog;
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label1: TLabel;
    DNMPanel2: TDNMPanel;
    Bevel2: TBevel;
    lblSavesoundfile: TLabel;
    Bevel3: TBevel;
    Bevel7: TBevel;
    Bevel14: TBevel;
    btnSavesoundfiletry: TImage;
    chkSavesoundfile: TwwCheckBox;
    edtSavesoundfile: TwwDBEdit;
    btnSavesoundfile: TDNMSpeedButton;
    DNMPanel3: TDNMPanel;
    Bevel6: TBevel;
    Bevel5: TBevel;
    Bevel4: TBevel;
    lblCancelsoundfile: TLabel;
    Bevel15: TBevel;
    btnCancelsoundfiletry: TImage;
    chkCancelsoundfile: TwwCheckBox;
    edtCancelsoundfile: TwwDBEdit;
    btnCancelsoundfile: TDNMSpeedButton;
    DNMPanel4: TDNMPanel;
    Bevel10: TBevel;
    Bevel8: TBevel;
    Bevel9: TBevel;
    lblPrintsoundfile: TLabel;
    Bevel16: TBevel;
    btnPrintsoundfiletry: TImage;
    chkPrintsoundfile: TwwCheckBox;
    edtPrintsoundfile: TwwDBEdit;
    btnPrintsoundfile: TDNMSpeedButton;
    DNMPanel5: TDNMPanel;
    Bevel13: TBevel;
    Bevel11: TBevel;
    Bevel12: TBevel;
    lblEmailsoundfile: TLabel;
    Bevel17: TBevel;
    btnEmailsoundfiletry: TImage;
    chkEmailsoundfile: TwwCheckBox;
    edtEmailsoundfile: TwwDBEdit;
    btnEmailsoundfile: TDNMSpeedButton;
    procedure btnSavesoundfileClick(Sender: TObject);
    procedure btnCancelsoundfileClick(Sender: TObject);
    procedure btnPrintsoundfileClick(Sender: TObject);
    procedure btnEmailsoundfileClick(Sender: TObject);
    procedure btnCancelsoundfiletryClick(Sender: TObject);
    procedure btnEmailsoundfiletryClick(Sender: TObject);
    procedure btnPrintsoundfiletryClick(Sender: TObject);
    procedure btnSavesoundfiletryClick(Sender: TObject);
  private
    procedure Choosefile(const edtfileName: TWWDBEdit);
    procedure PlaySound(SoundfileFieldName: String);
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    procedure PerformFinish(var Msg: TMessage); message TX_PerformFinish;
  Protected
    procedure StartupProcess(var Msg: TMessage); Override;
    procedure FinishProcess(var Msg: TMessage); Override;
  public
  end;


implementation

uses CommonLib;

{$R *.dfm}

{ TSoundPrefsGUI }
Procedure TSoundPrefsGUI.Choosefile(const edtfileName :TWWDBEdit);
var
  s:String;
begin
  s:= trim(edtfileName.Text);
  if s<> '' then OpensoundfileDlg.Filename   := s;
  if OpensoundfileDlg.Execute then        s := OpensoundfileDlg.Filename  ;
  if not (dsPrefs.Dataset.state in [dsEdit,dsInsert])  then dsPrefs.DataSet.Edit;
  dsPrefs.DataSet.FieldByName(edtfileName.DataField).AsString :=s;
  if (dsPrefs.Dataset.state in [dsEdit,dsInsert])  then dsPrefs.DataSet.Post;
  edtfileName.Text:= s;
  edtfileName.Refresh;
end;

procedure TSoundPrefsGUI.btnCancelsoundfileClick(Sender: TObject);begin  choosefile(edtCancelsoundfile);end;
procedure TSoundPrefsGUI.btnEmailsoundfileClick (Sender: TObject);begin  choosefile(edtEmailsoundfile );end;
procedure TSoundPrefsGUI.btnPrintsoundfileClick (Sender: TObject);begin  choosefile(edtPrintsoundfile );end;
procedure TSoundPrefsGUI.btnSavesoundfileClick  (Sender: TObject);begin  choosefile(edtSavesoundfile  );end;
procedure TSoundPrefsGUI.btnCancelsoundfiletryClick(Sender: TObject);begin  PlaySound(edtCancelsoundfile.DataField);end;
procedure TSoundPrefsGUI.btnEmailsoundfiletryClick (Sender: TObject);begin  PlaySound(edtEmailsoundfile.DataField );end;
procedure TSoundPrefsGUI.btnPrintsoundfiletryClick (Sender: TObject);begin  PlaySound(edtPrintsoundfile.DataField );end;
procedure TSoundPrefsGUI.btnSavesoundfiletryClick  (Sender: TObject);begin  PlaySound(edtSavesoundfile.DataField  );end;
procedure TSoundPrefsGUI.PlaySound(SoundfileFieldName:String);begin  commonlib.PlaySound(true , dsPrefs.Dataset.fieldByname(SoundfileFieldName).asString);end;
procedure TSoundPrefsGUI.PerformFinish(var Msg: TMessage);
begin
  DoPrefformFinish(Msg);
end;

procedure TSoundPrefsGUI.PerformStartup(var Msg: TMessage);
begin
   DoPerformStartup(Msg);
end;
procedure TSoundPrefsGUI.StartupProcess(var Msg: TMessage);
begin
  inherited;

end;
procedure TSoundPrefsGUI.FinishProcess(var Msg: TMessage);
begin
  inherited;

end;

initialization
  RegisterClassOnce(TSoundPrefsGUI);
finalization
  UnRegisterClass(TSoundPrefsGUI);

end.

