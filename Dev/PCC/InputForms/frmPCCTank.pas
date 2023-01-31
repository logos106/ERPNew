unit frmPCCTank;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, MemDS, StdCtrls, DNMPanel,
  DNMSpeedButton, wwdblook, wwdbedit, Mask, Wwdbspin, wwcheckbox, Shader;

type
  TPCCTank = class(TBaseInputGUI)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    qryTank: TMyQuery;
    dsTank: TDataSource;
    qryTankTankNo: TIntegerField;
    qryTankTankDescription: TStringField;
    qryTankGradeID: TIntegerField;
    qryTankProductID: TIntegerField;
    wwDBSpinEdit1: TwwDBSpinEdit;
    wwDBEdit1: TwwDBEdit;
    cboGrade: TwwDBLookupCombo;
    cboProduct: TwwDBLookupCombo;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryGrades: TMyQuery;
    qryProducts: TMyQuery;
    qryGradesGradeID: TIntegerField;
    qryGradesGradeName: TStringField;
    qryGradesGradeDesc: TStringField;
    qryProductsPartName: TStringField;
    qryProductsPartsID: TIntegerField;
    Bevel1: TBevel;
    cbActive: TwwCheckBox;
    Label5: TLabel;
    qryTankActive: TStringField;
    qryTankTankID: TIntegerField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure wwDBSpinEdit1AfterDownClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PCCTank: TPCCTank;

implementation

uses FastFuncs,FormFactory, CommonLib;

{$R *.dfm}

procedure TPCCTank.FormShow(Sender: TObject);
begin
  inherited;
  qryTank.ParamByName('TankID').AsInteger := KeyID;
  OpenQueries;
  if KeyID = 0 then begin
    qryTank.Insert;
  end
  else begin
    qryTank.Edit;
  end;
end;

procedure TPCCTank.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TPCCTank.btnOKClick(Sender: TObject);
begin
  try
    qryTank.Post;
  except
    on E: exception do begin
      if FastFuncs.PosEx('DUPL',FastFuncs.UpperCase(E.Message))>0 then CommonLib.MessageDlgXP_Vista('Tank with this number already exists!', mtError, [mbOK], 0);
      Exit;
    end;
  end;
  Notify;
  inherited;
  Close;
end;

procedure TPCCTank.btnCancelClick(Sender: TObject);
begin
  inherited;
  qryTank.Cancel;
  Close;
end;

procedure TPCCTank.wwDBSpinEdit1AfterDownClick(Sender: TObject);
begin
  inherited;
  If (TwwDBSpinEdit(Sender).Value < 0) then
    TwwDBSpinEdit(Sender).Value := 0;
end;

initialization
  RegisterClassOnce(TPCCTank);
  FormFact.RegisterMe(TPCCTank, 'TPCCTankList_*=TankID');

end.
