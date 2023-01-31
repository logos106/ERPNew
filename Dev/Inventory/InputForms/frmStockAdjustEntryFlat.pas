unit frmStockAdjustEntryFlat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  DB, MemDS, DBAccess, MyAccess,ERPdbComponents, Menus, AdvMenus,
  DataState, SelectionDialog, AppEvnts, ComCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, wwcheckbox, DBCtrls, Mask, wwdbdatetimepicker,
  DNMSpeedButton, wwdblook, Shader, ExtCtrls, DNMPanel, frmStockAdjustEntry, busobjbase,
  DBGrids, LogThreadLib, ImgList, ProgressDialog, TextFileObj, ERPDbLookupCombo;

type
  TfmStockAdjustEntryflat = class(TfmStockAdjustEntry)
    cboserialnumber: TwwDBLookupCombo;
    cboBinLocation: TwwDBLookupCombo;
    cboBatchnumber: TwwDBLookupCombo;
    QryBatchNo: TERPQuery;
    qrycboBinLocation: TERPQuery;
    qrycboserialnumber: TERPQuery;
    qrycboBinLocationbinlocation: TWideStringField;
    qrycboBinLocationbinnumber: TWideStringField;
    QryBatchNoBatchno: TWideStringField;
    QryBatchNoExpiryDate: TDateTimeField;
    qrycboBinLocationbinID: TIntegerField;
    qrycboserialnumberSerialnumber: TWideStringField;
    qryStockAdjustEntryProcessed: TWideStringField;
    qryStockAdjustEntryLinesAccountID: TIntegerField;
    qryStockAdjustEntryLinesAccountName: TWideStringField;
    qryStockAdjustEntryLinesSerialnos: TWideMemoField;
    qryStockAdjustEntryLinesBinid: TIntegerField;
    qryStockAdjustEntryLinesUOMcost: TFloatField;
    qryStockAdjustEntryLinestotalCost: TFloatField;
    qryStockAdjustEntryLinesInStockQty: TFloatField;
    qryStockAdjustEntryLinesAllocationInStockQty: TFloatField;
    qryStockAdjustEntryLinesAllocationInStockUOMQty: TFloatField;
    qryStockAdjustEntryLinesParttype: TWideStringField;
    qryStockAdjustEntryLinesMatrixDesc: TWideMemoField;
    qryStockAdjustEntryLinesMatrixRef: TWideMemoField;
    qryStockAdjustEntryLinesMatrixPrice: TFloatField;
    btnProcess: TDNMSpeedButton;
    QryUOMPartID: TIntegerField;
    qrycboBinLocationbinLocNum: TWideStringField;
    btnLoadProducts: TDNMSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure cboBatchnumberCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboBinLocationCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure grdTransactionsEnter(Sender: TObject);
    procedure cboBatchnumberNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnProcessClick(Sender: TObject);
    procedure grdTransactionsExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qryStockAdjustEntryLinesAfterInsert(DataSet: TDataSet);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cboProductCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboBinLocationNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure btnImportClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure cboserialnumberNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure qryStockAdjustEntryLinesCalcFields(DataSet: TDataSet);
    procedure btnToggleModeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure cboserialnumberCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure chkEnforceUOMEnter(Sender: TObject);
    procedure cboUOMCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure btnCompletedEnter(Sender: TObject);
    procedure btnCloseEnter(Sender: TObject);
    procedure grdTransactionsCalcTitleAttributes(Sender: TObject;
      AFieldName: String; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure grdTransactionsTitleButtonClick(Sender: TObject;
      AFieldName: String);
    procedure btnLoadProductsClick(Sender: TObject);
    procedure grdTransactionsDblClick(Sender: TObject);
    procedure qryStockAdjustEntryLinesBeforePost(DataSet: TDataSet);
  private
    LogFileCreated: Boolean;
    Logger : TLogger;
    TF: TTextfile;
    //procedure ErrorLog(const Value: string);
    procedure SelectProductFromreport(Sender: TwwDBGrid);
    Procedure Createbin(const fiClassID:Integer; const fsBinlocation, fsBinnumber:STRing);
    Procedure RefreshbinTables;

    Procedure PostLinesBeforeSave;
    Function QtyLocationsreport:boolean;
    procedure initTextfileViewer(Sender: TObject);
    function ImportErrorfilename: String;
    procedure initStockQtysLocationsReport(Sender: TObject);


  Protected
    procedure ShowStatus(const Value :String)  ;Override;
    procedure OnComboNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean); override;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string); override;
    Procedure checkWriteStatus(fsFieldname:String); override;
    Procedure UpdateBarcode(const Barcode:String);override;
    procedure SetMatrixDetails(sMatrixDesc, sMatrixRef: String;dMatrixPrice: double);Override;
    Procedure Hidecolumns;Override;
  public
    procedure CloseLog;
  end;


implementation

uses frmStockAdjustEntryTree, BaseInputForm, CommonLib, BusObjConst,
  BusobjStockAdjustEntry, busobjPQA, tcDataUtils, FormFactory,
  frmImportStockAdjust, StockQtysLocationsReport,
  FastFuncs, frmBinLocation, AppEnvironment, BusObjStock,
  LogMessageTypes, tcConst, PartsPriceMatrixLib, frmpartsPriceMatrixInput,
  BusObjProductbin, frmTextfileViewer, CommonFormLib, frmExportStockAdjustment, frmImportStockAdjustment;

{$R *.dfm}

procedure TfmStockAdjustEntryflat.btnToggleModeClick(Sender: TObject);
var
    form :TfmStockAdjustEntryTree;
begin
    if (StockAdjust.Processed) then begin
        CommonLib.MessageDlgXP_Vista('This Stock Adjustment is already processed. Its not possible to view it in Tree mode' , mtInformation , [mbok] , 0);
        Exit;
    end;
    Processingcursor(True);
    try
      if StockAdjust.Dirty then begin
        StockAdjust.Lines.PostDB;
        StockAdjust.postDB;
        SetFocusedControl(grdTransactions);
        StockAdjust.TempSave := True;
        try
          if not (StockAdjust.Save) then Exit;
        Finally
          StockAdjust.TempSave := False;
        end;
        StockAdjust.Connection.CommitTransaction;
        StockAdjust.UserLock.UnlockAllCurrentInstance;
        //StockAdjust.CreateTreeModeData;
        Self.KeyId := StockAdjust.ID;
      end else begin
        StockAdjust.Connection.RollbackTransaction;
        StockAdjust.Dirty := false;
      end;
      FreeandNil(StockAdjust);
      form := TfmStockAdjustEntryTree(GetComponentByClassName('TfmStockAdjustEntryTree'));
      if Assigned(form) then begin
            form.KeyID := Self.KeyID;
            (*Form.AllocationMode := Self.AllocationMode;*)
            form.FormStyle := fsMDIChild;
            form.BringToFront;
      end;
      Close;
    finally
        Processingcursor(False);
    end;
end;

procedure TfmStockAdjustEntryflat.btnLoadProductsClick(Sender: TObject);
begin
  inherited;
  QtyLocationsreport;
end;

procedure TfmStockAdjustEntryflat.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
  var
    MatrixDesc:String;
    MatrixRef:String;
    MatrixPrice:double;

  Procedure Allocationfields(Editable :boolean = False);
  var
    allocationenabled:Boolean;
  begin
    grdTransactions.ColumnByName('BatchNo').Readonly        := not(Editable) and ((StockAdjust.Lines.ProductID = 0) or (StockAdjust.Lines.Product.Batch=False));
    grdTransactions.ColumnByName('Expirydate').Readonly     := not(Editable) and ((StockAdjust.Lines.ProductID = 0) or (StockAdjust.Lines.Product.Batch=False));
    grdTransactions.ColumnByName('BinLocation').Readonly    := not(Editable) and ((StockAdjust.Lines.ProductID = 0) or (StockAdjust.Lines.Product.multiplebins=False));
    grdTransactions.ColumnByName('BinNumber').Readonly      := not(Editable) and ((StockAdjust.Lines.ProductID = 0) or (StockAdjust.Lines.Product.Multiplebins=False));
    grdTransactions.ColumnByName('SerialNumber').Readonly   := not(Editable) and ((StockAdjust.Lines.ProductID = 0) or (StockAdjust.Lines.Product.SNtracking=False));
    allocationenabled := (Editable) or (((StockAdjust.Lines.ProductID <> 0)) and ((StockAdjust.Lines.Product.Multiplebins) or (StockAdjust.Lines.Product.Batch) or (StockAdjust.Lines.Product.Sntracking)));
    grdTransactions.ColumnByName('AllocationFinalqty').Readonly         := not(allocationenabled);
    grdTransactions.ColumnByName('AllocationAdjustQty').Readonly        := not(allocationenabled);
    grdTransactions.ColumnByName('AllocationFinalUOMQty').Readonly      := not(allocationenabled);
    grdTransactions.ColumnByName('AllocationAdjustUOMQty').Readonly     := not(allocationenabled);
    cboBatchnumber.enabled        := not((StockAdjust.Lines.ProductID = 0) or (StockAdjust.Lines.Product.Batch=False));
    cboBinLocation.enabled        := not((StockAdjust.Lines.ProductID = 0) or (StockAdjust.Lines.Product.multiplebins=False));
    cboserialnumber.enabled       := not((StockAdjust.Lines.ProductID = 0) or (StockAdjust.Lines.Product.SNtracking=False));
  end;
begin
  inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TSAELinesFlat then TSAELinesFlat(Sender).DataSet:=qryStockAdjustEntryLines;
    end else if(Eventtype = BusObjEvent_Change) and (Value = BusObjEventVal_ProductChanged) then begin
        if StockAdjust.Lines.ProductID<> 0 then begin
          if not StockAdjust.Lines.deleted then begin
            ReadSalesDefaultPriceMethod(StockAdjust.Lines.ProductID,MatrixDesc, MatrixRef,MatrixPrice);
            SetMatrixDetails(MatrixDesc,MatrixRef ,MatrixPrice);
          end;
        end;
    end else if(Eventtype = BusObjEvent_Change) and (Value = BusobjEventVal_StockAdjustproduct) then begin
        if StockAdjust.Lines.ProductID<> 0 then begin
          if (StockAdjust.Lines.Product.Batch) and (Screen.activecontrol <> cboBatchnumber) then begin
              if QryBatchNo.active then QryBatchNo.Close;
              QryBatchNo.Params.ParamByName('ProductID').AsInteger    := StockAdjust.Lines.ProductID;
              QryBatchNo.Params.ParamByName('ClassId').AsInteger      := StockAdjust.Lines.DeptID;
              QryBatchNo.Params.ParamByName('TransDate').asDatetime   := StockAdjust.adjustmentdate;
              QryBatchNo.open;
              QryBatchNo.Locate('Batchno',StockAdjust.Lines.Batchno , []);
          end;
          if (StockAdjust.Lines.Product.Multiplebins) and (screen.activecontrol <> cboBinLocation) then begin
              if qrycboBinLocation.active then qrycboBinLocation.Close;
              qrycboBinLocation.Params.ParamByName('ClassId').AsInteger       := StockAdjust.Lines.DeptID;
              qrycboBinLocation.open;
              qrycboBinLocation.Locate('Binlocation;binnumber',VarArrayof([StockAdjust.Lines.Binlocation , StockAdjust.Lines.binnumber]) , []);
          end;
          if StockAdjust.Lines.Product.SNTracking then begin
              if qrycboserialnumber.Active then qrycboserialnumber.close;
              qrycboserialnumber.Params.ParamByName('ProductID').AsInteger    := StockAdjust.Lines.ProductID;
              qrycboserialnumber.Params.ParamByName('ClassId').AsInteger      := StockAdjust.Lines.DeptID;
              qrycboserialnumber.Params.ParamByName('TransDate').asDatetime   := StockAdjust.adjustmentdate;
              qrycboserialnumber.Params.ParamByName('TransDate1').asDatetime  := StockAdjust.adjustmentdate;
              qrycboserialnumber.Params.ParamByName('BinID').asInteger        := TProductBin.IDToggle(StockAdjust.Lines.ClassID, StockAdjust.Lines.binlocation, StockAdjust.Lines.binnumber, StockAdjust.Connection.connection);
              qrycboserialnumber.Params.ParamByName('Batchno').asString       :=StockAdjust.Lines.BatchNo;
              qrycboserialnumber.Params.ParamByName('ExpiryDate').asDatetime  :=StockAdjust.Lines.Expirydate;
              qrycboserialnumber.open;
              qrycboserialnumber.Locate('Serialnumber' , stockadjust.lines.serialnumber , []);
              cboserialnumber.Text :=stockadjust.lines.serialnumber ;
          end;
        end;
        Allocationfields;
    end else if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_IDChanged) then begin
      Allocationfields;
    end else if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_BeforeInsert) then begin
      Allocationfields(true);
    end else if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AfterInsert) then begin
      Allocationfields;
    end else if (EventType = BusObjEvent_Change) And (value = BusObjEventVal_uomChanged) then begin
      if QryUOMUnitID.AsInteger <> StockAdjust.lines.UnitOfMeasureID then begin
         closedb(QryUOM);
         opendb(QryUOM);
         QryUOM.locate('unitID' , StockAdjust.lines.UnitOfMeasureID , []);
      end;
    end;
end;

procedure TfmStockAdjustEntryflat.FormShow(Sender: TObject);
var
  bbatch,bbin, bsn :Boolean;
begin
  TProduct.checkAllocation(bbatch,bbin, bsn);
  (*if AllocationMode and (bbatch or bbin or  bsn) then begin
        if cboProductQry.active then cboProductQry.close;
        cboProductQry.SQL.text := StringReplace(cboProductQry.SQL.text ,'#','',[rfIgnoreCase]);
  end else AllocationMode := False;*)

   inherited;

   qryJob.Open;

 (* if bbatch= False then begin
    grdTransactions.RemoveField('Batchno');
    grdTransactions.RemoveField('ExpiryDate');
  end;
  if bbin= False then begin
    grdTransactions.RemoveField('BinLocation');
    grdTransactions.RemoveField('Binnumber');
  end;
  if (bbatch=False) and (bbin = False) then begin
    grdTransactions.RemoveField('AllocationInStockQty');
    grdTransactions.RemoveField('AllocationAdjustUOMQty');
    grdTransactions.RemoveField('AllocationFinalUOMQty');
    grdTransactions.RemoveField('AllocationAvailableUOMQty');
  end;
  if bsn= False then begin
    grdTransactions.RemoveField('SerialNumber');
  end;*)
  (*if AllocationMode then begin
        grdTransactions.RemoveField('InStockQty');
        grdTransactions.RemoveField('InStockUOMQty');
        grdTransactions.RemoveField('AdjustUOMQty');
        grdTransactions.RemoveField('FinalUOMQty');
        grdTransactions.RemoveField('AvailableUOMQty');
  end ;*)

  stockAdjust.ShowStatus  := ShowStatus;
  if accesslevel = 5 then grdTransactions.OnBeforePaint := nil;

  btnToggleMode.enabled:= not((bbatch=False) and (bbin = False) and (bsn= False));

  StockAdjust.Createbin := Createbin;
  lblProgressbar.Caption := 'Hold down CTRL and Press DOWN ARROW to add a new line and copy the product details from current record.';
  lblProgressbar.Visible := not(StockAdjust.Processed);


  btnProcess.enabled      := (AccessLevel<5) ;
  cboserialnumber.enabled := (AccessLevel<5) ;
  cboBinLocation.enabled  := (AccessLevel<5) ;
  cboBatchnumber.enabled  := (AccessLevel<5) ;
  cboProduct.enabled      := (AccessLevel<5) ;
  cboClass.enabled        := (AccessLevel<5) ;
  cboUOM.enabled          := (AccessLevel<5) ;


  StockAdjust.Lines;
  StockAdjust.Lines.Dataset.Filter:= 'Deleted <> ' + QuotedStr('T');
  StockAdjust.Lines.Dataset.Filtered:= true;
  StockAdjust.inTreemode := False;

  StockAdjust.dirty := False;
end;

procedure TfmStockAdjustEntryflat.cboBatchnumberCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
    if QryBatchNoExpiryDate.asDatetime <> 0 then StockAdjust.Lines.Expirydate :=QryBatchNoExpiryDate.asDatetime; 
end;

procedure TfmStockAdjustEntryflat.cboBinLocationCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  StockAdjust.Lines.BinNumber := qrycboBinLocationbinnumber.asString;
end;

procedure TfmStockAdjustEntryflat.grdTransactionsEnter(Sender: TObject);
(*function columnno(const value:String):Integer;
var   x:Integer;
begin
  result := 0;
  for x:= 0 to grdTransactions.FieldCount - 1 do
    if Sysutils.SameText(grdTransactions.FieldName(x) , Value) then begin
        result := x;
        break;
    end;
end;*)
begin
  inherited;
{  if StockAdjust.AdjustmentOnInstock then begin
(*    qryStockAdjustEntryLinesAllocationAvailableUOMQty.Visible := True;
    qryStockAdjustEntryLinesallocationinstockUOMQty.Visible := False;*)
    grdTransactions.AddField('AllocationInstockUOMQty', columnno('AvailableUOMQty'));
    grdTransactions.RemoveField('AllocationAvailableUOMQty');
  end else begin
    (*qryStockAdjustEntryLinesAllocationAvailableUOMQty.Visible := False;
    qryStockAdjustEntryLinesallocationinstockUOMQty.Visible := TRue*)
    grdTransactions.AddField('AllocationAvailableUOMQty', columnno('InstockUOMQty'));
    grdTransactions.RemoveField('AllocationInstockUOMQty');

  end; }
    if StockAdjust.Lines.count = 0 then begin
      StockAdjust.Lines.new;
      StockAdjust.Lines.PostDB;
    end;
end;

procedure TfmStockAdjustEntryflat.cboBatchnumberNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
    Accept := true;
end;

procedure TfmStockAdjustEntryflat.btnCompletedClick(Sender: TObject);
begin
  PostLinesbeforeSave;
  if StockAdjust.Lines.count = 0 then begin
     StockAdjust.Resultstatus.AddItem(False , rssWarning, 0 , 'No Products For Adjustment.' );
    Exit;
  end;
  OverrideAccessLevel(nil); // if readonly and set deleted
  try
    StockAdjust.Lines.PostDB;
    if not StockAdjust.Save then Exit;
   StockAdjust.Connection.CommitTransaction;
    inherited;
  finally
      Setaccesslevel(Nil);
  end;
end;

procedure TfmStockAdjustEntryflat.btnProcessClick(Sender: TObject);
begin
  inherited;
  PostLinesbeforeSave;
  if StockAdjust.Lines.count = 0 then begin
     StockAdjust.Resultstatus.AddItem(False , rssWarning, 0 , 'No Products For Adjustment.' );
    Exit;
  end;
    if StockAdjust.Process then begin
      StockAdjust.Dirty := False;
      StockAdjust.connection.CommitTransaction;
      commonlib.MessageDlgXP_Vista('Stock adjustment has been processed.' , mtInformation , [mbok], 0);
      Self.close;
    end;
end;

procedure TfmStockAdjustEntryflat.OnComboNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: boolean);
var
  strSQL :String;
begin
  if sender = cboBinLocation then begin
    strSQL:= 'Select * from tblProductbin   Where binlocation = ' + QuotedStr(cboBinLocation.text);
    if StockAdjust.Lines.BinNumber <> '' then
        strSQL := strSQL + ' and binnumber = '+quotedStr(StockAdjust.Lines.BinNumber);
    with StockAdjust.getnewDataset(StrSQL, true) do try
      if recordcount> 0 then begin
        if StockAdjust.Lines.BinNumber = '' then begin
          StockAdjust.Lines.Binlocation := FieldByname('binlocation').asString;
          StockAdjust.Lines.BinNumber   := FieldByname('binnumber').asString;
          StockAdjust.Lines.PostDB;
          grdTransactions.Refresh;
        end;
        Accept := True;
        exit;
      end;
    finally
      if active then Close;
      Free;
    end;
  end;
  inherited;
end;

procedure TfmStockAdjustEntryflat.grdTransactionsExit(Sender: TObject);
var
  Accept : Boolean;
begin
  inherited;
  if (grdTransactions.GetActiveField.FieldName = 'Binnumber') then begin
    StockAdjust.Lines.PostDB;
    OnComboNotInList(cboBinLocation, cboBinLocation.LookupTable, StockAdjust.Lines.Binlocation, Accept);
  end;
end;
(*procedure TfmStockAdjustEntryflat.ErrorLog(const Value: string);
begin
  if not LogFileCreated then
  begin
    LogFileCreated := True;
    Logger.Active  := True;
    Logger.Log(TitleLabel.Caption +'-Errors', ltBlank);
  end;
  Logger.Log(Value, ltError);
  TF.WriteLine(Value);
end;*)

procedure TfmStockAdjustEntryflat.CloseLog;
begin
  if LogFileCreated then begin
    LogFileCreated := False;
    if CommonLib.MessageDlgXP_Vista('Please refer to ' + ImportErrorfilename + ' for errors.'  , mtWarning, [mbOk] , 0, nil , '' , '' , False, nil, 'Open Log') <> mrok then
      OpenERPForm('TfmTextfileViewer' , 0 ,nil,  initTextfileViewer);
    Logger.Active := False;
  end;
end;
procedure TfmStockAdjustEntryflat.initTextfileViewer(Sender: TObject);
begin
  if not(Sender is TfmTextfileViewer) then exit;
  Freeandnil(TF);
  TfmTextfileViewer(Sender).textfileName :=  ImportErrorfilename;
end;
procedure TfmStockAdjustEntryflat.FormCreate(Sender: TObject);
begin
  AllowGridSorting  := False;
  inherited;
  LogFileCreated := False;
  Logger:= TLogger.Create(Application);
  Logger.LogTime := False;
  Logger.Logname:='ERP_StockUpdate';
  fPaintTimer.Interval := 2000;
end;
function TfmStockAdjustEntryflat.ImportErrorfilename:String;
begin
  ForceDirectories(Logger.LogPath);
  result:= Logger.LogPath + '\'+ Logger.LogName + '_' + FormatDateTime('yyyy_mm_dd',now) + '.err'
end;
procedure TfmStockAdjustEntryflat.qryStockAdjustEntryLinesAfterInsert(
  DataSet: TDataSet);
begin
  inherited;
  if ProductId <> 0 then StockAdjust.Lines.ProductID := ProductID;
end;

procedure TfmStockAdjustEntryflat.qryStockAdjustEntryLinesBeforePost(
  DataSet: TDataSet);
begin
  inherited;
  if cboJob.Text = '' then
    qryStockAdjustEntryLinesJobID.AsInteger := 0
  else
    qryStockAdjustEntryLinesJobID.AsInteger := qryJobJobID.AsInteger;
end;

procedure TfmStockAdjustEntryflat.SelectProductFromreport(Sender: TwwDBGrid);
var
  ds:TDataset;
  form: Tcomponent;
  i :Integer;
  grd :TwwDbGrid;
  s:String;
begin

  s := lblProgressbar.Caption;
  try
    grd:=Sender;         if not(Assigned(grd)) then exit;
    ds:= grd.Datasource.Dataset;    if not(Assigned(ds))  then exit;
    StockAdjust.Lines.PostDB;
    StockAdjust.Lines.dataset.DisableControls;
    StockAdjust.Lines.DoFieldChangewhenDisabled := true;
    ds.DisableControls;
    try
      showProgressbar(WAITMSG, grd.SelectedList.Count);
      try
        for i := 0 to grd.SelectedList.Count - 1 do begin
          lblProgressbar.Caption := 'Adding ' + IntToStr(i) +' of ' + IntToStr(grd.SelectedList.Count) + ' record(s)';
          Application.ProcessMessages;
          ds.GotoBookmark(grd.SelectedList.Items[i]);
          StockAdjust.Lines.New;
          StockAdjust.Lines.ProductName         := ds.fieldByname('ProductName').asString;
          StockAdjust.Lines.DeptID              := ds.fieldbyname('DepartmentId').asInteger;
          if (StockAdjust.Lines.Product.Batch) and (ds.fieldbyname('glevel').asInteger > 1 ) then begin
            StockAdjust.Lines.BatchNo       := ds.fieldbyname('Batchnumber').asString ;
            if ds.fieldbyname('BatchExpiryDate').asDatetime  <> 0 then
              StockAdjust.Lines.Expirydate  :=  ds.fieldbyname('BatchExpiryDate').asDatetime ;
          end;
          if (StockAdjust.Lines.Product.Multiplebins) and (ds.fieldbyname('glevel').asInteger > 2 ) then begin
            StockAdjust.Lines.binLocation       := ds.fieldbyname('binLocation').asString ;
            StockAdjust.Lines.Binnumber         := ds.fieldbyname('Binnumber').asString ;
          end;
          if (StockAdjust.Lines.UnitOfMeasure <> ds.Fieldbyname('UOM').asString)  then
            StockAdjust.Lines.UnitOfMeasure     := ds.Fieldbyname('UOM').asString;

          if ds.fieldbyname('glevel').asInteger  = 1 then begin
            if StockAdjust.Lines.AvailableQty<> ds.Fieldbyname('qty').asFloat then
              StockAdjust.Lines.AvailableQty    := ds.Fieldbyname('qty').asFloat;
          end else begin
            StockAdjust.Lines.calcAvailableQty;
            if StockAdjust.AdjustmentOnInstock then begin
              StockAdjust.Lines.FinalQty                    := StockAdjust.Lines.InStockQty   + StockAdjust.Lines.AdjustQty;
              StockAdjust.Lines.FinalUOMQty                 := StockAdjust.Lines.InStockUOMQty + StockAdjust.Lines.AdjustUOMQty;
            end else begin
              StockAdjust.Lines.FinalQty                    := StockAdjust.Lines.AvailableQty    + StockAdjust.Lines.AdjustQty;
              StockAdjust.Lines.FinalUOMQty                 := StockAdjust.Lines.AvailableUOMQty + StockAdjust.Lines.AdjustUOMQty;
            end;
            if StockAdjust.Lines.AllocationAvailableQty<> ds.Fieldbyname('qty').asFloat then begin
              StockAdjust.Lines.AllocationAvailableQty    := ds.Fieldbyname('qty').asFloat;
              StockAdjust.Lines.AllocationAvailableUOMQty := ds.Fieldbyname('UOMqty').asFloat;
              StockAdjust.Lines.AllocationFinalqty        := StockAdjust.Lines.AllocationAvailableQty    + StockAdjust.Lines.AllocationAdjustQty;
              StockAdjust.Lines.AllocationFinalUOMQty     := StockAdjust.Lines.AllocationAvailableUOMQty + StockAdjust.Lines.AllocationAdjustUOMQty;
            end;
          end;
          StockAdjust.Lines.PostDB;
          StepProgressbar;
        end;
      finally
        HideProgressbar;
      end;
    finally
        ds.EnableControls;
        StockAdjust.Lines.dataset.EnableControls;
    end;
  finally
    Form:= FindExistingComponent('TStockQtysLocationsReportGUI');
    if assigned(Form) then TStockQtysLocationsReportGUI(form).close;
    lblProgressbar.Caption := s;
  end;

end;
procedure TfmStockAdjustEntryflat.SetMatrixDetails(sMatrixDesc,
  sMatrixRef: String; dMatrixPrice: double);
begin
  inherited;
    StockAdjust.Lines.MatrixDesc := sMatrixDesc;
    StockAdjust.Lines.MatrixRef  := sMatrixRef;
    StockAdjust.Lines.MatrixPrice:= dMatrixPrice;
    StockAdjust.Lines.PostDB;
end;

procedure TfmStockAdjustEntryflat.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Do you wish to delete this record?', mtconfirmation, [mbYes, mbNo], 0)  = mrNo then exit;
  StockAdjust.Lines.deleted := true;
  StockAdjust.Lines.PostDB;
end;
procedure TfmStockAdjustEntryflat.initStockQtysLocationsReport(Sender: TObject);
begin
  TStockQtysLocationsReportGUI(Sender).ProductId   := StockAdjust.Lines.ProductID;
  TStockQtysLocationsReportGUI(Sender).ClassID     := StockAdjust.Lines.ClassID;
end;
Function TfmStockAdjustEntryflat.QtyLocationsreport:Boolean;
begin
  OpenERPListFormultiselectModal('TStockQtysLocationsReportGUI' ,initStockQtysLocationsReport , SelectProductFromreport);
  REsult := True;
end;
procedure TfmStockAdjustEntryflat.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  LineXML:String;
begin
  inherited;
  if StockAdjust.Processed then exit;
  if Key = VK_F9 then begin
    if QtyLocationsreport then exit;
  end else if Shift = [ssCtrl] then begin
      if Key = VK_down then begin
        StockAdjust.Lines.PostDB;
        LineXML :=StockAdjust.Lines.XMLTocopyLine;
        StockAdjust.Lines.New;
        StockAdjust.Lines.XML:=LineXML;
      end;
  end;
end;

procedure TfmStockAdjustEntryflat.cboProductCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
(*  StockAdjust.Lines.ProductName := cboProductQry.fieldByname('PARTNAME').asString;
  StockAdjust.Lines.PostDB;
  if StockAdjust.Lines.ProductId = 0 then Exit;
  if QryUOM.Locate('Multiplier;PartID' , VarArrayOf([1, StockAdjust.Lines.ProductId]) , []) =False then
    if QryUOM.Locate('Multiplier' , 1 , []) =false then exit;
  StockAdjust.Lines.UOM := QryUOMUnitname.asString;*)
end;

procedure TfmStockAdjustEntryflat.Createbin(const fiClassID:Integer; const fsBinlocation,fsBinnumber:STRing);
begin
    with TfmbinLocation(GetComponentByClassName('TfmbinLocation',TRue, Self)) do begin
        AttachObserver(Self);
        Keyid               := 0;
        Formcolor           := Self.Color;
        ClassId             := fiClassID;
        edtBinLocation.text := fsBinlocation;
        edtBinnumber.text   := fsBinnumber;
        Refreshdet          := RefreshbinTables;
        ShowModal;
    end;
end;

procedure TfmStockAdjustEntryflat.RefreshbinTables;
begin
    if qrycboBinLocation.Active then qrycboBinLocation.Close;
    qrycboBinLocation.open;
    if qrycboBinLocation.Locate('BinID' ,TfmbinLocation(GetComponentByClassName('TfmbinLocation',TRue, Self)).KeyID , []) then begin
      StockAdjust.Lines.BinLocation :=qrycboBinLocation.FieldByName('Binlocation').AsSTring;
      StockAdjust.Lines.BinNumber := qrycboBinLocation.FieldByName('Binnumber').AsSTring;
    end;
end;

procedure TfmStockAdjustEntryflat.cboBinLocationNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
  inherited;
  //Createbin(StockAdjust.Lines.ClassID ,StockAdjust.Lines.BinLocation , StockAdjust.Lines.BinNumber); 
end;

procedure TfmStockAdjustEntryflat.btnImportClick(Sender: TObject);
begin
  OpenERPForm('TfmImportStockAdjustment' , 0 );
  Self.Close;
  inherited;
    (*if (Stockadjust.Dataset.state = dsInsert) or (Stockadjust.Dataset.recordcount <> 0 ) then begin
      if MessageDlgXP_Vista('Do you wish to cancel the current changes?' , mtConfirmation , [mbYes, mbNo] , 0) = mrno then exit;
      Stockadjust.Lines.canceldb;
      Stockadjust.canceldb;
    end;
    Stockadjust.Connection.RollbackTransaction;
    Stockadjust.Dirty := False;
    OpenERPForm('TfmImportStockAdjustment' , 0 , nil);
    Self.Close;*)
  (*try
    Form := TfrmImportStockAdjustGUI(GetComponentByClassName('TfrmImportStockAdjustGUI', True, self));
    try
      if Assigned(Form) then begin //if has acess
        Form.ErrorLog := ErrorLog;
        TF:= TTextfile.Create(ImportErrorfilename , tfmCreate);
        FreeandNil(TF);
        TF:=TTextFile.Create(ImportErrorfilename, tfmOpenReadWrite);
        try
          Form.Showmodal;
          CloseLog;
        finally
          Freeandnil(TF);
        end;
        Self.Close;
      end;
    finally
        freeandNil(Form);
    end;
  finally
      stockAdjust.ShowStatus  := ShowStatus;
      stockAdjust.Progressbar := Progressbar;
      {if stockAdjust.AccountId <> 0 then begin
        strSQL := 'select count( * ) as ctr from tblStockAdjustentrylines where StockAdjustEntryID = ' +IntToStr(stockAdjust.ID) +' and AccountID <> ' +IntToStr(stockAdjust.AccountID) ;
        with stockAdjust.getnewDataset(strSQL,true) do try
          if recordcount > 0 then
            if fieldbyname('ctr').asInteger > 0 then begin
              lblProgressbar.visible := True;
              try
                lblProgressbar.Caption := 'Updating the ''To Account'' ';
                stockAdjust.AccountId := stockAdjust.AccountId; // this is to force assigning the assetAccount in the lines after import ;
              finally
                  lblProgressbar.visible:= False;
              end;
            end;
        finally
            if Active then close;
            Free;
        end;
      end;}
      //grdTransactions.RefreshDisplay;
  end;*)
end;

procedure TfmStockAdjustEntryflat.btnExportClick(Sender: TObject);
begin
    if (Stockadjust.Dataset.state = dsInsert) or (Stockadjust.Dataset.recordcount <> 0 ) then begin
      if MessageDlgXP_Vista('Do you wish to cancel the current changes?' , mtConfirmation , [mbYes, mbNo] , 0) = mrno then exit;
      Stockadjust.Lines.canceldb;
      Stockadjust.canceldb;
    end;
    Stockadjust.Connection.RollbackTransaction;
    Stockadjust.Dirty := False;
    OpenERPForm('TfmExportStockAdjustment' , 0 , nil);
    Self.Close;

(*Var Form : TComponent;
begin
  Form := GetComponentByClassName('TfmExportStockAdjustment');
  if Assigned(Form) then begin //if has acess
    with TfmExportStockAdjustment(Form) do begin
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;*)
end;

procedure TfmStockAdjustEntryflat.ShowStatus(const Value: String);
begin
    (*lblProgressbar.Caption := Value;
    lblProgressbar.Refresh;*)
    lbltimerMsg :=lblProgressbar;
    inherited;
end;

procedure TfmStockAdjustEntryflat.btnPrintClick(Sender: TObject);
var
  sSQL: string;
begin
  if StockAdjust.dirty then if not StockAdjust.Save then exit;
  StockAdjust.Connection.CommitTransaction;
  sSQL:= '{COmpanyInfo}Select * from tblCompanyInformation'+
          ' ~|||~{Detail}SELECT  SA.StockAdjustEntryID,SAL.ACCOUNTID,SAL.ACCOUNTNAME,SAL.PRODUCTID,'+
          ' SAL.PRODUCTNAME,SAL.DESCRIPTION,SAL.CLASSID,SAL.CLASSNAME,SAL.AVAILABLEUOMQTY,'+
          ' SAL.FINALUOMQTY,SAL.ADJUSTUOMQTY,SAL.COST,SAL.UOM,SAL.UOMMULTIPLIER, '+
          ' SA.CreationDate,SA.Adjustmentdate,SA.AccountID AS HAccountID,'+
          ' SA.Accountname AS HAccountName,SA.Notes,SA.IsStocktake,SA.Employee,'+
          ' SA.Deleted,SA.Processed , P.PartsDescription,SAL.BatchNo,SAL.Expirydate,'+
          ' SAL.BinLocation,SAL.BinNumber,'+
          ' SAL.serialnumber, '+
          ' SAL.AllocationAvailableUOMQty,'+
          ' SAL.AllocationFinalUOMQty,SAL.AllocationAdjustUOMQty , '+
          ' SAL.InStockQty ,   SAL.Cost * SAL.AdjustQty as TotalLineCost'+
          ' FROM tblStockAdjustentryLines as SAL'+
          ' inner join tblstockadjustentry as SA   on SA.StockAdjustEntryID = SAL.StockAdjustEntryID'+
          ' inner join tblParts as P on SAL.ProductId = P.PartsID'+
          ' WHERE SA.StockAdjustEntryID= '+ IntToStr(StockAdjust.ID) +
          ' Group by  SAL.STOCKADJUSTENTRYLINESID, SAL.ProductName';
  fbReportSQLSupplied := True;
  PrintTemplateReport(TStockAdjustEntry.Transtype, sSQL, not AppEnv.Employee.ShowPreview, 1);
  Close;
end;

procedure TfmStockAdjustEntryflat.cboserialnumberNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
  //inherited;
  Accept := True;
end;

procedure TfmStockAdjustEntryflat.qryStockAdjustEntryLinesCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryStockAdjustEntryLinesTotalCost.asFloat  := qryStockAdjustEntryLinesCost.asFloat * qryStockAdjustEntryLinesAdjustQty.asFloat;// round(qryStockAdjustEntryLinesCost.asFloat * qryStockAdjustEntryLinesAdjustQty.asFloat , CurrencyRoundPlaces);
  qryStockAdjustEntryLinesUOMCost.asFloat    := qryStockAdjustEntryLinesCost.asFloat * qryStockAdjustEntryLinesUOMMultiplier.asFloat  //round(qryStockAdjustEntryLinesCost.asFloat * qryStockAdjustEntryLinesUOMMultiplier.asFloat , CurrencyRoundPlaces);
end;


procedure TfmStockAdjustEntryflat.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CloseLog;
  inherited;

end;

procedure TfmStockAdjustEntryflat.FormDestroy(Sender: TObject);
begin
  FreeandNil(Logger);
  inherited;
end;

procedure TfmStockAdjustEntryflat.cboserialnumberCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  StockAdjust.Lines.Serialnumber := cboserialnumber.Text;
end;

procedure TfmStockAdjustEntryflat.chkEnforceUOMEnter(Sender: TObject);
begin
    SavedAccessLevel := AccessLevel;
    if StockAdjust.Lines.count = 0 then exit;
    inherited;
end;

procedure TfmStockAdjustEntryflat.cboUOMCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  cboUOM.text := StockAdjust.Lines.UOM;
end;

procedure TfmStockAdjustEntryflat.PostLinesBeforeSave;
begin
  SetControlFocus(cboAccount);
  StockAdjust.Lines.PostDB;
  StockAdjust.Lines.Dataset.disablecontrols;
  try
    StockAdjust.Lines.Dataset.filtered := False;
    StockAdjust.Lines.Dataset.Filtered := True;
  finally
      StockAdjust.Lines.Dataset.enablecontrols;
  end;

end;


procedure TfmStockAdjustEntryflat.checkWriteStatus(fsFieldname: String);
begin
  inherited;
  if LockedAdjustQty then
  if (Sysutils.SameText(fsFieldname , 'AdjustUOMQty')) or
    (Sysutils.SameText(fsFieldname , 'finalUomQty')) then
    if StockAdjust.Lines.dataset.findfield(fsFieldname) <> nil then
        MessageDlgXP_Vista(QuotedStr(lblEnforceUOM.caption)+' is  off.  ' +
                  'When ' + QuotedStr(lblEnforceUOM.caption)+'  is off, ' +
                  'Product and Department combination can have only one ' +
                  'line with adjusted Quantity.'+chr(13) +chr(13) +
                  'Either choose a different Unit of measure per line ' +
                  'or make all alterations on one line.' , mtinformation , [mbOk] , 0);

  if LockedAdjustAllocQty then
    if (Sysutils.SameText(fsFieldname , 'allocationfinalUomQty')) or
      (Sysutils.SameText(fsFieldname , 'AllocationAdjustUOMQty')) then
      if StockAdjust.Lines.dataset.findfield(fsFieldname) <> nil then
          MessageDlgXP_Vista(QuotedStr(lblEnforceUOM.caption)+' is  off.  ' +
                  'When ' + QuotedStr(lblEnforceUOM.caption)+'  if off, '+
                  'Product,Department, Bin and Batch combination can have only ' +
                  'one line with adjusted Quantity.'+chr(13) +chr(13) +
                  'Either choose a different Unit of measure per line ' +
                  'or make all alterations on one line.' , mtinformation , [mbOk] , 0);

end;

procedure TfmStockAdjustEntryflat.btnCompletedEnter(Sender: TObject);
begin
  inherited;
  if StockAdjust.Deleted then btnProcess.enabled := False;
end;

procedure TfmStockAdjustEntryflat.btnCloseEnter(Sender: TObject);
begin
  inherited;
  if StockAdjust.Deleted then btnProcess.enabled := False;
end;

procedure TfmStockAdjustEntryflat.grdTransactionsCalcTitleAttributes(
  Sender: TObject; AFieldName: String; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  inherited;
  if     (SameText(AFieldName , 'BinLocation'))
      or (SameText(AFieldName , 'binnumber'))
      or (SameText(AFieldName , 'Batchno'))
      or (SameText(AFieldName , 'ExpiryDate'))
      or (SameText(AFieldName , 'Serialnumber')) then begin
      ABrush.Color := pnlTitle.color;
      exit;
    end;
end;

procedure TfmStockAdjustEntryflat.grdTransactionsDblClick(Sender: TObject);
var
  sMatrixDesc:String;
  sMatrixRef:String;
  dMatrixPrice:double;
begin
  inherited;
  if (TField(grdTransactions.GetActiveField).FieldName = 'MatrixDesc') or (TField(grdTransactions.GetActiveField).FieldName = 'MatrixPrice') then begin
    sMatrixDesc := StockAdjust.Lines.MatrixDesc;
    sMatrixRef  := StockAdjust.Lines.MatrixRef;
    dMatrixPrice:= StockAdjust.Lines.MatrixPrice;
    TfmpartsPriceMatrixInput.PriceMAtrix(Self, sMatrixRef , sMatrixDesc , dMatrixPrice, StockAdjust.lines.ProductId, Myconnection);
    SetMatrixDetails(sMatrixDesc,sMatrixRef ,dMatrixPrice);
    Abort; // this is to cancel the memodialag popup for this field
  end;

end;

procedure TfmStockAdjustEntryflat.grdTransactionsTitleButtonClick(Sender: TObject; AFieldName: String);
var
  Key:Word;
begin
  if     (SameText(AFieldName , 'BinLocation'))
      or (SameText(AFieldName , 'binnumber'))
      or (SameText(AFieldName , 'Batchno'))
      or (SameText(AFieldName , 'ExpiryDate'))
      or (SameText(AFieldName , 'Serialnumber')) then begin
    Key := vk_f9;
    FormKeyDown(Sender , Key , []);
    exit;
  end else begin
      inherited;
  end;

end;

procedure TfmStockAdjustEntryflat.Hidecolumns;
begin
  inherited;
    Setcolumn(False,qryStockAdjustEntryLinesAccountID.fieldName);
    Setcolumn(False,qryStockAdjustEntryLinesAccountName.fieldName);
    Setcolumn(False,qryStockAdjustEntryLinesBinid.fieldName);
    Setcolumn(False,qryStockAdjustEntryLinesInStockQty.fieldName);
    Setcolumn(False,qryStockAdjustEntryLinesAllocationInStockQty.fieldName);
    if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnAllowtoSeecostInStockforms')<> 1 then begin
      SetColumn(False, qryStockAdjustEntryLinesUOMcost.Fieldname);
      SetColumn(False, qryStockAdjustEntryLinestotalCost.Fieldname);
    end;
end;

procedure TfmStockAdjustEntryflat.UpdateBarcode(const Barcode: String);
begin
  inherited;
  StockAdjust.Lines.PartBarcode := Barcode;
end;

initialization
with FormFact do begin
  RegisterMe(TfmStockAdjustEntryflat, 'TStockTakeListGUI_*=StockAdjustEntryID');

end;
  RegisterClassOnce(TfmStockAdjustEntryflat);
end.

