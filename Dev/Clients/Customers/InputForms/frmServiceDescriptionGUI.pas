unit frmServiceDescriptionGUI;
{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 19/12/05  1.00.02  AL   Removed "Instance", added RegisterClass  *Task306*
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, StdCtrls, ExtCtrls, DNMPanel, DBAccess, MyAccess,ERPdbComponents,
  SelectionDialog, AppEvnts, DB,  Buttons, DNMSpeedButton, DNMLib, DataState, Menus, AdvMenus,
  Shader, MemDS, ImgList;

type
  TfrmServiceDescription = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    edtDescription: TEdit;
    Label2: TLabel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);

  private
    { Private declarations }
    oTASDescription: PASDescription;

  public
    { Public declarations }
    property ReturnResult: PASDescription read oTASDescription write oTASDescription;

  end;

implementation

uses
  DNMExceptions, CommonLib;

{$R *.dfm}

procedure TfrmServiceDescription.FormCreate(Sender: TObject);
begin
  Self.fbIgnoreAccessLevels := true;
  inherited;
end;

procedure TfrmServiceDescription.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;

      // Our exception handler.
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;

      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmServiceDescription.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmServiceDescription.btnSaveClick(Sender: TObject);
begin
  inherited;
  if Empty(edtDescription.Text) then begin
    CommonLib.MessageDlgXP_Vista('Auto Service Cycles must have a valid description - Please specify and try again!', mtWarning, [mbOK], 0);
    Exit;
  end;
  
  if Self.FormState = [fsModal] then begin
    ReturnResult^.Result := edtDescription.Text;
    ModalResult          := mrOk;
  end else begin
    ReturnResult^.Result := '';
    Close;
  end;
end;

procedure TfrmServiceDescription.btnCancelClick(Sender: TObject);
begin
  inherited;
  if Self.FormState = [fsModal] then begin
    ReturnResult^.Result := '';
    ModalResult          := mrCancel;
  end else begin
    ReturnResult^.Result := '';
    Close;
  end;
end;

Initialization
  RegisterClassOnce(TfrmServiceDescription);

end.
