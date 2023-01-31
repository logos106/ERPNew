unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, JsonObject;

type
  TfmMain = class(TForm)
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    edtERPExecName: TEdit;
    Label1: TLabel;
    edtDocNo: TEdit;
    Label2: TLabel;
    btnExport: TButton;
    edtOutputPath: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    edtFTPServer: TEdit;
    edtFTPFolder: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    edtFTPUser: TEdit;
    Label7: TLabel;
    edtFTPPass: TEdit;
    chkSaveToFolder: TCheckBox;
    chkSaveToFTP: TCheckBox;
    procedure Timer1Timer(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtOutputPathChange(Sender: TObject);
    procedure edtFTPServerChange(Sender: TObject);
    procedure edtFTPFolderChange(Sender: TObject);
    procedure edtFTPUserChange(Sender: TObject);
    procedure edtFTPPassChange(Sender: TObject);
    procedure chkSaveToFolderClick(Sender: TObject);
    procedure chkSaveToFTPClick(Sender: TObject);
    procedure edtERPExecNameChange(Sender: TObject);
  private
    fERPPath: string;
    fServer, fDatabase: string;
    fConnectionFileAge: integer;
    Config: TJsonObject;
    Loading: boolean;
    function ERPRunning: boolean;
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

uses
  AppRunUtils, IniFiles, SalesOrderFTPExportObj;

procedure TfmMain.btnExportClick(Sender: TObject);
var
  Exporter: TSalesOrderFTPExport;
  msg: string;
  SaveCursor: TCursor;
begin
  if edtDocNo.Text = '' then begin
    MessageDlg('Please enter a Sales Order Number.', mtWarning, [mbOk], 0);
    exit;
  end;
  if not ERPRunning then begin
    MessageDlg('Please start ERP first.', mtWarning, [mbOk], 0);
    exit;
  end;
  SaveCursor:= Screen.Cursor;
  try
    Screen.Cursor:= crHourGlass;
    self.Enabled:= false;
    Exporter:= TSalesOrderFTPExport.Create;
    try
      Exporter.ServerName:= self.fServer;
      Exporter.DatabaseName:= self.fDatabase;
      Exporter.FTPHost:= Config.S['FTPServer'];
      Exporter.FTPUser:= Config.S['FTPUser'];
      Exporter.FTPPass:= Config.S['FTPPass'];
      Exporter.FTPFolder:= Config.S['FTPFolder'];
      Exporter.OutputFolder:= Config.S['OutputPath'];
      Exporter.OutputToFile:= Config.B['SaveToFolder'];
      Exporter.OutputToFTP:= Config.B['SaveToFTP'];
      if Config.S['ERPExecName'] = '' then begin
        Config.S['ERPExecName']:= 'ERP.exe';
        Config.SaveToFile(ChangeFileExt(Application.ExeName,'.cfg'));
      end;
      edtERPExecName.Text:= Config.S['ERPExecName'];
      if Exporter.ExportSalesOrder(edtDocNo.Text,msg) then begin
        MessageDlg('File SalesOrder_' + edtDocNo.Text + '.txt has been exported.', mtInformation, [mbOk], 0);
      end
      else begin
        MessageDlg('Export failed: ' + msg, mtWarning, [mbOk], 0);
      end;

    finally
      Exporter.Free;
    end;

  finally
    self.Enabled:= true;
    Screen.Cursor:= SaveCursor;
  end;
end;

procedure TfmMain.chkSaveToFolderClick(Sender: TObject);
begin
  if Loading then Exit;
  Config.B['SaveToFolder']:= chkSaveToFolder.Checked;
  Config.SaveToFile(ChangeFileExt(Application.ExeName,'.cfg'));
end;

procedure TfmMain.chkSaveToFTPClick(Sender: TObject);
begin
  if Loading then Exit;
  Config.B['SaveToFTP']:= chkSaveToFTP.Checked;
  Config.SaveToFile(ChangeFileExt(Application.ExeName,'.cfg'));
end;

procedure TfmMain.edtERPExecNameChange(Sender: TObject);
begin
  if Loading then Exit;
  Config.S['ERPExecName']:= edtERPExecName.Text;
  Config.SaveToFile(ChangeFileExt(Application.ExeName,'.cfg'));
end;

procedure TfmMain.edtFTPFolderChange(Sender: TObject);
begin
  if Loading then Exit;
  Config.S['FTPFolder']:= edtFTPFolder.Text;
  Config.SaveToFile(ChangeFileExt(Application.ExeName,'.cfg'));
end;

procedure TfmMain.edtFTPPassChange(Sender: TObject);
begin
  if Loading then Exit;
  Config.S['FTPPass']:= edtFTPPass.Text;
  Config.SaveToFile(ChangeFileExt(Application.ExeName,'.cfg'));
end;

procedure TfmMain.edtFTPServerChange(Sender: TObject);
begin
  if Loading then Exit;
  Config.S['FTPServer']:= edtFTPServer.Text;
  Config.SaveToFile(ChangeFileExt(Application.ExeName,'.cfg'));
end;

procedure TfmMain.edtFTPUserChange(Sender: TObject);
begin
  if Loading then Exit;
  Config.S['FTPUser']:= edtFTPUser.Text;
  Config.SaveToFile(ChangeFileExt(Application.ExeName,'.cfg'));
end;

procedure TfmMain.edtOutputPathChange(Sender: TObject);
begin
  if Loading then Exit;
  Config.S['OutputPath']:= edtOutputPath.Text;
  Config.SaveToFile(ChangeFileExt(Application.ExeName,'.cfg'));
end;

function TfmMain.ERPRunning: boolean;
var
  ExeName, s: string;
  Age: integer;
  Ini: TIniFile;
begin
  if edtERPExecName.Text <> '' then
    ExeName:= ExtractFileName(edtERPExecName.Text)
  else
    ExeName:= 'erp.exe';
  s:= GetProcessPath(ExeName);
  result:= s <> '';
  if result then begin
    fERPPath:= ExtractFilePath(s);
    Age:= FileAge(fERPPath + 'connection.ini');
    if (fConnectionFileAge <> Age) or (fServer = '') then begin
      fConnectionFileAge:= Age;
      Ini := TIniFile.Create(fERPPath + 'connection.ini');
      try
        fServer:= Ini.ReadString('Last_Database','LastConnectServer','');
        fDatabase:= Ini.ReadString('Last_Database','Database','');
        StatusBar1.Panels.Items[0].Text:= 'Server: ' + fServer;
        StatusBar1.Panels.Items[1].Text:= 'Database: ' + fDatabase;
      finally
        Ini.Free;
      end;
    end;
  end
  else begin
    fERPPath:= '';
    fDatabase:= '';
    fServer:= '';
    StatusBar1.Panels.Items[0].Text:= 'Server:';
    StatusBar1.Panels.Items[1].Text:= 'Database:';
  end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  Loading:= true;
  try
    Config:= TJsonObject.Create;
    Config.LoadFromFile(ChangeFileExt(Application.ExeName,'.cfg'));
    edtOutputPath.Text:= Config.S['OutputPath'];
    edtFTPServer.Text:= Config.S['FTPServer'];
    edtFTPFolder.Text:= Config.S['FTPFolder'];
    edtFTPUser.Text:= Config.S['FTPUser'];
    edtFTPPass.Text:= Config.S['FTPPass'];
    chkSaveToFolder.Checked:= Config.B['SaveToFolder'];
    chkSaveToFTP.Checked:= Config.B['SaveToFTP'];
  finally
    Loading:= false;
  end;
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  Config.Free;
end;

procedure TfmMain.Timer1Timer(Sender: TObject);
begin
  { check if connection.ini has changed }
  if ERPRunning then begin


  end;
end;

end.
