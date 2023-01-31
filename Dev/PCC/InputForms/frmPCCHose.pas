unit frmPCCHose;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, wwdblook, StdCtrls, Mask,
  wwdbedit, Wwdbspin, MemDS, DNMSpeedButton, DNMPanel, wwcheckbox, Shader;

type
  TPCCHose = class(TBaseInputGUI)
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    qryHoses: TMyQuery;
    qryTanks: TMyQuery;
    wwDBSpinEdit1: TwwDBSpinEdit;
    wwDBSpinEdit2: TwwDBSpinEdit;
    wwDBLookupCombo1: TwwDBLookupCombo;
    dsHoses: TDataSource;
    Bevel1: TBevel;
    cbActive: TwwCheckBox;
    Label4: TLabel;
    qryHosesHoseID: TIntegerField;
    qryHosesHoseNo: TIntegerField;
    qryHosesDispenserNo: TIntegerField;
    qryHosesTankID: TIntegerField;
    qryHosesGlobalRef: TStringField;
    qryHosesActive: TStringField;
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
  PCCHose: TPCCHose;

implementation

uses FastFuncs,FormFactory, CommonLib;

{$R *.dfm}

procedure TPCCHose.FormShow(Sender: TObject);
begin
  inherited;
  qryHoses.ParamByName('HoseID').AsInteger := KeyID;
  OpenQueries;
  if KeyID = 0 then begin
    qryHoses.Insert;
  end
  else begin
    qryHoses.Edit;
  end;
end;

procedure TPCCHose.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TPCCHose.btnOKClick(Sender: TObject);
begin
  try
    qryHoses.Post;
  except
    on E: exception do begin
      if FastFuncs.PosEx('DUPL',FastFuncs.UpperCase(E.Message))>0 then CommonLib.MessageDlgXP_Vista('Hose already exists for this dispenser!', mtError, [mbOK], 0);
      Exit;
    end;
  end;
  Notify;
  inherited;
  Close;
end;

procedure TPCCHose.btnCancelClick(Sender: TObject);
begin
  inherited;
  qryHoses.Cancel;
  Close;
end;

procedure TPCCHose.wwDBSpinEdit1AfterDownClick(Sender: TObject);
begin
  inherited;
  If (TwwDBSpinEdit(Sender).Value < 0) then
    TwwDBSpinEdit(Sender).Value := 0;
end;

initialization
  RegisterClassOnce(TPCCHose);
  FormFact.RegisterMe(TPCCHose, 'TPCCHoseList_*=HoseID');

end.
