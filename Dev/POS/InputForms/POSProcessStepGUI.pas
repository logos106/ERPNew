unit POSProcessStepGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts,
  DB,  StdCtrls, Grids, Wwdbigrd, Wwdbgrid, Buttons, DNMSpeedButton, MemDS, ExtCtrls,
  DNMPanel, DataState, Menus, AdvMenus, Shader, ImgList;

type
  TPOSProcessStepFrm = class(TBaseInputGUI)
    tblProcessStep: TMyTable;
    dsProcessStep: TDataSource;
    pnlLeft: TDNMPanel;
    pnlBottom: TDNMPanel;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlTop: TDNMPanel;
    grdSteps: TwwDBGrid;
    DNMPanel1: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    tblProcessStepDescription: TWideStringField;
    tblProcessStepActive: TWideStringField;
    tblProcessStepGlobalRef: TWideStringField;
    tblProcessStepID: TIntegerField;
    tblProcessStepProcessTime: TDateTimeField;
    tblProcessStepmsTimeStamp: TDateTimeField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure tblProcessStepAfterInsert(DataSet: TDataSet);
    procedure tblProcessStepBeforePost(DataSet: TDataSet);
    procedure tblProcessStepActiveSetText(Sender: TField;
      const Text: String);
  private
  public
  end;

implementation

{$R *.dfm}

uses
  DnMExceptions, CommonLib;

procedure TPOSProcessStepFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if (tblProcessStep.State = dsInsert) or (tblProcessStep.State = dsEdit) then
    tblProcessStep.Cancel;


  self.RollbackTransaction;

  if not (fsModal in FormState) then
    Action := caFree;
end;

procedure TPOSProcessStepFrm.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      // Set a non zero KeyID so BaseInputForm does not throw an exception
      // if access is read only
      Self.KeyID := 1;
      inherited;

      // set controlls based on access level
      if Self.AccessLevel >= 5 then begin
        grdSteps.Options := grdSteps.Options - [dgEditing];
      end;

      BeginTransaction;

      tblProcessStep.Open;


      // Exception handler.
    except
      on EABort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TPOSProcessStepFrm.btnOKClick(Sender: TObject);
begin
  inherited;
  if (tblProcessStep.State = dsInsert) or (tblProcessStep.State = dsEdit) then begin
    if tblProcessStep.FieldByName('Description').AsString <> '' then
      tblProcessStep.Post
    else
      tblProcessStep.Cancel;
  end;
  self.CommitTransaction;
  Close;
end;

procedure TPOSProcessStepFrm.btnCancelClick(Sender: TObject);
begin
  inherited;
  if tblProcessStep.State in [dsEdit, dsInsert] then tblProcessStep.Cancel;
  Close;
end;

procedure TPOSProcessStepFrm.tblProcessStepAfterInsert(DataSet: TDataSet);
begin
  inherited;
  Dataset.FieldByName('Active').AsBoolean:= true;
end;

procedure TPOSProcessStepFrm.tblProcessStepBeforePost(DataSet: TDataSet);
begin
  inherited;
  if Dataset.FieldByName('description').AsString = '' then begin
    commonLib.MessageDlgXP_Vista('Please enter a description for this process step.',mtInformation,[mbOk],0);
    Abort;
  end;
end;

procedure TPOSProcessStepFrm.tblProcessStepActiveSetText(Sender: TField;
  const Text: String);
begin
  inherited;
  if (Text = 'F') and (tblProcessStepDescription.AsString = 'Assembly') then begin
    commonLib.MessageDlgXP_Vista('The "Assembly" process step is required by the system and can not be made inactive.',mtInformation,[mbOk],0);
  end
  else begin
    Sender.AsString:= Text;
  end;
end;

initialization
  RegisterClassOnce(TPOSProcessStepFrm);
end.
