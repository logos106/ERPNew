unit frmTerminateHint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseHintForm, StdCtrls, Buttons, DNMSpeedButton, ExtCtrls, wwcheckbox, 
  DB, MemDS, DBAccess, MyAccess,ERPdbComponents;

type
  TfrmTerminationHint = class(TBaseHintGUI)
    qryHints: TERPQuery;
    chkApplyToAll: TwwCheckBox;
    Label2: TLabel;
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure SetToSavedPreferences(const TotalHintDescription: String);
    procedure ReinstateHint(const TotalHintDescription: String);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;


implementation

uses
  CommonDbLib,  AppEnvironment, CommonLib;

{$R *.dfm}

procedure TfrmTerminationHint.ReinstateHint(Const TotalHintDescription: String);
begin
  try
    qryHints.Connection :=   CommonDbLib.GetSharedMyDacConnection;
    qryHints.SQL.Clear;
    qryHints.SQL.Add('SELECT * FROM tblhints WHERE Description = ');
    qryHints.SQL.Add(QuotedStr(TotalHintDescription));
    qryHints.SQL.Add(' AND LogonName = ');
    qryHints.SQL.Add(QuotedStr(AppEnv.Employee.LogonName));
    qryHints.Open;
    qryHints.Edit;
    qryHints.FieldByName('DontShow').AsString := 'F';
    qryHints.Post;
  except

  end;

end;

procedure TfrmTerminationHint.SetToSavedPreferences(Const TotalHintDescription:String);
begin
  try
    qryHints.Connection :=   CommonDbLib.GetSharedMyDacConnection;
    qryHints.SQL.Clear;
    qryHints.SQL.Add('SELECT * FROM tblhints WHERE Description = ');
    qryHints.SQL.Add(QuotedStr(TotalHintDescription));
    qryHints.SQL.Add(' AND LogonName = ');
    qryHints.SQL.Add(QuotedStr(AppEnv.Employee.LogonName));
    qryHints.Open;

    if  qryHints.FieldByName('DontShow').asString = 'T' then begin
      chkDontShowHint.Checked := True;
    end else begin
      chkDontShowHint.Checked := False;
    end;

    Self.Width := qryHints.FieldByName('Width').AsInteger;
    Self.Height := qryHints.FieldByName('FormHeight').AsInteger;
    Self.Left := qryHints.FieldByName('FormLeft').AsInteger;
    Self.Top := qryHints.FieldByName('Top').AsInteger;
  except

  end;
end;


procedure TfrmTerminationHint.btnCloseClick(Sender: TObject);

begin
  inherited;
  qryHints.Edit;
  if chkDontShowHint.Checked = True then begin
    qryHints.FieldByName('DontShow').asString := 'T';
  end else begin
    qryHints.FieldByName('DontShow').asString := 'F';
  end;
  
  if chkApplyToAll.Checked = True then begin
    qryHints.Close;
    qryHints.SQL.Clear;
    qryHints.SQL.Add('SELECT * FROM tblhints');
    qryHints.SQL.Add(' WHERE LogonName = ');
    qryHints.SQL.Add(QuotedStr(AppEnv.Employee.LogonName));
    qryHints.Open;
    
    qryHints.First;
    while not qryHints.Eof do begin
      qryHints.Edit;
      qryHints.FieldByName('Width').AsInteger := self.Width;
      qryHints.FieldByName('FormHeight').AsInteger := self.Height;
      qryHints.FieldByName('FormLeft').AsInteger := Self.Left;
      qryHints.FieldByName('Top').AsInteger := Self.Top;
      qryHints.Post;
      qryHints.Next;
    end;
  end else begin
    qryHints.FieldByName('Width').AsInteger := self.Width;
    qryHints.FieldByName('FormHeight').AsInteger := self.Height;
    qryHints.FieldByName('FormLeft').AsInteger := Self.Left;
    qryHints.FieldByName('Top').AsInteger := Self.Top;
    qryHints.Post;
  end;

  Self.Close;
end;

procedure TfrmTerminationHint.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmTerminationHint.FormCreate(Sender: TObject);
begin
  inherited;
  try


  finally

  end;
end;

procedure TfrmTerminationHint.FormResize(Sender: TObject);
begin
  inherited;
  Self.Panel1.Width := Self.Width - 22;
  Self.HintMemo.Width := Self.Width - 79;
//  Self.btnClose.Left :=  Self.Width - Self.btnClose.Width - 10;

  Self.Panel1.Height := Self.Height - 72;
  Self.HintMemo.Height := Self.Height - 114;
//  Self.btnClose.Top := Self.Top +  283;
end;

Initialization
  RegisterClassOnce(TfrmTerminationHint);
end.
