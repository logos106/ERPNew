unit BaseInputForm;

interface
uses
  Windows, BaseForm, DB, ADODB,Controls, ExtCtrls, DNMPanel,
  Classes, StdCtrls,SysUtils, Buttons,Forms,Graphics,Dialogs, MemDS,
  DBAccess, MyAccess, DNMSpeedButton, Shader;

type
  TBaseInputGUI = class(TBaseFormGUI)
    DSMaster: TDataSource;
    DBConnection: TMyConnection;
    qryMaster: TMyQuery;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Cancel: TDNMSpeedButton;
    Print: TDNMSpeedButton;
    Save: TDNMSpeedButton;
    New: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CancelClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PrintClick(Sender: TObject);
    procedure PrintMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure NewClick(Sender: TObject);
  private
    { Private declarations }
    fiKeyID: Integer;
  protected
    fsBitmapClass: string;
    flstObservers: TList;
    procedure CloseQueries;
    procedure OpenQueries; overload;
    procedure OpenQueries(const QueryNamesNotToOpen: array of string); overload;
    function SaveRecord :Boolean;
    procedure BeginTransaction;
    procedure CommitTransaction;
    procedure RollbackTransaction(Const OnRollbackPerformed: TProcedure);
    procedure Notify;
  public
    { Public declarations }
    class function Instance: TBaseInputGUI; virtual;
    Function GetObserver: TObject;
    procedure AttachObserver(const oObserver: TObject);
    procedure DetachObserver(const oObserver: TObject);
    property KeyID: Integer read fiKeyID write fiKeyID;
  end;

implementation

uses Main,FuncLib,BaseListingForm,BaseDataMod, FastFuncs;

{$R *.dfm}

class function TBaseInputGUI.Instance: TBaseInputGUI;
begin
  // this should only be called if implemented in descendant class
  raise Exception.Create('Instance not implemented');
end;

procedure TBaseInputGUI.FormCreate(Sender: TObject);
var
  SavedCursor: TCursor;
begin
  inherited;
  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    flstObservers := TList.Create;
  finally
    Screen.Cursor := SavedCursor;
  end;
  DBConnection.Disconnect;
  DBConnection.LoginPrompt := BaseDataModule.NonTransDBConnection.LoginPrompt;
  DBConnection.Database := BaseDataModule.NonTransDBConnection.Database;
  DBConnection.Username := BaseDataModule.NonTransDBConnection.Username;
  DBConnection.Password := BaseDataModule.NonTransDBConnection.Password;
  DBConnection.Port := BaseDataModule.NonTransDBConnection.Port;  
  DBConnection.Options.Protocol := BaseDataModule.NonTransDBConnection.Options.Protocol;
  DBConnection.Server := BaseDataModule.NonTransDBConnection.Server;
  DBConnection.Connect;
end;

procedure TBaseInputGUI.FormDestroy(Sender: TObject);
begin
  flstObservers.Clear;
  flstObservers.Free;
end;

procedure TBaseInputGUI.FormShow(Sender: TObject);
var
  SavedCursor: TCursor;
begin
  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    Top := ((MainGUI.ClientHeight - MainGUI.StatusBar.Height) - Self.Height) div 2;
    Left := (MainGUI.ClientWidth - Self.Width) div 2;
    BeginTransaction;
    qryMaster.Close;
    qryMaster.Open;
    if (KeyID <> 0) or (qryMaster.RecordCount<>0) then begin
      qryMaster.Edit;
    end else begin
      qryMaster.Insert;
    end;
  finally
    Screen.Cursor := SavedCursor;
  end;
end;

function TBaseInputGUI.GetObserver: TObject;
begin
  Result := nil;
  If flstObservers.Count = 0 then Exit;
  If Assigned(flstObservers[0]) then
    Result := flstObservers[0];
end;

procedure TBaseInputGUI.AttachObserver(const oObserver: TObject);
begin
  Assert(oObserver <> nil, 'TBaseInputGUI cannot attach a NIL object');
  if flstObservers.IndexOf(oObserver) = -1 then begin
    flstObservers.Add(oObserver);
  end;
end;

procedure TBaseInputGUI.DetachObserver(const oObserver: TObject);
begin
  if oObserver <> nil then begin
    flstObservers.Remove(oObserver);
  end;
end;

procedure TBaseInputGUI.Notify;
var
  i: integer;
begin
  Try
    for i := 0 to flstObservers.Count - 1 do begin
      If not Assigned(flstObservers[i]) then Continue;
      if not Empty(TForm(flstObservers[i]).Name) then begin
        if TForm(flstObservers[i]) is TBaseListingGUI then begin
          TBaseListingGUI(flstObservers[i]).UpdateMe;
        end;
      end;
    end;
  Except
  End;
end;

procedure TBaseInputGUI.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

procedure TBaseInputGUI.CancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TBaseInputGUI.SaveClick(Sender: TObject);
begin
  inherited;
  If SaveRecord Then Self.Close;
end;

function TBaseInputGUI.SaveRecord: Boolean;
begin
  Try
    Self.qryMaster.Edit;
    Self.qryMaster.Post;
    CommitTransaction;
    Notify;
    Result := True;
  Except
    on e: exception do begin
      RollbackTransaction(nil);
      raise Exception.Create(e.Message + chr(13) + 'Errors occured in ' + Self.ClassName);
    end;
  end;
end;

procedure TBaseInputGUI.BeginTransaction;
begin
  if Self.DBConnection.Connected and not Self.DBConnection.InTransaction then begin
     Self.DBConnection.StartTransaction;
  end;
end;

procedure TBaseInputGUI.CommitTransaction;
begin
  try
    if Self.DBConnection.Connected and Self.DBConnection.InTransaction then begin
       Self.DBConnection.Commit;
    end;
  except
    on e: exception do begin
       RollbackTransaction(nil);
       raise Exception.Create(e.Message + chr(13) + 'Errors occured in ' + Self.ClassName);
    end;
  end;
end;

procedure TBaseInputGUI.RollbackTransaction(const OnRollbackPerformed: TProcedure);
begin
  if Self.DBConnection.Connected and Self.DBConnection.InTransaction then begin
    try
      Self.DBConnection.Rollback;
    except
      on e: exception do begin
        raise Exception.Create(e.Message + chr(13) + 'Errors occured in ' + Self.ClassName);
      end;
    end;
  end;
end;

procedure TBaseInputGUI.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TBaseInputGUI.PrintClick(Sender: TObject);
var
  SavedCursor: TCursor;
begin
  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    If not Empty(ReportName) Then Begin
      If Print.Caption = 'Designer' then Begin
        DesignReport;
        Print.Caption := 'Print';
      end else If Print.Caption = 'Import' then Begin
        ImportReport;
        Print.Caption := 'Print';
      end else If Print.Caption = 'Export' then Begin
        ExportReport;
        Print.Caption := 'Print';
      end else begin
        PrintReport;
      end;
    end;
  finally
    Screen.Cursor := SavedCursor;
  end;
end;

procedure TBaseInputGUI.PrintMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if (Shift=[ssCtrl]) then begin
     Print.Caption := 'Designer';
  end else if (Shift=[ssCtrl,ssShift]) then begin
     Print.Caption := 'Export';
  end else if (Shift=[ssCtrl,ssAlt]) then begin
     Print.Caption := 'Import';
  end else Begin
     Print.Caption := 'Print';
  End;
end;

procedure TBaseInputGUI.NewClick(Sender: TObject);
begin
  inherited;
  If SaveRecord Then begin
    FormShow(nil);
    KeyID := 0;
  end;  
end;

procedure TBaseInputGUI.CloseQueries;
var
  iIndex: Integer;
begin
  for iIndex := 0 to ComponentCount - 1 do
    if Self.Components[iIndex] is TCustomMyDataSet then
      if TCustomMyDataSet(Components[iIndex]).Active then
        TCustomMyDataSet(Components[iIndex]).Close;
end;

procedure TBaseInputGUI.OpenQueries;
var
  DummyArray: array of string;
begin
  DummyArray := nil;
  OpenQueries(DummyArray);
end;


procedure TBaseInputGUI.OpenQueries(const QueryNamesNotToOpen: array of string);
var
  iIndex, iCount: Integer;
  bDoOpen: Boolean;
  savedCursor: TCursor;
begin
  savedCursor := Screen.Cursor;
  try
    Screen.Cursor := crHourGlass;
    iIndex:= 0;
    while iIndex < Self.ComponentCount do begin
      if Self.Components[iIndex] is TCustomMyDataSet then begin
        with Self.Components[iIndex] as TCustomMyDataSet do begin
          bDoOpen := true;
          for iCount := low(QueryNamesNotToOpen) to High(QueryNamesNotToOpen) do begin
            if FastFuncs.UpperCase(Self.Components[iIndex].Name) = FastFuncs.UpperCase(QueryNamesNotToOpen[iCount]) then begin
              bDoOpen := false;
              break;
            end;
          end;
          if bDoOpen then
          begin
            Open;
          end;
        end;
      end;
      Inc(iIndex);
    end;
  finally
    Screen.Cursor := savedCursor;
  end;
end;

end.
