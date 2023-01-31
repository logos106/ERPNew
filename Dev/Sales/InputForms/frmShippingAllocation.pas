unit frmShippingAllocation;

interface
{$I ERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ExtCtrls, StdCtrls, Shader, DNMPanel, DNMSpeedButton,
  BusObjShipment, wwDbGrid, IntegerListObj, BusObjBase, Mask, DBCtrls,
  wwcheckbox;

type
  TfmShippingAllocation = class(TBaseInputGUI)
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    ScrollBox1: TScrollBox;
    btnNew: TDNMSpeedButton;
    qryShipmentList: TERPQuery;
    dsShipmentList: TDataSource;
    edtStatus: TDBEdit;
    Label1: TLabel;
    btnProcessAll: TDNMSpeedButton;
    lblInfo: TLabel;
    btnPrintLabels: TDNMSpeedButton;
    chkPreview: TwwCheckBox;
    btnPrintPicking: TDNMSpeedButton;
    chkChooseRpt: TwwCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure ScrollBox1Resize(Sender: TObject);
    procedure btnProcessAllClick(Sender: TObject);
    procedure btnPrintLabelsClick(Sender: TObject);
    procedure btnPrintPickingClick(Sender: TObject);
    procedure tmrOnshowTimer(Sender: TObject);
  private
    AddressIdList: TIntegerList;
    ShipmentList: TShipmentList;
    fSaleId: integer;
    ProgDlg: TProgressDialog;
    tmpTableName: string;
    procedure DoOnDelete(Sender: TObject);
    procedure DoOnQtyChange(Sender: TObject);

    procedure AddressListOnGridDataSelect(Sender: TwwDbGrid);
    procedure RefreshPanels;
    procedure CreateShipmentsFromShipAddresses;
    procedure DoAutoAllocation;
    procedure ValidateShipmentAddress(Shp: TShipment; ErrorList: TStringList);
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure SetKeyId(const Value: integer); override;
    function GetReportTypeID: integer; override;
  public
    property SaleId: integer read fSaleId write fSaleId;
  end;

implementation

uses
  BusObjSaleBase, ShipAddressListForm, CommonLib, ibxezship, ibxezaddress,
  ShipIntegrationUtils, fraShipment, CommonDbLib, DNMExceptions, BusObjConst,
  MemoDialog, AppEnvironment, ShipAddressValidationObj, TempTableUtils,
  DbSharedObjectsObj, ReportTemplateBase,
  ibxupsship, SystemLib, tcDataUtils, BusObjShippingAddress,
  ShipIntegrationTypes, LogLib;

{$R *.dfm}

procedure TfmShippingAllocation.AddressListOnGridDataSelect(Sender: TwwDbGrid);
var
  x: integer;
begin
  { get list of selected addresses }
  Sender.DataSource.DataSet.DisableControls;
  for x := 0 to Sender.SelectedList.Count -1 do begin
    Sender.DataSource.DataSet.GotoBookmark(Sender.SelectedList[x]);
    AddressIdList.AddIfNotInList(Sender.DataSource.DataSet.FieldByName('ShipAddressId').AsInteger);
  end;
end;

procedure TfmShippingAllocation.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmShippingAllocation.btnNewClick(Sender: TObject);
begin
  inherited;
  CreateShipmentsFromShipAddresses;
  if AddressIdList.Count > 0 then
    RefreshPanels;
end;

procedure TfmShippingAllocation.btnPrintLabelsClick(Sender: TObject);
var
  repName: string;
  SQL: string;
begin
  inherited;
  TReportTemplateBase.GetDefaultReportSQL('Shipping',repName,SQL);
  if chkChooseRpt.Checked then begin
    LoadReportTypes;
    if dlgReportSelect.Execute then
      repName := dlgReportSelect.SelectedItems.Text;
  end;
  if repName = '' then exit;

  tmpTableName := BusObjShipment.PrepareLabelTempTable(IntToStr(ShipmentList.ID),'',MyConnection);


  SQL := SQL + ' where T.shipmentlistid = ' + IntToStr(ShipmentList.ID) + ' order by T.ShipmentPackageId';
  SQL := ReplaceStr(Lowercase(SQL), 'tmp_tblshipmentprint', tmpTableName);
  fbReportSQLSupplied := true;
  PrintTemplateReport(repName, SQL, not chkPreview.Checked, 1);
  fbReportSQLSupplied := false;
//  DestroyUserTemporaryTable(CommonDbLib.GetSharedMyDacConnection, tmpTableName);
  tmpTableName := '';
end;

procedure TfmShippingAllocation.btnPrintPickingClick(Sender: TObject);
var
  SQL: string;
  qry: TERPQuery;
begin
  inherited;
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := Shipmentlist.Connection.Connection;
    qry.SQL.Add('select count(*)');
    qry.SQL.Add('from tblshipment');
    qry.SQL.Add('inner join tblshipmentsaleline on tblshipment.ShipmentId = tblshipmentsaleline.ShipmentId');
    qry.SQL.Add('where tblshipment.ShipmentListId = ' + IntToStr(Shipmentlist.ID));
    qry.SQL.Add('and ifnull(tblshipmentsaleline.UOMQty,0) <> 0');
    qry.Open;
    if qry.Fields[0].AsInteger = 0 then begin
      CommonLib.MessageDlgXP_Vista('Nothing has been allocated to ship.',mtInformation,[mbOk],0);
      exit;
    end;
  finally
    qry.Free;
  end;

  fbReportSQLSupplied := false;
  SQL := ' ~|||~ and SHL.ShipmentListId = ' + IntToStr(shipmentlist.ID);
  PrintTemplateReport('Package Ship Picking', SQL, not chkPreview.Checked, 1);
end;

procedure TfmShippingAllocation.btnProcessAllClick(Sender: TObject);
var
  dlg: TProgressDialog;
  sl: TStringList;
  x: integer;
begin
  inherited;
  DisableForm;
  sl := TStringList.Create;
  try
    { first make sure all address are valid }
    ShipmentList.Shipments.Dataset.DisableControls;
    try
      ShipmentList.Shipments.First;
      while not ShipmentList.Shipments.EOF do begin
        if (not ShipmentList.Shipments.Processed) and (not ShipmentList.Shipments.RecipientAddressValid) then
          self.ValidateShipmentAddress(ShipmentList.Shipments,sl);
        ShipmentList.Shipments.Next;
      end;
    finally
      ShipmentList.Shipments.Dataset.EnableControls;
    end;
    if sl.Count > 0 then begin
      sl.Insert(0,'');
      sl.Insert(0,'The following Recipient addresses could not be validated:');
      DoMemoDialog('Invalid Recipient Addresses',sl.Text,ssBoth);
      exit;
    end;

    { now do shipments }
    sl.Clear;
    self.CommitTransaction;
    try
      dlg := TProgressDialog.Create(nil);
      ShipmentList.SilentMode := true;
      try
        dlg.Caption := 'Processing Shipments';
        dlg.MaxValue := 100;
        dlg.TimerUpdate := true;
        dlg.Execute;

        ShipmentList.ShipAll(sl);
        btnProcessAll.Enabled := ShipmentList.Status <> 'Processed';

        for x := 0 to ScrollBox1.ControlCount - 1 do
          TfrShipment(ScrollBox1.Controls[x]).UpdateGui;
      finally
        dlg.Free;
        ShipmentList.SilentMode := false;
      end;
      if sl.Count > 0 then begin
        sl.Insert(0,'');
        sl.Insert(0,'The following Shipments could not be processed:');
        DoMemoDialog('Shipment Processing Errors',sl.Text,ssBoth);
      end;
    finally
      self.BeginTransaction;
    end;
  finally
    sl.Free;
    EnableForm;
  end;
end;

procedure TfmShippingAllocation.btnSaveClick(Sender: TObject);
var
  x: integer;
begin
  inherited;
  if ShipmentList.Save then begin
    ShipmentList.UpdateStatus(ShipmentList);
    ShipmentList.PostDb;
    self.CommitTransaction;
    close;
  end
  else begin
    { was the problem with a shipment .. }
    if ShipmentList.InvalidShipmentId > 0 then begin
      { heighlight the invalid one }
      for x := 0 to ScrollBox1.ControlCount -1 do begin
        if TfrShipment(ScrollBox1.Controls[x]).Shipment.ID = ShipmentList.InvalidShipmentId then begin
          TfrShipment(ScrollBox1.Controls[x]).OnClick(ScrollBox1.Controls[x]);
          ScrollBox1.ScrollInView(ScrollBox1.Controls[x]);
          break;
        end;
      end;
    end;
  end;
end;

procedure TfmShippingAllocation.CreateShipmentsFromShipAddresses;
var
//  ClientId: integer;
  form: TShipAddressListGUI;
  x: integer;

  Provider: TibxezshipProviders;
  ServiceType: TibxezshipServiceTypes;
  ClientShipperAccountNo: string;
  aPayorType :String;

  ClientBillCountryCode: string;
  ClientBillPostcode: string;
begin
  { need to get user to select which addresses to ship to so we can create shipments }
  AddressIdList.Clear;
  form := TShipAddressListGUI(CommonLib.GetComponentByClassName(TShipAddressListGUI.ClassName,false));
  form.CustomerID := TSalesBase.SaleClientId(SaleId);
  form.OnGridDataSelect := AddressListOnGridDataSelect;
  form.ShipAddressIdsAlreadySelected := ShipmentList.GetShipAddressIdList;
  form.EnableMultiSelect('');
  if form.ShowModal = mrOk then begin
    { add the selected addresses }
    if AddressIdList.Count > 0 then begin
      Provider := SaleShipProvider(SaleId, ServiceType, ClientShipperAccountNo, ClientBillCountryCode, ClientBillPostcode , aPayorType);
      for x := 0 to AddressIdList.Count -1 do begin
        ShipmentList.Shipments.New;
        ShipmentList.Shipments.Provider := Provider;
        ShipmentList.Shipments.ServiceType := ServiceType;
        if aPayorType <> '' then ShipmentList.Shipments.PayorType := StrToPayorType(aPayorType);
        ShipmentList.Shipments.ShipAddressId := AddressIdList[x];
        ShipmentList.Shipments.RecipientAddressValid := TShippingAddress.IsAddressValidated(AddressIdList[x]);
        if ClientShipperAccountNo <> '' then begin
          ShipmentList.Shipments.PayorAccountNumber := ClientShipperAccountNo;
          ShipmentList.Shipments.PayorType := ibxezship.ptRecipient;
          if Provider = TibxezshipProviders.pUPS then
            ShipmentList.Shipments.PayorZipCode := ClientBillPostcode;
        end;
        ShipmentList.Shipments.PostDb;
        { create at least one new package line }
        ShipmentList.Shipments.Packages.New;
        ShipmentList.Shipments.Packages.PackageType := ShipIntegrationUtils.DefaultPackageType(Provider);
        try
          ShipmentList.Shipments.Packages.PostDb;
        except

        end;
      end;
      ShipmentList.UpdatePackageReferences(TSalesBase.CustPONumberForSaleID(SaleId));
      RefreshPanels;
    end;
  end;

end;

procedure TfmShippingAllocation.DoAutoAllocation;
var
  qry: TERPQuery;
  prog: TProgressDialog;
begin
  qry := TERPQuery.Create(nil);
  prog := TProgressDialog.Create(nil);
  try
    prog.Caption := 'Auto Allocation';
    prog.Message := 'Please wait ..';
    prog.MaxValue := ShipmentList.Shipments.Count;
    prog.Step := 1;
    prog.Execute;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select (UnitOfMeasureShipped div ' + IntToStr(ShipmentList.NonCanceledCount) + ') as UOMQty,');
    qry.SQL.Add('SaleLineId');
    qry.SQL.Add('from tblsaleslines');
    qry.SQL.Add('where SaleId = ' + IntToStr(SaleId));
    qry.Open;
    ShipmentList.Shipments.Dataset.DisableControls;
    try
      ShipmentList.Shipments.First;
      while not ShipmentList.Shipments.EOF do begin
        qry.First;
        while not qry.Eof do begin
          ShipmentList.Shipments.SalesLines.New;
          ShipmentList.Shipments.SalesLines.SaleLineId := qry.FieldByName('SaleLineId').AsInteger;
          ShipmentList.Shipments.SalesLines.UOMQty := qry.FieldByName('UOMQty').AsFloat;
          ShipmentList.Shipments.SalesLines.PostDb;
          qry.Next;
        end;
        ShipmentList.Shipments.PostDb;
        prog.StepIt;
        ShipmentList.Shipments.Next;
      end;
    finally
      ShipmentList.Shipments.Dataset.EnableControls;
    end;
  finally
    qry.Free;
    prog.Free;
  end;
end;

procedure TfmShippingAllocation.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited ;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TShipmentList then TShipment(Sender).DataSet:= qryShipmentList;
  end;
end;

procedure TfmShippingAllocation.DoOnDelete(Sender: TObject);
var
  msgOption: integer;
begin
  msgOption:= MessageDlgXP_Vista('Do You Wish To Delete This Line or Delete all Lines?', mtConfirmation,[] , 0 ,nil , '' , '' , False, nil , 'This Line,All Lines,Cancel' );
  case msgOption of
    100:
      begin
        if TfrShipment(Sender).Shipment.Processed then begin
          MessageDlgXP_Vista('Can not delete this Shipment, it has allready been processed.', mtInformation,[mbOk], 0);
          exit;
        end;
        ProgDlg:= TProgressDialog.Create(nil);
        ProgDlg.Caption := 'Deleting';
        ProgDlg.MaxValue := 10;
        ProgDlg.TimerUpdate := true;
        ProgDlg.Execute;
        TfrShipment(Sender).Shipment.Active := false;
        TfrShipment(Sender).Shipment.PostDb;
      end;
    101:
      begin
        ProgDlg:= TProgressDialog.Create(nil);
        ProgDlg.Caption := 'Deleting';
        ProgDlg.MaxValue := 10;
        ProgDlg.TimerUpdate := true;
        ProgDlg.Execute;
        ShipmentList.Shipments.Dataset.DisableControls;
        try
          ShipmentList.Shipments.DoFieldChangewhenDisabled := true;
          ShipmentList.Shipments.First;
          while not ShipmentList.Shipments.EOF do begin
            if not ShipmentList.Shipments.Processed then begin
              ShipmentList.Shipments.Active := false;
              ShipmentList.Shipments.PostDb;
            end;
            ShipmentList.Shipments.Next;
          end;
        finally
          ShipmentList.Shipments.Dataset.EnableControls;
        end;
      end;
    102: exit;
  end;
  self.DoDelayObjectProcedure(RefreshPanels,10, Self.classname +'.RefreshPanels');
//  self.RefreshPanels;
end;

procedure TfmShippingAllocation.DoOnQtyChange(Sender: TObject);
var
  x: integer;
begin
  for x := 0 to ScrollBox1.ControlCount -1 do begin
    if (ScrollBox1.Controls[x] is TfrShipment) and (ScrollBox1.Controls[x] <> Sender) then begin
      TfrShipment(ScrollBox1.Controls[x]).qrySaleLine.Refresh;
    end;
  end;
end;

procedure TfmShippingAllocation.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  self.RollbackTransaction;
  self.Notify(false);
  Action := caFree;
end;

procedure TfmShippingAllocation.FormCreate(Sender: TObject);
begin
  inherited;
  AddressIdList := TIntegerList.Create;
  tmpTableName := '';
  //
end;

procedure TfmShippingAllocation.FormDestroy(Sender: TObject);
begin
  inherited;
  AddressIdList.Free;
  ShipmentList.Free;
  if tmpTableName <> '' then
    DropTemporyTables(tmpTableName, CommonDbLib.GetSharedMyDacConnection);
end;

procedure TfmShippingAllocation.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      self.RollbackTransaction;
      self.BeginTransaction;
      ShipmentList := TShipmentList.Create(nil, MyConnection);
      ShipmentList.BusObjEvent := DoBusinessObjectEvent;
      ShipmentList.LoadSelect('SaleId = ' + IntToStr(SaleId));
      if accesslevel < 3 then begin
        if ShipmentList.Count = 0 then begin
          ShipmentList.New;
          ShipmentList.SaleId := SaleId;
          ShipmentList.PostDb;
        end;
        if ShipmentList.NonCanceledCount = 0 then begin    //Shipments.Count = 0 then begin
          CreateShipmentsFromShipAddresses;
          { auto allocation }
          DoAutoAllocation;
        end;
      end;
      RefreshPanels;
      // Exception Handler
    except
      // Handle these known exceptions.
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
end;

function TfmShippingAllocation.GetReportTypeID: integer;
begin
  result := TemplateTypeID('Shipping');
end;

procedure TfmShippingAllocation.RefreshPanels;
var
  frame, LastFrame: TfrShipment;
  found: boolean;
begin
  self.DisableForm;
  try
    if not Assigned(ProgDlg) then begin
      ProgDlg:= TProgressDialog.Create(nil);
      ProgDlg.Caption := 'Loading';
      ProgDlg.MaxValue := 10;
      ProgDlg.TimerUpdate := true;
      ProgDlg.Execute;
    end;
    found := false;
    while ScrollBox1.ControlCount > 0 do begin
      found := true;
      ScrollBox1.Controls[0].Free;
    end;
    if found then
      ShipmentList.RefreshDB; //  Dataset.Refresh;
    ShipmentList.Shipments.First;
    LastFrame := nil;
    clog('');
    while not ShipmentList.Shipments.EOF do begin
      frame := TfrShipment.Create(self);
      frame.Name := frame.ClassName + IntToStr(ScrollBox1.ControlCount);
      frame.Parent := ScrollBox1;
      frame.OnQtyChange := DoOnQtyChange;
      frame.OnDelete := DoOnDelete;
      frame.Left := 0;
      frame.Width := ScrollBox1.ClientWidth;
      frame.Shipment := ShipmentList.Shipments;
      if Assigned(LastFrame) then begin
        frame.Top := LastFrame.Top + LastFrame.Height;
        frame.Height := Lastframe.Height;
      end
      else begin
        frame.Top := 0;
        if frame.qrySaleLine.RecordCount > 1 then
          frame.Height := frame.Height +
            frame.grdSaleLine.RowHeights[0] * (frame.qrySaleLine.RecordCount -1);
      end;
      frame.AccessLevel := Self.accesslevel;
      LastFrame := frame;
      ShipmentList.Shipments.Next;
    end;
  finally
    FreeAndNil(ProgDlg);
    self.EnableForm;
  end;
  if ScrollBox1.ControlCount = 0 then begin
    lblInfo.Visible := true;
    ScrollBox1.Margins.bottom :=3;
    //lblInfo.Top := 500;
    //ScrollBox1.Height := 420;
  end
  else begin
    lblInfo.Visible := false;
    ScrollBox1.Margins.bottom :=lblInfo.Margins.bottom;
    //lblInfo.Top := 500;
    //ScrollBox1.Height := 450;
  end;

  btnProcessAll.Enabled := (ShipmentList.Status <> 'Processed') and
    ((AppEnv.CompanyPrefs.AllowShipmentsFromSalesOrder and SameText(ShipmentList.SaleType,'Sales Order')) or
    SameText(ShipmentList.SaleType,'Invoice'));
end;

procedure TfmShippingAllocation.ScrollBox1Resize(Sender: TObject);
var
  x: integer;
begin
  inherited;
  for x := 0 to ScrollBox1.ControlCount -1 do
    ScrollBox1.Controls[x].Width := ScrollBox1.ClientWidth;
end;

procedure TfmShippingAllocation.SetKeyId(const Value: integer);
begin
  inherited;
  SaleId := Value;
end;

procedure TfmShippingAllocation.ValidateShipmentAddress(Shp: TShipment;
  ErrorList: TStringList);
var
  val: TShipAddressValidation;
begin
  val := TShipAddressValidation.Create;
  try
    val.Providers := [TibxezaddressProviders(Shp.Provider)];
    val.Address.AddressLine1 := Shp.RecipientAddress1;
    val.Address.AddressLine2 := Shp.RecipientAddress2;
    val.Address.City := Shp.RecipientCity;
    val.Address.State := Shp.RecipientState;
    val.Address.PostCode := Shp.RecipientZipCode;
    val.Address.CountryCode := Shp.RecipientCountryCode;
    if Length(Shp.RecipientPhone) < 10 then
      val.ErrMessage := 'Phone Number must be at least 10 alphanumeric characters long.';
    val.Address.Updated := false;

    if (val.ErrMessage = '') and val.ValidateAddress then begin
      { only update if somthing changed }
      if val.Address.Updated or (not Shp.RecipientAddressValid) then begin
        { update the address }
        Shp.RecipientAddress1 := val.Address.AddressLine1;
        Shp.RecipientAddress2 := val.Address.AddressLine2;
        Shp.RecipientCity := val.Address.City;
        Shp.RecipientState := val.Address.State;
        Shp.RecipientZipCode := val.Address.PostCode;
        Shp.RecipientCountryCode := val.Address.CountryCode;
        Shp.RecipientAddressValid := true;
        Shp.PostDb;
        { try and update the Customers Shipping Address object }
        if Shp.ShippingAddress.Lock then begin
          Shp.UpdateShippingAddress;
          Shp.ShippingAddress.AddressValidated := true;
          Shp.ShippingAddress.PostDb;
        end;
      end;
    end
    else if val.ErrMessage <> '' then begin
      if not Assigned(ErrorList) then begin
//        CommonLib.MessageDlgXP_Vista(val.ErrMessage,mtWarning,[mbOk],0);
        if CommonLib.MessageDlgXP_Vista(val.ErrMessage + #13#10 +  #13#10 + 'Do you want to flag address as valid anyway?',mtWarning,[mbNo,mbYes],0) = mrYes then begin
          Shp.UpdateShippingAddress;
          Shp.ShippingAddress.AddressValidated := true;
          Shp.ShippingAddress.PostDb;
        end;
      end
      else begin
        if ErrorList.Count > 0 then ErrorList.Add('');
        ErrorList.Add(Shp.RecipientAddressAsSingleLine);
        ErrorList.Add('Error From ' + val.ErrMessage);
      end;
    end;
  finally
    val.Free;
  end;
end;
procedure TfmShippingAllocation.tmrOnshowTimer(Sender: TObject);
begin
  inherited; // disables the timer, do not remove
  if fitmrOnshowNo = 1 then begin
    btnProcessAll.Click;
    if not(btnProcessAll.Enabled) or (Devmode) then
      btnSave.click;
  end else if fitmrOnshowNo = 2 then begin
        if ScrollBox1.ControlCount >0 then
          TfrShipment(ScrollBox1.Controls[0]).btnEditShipment.click;
  end;
end;


initialization
  RegisterClass(TfmShippingAllocation);

end.
