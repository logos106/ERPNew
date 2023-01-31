unit frmPCCGrade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, DNMSpeedButton, DNMPanel,
  StdCtrls, Mask, wwdbedit, MemDS, Wwdbspin, wwcheckbox, Shader;

type
  TPCCGradeForm = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    edtGradeName: TwwDBEdit;
    edtDesc: TwwDBEdit;
    qryGrade: TMyQuery;
    qryGradeGradeDesc: TStringField;
    dsGrade: TDataSource;
    qryGradeGradeName: TStringField;
    Label3: TLabel;
    wwDBSpinEdit1: TwwDBSpinEdit;
    qryGradeGradeNo: TIntegerField;
    Bevel1: TBevel;
    cbActive: TwwCheckBox;
    Label4: TLabel;
    qryGradeGradeID: TIntegerField;
    qryGradeActive: TStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure wwDBSpinEdit1AfterDownClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PCCGradeForm: TPCCGradeForm;

implementation

uses FastFuncs,CommonLib, FormFactory;

{$R *.dfm}

procedure TPCCGradeForm.FormShow(Sender: TObject);
begin
  inherited;
  qryGrade.ParamByName('GradeID').AsInteger := KeyID;
  OpenQueries;
  if KeyID = 0 then begin
    qryGrade.Insert;
  end
  else begin
    qryGrade.Edit;
  end;
end;

procedure TPCCGradeForm.btnOKClick(Sender: TObject);
begin
  if edtGradeName.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('Grade Name must not be blank!', mtInformation, [mbOK], 0);
    SetControlFocus(edtGradeName);
    Exit;
  end;
  try
    qryGrade.Post;
  except
    on E: exception do begin
      if FastFuncs.PosEx('DUPL',FastFuncs.UpperCase(E.Message))>0 then CommonLib.MessageDlgXP_Vista('Grade with this number already exists!', mtError, [mbOK], 0);
      Exit;
    end;
  end;
  Notify;
  inherited;
  Close;
end;

procedure TPCCGradeForm.btnCancelClick(Sender: TObject);
begin
  inherited;
  qryGrade.Cancel;
  Close;
end;

procedure TPCCGradeForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TPCCGradeForm.wwDBSpinEdit1AfterDownClick(Sender: TObject);
begin
  inherited;
  If (TwwDBSpinEdit(Sender).Value < 0) then
    TwwDBSpinEdit(Sender).Value := 0;
end;

initialization
  RegisterClassOnce(TPCCGradeForm);
  FormFact.RegisterMe(TPCCGradeForm, 'TPCCGradeList_*=GradeID');
end.
