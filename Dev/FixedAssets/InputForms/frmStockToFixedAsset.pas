unit frmStockToFixedAsset;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, wwcheckbox, DNMSpeedButton, Shader, DNMPanel,
  BusObjStockToAsset, Grids, Wwdbigrd, Wwdbgrid, Mask, wwdbedit, BusObjBase,
  wwdblook, ERPDbLookupCombo, Buttons;

type
  TfmStockToFixedAsset = class(TBaseInputGUI)
    pnlBottom: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    pnlTop: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryMain: TERPQuery;
    qryDetail: TERPQuery;
    qryMainGlobalRef: TWideStringField;
    qryMainStockToFixedAssetID: TIntegerField;
    qryMainCreationDate: TDateTimeField;
    qryMainProcessDate: TDateTimeField;
    qryMainProcessed: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainEmployeeID: TIntegerField;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainmsUpdateSiteCode: TWideStringField;
    qryDetailGlobalRef: TWideStringField;
    qryDetailStockToFixedAssetLineID: TIntegerField;
    qryDetailStockToFixedAssetID: TIntegerField;
    qryDetailProductName: TWideStringField;
    qryDetailProductID: TIntegerField;
    qryDetailProductType: TWideStringField;
    qryDetailAssetName: TWideStringField;
    qryDetailAssetCode: TWideStringField;
    qryDetailIsHireAsset: TWideStringField;
    qryDetailIsBatch: TWideStringField;
    qryDetailIsBin: TWideStringField;
    qryDetailIsSerialNumber: TWideStringField;
    qryDetailBatchNUmber: TWideStringField;
    qryDetailBatchExpiryDate: TDateTimeField;
    qryDetailSerialNumber: TWideStringField;
    qryDetailmsTimeStamp: TDateTimeField;
    qryDetailmsUpdateSiteCode: TWideStringField;
    edtDescription: TwwDBEdit;
    Label1: TLabel;
    dsMain: TDataSource;
    dsDetail: TDataSource;
    Label2: TLabel;
    edtCreationDate: TwwDBEdit;
    Label3: TLabel;
    edtEmployeeName: TwwDBEdit;
    chkProcessed: TwwCheckBox;
    Label4: TLabel;
    edtProcessDate: TwwDBEdit;
    grdLines: TwwDBGrid;
    btnSelect: TDNMSpeedButton;
    qryDetailBinNumber: TWideStringField;
    qryDetailBinLocation: TWideStringField;
    grdLinesIButton: TwwIButton;
    qryDetailAssetId: TIntegerField;
    qryDetailPurchaseDate: TDateField;
    qryDetailPurchaseCost: TFloatField;
    qryDetailDeptClassName: TWideStringField;
    cboDeptClass: TwwDBLookupCombo;
    qryDepClassLookup: TERPQuery;
    qryDepClassLookupClassName: TWideStringField;
    qryDepClassLookupClassID: TIntegerField;
    btnProcess: TDNMSpeedButton;
    qryDetailAssetType: TWideStringField;
    cboAssetType: TwwDBLookupCombo;
    qryAssetTypeLookup: TERPQuery;
    qryAssetTypeLookupAssetTypeCode: TWideStringField;
    qryAssetTypeLookupAssetTypeID: TIntegerField;
    qryMainStockAdjustEntryID: TIntegerField;
    btnStockAdjustment: TDNMSpeedButton;
    chkIsHire: TwwCheckBox;
    qryMainPurchaseOrderId: TIntegerField;
    qryDetailAssetDescription: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnProcessClick(Sender: TObject);
    procedure cboAssetTypeChange(Sender: TObject);
    procedure cboAssetTypeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure chkIsHireClick(Sender: TObject);
    procedure grdLinesDblClick(Sender: TObject);
    procedure grdLinesIButtonClick(Sender: TObject);
    procedure btnStockAdjustmentClick(Sender: TObject);
    procedure grdLinesColEnter(Sender: TObject);
  private
    StockToAsset: TStockToAsset;
    fPurchaseOrderId: integer;
//    Progress: TProgressDialog;
    procedure DoOnGridDataSelect(Sender: TwwDbGrid);
    function SaveData: boolean;
    function CreateFixedAssets: boolean;
    procedure SetAllAssetTypes(aAssetType: string);
    procedure AssetAfterShow(Sender: TObject);
    function GetPurchaseOrderId: integer;
  public
    procedure UpdateMe(const Cancelled: Boolean; const aObject: TObject = nil); override;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure EnableDisable; override;
  public
    property PurchaseOrderId: integer read GetPurchaseOrderId write fPurchaseOrderId;
  end;

implementation

uses
  BusObjConst, DNMExceptions, CommonLib, CommonFormLib,
  StockQtysLocationsReport, AppEnvironment, BusObjFixedAsset,
  DbSharedObjectsObj, frmFixedAsset, frmStockToFixedAssetQtyInput, FormFactory,
  CommonDbLib, POLineDetailList, tcConst;

{$R *.dfm}

procedure TfmStockToFixedAsset.AssetAfterShow(Sender: TObject);
begin
  if Sender is TfmFixedAsset then
    TfmFixedAsset(Sender).AttachObserver(self);
end;

procedure TfmStockToFixedAsset.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmStockToFixedAsset.btnProcessClick(Sender: TObject);
begin
  inherited;
  if StockToAsset.Lines.Count > 0 then begin
    DoShowProgressbar(StockToAsset.Lines.Count, WAITMSG);
    try
      CreateFixedAssets;
    finally
      DoHideProgressbar;
    end;
  end
  else
    CommonLib.MessageDlgXP_Vista('Please select products that you wish to create Fixed Assets from.',mtInformation,[mbOk],0);
end;

procedure TfmStockToFixedAsset.btnSaveClick(Sender: TObject);
begin
  if not StockToAsset.Processed then begin
    if CommonLib.MessageDlgXP_Vista('This has not been processed yet, would you like to process it now?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
      btnProcess.Click;
    end;
  end;
  if not SaveData then Exit;
  CommitTransaction;
  StockToAsset.Dirty := False;
  Notify;
  Close;
end;

procedure TfmStockToFixedAsset.btnSelectClick(Sender: TObject);
var
  StockQtysLocations: TStockQtysLocationsReportGUI;
  POLineDetail: TPOLineDetailListGUI;
begin
  inherited;
  self.HideHighlightControl;
  if PurchaseOrderID > 0 then begin
    POLineDetail := TPOLineDetailListGUI.Create(Application);
    POLineDetail.PurchaseOrderId := PurchaseOrderID;
    POLineDetail.OnGridDataSelect := DoOnGridDataSelect;
    POLineDetail.EnableMultiSelect('Please Select The Record(s) to Convert.  Multiple Records Can Be Selected In The List.');

    POLineDetail.FormStyle := fsMDIChild;
    POLineDetail.BringToFront;
  end
  else begin
    StockQtysLocations := TStockQtysLocationsReportGUI.Create(Application);
    StockQtysLocations.IncludeNonInventoryParts := true;
    StockQtysLocations.UseBoldInGrid := false;
    StockQtysLocations.OnGridDataSelect := DoOnGridDataSelect;
    StockQtysLocations.CustomFilterString := '(gLevel > 1) or (gLevel = 1 and Bin = "F" and Batch = "F" and SN = "F")';
    StockQtysLocations.DefaultGroupFilterItemIndex := 2;
    StockQtysLocations.FormStyle := fsMDIChild ;
    StockQtysLocations.BringToFront;
    StockQtysLocations.btnRequery.Click;
  end;
end;

procedure TfmStockToFixedAsset.btnStockAdjustmentClick(Sender: TObject);
begin
  inherited;
  if StockToAsset.StockAdjustEntryID > 0 then begin
    OpenERPForm('TfmStockAdjustEntryflat',StockToAsset.StockAdjustEntryID);
  end;

end;

procedure TfmStockToFixedAsset.cboAssetTypeChange(Sender: TObject);
begin
  inherited;
  if not cboAssetType.Focused then exit;
  SetAllAssetTypes(cboAssetType.Text);
end;

procedure TfmStockToFixedAsset.cboAssetTypeCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if not cboAssetType.Focused then exit;
  SetAllAssetTypes(cboAssetType.Text);
end;

procedure TfmStockToFixedAsset.chkIsHireClick(Sender: TObject);
begin
  inherited;
  if self.IsFlag('IsHire') then exit;
  if not chkIsHire.Focused then exit;

  self.AddFlag('IsHire');
  try
    if CommonLib.MessageDlgXP_Vista('Would you like to set all lines the same?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
      StockToAsset.SetAllIsHire(chkIsHire.Checked);
    end;
  finally
    self.RemoveFlag('IsHire');
  end;
end;

function TfmStockToFixedAsset.CreateFixedAssets: boolean;
var
  msg: string;
begin
  result := self.SaveData;
  if result then begin
    self.CommitTransaction;
    self.BeginTransaction;
    if StockToAsset.CreateFixedAssets(msg) then begin
      self.CommitTransaction;
      self.BeginTransaction;
      EnableDisable;
      CommonLib.MessageDlgXP_Vista('Fixed Asset(s) have been created.' ,mtInformation,[mbOk],0);
    end
    else begin
      self.RollbackTransaction;
      self.BeginTransaction;
      CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
    end;
  end
  else begin
  (*
    self.RollbackTransaction;
    self.BeginTransaction;
    *)
    exit;
  end;
end;

procedure TfmStockToFixedAsset.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TStockToAsset then
      TStockToAsset(Sender).DataSet := qryMain
    else if Sender is TStockToAssetLine then
      TStockToAssetLine(Sender).DataSet := qryDetail;
  end
  else if (Eventtype = BusobjEvent_ToDo) and (Value = BusobjEvent_ProgressbarProgress) then begin
    DoStepProgressbar;
  end;
end;

procedure TfmStockToFixedAsset.DoOnGridDataSelect(Sender: TwwDbGrid);
var
  i, x: integer;
  lastAssetCode: string;
  qry: TERPQuery;
  MaxQty: integer;
  NoStockList: string;
begin
  NoStockList := '';
  if StockToAsset.Lines.Count > 0 then begin
    qry := DbSharedObj.GetQuery(MyConnection);
    try
      qry.SQL.Add('select AssetCode from tblstocktofixedassetline where IfNull(AssetCode,"") <> ""');
      qry.SQL.Add('order by StockToFixedAssetLineID desc');
      qry.SQL.Add('limit 1');
      qry.Open;
      lastAssetCode := qry.FieldByName('AssetCode').AsString;
    finally
      DbSharedObj.ReleaseObj(qry);
    end;
  end
  else
    lastAssetCode := '';

  for i := 0 to Sender.SelectedList.Count - 1 do begin
    Sender.DataSource.DataSet.GotoBookmark(Sender.SelectedList.Items[i]);
      if Sender.DataSource.DataSet.FieldByName('SN').AsBoolean then
        MaxQty := 1
      else if SameText(Sender.DataSource.DataSet.FieldByName('PartType').AsString,'NONINV') then
        MaxQty := -1
      else
        MaxQty := Sender.DataSource.DataSet.FieldByName('Qty').AsInteger;
    if (MaxQty <> 0) then begin
      MaxQty := frmStockToFixedAssetQtyInput.GetQtyOfProduct(Sender.DataSource.DataSet.FieldByName('ProductName').AsString,MaxQty);
    end;

    if MaxQty  < 1 then begin
      if NoStockList <> '' then NoStockList := NoStockList + ', ';
      NoStockList := NoStockList + Sender.DataSource.DataSet.FieldByName('ProductName').AsString;
    end;

    for x := 0 to MaxQty -1 do begin
      StockToAsset.Lines.New;
      StockToAsset.Lines.ProductID := Sender.DataSource.DataSet.FieldByName('PartsId').AsInteger;
      StockToAsset.Lines.AssetName := StockToAsset.Lines.ProductName;
      lastAssetCode := TFixedAssets.NextAssetCode(lastAssetCode, MyConnection);
      StockToAsset.Lines.AssetCode := lastAssetCode;
      StockToAsset.Lines.ProductType := Sender.DataSource.DataSet.FieldByName('PartType').AsString;
      StockToAsset.Lines.IsBatch := Sender.DataSource.DataSet.FieldByName('Batch').AsBoolean;
      StockToAsset.Lines.IsBin := Sender.DataSource.DataSet.FieldByName('Bin').AsBoolean;
      StockToAsset.Lines.IsSerialNumber := Sender.DataSource.DataSet.FieldByName('SN').AsBoolean;

      if StockToAsset.Lines.IsBatch then begin
        StockToAsset.Lines.BatchNumber := Sender.DataSource.DataSet.FieldByName('BatchNumber').AsString;
        if Sender.DataSource.DataSet.FieldByName('ExpiryDate').AsString <> '' then
          StockToAsset.Lines.BatchExpiryDate := Sender.DataSource.DataSet.FieldByName('ExpiryDate').AsDateTime;
      end;
      if StockToAsset.Lines.IsBin then begin
        StockToAsset.Lines.BinNumber := Sender.DataSource.DataSet.FieldByName('BinNumber').AsString;
        StockToAsset.Lines.BinLocation := Sender.DataSource.DataSet.FieldByName('BinLocation').AsString;
      end;
      if StockToAsset.Lines.IsSerialNumber then begin
        StockToAsset.Lines.SerialNumber := Sender.DataSource.DataSet.FieldByName('SerialNumber').AsString;
      end;
      StockToAsset.Lines.PurchaseDate := Date;
      StockToAsset.Lines.PurchaseCost := Sender.DataSource.DataSet.FieldByName('Cost').AsFloat;
      StockToAsset.Lines.DeptClassName := AppEnv.DefaultClass.DefaultClassName;

      StockToAsset.Lines.PostDb;
    end;
  end;
  if NoStockList <> '' then
    CommonLib.MessageDlgXP_Vista('The following selected Product(s) can not be used as there is no stock available: ' + NoStockList,mtInformation,[mbOk],0);
end;

procedure TfmStockToFixedAsset.EnableDisable;
begin
  inherited;
  btnProcess.Enabled := (not StockToAsset.Processed) and (AccessLevel < 3);
  btnStockAdjustment.Enabled := StockToAsset.StockAdjustEntryID > 0;
  edtDescription.ReadOnly := StockToAsset.Processed;
  chkActive.Enabled := (not StockToAsset.Processed);
  btnSelect.Enabled := (not StockToAsset.Processed) and (AccessLevel < 3);

  if StockToAsset.Processed then
    grdLines.Options := grdLines.Options - [dgEditing];

end;

procedure TfmStockToFixedAsset.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmStockToFixedAsset.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if StockToAsset.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveData then begin
            StockToAsset.Connection.CommitTransaction;
            StockToAsset.Dirty := false;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          StockToAsset.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;
end;

procedure TfmStockToFixedAsset.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := true;
  inherited;
  fPurchaseOrderId := 0;
  StockToAsset := TStockToAsset.Create(nil);
  StockToAsset.Connection := TMyDacDataConnection.Create(StockToAsset);
  StockToAsset.Connection.Connection := MyConnection;
  StockToAsset.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TfmStockToFixedAsset.FormDestroy(Sender: TObject);
begin
  inherited;
  StockToAsset.Free;
end;

procedure TfmStockToFixedAsset.FormShow(Sender: TObject);
var
  QueriesNotToOpen: array of string;
  qry: TERPQuery;
begin
  DisableForm;
  try
    try
      inherited;
      Setlength(QueriesNotToOpen, 2);
      QueriesNotToOpen[0] := 'qryMain';
      QueriesNotToOpen[1] := 'qryDetail';
      OpenQueries(QueriesNotToOpen);

      RollbackTransaction;

      BeginTransaction;
      StockToAsset.Load(KeyId);
      StockToAsset.Lines;

      if KeyID = 0 then begin
        StockToAsset.New;
        if fPurchaseOrderId > 0 then begin
          StockToAsset.PurchaseOrderId := fPurchaseOrderId;
          qry := DbSharedObj.GetQuery(MyConnection);
          try
            qry.SQL.Add('select SupplierName, OrderDate from tblPurchaseOrders');
            qry.SQL.Add('where PurchaseOrderId = ' + IntToStr(fPurchaseOrderId));
            qry.Open;
            StockToAsset.Description := 'PO# ' + IntToStr(fPurchaseOrderId) + ' ' +
              qry.FieldByName('SupplierName').AsString  + ' ' + DateToStr(Trunc(qry.FieldByName('OrderDate').AsDateTime));
          finally
            DbSharedObj.ReleaseObj(qry);
          end;
        end;
        StockToAsset.PostDB;
      end;

      qryMainCreationDate.DisplayFormat := FormatSettings.ShortDateFormat;
      qryMainProcessDate.DisplayFormat := FormatSettings.ShortDateFormat;
      EnableDisable;

    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
end;

function TfmStockToFixedAsset.GetPurchaseOrderId: integer;
begin
  if Assigned(StockToAsset) and (StockToAsset.ID > 0) then
    result := StockToAsset.PurchaseOrderId
  else
    Result := fPurchaseOrderId;
end;

procedure TfmStockToFixedAsset.grdLinesColEnter(Sender: TObject);
begin
  inherited;
  if StockToAsset.Processed or (AccessLevel > 2) then exit;
  if (grdLines.GetActiveField.FieldName = qryDetailProductName.FieldName) then
    self.HighlightControl(btnSelect)
  else
    self.HideHighlightControl;
end;

procedure TfmStockToFixedAsset.grdLinesDblClick(Sender: TObject);
begin
  inherited;
  if StockToAsset.Lines.AssetId > 0 then begin
    OpenERPForm('TfmFixedAsset',StockToAsset.Lines.AssetId,AssetAfterShow);

  end
  else begin
    CommonLib.MessageDlgXP_Vista('No further information available.',mtInformation,[mbOk],0);

  end;
end;

procedure TfmStockToFixedAsset.grdLinesIButtonClick(Sender: TObject);
begin
  inherited;
  if StockToAsset.Lines.Count = 0 then exit;
  if MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation,[mbyes,mbno] , 0 ) = mryes then begin
    StockToAsset.Lines.Delete;
  end;
end;

function TfmStockToFixedAsset.SaveData: boolean;
begin
  result:= true;
  if not result then exit;
  StockToAsset.POSTDB;
  result := StockToAsset.Save;
end;

procedure TfmStockToFixedAsset.SetAllAssetTypes(aAssetType: string);
begin
  if aAssetType = '' then exit;
  if self.IsFlag('AssetType') then exit;
  self.AddFlag('AssetType');
  try
    if CommonLib.MessageDlgXP_Vista('Would you like to set all lines to Asset Type "' + aAssetType + '"?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
      StockToAsset.SetAllAssetTypes(aAssetType);
    end;
  finally
    self.RemoveFlag('AssetType');
  end;
end;

procedure TfmStockToFixedAsset.UpdateMe(const Cancelled: Boolean;
  const aObject: TObject);
var
  qry: TERPQuery;
  Asset: TFixedAssets;
begin
  inherited;
  if Cancelled then exit;

  if aObject is TfmFixedAsset then begin
    qry := DbSharedObj.GetQuery(MyConnection);
    try
      qry.SQL.Add('select * from tblStockToFixedAssetLine');
      qry.SQL.Add('where StockToFixedAssetLineId <> ' + IntToStr(qryDetailStockToFixedAssetLineID.AsInteger));
      qry.SQL.Add('and StockToFixedAssetId = ' + IntToStr(qryDetailStockToFixedAssetID.AsInteger));
      qry.SQL.Add('and ProductName = ' + QuotedStr(qryDetailProductName.AsString));
      qry.Open;
      if qry.IsEmpty then exit;
      if CommonLib.MessageDlgXP_Vista('Would you like to Clone the Values from this Asset to the other Assets for Product "' + qryDetailProductName.AsString + '"?' + #13#10 + #13#10 +
        'Note that any existing values on the Other Assets will be Overwritten.',mtConfirmation,[mbYes,mbNo],0) <> mrYes then exit;
      Asset := TFixedAssets.CreateWithNewConn(nil);
      try
        Asset.Connection.Connection := CommonDbLib.GetNewMyDacConnection(Asset);
        Asset.SilentMode := false;
        TfmFixedAsset(aObject).FixedAssets.CloneAssetName := false;
        while not qry.Eof do begin
          Asset.Load(qry.FieldByName('AssetId').AsInteger);
          Asset.Connection.BeginTransaction;
          TfmFixedAsset(aObject).FixedAssets.ObjInstanceToClone := Asset;
          TfmFixedAsset(aObject).FixedAssets.ClonePropertyObjects;
          if Asset.Save then begin
            Asset.Connection.CommitTransaction;
          end
          else begin
            Asset.Connection.RollbackTransaction;
            exit;
          end;

          qry.Next;
        end;

        StockToAsset.Dirty := true;
      finally
        Asset.Free;
      end;
    finally
      DbSharedObj.ReleaseObj(qry);
    end;
  end;
end;

initialization
  RegisterClass(TfmStockToFixedAsset);
  with FormFact do begin
    RegisterMe(TfmStockToFixedAsset, 'TStockToFixedAssetListGUI_*=StockToFixedAssetID');
  end;
end.
