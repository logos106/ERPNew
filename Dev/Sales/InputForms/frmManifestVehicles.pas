unit frmManifestVehicles;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, StdCtrls, Mask, DBCtrls, DB,   ExtCtrls,
  DNMPanel, wwcheckbox, Buttons, DNMSpeedButton, SelectionDialog, AppEvnts,
  wwclearbuttongroup, wwradiogroup, kbmMemTable, wwdbedit, Wwdotdot,
  Wwdbcomb, wwdblook, DBAccess, MyAccess,ERPdbComponents, DataState, MemDS, Menus, AdvMenus, Shader,
  ImgList, ProgressDialog;

type
  TManifestVehicleGUI = class(TBaseInputGUI)
    Label11: TLabel;
    cmdOk: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    qryVehicles: TERPQuery;
    DSVehicles: TDataSource;
    qryVehiclesVehicleID: TAutoIncField;
    qryVehiclesOwnerName: TWideStringField;
    qryVehiclesDriver: TWideStringField;
    qryVehiclesPhone: TWideStringField;
    qryVehiclesRegistrationNo: TWideStringField;
    qryVehiclesTrailer: TWideStringField;
    qryVehiclesNotes: TWideMemoField;
    Description_Label: TLabel;
    VehicleName: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Driver: TDBEdit;
    Label3: TLabel;
    RegistrationNo: TDBEdit;
    qryVehiclesActive: TWideStringField;
    Trailer: TwwRadioGroup;
    Label31: TLabel;
    Phone: TDBEdit;
    Notes: TDBMemo;
    Label4: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    qryVehiclesVehicleName: TWideStringField;
    memqryVehicles: TkbmMemTable;
    qryVehiclesGlobalRef: TWideStringField;
    qryVehiclesEditedFlag: TWideStringField;
    qrySuppliers: TERPQuery;
    dsSuppliers: TDataSource;
    qrySuppliersClientID: TAutoIncField;
    qrySuppliersCompany: TWideStringField;
    cboSupplier: TwwDBLookupCombo;
    qryVehiclesSupplierID: TIntegerField;
    Label9: TLabel;
    edtRatePerTruck: TDBEdit;
    qryVehiclesPercentageRate: TFloatField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdOkClick(Sender: TObject);
    procedure qryVehiclesAfterOpen(DataSet: TDataSet);
    procedure cboSupplierCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
        
  end;

//var
//  ManifestVehicleGUI: TManifestVehicleGUI;

implementation
  
uses FormFactory, DNMLib, DNMExceptions, CommonLib;
{$R *.dfm}

{ TManifestVehicleGUI }

procedure TManifestVehicleGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
//  ManifestVehicleGUI := nil;
end;

procedure TManifestVehicleGUI.cmdCancelClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TManifestVehicleGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      if qryVehicles.Active then begin
        if not (qryVehicles.State in [dsBrowse]) then begin
          qryVehicles.Post;
          Notify;
        end;
        CloseQueries;
      end;
      qryVehicles.ParamByName('ID').asInteger := KeyID;
      OpenQueries;

      if KeyID = 0 then begin
        qryVehicles.Insert;
        VehicleName.ReadOnly := false;
      end else begin
        qryVehicles.Edit;
        VehicleName.ReadOnly := true;
      end;
      chkActive.Enabled := (AccessLevel <> 2) and (AccessLevel <> 3);
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;


procedure TManifestVehicleGUI.cmdNewClick(Sender: TObject);
begin
  try
    if not Empty(VehicleName.Text) then begin
      // Ensure the user selected a supplier name.
      if cboSupplier.Text = '' then begin
        CommonLib.MessageDlgXP_Vista('Supplier name cannot be blank.', mtWarning, [mbOK], 0);
        SetControlFocus(cboSupplier);
        Exit;
      end;

      if not (qryVehicles.State in [dsBrowse]) then begin
        qryVehicles.Edit;
        qryVehicles.Post;
      end;

      KeyID := 0;
      FormShow(nil);
      VehicleName.ReadOnly := false;
      SetControlFocus(VehicleName);
    end else begin
      CommonLib.MessageDlgXP_Vista('Vehicle Name cannot be blank.', mtWarning, [mbOK], 0);
      SetControlFocus(VehicleName);
    end;
  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;


procedure TManifestVehicleGUI.cmdOkClick(Sender: TObject);
begin
  try
    // Ensure the user selected a supplier name.
    if cboSupplier.Text = '' then begin
      CommonLib.MessageDlgXP_Vista('Supplier name cannot be blank.', mtWarning, [mbOK], 0);
      SetControlFocus(cboSupplier);
      Exit;
    end;

    // Did the user provide a vehicle name?
    if not Empty(VehicleName.Text) then begin
      // Yes, then Save details.
      if not (qryVehicles.State in [dsBrowse]) then begin
        ProcessEditedFlag('Main', Self, memqryVehicles, qryVehicles, nil);
        qryVehicles.Edit;
        qryVehicles.Post;
        Notify;
      end;

      Self.Close;
    end else begin
      // No, then inform the user them must provide a vehicle name.
      CommonLib.MessageDlgXP_Vista('Vehicle Name cannot be blank.', mtWarning, [mbOK], 0);
      SetControlFocus(VehicleName);
    end;

  except
    // Except Handler.
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

procedure TManifestVehicleGUI.qryVehiclesAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LoadEditedFlagMemTable(qryVehicles, MemqryVehicles)
end;

procedure TManifestVehicleGUI.cboSupplierCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  with qryVehicles do begin
    FieldByName('SupplierID').AsString := qrySuppliers.FieldByName('ClientID').AsString;
  end;
end;

initialization
  RegisterClassOnce(TManifestVehicleGUI);
  with FormFact do begin
    RegisterMe(TManifestVehicleGUI, 'TManifestVehiclesListGUI_*=VehicleID');
    RegisterControl(TManifestVehicleGUI, '*_cboVehicle=VehicleID');
  end;
end.

