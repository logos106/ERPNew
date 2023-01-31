unit frmTermsFrm;

{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 31/08/05  1.00.01 IJB  Fixed Access Violation on Cancel, moved notify to before
                        self.close.
 1/11/05   1.00.02 DLS  Added RegisterClass
                        }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, StdCtrls, Mask, DBCtrls, ExtCtrls,  
  BaseInputForm, DNMPanel, kbmMemTable, wwcheckbox, Buttons, DNMSpeedButton,
  MemDS, DBAccess, MyAccess,ERPdbComponents, Shader, Menus, AdvMenus, DataState,
  SelectionDialog, AppEvnts, ImgList, ProgressDialog;

type
  TfrmTermsfm = class(TBaseInputGUI)
    frmTermsSrc: TDataSource;
    txtName: TDBEdit;
    Name_Label: TLabel;
    txtDays: TDBEdit;
    Label13: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    txtEOMDays: TDBEdit;
    Label19: TLabel;
    Label21: TLabel;
    Label11: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    txtDescription: TDBEdit;
    Label27: TLabel;
    Bevel1: TBevel;
    qryTerms: TERPQuery;
    memQryTerms: TkbmMemTable;
    cmdOk: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    chkEOM: TwwCheckBox;
    chkEOMPlus: TwwCheckBox;
    chkActive: TwwCheckBox;
    qryTermsActive: TWideStringField;
    qryTermsDescription: TWideStringField;
    qryTermsEOM: TWideStringField;
    qryTermsEOMPlus: TWideStringField;
    qryTermsEditedFlag: TWideStringField;
    qryTermsTerms: TWideStringField;
    qryTermsTermsAmount: TSmallintField;
    qryTermsTermsID: TAutoIncField;
    qryTermsRequired: TWideStringField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Bevel2: TBevel;
    qryTermsEarlyPaymentDiscount: TFloatField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryTermsGlobalRef: TWideStringField;
    procedure chkEOMClick(Sender: TObject);
    procedure chkEOMPlusClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdOkClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qryTermsAfterOpen(DataSet: TDataSet);
    procedure chkActiveClick(Sender: TObject);
    procedure qryTermsAfterPost(DataSet: TDataSet);
  private
    function ValidateData: boolean;
  public
    TID: integer;              
    
  end;

implementation

uses DNMLib, FormFactory, DNMExceptions,
  CommonLib, AppEnvironment;

{$R *.DFM}


procedure TfrmTermsfm.chkEOMClick(Sender: TObject);
begin
  if not qryTerms.Active then exit;
  if not chkEOMPlus.Enabled then begin
    EditDB(qryTerms);
    qryTerms.FieldByName('EOMPlus').AsBoolean := false;
    PostDB(qryTerms);
    EditDB(qryTerms);
  end;
  chkEOMPlus.Enabled := chkEOM.Checked;
  txtEOMDays.Enabled := chkEOM.Checked;
  Application.ProcessMessages;
end;

procedure TfrmTermsfm.chkEOMPlusClick(Sender: TObject);
begin
  txtEOMDays.Enabled := chkEOMPlus.Checked;
  txtDays.Enabled := not (chkEOMPlus.Checked);
  Application.ProcessMessages;
end;

procedure TfrmTermsfm.cmdCancelClick(Sender: TObject);
begin
  Notify(true);
  Self.Close;
end;

procedure TfrmTermsfm.cmdOkClick(Sender: TObject);
begin
  try
    chkEOMClick(nil);
    if ValidateData then begin
      qryTerms.Edit;
      ProcessEditedFlag('Main', Self, memqryTerms, qryTerms, nil);
      qryTerms.Edit;
      qryTerms.Post;
      qryTerms.Edit;
      KeyId := qryTermsTermsID.AsInteger;
      CommitTransaction;
      Notify(false);
      Self.Close;
    end;
  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

procedure TfrmTermsfm.cmdNewClick(Sender: TObject);
begin
  try
    if ValidateData then begin
      ProcessEditedFlag('Main', Self, memqryTerms, qryTerms, nil);
      qryTerms.Edit;
      qryTerms.Post;
      CommitTransaction;
      Notify;
      KeyID := 0;
      FormShow(nil);
      SetControlFocus(txtName);
    end;
  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

procedure TfrmTermsfm.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      if qryTerms.Active then begin
        CloseQueries;
      end;
      RollbackTransaction;

      BeginTransaction;
      qryTerms.ParamByName('TID').asInteger := KeyID;
      OpenQueries;
      if KeyID = 0 then begin
        qryTerms.Insert;
      end else begin
        qryTerms.Edit;
      end;

      chkActive.Enabled := (AccessLevel <> 2) and (AccessLevel <> 3);

      if qryTermsRequired.AsBoolean then begin
        chkActive.Enabled := false;
        Label11.Enabled := false;
        txtName.Enabled := false;
      end;


      chkEOMClick(nil);
      SetControlFocus(txtName);
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmTermsfm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  RollbackTransaction;
  CloseQueries;
  inherited;
  Action := caFree;
end;

procedure TfrmTermsfm.qryTermsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  txtName.ReadOnly := KeyId <>0;
  LoadEditedFlagMemTable(qryTerms, memqryTerms);
end;

procedure TfrmTermsfm.chkActiveClick(Sender: TObject);
begin
  inherited;
  chkEOMClick(Sender);
  editDB(qryTerms);
end;

function TfrmTermsfm.ValidateData: boolean;
begin
  result:= true;
  if Empty(txtName.Text) then begin
    result:= false;
    CommonLib.MessageDlgXP_Vista('Name cannot be blank.', mtWarning, [mbOK], 0);
    SetControlFocus(txtName);
    exit;
  end;
end;

procedure TfrmTermsfm.qryTermsAfterPost(DataSet: TDataSet);
begin
  inherited;
  if qryTermsGlobalRef.AsString = '' then begin
    EditDb(qryTerms);
    qryTermsGlobalRef.AsString:= AppEnv.Branch.SiteCode + qryTermsTermsID.AsString;
    PostDb(qryTerms);
  end;
end;

initialization
  RegisterClassOnce(TfrmTermsfm);
(*  FormFact.RegisterMe(TfrmTermsfm, 'TTermsListGUI_*=TermsID');
  FormFact.RegisterMe(TfrmTermsfm, 'TTermsListGUI_Terms=TermsID');
  FormFact.RegisterMe(TfrmTermsfm, 'TClientTypeListGUI_Terms=TermsID');
  FormFact.RegisterControl(TfrmTermsfm, '*_cboTerms=TermsID');
  FormFact.RegisterControl(TfrmTermsfm, '*_Terms=TermsID');*)
end.

