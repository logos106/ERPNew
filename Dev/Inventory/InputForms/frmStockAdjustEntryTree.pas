unit frmStockAdjustEntryTree;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  DB, MemDS, DBAccess, MyAccess,ERPdbComponents, Menus, AdvMenus,
  DataState, SelectionDialog, AppEvnts, ComCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, wwcheckbox, DBCtrls, Mask, wwdbdatetimepicker,
  DNMSpeedButton, wwdblook, Shader, ExtCtrls, DNMPanel, frmStockAdjustEntry, busobjbase,
  ImgList, ProgressDialog, ERPDbLookupCombo;

type
  TfmStockAdjustEntryTree = class(TfmStockAdjustEntry)
    qryStockAdjustEntryProductLines: TERPQuery;
    dsStockAdjustEntryProductLines: TDataSource;
    qryStockAdjustEntryProductLinesGLOBALREF: TWideStringField;
    qryStockAdjustEntryProductLinesSTOCKADJUSTENTRYLINESID: TIntegerField;
    qryStockAdjustEntryProductLinesSTOCKADJUSTENTRYID: TIntegerField;
    qryStockAdjustEntryProductLinesPRODUCTID: TIntegerField;
    qryStockAdjustEntryProductLinesPRODUCTNAME: TWideStringField;
    qryStockAdjustEntryProductLinesDESCRIPTION: TWideStringField;
    qryStockAdjustEntryProductLinesCLASSID: TIntegerField;
    qryStockAdjustEntryProductLinesCLASSNAME: TWideStringField;
    qryStockAdjustEntryProductLinesAVAILABLEQTY: TFloatField;
    qryStockAdjustEntryProductLinesAccountID:TIntegerField;
    qryStockAdjustEntryProductLinesAccountName:TWideStringfield;
    qryStockAdjustEntryProductLinesFINALQTY: TFloatField;
    qryStockAdjustEntryProductLinesADJUSTQTY: TFloatField;
    qryStockAdjustEntryProductLinesAVAILABLEUOMQTY: TFloatField;
    qryStockAdjustEntryProductLinesFINALUOMQTY: TFloatField;
    qryStockAdjustEntryProductLinesADJUSTUOMQTY: TFloatField;
    qryStockAdjustEntryProductLinesCOST: TFloatField;
    qryStockAdjustEntryProductLinesUOM: TWideStringField;
    qryStockAdjustEntryProductLinesUOMMULTIPLIER: TFloatField;
    qryStockAdjustEntryProductLinesDELETED: TWideStringField;
    qryStockAdjustEntryProductLinesUOMID: TIntegerField;
    qryStockAdjustEntryProductLinesMSTIMESTAMP: TDateTimeField;
    qryStockAdjustEntryProductLinesPQAAllocation: TWideStringField;
    qryStockAdjustEntryLinesAccountID: TIntegerField;
    qryStockAdjustEntryLinesAccountName: TWideStringField;
    qryStockAdjustEntryLinesSerialnos: TWideMemoField;
    qryStockAdjustEntryLinesBinid: TIntegerField;
    qryStockAdjustEntryProductLinesUOMCost: TFloatField;
    qryStockAdjustEntryProductLinesTotalcost: TFloatField;
    qryStockAdjustEntryProductLinesInStockQty: TFloatField;
    btnProcess: TDNMSpeedButton;
    qryStockAdjustEntryProcessed: TWideStringField;
    qryStockAdjustEntryProductLinesInStockUOMQty: TFloatField;
    qryStockAdjustEntryProductLinesPartBarcode: TWideStringField;
    qryStockAdjustEntryProductLinesParttype: TWideStringField;
    qryStockAdjustEntryProductLinesMatrixDesc: TWideMemoField;
    qryStockAdjustEntryProductLinesMatrixRef: TWideMemoField;
    qryStockAdjustEntryProductLinesMatrixPrice: TFloatField;

    qryStockAdjustEntryProductLinesFormulaQtyValue1: TFloatField;
    qryStockAdjustEntryProductLinesFormulaQtyValue2: TFloatField;
    qryStockAdjustEntryProductLinesFormulaQtyValue3: TFloatField;
    qryStockAdjustEntryProductLinesFormulaQtyValue4: TFloatField;
    qryStockAdjustEntryProductLinesFormulaQtyValue5: TFloatField;
    qryStockAdjustEntryProductLinesFormulaQtyValue: TFloatField;
    qryStockAdjustEntryAdjusttype: TWideStringField;
    btnLoadProducts: TDNMSpeedButton;
    qryStockAdjustEntryProductLinesNotes: TWideStringField;
    qryStockAdjustEntryProductLinesProductPrintName: TWideStringField;
    qryStockAdjustEntryProductLinesJobID: TIntegerField;
    qryStockAdjustEntryProductLinesJobName: TWideStringField;


    procedure btnToggleModeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure qryStockAdjustEntryProductLinesCalcFields(DataSet: TDataSet);
    procedure grdTransactionsDblClick(Sender: TObject);
    procedure qryStockAdjustEntryLinesAfterInsert(DataSet: TDataSet);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure grdTransactionsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnProcessClick(Sender: TObject);
    procedure chkEnforceUOMEnter(Sender: TObject);
    procedure cboUOMCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnLoadProductsClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure qryStockAdjustEntryAfterInsert(DataSet: TDataSet);
    procedure qryStockAdjustEntryProductLinesBeforePost(DataSet: TDataSet);
  private
    Procedure Showallocationform;
    Procedure PostLinesBeforeSave;
    function SaveStockAdjust:Boolean;
    procedure SelectProductFromreport(Sender: TwwDBGrid);
    Function QtyLocationsreport:boolean;
  Protected
    procedure initStockQtysLocationsReport(Sender: TObject);virtual;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string); override;
    Procedure checkWriteStatus(fsFieldname:String); override;
    Procedure UpdateBarcode(const Barcode:String);override;
    procedure SetMatrixDetails(sMatrixDesc, sMatrixRef: String;dMatrixPrice: double);Override;
    Procedure Hidecolumns;Override;
    function formAllocationType:String;virtual;
  public
    { Public declarations }
  end;


implementation

uses frmStockAdjustEntryFlat, CommonLib, BusObjConst,
  BusobjStockAdjustEntry, FastFuncs, frmStockAdjustEntryalloc,
  ProductQtyLib,  AppEnvironment, BusObjStock, FormFactory, tcConst,
  PartsPriceMatrixLib, frmpartsPriceMatrixInput, CommonFormLib, StockQtysLocationsReport, StockLib,
  tcDataUtils, LogLib,StockQtysLocationsBase;

{$R *.dfm}

procedure TfmStockAdjustEntryTree.btnToggleModeClick(Sender: TObject);
var
    form :TfmStockAdjustEntryflat;
begin
    Processingcursor(True);
    try
      if StockAdjust.Dirty then begin
        StockAdjust.postDB;
        StockAdjust.LineProducts.PostDB;
        SetFocusedControl(grdTransactions);
        StockAdjust.TempSave := True;
        try
          if not (StockAdjust.Save) then Exit;
        Finally
          StockAdjust.TempSave := False;
        end;
        StockAdjust.CreateFlatModeData;
        StockAdjust.Connection.CommitTransaction;
        Self.KeyId := StockAdjust.ID;
      end else begin
        StockAdjust.Connection.RollbackTransaction;
        StockAdjust.Dirty := false;
      end;
      StockAdjust.UserLock.UnlockAllCurrentInstance;
      Freeandnil(StockAdjust);
      form := TfmStockAdjustEntryflat(GetComponentByClassName('TfmStockAdjustEntryflat'));
      if Assigned(form) then begin
        form.KeyId := Self.KeyId;
        (*form.AllocationMode := Self.AllocationMode;*)
        form.FormStyle := fsMDIChild;
        form.BringToFront;
      end;
      Self.Close;
  finally
    Processingcursor(False);
  end;
end;

procedure TfmStockAdjustEntryTree.DoBusinessObjectEvent( const Sender: TDatasetBusObj; const EventType, Value: string);
var
  MatrixDesc:String;
  MatrixRef:String;
  MatrixPrice:double;
begin
  inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TSAELinestree then
            TSAELinestree(Sender).DataSet := qryStockAdjustEntryProductLines;
    end else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_QtyShipped) then begin
        //TfmAllocation.DoBinBatchform(Invoice.Lines.PQA, self);
        grdTransactions.SetActiveField('PQAallocation');
        Showallocationform;
    end else if(Eventtype = BusObjEvent_Change) and (Value = BusObjEventVal_ProductChanged) then begin
        if StockAdjust.LineProducts.ProductID <> 0 then begin
            StockAdjust.LineProducts.UOM := StockAdjust.LineProducts.Product.UOMSales;
            StockAdjust.LineProducts.UOMId := tcdatautils.GetUnitOfMeasureID(StockAdjust.LineProducts.UOM, StockAdjust.LineProducts.Product.ID);
            StockAdjust.LineProducts.PostDB;
            if not StockAdjust.LineProducts.deleted then begin
              ReadSalesDefaultPriceMethod(StockAdjust.LineProducts.ProductID, MatrixDesc, MatrixRef, MatrixPrice);
              SetMatrixDetails(MatrixDesc, MatrixRef, MatrixPrice);
            end;
        end;
    end else if (EventType = BusObjEvent_Change) And (value = BusObjEventVal_uomChanged) then begin
      if QryUOMUnitID.AsInteger <> StockAdjust.LineProducts.UnitOfMeasureID then begin
         closedb(QryUOM);
         opendb(QryUOM);
         QryUOM.locate('unitID' , StockAdjust.LineProducts.UnitOfMeasureID , []);
      end;
  end;
end;

function TfmStockAdjustEntryTree.formAllocationType: String;
begin
  Result := '';
end;

procedure TfmStockAdjustEntryTree.FormShow(Sender: TObject);
var
  i:Integer;
(*var
  bbatch,bbin, bsn :Boolean;*)
begin
  //TProduct.checkAllocation(bbatch,bbin, bsn);
(*  if AllocationMode and (bbatch or bbin or  bsn) then begin
        if cboProductQry.active then cboProductQry.close;
        cboProductQry.SQL.text := StringReplace(cboProductQry.SQL.text ,'#','',[rfIgnoreCase]);
  end else AllocationMode := False;*)
  inherited;
(*  if (not(bbatch)) and (not( bbin)) and (not(bsn)) then begin
    grdTransactions.RemoveField('PQAAllocation');
  end;*)

  qryJob.Open;

  if (StockAdjust.Processed) or (StockAdjust.Deleted) or (AccessLevel = 5) then begin
    btnProcess.Enabled := false;
  end
  else begin
    btnProcess.Enabled := true;
  end;

  i:= accesslevel;
  accesslevel:= 1;
  try
    showProgressbar(WAITMSG , 6);
    try
      StepProgressbar;
      //StockAdjust.Progressbar := ListProgressbar;
      StockAdjust.ShowStatus := ListShowStatus;
      try
        StockAdjust.CreateTreeModeData;      StepProgressbar;
        StockAdjust.LineProducts.Dataset.Filter:= 'Deleted <> ' + QuotedStr('T');      StepProgressbar;
        StockAdjust.LineProducts.Dataset.Filtered:= true;      StepProgressbar;
        StockAdjust.LineProducts;      StepProgressbar;
        StockAdjust.inTreemode := True;StepProgressbar;
      finally
        //StockAdjust.Progressbar := Progressbar;
        StockAdjust.ShowStatus := ShowStatus;
      end;
    finally
      HideProgressbar;
    end;
  finally
    accesslevel:= i;
  end;
  btnLoadProducts.Enabled := AccessLevel = 1;
end;

procedure TfmStockAdjustEntryTree.btnCompletedClick(Sender: TObject);
begin
  if SaveStockAdjust then begin
    inherited;
  end;
end;

procedure TfmStockAdjustEntryTree.qryStockAdjustEntryProductLinesBeforePost(
  DataSet: TDataSet);
begin
  inherited;
  if cboJob.Text = '' then
    qryStockAdjustEntryLinesJobID.AsInteger := 0
  else
    StockAdjust.LineProducts.JobID := qryJobJobID.AsInteger;
end;

procedure TfmStockAdjustEntryTree.qryStockAdjustEntryProductLinesCalcFields(
  DataSet: TDataSet);
begin
  inherited;
  StockAdjust.LineProducts.PQAAllocation := '+';
  qryStockAdjustEntryProductLinesTotalCost.asFloat  := round(qryStockAdjustEntryProductLinesCost.asFloat * qryStockAdjustEntryProductLinesAdjustQty.asFloat , CurrencyRoundPlaces);
  qryStockAdjustEntryProductLinesUOMCost.asFloat    := round(qryStockAdjustEntryProductLinesCost.asFloat * qryStockAdjustEntryProductLinesUOMMultiplier.asFloat , CurrencyRoundPlaces);
end;

function TfmStockAdjustEntryTree.QtyLocationsreport: boolean;
begin
  OpenERPListFormultiselectModal('TStockQtysLocationsReportGUI' ,initStockQtysLocationsReport , SelectProductFromreport);
  REsult := True;
end;

procedure TfmStockAdjustEntryTree.SelectProductFromreport(Sender: TwwDBGrid);
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
    StockAdjust.LineProducts.PostDB;
    StockAdjust.LineProducts.dataset.DisableControls;
    StockAdjust.LineProducts.DoFieldChangewhenDisabled := true;
    ds.DisableControls;
    try
      showProgressbar(WAITMSG, grd.SelectedList.Count);
      try
        for i := 0 to grd.SelectedList.Count - 1 do begin
          lblProgressbar.Caption := 'Adding ' + IntToStr(i) +' of ' + IntToStr(grd.SelectedList.Count) + ' record(s)';
          Application.ProcessMessages;
          ds.GotoBookmark(grd.SelectedList.Items[i]);
          StockAdjust.LineProducts.New;
          StockAdjust.LineProducts.ProductName         := ds.fieldByname('ProductName').asString;
          StockAdjust.LineProducts.DeptID              := ds.fieldbyname('DepartmentId').asInteger;
          if StockAdjust.LineProducts.AvailableQty<> ds.Fieldbyname('qty').asFloat then
            StockAdjust.LineProducts.AvailableQty    := ds.Fieldbyname('qty').asFloat;
          StockAdjust.LineProducts.PostDB;
          StepProgressbar;
        end;
      finally
        HideProgressbar;
      end;
    finally
        ds.EnableControls;
        StockAdjust.LineProducts.dataset.EnableControls;
    end;
  finally
    Form:= FindExistingComponent('TStockQtysLocationsReportGUI');
    if assigned(Form) then TStockQtysLocationsReportGUI(form).close;
    lblProgressbar.Caption := s;
  end;

end;

procedure TfmStockAdjustEntryTree.initStockQtysLocationsReport(Sender: TObject);
begin
  (*TStockQtysLocationsReportGUI(Sender).ProductId       := StockAdjust.LineProducts.ProductID;
  TStockQtysLocationsReportGUI(Sender).ClassID         := StockAdjust.LineProducts.ClassID;*)
  TStockQtysLocationsReportGUI(Sender).FormDisplayMode := tSummaryOnly;
end;

Procedure TfmStockAdjustEntryTree.Showallocationform;
var
    fsFieldname :STring;
begin
  fsFieldname := grdTransactions.GetActiveField.Fieldname;
  if Sysutils.SameText(fsFieldname , 'PQAallocation') then begin
    StockAdjust.LineProducts.postDB;
    StockAdjust.LineProducts.PQAAllocation := '-';
    try
      TfmStockAdjustEntryalloc.DoBinBatchform(StockAdjust.LineProducts.PQA, self);
    Finally
      StockAdjust.LineProducts.PQAAllocation := '+';
    End;
  end;
end;

procedure TfmStockAdjustEntryTree.grdTransactionsDblClick(Sender: TObject);
var
  sMatrixDesc:String;
  sMatrixRef:String;
  dMatrixPrice:double;
begin
  inherited;
  if (TField(grdTransactions.GetActiveField).FieldName = 'MatrixDesc') or (TField(grdTransactions.GetActiveField).FieldName = 'MatrixPrice') then begin
    sMatrixDesc := StockAdjust.LineProducts.MatrixDesc;
    sMatrixRef  := StockAdjust.LineProducts.MatrixRef;
    dMatrixPrice:= StockAdjust.LineProducts.MatrixPrice;
    TfmpartsPriceMatrixInput.PriceMAtrix(Self, sMatrixRef , sMatrixDesc , dMatrixPrice, StockAdjust.LineProducts.ProductId, Myconnection);
    SetMatrixDetails(sMatrixDesc,sMatrixRef ,dMatrixPrice);
    Abort; // this is to cancel the memodialag popup for this field
  end;
  Showallocationform;
end;

procedure TfmStockAdjustEntryTree.qryStockAdjustEntryAfterInsert(DataSet: TDataSet);
begin
  inherited;
  StockAdjust.Adjusttype := StockAdjustmenttypetoStr(satGen);
end;

procedure TfmStockAdjustEntryTree.qryStockAdjustEntryLinesAfterInsert(DataSet: TDataSet);
begin
  inherited;
    if ProductId <> 0 then StockAdjust.LineProducts.ProductID := ProductID;
end;

procedure TfmStockAdjustEntryTree.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Do you wish to delete this record?', mtconfirmation, [mbYes, mbNo], 0)  = mrNo then exit;
  StockAdjust.LineProducts.Deleted := true;
  StockAdjust.LineProducts.PostDB;
end;

procedure TfmStockAdjustEntryTree.btnLoadProductsClick(Sender: TObject);
begin
  inherited;
  QtyLocationsreport;
end;

procedure TfmStockAdjustEntryTree.btnPrintClick(Sender: TObject);
var
  sSQL: String;
  ReadPQADetailTablename: String;
  ReadPQAtablename:String;
  ReadLineTablename:String;
begin
  {as long as the stockadjustment is not processed, the records are stored in the flat table structure
  and the tree form is populated from temporary table}
//  if not SaveStockAdjust then exit;
  if not self.StockAdjust.ValidateData then exit;
  try
    sSQL := ProductTables(tDetailswithSno, False, false, 0 , false ) ;

    ReadPQADetailTablename:= BusobjStockAdjustEntry.ReadPQADetailTablename;
    ReadPQAtablename      := BusobjStockAdjustEntry.ReadPQAtablename;
    ReadLineTablename     := BusobjStockAdjustEntry.ReadLineTablename ;

    sSQL := StringReplace(sSQL , '`tblPQADetails`' , ReadPQADetailTablename+' ', [rfReplaceAll, rfIgnoreCase]) ;
    sSQL := StringReplace(sSQL , '`tblPQA`' , ReadPQAtablename+' ', [rfReplaceAll, rfIgnoreCase]) ;
    sSQL := '{COmpanyInfo}Select * from tblCompanyInformation~|||~'+
          '{Detail}SELECT  ' +
          ' SA.StockAdjustEntryID, PBin.Binlocation, PBin.binnumber,PQABatch.Value as batchno,  ' +
          ' PQABatch.ExpiryDate,  ' +
          ' (if (ifnull(PQABins.PQADEtailID,0)=0 , PQABatch.UOMQty , PQABins.UOMQty)) as BinQty,'+
          ' /*GROUP_CONCAT(PQASN.Value, char(13))*/ PQASN.Value as SoldSerials,' +
          ' SAL.ACCOUNTID,SAL.ACCOUNTNAME,SAL.PRODUCTID,SAL.PRODUCTNAME, ' +
          ' SAL.DESCRIPTION,SAL.CLASSID,SAL.CLASSNAME,SAL.AVAILABLEUOMQTY, ' +
          ' SAL.FINALUOMQTY,SAL.ADJUSTUOMQTY,SAL.COST,SAL.UOM,SAL.UOMMULTIPLIER,' +
          ' SA.CreationDate,SA.Adjustmentdate,SA.AccountID AS HAccountID, ' +
          ' SA.Accountname AS HAccountName,SA.Notes,SA.IsStocktake, ' +
          ' SA.Employee,SA.Deleted,SA.Processed,'+
          ' SAL.InStockQty ,   SAL.Cost * SAL.AdjustQty as TotalLineCost,' +
          ' SAL.Notes as LineNotes' +
          ' FROM ' + sSQL +
          ' inner join ' + ReadLineTablename + ' as SAL on SAL.StockAdjustEntryID = PQA.TransID and SAL.StockAdjustEntryLinesID = PQA.TransLineId and PQA.TRanstype = "TSAELinestree"'+
          ' inner join tblstockadjustentry as SA   on SA.StockAdjustEntryID = SAL.StockAdjustEntryID' +
          ' WHERE SA.StockAdjustEntryID= ' + IntToStr(StockAdjust.ID) +
          ' /*Group by  SAL.STOCKADJUSTENTRYLINESID, PQABatch.Value , PQABatch.ExpiryDate, PBin.binnumber,PBin.Binlocation, SAL.ProductId, SAL.CLASSID*/ order by productname , classname';
    fbReportSQLSupplied := True;
    ConnectionFormReport := Myconnection;
    PrintTemplateReport('Stock Adjustment', sSQL, not(devmode) and (not AppEnv.Employee.ShowPreview), 1);
  finally
    SaveStockAdjust;
  end;
  Close;

end;

procedure TfmStockAdjustEntryTree.grdTransactionsMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  Showallocationform;
end;

procedure TfmStockAdjustEntryTree.Hidecolumns;
begin
  inherited;
    Setcolumn(False, qryStockAdjustEntryLinesAccountID.fieldname);
    Setcolumn(False, qryStockAdjustEntryLinesAccountName.fieldname);
    Setcolumn(False, qryStockAdjustEntryLinesBinid.fieldname);
    Setcolumn(False, qryStockAdjustEntryProductLinesInStockQty.fieldname);
    Setcolumn(False, qryStockAdjustEntryProductLinesUOMMULTIPLIER.fieldname);
    Setcolumn(False, qryStockAdjustEntryProductLinesParttype.fieldname);
    if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnAllowtoSeecostInStockforms')<> 1 then begin
      SetColumn(False, qryStockAdjustEntryProductLinesCOST.Fieldname);
      SetColumn(False, qryStockAdjustEntryProductLinesUOMCost.Fieldname);
      SetColumn(False, qryStockAdjustEntryProductLinesTotalcost.Fieldname);
    end;
end;

procedure TfmStockAdjustEntryTree.btnProcessClick(Sender: TObject);
begin
  inherited;
  if StockAdjust.Deleted then exit;
  PostLinesBeforeSave;
  if StockAdjust.LineProducts.count = 0 then begin
     StockAdjust.Resultstatus.AddItem(False , rssWarning, 0 , 'No Products For Adjustment.' );
    Exit;
  end;
  if not StockAdjust.Process then Exit;
  StockAdjust.Dirty := False;
  StockAdjust.connection.CommitTransaction;
  StockAdjust.CreateFlatModeData;
  Self.close;
end;

procedure TfmStockAdjustEntryTree.chkEnforceUOMEnter(Sender: TObject);
begin
    SavedAccessLevel := AccessLevel;
    if StockAdjust.LineProducts.count = 0 then exit;
    inherited;
end;

procedure TfmStockAdjustEntryTree.cboUOMCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  cboUOM.text := StockAdjust.LineProducts.UOM;
end;

procedure TfmStockAdjustEntryTree.PostLinesBeforeSave;
begin
  SetControlFocus(cboAccount);
  StockAdjust.LineProducts.PostDB;
  StockAdjust.LineProducts.Dataset.disablecontrols;
  try
    StockAdjust.LineProducts.Dataset.Filtered := False;
    StockAdjust.LineProducts.Dataset.Filtered := True;
  finally
    StockAdjust.LineProducts.Dataset.enablecontrols;
  end;
end;

procedure TfmStockAdjustEntryTree.checkWriteStatus(fsFieldname: String);
begin
  inherited;
  if LockedAdjustQty then
  if (Sysutils.SameText(fsFieldname , 'AdjustUOMQty')) or (Sysutils.SameText(fsFieldname , 'finalUomQty')) then
    if StockAdjust.LineProducts.dataset.findfield(fsFieldname) <> nil then
      if StockAdjust.LineProducts.dataset.findfield(fsFieldname).REadonly then
        MessageDlgXP_Vista(QuotedStr(lblEnforceUOM.caption)+' is  off.  When ' + QuotedStr(lblEnforceUOM.caption)+'  if off, Product and Department combination can have only one line with adjusted Quantity.', mtinformation , [mbOk] , 0);
end;

function TfmStockAdjustEntryTree.SaveStockAdjust: Boolean;
begin
Result := False;
try
  PostLinesBeforeSave;
  if (StockAdjust.LineProducts.count = 0) and (StockAdjust.StockMovement.Lines.Count = 0) then begin
     StockAdjust.Resultstatus.AddItem(False , rssWarning, 0 , 'No Products For Adjustment.' );
    Exit;
  end;
  if StockAdjust.dirty then begin
    StockAdjust.postDB;
    StockAdjust.LineProducts.PostDB;
    if not StockAdjust.Save then exit;
   if not StockAdjust.Deleted then StockAdjust.CreateFlatModeData;
  end;
  StockAdjust.Connection.CommitTransaction;
  StockAdjust.DeleteSAELineTables;
  Result := true;
Except
    on E:Exception do begin
        Result := False;
    end;
end;
end;

procedure TfmStockAdjustEntryTree.SetMatrixDetails(sMatrixDesc,
  sMatrixRef: String; dMatrixPrice: double);
begin
  inherited;
    StockAdjust.LineProducts.MatrixDesc := sMatrixDesc;
    StockAdjust.LineProducts.MatrixRef  := sMatrixRef;
    StockAdjust.LineProducts.MatrixPrice:= dMatrixPrice;
    StockAdjust.LineProducts.PostDB;
end;

procedure TfmStockAdjustEntryTree.FormCreate(Sender: TObject);
begin
  AllowGridSorting  := True;
  inherited;
end;

procedure TfmStockAdjustEntryTree.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if StockAdjust.Processed then exit;

  if Key = VK_F9 then begin
    if QtyLocationsreport then exit;
  end;

end;

procedure TfmStockAdjustEntryTree.UpdateBarcode(const Barcode: String);
begin
  inherited;
  StockAdjust.LineProducts.PartBarcode := Barcode;
end;

initialization
    RegisterClassOnce(TfmStockAdjustEntryTree);
  with FormFact do
  begin
    RegisterMe(TfmStockAdjustEntryTree, 'TStockAdjustEntryListGUI_*_Gen=StockAdjustEntryID');
    RegisterMe(TfmStockAdjustEntryTree, 'TStockAdjustAccountListGUI_*_Gen=StockAdjustEntryID');
    RegisterMe(TfmStockAdjustEntryTree, 'TStockTakeListGUI_*_=StockAdjustEntryID');
    RegisterMe(TfmStockAdjustEntryTree, 'TStockAdjustEntryDetailListGUI_*_Gen=StockAdjustEntryID');
    RegisterMe(TfmStockAdjustEntryTree, 'TStockAdjustEntryDetailVariaceListGUI_*_Gen=StockAdjustEntryID');
    RegisterMe(TfmStockAdjustEntryTree, 'TSerialNumberHistoryGUI_transtype_GenStockAdjustEntry=StockAdjustEntryID');
    RegisterMe(TfmStockAdjustEntryTree, 'TBalTransListGUI_*_GenStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryTree, 'TGlobalsearchGUI_*_Stock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryTree, 'TBalTransListGUI_*_GenStockAdjustEntry=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryTree, 'TInventoryAssetVsStockStautsGUI_*_Stock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryTree, 'TTrialBalTransListGUI_*_GenStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryTree, 'TTransactionListGUI_*_GenStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryTree, 'TBASTransReturnListGUI_*_GenStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryTree, 'TNZTransReturnListGUI_*_GenStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryTree, 'TVATTransReturnListGUI_*_GenStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryTree, 'TTransAccountDetailsGUI_*_GenStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryTree, 'TGeneralLedgerReportGUI_*_GenStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryTree, 'TStockStatusReportGUI_*_GenStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryTree, 'TStockStatusRoling_*_GenStock Adjustment=StockAdjustentryID');
    //RegisterMe(TfmStockAdjustEntryTree, 'TExpenseClaimListGUI_*_GenStock Adjustment=StockAdjustentryID');
    //RegisterMe(TfmStockAdjustEntryTree, 'TGlobalsearchGUI_*_GenStock Adjustment=StockAdjustentryID');
    //RegisterMe(TfmStockAdjustEntryTree, 'TApprovalReminderListGUI_*_GenStock Adjustment=StockAdjustentryID');
    //RegisterMe(TfmStockAdjustEntryTree, 'TBankAccountListGUI_*_GenStock Adjustment=StockAdjustentryID');
    //RegisterMe(TfmStockAdjustEntryTree, 'TAccountsPayableNotes_*_GenStock Adjustment=StockAdjustentryID');
    //RegisterMe(TfmStockAdjustEntryTree, 'TAccountsPayListGUI_*_GenStock Adjustment=StockAdjustentryID');
    //RegisterMe(TfmStockAdjustEntryTree, 'TToBeReconciledGUI_*_GenStock Adjustment=StockAdjustentryID');
    //RegisterMe(TfmStockAdjustEntryTree, 'TReconListDetailFormGUI_*_GenStock Adjustment=StockAdjustentryID');
  end;

end.
