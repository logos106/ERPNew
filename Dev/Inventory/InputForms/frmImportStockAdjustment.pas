unit frmImportStockAdjustment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmImportDataMapping, ActnList, DB, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState, SelectionDialog, AppEvnts, Menus, ExtCtrls, AdvEdit, StdCtrls,
  wwclearbuttongroup, wwradiogroup, Wwdotdot, Wwdbcomb, Mask, wwdbedit, Shader, wwcheckbox, DNMSpeedButton, Grids, AdvObj, BaseGrid, AdvGrid, DNMPanel, wwdbdatetimepicker, BusObjBase, BusobjStockAdjustEntry,
  ComCtrls;

type
  TfmImportStockAdjustment = class(TfmImportDataMapping)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    lblIgnoreIncompleteallocation: TLabel;
    RadioGroup1: TRadioGroup;
    chkStockTake: TCheckBox;
    chkIgnorebinbatchProducts: TCheckBox;
    Qrystockadjustmentimportexport: TERPQuery;
    dsstockadjustmentimportexport: TDataSource;
    QrystockadjustmentimportexportAdjID: TIntegerField;
    QrystockadjustmentimportexportDepartmentID: TIntegerField;
    QrystockadjustmentimportexportUOMID: TIntegerField;
    QrystockadjustmentimportexportUOM: TWideStringField;
    QrystockadjustmentimportexportUOMMultiplier: TFloatField;
    QrystockadjustmentimportexportPartsId: TIntegerField;
    QrystockadjustmentimportexportgLevel: TLargeintField;
    QrystockadjustmentimportexportProductName: TWideStringField;
    QrystockadjustmentimportexportProductColumn1: TWideStringField;
    QrystockadjustmentimportexportProductColumn2: TWideStringField;
    QrystockadjustmentimportexportProductColumn3: TWideStringField;
    QrystockadjustmentimportexportPartsDescription: TWideStringField;
    QrystockadjustmentimportexportDeptName: TWideStringField;
    QrystockadjustmentimportexportAccountName: TWideStringField;
    QrystockadjustmentimportexportAccountGroup: TWideStringField;
    QrystockadjustmentimportexportBatchnumber: TWideStringField;
    QrystockadjustmentimportexportExpiryDate: TWideStringField;
    QrystockadjustmentimportexportBatchExpiryDate: TDateTimeField;
    QrystockadjustmentimportexportBinlocation: TWideStringField;
    QrystockadjustmentimportexportBinnumber: TWideStringField;
    QrystockadjustmentimportexportSerialnumber: TWideStringField;
    QrystockadjustmentimportexportUOMQty: TFloatField;
    QrystockadjustmentimportexportFinalcount: TFloatField;
    QrystockadjustmentimportexportAllocFinalcount: TFloatField;
    QrystockadjustmentimportexportQty: TFloatField;
    QrystockadjustmentimportexportInstockUOMQty: TFloatField;
    QrystockadjustmentimportexportInstockQty: TFloatField;
    QrystockadjustmentimportexportCost: TFloatField;
    QrystockadjustmentimportexportValue: TFloatField;
    QrystockadjustmentimportexportActive: TWideStringField;
    QrystockadjustmentimportexportSeqno: TIntegerField;
    QrystockadjustmentimportexportProductBarCode: TWideStringField;
    chkAdjustmentOnInstock: TCheckbox;
    lblStockTakeNote: TLabel;
    QrystockadjustmentimportexportQtyType: TWideStringField;
    QrystockadjustmentimportexportTruckLoadNo: TWideStringField;
    DNMPanel3: TDNMPanel;
    Label7: TLabel;
    Label6: TLabel;
    dtAdjustmentDate: TwwDBDateTimePicker;
    Shape1: TShape;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkStockTakeClick(Sender: TObject);
    procedure chkIgnorebinbatchProductsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actImportExecute(Sender: TObject);
    Procedure Createbin(const fiClassID:Integer; const fsBinlocation,fsBinnumber:STRing);
  private
    Stock : TStockAdjustEntry;
    ErrorList           : TStringList;
    ErrorItems          : TStringList;
    LineCtr:Integer;
    ImportgroupOriginalno:String;
    SAIds:String;
    AdjustmentOnInstock :Boolean;
    fsStockAdjumentDescription: String;
    procedure ReadnApplyGuiPref;
    Procedure WriteGuiPref;
    //procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
    Procedure ImportCallback(Const Sender: TBusObj; var Abort: Boolean);
    procedure NewStock;
    procedure StepProgresbarinScriptExec(Sender: TObject; var SQL: string;var Omit: Boolean);
    function getImportOk: Boolean;
    procedure ExportLineswithError(fConnection: TERPConnection; Ids: String);
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    function SaveData: boolean;Override;
  public
    Property StockAdjumentDescription :String read fsStockAdjumentDescription write fsStockAdjumentDescription;
    Property StockImportOk:Boolean read getImportOk;
  end;


implementation

uses tcDataUtils, CommonLib, tcConst, BusobjStockAdjustmentExport, AppEnvironment, BusObjConst, CommonDbLib, ProductQtyLib, frmStockAdjustEntryFlat, LogLib, shellapi, frmBinLocation, BusObjProductbin,
  ExportDataObj, DbSharedObjectsObj;

const
  SAI_ERRORFILENAME = 'SAI_Errors.txt';
  SAI_ERRORLINESFILENAME = 'SAI_LineswithErrors.csv';

{$R *.dfm}

procedure TfmImportStockAdjustment.actImportExecute(Sender: TObject);
var
  SAE : TStockAdjustmentImportExport;
  str:String;
  //StockAdjustForm: TfmStockAdjustEntryflat;
  ErrorFilename:String;
  s:String;
begin
  clog('import started');
  str:= 'You have selected the following ' ;
  str := str +NL+NL+ 'Is Stock Take : ';  if chkStockTake.Checked then str := STR+ 'Yes'  else str := STR+ 'No';
  str := str +NL+NL+ 'Ignore Bin / Batch / Serial Number Product , if all combined in the spreadsheet ?: ';  if chkIgnorebinbatchProducts.Checked then str := STR+ 'Yes'  else str := STR+ 'No';
  str := str +NL+NL+ 'Stock Adjustment as On : ' + FormatdateTime(FormatSettings.ShortDateformat+' HH:NN:SS AM/PM', dtAdjustmentDate.DateTime);
  if MessageDlgXP_Vista(str+NL+NL+'Are you sure you want to import ' +quotedstr(edtImportFileName.Text) + ' with these options?' , mtconfirmation, [mbyes, mbNo] , 0) = mrNo then Exit;

  str :='The exported file will have the tick option ' +
              '"Show Only as Unit of Measure" turned on.  '+
            'This is only showing the Quantity of the selected Unit of Measure.  It is not '+
            'displaying the Quantity of any other Unit of Measure for this product on this line or row, as it is expecting '+
            'you to count the Quantities separately on a different line or row  ie If You have 2 Cartons and 8 singles, it will only '+
            'display as 2 Cartons on this line or row.'+chr(13)+chr(13);

  if chkStockTake.Checked then
    str := str+ 'As this is a ''Stock-Take'', The stock will be adjusted to 0 if the product is in the list and not a specific Unit of measure.'+chr(13)+chr(13);

  str := str+ //'The tick option "Adjustment on In-Stock Quantity" will be turned on.  '+
            'This will calculate the Adjustment Quantities based on the ''In-Stock'' Column  '+
            'ie If you have 100 in stock and 20 on Sales Order, it will base the adjustment on 100.'+chr(13)+chr(13);

  str:= str+'Is it okay to continue importing ' + edtImportFileName.Text +'?';
  if MessageDlgXP_Vista(str, mtconfirmation, [mbyes, mbNo] , 0) = mrNo then Exit;
  ProcessingCursor(True);
  try
    DeleteContentsFromUserTemporaryTable('tblstockadjustmentimportexport');
    ImportOK := False;
    inherited;
    if not ImportOK then exit;

    Stock := TStockAdjustEntry.CreateWithNewConn(Self);
    Try
      Stock.connection.Connection := Self.MyConnection;
      Stock.Load(0);

      DoShowProgressbar(40, WAITMSG);
      try
          SAE := TStockAdjustmentImportExport.CreateWithNewConn(self);
          try
            SAE.Connection.Connection := Self.MyConnection;
            SAE.BusObjEvent := DoBusinessObjectEvent;
            SAE.Load;
            if SAE.count =0 then exit;
            if chkStockTake.Checked then begin
              if MessageDlgXP_Vista('You have Selected this Import as a ''Stock Take''.'+NL+NL+
                          'This means that the stock of all '+ AppEnv.DefaultClass.PartColumn +'/' + Appenv.DefaultClass.classheading +' combinations in the Importing file' +
                          ' will change to the stock (and allocation) mentioned in the importing sheet by adding new stock or deleting the existing Stock( and allocation).'+NL+NL+
                          'Are you Sure you want to set it as a Stock Take? ', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
                //pnlProgress.Visible := True;
                SAE.AdjustStockforStockTake(dtAdjustmentDate.datetime,  tDetailswithSno , true, (*fsTablename ,*) 0 ,  '' , SAE.ProductDeptIDs, StepProgresbarinScriptExec);
                SAE.closedb;
                SAE.Load;
                DoStepProgressbar();
              end;
            end;

            // create bins if new bins used
            with SAE.GetNewDataSet('select distinct SA.departmentId, SA.binlocation, SA.binnumber  '+
                                   ' from tblstockadjustmentimportexport SA  '+
                                   ' left join  tblproductbin PB on SA.DepartmentID = PB.ClassId and SA.Binlocation = PB.BinLocation and SA.Binnumber = PB.BinNumber  '+
                                   ' Where ifnull(SA.binlocation,"")<> "" and ifnull(SA.DepartmentID,0)<> 0 and ifnull(PB.BinID,0)=0' , true) do try

              if recordcount >0 then begin
                First;
                While EOF = False do begin
                  Createbin(fieldbyname('departmentId').AsInteger ,fieldbyname('binlocation').AsString, fieldbyname('binnumber').AsString);
                  Next;
                end;
              end;
            finally
              if active then close;
              Free;
            end;

            //pnlProgress.Visible := True;
            str:= '';
            SAIds:= '';
            LineCtr := 0;
            ImportgroupOriginalno :='';
            AdjustmentOnInstock := SAE.AdjustmentOnInstock;
            ErrorList:= TStringlist.Create;
            ErrorItems:= TStringlist.Create;
            try
              Stock.Connection.BeginTransaction;
              try
                NewStock;
                DoShowProgressbar(SAE.count, WAitMSG);
                try
                  SAE.IterateRecords(ImportCallback);
                  if SAIds <> '' then SAIds :=SAIds +',';
                  SAIds := SAIds + inttostr(Stock.ID);
                  str :='File "' + edtImportFileName.Text + '"  is imported. ' ;
                  edtImportFileName.text := '';
                  DataMap.PostDB;
                  DataMap.Dirty := false;
                  Dirty := False;
                  Stock.Connection.CommitTransaction;
                finally
                  DoHideProgressbar;
                end;
              Except
                on E:Exception do begin
                  SAIds := '';
                  Stock.Connection.RollbackTransaction;
                  Exit;
                end;
              end;
            finally
                if SAIds <> '' then begin
                  if pos(',', SAIds) = 0 then begin
                    str:= str + chr(13) + chr(13) +'Stock Adjustment No:' + SAIds +chr(13)  +chr(13)  + 'Please note that this Adjustment is not processed.';
                  end else begin
                    str:= str + chr(13)  +chr(13) + 'Stock Adjustment No(s)  :' + SAIds +chr(13)  +chr(13)  + 'Please note that none of these stock adjustments(Original no : '+ ImportgroupOriginalno +') are processed.';
                  end;
                  //pnlProgress.Visible := False;
                  CommonLib.MessageDlgXP_Vista(str, mtInformation, [mbOK], 0);
                  s:= '';
                  if ErrorList.Count >0 then begin
                    if devmode then logtext(ErrorList.text);
                    ErrorFilename := Commonlib.TempDir  + SAI_ERRORFILENAME;
                    ErrorList.SaveToFile(Errorfilename);
                    s:=s + NL + '   '+uppercase(quotedstr(SAI_ERRORFILENAME))+ ' (Errors)';
                    (*if CommonLib.MessageDlgXP_Vista( 'The incomplete Batch-bin-Serialised allocation adjustments are ignored while importing. Please refer to '+quotedstr(Errorfilename) +' for details.'+
                        'Would you like to open the file?', mtConfirmation , [mbyes,mbno], 0) = mryes then
                      ShellExecute(Handle, 'open', PChar(Errorfilename), '', '', SW_SHOW);*)
                  end;
                  if ErrorItems.count > 0 then begin
                    ExportLineswithError(TERPConnection(SAE.Connection.Connection),  ErrorItems.CommaText);
                    s:=s + NL + '   '+uppercase(quotedstr((*Commonlib.TempDir  + '\'+*)SAI_ERRORLINESFILENAME)) +' (Lines with Errors)';
                  end;
                  if s <> '' then begin
                    s := 'The "Incomplete Adjustments" and "Entries with Errors" are Ignored While Importing.' + NL+NL +'Please Refer to  '+NL+Commonlib.TempDir  + s;
                    if CommonLib.MessageDlgXP_Vista(s+nl+nl+
                        'Would you like to open the folder?', mtConfirmation , [mbyes,mbno], 0 ) = mryes then
                      ShellExecute(Handle, 'open', PChar(Commonlib.TempDir), '', '', SW_SHOW);

                  end;
                end;
                Freeandnil(ErrorList);
                Freeandnil(ErrorItems);
            end;
          finally
            FreeandNil(SAE);
          end;
      finally
        DoHideProgressbar;
      end;
    Finally
      FreeandNil(Stock);
    End;
  finally
    Processingcursor(False);
  end;
  logtext('done');
  Self.Close;
end;

Procedure TfmImportStockAdjustment.ExportLineswithError(fConnection :TERPConnection; Ids:String);
var
  Exporter: TDataExporter;
  Script :TERPScript;
begin
  inherited;

    Script := DbSharedObj.GetScript(fConnection);
    try
      Script.SQL.text := 'Delete from tblstockadjustmentImportExport where not(AdjID in (' + ids +'))';
      Script.Execute;
    finally
      DbSharedObj.ReleaseObj(Script);
    end;

        Exporter:= TDataExporter.Create;
        try
          Exporter.DataFormat:= dfCSV;
          Exporter.StopOnError:= false;
          DoShowProgressbar(35 , WAITMSG );
          try
            DoStepProgressbar;
            (*if not hasDatatoExport then begin
              MessageDlgXP_Vista('As per the selections you have made, there is no data to be exported', mtInformation, [mbOK], 0);
              exit;
            end;*)
            Exporter.ExportDataToFile('TStockAdjustmentImportExport',Commonlib.TempDir  +SAI_ERRORLINESFILENAME);
            DoStepProgressbar;
          finally
            DoHideProgressbar;
          end;
        finally
          Exporter.Free;
        end;

end;
Procedure TfmImportStockAdjustment.ImportCallback(Const Sender: TBusObj; var Abort: Boolean);
var
  sError :String;
  fb:Boolean;
  function IsAllocationline:Boolean;
  begin
    REsult:= False;
    if Trim(TStockAdjustmentImportExport(Sender).Batchnumber)<> '' then begin
      Result := True;
      Exit;
    end;
    if Trim(TStockAdjustmentImportExport(Sender).BinLocation)<> '' then begin
      Result := True;
      Exit;
    end;
    if Trim(TStockAdjustmentImportExport(Sender).SerialNumber)<> '' then begin
      Result := True;
      Exit;
    end;
  end;
begin
  if not(Sender is TStockAdjustmentImportExport) then exit;
  DoStepProgressbar(TStockAdjustmentImportExport(Sender).ProductName);
  if LineCtr >= 400 then begin
    Stock.Lines.PostDB;
    Stock.PostDB;
    if SAIds <> '' then SAIds := SAIds +',';
    SAIds := SAIds + IntToStr(Stock.ID);
    NewStock;
    LineCtr:= 0;
  end;

  try
    Stock.Connection.BeginNestedTransaction;
    try
      Stock.Lines.New;
      Stock.Lines.ProductName            := TStockAdjustmentImportExport(Sender).ProductName;
      Stock.Lines.PostDB;
      if TStockAdjustmentImportExport(Sender).DeptName       <> '' then Stock.Lines.DeptName       := TStockAdjustmentImportExport(Sender).DeptName;
      if TStockAdjustmentImportExport(Sender).AccountName    <> '' then Stock.Lines.AccountName    := TStockAdjustmentImportExport(Sender).Accountname;
      if TStockAdjustmentImportExport(Sender).cost           <> 0  then Stock.Lines.Cost           := TStockAdjustmentImportExport(Sender).cost;
      if TStockAdjustmentImportExport(Sender).UOM            <> '' then Stock.Lines.UOM            := TStockAdjustmentImportExport(Sender).UOM;
      (*if TStockAdjustmentImportExport(Sender).finalCount   <>0 then *)
      if (TStockAdjustmentImportExport(Sender).finalCount   <>0) or (not(IsAllocationline)) then begin
        Stock.Lines.FinalUOMQty    := TStockAdjustmentImportExport(Sender).finalCount;
        Stock.Lines.FinalQty    := Stock.Lines.FinalUOMQty*Stock.Lines.UOMMultiplier;
      end;

      Stock.Lines.OnProductchange;
      if TStockAdjustmentImportExport(Sender).Batchnumber    <> '' then Stock.Lines.batchno        := TStockAdjustmentImportExport(Sender).BAtchnumber;
      if TStockAdjustmentImportExport(Sender).BatchExpiryDate<> 0  then stock.Lines.Expirydate     := TStockAdjustmentImportExport(Sender).BatchExpiryDate;
      if TStockAdjustmentImportExport(Sender).BinLocation    <> '' then stock.Lines.BinLocation    := TStockAdjustmentImportExport(Sender).binlocation;
      if TStockAdjustmentImportExport(Sender).BinNumber      <> '' then stock.Lines.BinNumber      := TStockAdjustmentImportExport(Sender).BinNumber;
      if TStockAdjustmentImportExport(Sender).SerialNumber   <> '' then stock.Lines.SerialNumber   := TStockAdjustmentImportExport(Sender).Serialnumber;
      if Stock.Lines.SerialNumber <> ''  then begin
        if Stock.Lines.AllocationAvailableQty     > 1 then Stock.Lines.AllocationAvailableQty     := 1;
        if Stock.Lines.AllocationInstockQty       > 1 then Stock.Lines.AllocationInstockQty       := 1;
        if Stock.Lines.AllocationAvailableUOMQty  > 1 then Stock.Lines.AllocationAvailableUOMQty  := 1;
        if Stock.Lines.AllocationInStockUOMQty    > 1 then Stock.Lines.AllocationInstockUOMQty    := 1;
      end;
      if   (Stock.Lines.batchno <> '') or (Stock.Lines.BinLocation <> '') or (Stock.Lines.SerialNumber <> '') then begin
        Stock.Lines.AllocationFinalUOMQty  := TStockAdjustmentImportExport(Sender).AllocFinalcount;
        Stock.Lines.AllocationFinalQty  := Stock.Lines.AllocationFinalUOMQty*Stock.Lines.UOMMultiplier;
        //if Stock.Lines.AllocationFinalUOMQty =0 then if Stock.Lines.SerialNumber <> '' then Stock.Lines.AllocationFinalUOMQty:= 1 ;
      end;
      if Stock.Lines.accountId = 0 then begin
        Stock.Lines.AccountId := Stock.AccountID;
        Stock.Lines.Accountname := Stock.Accountname;
      end;


      Stock.Lines.Onallocationchange;
      Stock.Lines.PostDB;

      if Stock.Lines.binLocation <> '' then
        if Stock.Lines.binId = 0 then
          Createbin(Stock.Lines.ClassID ,Stock.Lines.BinLocation , Stock.Lines.BinNumber);

      fb:=Stock.SilentMode;
      Stock.SilentMode:= True; // this is to avaoid showing the error in the validatedata here - as the errors are recorded into a file
      try
        sError := inttostr(TStockAdjustmentImportExport(Sender).ID);
        if not Stock.Lines.ValidateData then begin
          sError := sError +',' +replacestr(replacestr(Stock.ResultStatus.GetLastFatalStatusItem.Message, NL , '  '), '('+Stock.Lines.Classname+')' , '');
          Stock.Connection.RollbackNestedTransaction;
          Exit;
        end else begin
          if chkIgnorebinbatchProducts.checked then
            if not Stock.Lines.ValidateAllocationAttribs then begin
              sError := sError +',' +replacestr(replacestr(Stock.ResultStatus.GetLastFatalStatusItem.Message, NL , '  '), '('+Stock.Lines.Classname+')' , '');
              Stock.Connection.RollbackNestedTransaction;
              Exit;
            end;
        end;
        Stock.Connection.CommitNestedTransaction;
      finally
        if (sError <> '' ) and not(Sametext(sError , inttostr(TStockAdjustmentImportExport(Sender).ID)))  then begin
            ErrorList.Add(sError);
            ErrorItems.Add(inttostr(TStockAdjustmentImportExport(Sender).ID));
        end;
        Stock.silentMode := fb;
      end;
    Except
      on E:Exception do begin
        Stock.Connection.RollbackNestedTransaction;
        ErrorList.Add('error on line :'+sError +E.message);
        ErrorItems.Add(inttostr(TStockAdjustmentImportExport(Sender).ID));
      end;
    end;
    LineCtr:= LineCtr+1;
  Except
    on E:Exception do begin
      ErrorList.Add('error on line :'+sError +E.message);
      ErrorItems.Add(inttostr(TStockAdjustmentImportExport(Sender).ID));
    end;
  end;

end;

procedure TfmImportStockAdjustment.chkIgnorebinbatchProductsClick(Sender: TObject);
begin
  inherited;
  if Screen.activecontrol = chkIgnorebinbatchProducts then
    if chkIgnorebinbatchProducts.checked then
      chkStockTake.checked := False;
end;

procedure TfmImportStockAdjustment.chkStockTakeClick(Sender: TObject);
begin
  inherited;
  if Screen.activecontrol = chkStockTake then
    if chkStockTake.checked then
      chkIgnorebinbatchProducts.checked := False;
end;
Procedure TfmImportStockAdjustment.NewStock;
begin
  if (Stock.Dataset.state = dsInsert) (*or (Stock.Dataset.recordcount <> 0 )*) then
  else begin
    Stock.new;
    Stock.Notes := StockAdjumentDescription;
  end;
  Stock.EnforceUOM := True;
  //Stock.AdjustmentOnInstock := True;
  Stock.AdjustmentOnInstock := AdjustmentOnInstock ;//False;//chkAdjustmentOnInstock.checked;
  Stock.AdjustmentDate := dtAdjustmentDate.DateTime;
  Stock.PostDB;
  if ImportgroupOriginalno = '' then ImportgroupOriginalno := stock.globalref;
  Stock.ImportgroupOriginalno := ImportgroupOriginalno;
  Stock.IsStockTake := chkStockTake.checked;

  Stock.PostDB;
  Stock.Lines.DeleteAll;
  Stock.Lines.DoFieldChangewhenDisabled := true;
  Stock.ImportingStockAdjustment := True;
  DoStepProgressbar( 'Stock Adjustment No : ' + IntToStr(Stock.ID));
end;

procedure TfmImportStockAdjustment.Createbin(const fiClassID: Integer; const fsBinlocation, fsBinnumber: STRing);
begin
  {create bin if volume is not enforced}
  if Appenv.companyprefs.EnforceBinVolume =False then begin
    With TProductBin.createwithNewconn(Self) do try
      connection.connection := Self.myconnection;
      LoadSelect('BinLocation =' +quotedstr( fsBinlocation)+' and BinNumber=' +quotedstr( fsBinnumber)+' and ClassId =' +inttostr( fiClassID));
      if count >= 1 then begin
        if active =false then Active := True;
        PostDB;
        Exit;
      end;
      New;
      BinLocation := fsBinlocation;
      BinNumber   := fsBinnumber;
      ClassId     := fiClassID;
      PostDB;
      Exit;
    finally
      Free;
    end;
  end;

    with TfmbinLocation(GetComponentByClassName('TfmbinLocation',TRue, Self)) do try
        AttachObserver(Self);
        Keyid               := 0;
        Formcolor           := Self.Color;
        ClassId             := fiClassID;
        edtBinLocation.text := fsBinlocation;
        edtBinnumber.text   := fsBinnumber;
        ShowModal;
    finally
      Free;
    end;
end;

(*procedure TfmImportStockAdjustment.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
    {object is from the stock adjustment form and the tables are in the stock adjustment form}
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if sender is TSAELinesFlat then
            if (Assigned(Sender.Owner)) and (Sender.owner is TStockAdjustEntry) then
                if (Assigned(Sender.Owner.Owner)) and (Sender.Owner.Owner is TfmStockAdjustEntryflat) then
                    TSAELinesFlat(Sender).Dataset := TfmStockAdjustEntryflat(Sender.Owner.Owner).qryStockAdjustEntryLines;
        if sender is TStockAdjustEntry then
            if (Assigned(Sender.Owner)) and (Sender.Owner is TfmStockAdjustEntryflat) then
                    TStockAdjustEntry(Sender).Dataset := TfmStockAdjustEntryflat(Sender.Owner.Owner).qryStockAdjustEntry;
    end;

end;*)

procedure TfmImportStockAdjustment.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TStockAdjustmentImportExport then TStockAdjustmentImportExport(Sender).Dataset := Qrystockadjustmentimportexport;
  end;
end;

procedure TfmImportStockAdjustment.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  WriteGuiPref;
end;

procedure TfmImportStockAdjustment.FormCreate(Sender: TObject);
begin
  inherited;
  StockAdjumentDescription := '';
  dtAdjustmentDate.Datetime := Now;
  lblIgnoreIncompleteallocation.caption :=  'Turn this tick on if the spreadsheet you are importing has :   Serial numbers in Bins' + NL+
                                            '                                                                                          OR Bins in Batches' + NL+
                                            '                                                                                          OR Serial numbers in Batches.' + NL+
                                            'Any combination of these 3, and you have not isolated these scenarios in this spreadsheet.' + NL+
                                            'ie. You have a bin Quantity and a serial number Quantity for the same product on the same spreadsheet on different lines.  ' + (*NL+*)
                                            //'' + NL+
                                            'Ideally, Import each Object on a separate spreadsheet.'+NL+
                                            '         eg: Do Bin import as One spreadsheet , '+NL+
                                            '	  Do Batches Import on a second spreadsheet,'+NL+
                                            '	  Do Serial Number import on a third spreadsheet.';
  lblStockTakeNote.caption := NL+'When imported:'+NL +
                              'A STOCK TAKE will delete all the AVAILABLE(Column) stock of the Products/Departments in the spreadsheet and will make the AVAILABLE(column) stock the same as the Spreadsheet.  '+
                              'It will ignore any Product/Department that is not in the spreadsheet.  All Serial Numbers , Bins and Batches will be removed and replaced with whats on the Spreadsheet.  '+
                              'ie, ERP has 8 Serial Numbers, Spread sheet has 5 different Serial Numbers, ERP will be adjusted to 5 Serial Numbers as per the spreadsheet.'+NL+
                              'A NON STOCK TAKE will ignore any Product/Department that is not in the spreadsheet.  All Serial Numbers , Bins and Batches will remain and will be added '+
                              'to based on whats on the Spreadsheet.  ie, ERP has 8 Serial Numbers, Spread sheet has 5 different Serial Numbers, ERP will be adjusted to 13 unique Serial Numbers.';
  SavencloseonImport := False;
end;

procedure TfmImportStockAdjustment.FormShow(Sender: TObject);
begin
  KeyId := StockAdjustImportDataMapID; // this form is used for stock adjustemnt import only. and the history si not required. the record is kep in the table as next time opened, it will have the previous import info
  inherited;
  if KeyId =0 then begin
    DataMap.typename := 'Stock Adjustment';
    DataMap.ImportName := 'Stock Adjsutment Import';
    DataMap.PostDB;
  end;
  edtName.Enabled := False;
  cboImportType.Enabled := False;
  ReadnApplyGuiPref;
  HighLightcontrol(dtAdjustmentDate);
  HighlightextraControl1(chkStockTake);
end;
function TfmImportStockAdjustment.getImportOk: Boolean;
begin
  REsult := ImportOk;
end;

procedure TfmImportStockAdjustment.ReadnApplyGuiPref;
begin
    if GuiPrefs.Active = False then GuiPrefs.Active := TRue;
    chkIgnorebinbatchProducts.checked :=  GuiPrefs.Node['Options.IgnoreIncompleteallocation'].asBoolean;
    //chkAdjustmentOnInstock.checked :=  GuiPrefs.Node['Options.AdjustmentOnInstock'].asBoolean;
    chkStockTake.checked :=  GuiPrefs.Node['Options.IsStockTake'].asBoolean;
    if GuiPrefs.Node.Exists('Options.AdjustmentDate') then dtAdjustmentDate.dateTime := GuiPrefs.Node['Options.AdjustmentDate'].asDatetime;
    if dtAdjustmentDate.dateTime =0 then dtAdjustmentDate.dateTime := now;
end;

function TfmImportStockAdjustment.SaveData: boolean;
var
  f: TextFile;
  line:String;
  s:String;
  ctr:Integer;
begin
  Result := inherited SaveData;
  if not result then exit;
  if Trim(edtImportFileName.text) <> '' then
    if fileExists (edtImportFileName.text) then begin
      AssignFile(f,edtImportFileName.text);
      Reset(f);
      try
        ctr:= 1;
        ReadLn(f,line);
        s:=TStockAdjustmentImportExport.HeaderLine(DataMap.separatorValue);
        if not Sametext(line , s) then begin
          //REsult:= False;
          MessageDlgXP_Vista('The header line in the importing file ' +quotedstr(edtImportFileName.text) +' is invalid.' +  NL+
                              s +NL+
                             line , mtInformation, [mbOk], 0);
          CopyToClipboard(s);
          //exit;
        end;
        while not EOF(f) do begin
          ReadLn(f,line);
          ctr:= ctr+1;
          if sametext(copy(line, 1, length('FINALTStockAdjustEntry')) , 'FINALTStockAdjustEntry') then begin
            REsult:= False;
            MessageDlgXP_Vista('Line :' + inttostr(ctr) +' contains ' +quotedstr('FINALTStockAdjustEntry')+' in the importing file ' +quotedstr(edtImportFileName.text) +'. Please delete this line.' +  NL+
                              line , mtInformation, [mbOk], 0);
            exit;
          end;
          if trim(Line)='' then begin
            REsult:= False;
            MessageDlgXP_Vista('Line :' + inttostr(ctr) +' is empty.  Please delete this line from the importing file ' +quotedstr(edtImportFileName.text) +'.' +  NL+
                             line , mtInformation, [mbOk], 0);
            exit;

          end;
        end;


      finally
        CloseFile(f);
      end;
    end;
end;

procedure TfmImportStockAdjustment.StepProgresbarinScriptExec(Sender: TObject; var SQL: string; var Omit: Boolean);
begin
  if devmode then DoStepProgressbar(copy(SQL, 1, 100))
  else DoStepProgressbar();
end;


procedure TfmImportStockAdjustment.WriteGuiPref;
begin
    GuiPrefs.Node['Options.IgnoreIncompleteallocation'].asBoolean := chkIgnorebinbatchProducts.checked;
    GuiPrefs.Node['Options.IsStockTake'].asBoolean         := chkStockTake.checked;
    GuiPrefs.Node['Options.AdjustmentDate'].asDatetime     := dtAdjustmentDate.dateTime;
    //GuiPrefs.Node['Options.AdjustmentOnInstock'].asBoolean := chkAdjustmentOnInstock.checked;
end;

initialization
  RegisterClassOnce(TfmImportStockAdjustment);

end.

