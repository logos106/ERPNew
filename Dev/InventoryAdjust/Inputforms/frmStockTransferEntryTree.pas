unit frmStockTransferEntryTree;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmStockTransferEntryBase, DB, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, DBCtrls,
  wwdbedit, Shader, wwcheckbox, DNMSpeedButton, wwdblook, Buttons, Wwdbigrd, Grids, Wwdbgrid, DNMPanel, wwdbdatetimepicker, Mask, busobjstockTransferentry , BusObjBase,
  ERPDbLookupCombo;

type
  TfmStockTransferEntryTree = class(TfmStockTransferEntryBase)
    tblDetailsPQAFrom: TStringField;
    tblDetailsPQAto: TStringField;
    chkhideBarcode: TwwCheckBox;
    Bevel3: TBevel;
    Label7: TLabel;
    btnAutoFill: TDNMSpeedButton;
    procedure SubformDetailsDblClick(Sender: TObject);
    procedure tblDetailsCalcFields(DataSet: TDataSet);
    procedure tblMasterAfterInsert(DataSet: TDataSet);
    procedure SubformDetailsDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure chkhideBarcodeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAutoFillClick(Sender: TObject);
    procedure cboProductBeforeOpenList(Sender: TObject);
  private
    function Showallocationform: Boolean;
    function CopyAllocationToTransferto: boolean;
  Protected
    (*function StockTransferLines :TSTELines;Override;*)
    procedure Initform;Override;
    Procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string); Override;
    procedure initStockQtysLocationsReport(Sender: TObject);Override;
    Procedure HideallocationFields;Override;
  public
  end;

implementation

uses CommonLib, tcDataUtils, frmAllocation, frmStockTransferEntryalloc, AppEnvironment, StockLib, FormFactory, StockQtysLocationsReport, busobjPQA, CommonDbLib,  frmStockTransferEntry,
  frmStockTransferEntryBatch, frmStockTransferEntryBin, frmStockTransferEntrySN,
  InventoryLib, ProductListExpressForm;

{$R *.dfm}

procedure TfmStockTransferEntryTree.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
(*  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset)  and (Sender is TSTELinesTreeIn) then
    TSTELinesTreeIn(Sender).DataSet := tblDetails;*)
  inherited;

end;


procedure TfmStockTransferEntryTree.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  GuiPrefs.Node['Options.HideBarcode'].asBoolean := chkhideBarcode.checked;
end;

procedure TfmStockTransferEntryTree.FormShow(Sender: TObject);
var
s:String;
begin
  inherited;
  tblMasterDateTransferred.DisplayFormat := FormatSettings.ShortDateFormat;
  chkhideBarcode.checked :=GuiPrefs.Node['Options.HideBarcode'].asBoolean;
  chkhideBarcodeClick(chkhideBarcode);
  s:= '';

  if (KeyId =0) or ( tblMasterProcessed.asBoolean=False) then
          if self is TfmStockTransferEntryBatch then s:= BatchAdjhint(False)
    else  if self is TfmStockTransferEntryBin   then s:= BinAdjhint(False)
    else  if self is TfmStockTransferEntrySN    then s:= SNAdjhint(False);

  if s<> '' then begin
    MessageDlg(s, mtInformation, [mbOK], 0);
    timerMsg(lblMessage, s, 20, clred);
  end;
end;

procedure TfmStockTransferEntryTree.HideallocationFields;
begin
  inherited;
  GuiPrefs.DbGridElement[SubformDetails].HideField(tblDetailsPQAFrom.fieldname);
  GuiPrefs.DbGridElement[SubformDetails].HideField(tblDetailsPQAto.fieldname);
end;

procedure TfmStockTransferEntryTree.Initform;
var
  QueryNamesNotToOpen: array of string;
begin
      Setlength(QueryNamesNotToOpen, 2);
      QueryNamesNotToOpen[0] := 'tblMaster';
      QueryNamesNotToOpen[1] := 'tblDetails';
      OpenQueries;
      StockTransfer.Load(KeyID);
      StockTransfer.TreeLines.Dataset.Filter:= 'Deleted <> ' + QuotedStr('T');
      StockTransfer.TreeLines.Dataset.Filtered:= true;
  inherited;

end;

procedure TfmStockTransferEntryTree.initStockQtysLocationsReport(Sender: TObject);
begin
  inherited;
  if not(Sender is TStockQtysLocationsReportGUI) then exit;
  TStockQtysLocationsReportGUI(Sender).grpFilters.ItemIndex := 0;
  TStockQtysLocationsReportGUI(Sender).AddfilterString('Batch = ' +quotedstr('T') +' or Bin = ' +quotedstr('T')+' or SN = ' + Quotedstr('T'));
end;

function TfmStockTransferEntryTree.Showallocationform:Boolean;
var
    fsFieldname :STring;
    islocked:Boolean;
begin
  Result := False;
  try
    fsFieldname := SubformDetails.GetActiveField.Fieldname;
    if Sysutils.SameText(fsFieldname , tbldetailsPQAfrom.FieldName) or  Sysutils.SameText(fsFieldname , tbldetailsPQATo.FieldName) then begin
        if (StockTransfer.TreeLines.ProductId =0) then exit;

        if (StockTransfer.TreeLines.Qty=0) then begin
          MessageDlgXP_Vista('Please select a Quantity to transfer', mtWarning, [mbOK], 0);
          Exit;
        end;

        if (StockTransfer.TreeLines.ClassIDto=0) then begin
          MessageDlgXP_Vista('Please select a ' + Appenv.DefaultClass.ClassHeading+' to transfer.', mtWarning, [mbOK], 0);
          Exit;
        end;

        if not (IsInvProduct(StockTransfer.TreeLines.Product.Producttype)) then begin
          MessageDlgXP_Vista(StockTransfer.TreeLines.productname + ' is ' + quotedstr(Producttypename(StockTransfer.TreeLines.product.ProductType)) +' type.  Allocation is only for inventory products', mtWarning, [mbOK], 0);
          exit;
        end;

        if (StockTransfer.TreeLines.product.Batch = False) and ( StockTransfer.TreeLines.product.Multiplebins = False) and ( StockTransfer.TreeLines.product.SnTracking = False) Then begin
          MessageDlgXP_Vista(StockTransfer.TreeLines.productname + ' has none of the allocations  - Batch / Bin / Serial Number tracking - turned on', mtWarning, [mbOK], 0);
          exit;
        end;

        REsult := True;

        if Sysutils.SameText(fsFieldname , tbldetailsPQAfrom.FieldName)  then begin
          StockTransfer.TreeLines.pqaFromAllocation := '-';
          try
            islocked := (AccessLevel >= 5 ) OR
                      ((tblDetails.findField('UnitofMeasureShipped') <> nil) and (tblDetails.findField('UnitofMeasureShipped').readonly)) OR
                      (not(dgEditing in SubformDetails.Options));
            StockTransfer.TreeLines.PostDB;
            TfmStockTransferEntryalloc.DoBinBatchform(StockTransfer.TreeLines.STEPQA, self, islocked, true);
            StockTransfer.TreeLines.PostDB;
            if not CopyAllocationToTransferTo then begin
                MessageDlgXP_vista('Bins are not created for the transfer to department ' + Quotedstr(StockTransfer.TreeLines.ClassNameTo)+'.'+
                                   'The Allocation is copied across with blank Bin.'+
                                   'Please make sure you either create and assign the Bins to it or change and fix the allocation.'+
                                   'Cancelling the allocation will delete all the Bin allocation(s) without a valid Bin.', mtWarning, [mbOK], 0);
            end;
            SubformDetails.SetActiveField(tbldetailsPQATo.FieldName);
            Showallocationform;
          finally
              StockTransfer.TreeLines.PQAFromAllocation := '+';
          End;

        end else begin


          if StockTransfer.TreeLinesIn.ClassID =0 then begin
            MessageDlgXP_Vista('Please Select the '  + Appenv.defaultclass.classheading +' to Transfer ' + StockTransfer.TreeLines.productname + ' to.', mtWarning, [mbOK], 0);
            exit;
          end;
          StockTransfer.TreeLines.pqaToAllocation := '-';
          try
            islocked := (AccessLevel >= 5 ) OR
                      ((tblDetails.findField('UnitofMeasureShipped') <> nil) and (tblDetails.findField('UnitofMeasureShipped').readonly)) OR
                      (not(dgEditing in SubformDetails.Options));
            StockTransfer.TreeLines.PostDB;
            TfmStockTransferEntryalloc.DoBinBatchform(StockTransfer.TreeLinesIn.STEPQA, self, islocked, true);
            StockTransfer.TreeLinesIn.PostDB;
          finally
              StockTransfer.TreeLines.PQAToAllocation := '+';
          End;
        end;
    end;
  Except
    on E:EXception do begin
      MessageDlgXP_Vista('1:' +E.Message, mtWarning, [mbOK], 0);
    end;
  end;
end;
(*function TfmStockTransferEntryTree.StockTransferLines: TSTELines;
begin
  REsult:=StockTransfer.TreeLines;
end;*)
procedure TfmStockTransferEntryTree.btnAutoFillClick(Sender: TObject);
begin
  inherited;
  if Stocktransfer.Dirty then begin
    if CommonLib.MessageDlgXP_Vista('Do You Wish To Cancel These Changes You Have Made?', mtWarning, [mbYes, mbNo], 0)  = mrno then exit;
    Stocktransfer.Connection.RollbackTransaction;
    Stocktransfer.Dirty := false;
  end;
  try
    Stocktransfer.UserLock.UnlockAllCurrentInstance;
    UnlockRelatedTables;
    // since the flat form also updates the same table, the locks are cleared here
    TfmStockTransferEntry.AutoTransfer(0, 0,'','' , true); // IGNORE the check for available qty in the transferfrom Department - DENE
  finally
    Self.Close;
  end;
end;

procedure TfmStockTransferEntryTree.cboProductBeforeOpenList(Sender: TObject);
begin
  inherited;
    if sender is TProductListExpressGUI then
           if self is TfmStockTransferEntrySN     then TProductListExpressGUI(Sender).FilterString := 'SNTracking=' + quotedstr('T')
      else if self is TfmStockTransferEntryBin    then TProductListExpressGUI(Sender).FilterString := 'MultipleBins=' + quotedstr('T')
      else if self is TfmStockTransferEntryBatch  then TProductListExpressGUI(Sender).FilterString := 'batch=' + quotedstr('T');
end;

procedure TfmStockTransferEntryTree.chkhideBarcodeClick(Sender: TObject);
begin
  inherited;
  if chkhideBarcode.checked then begin
    tblDetailsPartBarcode.Visible := False;
  end else begin
    tblDetailsPartBarcode.Visible := TRue;
    tblDetailsPartBarcode.Index :=0;
  end;

end;

Function TfmStockTransferEntryTree.CopyAllocationToTransferto:boolean;
  Function CreatebinifReqd:Boolean;
    var
      fsfilter:String;
      fbfiltered:Boolean;
      SQL1, SQL2, filename:String;
  begin
    REsult:= False;
    try
      fsfilter:=StockTransfer.TreeLines.STEPQA.PQADetails.Filter;
      fbfiltered:=StockTransfer.TreeLines.STEPQA.PQADetails.Filtered;
      try
        StockTransfer.TreeLines.STEPQA.PQADetails.Filter := 'PQAtype = ' +quotedstr(TPQABins.pqadetailtype);
        StockTransfer.TreeLines.STEPQA.PQADetails.filtered := TRue;
        if (StockTransfer.TreeLines.STEPQA.PQADetails.count >0) and (StockTransfer.TreeLines.Product.MultipleBins) and (StockTransfer.TreeLines.STEPQA.hasBinAllocation) then begin
            if MessageDlgXP_Vista('Would you like to create the Bins in the transfering into ' + Appenv.DefaultClass.classheading+' ?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
            InsertInToTemporaryTableusingfile(TERPConnection(StockTransfer.Connection.Connection), 'tblproductbin' ,  ' Select '+
                                        ' STEL.ClassIDTo, PB.BinLocation, PB.BinNumber, STEL.ClassNameTo, "T", PB.volume '+
                                        ' from tblstocktransferentrylines STEL inner join tblstocktransferentrypqa PQA on STEL.TransferEntryID = PQA.TransID and STEL.TransferEntryLinesID = PQA.TransLineID '+
                                        ' inner join tblstocktransferentrypqaDetails PQAD on PQA.pqaid = PQAD.PQAID '+
                                        ' inner join tblproductbin PB on PQAD.Value = PB.BinID '+
                                        ' Where PQA.PQAID = ' + inttostr(StockTransfer.TreeLines.STEPQA.ID)  ,'ClassId,BinLocation,BinNumber,ClassName,Active,volume',  SQL1, SQL2,filename);
            if SQL1 <> '' then StockTransfer.ExecuteSQL(SQL1, True);
            if SQL2 <> '' then StockTransfer.ExecuteSQL(SQL2, false);
        end;
        Result:= True;
      finally
        StockTransfer.TreeLines.STEPQA.PQADetails.Filter:= fsfilter;
        StockTransfer.TreeLines.STEPQA.PQADetails.Filtered:= fbfiltered;
      end;
    finally
      if filename <> '' then AppEnv.UtilsClient.DeleteServerFiles(replaceStr(filename, '.tmp' , '*.tmp'));
    end;
  end;
  Procedure CopyAllocation;
        var
          strSQL: string;
          tablename: string;
          clonePQADetails: TPQADetails;
          qryPQADetails: TERPQuery;
          IDs: string;
          SQLs: TStringList;
        begin
            tablename := GetUserTemporaryTableName('STEallocation');
            try

              strSQL :='drop table if exists ' +tablename +';' +
                    ' CREATE TABLE '+tablename +' (' +
                    '   Globalref varchar(255) DEFAULT NULL,' +
                    ' 	ID INT(11) NOT NULL AUTO_INCREMENT,' +
                    '   Qty double DEFAULT NULL,' +
                    '   UOMQty double DEFAULT NULL,' +
                    '   PQAType enum("Batch","Bin","SN","") CHARACTER SET latin1 DEFAULT NULL,' +
                    '   ParentRef varchar(255) DEFAULT NULL,' +
                    '   Value varchar(100) DEFAULT NULL,' +
                    '   ExpiryDate datetime DEFAULT NULL,' +
                    '   binlocation varchar(30) DEFAULT NULL,' +
                    '   binnumber varchar(30) DEFAULT NULL,' +
                    '   ClassIDTo int(11) DEFAULT "0",' +
                    '   Newglobalref varchar(255) DEFAULT NULL,' +
                    ' 	PRIMARY KEY (ID)' +
                    ' ) ENGINE=MyISAM DEFAULT CHARSET=utf8;';

              StockTransfer.ExecuteSQL(strSQL, False);

              strSQL := ' select * from ' + tablename + ' order by Globalref';
              qryPQADetails := TERPQuery(StockTransfer.getnewDataset(strSQL, False));
              try
                strSQL:=   ' select PQAD.Globalref, PQAD.Qty , PQAD.UOMQty , PQAD.PQAType , PQAD.ParentRef, PQAD.Value , PQAD.ExpiryDate, PB.binlocation, PB.binnumber, STEL.ClassIDTo ' +
                                ' from tblstocktransferentrylines STEL  '+
                                ' inner join tblstocktransferentrypqa PQA on STEL.TransferEntryID = PQA.TransID and STEL.TransferEntryLinesID = PQA.TransLineID '+
                                ' inner join tblstocktransferentrypqaDEtails PQAD on PQA.pqaid = PQAD.PQAID '+
                                ' Left join tblproductbin PB on PQAD.Value = PB.BinID '+
                                ' Where PQA.PQAID = ' + inttostr(StockTransfer.TreeLines.STEPQA.ID) ;


                With StockTransfer.GetNewDataSet(strSQL, true) do try
                  if recordcount =0 then exit;
                  First;
                  While Eof = False do begin
                    qryPQADetails.append;
                    qryPQADetails.FieldByname('Globalref').AsString   := FieldByname('Globalref').AsString;
                    qryPQADetails.FieldByname('Qty').AsFloat          := FieldByname('Qty').AsFloat;
                    qryPQADetails.FieldByname('UOMQty').AsString      := FieldByname('UOMQty').AsString;
                    qryPQADetails.FieldByname('PQAType').AsString     := FieldByname('PQAType').AsString;
                    qryPQADetails.FieldByname('ParentRef').AsString   := FieldByname('ParentRef').AsString;
                    qryPQADetails.FieldByname('Value').AsString       := FieldByname('Value').AsString;
                    qryPQADetails.FieldByname('ExpiryDate').asDateTime:= FieldByname('ExpiryDate').asDateTime;
                    qryPQADetails.FieldByname('binlocation').AsString := FieldByname('binlocation').AsString;
                    qryPQADetails.FieldByname('binnumber').AsString   := FieldByname('binnumber').AsString;
                    qryPQADetails.FieldByname('ClassIDTo').asInteger  := FieldByname('ClassIDTo').asInteger;
                    qryPQADetails.Post;
                    Next;
                  end;
                finally
                  if active then close;
                  Free;
                end;

                clonePQADetails := StockTransfer.TreeLines.STEPQA.NewPQADetailObj(StockTransfer.TreeLinesIn.STEPQA.ID);
                IDs := '';
                if qryPQADetails.recordcount = 0 then Exit;
                qryPQADetails.first;
                while qryPQADetails.Eof = False do begin
                  clonePQADetails.New;
                  clonePQADetails.PQAID := StockTransfer.TreeLinesIn.STEPQA.ID;
                  clonePQADetails.Qty := qryPQADetails.fieldByname('Qty').asFloat;
                  clonePQADetails.UOMQty := qryPQADetails.fieldByname('UOMQty').asFloat;
                  clonePQADetails.PQAType := qryPQADetails.fieldByname('PQAType').asString;
                  clonePQADetails.ParentRef := qryPQADetails.fieldByname('ParentRef').asString;
                  if clonePQADetails.PQAType = TPQABins.pqadetailtype then begin
                    clonePQADetails.PQAValue := inttostr(tcdatautils.GetBinID(qryPQADetails.fieldByname('Binlocation').asString, qryPQADetails.fieldByname('Binnumber').asString , qryPQADetails.fieldByname('ClassIDTo').asInteger));
                    clonePQADetails.binId := tcdatautils.GetBinID(qryPQADetails.fieldByname('Binlocation').asString, qryPQADetails.fieldByname('Binnumber').asString , qryPQADetails.fieldByname('ClassIDTo').asInteger);
                  end else begin
                    clonePQADetails.PQAValue :=qryPQADetails.fieldByname('Value').asString;
                  end;
                  if qryPQADetails.fieldByname('ExpiryDate').asDatetime <> 0 then clonePQADetails.ExpiryDate := qryPQADetails.fieldByname('ExpiryDate').asDatetime;
                  clonePQADetails.PostDb;
                  if IDs <> '' then IDs := IDs + ',';
                  IDs := IDs + inttostr(clonePQADetails.ID);
                  qryPQADetails.edit;
                  qryPQADetails.fieldByname('Newglobalref').asString := clonePQADetails.Globalref;
                  qryPQADetails.Post;
                  qryPQADetails.next;
                end;
                if qryPQADetails.recordcount = 0 then Exit;
                qryPQADetails.first;
                SQLs := TStringList.Create;
                try
                  while qryPQADetails.Eof = False do begin
                    SQLs.Add('update tblstocktransferentrypqaDetails set ParentREf = ' + Quotedstr(qryPQADetails.fieldByname('Newglobalref').asString) + ' where ParentRef = ' +
                      Quotedstr(qryPQADetails.fieldByname('Globalref').asString) + ' and PQADetailID in (' + IDs + ');');
                    qryPQADetails.next;
                  end;
                  if SQLs.Count>0 then StockTransfer.ExecuteSQL(SQLs, true);
                finally FreeandNil(SQLs);
                end;
              finally
                if qryPQADetails.Active then qryPQADetails.close;
                FreeandNil(qryPQADetails);
              end;
            finally
              strSQL := ' drop table if exists ' + tablename;
              StockTransfer.getnewDataset(strSQL, False);
            end;
        end;
begin
  REsult:= true;
  if StockTransfer.TreeLinesIn.STEPQA.PQADetails.Count >0 then exit;
  if StockTransfer.TreeLines.STEPQA.PQADetails.count =0 then exit;
  StockTransfer.userallocating := True;
  try
      (*if not CreateBinifReqd then exit;*)
      REsult :=CreateBinifReqd ;
      //if not result then exit;
      Copyallocation;
  finally
    StockTransfer.userallocating := False;
  end;
end;

procedure TfmStockTransferEntryTree.SubformDetailsDblClick(Sender: TObject);
begin
  inherited;
  Showallocationform;
end;

procedure TfmStockTransferEntryTree.SubformDetailsDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then begin
    SubformDetails.OnDblClick(SubformDetails);
    Key := 0;
    exit;
  end;
end;

procedure TfmStockTransferEntryTree.tblDetailsCalcFields(DataSet: TDataSet);
begin
  inherited;
  if tblDetails.recordcount > 0 then begin
    tblDetailsPQAFrom.AsString := '+';
    tblDetailsPQAto.AsString := '+';
  end;
end;

procedure TfmStockTransferEntryTree.tblMasterAfterInsert(DataSet: TDataSet);
begin
  inherited;
  StockTransfer.Transfertype := StockTransfertypetoStr(sttTree);
end;
initialization
  with FormFact do begin
    RegisterMe(TfmStockTransferEntryTree, 'TStockTransferEntryListGUI_*_Tree=TransferEntryID');
    RegisterMe(TfmStockTransferEntryTree, 'TProductQtyOnTransitGUI_*_Tree=TransferEntryID');
    RegisterMe(TfmStockTransferEntryTree, 'TSalesStockTransferListGUI_*_Tree=TransferEntryID');
    RegisterMe(TfmStockTransferEntryTree, 'TSerialNumberHistoryGUI_transtype_TreeStockTransferEntry=StockAdjustEntryID');
    RegisterMe(TfmStockTransferEntryTree, 'TBalTransListGUI_*_TreeStock Transfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntryTree, 'TToBeReconciledGUI_*_TreeStock Transfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntryTree, 'TTransactionListGUI_*_TreeStock Transfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntryTree, 'TBASTransReturnListGUI_*_TreeStock Transfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntryTree, 'TNZTransReturnListGUI_*_TreeStock Transfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntryTree, 'TVATTransReturnListGUI_*_TreeStock Transfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntryTree, 'TTransAccountDetailsGUI_*_TreeStock Transfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntryTree, 'TGeneralLedgerReportGUI_*_Stock Transfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntryTree, 'TExpenseClaimListGUI_*_TreeStockTransfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntryTree, 'TStockStatusReportGUI_*_TreeStock Transfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntryTree, 'TStockStatusRoling_*_TreeStock Transfer=StockTransferEntryID');
  end;
  RegisterClassOnce(TfmStockTransferEntryTree);
end.

