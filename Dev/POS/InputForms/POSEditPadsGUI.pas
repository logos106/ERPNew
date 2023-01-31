unit POSEditPadsGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, StdCtrls, ExtCtrls, BaseInputForm,  DNMPanel, Grids,
  DBGrids, DB, Mask, DBCtrls, Buttons, DNMSpeedButton, kbmMemTable, ActnList, MemDS,
  DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, DataState, Menus, AdvMenus, Shader,
  ProgressDialog, ImgList;

type
  TPOSEditPadsPopUp = class(TBaseInputGUI)
    scKeypad: TDataSource;
    grdKeypad: TDBGrid;
    DNMPanel1: TDNMPanel;
    DBCheckBox1: TDBCheckBox;
    edtTitle: TDBEdit;
    Label2: TLabel;
    btnSave: TDNMSpeedButton;
    BitBtn2: TDNMSpeedButton;
    btnAssign: TDNMSpeedButton;
    ActionList1: TActionList;
    AssignButton: TAction;
    qryKeypad: TERPQuery;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AssignButtonUpdate(Sender: TObject);
    procedure AssignButtonExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    fbStartingUp: boolean;
    iKeypadID: integer;
  end;


implementation

{$R *.dfm}

uses Forms, CommonDbLib, POSChgPadGUI, CustomizePOSGUI, CommonLib;



procedure TPOSEditPadsPopUp.FormCreate(Sender: TObject);
begin
  fbStartingUp := true;
  inherited;
  qryKeypad.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryKeypad.Open;
end;


procedure TPOSEditPadsPopUp.btnSaveClick(Sender: TObject);
begin
  inherited;
  if qryKeypad.State <> dsBrowse then begin
    qryKeypad.Post;
  end;
end;

procedure TPOSEditPadsPopUp.FormShow(Sender: TObject);
begin
  inherited;
  fbStartingUp := false;
end;

procedure TPOSEditPadsPopUp.AssignButtonUpdate(Sender: TObject);
begin
  inherited;
  btnAssign.Enabled := DBCheckBox1.Checked;
end;

procedure TPOSEditPadsPopUp.AssignButtonExecute(Sender: TObject);
var CustomizePOSForm: TCustomizePOSForm;
begin
  inherited;
  with TPOSChgPadPopUp(GetComponentByClassName('TPOSChgPadPopUp')) do begin
    frmSender := Self;
    Position  := poScreenCenter;
    FormStyle := fsNormal;
    ShowModal;

    CustomizePOSForm:=TCustomizePOSForm(FindExistingComponent('TCustomizePOSForm'));
    if not CustomizePOSForm.LocateChangeButton(iKeypadID, qryKeypad.FieldByName('KeypadID').AsInteger) then begin
      CustomizePOSForm.CreateNewChangeButton(iKeypadID, qryKeypad.FieldByName('KeypadID').AsInteger,
        qryKeypad.FieldByName('Description').AsString);
    end;
//    if not CustomizePOSForm.LocateChangeButton(iKeypadID, qryKeypad.FieldByName('KeypadID').AsInteger) then begin
//      CustomizePOSForm.CreateNewChangeButton(iKeypadID, qryKeypad.FieldByName('KeypadID').AsInteger,
//        qryKeypad.FieldByName('Description').AsString);
//    end;
  end;
end;

Initialization
  RegisterClassOnce(TPOSEditPadsPopUp);

end.
