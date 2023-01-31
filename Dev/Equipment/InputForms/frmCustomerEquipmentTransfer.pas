unit frmCustomerEquipmentTransfer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  DNMSpeedButton, StdCtrls, Shader, DNMPanel, wwdblook, ERPDbLookupCombo, Mask,
  wwdbedit, BusObjClient, BusObjConst, BusObjBase, ProgressDialog, Grids, Wwdbigrd, Wwdbgrid;

type
  TfmCustomerEquipmentTransfer = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    edtEquipmentName: TwwDBEdit;
    cboCustomer: TERPDbLookupCombo;
    Label1: TLabel;
    Label2: TLabel;
    qryCustEquip: TERPQuery;
    dsCustEquip: TDataSource;
    qryCustomers: TERPQuery;
    qryCustEquipGlobalRef: TWideStringField;
    qryCustEquipid: TIntegerField;
    qryCustEquipEquipmentID: TIntegerField;
    qryCustEquipNotes: TWideMemoField;
    qryCustEquipClientID: TIntegerField;
    qryCustEquipDescription: TWideStringField;
    qryCustEquipEditedFlag: TWideStringField;
    qryCustEquipEquipName: TWideStringField;
    qryCustEquipmsTimeStamp: TDateTimeField;
    qryCustEquipManufacture: TWideStringField;
    qryCustEquipmodel: TWideStringField;
    qryCustEquipSerialno: TWideStringField;
    qryCustEquipRegistration: TWideStringField;
    qryCustEquipWarantyPeriod: TFloatField;
    qryCustEquipWarantyFinishDate: TDateTimeField;
    qryCustEquipQuantity: TFloatField;
    qryCustEquipUOM: TWideStringField;
    qryCustEquipUOMID: TLargeintField;
    qryCustEquipUOMMultiplier: TFloatField;
    qryCustEquipUOMQty: TFloatField;
    qryCustEquipWarantyStartDate: TDateTimeField;
    qryCustEquipActive: TWideStringField;
    qryCustEquipCUSTFLD1: TWideStringField;
    qryCustEquipCUSTFLD2: TWideStringField;
    qryCustEquipCUSTFLD3: TWideStringField;
    qryCustEquipCUSTFLD4: TWideStringField;
    qryCustEquipCUSTFLD5: TWideStringField;
    qryCustEquipCUSTFLD6: TWideStringField;
    qryCustEquipCUSTFLD7: TWideStringField;
    qryCustEquipCUSTFLD8: TWideStringField;
    qryCustEquipCUSTFLD9: TWideStringField;
    qryCustEquipCUSTFLD10: TWideStringField;
    qryCustEquipClientName: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboCustomerBeforeOpenList(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cboCustomerDoGridDataSelect(Sender: TObject);
  private
    CustomerEquipment: TCustomerEquipment;
    //fTransConnection: TERPConnection;
    fSourceDataset: TDataset;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure SetTransConnection(const Value: TERPConnection);Override;
  public
    //property TransConnection: TERPConnection read fTransConnection write SetTransConnection;
    property SourceDataset: TDataset read fSourceDataset write fSourceDataset;
  end;

  function DoCustomerEquipmentTransfer(CustEquipID: integer; Conn: TMyConnection): boolean;

implementation

{$R *.dfm}

uses
  BaseListingForm, CustomerExpressList;

function DoCustomerEquipmentTransfer(CustEquipID: integer; Conn: TMyConnection): boolean;
var
  form: TfmCustomerEquipmentTransfer;
  SaveActive: boolean;
  SrcCustEquip: TErpQuery;
begin
  result:= false;
  SrcCustEquip:= TErpQuery.Create(nil);
  try
    SrcCustEquip.Connection:= Conn;
    SrcCustEquip.SQL.Text:= 'select * from tblCustomerEquip where ID = ' + IntToStr(CustEquipID);
    SrcCustEquip.Open;
    SaveActive:= SrcCustEquip.FieldByName('Active').AsBoolean;
    try
      if SaveActive then begin
        SrcCustEquip.Edit;
        SrcCustEquip.FieldByName('Active').AsBoolean:= false;
        SrcCustEquip.Post;
      end;
      form:= TfmCustomerEquipmentTransfer.Create(nil);
      try
        form.TransConnection:= TERPConnection(Conn);
        form.SourceDataset:= SrcCustEquip;
        result:= form.ShowModal = mrOk;

      finally
        form.Free;
      end;
    finally
      if (not result) and (SrcCustEquip.FieldByName('Active').AsBoolean <> SaveActive) then begin
        SrcCustEquip.Edit;
        SrcCustEquip.FieldByName('Active').AsBoolean:= SaveActive;
        SrcCustEquip.Post;
      end;
    end;
  finally
    SrcCustEquip.Free;
  end;
end;

procedure TfmCustomerEquipmentTransfer.btnCancelClick(Sender: TObject);
begin
  inherited;
  CustomerEquipment.connection.RollbackNestedTransaction;
end;

procedure TfmCustomerEquipmentTransfer.btnSaveClick(Sender: TObject);
begin
  inherited;
  CustomerEquipment.PostDb;
  CustomerEquipment.IsTransferingtoAnotehrclient:= True;
  try
    if CustomerEquipment.Save then begin
      CustomerEquipment.connection.CommitNestedTransaction;
      ModalResult:= mrOK;
    end;
  finally
    CustomerEquipment.IsTransferingtoAnotehrclient := False;
  end;
end;

procedure TfmCustomerEquipmentTransfer.cboCustomerBeforeOpenList(
  Sender: TObject);
begin
  inherited;
  TBaseListingGUI(Sender).FilterString:= 'ClientID <> ' +
    SourceDataset.FieldByName('ClientID').AsString + ' and Active = "T"';
end;

procedure TfmCustomerEquipmentTransfer.cboCustomerDoGridDataSelect(Sender: TObject);
begin
  inherited;
  if sender is TwwDBGrid then begin
    if TwwDBGrid(Sender).datasource.dataset.findfield('company') <> nil then begin
      CustomerEquipment.ClientName := TwwDBGrid(Sender).datasource.dataset.findfield('company').asString ;
      CustomerEquipment.PostDB;

      {refreshthe combo}
      TERPQuery(cbocustomer.LookupTable).ParamByName('SearchMode').AsInteger:= ord(smStartsWith);
      TERPQuery(cbocustomer.LookupTable).ParamByName('SearchValue').AsString:= CustomerEquipment.ClientName;
      if TERPQuery(cbocustomer.LookupTable).Active then TERPQuery(cbocustomer.LookupTable).Refresh;
      if TERPQuery(cbocustomer.LookupTable).locate('clientId' , customerequipment.clientId,[]) then
        cbocustomer.text :=CustomerEquipment.ClientName;
    end;
  end;
end;

procedure TfmCustomerEquipmentTransfer.DoBusinessObjectEvent(  const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TCustomerEquipment then
      TCustomerEquipment(Sender).DataSet:= qryCustEquip;
  end
end;

procedure TfmCustomerEquipmentTransfer.FormCreate(Sender: TObject);
begin
  inherited;
  CustomerEquipment:= TCustomerEquipment.Create(self);
  CustomerEquipment.Connection := TMyDacDataConnection.Create(CustomerEquipment);
  CustomerEquipment.Connection.MyDacConnection := MyConnection;
  CustomerEquipment.BusObjEvent := DoBusinessObjectEvent;
  cboCustomer.SpcialLookupItemList.Text := ComboSpecialItem_OpenList;
end;

procedure TfmCustomerEquipmentTransfer.FormShow(Sender: TObject);
var
  SrcCustEquip: TCustomerEquipment;
begin
  inherited;

  CustomerEquipment.connection.BeginNestedTransaction;
  qryCustomers.ParamByName('ExcludeClientID').AsInteger:=
    SourceDataset.FieldByName('ClientID').AsInteger;

  qryCustomers.Open;
  SrcCustEquip:= TCustomerEquipment.Create(nil);
  try
    SrcCustEquip.Connection:= CustomerEquipment.Connection;
    SrcCustEquip.Load(SourceDataset.FieldByName('ID').AsInteger);
    SrcCustEquip.ObjInstanceToClone:= CustomerEquipment;
    SrcCustEquip.CloneBusObj('ClientID',0,false);
    CustomerEquipment.clientId := 0;
    CustomerEquipment.Active:= true;
    CustomerEquipment.SilentMode:= false;
  finally
    SrcCustEquip.Free;
  end;
end;

procedure TfmCustomerEquipmentTransfer.SetTransConnection(  const Value: TERPConnection);
begin
  inherited SetTransConnection(Value);
  CloseDb(qryCustEquip);
  qryCustEquip.Connection:= fTransConnection;
  CustomerEquipment.Connection.MyDacConnection:= fTransConnection;
end;

end.
