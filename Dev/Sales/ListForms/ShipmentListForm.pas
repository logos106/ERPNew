unit ShipmentListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, IntegerListObj, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TShipmentProcessedType = (sptAny, sptNotProcessed, sptProcessed);

  TShipmentListFormGUI = class(TBaseListingGUI)
    qryMainShipmentListId: TIntegerField;
    qryMainShipmentListStatus: TWideStringField;
    qryMainSaleType: TWideStringField;
    qryMainSaleRefNo: TWideStringField;
    qryMainSaleId: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainSaleStatus: TWideStringField;
    qryMainShipmentId: TIntegerField;
    qryMainProvidorType: TIntegerField;
    qryMainMasterTrackingNumber: TWideStringField;
    qryMainShipmentProcessed: TWideStringField;
    qryMainRecipientCompany: TWideStringField;
    qryMainRecipientFirstName: TWideStringField;
    qryMainRecipientLastName: TWideStringField;
    qryMainRecipientAddress1: TWideStringField;
    qryMainRecipientAddress2: TWideStringField;
    qryMainRecipientCity: TWideStringField;
    qryMainRecipientState: TWideStringField;
    qryMainRecipientPostCode: TWideStringField;
    qryMainRecipientCountryCode: TWideStringField;
    qryMainProviderName: TStringField;
    rgType: TRadioGroup;
    btnPicking: TDNMSpeedButton;
    btnShipSelected: TDNMSpeedButton;
    btnPrintLabels: TDNMSpeedButton;
    qryMainErrorMessage: TWideMemoField;
    chkShipLabels: TCheckBox;
    Label2: TLabel;
    chkAddressLabels: TCheckBox;
    Label4: TLabel;
    qryMainNoOfBoxes: TLargeintField;
    qryMainDetailType: TLargeintField;
    qryMainPackageWeight: TWideStringField;
    qryMainPackageWeightFrac: TWideStringField;
    qryMainPackageBaseCharge: TFloatField;
    qryMainPackageCODAmount: TFloatField;
    qryMainPackageCODType: TIntegerField;
    qryMainPackageDangerousGoodsAccessible: TWideStringField;
    qryMainPackageDescription: TWideStringField;
    qryMainPackageHeight: TIntegerField;
    qryMainPackageInsuredValue: TFloatField;
    qryMainPackageLength: TIntegerField;
    qryMainPackageNetCharge: TFloatField;
    qryMainPackageType: TIntegerField;
    qryMainPackageReference: TWideStringField;
    qryMainPackageReturnRecpt: TWideMemoField;
    qryMainPackageSignatureType: TIntegerField;
    qryMainPackageSpecialService: TIntegerField;
    qryMainPackageTotalDiscount: TFloatField;
    qryMainPackageTotalSurcharges: TFloatField;
    qryMainPackageTrackingNumber: TWideStringField;
    qryMainPackageWidth: TIntegerField;
    qryMainPackageCODTypeDesc: TStringField;
    qryMainPackageTypeDesc: TStringField;
    qryMainPackageSignatureTypeDesc: TStringField;
    rgDetailType: TRadioGroup;
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grpFiltersClick(Sender: TObject); override;
    procedure grdMainDblClick(Sender: TObject); override;
    procedure rgTypeClick(Sender: TObject);
    procedure btnPickingClick(Sender: TObject);
    procedure btnShipSelectedClick(Sender: TObject);
    procedure btnPrintLabelsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rgDetailTypeClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
    procedure GetSelectList(IdList: TIntegerList; ShipmentProcessedType: TShipmentProcessedType = sptAny);
    procedure ProcessShipments;
    procedure PrintShippingLabels;
  protected
    procedure RefreshQuery; override;
    procedure ApplyQueryFilter; override;
    function GetReportTypeID: integer; override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
    procedure ReadnApplyGuiPrefExtra; override;//virtual;
    Procedure WriteGuiPrefExtra; override; //virtual;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses
  ShipIntegrationTypes, ibxezship, BaseInputForm, CommonLib, BusObjShipment,
  ReportTemplateBase, TempTableUtils, CommonDbLib, SalesLib, tcDataUtils;

procedure TShipmentListFormGUI.ApplyQueryFilter;
begin
  GroupFilterString := '';
  case rgDetailType.ItemIndex of
    0:
      begin { Summary }
        GroupFilterString := '(DetailType = 0)';
      end;
    1:
      begin { Detail }
        GroupFilterString := '';
      end;
  end;
  inherited;
end;

procedure TShipmentListFormGUI.btnPickingClick(Sender: TObject);
var
  IdList: TIntegerList;
  SQL: string;
begin
  inherited;
  if grdMain.SelectedList.Count = 0 then exit;
  IdList := TIntegerList.Create;
  try
    GetSelectList(IdList, sptAny);

    ReportSQLSupplied := false;
    SQL := ' ~|||~ and tblshipment.ShipmentId IN (' + IdList.CommaText + ')';
    PrintTemplateReport('Package Ship Picking', SQL, not chkPreview.Checked, 1);

  finally
    IdList.Free;
  end;
end;

procedure TShipmentListFormGUI.btnPrintLabelsClick(Sender: TObject);
begin
  inherited;
  PrintShippingLabels;
end;

procedure TShipmentListFormGUI.btnShipSelectedClick(Sender: TObject);
begin
  inherited;
  ProcessShipments;
end;

procedure TShipmentListFormGUI.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('PackageCODType,PackageType,PackageSignatureType,DetailType,ShipmentSpecialServices');
end;

function TShipmentListFormGUI.GetReportTypeID: integer;
begin
  //result := 136;
  result := TemplateTypeID('Shipping');
end;

procedure TShipmentListFormGUI.GetSelectList(IdList: TIntegerList;
  ShipmentProcessedType: TShipmentProcessedType);
var
  x: integer;
  bm: TBookmark;
begin
  IdList.Clear;
  if grdMain.SelectedList.Count = 0 then exit;
  bm := qryMain.GetBookmark;
  try
    qryMain.DisableControls;
    try
      for x := 0 to grdMain.SelectedList.Count -1 do begin
        qryMain.GotoBookmark(grdMain.SelectedList[x]);
        if (ShipmentProcessedType = sptAny) or
          ((ShipmentProcessedType = sptNotProcessed) and (not qryMainShipmentProcessed.AsBoolean)) or
          ((ShipmentProcessedType = sptProcessed) and qryMainShipmentProcessed.AsBoolean)  then

        IdList.Add(qryMainShipmentId.AsInteger);
      end;
    finally
      qryMain.GotoBookmark(bm);
      qryMain.EnableControls;
    end;
  finally
    qryMain.FreeBookmark(bm);
  end;
end;

procedure TShipmentListFormGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if rgDetailType.ItemIndex = 1 then begin
    if qryMainDetailType.AsInteger = 0 then
      AFont.Style := AFont.Style + [fsBold];
  end;
end;

procedure TShipmentListFormGUI.grdMainDblClick(Sender: TObject);
var
  form: TBaseInputGUI;
begin
//  inherited;
  form:= nil;
  if (grdMain.SelectedField = qryMainErrorMessage) then begin
    { memo .. don't open form }
  end
  else if (grdMain.SelectedField = qryMainSaleType) or
     (grdMain.SelectedField = qryMainSaleRefNo) or
     (grdMain.SelectedField = qryMainSaleId) then begin
    if SameText(qryMainSaleType.AsString, 'Sales Order') then
      form := TBaseInputGUI(GetComponentByClassName('TSalesOrderGUI',false))
    else if SameText(qryMainSaleType.AsString, 'Invoice') then
      form := TBaseInputGUI(GetComponentByClassName('TInvoiceGUI',false));
  end
  else
    form := TBaseInputGUI(GetComponentByClassName('TfmShippingAllocation',false));

  if not Assigned(form) then exit;
  form.KeyID := qryMainSaleId.AsInteger;
  form.FormStyle := fsMDIChild;
  form.BringToFront;
end;

procedure TShipmentListFormGUI.grpFiltersClick(Sender: TObject);
begin
  //inherited;
  RefreshQuery;
end;

procedure TShipmentListFormGUI.IterateselectedRecordsCallback(
  var Abort: boolean; SelIndex: Integer);
var
  noofBoxes: integer;
begin
  inherited;
  if IterateProcNo = 1 then begin
    ReportSQLSupplied := true;
    try
      noofBoxes := CustomInputInteger('No of Lables' , 'Specify the number of labels to be printed for ' +#13#10+
        QrymainSaleType.asString +' # ' + inttostr(QrymainsaleID.asInteger) +#13#10+'for ' +quotedstr(Qrymaincustomername.asString) , inttostr(qryMainnoofboxes.AsInteger));
      if noofBoxes <=0 then exit;
      PrintTemplateReport('Address Labels', SalesAddressLabelSQL(noofBoxes, QrymainSaleID.AsInteger), not(chkPreview.Checked) and not(devmode), 1);
    finally
      ReportSQLSupplied := False;
    end;
  end;
end;

procedure TShipmentListFormGUI.PrintShippingLabels;
var
  repName: string;
  SQL: string;
  tmpTableName: string;
  IdList: TIntegerList;
begin
  if (not chkAddressLabels.Checked) and (not chkShipLabels.Checked) then begin
    CommonLib.MessageDlgXP_Vista('Please Select Ship Labels and / or Address Lables',mtInformation,[mbOk],0);
    exit;
  end;

  if chkAddressLabels.Checked then begin
    IterateProcNo := 1;
    IterateselectedRecords;
  end;

  if chkShipLabels.Checked then begin
    TReportTemplateBase.GetDefaultReportSQL('Shipping',repName,SQL);
    if chkChooseRpt.Checked then begin
      LoadReportTypes;
      if dlgReportSelect.Execute then begin
        repName := dlgReportSelect.SelectedItems.Text;
      end
      else
        exit;
    end;

    IdList := TIntegerList.Create;
    try
      self.GetSelectList(IdList, sptProcessed);
      if IdList.Count = 0 then begin
        CommonLib.MessageDlgXP_Vista('There where no Processed items selected',mtInformation,[mbOk],0);
        exit;
      end;

      tmpTableName := BusObjShipment.PrepareLabelTempTable('',IdLIst.CommaText , CommonDbLib.GetSharedMyDacConnection);
(*      SQL := SQL + {' and tmp_tblshipmentprint.shipmentlistid = ' + IntToStr(ShipmentList.ID) +}
         ' order by T.ShipmentListId, T.ShipmentId, T.ShipmentPackageId';*)
      SQL := SQL + ' order by T.ShipmentPackageId';
      SQL := ReplaceStr(Lowercase(SQL), 'tmp_tblshipmentprint', tmpTableName);
      ReportSQLSupplied := true;
      PrintTemplateReport(repName, SQL, not chkPreview.Checked, 1);
      ReportSQLSupplied := false;

    finally
      IdList.Free;
      (*if tmpTableName <> '' then
        DropTemporyTables(tmpTableName, CommonDbLib.GetSharedMyDacConnection);*)
    end;
  end;

end;

procedure TShipmentListFormGUI.ProcessShipments;
var
  IdList: TIntegerList;
  Shipment: TShipment;
  dlg: TProgressDialog;
  x: integer;
begin
  IdList := TIntegerList.Create;
  dlg := TProgressDialog.Create(nil);
  try
    self.GetSelectList(IdList, sptNotProcessed);
    if IdList.Count = 0 then begin
      CommonLib.MessageDlgXP_Vista('There where no Un-Processed items selected',mtInformation,[mbOk],0);
      exit;
    end;
    Shipment := TShipment.CreateWithNewConn(nil);
    try
      Shipment.SilentMode := true;
      dlg.Caption := 'Processing Shipments';
      dlg.MaxValue := IdList.Count;
      dlg.Value := 1;
      dlg.Execute;
      for x := 0 to IdList.Count -1 do begin
        Shipment.Load(IdList[x]);
        Shipment.Connection.BeginTransaction;
        try
          Shipment.Ship;
          Shipment.PostDb;
          TShipmentList.UpdateStatus(Shipment.Id, Shipment.Connection.Connection);
          Shipment.Connection.CommitTransaction;
        except
          on e: exception do begin
            Shipment.ProcessedComment := e.Message;
            Shipment.PostDB;
            Shipment.Connection.CommitTransaction;
          end;
        end;

        dlg.StepIt;
      end;

      self.RefreshQuery;
    finally
      Shipment.Free;
    end;
  finally
    IdList.Free;
    dlg.Free;
  end;

end;

procedure TShipmentListFormGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  if qryMainProvidorType.AsInteger > 0 then
    qryMainProviderName.AsString := ProviderTypeToStr(TibxezshipProviders(qryMainProvidorType.AsInteger));

  if qryMainPackageCODType.IsNull then
    qryMainPackageCODTypeDesc.Clear
  else
    qryMainPackageCODTypeDesc.AsString := PackageCODTypeToStr(TibxezshipPackageCODTypes(qryMainPackageCODType.AsInteger));

  if qryMainPackageType.IsNull then
    qryMainPackageTypeDesc.Clear
  else
    qryMainPackageTypeDesc.AsString := PackageTypeToStr(TibxezshipPackageTypes(qryMainPackageType.AsInteger));

  if qryMainPackageSignatureType.IsNull then
    qryMainPackageSignatureTypeDesc.Clear
  else
    qryMainPackageSignatureTypeDesc.AsString := SignatureTypeToStr(TibxezshipPackageSignatureTypes(qryMainPackageSignatureType.AsInteger));
end;

procedure TShipmentListFormGUI.ReadnApplyGuiPrefExtra;
begin
  if GuiPrefs.Node.Exists('Options.DetailType') then begin
    rgDetailType.ItemIndex := GuiPrefs.Node['Options.DetailType'].asInteger;
  end;
end;

procedure TShipmentListFormGUI.RefreshQuery;
begin
  case grpFilters.ItemIndex of
    0: qryMain.ParamByName('ProcStatus').AsString := 'Not Processed';
    1: qryMain.ParamByName('ProcStatus').AsString := 'Processed';
    2: qryMain.ParamByName('ProcStatus').AsString := 'All';
  end;
  case rgType.ItemIndex of
    0: qryMain.ParamByName('SaleType').AsString := 'Invoice';
    1: qryMain.ParamByName('SaleType').AsString := 'SO';
    2: qryMain.ParamByName('SaleType').AsString := 'Both';
  end;

  if chkIgnoreDates.Checked then begin
    qryMain.ParamByName('DateFrom').AsDateTime := 0;
    qryMain.ParamByName('DateTo').AsDateTime := MaxDateTime;
  end
  else begin
    qryMain.ParamByName('DateFrom').AsDateTime := dtFrom.DateTime;
    qryMain.ParamByName('DateTo').AsDateTime := dtTo.DateTime;
  end;
  inherited;
  ApplyQueryFilter;
end;

procedure TShipmentListFormGUI.rgDetailTypeClick(Sender: TObject);
begin
  inherited;
  ApplyQueryFilter;
end;

procedure TShipmentListFormGUI.rgTypeClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TShipmentListFormGUI.WriteGuiPrefExtra;
begin
  GuiPrefs.Node['Options.DetailType'].asInteger := rgDetailType.ItemIndex;
end;

initialization
  RegisterClass(TShipmentListFormGUI);

end.
