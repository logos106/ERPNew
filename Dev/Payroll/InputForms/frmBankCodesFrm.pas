unit frmBankCodesFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, AppEvnts, DB,  ExtCtrls, DNMPanel, wwdblook,
  Wwdotdot, Wwdbcomb, StdCtrls, DBCtrls, Mask, wwdbedit, Buttons, DNMSpeedButton, kbmMemTable,
  SelectionDialog, wwcheckbox, DBAccess, MyAccess,ERPdbComponents, DataState, Menus, AdvMenus, MemDS,
  Shader, ImgList, ProgressDialog;

type
  TfrmBankCodes = class(TBaseInputGUI)
    qryBankCode: TERPQuery;
    DSBankCode: TDataSource;
    wwDBEdit1: TwwDBEdit;
    Label1: TLabel;
    BitBtn1: TDNMSpeedButton;
    BitBtn2: TDNMSpeedButton;
    Label2: TLabel;
    txtBankcode: TwwDBEdit;
    btnNew: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    Label3: TLabel;
    Bevel1: TBevel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label4: TLabel;
    wwDBEdit2: TwwDBEdit;
    lblCountry: TLabel;
    cbocountry: TwwDBLookupCombo;
    qryRegions: TERPQuery;
    qryRegionsregionId: TIntegerField;
    qryRegionsRegion: TWideStringField;
    qryBankCodeCodeID: TIntegerField;
    qryBankCodeBankCode: TWideStringField;
    qryBankCodeBankName: TWideStringField;
    qryBankCodeActive: TWideStringField;
    qryBankCodebankNumber: TWideStringField;
    qryBankCodeREgionID: TIntegerField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure cbocountryCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    
  end;

implementation

uses FormFactory, DnMExceptions, CommonLib, AppEnvironment;

{$R *.dfm}

procedure TfrmBankCodes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Closequeries;
  Action := caFree;
end;

procedure TfrmBankCodes.BitBtn2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmBankCodes.BitBtn1Click(Sender: TObject);
begin
  inherited;
  if Empty(txtBankcode.Text) then begin
    CommonLib.MessageDlgXP_Vista('No Bank Code !', mtWarning, [mbOK], 0);
    exit;
  end;

  if  qryBankCodeREgionId.AsInteger =0 then begin
    CommonLib.MessageDlgXP_Vista('Region is blank ', mtWarning, [mbOK], 0);
    exit;
  end;
  PostDB(qryBankCode);
  Notify;
  Close;
end;

procedure TfrmBankCodes.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      chkActive.Enabled := (AccessLevel = 1);
      qryBankCode.ParamByName('KeyID').asInteger := KeyID;
      OpenQueries;
      if KeyID = 0 then begin
        qryBankCode.Insert;
        qryBankCode.FieldByName('Active').AsString := 'T';
        qryBankCode.FieldByName('RegionID').AsInteger := AppEnv.RegionalOptions.ID;
      end else begin
        qryBankCode.Edit;
      end;
      SetControlFocus(txtBankcode);
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmBankCodes.btnNewClick(Sender: TObject);
begin
  inherited;
  if not Empty(txtBankcode.Text) then begin
    qryBankCode.Insert;
    qryBankCode.FieldByName('Active').AsString := 'T';
    SetControlFocus(txtBankcode);
  end else CommonLib.MessageDlgXP_Vista('No Bank Code !', mtWarning, [mbOK], 0);
end;

procedure TfrmBankCodes.cbocountryCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if not modified then exit;
  EditDB(qryBankCode);
  qryBankCodeREgionID.AsInteger := qryRegionsregionId.AsInteger;
end;

initialization
  RegisterClassOnce(TfrmBankCodes);
  FormFact.RegisterMe(TfrmBankCodes, 'TfrmBankCodeList_*=CodeID');
  FormFact.RegisterControl(TfrmBankCodes, '*_cboBankCode=CodeID');
end.
