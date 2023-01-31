unit BaseRollaBlindWizard;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 24/05/06  1.00.01 DSP  Initial version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, DNMSpeedButton, DNMPanel,
  StdCtrls, MemDS, DBCtrls, RollaBlindQueryLoadObj;

type
  TBaseRollaBlindWizardGUI = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    btnBack: TDNMSpeedButton;
    btnNext: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryMain: TMyQuery;
    qryHeading: TMyQuery;
    qryHeadingLeadNumber: TIntegerField;
    qryHeadingTitle: TStringField;
    qryHeadingFirstName: TStringField;
    qryHeadingSurname: TStringField;
    dsMain: TDataSource;
    dsHeading: TDataSource;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    ScrollBox: TScrollBox;
    Label3: TLabel;
    txtLeadNumber: TDBText;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    txtTitle: TDBText;
    txtFirstName: TDBText;
    txtSurname: TDBText;
    txtSheetNumber: TDBText;
    Bevel1: TBevel;
    pnlTitle: TDNMPanel;
    imgArrow: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNextClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fRollbackID: string;
    fLeadNumber: string;
    fSheetID: Integer;
    fInitialSetup: Boolean;
    fDataChanged: Boolean;
    fNextFormClassName: string;
    fBackFormClassName: string;
    fQueryLoad: TRollaBlindQueryLoad;
    procedure ExitWizard;
    procedure SetInitialSetup(const Value: Boolean);
  protected
    procedure SaveData; //virtual;
    function GetWizardConnection: TMyConnection;
    procedure RemoveFormFromList; //virtual;
    procedure FreeAllFormsInList; //virtual;
    procedure CMFocusChanged(var Message: TCMFOCUSCHANGED); message CM_FOCUSCHANGED;
  public
    property RollbackID: string read fRollbackID write fRollbackID;
    property LeadNumber: string read fLeadNumber write fLeadNumber;
    property SheetID: Integer read fSheetID write fSheetID;
    property InitialSetup: Boolean read fInitialSetup write SetInitialSetup;
    property DataChanged: Boolean read fDataChanged write fDataChanged;
    property NextFormClassName: string read fNextFormClassName write fNextFormClassName;
    property BackFormClassName: string read fBackFormClassName write fBackFormClassName;
    property QueryLoad: TRollaBlindQueryLoad read fQueryLoad;
  end;

implementation

{$R *.dfm}

uses
  CommonLib, CommonDbLib;

var
  FormList: TList;
  WizardConnection: TMyConnection;

procedure TBaseRollaBlindWizardGUI.FormCreate(Sender: TObject);
var
  Index: Integer;
begin
  TitleLabel.Caption := Caption;
  inherited;
  fRollbackID := '';
  fLeadNumber := '';
  fSheetID := 0;
  fInitialSetup := True;
  fDataChanged := False;
  fNextFormClassName := '';
  fBackFormClassName := '';
  if not Assigned(FormList) then
    FormList := TList.Create;

  FormList.Add(Self);

  if not Assigned(WizardConnection) then begin
    WizardConnection := TMyConnection.Create(nil);
    CommonDbLib.SetMyDacConnection(WizardConnection);
    WizardConnection.Connected:= true;
  end;

  fQueryLoad := TRollaBlindQueryLoad.Create;
  fQueryLoad.Connection := WizardConnection;

  for Index := 0 to ComponentCount - 1 do begin
    if Components[Index] is TMyQuery then
      TMyQuery(Components[Index]).Connection := WizardConnection;
  end;
end;

procedure TBaseRollaBlindWizardGUI.FormShow(Sender: TObject);
begin
  inherited;
  OpenQueries;

  if fLeadNumber <> '' then begin
    qryHeading.Close;
    qryHeading.ParamByName('ClientID').AsString := fLeadNumber;
    qryHeading.Open;
    qryMain.Locate('SheetID', fSheetID, [loCaseInsensitive]);
  end;
end;

procedure TBaseRollaBlindWizardGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  Response: TModalResult;
begin
  inherited;

  if DataChanged then begin
    Response := CommonLib.MessageDlgXP_Vista('Lose all entries that have been made?', mtConfirmation, [mbYes, mbNo], 0);

    if Response = mrNo then
      Action := caNone
    else begin
      ExitWizard;
      Action := caFree;
    end;
  end
  else begin
    ExitWizard;
    Action := caFree;
  end;
end;

procedure TBaseRollaBlindWizardGUI.btnNextClick(Sender: TObject);
var
  qrySave: TMyQuery;
  TmpComp: TComponent;
begin
  inherited;

  if WizardConnection.InTransaction then begin
    qrySave := TMyQuery.Create(Self);
    qrySave.Options.FlatBuffers := True;
    try
      SaveData;
      qrySave.Connection := WizardConnection;
      qrySave.SQL.Text := 'SAVEPOINT ' + Name;
      qrySave.Execute;
    finally
      FreeandNil(qrySave);
    end;
  end;

  TmpComp := GetComponentByClassName(NextFormClassName);

  if Assigned(TmpComp) then begin
    with TBaseRollaBlindWizardGUI(TmpComp) do begin
      LeadNumber := Self.txtLeadNumber.Field.AsString;
      SheetID := Self.txtSheetNumber.Field.AsInteger;
      RollbackID := Self.Name;
      FormStyle := fsMDIChild;
      BringToFront;
    end;

    ShowWindow(Handle, SW_HIDE);
  end;
end;

procedure TBaseRollaBlindWizardGUI.btnBackClick(Sender: TObject);
var
  TmpComp: TComponent;
  qryRollback: TMyQuery;
begin
  inherited;

  if WizardConnection.InTransaction  and (not Empty(fRollbackID)) then begin
    qryRollback := TMyQuery.Create(Self);
    qryRollback.Options.FlatBuffers := True;
    try
      qryRollback.Connection := WizardConnection;
      qryRollback.SQL.Text := 'ROLLBACK TO SAVEPOINT ' + fRollbackID;
      qryRollback.Execute;
    finally
      FreeandNil(qryRollback);
    end;

    TmpComp := GetComponentByClassName(BackFormClassName);

    if Assigned(TmpComp) then begin
      RemoveFormFromList;
      ShowWindow(TForm(TmpComp).Handle, SW_SHOW);
      Release;
    end;
  end;
end;

procedure TBaseRollaBlindWizardGUI.SaveData;
var
  Index: Integer;
begin
  for Index := 0 to ComponentCount - 1 do begin
    if Components[Index] is TMyQuery then begin
      if TMyQuery(Components[Index]).State in [dsEdit, dsInsert] then
        TMyQuery(Components[Index]).Post;
    end;
  end;
end;

procedure TBaseRollaBlindWizardGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TBaseRollaBlindWizardGUI.GetWizardConnection: TMyConnection;
begin
  Result := WizardConnection;
end;

procedure TBaseRollaBlindWizardGUI.RemoveFormFromList;
var
  Index: Integer;
  FoundMatch: Boolean;
begin
  FoundMatch := False;
  Index := FormList.Count - 1;

  while (Index >= 0) and (not FoundMatch) do begin
    if TForm(FormList.Items[Index]).Name = Name then begin
      FormList.Delete(Index);
      FoundMatch := True;
    end
    else
      Dec(Index);
  end;
end;

procedure TBaseRollaBlindWizardGUI.FreeAllFormsInList;
begin
  while FormList.Count > 0 do begin
    TForm(FormList.Items[0]).Release;
    FormList.Delete(0);
  end;
end;

procedure TBaseRollaBlindWizardGUI.FormDestroy(Sender: TObject);
begin
  FreeandNil(fQueryLoad);
  if Assigned(FormList) and (FormList.Count = 0) then begin
    FreeAndNil(FormList);
    FreeAndNil(WizardConnection);
  end;
  inherited;
end;

procedure TBaseRollaBlindWizardGUI.ExitWizard;
begin
  if WizardConnection.InTransaction then
    WizardConnection.Rollback;

  while FormList.Count > 0 do begin
    if TForm(FormList.Items[0]).Name <> Name then
      TForm(FormList.Items[0]).Release;

    FormList.Delete(0);
  end;
end;

procedure TBaseRollaBlindWizardGUI.CMFocusChanged(var Message: TCMFOCUSCHANGED);
var
  Sender: TWinControl;
begin
  Sender := Message.Sender;

  if Assigned(Sender) and InitialSetup then begin
    if not (Sender is TDNMSpeedButton) then begin
      imgArrow.Left := Sender.Left - imgArrow.Width;
      imgArrow.Top := Sender.Top + ((Sender.Height - imgArrow.Height) div 2) + 1;
      imgArrow.Show;
    end
    else
      imgArrow.Hide;
  end;

  inherited;
end;

procedure TBaseRollaBlindWizardGUI.SetInitialSetup(const Value: Boolean);
begin
  if Value <> fInitialSetup then begin
    fInitialSetup := Value;

    if Value = False then
      imgArrow.Hide;
  end;
end;

initialization
  FormList := nil;
  WizardConnection := nil;
end.
