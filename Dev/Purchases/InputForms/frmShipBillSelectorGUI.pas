unit frmShipBillSelectorGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess,
  MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls, DNMSpeedButton, StdCtrls,
  CheckLst, MemDS, Grids, Wwdbigrd, Wwdbgrid,BusObjShippingContainer,
  wwcheckbox, Shader, DNMPanel, ImgList, ProgressDialog;

type
  TfrmShipBillSelector = class(TBaseInputGUI)
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryBills: TERPQuery;
    Label1: TLabel;
    grdBills: TwwDBGrid;
    DSBills: TDataSource;
    qryBillsPurchaseLineID: TIntegerField;
    qryBillsOrderDate: TDateTimeField;
    qryBillsSupplierName: TWideStringField;
    qryBillsLineCost: TFloatField;
    qryBillsLineTax: TFloatField;
    qryBillsLineCostInc: TFloatField;
    qryBillsTotalLineAmountInc: TFloatField;
    qryBillsTotalLineAmount: TFloatField;
    qryBillsRelatedShipContainerIDUsed: TWideStringField;
    qryBillsPurchaseOrderID: TIntegerField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryBillsType: TWideStringField;
    qryBillsPhone: TWideStringField;
    qryBillsInvoiceNumber: TWideStringField;
    qryBillsForeignTotalLineAmount: TFloatField;
    qryBillsForeignExchangeCode: TWideStringField;
    DNMSpeedButton1: TDNMSpeedButton;
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdBillsDblClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure qryBillsRelatedShipContainerIDUsedChange(Sender: TField);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure grdBillsColEnter(Sender: TObject);
    procedure grdBillsRowChanged(Sender: TObject);
    procedure grdBillsEnter(Sender: TObject);
  private
    fSubShip:TShippingContainer;
    procedure SetSubShip(Const Value :TShippingContainer );
    Procedure CallBackApply(Sender: TDataset; var Abort: boolean);
    Procedure SetfocustoApply;
   // procedure SetForeignFieldDisplayFormat;
  public
    property SubShip:TShippingContainer  read fSubShip write SetSubShip ;
  end;    

implementation

{$R *.dfm}
uses
  CommonLib, BusObjCurrency;


procedure TfrmShipBillSelector.SetfocustoApply;
begin
  if not(Screen.activecontrol =grdBills) then exit;
  if not(sameText(grdBills.getActiveField.fieldname, 'RelatedShipContainerIDUsed')) then
    grdBills.setActiveField('RelatedShipContainerIDUsed');
end;

procedure TfrmShipBillSelector.SetSubShip(Const Value :TShippingContainer);
begin
  fSubShip := Value;
end;

procedure TfrmShipBillSelector.btnCancelClick(Sender: TObject);
begin
  RollbackTransaction;
  inherited;
end;

procedure TfrmShipBillSelector.btnSaveClick(Sender: TObject);
var
  dTotalCost:double;
begin
  inherited;
  qryBills.DisableControls;
  try
    dTotalCost := 0;
    qryBills.First;
    while not qryBills.Eof do begin
      if qryBills.FieldByName('RelatedShipContainerIdUsed').AsString = 'T' then begin
        SubShip.ContainerDetails.AuxilaryBillIDList.Add(qryBills.FieldByName('PurchaseOrderID').AsInteger);
        dTotalCost := dTotalCost + qryBills.FieldByName('LineCostInc').asFloat;
      end;
      qryBills.Next;
    end;
    if dTotalCost > 0 then SubShip.TotalAuxilaryCosts := dTotalCost;
  finally
    qryBills.EnableControls;
  end;
  CommitTransaction;
  ModalResult := mrOK;
end;

procedure TfrmShipBillSelector.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  userlock.Unlock('Shipping Container - Bill Selector');
end;

procedure TfrmShipBillSelector.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    if not qryBills.Active then qryBills.Open;
    BeginTransaction;
    qryBills.Edit;
    UserLock.Enabled := True; // used to lock the bills when applied
  finally
    EnableForm;
  end;  
end;

//procedure TfrmShipBillSelector.SetForeignFieldDisplayFormat;
//var
//  CurrencySymbol,fmt,fmt5: string;
//  fld: TField;
//begin
//  CurrencySymbol:= TExchangeRates.CurrencySymbolForCode(qryBills.FieldByName('ForeignExchangeCode').AsString, MyConnection);
//
//  fmt:= CurrencySymbol + '#,##0.00;(' + CurrencySymbol + '#,##0.00)';
//  fmt5:= CurrencySymbol + '#,##0.00000;(' + CurrencySymbol + '#,##0.00000)';
//  if qryBills.Active then begin
//    fld:= qryBills.FindField('ForeignTotalLineAmount');
//    if Assigned(fld) then TFloatField(fld).DisplayFormat:= fmt5;
//  end;
//end;

procedure TfrmShipBillSelector.grdBillsColEnter(Sender: TObject);
begin
  inherited;
  SetfocustoApply;
end;

procedure TfrmShipBillSelector.grdBillsDblClick(Sender: TObject);
var
  Frm:TComponent;
begin
  inherited;
  Processingcursor(True);
  try
    //if (Sysutils.SameText('CustomerJob',grdDetails.getActiveField.FieldName))
    if qryBills.FieldByName('Type').asString = 'Bill' then begin
      frm := GetComponentByClassName('TBillGUI');
    end else if qryBills.FieldByName('Type').asString = 'Credit' then begin
      frm := GetComponentByClassName('TCreditGUI');
    end;      
    if Assigned(Frm) then begin
      TBaseInputGUI(Frm).KeyID :=  qryBills.FieldByName('PurchaseOrderID').AsInteger;
      TBaseInputGUI(frm).ShowModal;
    end;
  finally
    Processingcursor(False);
    SetControlFocus(grdBills);
    FreeandNil(frm);
  end;
end;

procedure TfrmShipBillSelector.grdBillsEnter(Sender: TObject);
begin
  inherited;
  SetfocustoApply;
end;

procedure TfrmShipBillSelector.grdBillsRowChanged(Sender: TObject);
begin
  inherited;
  SetfocustoApply;
end;

procedure TfrmShipBillSelector.qryBillsRelatedShipContainerIDUsedChange(  Sender: TField);
var
  ErrMsg:STring;
begin
  inherited;
  if not(qryBillsRelatedShipContainerIDUsed.asBoolean ) then exit;
  if not(UserLock.Lock('tblPurchaseOrders' , QrybillsPurchaseOrderId.asInteger,'Shipping Container - Bill Selector')) then begin
    ErrMsg:=userlock.LockMessage;
    ErrMsg:=ReplaceStr(ErrMsg, 'this record' , 'Bill #'+inttostr(qryBillsPurchaseOrderID.asInteger) );
    ErrMsg:=ReplaceStr(ErrMsg ,'Unable to update data.' , 'Unable To Import Cost From Bill #'+ inttostr(qryBillsPurchaseOrderID.asInteger));
    MessageDlgXP_Vista(ErrMsg, Mtwarning, [mbok],0);
    editDB(qryBills);
    qryBillsRelatedShipContainerIDUsed.asBoolean := False;
    PostDB(qryBills);
  end;
end;

procedure TfrmShipBillSelector.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  Iteraterecords(qryBills , CallBackApply);
end;

procedure TfrmShipBillSelector.CallBackApply(Sender: TDataset;var Abort: boolean);
begin
  if sender <> qrybills then exit;
  if qryBills.FieldByName('RelatedShipContainerIdUsed').AsString = 'T' then exit;
  EditDB(qrybills);
  qryBills.FieldByName('RelatedShipContainerIdUsed').AsString := 'T';
  PostDB(Qrybills);

end;

initialization
  RegisterClassOnce(TfrmShipBillSelector);
end.
