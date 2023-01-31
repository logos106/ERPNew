unit frmRepairFaults;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ImgList, Menus, AdvMenus, DataState, DB,
  DBAccess, MyAccess, ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls,
  StdCtrls, Shader, DNMPanel, MemDS, wwclearbuttongroup, wwradiogroup,
  BusObjBase, DNMSpeedButton, wwcheckbox, Mask, wwdbedit, busobjrepairs,
  wwdblook, ProgressDialog;

type
  TfmRepairFaults = class(TBaseInputGUI)
    DNMPanel3: TDNMPanel;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Qryrepairfaults: TERPQuery;
    dsrepairfaults: TDataSource;
    QryrepairfaultsRepairFaultID: TLargeintField;
    QryrepairfaultsGlobalref: TWideStringField;
    Qryrepairfaultscode: TWideStringField;
    QryrepairfaultsCategory: TWideStringField;
    QryrepairfaultsDescription: TWideStringField;
    QryrepairfaultsActive: TWideStringField;
    QryrepairfaultsmsTimestamp: TDateTimeField;
    wwRadioGroup1: TwwRadioGroup;
    lblFrom: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    chkActive: TwwCheckBox;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    edtcode: TwwDBEdit;
    edtDescription: TwwDBEdit;
    qryManufacture: TERPQuery;
    qryManufactureName: TWideStringField;
    qryManufactureID: TIntegerField;
    cboManufacture: TwwDBLookupCombo;
    Label2: TLabel;
    QryrepairfaultsManufactureID: TIntegerField;
    QryrepairfaultsManufacture: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cboManufactureCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
  private
    RepairFaults:TRepairFaults;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, FormFactory, BusObjConst;

{$R *.dfm}
procedure TfmRepairFaults.FormCreate(Sender: TObject);
begin
  inherited;
  RepairFaults:=TRepairFaults.create(Self);
  RepairFaults.Connection := TMyDacDataConnection.create(RepairFaults);
  RepairFaults.connection.Connection := Self.MyConnection;
  RepairFaults.BusObjEvent :=DoBusinessObjectEvent;
end;

procedure TfmRepairFaults.FormShow(Sender: TObject);
begin
  inherited;
  RepairFaults.Load(KeyID);
  OpenQueries;
  RepairFaults.Connection.BeginTransaction;
  if KeyId = 0 then RepairFaults.New;
end;

procedure TfmRepairFaults.btnSaveClick(Sender: TObject);
begin
  inherited;
  RepairFaults.PostDB;
  if not RepairFaults.Save then exit;
  RepairFaults.Connection.CommitTransaction;
  Notify(false);
  if fsModal in FormState then  else Close;
end;

procedure TfmRepairFaults.btnCancelClick(Sender: TObject);
begin
  inherited;
  Notify(True);
  if fsModal in FormState then  else Close;
end;

procedure TfmRepairFaults.btnNewClick(Sender: TObject);
begin
  inherited;
  RepairFaults.PostDB;
  if not RepairFaults.Save then exit;
  RepairFaults.Connection.CommitTransaction;
  RepairFaults.Connection.BeginTransaction;
  RepairFaults.New;
  SetControlFocus(edtcode);
end;

procedure TfmRepairFaults.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  MsgOption: integer;
begin
  Canclose := False;
  if (RepairFaults.Dirty = false) then CanClose := true
  else  begin
    MsgOption := CommonLib.MessageDlgXP_Vista('Do you wish to Save changes?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
    if msgOption = mrYes then begin
        if not RepairFaults.Save then exit;
        RepairFaults.Connection.CommitTransaction;
        Canclose:= true;
    end else if MsgOption = mrNo then begin
      RepairFaults.canceldb;
      RepairFaults.Connection.RollbackTransaction;
      canclose:=true;
    end else CanClose := false;
  end;
  if Canclose then inherited;
end;

procedure TfmRepairFaults.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
    inherited ;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TRepairFaults then TRepairFaults(Sender).Dataset := Qryrepairfaults;
    end;
end;

procedure TfmRepairFaults.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmRepairFaults.cboManufactureCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  RepairFaults.ManufactureID := qryManufactureID.asInteger;
  RepairFaults.Manufacture:= qryManufactureName.asString;
end;

initialization
  RegisterClassOnce(TfmRepairFaults);
  with FormFact do begin
    RegisterMe(TfmRepairFaults, 'TRepairFaultGUI_*=RepairFaultID');
  end;

end.
