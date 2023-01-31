unit frmEmailReferenceTask;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ExtCtrls, StdCtrls, DNMSpeedButton, wwdblook,
  Shader, DNMPanel , tcTypes; //, BusObjCorrespondence;

type

  TfmEmailReferenceTask = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryReferenceLookup: TERPQuery;
    cboCorrespondencetype: TwwDBLookupCombo;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cboCorrespondencetypeNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure qryReferenceLookupBeforeOpen(DataSet: TDataSet);
    procedure btnNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fOwnerConnection: TERPConnection;
    function GetOwnerConnection: TERPConnection;
    function GetEmailTemplate: string;
  Protected
    fEmailTemplate : string;
    function AddNew(const aRef : string) : boolean;
  public
    property OwnerConnection: TERPConnection read GetOwnerConnection write fOwnerConnection;
    property EmailTemplate : string read GetEmailTemplate;
  end;


implementation

uses frmCorrespondenceReference, CommonLib, frmEmailCorrespondenceReference,
  DNMLib,
  BusObjBase, AppEnvironment, tcDataUtils, CommonDbLib,
  Preferences, remainClientFrm, FastFuncs , strUtils, tcConst,
  CorrespondenceObj;


{$R *.dfm}

{ TfmCorrespondanceBase }

procedure TfmEmailReferenceTask.qryReferenceLookupBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  if Assigned(OwnerConnection) then
    qryReferenceLookup.Connection := OwnerConnection;
end;


function TfmEmailReferenceTask.AddNew(const aRef: string) : boolean;
var
  form: TfmCorrespondenceReference;
begin
  Result := false;
  form := TfmEmailCorrespondenceReference.Create(nil);
  try
//      if CorrespondenceType = tcTypes.ctEmail then
    form.KeyID := 0;
    form.NewReference := aRef;
    if form.ShowModal = mrOk then begin
      qryReferenceLookup.Refresh;
      qryReferenceLookup.Locate('Reference',form.qryMainReference.AsString,[loCaseInsensitive]);
      cboCorrespondenceType.Text := form.qryMainReference.AsString;
      Result := true;
    end;
  finally
    form.Free;
  end;
end;

procedure TfmEmailReferenceTask.btnCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfmEmailReferenceTask.btnNewClick(Sender: TObject);
begin
  AddNew('');
end;

procedure TfmEmailReferenceTask.btnSaveClick(Sender: TObject);
begin
  inherited;
  if Trim(cboCorrespondencetype.Text) = '' then begin
    CommonLib.MessageDlgXP_Vista('You must enter a Reference', mtCustom, [mbOK], 0);
    SetControlFocus(cboCorrespondencetype);
    Exit;
  end else if not IsValidFileName(cboCorrespondencetype.Text) then begin
    CommonLib.MessageDlgXP_Vista('Reference you entered is invalid. It cannot contain characters like \ / : * ? " < > |.',
      mtInformation, [mbOK], 0);
    SetControlFocus(cboCorrespondencetype);
    Exit;
  end;
  fEmailTemplate := qryReferenceLookup.FieldByName('CorrespondenceText').AsString;
  ModalResult := mrOk;
//  self.Notify(false);
//  self.Notify;
//  Close;
end;

procedure TfmEmailReferenceTask.cboCorrespondencetypeNotInList(Sender: TObject;  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
  Accept:= false;
  if CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    Accept := AddNew(NewValue);
  end;
end;

procedure TfmEmailReferenceTask.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmEmailReferenceTask.FormCreate(Sender: TObject);
begin
  inherited;
  fOwnerConnection := nil;
end;

procedure TfmEmailReferenceTask.FormShow(Sender: TObject);
begin
  inherited;
  CloseDb(qryReferenceLookup);
  qryReferenceLookup.SQL.Text := 'select * from tblCorrespondenceReference where TypeCode = "Email" order by Reference';
  OpenDb(qryReferenceLookup);
end;

function TfmEmailReferenceTask.GetEmailTemplate: string;
begin
  Result := fEmailTemplate;
end;

function TfmEmailReferenceTask.GetOwnerConnection: TERPConnection;
begin
  result := fOwnerConnection;
  if result  = nil then
   result := self.MyConnection;
end;

end.

