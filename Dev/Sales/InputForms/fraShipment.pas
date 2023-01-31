unit fraShipment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, BusObjShipment, DNMSpeedButton, StdCtrls, Grids, Wwdbigrd, Wwdbgrid,
  DB, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls, wwcheckbox,
  ActnList, DNMAction;

type
  TfrShipment = class(TFrame)
    btnDeleteShipping: TDNMSpeedButton;
    qrySaleLine: TERPQuery;
    ERPConnection1: TERPConnection;
    qrySaleLineSaleLineId: TIntegerField;
    qrySaleLineProductName: TWideStringField;
    qrySaleLineDescription: TWideStringField;
    qrySaleLineUOMSoldQty: TFloatField;
    qrySaleLineShippedUOMQty: TFloatField;
    qrySaleLineUOM: TWideStringField;
    qrySaleLineUnallocatedUOMQty: TFloatField;
    qrySaleLineAllocatedUOMQty: TFloatField;
    dsSaleLine: TDataSource;
    grdSaleLine: TwwDBGrid;
    Bevel1: TBevel;
    btnEditShipment: TDNMSpeedButton;
    btnAddressEdit: TDNMSpeedButton;
    lblShipAddress: TLabel;
    bevHeighlight: TBevel;
    chkProcessed: TCheckBox;
    edtTrackNo: TEdit;
    chkCanceled: TCheckBox;
    qrySaleLineRecipientAddressValid: TWideStringField;
    ActionList1: TActionList;
    actEditActionList: TDNMAction;
    qrySaleLineProvider: TWideStringField;
    qrySaleLinepayortype: TWideStringField;
    procedure qrySaleLineAllocatedUOMQtySetText(Sender: TField;
      const Text: string);
    procedure btnDeleteShippingClick(Sender: TObject);
    procedure grdSaleLineCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FrameDblClick(Sender: TObject);
    procedure btnEditShipmentClick(Sender: TObject);
    procedure btnAddressEditClick(Sender: TObject);
    procedure grdSaleLineDblClick(Sender: TObject);
    procedure lblShipAddressDblClick(Sender: TObject);
    procedure FrameClick(Sender: TObject);
    procedure lblShipAddressClick(Sender: TObject);
    procedure FrameResize(Sender: TObject);
    procedure actEditActionListUpdate(Sender: TObject);
  private
    fShipmentId: integer;
    fShipment: TShipment;
    fOnQtyChange: TNotifyEvent;
    fOnDelete: TNotifyEvent;
    FSelected: boolean;
    fiAccessLevel:Integer;
    procedure SetShipment(const Value: TShipment);
    function GetShipment: TShipment;
    procedure DoEditShipment;
    procedure DoEditAddress;
    procedure SetSelected(const Value: boolean);
    procedure setAccessLevel(const Value: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    property Shipment: TShipment read GetShipment write SetShipment;
    property OnQtyChange: TNotifyEvent read fOnQtyChange write fOnQtyChange;
    property OnDelete: TNotifyEvent read fOnDelete write fOnDelete;
    property Selected: boolean read FSelected write SetSelected;
    procedure UpdateGui;
    Property AccessLevel :Integer read fiAccessLevel Write setAccessLevel;
  end;

implementation

{$R *.dfm}

uses
  BaseInputForm, CommonLib, DNMButtons, LogLib, CommonDbLib;

{ TfrShipment }

procedure TfrShipment.btnDeleteShippingClick(Sender: TObject);
begin
//  Shipment.Active := false;
//  Shipment.PostDb;
  self.Click;
  if Assigned(fOnDelete) then
    fOnDelete(self);
end;

procedure TfrShipment.btnEditShipmentClick(Sender: TObject);
begin
  self.Click;
  DoEditShipment;
end;

constructor TfrShipment.Create(AOwner: TComponent);
begin
  try
    inherited;
  except
    ERPConnection1.Disconnect;
  end;
  qrySaleLine.Close;
  qrySaleLine.Connection := nil;
  fSelected := false;
  bevHeighlight.Visible := false;
end;

procedure TfrShipment.DoEditAddress;
var
  form: TBaseInputGUI;
begin
  form := TBaseInputGUI(GetComponentByClassName('TShipAddressGUI',false));
  form.KeyID := Shipment.ShipAddressId;
  if form.ShowModal = mrOk then begin
    Shipment.ShippingAddress.RefreshDB;
    Shipment.PopulateRecipientAddress;
    lblShipAddress.Caption := Shipment.RecipientAddressAsSingleLine;
  end;
end;

procedure TfrShipment.DoEditShipment;
var
  form: TBaseInputGUI;
begin
  Shipment.ShipmentList.PostDb;
  Shipment.ShipmentList.Connection.CommitTransaction;
  try
    form := TBaseInputGUI(GetComponentByClassName('TfmShipment',false, self));
    form.KeyID := Shipment.Id;
    if form.ShowModal = mrOk then begin
      Shipment.RefreshDB;
      Shipment.ShipmentList.UpdateStatus(Shipment.ShipmentList);
      Shipment.ShipmentList.PostDb;
      lblShipAddress.Caption := Shipment.RecipientAddressAsSingleLine;
      UpdateGui;
      closedb(qrySaleLine);
      Opendb(qrySaleLine);
    end;
  finally
    Shipment.ShipmentList.Connection.BeginTransaction;
  end;
end;

procedure TfrShipment.actEditActionListUpdate(Sender: TObject);
begin
  if qrySaleLineRecipientAddressValid.asBoolean then begin
    btnEditShipment.colorStyle := lcsGreen;
  end else begin
    btnEditShipment.colorStyle := lcsDefault;
  end;
end;

procedure TfrShipment.btnAddressEditClick(Sender: TObject);
begin
  self.Click;
  DoEditAddress;
end;

procedure TfrShipment.FrameClick(Sender: TObject);
var
  x: integer;
begin
  Selected := true;
  if Assigned(Parent) then begin
    for x := 0 to Parent.ControlCount -1 do begin
      if (Parent.Controls[x] is TfrShipment) and (Parent.Controls[x] <> self) then
        TfrShipment(Parent.Controls[x]).Selected := false;

    end;
  end;
end;

procedure TfrShipment.FrameDblClick(Sender: TObject);
begin
  DoEditShipment;
end;

procedure TfrShipment.FrameResize(Sender: TObject);
begin
  edtTrackNo.Width := self.ClientWidth - edtTrackNo.Left - 5;
end;

function TfrShipment.GetShipment: TShipment;
begin
  result := fShipment;
  result.Dataset.Locate('ShipmentId',fShipmentId,[]);
end;

procedure TfrShipment.qrySaleLineAllocatedUOMQtySetText(Sender: TField;
  const Text: string);
begin
  if Shipment.SalesLines.Dataset.Locate('SaleLineId', qrySaleLine.FieldByName('SaleLineId').AsInteger, []) then begin
    Shipment.SalesLines.UOMQty := StrToFloatDef(Text,0);
    Shipment.SalesLines.PostDb;
  end
  else begin
   Shipment.SalesLines.New;
   Shipment.SalesLines.SaleLineId := qrySaleLine.FieldByName('SaleLineId').AsInteger;
    Shipment.SalesLines.UOMQty := StrToFloatDef(Text,0);
    Shipment.SalesLines.PostDb;
  end;
  Sender.DataSet.Cancel;
  qrySaleLine.Refresh;
  if Assigned(OnQtyChange) then
    OnQtyChange(self);
end;

procedure TfrShipment.setAccessLevel(const Value: Integer);
begin
  fiAccessLevel := Value;
  if value >=3 then begin
    grdSaleLine.options := grdSaleLine.options - [dgediting];
    btnDeleteShipping.enabled := False;
    btnAddressEdit.enabled := False;
    btnEditShipment.enabled := False;
  end;
end;

procedure TfrShipment.SetSelected(const Value: boolean);
begin
  if FSelected <> Value then begin
    FSelected := Value;
    bevHeighlight.Visible := FSelected;
//    bevHeighlight.SendToBack;
//    self.Invalidate;
//    self.Repaint;
    btnAddressEdit.Invalidate;
    btnEditShipment.Invalidate;
    btnDeleteShipping.Invalidate;
  end;
end;

procedure TfrShipment.SetShipment(const Value: TShipment);
begin
  fShipment := Value;
  fShipmentId := Value.ID;
  if Assigned(fShipment) then begin
    lblShipAddress.Caption := fShipment.RecipientAddressAsSingleLine;

    qrySaleLine.ParamByName('SaleId').AsInteger := Shipment.SaleId;
    qrySaleLine.ParamByName('ShipmentId').AsInteger := Shipment.Id;
    qrySaleLine.Connection := fShipment.Connection.Connection;
    qrySaleLine.Open;
    logtext(qrySaleLine.SQLText);
    UpdateGui;
  end
  else begin
    lblShipAddress.Caption := '';
    qrySaleLine.Close;
    chkProcessed.Checked := false;
    chkCanceled.Checked := false;
    edtTrackNo.Text := '';
  end;
end;

procedure TfrShipment.UpdateGui;
begin
  chkProcessed.Checked := fShipment.Processed;
  chkCanceled.Checked := fShipment.Canceled;
  if Shipment.PackageIDCode <> '' then
    edtTrackNo.Text := Shipment.PackageIDCode
  else
    edtTrackNo.Text := Shipment.MasterTrackingNumber;
  if fShipment.Processed then
    grdSaleLine.Options := grdSaleLine.Options - [dgEditing];
  btnAddressEdit.Enabled := not fShipment.Processed;
end;

procedure TfrShipment.grdSaleLineCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if qrySaleLine.FieldByName('UnallocatedUOMQty').AsFloat <> 0 then
    ABrush.Color := $00c1c1ff
  else
    if field.FieldName <> 'AllocatedUOMQty' then
      ABrush.Color := $00d7d7d7;
  if field.FieldName = 'UnallocatedUOMQty' then
    AFont.Style := AFont.Style + [fsBold];
end;

procedure TfrShipment.grdSaleLineDblClick(Sender: TObject);
begin
  self.Click;
  DoEditShipment;
end;

procedure TfrShipment.lblShipAddressClick(Sender: TObject);
begin
  self.Click;
end;

procedure TfrShipment.lblShipAddressDblClick(Sender: TObject);
begin
  DoEditAddress;
end;

end.
