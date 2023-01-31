unit frmLogs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, StdCtrls, Buttons, DNMSpeedButton, ComCtrls,AdvOfficeStatusBar, DBAccess, MyAccess,ERPdbComponents,
  SelectionDialog, AppEvnts, DB,  DataState, Menus, AdvMenus, ExtCtrls,
  MemDS, ImgList, ProgressDialog;

type
  TfrmLogsGUI = class(TBaseInputGUI)
    RichEdit1: TRichEdit;
    cmdClose: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    btnPrint: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPrintClick(Sender: TObject);

  private
    { Private declarations }
    slLines: TStringList;
    sFileName: string;
    iMaxLines: integer;

    procedure SetLogLines(const Value: TStringList);
    procedure SetFilename(const Value: string);

  public
    { Public declarations }
    
    procedure AddLogEntry(const sText: string);
    procedure SaveLog;
    procedure ClearLog;

    property LogLines: TStringList read slLines write SetLogLines;
    property LogFilename: string read sFileName write SetFilename;
    property MaxLines: integer read iMaxLines write iMaxLines default 0;
    
  end;

implementation

uses
  CommonLib;

{$R *.dfm}

  
{ TfrmLogsGUI }

procedure TfrmLogsGUI.SetLogLines(Const Value: TStringList);
begin
  try
    RichEdit1.Lines.Assign(Value);
    slLines := Value;
  except
    slLines := nil;
  end;
end;

procedure TfrmLogsGUI.FormCreate(Sender: TObject);
begin
  Self.fbIgnoreAccessLevels := true;
  inherited;
end;

procedure TfrmLogsGUI.cmdCloseClick(Sender: TObject);
var
  fs: TSaveDialog;
begin
  inherited;
  fs := TSaveDialog.Create(self);
  try
    fs.Title       := 'Save Log As ...';
    fs.Options     := [ofFileMustExist, ofCreatePrompt];
    fs.Filter      := 'ERP Log File|*.log';
    fs.FilterIndex := 1;
    fs.DefaultExt  := 'log';
    if fs.Execute then begin
      try
        // Attempt to Save log to file.
        RichEdit1.Lines.SaveToFile(fs.FileName);
      except
        // Report error to user.
        CommonLib.MessageDlgXP_Vista('Failed to Save log file!', mtWarning, [mbOK], 0);
      end;
    end;

    if Self.FormState = [fsModal] then begin
      ModalResult := mrOk;
    end else begin
      Close;
    end;
  finally
    // Free our used objects.
    if Assigned(fs) then
      FreeandNil(fs);
  end;
end;

procedure TfrmLogsGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  if Self.FormState = [fsModal] then begin
    ModalResult := mrCancel;
  end else begin
    Close;
  end;
end;

procedure TfrmLogsGUI.SetFilename(Const Value: string);
begin
  try
    // Clear log.
    RichEdit1.Lines.Clear;
    // Attempt to load log into Richedit.
    RichEdit1.Lines.LoadFromFile(Value);
    // Save our new filename.
    sFileName := Value;
  except
    CommonLib.MessageDlgXP_Vista('Log Filename is NOT valid and cannot be loaded.', mtWarning, [mbOK], 0);
    sFileName := '';
  end;
end;

procedure TfrmLogsGUI.AddLogEntry(Const sText: string);
begin
  // Add log line.
  RichEdit1.Lines.Add(DateTimeToStr(Now) + ' > ' + sText);

  // Has the log file have a line limit?
  if MaxLines <> 0 then begin
    // Does the contents exceed maximum line limit?
    if RichEdit1.Lines.Count > MaxLines then begin
      // Yes, delete the top line.
      RichEdit1.Lines.Delete(0);
    end;
  end;
end;

procedure TfrmLogsGUI.ClearLog;
begin
  // Clear Log
  RichEdit1.Lines.Clear;
end;

procedure TfrmLogsGUI.SaveLog;
begin
  try
    // Save log to designated file.
    Richedit1.Lines.SaveToFile(sFileName);
  except
    CommonLib.MessageDlgXP_Vista('Failed to Save Log file!', mtWarning, [mbOK], 0);
  end;
end;

procedure TfrmLogsGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmLogsGUI.btnPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    RichEdit1.Print('Operation Logs - Print Out: ' + DateToStr(Now));
  finally
    EnableForm;
  end;  
end;

initialization
  RegisterClassOnce(TfrmLogsGUI);

end.
