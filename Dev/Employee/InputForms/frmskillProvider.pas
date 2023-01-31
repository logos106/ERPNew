unit frmskillProvider;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  StdCtrls, Shader, DNMPanel, DNMSpeedButton, BusobjEmpskills, BusObjBase, Mask,
  DBCtrls, wwcheckbox, wwdblook, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  ProgressDialog;

type
  TfmskillProvider = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMSpeedButton1: TDNMSpeedButton;
    DNMSpeedButton2: TDNMSpeedButton;
    DNMSpeedButton3: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    dsSkillProvider: TDataSource;
    QrySkillProvider: TERPQuery;
    dsSkillProviderskills: TDataSource;
    QrySkillProviderskills: TERPQuery;
    QrySkillProviderglobalref: TWideStringField;
    QrySkillProviderskillProviderId: TIntegerField;
    QrySkillProviderSkillProviderName: TWideStringField;
    QrySkillProviderActive: TWideStringField;
    QrySkillProvidermsTimeStamp: TDateTimeField;
    QrySkillProviderskillsglobalref: TWideStringField;
    QrySkillProviderskillsID: TIntegerField;
    QrySkillProviderskillsProviderID: TIntegerField;
    QrySkillProviderskillsskillid: TIntegerField;
    QrySkillProviderskillsActive: TWideStringField;
    QrySkillProviderskillsmsTimeStamp: TDateTimeField;
    Label25: TLabel;
    edtProvider: TDBEdit;
    chkActive: TwwCheckBox;
    Label36: TLabel;
    wwDBGrid1: TwwDBGrid;
    wwIButton1: TwwIButton;
    QrySkillProviderskillsSkillname: TWideStringField;
    cboskills: TwwDBLookupCombo;
    qryskills: TERPQuery;
    qryskillsSkillID: TIntegerField;
    qryskillsSkill: TWideStringField;
    chkShowinative: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure DNMSpeedButton2Click(Sender: TObject);
    procedure DNMSpeedButton3Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cboskillsCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure wwIButton1Click(Sender: TObject);
    procedure wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure chkShowinativeClick(Sender: TObject);
    procedure wwDBGrid1Enter(Sender: TObject);
  private
    skillProviderObj :TSkillProvider;
    fLastcombo  : TwwDbLookupcombo;
    function Savechanges(confirm:boolean ):Boolean;
    Procedure doBusObjEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
  public
    procedure UpdateMe(const Cancelled: boolean; const aObject: TObject = nil); override;
  end;

implementation

uses CommonLib,  BusObjConst, FormFactory;

{$R *.dfm}
{ TfmskillProvider }

procedure TfmskillProvider.cboskillsCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  skillProviderObj.Skills.skillID := qryskillsSkillID.asInteger;
end;

procedure TfmskillProvider.chkShowinativeClick(Sender: TObject);
begin
  inherited;
  if chkShowinative.checked then
    skillProviderObj.skills.dataset.filter :=''
  else skillProviderObj.skills.dataset.filter := 'active = '+quotedstr('F');

  skillProviderObj.skills.dataset.filtered := skillProviderObj.skills.dataset.filter <> '';
end;

procedure TfmskillProvider.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  if Savechanges(False) then begin
    skillProviderObj.Dirty := false;
    skillProviderObj.connection.CommitTransaction;
    Self.close;
  end;

end;

procedure TfmskillProvider.DNMSpeedButton2Click(Sender: TObject);
begin
  inherited;
  if not Savechanges(true) then exit;
  skillProviderObj.Connection.CommitTransaction;
  skillProviderObj.Connection.BeginTransaction;

  skillProviderObj.New;
  skillProviderObj.postdb;
  skillProviderObj.skills;
  SetControlFocus(edtProvider);
end;

procedure TfmskillProvider.DNMSpeedButton3Click(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmskillProvider.doBusObjEvent(const Sender: TDatasetBusObj;
  const EventType, Value: string);
begin
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TSkillProvider then TSkillProvider(Sender).Dataset := QrySkillProvider
        else if Sender is TSkillProviderSkills then TSkillProviderSkills(Sender).Dataset := QrySkillProviderskills;
    end;

end;

procedure TfmskillProvider.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmskillProvider.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := Savechanges(true);
end;

procedure TfmskillProvider.FormCreate(Sender: TObject);
begin
  inherited;
  skillProviderObj :=TSkillProvider.create(Self);
  skillProviderObj.connection := TMyDacDataConnection.create(skillProviderObj);
  skillProviderObj.Connection.Connection := Self.MyConnection;
  skillProviderObj.BusObjEvent := doBusObjEvent;
end;

procedure TfmskillProvider.FormShow(Sender: TObject);
begin
  inherited;
  skillProviderObj.Load(KeyID);
  skillProviderObj.Connection.BeginTransaction;
  if KeyId =0 then begin
    skillProviderObj.New;
    skillProviderObj.postdb;
  end;
  skillProviderObj.skills;
  openqueries;
end;

function TfmskillProvider.Savechanges(confirm: boolean): Boolean;
begin
  REsult := False;
  if not skillProviderObj.dirty then Result := True
  else begin
    if not confirm then begin
      skillProviderObj.skills.postDB;
      skillProviderObj.PostDB;
      Result := skillProviderObj.Save;
      Notify(False);
    end else begin
      Case  MessageDlgXP_Vista('Do You wish To Save the Changes?',  mtconfirmation , [mbyes,mbno,mbcancel], 0)  of
        mryes: begin
            skillProviderObj.PostDB;
            skillProviderObj.skills.postDB;
            Result := skillProviderObj.Save;
            Notify(False);
        end;
        mrno:begin
            skillProviderObj.skills.Canceldb;
            skillProviderObj.canceldb;
            skillProviderObj.Connection.RollbackTransaction;
            Result:=true;
          end;
        mrcancel: begin
          Result:= False;
        end;
      End;
    end;
  end;

end;

procedure TfmskillProvider.UpdateMe(const Cancelled: boolean;
  const aObject: TObject);
begin
  inherited;
  if not Assigned(fLastcombo) then exit;

  if Cancelled then begin
    if (Sysutils.SameText(fLastcombo.Name, 'cboskills'))  then begin
      cboskills.Text := '';
      closedb(qryskills);
      opendb(qryskills);
    end;
  end
  else begin
    if Assigned(aObject) and (aObject is TBaseInputGUI) and (Sysutils.SameText(fLastcombo.Name, 'cboskills'))  then begin
      closedb(qryskills);
      opendb(qryskills);
      if qryskills.Locate('SkillID', TBaseInputGUI(aObject).KeyID, []) then begin
        skillProviderObj.skills.SkillId := qryskillsskillid.asinteger;
        fLastcombo.Text := self.qryskillsSkill.AsString;
      end;
    end;
  end;
end;

procedure TfmskillProvider.wwDBGrid1CalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if skillProviderObj.skills.Active = false then Afont.color := clInactiveCaption;
end;

procedure TfmskillProvider.wwDBGrid1Enter(Sender: TObject);
begin
  inherited;
  if skillProviderObj.SkillProviderName = '' then begin
    setcontrolfocus(edtProvider);
  end;
  fLastcombo := cboskills;
end;

procedure TfmskillProvider.wwIButton1Click(Sender: TObject);
begin
  inherited;
  skillProviderObj.skills.Active:= False;
  skillProviderObj.skills.PostDb;
end;

initialization
  RegisterClassOnce(TfmskillProvider);
  with FormFact do
  begin
    RegisterMe(TfmskillProvider, 'TSkillProviderGUI_*=skillProviderID');
    RegisterControl(TfmskillProvider, '*_cboskillprovider=skillProviderID');
  end;
end.
