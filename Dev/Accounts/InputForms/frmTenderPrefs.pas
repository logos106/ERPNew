unit frmTenderPrefs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Grids, Wwdbigrd, Wwdbgrid, DNMSpeedButton,
  ExtCtrls, DNMPanel, Menus, AdvMenus, DataState, DBAccess, MyAccess,ERPdbComponents,
  SelectionDialog, AppEvnts, DB,  StdCtrls, wwdblook, MemDS, Shader,
  ImgList, ProgressDialog, ERPDbLookupCombo;

type
  TTenderPrefsGUI = class(TBaseInputGUI)
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    wwDBGrid1: TwwDBGrid;
    qryCOA: TERPQuery;
    qryPaymentMethods: TERPQuery;
    qryMaster: TERPQuery;
    DSMaster: TDataSource;
    cboPaymethod: TwwDBLookupCombo;
    cboCOA: TERPDbLookupCombo;
    qryMasterGlobalRef: TWideStringField;
    qryMasterTAPID: TIntegerField;
    qryMasterPaymethodID: TIntegerField;
    qryMasterPaymethod: TWideStringField;
    qryMasterAccountID: TIntegerField;
    qryMasterAccount: TWideStringField;
    qryMastermsTimeStamp: TDateTimeField;
    qryMasterActive: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryMasterSurchargePercent: TFloatField;
    qryCOAAccountID: TIntegerField;
    qryCOAAccountType: TWideStringField;
    qryCOAAccountGroup: TWideStringField;
    qryCOAAccountName: TWideStringField;
    qryCOABalance: TFloatField;
    qryCOADescription: TWideStringField;
    qryCOAAccountNumber: TWideStringField;
    procedure btnCompletedClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qryMasterAccountChange(Sender: TField);
    procedure qryMasterPaymethodChange(Sender: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TenderPrefsGUI: TTenderPrefsGUI;

implementation

  uses CommonDBlib,tcDataUtils, CommonLib, PreferancesLib;
{$R *.dfm}

procedure TTenderPrefsGUI.btnCompletedClick(Sender: TObject);
begin
  Try
    inherited;
    qryMaster.Edit;    
    qryMaster.Post;
    CommitTransaction;
    PreferancesLib.DoPrefAuditTrail;
    Self.close;
  except
    on e: Exception do begin
      RollbackTransaction;
      Self.Close;
    end;
  end;
end;

procedure TTenderPrefsGUI.FormShow(Sender: TObject);
begin
  inherited;
  qryMaster.Connection := MyConnection;
  qryPaymentMethods.Connection := Commondblib.GetSharedMyDacConnection;
  qryCOA.Connection := Commondblib.GetSharedMyDacConnection;
  OpenQueries;
  BeginTransaction;
end;

procedure TTenderPrefsGUI.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TTenderPrefsGUI.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  inherited;
  Action := cafree;
end;

procedure TTenderPrefsGUI.qryMasterAccountChange(Sender: TField);
begin
  inherited;
  if qryMasterAccount.AsString = '' then begin
    qryMasterAccountID.asInteger := 0;
  end else begin
    qryMasterAccountID.asInteger := tcDataUtils.getAccountID(qryMasterAccount.AsString);
    if qryMasterAccountID.asInteger  =0 then qryMasterAccount.AsString := '';
  end;
end;

procedure TTenderPrefsGUI.qryMasterPaymethodChange(Sender: TField);
begin
  inherited;
  qryMasterPaymethodID.asInteger := tcDataUtils.GetPaymentMethod(cboPaymethod.Text);
end;

initialization
  RegisterClassOnce(TTenderPrefsGUI);
end.
