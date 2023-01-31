unit frmFixedAssetTypeGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,  ExtCtrls,
  DNMPanel, StdCtrls, wwcheckbox, Buttons, DNMSpeedButton, DBCtrls, wwdbedit, Wwdotdot,
  Wwdbcomb, Mask, DBAccess, MyAccess,ERPdbComponents, DataState, Menus, AdvMenus, MemDS, Shader,
  ImgList, ProgressDialog;

type
  TFixedAssetTypeGUI = class(TBaseInputGUI)
    cmdOk: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    Label11: TLabel;
    qryAssetTypes: TERPQuery;
    DSAssetTypes: TDataSource;
    qryAssetTypesAssetTypeID: TAutoIncField;
    qryAssetTypesAssetTypeCode: TWideStringField;
    qryAssetTypesAssetTypeName: TWideStringField;
    qryAssetTypesNotes: TWideMemoField;
    qryAssetTypesDepreciationOption: TSmallintField;
    qryAssetTypesLife: TFloatField;
    qryAssetTypesSalvageType: TSmallintField;
    qryAssetTypesSalvage: TFloatField;
    qryAssetTypesSalvageFactor: TFloatField;
    Bevel3: TBevel;
    Label1: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    SalvageFactor: TDBEdit;
    Salvage: TDBEdit;
    Life: TDBEdit;
    cboDepreciationOption: TwwDBComboBox;
    cboSalvageType: TwwDBComboBox;
    AssetTypeName: TDBEdit;
    Label8: TLabel;
    Label7: TLabel;
    AssetTypeCode: TDBEdit;
    Notes: TDBMemo;
    Label2: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryAssetTypesActive: TWideStringField;
    procedure cmdCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdOkClick(Sender: TObject);
    procedure cboDepreciationOptionChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboSalvageTypeChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
        
  end;

implementation
  
uses FormFactory, DNMExceptions, CommonLib;

{$R *.dfm}

procedure TFixedAssetTypeGUI.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TFixedAssetTypeGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
end;

procedure TFixedAssetTypeGUI.cmdNewClick(Sender: TObject);
begin
  try
    if not Empty(AssetTypeCode.Text) then begin
      qryAssetTypes.Edit;
      qryAssetTypes.Post;
      Notify;
      KeyID := 0;
      FormShow(nil);
      SetControlFocus(AssetTypeCode);
    end else begin
      CommonLib.MessageDlgXP_Vista('Asset Type Code cannot be blank.', mtWarning, [mbOK], 0);
      SetControlFocus(AssetTypeCode);
    end;
  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

procedure TFixedAssetTypeGUI.cmdOkClick(Sender: TObject);
begin
  try
    if not Empty(AssetTypeCode.Text) then begin
      qryAssetTypes.Edit;
      qryAssetTypes.Post;
      Notify;
      Self.Close;
    end else begin
      CommonLib.MessageDlgXP_Vista('Asset Type Code cannot be blank.', mtWarning, [mbOK], 0);
      SetControlFocus(AssetTypeCode);
    end;
  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

procedure TFixedAssetTypeGUI.cboDepreciationOptionChange(Sender: TObject);
begin
  inherited;
  if cboDepreciationOption.Value <> '3' then begin
    cboDepreciationOption.Width := 240;
    SalvageFactor.Visible       := false;
  end else begin
    cboDepreciationOption.Width := 170;
    SalvageFactor.Visible       := true;  
  end;
end;

procedure TFixedAssetTypeGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      if qryAssetTypes.Active then begin
        if not (qryAssetTypes.State in [dsBrowse]) then begin
          qryAssetTypes.Post;
          Notify;
        end;
        CloseQueries;
      end;
      qryAssetTypes.ParamByName('ID').asInteger := KeyID;
      OpenQueries;
      if KeyID = 0 then begin
        qryAssetTypes.Insert;
      end else begin
        qryAssetTypes.Edit;
      end;
      cboDepreciationOptionChange(nil);
      SetControlFocus(AssetTypeCode);
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;   
end;

procedure TFixedAssetTypeGUI.cboSalvageTypeChange(Sender: TObject);
begin
  inherited;
  if Empty(cboSalvageType.Text) then
    cboSalvageType.Text := 'Amount';

  if (cboSalvageType.Text = 'Amount') then begin
    qryAssetTypesSalvage.currency      := true;
    qryAssetTypesSalvage.DisplayFormat := '';
  end else begin
    qryAssetTypesSalvage.currency      := false;
    qryAssetTypesSalvage.DisplayFormat := '0.00%';
    if qryAssetTypesSalvage.AsFloat > 100.00 then qryAssetTypesSalvage.AsFloat := 0.00;
  end;
end;

initialization
  RegisterClassOnce(TFixedAssetTypeGUI);
  FormFact.RegisterMe(TFixedAssetTypeGUI, 'TFixedAssetTypeListGUI_*=AssetTypeID');
  FormFact.RegisterControl(TFixedAssetTypeGUI, '*_cboAssetType=AssetTypeID');
end.
