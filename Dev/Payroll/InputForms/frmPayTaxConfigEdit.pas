unit frmPayTaxConfigEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, BusObjPayTaxConfig, BusObjBase, DNMSpeedButton,
  Shader, DNMPanel, wwcheckbox, wwdblook, Wwdotdot, Wwdbcomb, Mask, wwdbedit;

type
  TfmPayTaxConfigEdit = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    qryPayTaxConfig: TERPQuery;
    dsPayTaxConfig: TDataSource;
    qryPayTaxConfigGlobalRef: TWideStringField;
    qryPayTaxConfigID: TIntegerField;
    qryPayTaxConfigRegionId: TIntegerField;
    qryPayTaxConfigTaxName: TWideStringField;
    qryPayTaxConfigExpenseAccountId: TIntegerField;
    qryPayTaxConfigLiabilityAccountId: TIntegerField;
    qryPayTaxConfigTaxType: TWideStringField;
    qryPayTaxConfigPrimaryTax: TWideStringField;
    qryPayTaxConfigRoundTax: TWideStringField;
    qryPayTaxConfigActive: TWideStringField;
    qryPayTaxConfigmsTimeStamp: TDateTimeField;
    qryPayTaxConfigmsUpdateSiteCode: TWideStringField;
    Label1: TLabel;
    edtTaxName: TwwDBEdit;
    cboTaxType: TwwDBComboBox;
    qryExpenseAccountLookup: TERPQuery;
    qryLiabilityAccountLookup: TERPQuery;
    cboExpenseAccount: TwwDBLookupCombo;
    qryPayTaxConfigExpenseAccount: TStringField;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    cboLiabilityAccount: TwwDBLookupCombo;
    chkPrimary: TwwCheckBox;
    chkRoundTax: TwwCheckBox;
    chkActive: TwwCheckBox;
    qryPayTaxConfigAllowanceAmount: TFloatField;
    Label5: TLabel;
    edtAllowanceAmount: TwwDBEdit;
    Label6: TLabel;
    cboTaxScale: TwwDBLookupCombo;
    qryTaxScaleLookup: TERPQuery;
    qryPayTaxConfigDefaultTaxScaleId: TIntegerField;
    qryPayTaxConfigDefaultTaxScale: TStringField;
    Label7: TLabel;
    cboGroupType: TwwDBComboBox;
    qryPayTaxConfigGroupType: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qryTaxScaleLookupBeforeOpen(DataSet: TDataSet);
  private
    TaxConfig: TPayTaxConfig;
    function SaveRecord: Boolean;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure SetTransConnection(const Value: TERPConnection); override;
  public
    { Public declarations }
  end;

  function DoPayTaxConfigEdit(aId: integer; Conn: TERPConnection): boolean;

implementation

uses
  BusObjConst, CommonLib, DNMExceptions, Appenvironment;

function DoPayTaxConfigEdit(aId: integer; Conn: TERPConnection): boolean;
var
  form: TfmPayTaxConfigEdit;
begin
  form := TfmPayTaxConfigEdit.Create(nil);
  try
    form.TransConnection := Conn;
    form.KeyID := aId;
    result := form.ShowModal = mrOk;
  finally
    form.Free;
  end;
end;


{$R *.dfm}

{ TfmPayTaxConfigEdit }

procedure TfmPayTaxConfigEdit.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if SaveRecord then begin
    CommitTransaction;
    TaxConfig.Dirty := false;
    ModalResult := mrOk;
  end;
end;

procedure TfmPayTaxConfigEdit.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
 inherited ;
 if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TPayTaxConfig then TPayTaxConfig(Sender).Dataset  := qryPayTaxConfig;
 end;
end;

procedure TfmPayTaxConfigEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmPayTaxConfigEdit.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if TaxConfig.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveRecord then begin
            CommitTransaction;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          TaxConfig.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
          cmdCancel.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;

end;

procedure TfmPayTaxConfigEdit.FormCreate(Sender: TObject);
begin
  inherited;
  TaxConfig := TPayTaxConfig.Create(Self);
  TaxConfig.Connection := TMyDacDataConnection.Create(TaxConfig);
  TaxConfig.Connection.connection := TransConnection;
  TaxConfig.BusObjEvent := DoBusinessObjectEvent;
  qryPayTaxConfig.Connection := TransConnection;
end;

procedure TfmPayTaxConfigEdit.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      TaxConfig.Load(KeyID);
      BeginTransaction;
      if TaxConfig.count = 0 then TaxConfig.new
      else edtTaxName.ReadOnly := true;
      OpenQueries;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfmPayTaxConfigEdit.qryTaxScaleLookupBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryTaxScaleLookup.ParamByName('RegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

function TfmPayTaxConfigEdit.SaveRecord: Boolean;
begin
  result := TaxConfig.Save;
end;

procedure TfmPayTaxConfigEdit.SetTransConnection(const Value: TERPConnection);
begin
  inherited;
  AssignConnectionToAllQrys(TransConnection);
  TaxConfig.Connection.connection := TransConnection;
end;

end.
