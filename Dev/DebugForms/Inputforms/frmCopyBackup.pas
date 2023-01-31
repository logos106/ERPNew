unit frmCopyBackup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, BaseInputForm;

type
  TfmCopyBackup = class(TBaseInputGUI)
    OpenDialog1: TOpenDialog;
    btnchoosefile: TButton;
    lblFrom: TLabel;
    lblto: TLabel;
    ProgressBar1: TProgressBar;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure btnchoosefileClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnchoosefileMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCopyBackup: TfmCopyBackup;

implementation

uses ShellAPI, CommonLib, LogLib, InstallConst;

{$R *.dfm}

procedure TfmCopyBackup.btnchoosefileClick(Sender: TObject);
var
  filename:String;
  filepath:String;
  sCmd :String;
begin
 OpenDialog1.InitialDir := lblfrom.Caption ;
 if not OpenDialog1.Execute then exit;
 filename := Opendialog1.FileName;

 if filename ='' then exit;
 ProgressBar1.Min:= 1;
 ProgressBar1.Max := 10;
 ProgressBar1.Step := 1;
 ProgressBar1.Visible := True;
 try
  filepath := ExtractShortPathName(ExtractFileDir(filename));
  filepath := replacestr(filepath , '\\DEMO1-PC\Client Data' , 'x:\');
  ProgressBar1.stepit;
  filename := ExtractFileName(filename);
  ProgressBar1.stepit;
  filename := replacestr(filename, '.zip', '.*');
  ProgressBar1.stepit;
//  sCmd := Pwidechar('/c ' +ExtractShortPathName('C:\ERP Software\Backup\copyERPBackup\copyERPBackup.bat' ) +' ' + Trim(filepath)+' '  + Trim(filename ));
  sCmd := Pwidechar('/c ' +ExtractShortPathName(ERP_SERVER_ROOT_DIR + ERP_BACKUP_DIR + 'copyERPBackup\copyERPBackup.bat' ) +' ' + Trim(filepath)+' '  + Trim(filename ));
  ProgressBar1.stepit;
  logtext(sCmd);
  ShellExecuteW (application.handle, 'open', 'cmd', PChar(sCmd), nil, SW_MAXIMIZE);
  ProgressBar1.stepit;
 finally
   ProgressBar1.Visible := False;
   btnchoosefile.Caption := 'Done';
   btnchoosefile.Refresh;
   Timer1.Enabled:= True;
 end;

end;

procedure TfmCopyBackup.btnchoosefileMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Timer1Timer(nil);
end;

procedure TfmCopyBackup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmCopyBackup.FormCreate(Sender: TObject);
begin
  lblfrom.Caption := 'Backup folder : y:\Client Data\';
  lblto.Caption   := 'Copy to folder : C:\ERPSof~1\Backup';
end;

procedure TfmCopyBackup.Timer1Timer(Sender: TObject);
begin
  btnchoosefile.Caption := 'Choose Backup file to Copy';
  btnchoosefile.Refresh;
  Timer1.Enabled:= false;
end;
initialization
  RegisterClassOnce(TfmCopyBackup);

end.
