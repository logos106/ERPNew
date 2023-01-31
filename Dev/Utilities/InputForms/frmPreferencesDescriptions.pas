unit frmPreferencesDescriptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel, DAScript,
  MyScript;

type
  TfmPreferencesDescriptions = class(TBaseInputGUI)
    SctMain: TERPScript;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel1: TDNMPanel;
    cmdsave: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    memDetails: TMemo;
    DNMSpeedButton1: TDNMSpeedButton;
    procedure cmdCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdsaveClick(Sender: TObject);
    procedure SctMainBeforeExecute(Sender: TObject; var SQL: string;
      var Omit: Boolean);
    procedure SctMainError(Sender: TObject; E: Exception; SQL: string;
      var Action: TErrorAction);
    procedure DNMSpeedButton1Click(Sender: TObject);
  private
    sqlcnt :Integer;

    procedure LoadSQL;
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses LogLib, CommonLib, tcConst, shellapi, BusObjPrejerenceToExport;

const
  sqlfilename = '\\192.168.1.110\Development\P1\prefs.lib';
{$R *.dfm}
procedure TfmPreferencesDescriptions.LoadSQL;
Procedure formatnLogSQL(filename:String);
var
  ctr:Integer;
begin
  sctmain.SQL.clear;
  sctmain.SQL.LoadFromFile(filename);
  sctmain.SQL.text  := Trim(sctmain.SQL.text );

  sctmain.SQL.text := replacestr(sctmain.SQL.text, '`' , ' ');
  //sctmain.SQL.text := replacestr(sctmain.SQL.text, '''' , '"');

  logtext(NL+NL+'/*'+filename+'*/', sqlfilename);
  logtext(sctmain.SQL.TExt, sqlfilename);
  memDetails.lines.add(filename);
end;
begin
  clog('', sqlfilename);
  memDetails.lines.clear;
  sctmain.connection := Myconnection;
  formatnLogSQL('D:\ERP\SQL\dbprefs-1.sql');
  formatnLogSQL('D:\ERP\SQL\dbprefs-2.sql');
  formatnLogSQL('D:\ERP\SQL\dbprefs-3.sql');
  formatnLogSQL('D:\ERP\SQL\dbprefs-4.sql');
  formatnLogSQL('D:\ERP\SQL\dbprefs-5.sql');
  formatnLogSQL('D:\ERP\SQL\dbprefs-6.sql');
  ShellExecute(Handle, 'open', PChar(sqlfilename), '', '', SW_SHOW);
end;

procedure TfmPreferencesDescriptions.SctMainError(Sender: TObject; E: Exception;
  SQL: string; var Action: TErrorAction);
begin
  inherited;
  Action :=  eaContinue ;
  if devmode then
    logtext(E.message+NL+SQL+NL+'===================================================');
end;

procedure TfmPreferencesDescriptions.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.close;
end;

procedure TfmPreferencesDescriptions.cmdsaveClick(Sender: TObject);
begin
  inherited;
  LoadSQL;

  if MessageDlgXP_Vista('Do you Want to Run the script?', mtConfirmation, [mbYes, mbNo], 0) = mryes then begin
      sctmain.SQL.clear;
      sctmain.SQL.LoadFromFile(sqlfilename);
    DoShowProgressbar(SctMain.SQL.Count,WAITMSG);
    try
      sqlcnt := 0;
      memDetails.lines.clear;
      clog('');
      sctmain.Execute;
    finally
      DoHideProgressbar;
    end;
  end;
end;

procedure TfmPreferencesDescriptions.DNMSpeedButton1Click(Sender: TObject);
var
  obj : TPrejerenceToExport;
begin
  inherited;
  obj := TPrejerenceToExport.CreateWithNewConn(Self);
  try

  finally
    freeandnil(obj);
  end;
end;

procedure TfmPreferencesDescriptions.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := cafree;
end;
procedure TfmPreferencesDescriptions.SctMainBeforeExecute(Sender: TObject;
  var SQL: string; var Omit: Boolean);
begin
  inherited;
  sqlcnt := sqlcnt +1;
  DoStepProgressbar(inttostr(sqlcnt)+' of ' + inttostr(sctmain.sql.count));
  memDetails.lines.add(SQL);
end;

Initialization
  RegisterClassOnce(TfmPreferencesDescriptions);

end.
