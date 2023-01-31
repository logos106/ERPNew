unit frmPoolProfileTestDefaults;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DataState, DBAccess, MyAccess, SelectionDialog,
  AppEvnts, DB,  ExtCtrls, DNMPanel, ActnList, StdCtrls, wwcheckbox,
  Buttons, DNMSpeedButton, wwdblook, Mask, wwdbedit, MemDS, Menus, AdvMenus, Shader;

type
  TfmPoolProfileTestDefaults = class(TBaseInputGUI)
    alMain: TActionList;
    actMainSave: TAction;
    actMainNew: TAction;
    actMainCancel: TAction;
    qryPoolTestDefault: TMyQuery;
    qryPoolTestDefaultDefaultTestID: TIntegerField;
    qryPoolTestDefaultTestCategoriesID: TIntegerField;
    qryPoolTestDefaultName: TStringField;
    qryPoolTestDefaultTargetValue: TFloatField;
    qryPoolTestDefaultMinimum: TFloatField;
    qryPoolTestDefaultMaximum: TFloatField;
    qryPoolTestDefaultDecreasePartNo: TStringField;
    qryPoolTestDefaultDecreaseDose: TFloatField;
    qryPoolTestDefaultDecreaseRslt: TFloatField;
    qryPoolTestDefaultIncreasePartNo: TStringField;
    qryPoolTestDefaultIncreaseDose: TFloatField;
    qryPoolTestDefaultIncreaseRslt: TFloatField;
    QryIncreaseParts: TMyQuery;
    qryDecreaseParts: TMyQuery;
    qryDecreasePartsPartsID: TIntegerField;
    qryDecreasePartsPartName: TStringField;
    QryIncreasePartsPartsID: TIntegerField;
    QryIncreasePartsPartName: TStringField;
    dsPoolTestDefault: TDataSource;
    qryPoolTestDefaultDecreasePartID: TIntegerField;
    qryPoolTestDefaultIncreasePartID: TIntegerField;
    edtName: TEdit;
    edtSubstance: TEdit;
    lblSubstance: TLabel;
    lblType: TLabel;
    lblTemperature: TLabel;
    edtTargetValue: TwwDBEdit;
    Label2: TLabel;
    edtMinRange: TwwDBEdit;
    Label3: TLabel;
    edtMaxRange: TwwDBEdit;
    Label6: TLabel;
    Bevel1: TBevel;
    Label7: TLabel;
    Label11: TLabel;
    Label8: TLabel;
    lblAlgaeType: TLabel;
    cboDecreasePartNo: TwwDBLookupCombo;
    cboIncreasePartNo: TwwDBLookupCombo;
    edtIncreaseDose: TwwDBEdit;
    edtDecreaseDose: TwwDBEdit;
    Label9: TLabel;
    Label10: TLabel;
    edtDecreaseResult: TwwDBEdit;
    edtIncreaseResult: TwwDBEdit;
    Bevel2: TBevel;
    DNMPanel1: TDNMPanel;
    Button1: TDNMSpeedButton;
    BitBtn2: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure actMainSaveExecute(Sender: TObject);
    procedure actMainNewExecute(Sender: TObject);
    procedure actMainCancelExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    function SaveData: boolean;
    function ValidateFormData: boolean;
  public
    
    { Public declarations }
  end;

//var
//  fmPoolProfileTestDefaults: TfmPoolProfileTestDefaults;

implementation

uses FastFuncs,CommonLib;

{$R *.dfm}

function TfmPoolProfileTestDefaults.ValidateFormData: boolean;
begin
  Result := false;
  if FastFuncs.Trim(edtTargetValue.Text) = '' then begin
    CommonLib.MessageDlgXP_Vista('Target value cannot be blank.', mtError, [mbOK], 0);
    SetControlFocus(edtTargetValue);
    Exit;
  end;
  if FastFuncs.Trim(edtMinRange.Text) = '' then begin
    CommonLib.MessageDlgXP_Vista('Minimum Range Value  cannot be blank.', mtError, [mbOK], 0);
    SetControlFocus(edtMinRange);
    Exit;
  end;
  if FastFuncs.Trim(edtMaxRange.Text) = '' then begin
    CommonLib.MessageDlgXP_Vista('Maximum Range Value  cannot be blank.', mtError, [mbOK], 0);
    SetControlFocus(edtMaxRange);
    Exit;
  end;
  Result := true;
end;

function TfmPoolProfileTestDefaults.SaveData: boolean;
begin
  Result := true;
  if not (qryPoolTestDefault.State in [dsinsert, dsEdit]) then Exit;

  Result := false;
  if qryPoolTestDefault.State in [dsinsert, dsEdit] then if ValidateFormData then begin
      with qryPoolTestDefault do begin
        Post;
        KeyId := qryPoolTestDefault.FieldByName('DefaultTestId').AsInteger;
      end;
    end else Exit;
  Result := true;
end;


procedure TfmPoolProfileTestDefaults.FormCreate(Sender: TObject);
begin
  Self.fbIgnoreAccessLevels := true;
  inherited;
  // If user does not have access to this form so don't process any further
  if ErrorOccurred then Exit;
end;

procedure TfmPoolProfileTestDefaults.actMainSaveExecute(Sender: TObject);
begin
  inherited;
  if qryPoolTestDefault.State in [dsEdit, dsInsert] then begin
    if not SaveData then Exit;
    CommitTransaction;
    Notify;
    DataState.Dirty := false;
  end;
  Self.Close;
end;

procedure TfmPoolProfileTestDefaults.actMainNewExecute(Sender: TObject);
begin
  inherited;
  // not possible to create new records at the moment, so the button is disables 
end;

procedure TfmPoolProfileTestDefaults.actMainCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmPoolProfileTestDefaults.FormShow(Sender: TObject);
begin
  inherited;
  with QryIncreaseParts do if Active = false then Open;
  with qryDecreaseParts do if Active = false then Open;
  with qryPoolTestDefault do begin
    if Active then Close;
    ParamByname('DefaultTestID').AsInteger := KeyId;
    Open;
    if RecordCount = 0 then begin
      Insert;
    end;
    DataState.Activate;
  end;
  Caption := TitleLabel.Caption;
end;

procedure TfmPoolProfileTestDefaults.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
  if ErrorOccurred then Exit;

  CanClose := false;
  if DataState.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes: 
        begin
          if SaveData then begin
            CommitTransaction;
            Notify;
            CanClose := true;
          end;
        end;
      mrNo: 
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          CanClose := true;
        end;
      mrCancel: 
        begin
          CanClose := false;
        end;
    end;
  end else begin
    CanClose := true;
  end;
  CanClose := true;
end;

procedure TfmPoolProfileTestDefaults.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  RollbackTransaction;
  Action := caFree;
  CloseQueries;
end;

initialization
  RegisterClassOnce(TfmPoolProfileTestDefaults);

end.
