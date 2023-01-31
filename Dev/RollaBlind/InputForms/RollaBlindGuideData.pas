unit RollaBlindGuideData;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 18/05/06  1.00.01 DSP  Initial version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, DNMSpeedButton, DNMPanel,
  MemDS, StdCtrls, wwclearbuttongroup, wwradiogroup, wwdblook, wwdbedit,
  Mask, Wwdotdot, Wwdbcomb, wwcheckbox;

type
  TRollaBlindGuideDataGUI = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    pnlTitle: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Bevel1: TBevel;
    Label1: TLabel;
    qryMain: TMyQuery;
    qryProfileType: TMyQuery;
    dsMain: TDataSource;
    Label2: TLabel;
    cboProfileType: TwwDBLookupCombo;
    Label3: TLabel;
    cboGuideType: TwwDBComboBox;
    Label4: TLabel;
    Label5: TLabel;
    edtLength: TwwDBEdit;
    edtItemNumber: TwwDBEdit;
    grpStandard: TwwRadioGroup;
    btnNew: TDNMSpeedButton;
    chkPerforated: TwwCheckBox;
    chkClipped: TwwCheckBox;
    Label6: TLabel;
    Label7: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
  private
    procedure SaveData;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  FormFactory, CommonLib;

procedure TRollaBlindGuideDataGUI.FormShow(Sender: TObject);
begin
  inherited;
  OpenQueries;

  if KeyID = 0 then
    qryMain.Insert
  else
    qryMain.Locate('GuideDataID', KeyID, [loCaseInsensitive]);

  if not DataState.IsActive then
    DataState.Activate;

  DataState.Dirty := False;
end;

procedure TRollaBlindGuideDataGUI.FormCreate(Sender: TObject);
begin
  TitleLabel.Caption := Caption;
  inherited;
  if not MyConnection.InTransaction then
    BeginTransaction;
end;

procedure TRollaBlindGuideDataGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  Response: TModalResult;
begin
  inherited;

  if DataState.Dirty then
    Response := CommonLib.MessageDlgXP_Vista('Do you wish to keep the changes you made ?', mtConfirmation, [mbNo, mbYes, mbCancel], 0)
  else
    Response := mrNo;

  if Response = mrCancel then
    Action := caNone
  else begin
    if MyConnection.InTransaction then begin
      if Response = mrYes then begin
        SaveData;
        CloseQueries;
        CommitTransaction;
        Notify;
      end
      else
        RollbackTransaction;
    end;

    Action := caFree;
  end;
end;

procedure TRollaBlindGuideDataGUI.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveData;
  CloseQueries;

  if MyConnection.InTransaction then
    CommitTransaction;

  Notify;
  Release;
end;

procedure TRollaBlindGuideDataGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TRollaBlindGuideDataGUI.SaveData;
var
  Index: Integer;
begin
  if qryMain.State in [dsEdit, dsInsert] then
    qryMain.FieldByName('ProfileTypeID').AsInteger := qryProfileType.FieldByName('ProfileTypeID').AsInteger;

  for Index := 0 to ComponentCount - 1 do begin
    if Components[Index] is TMyQuery then begin
      if TMyQuery(Components[Index]).State in [dsEdit, dsInsert] then
        TMyQuery(Components[Index]).Post;
    end;
  end;
end;

procedure TRollaBlindGuideDataGUI.btnNewClick(Sender: TObject);
begin
  inherited;
  SaveData;
  CloseQueries;

  if MyConnection.InTransaction then
    CommitTransaction;

  Notify;
  BeginTransaction;
  DataState.Dirty := False;
  OpenQueries;
  qryMain.Insert;
end;

initialization
  RegisterClassOnce(TRollaBlindGuideDataGUI);

  with FormFact do
  begin
    RegisterMe(TRollaBlindGuideDataGUI, 'TRollaBlindGuideDataListGUI_*=GuideDataID');
  end;
finalization
  UnRegisterClass(TRollaBlindGuideDataGUI);
end.
