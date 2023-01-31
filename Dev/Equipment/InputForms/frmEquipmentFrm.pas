unit frmEquipmentFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess,
  MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls, MemDS, StdCtrls, Mask,
  wwdbedit, wwcheckbox, DNMSpeedButton, Shader, DNMPanel, ImgList, wwdblook, BusObjEquipment,
  Grids, Wwdbigrd, Wwdbgrid, BusObjBase, ActnList, DNMAction, ProgressDialog;

type
  TfrmEquipment = class(TBaseInputGUI)
    DSEquipment: TDataSource;
    qryEquipment: TERPQuery;
    qryEquipmentGlobalRef: TWideStringField;
    qryEquipmentEquipmentID: TIntegerField;
    qryEquipmentEquipmentName: TWideStringField;
    qryEquipmentEquipmentDescription: TWideStringField;
    qryEquipmentEditedFlag: TWideStringField;
    qryEquipmentActive: TWideStringField;
    qryEquipmentmsTimeStamp: TDateTimeField;
    qryEquipmentProductId: TLargeintField;
    qryEquipmentManufacture: TWideStringField;
    qryEquipmentModel: TWideStringField;
    qryManufacture: TERPQuery;
    qryManufactureName: TWideStringField;
    qryManufactureID: TIntegerField;
    qryEquipmentManufactureID: TIntegerField;
    QryEquipmentParts: TERPQuery;
    dsEquipmentParts: TDataSource;
    QryEquipmentPartsGlobalref: TWideStringField;
    QryEquipmentPartsID: TIntegerField;
    QryEquipmentPartsEquipmentId: TIntegerField;
    QryEquipmentPartsEquipmentname: TWideStringField;
    QryEquipmentPartsProductId: TIntegerField;
    QryEquipmentPartsProductName: TWideStringField;
    QryEquipmentPartsActive: TWideStringField;
    QryEquipmentPartsmstimestamp: TDateTimeField;
    qryParts: TERPQuery;
    QryLinkedProduct: TERPQuery;
    qryEquipmentProductname: TWideStringField;
    QryLinkedProductPARTSID: TIntegerField;
    QryLinkedProductPARTNAME: TWideStringField;
    qryPartsPARTSID: TIntegerField;
    qryPartsPARTNAME: TWideStringField;
    DNMPanel1: TDNMPanel;
    grdSpareParts: TwwDBGrid;
    Label1: TLabel;
    edName: TwwDBEdit;
    lblProduct: TLabel;
    cboProduct: TwwDBLookupCombo;
    Label2: TLabel;
    edDescription: TwwDBEdit;
    Label4: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    cboManufacture: TwwDBLookupCombo;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label3: TLabel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    cboProductR: TwwDBLookupCombo;
    QryEquipmentPartsPARTSDESCRIPTION: TWideStringField;
    qryPartsPARTSDESCRIPTION: TWideStringField;
    qryModel: TERPQuery;
    cboModel: TwwDBLookupCombo;
    Panel1: TPanel;
    Label7: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure cboManufactureCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboManufactureNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure cboProductRCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure grdSparePartsExit(Sender: TObject);
    procedure actchooseProductUpdate(Sender: TObject);
    procedure cboProductCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cboModelNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
  private
    fNewName:string;
    Equipment:TEquipment;
    function SaveEquip: boolean;
    (*Procedure LinkToEquipment(Sender:TObject);*)
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    property NewName: string read fNewName write fNewName;

  end;


implementation

{$R *.dfm}
uses
  CommonLib, FormFactory, BusObjConst, BusObjManufacture, BusObjModel;

procedure TfrmEquipment.btnCancelClick(Sender: TObject);
begin
  inherited;
  if fsModal in FormState then  else Close;
end;
Function TfrmEquipment.SaveEquip:boolean;
begin
  result := False;
  Equipment.PostDB;
  Equipment.Equipmentparts.PostDB;
  if edName.Text = '' then exit;
  REsult := Equipment.Save;
end;
procedure TfrmEquipment.btnSaveClick(Sender: TObject);
begin
  inherited;
  if not SaveEquip then exit;
  Equipment.Dirty := False;
  CommitTransaction;
  Notify(false);
  if fsModal in FormState then  else Close;
end;

procedure TfrmEquipment.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Closequeries;
  Action := caFree;
end;

procedure TfrmEquipment.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    bringTofront;
    if not Equipment.Dirty then begin
        canclose := True;
        Exit;
    end;
    case CommonLib.MessageDlgXP_Vista('Do you wish to keep these changes you have made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
    mrYes:
        begin
          if SaveEquip then begin
            CommitTransaction;
            Notify(False);
            CanClose := True;
          end else Canclose := False;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          Equipment.Dirty := false;
          CanClose := True;
          Notify(True);
        end;
      mrCancel:
        begin
          CanClose := false;
        end;
    end;

end;

procedure TfrmEquipment.FormShow(Sender: TObject);
begin
  inherited;
  BeginTransaction;
  Equipment.Load(KeyID);
  Openqueries;
  if Self.KeyID = 0 then begin
    Equipment.New;
    Equipment.PostDB;
    Equipment.EditDB;
    Self.KeyID := Equipment.ID;
    if fNewName <> '' then Equipment.EquipmentName:= NewName;
  end;
  cboProduct.enabled := Equipment.cleanproductId =0;
  lblProduct.enabled := Equipment.cleanproductId =0;
  Equipment.EquipmentParts;

  if not Equipment.Lock then begin
    Self.caption :=  self.Caption + '     {Read-Only}';
    Accesslevel  := 5;
  end;
end;

procedure TfrmEquipment.btnNewClick(Sender: TObject);
begin
  inherited;
  if not SaveEquip then exit;
  Equipment.Dirty := False;
  CommitTransaction;
  KeyID    := 0;
  fNewName := '';
  FormShow(nil);
end;

procedure TfrmEquipment.cboManufactureCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not modified then exit;
  inherited;
  Equipment.ManufactureID := qryManufactureID.asInteger;
  Equipment.Manufacture   := qryManufactureName.AsString;
end;

procedure TfrmEquipment.cboManufactureNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('This value not found in the list. Do you want to create a new one?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
  begin
    Accept := false;
    Exit;
  end;
  if TERPQuery(cboManufacture.datasource.Dataset).State in [dsEdit, dsInsert] then
  else TERPQuery(cboManufacture.datasource.Dataset).Edit;
  TERPQuery(cboManufacture.datasource.Dataset).FieldByName('Manufacture').AsString := NewValue;
  TManufacture.newManufacture(NewValue);
  Closedb(qryManufacture);
  OpenDb(qryManufacture);
  if qryManufacture.Locate('name' , newValue , []) then
     cboManufactureCloseUp(cboManufacture , qryManufacture , qryEquipment , true);
end;

procedure TfrmEquipment.cboModelNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
var
  msg: string;
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('This value not found in the list. Do you want to create a new one?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then begin
    Accept := false;
    Exit;
  end
  else begin
    if TModel.AddNewModel(cboModel.Text,msg) then
      Accept:= true
    else begin
      Accept:= false;
      CommonLib.MessageDlgXP_Vista('Could not create new Model: ' + msg, mtWarning, [mbOk], 0);
    end;
  end;

end;

procedure TfrmEquipment.FormCreate(Sender: TObject);
begin
  inherited;
  Equipment:= TEquipment.create(Self);
  Equipment.connection := TMyDacDataConnection.create(Equipment);
  Equipment.Connection.Connection := Self.MyConnection;
  Equipment.BusObjEvent := DoBusinessObjectEvent;

end;

procedure TfrmEquipment.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TEquipment then
      TEquipment(Sender).Dataset := qryEquipment
    else if Sender is TEquipmentParts then
      TEquipmentParts(Sender).Dataset := qryEquipmentParts;
    end else if (Eventtype = BusobjEvent_ToDo) and (Value = BusobjEvent_IDChange) then begin
      cboProduct.enabled := Equipment.cleanproductId =0;
      lblProduct.enabled := Equipment.cleanproductId =0;
  end;
end;
procedure TfrmEquipment.cboProductRCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not modified then exit;
  inherited;
  Equipment.EquipmentParts.ProductId := qryPartsPARTSID.asInteger;
  Equipment.EquipmentParts.PARTSDESCRIPTION := qrypartsPARTSDESCRIPTION.asString;
end;

procedure TfrmEquipment.grdSparePartsExit(Sender: TObject);
begin
  inherited;
  Equipment.EquipmentParts.PostDB;
end;
procedure TfrmEquipment.actchooseProductUpdate(Sender: TObject);
begin
  inherited;
(*  actchooseProduct.visible := (Equipment.productId = 0) or (Equipment.cleanProductID =0);*)
end;

(*procedure TfrmEquipment.LinkToEquipment(Sender: TObject);
begin
  with TwwDBGrid(Sender).Datasource.dataset do begin
    if RecordCount = 0 then exit;
    if findfield('PartsId') = nil then exit;
    if fieldByname('PartsID').asInteger = 0 then exit;
    Equipment.ProductID :=  fieldByname('PartsID').asInteger;
    Equipment.PostDB;
  end;
end;*)

procedure TfrmEquipment.cboProductCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then exit;
  inherited;
  Equipment.ProductId := QryLinkedProductPARTSID.asInteger;
end;

initialization
  RegisterClassOnce(TfrmEquipment);
  with FormFact do begin
    RegisterMe(TfrmEquipment, 'TCustomFieldValuesListEquipmentGUI_*=EquipmentID');
  end;
(*  with FormFact do begin
    RegisterMe(TfrmEquipment, 'TEquipmentListGUI_*=EquipmentID');
    RegisterMe(TfrmEquipment, 'TEquipmentsparePartsGUI_*=EquipmentID');
    RegisterMe(TfrmEquipment, 'TClientEquipmentlist_*=EquipmentID');
    RegisterControl(TfrmEquipment, '*_cboEquipment=EquipmentID');
    RegisterControl(TfrmEquipment, '*_cboEquipmentName=EquipmentID');
  end;*)
end.
