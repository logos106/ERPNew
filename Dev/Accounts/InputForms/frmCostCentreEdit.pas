unit frmCostCentreEdit;
{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 ??/??/?? 1.00.01  ???  Initial Version
 19/12/05 1.00.02  AL   Removed "Instance", added RegisterClass  *Task306*
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DBAccess, MyAccess, SelectionDialog, AppEvnts,
  DB,  MemDS, StdCtrls, wwcheckbox, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel,
  Mask, DBCtrls, DataState, Menus, AdvMenus, Shader;

type
  TfmCostCentreEdit = class(TBaseInputGUI)
    qryCostCentre: TMyQuery;
    pnlBottom: TDNMPanel;
    Label50: TLabel;
    btnSave: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    dsCostCentre: TDataSource;
    Label1: TLabel;
    edtCostCentreName: TDBEdit;
    Label2: TLabel;
    edtCostCentreDescription: TDBEdit;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
    function SaveData: boolean;
  public
    { Public declarations }
    
  end;

implementation

{$R *.dfm}

uses
  DNMExceptions, DNMLib, FormFactory, CommonLib;

procedure TfmCostCentreEdit.FormCreate(Sender: TObject);
begin
  Self.fbIgnoreAccessLevels := true;
  inherited;
end;

procedure TfmCostCentreEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if (qryCostCentre.State in [dsInsert, dsEdit]) then qryCostCentre.Cancel;
  RollbackTransaction;
  Action := caFree;
end;

procedure TfmCostCentreEdit.FormShow(Sender: TObject);
begin
  try
    inherited;

    // Roll back any existing transaction
    RollbackTransaction;

    qryCostCentre.Close;

    // set isolation level so that new records added outside this transaction
    // (eg part records) will be visible


    //cmd.SQL.Text:= 'SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED';
    //cmd.Execute;

    // Put our Database Connection into transaction mode.
    BeginTransaction;

    qryCostCentre.ParamByName('CostCentreId').AsInteger := KeyId;
    qryCostCentre.Open;

    if qryCostCentre.RecordCount > 0 then qryCostCentre.Edit
    else qryCostCentre.Insert;

    DataState.Activate;

    // Exception Handler
  except
    // Handle these known exceptions.
    on EAbort do HandleEAbortException;
    on e: ENoAccess do HandleNoAccessException(e);
    else raise;
  end;
end;

function TfmCostCentreEdit.SaveData: boolean;
begin
  Result := false;
  // validate form data
  if edtCostCentreName.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('Cost Centre Name cannot be blank.', mtError, [mbOK], 0);
    Exit;
  end;

  if (qryCostCentre.State in [dsInsert, dsEdit]) then begin
    if (qryCostCentre.State in [dsInsert]) then begin
      qryCostCentre.Post;
      KeyId := GetLastRecordPostID('tblCostCentre', MyConnection);
      Result := true;
    end else begin
      qryCostCentre.Post;
      Result := true;
    end;
  end;
end;


procedure TfmCostCentreEdit.btnSaveClick(Sender: TObject);
begin
  inherited;
  if not SaveData then Exit;
  CommitTransaction;
  Notify;
  Close;
end;

procedure TfmCostCentreEdit.btnNewClick(Sender: TObject);
begin
  inherited;
  if DataState.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes: 
        begin
          if not SaveData then Exit;
        end;
      mrNo: 
        begin
          if (qryCostCentre.State in [dsInsert, dsEdit]) then qryCostCentre.Cancel;
        end;
      mrCancel: 
        begin
          Exit;
        end;
    end;
  end;

  edtCostCentreName.Text := '';
  edtCostCentreDescription.Text := '';
  KeyID := 0;
  FormShow(nil);
  DataState.Dirty := false;
end;

procedure TfmCostCentreEdit.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

initialization
  RegisterClassOnce(TfmCostCentreEdit);
  with FormFact do begin
    // register all columns on course list form to open this form on DblClick
    RegisterMe(TfmCostCentreEdit, 'TfmCostCentreList_*=CostCentreId');
  end;
end.
