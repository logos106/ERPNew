unit frmskills;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  StdCtrls, Shader, DNMPanel, DNMSpeedButton, wwcheckbox, Mask, DBCtrls, BusobjEmpskills, BusObjBase,
  ProgressDialog;

type
  Tfmskills = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    Label25: TLabel;
    edtskillname: TDBEdit;
    QrySkills: TERPQuery;
    dsSkills: TDataSource;
    QrySkillsGlobalRef: TWideStringField;
    QrySkillsSkillID: TIntegerField;
    QrySkillsSkill: TWideStringField;
    QrySkillsEditedFlag: TWideStringField;
    QrySkillsActive: TWideStringField;
    QrySkillsmsTimeStamp: TDateTimeField;
    Label36: TLabel;
    chkActive: TwwCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    skillObj :TSkills;
    function Savechanges(confirm:boolean ):Boolean;
  Protected
    Procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);override;
  public

  end;


implementation

uses CommonLib, BusObjConst, FormFactory;

{$R *.dfm}
procedure Tfmskills.btnSaveClick(Sender: TObject);
begin
  inherited;
  if Savechanges(False) then begin
    skillObj.Dirty := false;
    skillObj.connection.CommitTransaction;
    Notify(False);
    Self.close;
  end;

end;

procedure Tfmskills.btnNewClick(Sender: TObject);
begin
  inherited;
  if not Savechanges(true) then exit;
  skillObj.Connection.CommitTransaction;
  skillObj.Connection.BeginTransaction;
  skillObj.New;
  SetControlFocus(edtskillname);
end;

procedure Tfmskills.btnCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure Tfmskills.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType,Value: string);
begin
    inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TSkills then TSkills(Sender).Dataset := QrySkills;
    end;
end;
procedure Tfmskills.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure Tfmskills.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := Savechanges(true);
end;

procedure Tfmskills.FormCreate(Sender: TObject);
begin
  inherited;
  skillObj :=TSkills.create(Self);
  skillObj.connection := TMyDacDataConnection.create(skillObj);
  skillObj.Connection.Connection := Self.MyConnection;
  skillObj.BusObjEvent := DoBusinessObjectEvent;
end;

procedure Tfmskills.FormShow(Sender: TObject);
begin
  inherited;
  skillObj.Load(KeyID);
  skillObj.Connection.BeginTransaction;
  if KeyId =0 then skillObj.New;
end;

function Tfmskills.Savechanges(confirm: boolean): Boolean;
begin
  REsult := False;
  if not skillObj.dirty then Result := True
  else begin
    if not confirm then begin
      skillObj.PostDB;
      Result := skillObj.Save;
    end else begin
      Case  MessageDlgXP_Vista('Do You wish To Save the Changes?',  mtconfirmation , [mbyes,mbno,mbcancel], 0) of
        mryes: begin
            skillObj.PostDB;
            Result := skillObj.Save;
        end;
        mrno:begin
            skillObj.canceldb;
            skillObj.Connection.RollbackTransaction;
            Result:=true;
          end;
        mrcancel: begin
          Result:= False;
        end;
      End;
    end;
  end;
  KeyID := skillObj.ID;
end;

initialization
  RegisterClassOnce(Tfmskills);
  with FormFact do
  begin
    RegisterMe(Tfmskills, 'TSkillsGUI_*=skillID');
    RegisterControl(Tfmskills, '*_cboskills=Skillid');
  end;
end.
