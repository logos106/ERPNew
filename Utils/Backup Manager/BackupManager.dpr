program BackupManager;

{%File 'BackupManager.inc'}

uses
  ExcMagic,
  ExcMagicGUI,
  Forms,
  OgFirst,
  ExMagicUnit in 'ExMagicUnit.pas',
  BackupManagerObj in 'BackupManagerObj.pas',
  frmBackupManager in 'frmBackupManager.pas' {BackupManagerGUI};

{$R *.res}

begin
  Application.Title := 'Database Manager';
  if IsFirstInstance then begin
    Application.Initialize;
    Application.CreateForm(TBackupManagerGUI, BackupManagerGUI);
  Application.Run;
  end else begin
    ActivateFirstInstance;
  end;
end.
