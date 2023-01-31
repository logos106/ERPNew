unit frmPCCAttendant;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, DNMSpeedButton, DNMPanel,
  MemDS, StdCtrls, wwdblook, wwdbedit, Mask, Wwdbspin, wwcheckbox, Shader;

type
  TPCCAttendant = class(TBaseInputGUI)
    Bevel1: TBevel;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryAttendants: TMyQuery;
    qryAttendantsPCCAttendantID: TIntegerField;
    qryAttendantsAttendantID: TWordField;
    qryAttendantsPassword: TIntegerField;
    qryAttendantsEmployeeID: TIntegerField;
    dsAttendant: TDataSource;
    qryAttendantsDescription: TStringField;
    edtDescription: TwwDBEdit;
    cboEmployee: TwwDBLookupCombo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    qryEmployee: TMyQuery;
    qryEmployeeEmployeeName: TStringField;
    qryEmployeeEmployeeID: TIntegerField;
    edtPassword: TwwDBEdit;
    edtAttendant: TwwDBEdit;
    cbActive: TwwCheckBox;
    Label5: TLabel;
    qryAttendantsActive: TStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PCCAttendant: TPCCAttendant;

implementation

uses FastFuncs,FormFactory, CommonLib;

{$R *.dfm}

procedure TPCCAttendant.FormShow(Sender: TObject);
begin
  inherited;
  qryAttendants.ParamByName('PCCAttendantID').AsInteger := KeyID;
  OpenQueries;
  if KeyID = 0 then begin
    qryAttendants.Insert;
  end
  else begin
    qryAttendants.Edit;
  end;
end;

procedure TPCCAttendant.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TPCCAttendant.btnOKClick(Sender: TObject);
begin
  inherited;
  try
    qryAttendants.Post;
  except
    on E: exception do begin
      if FastFuncs.PosEx('DUPLICATE ENTRY',FastFuncs.UpperCase(E.Message))>0 then CommonLib.MessageDlgXP_Vista('Attendant with this number already exists!', mtError, [mbOK], 0);
      Exit;
    end;
  end;
  Notify;
  inherited;
  Close;
end;

procedure TPCCAttendant.btnCancelClick(Sender: TObject);
begin
  inherited;
  qryAttendants.Cancel;
  Close;
end;

initialization
  RegisterClassOnce(TPCCAttendant);
  FormFact.RegisterMe(TPCCAttendant, 'TPCCAttendantList_*=PCCAttendantID');

end.
