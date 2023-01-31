unit frmImportStockAdjust;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB,  ComCtrls,AdvOfficeStatusBar, DNMSpeedButton, StdCtrls,
  ExtCtrls, Menus, AdvMenus, DataState, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts ,
  BusobjStockAdjustEntry,busobjbase, MemDS, Shader, DNMPanel, ImgList,
  ProgressDialog, wwdbdatetimepicker;

type

  TTransProc1 = procedure(const Value :String)  of object;
  TfrmImportStockAdjustGUI = class(TBaseInputGUI)
    txtFilePath: TEdit;
    Letter_Label: TLabel;
    OpenDialog1: TOpenDialog;
    SpeedButton1: TDNMSpeedButton;
    lblImporting: TLabel;
    ImportProgressBar: TProgressBar;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    cboProductQry: TERPQuery;
    cboProductQryPARTSID: TAutoIncField;
    cboProductQryPARTTYPE: TWideStringField;
    cboProductQryPRODUCTGROUP: TWideStringField;
    cboProductQryPARTNAME: TWideStringField;
    cboProductQryPARTSDESCRIPTION: TWideStringField;
    cboProductQryINCOMEACCNT: TWideStringField;
    cboProductQryASSETACCNT: TWideStringField;
    cboProductQryCOGSACCNT: TWideStringField;
    cboProductQryTaxCodeID: TAutoIncField;
    cboProductQryTAXCODE: TWideStringField;
    cboProductQryCOST1: TFloatField;
    cboProductQryPRICE1: TFloatField;
    cboProductQryWHOLESALEPRICE: TFloatField;
    cboProductQryAvgCost: TFloatField;
    cboProductQryRate: TFloatField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    lblstockAdjustmentId: TLabel;
    Label3: TLabel;
    AdjustmentDate: TwwDBDateTimePicker;
    DNMPanel1: TDNMPanel;
    chkIgnoreIncompleteallocation: TCheckBox;
    lblIgnoreIncompleteallocation: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboProductQryBeforeOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    F                   : TextFile;
    HeaderStrings       : string;
    Stock               : TStockAdjustEntry;
    ErrorList           : TStringList;
    fi_recno            : Integer;
    fErrorLog           : TTransProc1;
    ctr:Integer;
    ImportgroupOriginalno:String;
    function  IsDir(const DirPath: string): boolean;
    function  IsFile(const FileName: string): boolean;
    function  GetLineOfString(const I, LinesCount: integer): string;
    function  LineCount(const FileName: string): integer;
    function  StrExtStr(const HSrc: string; const Delim: string; const Count: integer): string;
    function  GetColumnNo(const ColumnHeading, HeaderStrings: string): integer;
    function  Lineno(const iLineno:Integer):String;
    procedure ProcessLineOfString(const LineStr: string);
    procedure ValidateLines(const LineStr: string);
    function  ProcessLinesDetails(const LineString: string): boolean;
    function  ValidateLinesDetails(const LineString: string): boolean;
    Procedure Createbin(const fiClassID:Integer; const fsBinlocation,fsBinnumber:STRing);
    function StripQuotes(const sString: string): string;
    procedure ReadnApplyGuiPref;
    Procedure WriteGuiPref;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    property  ErrorLog :TTransProc1 Read fErrorLog Write fErrorLog;
  end;


implementation

uses FastFuncs,DNMExceptions,
     CommonLib, tcDataUtils, DNMLib, BusObjConst,
      AppEnvironment, frmStockAdjustEntryFlat, frmBinLocation,
  GuiPrefsObj, BusObjProductbin,  BusObjStock, BusObjClass, ExportImportUtils, tcConst, LogLib , ShellAPI;


{$R *.dfm}

procedure TfrmImportStockAdjustGUI.btnCancelClick(Sender: TObject);
begin
  Self.Close;
end;
function TfrmImportStockAdjustGUI.IsDir(const DirPath: string): boolean;
begin
  Result := DirectoryExists(DirPath);
end;

function TfrmImportStockAdjustGUI.IsFile(const FileName: string): boolean;
begin
  Result := FileExists(FileName);
end;
function TfrmImportStockAdjustGUI.LineCount(const FileName: string): integer;
var
  Count: integer;
begin
  Count := 0;
  AssignFile(F, FileName);
  try
    {$I-}
    Reset(F);
    {$I+}
    if IOResult = 0 then
    while not Eof(F) do begin
      Readln(F);
      Inc(Count);
    end;
    CloseFile(F);
    Result := Count;
  except
    CommonLib.MessageDlgXP_Vista('File is Already in Use by Another Application!', mtWarning, [mbOK], 0);
    Result := 0;
  end;
end;

function TfrmImportStockAdjustGUI.StrExtStr(const HSrc: string; const Delim: string; const Count: integer): string;
var
  S: integer;
  E: integer;
  L9: integer;
  Src: string;
begin
  Src := HSrc + Delim;
  S := 1;
  for L9 := 1 to Count - 1 do begin
    S := FastFuncs.PosEx(Delim, Src);
    if S > 0 then Delete(Src, S, char_length(Delim))
    else Break;
  end;
  Result := '';
  if S > 0 then begin
    E      := FastFuncs.PosEx(Delim, Src + Delim);
    Result := Copy(Src, S, E - S);
  end;
end;


function TfrmImportStockAdjustGUI.GetLineOfString(const I, LinesCount: integer): string;
begin
  try
    Readln(F, Result);
    ImportProgressBar.StepIt;
     lblImporting.Caption := 'Importing records ..... ' + IntToStr(i) + ' of ' +
         IntToStr(LinesCount) ;
    Application.ProcessMessages;
  except
    on EInOutError do Result := '';
  end;
end;

procedure TfrmImportStockAdjustGUI.btnOKClick(Sender: TObject);
var
  LINESTRING: string;
  LinesCount: integer;
  strSQL, str :STring;
  I:Integer;
  StockAdjustForm: TfmStockAdjustEntryflat;
  msg: string;
  OpenedOk: boolean;
  ErrorFilename:String;

  Ids:String;
  done:Boolean;
  (*fbenforceUOM, fbAdjustmentOnInstock :boolean;*)
  Procedure NewStock;
  begin
    if (Stock.Dataset.state = dsInsert) (*or (Stock.Dataset.recordcount <> 0 )*) then
    else begin
      Stock.new;
    end;
    Stock.EnforceUOM := True;
    Stock.AdjustmentOnInstock := True;
    Stock.AdjustmentDate := AdjustmentDate.DateTime;
    Stock.PostDB;
    if ImportgroupOriginalno = '' then ImportgroupOriginalno := stock.globalref;
    Stock.ImportgroupOriginalno := ImportgroupOriginalno;
    Stock.PostDB;
    lblstockAdjustmentId.visible := true;
    lblstockAdjustmentId.caption := 'Stock Adjustment No : ' + IntToStr(Stock.ID);
    lblstockAdjustmentId.refresh;
    (*Stock.Lines.Dataset.DisableControls;*)
    Stock.Lines.DeleteAll;
    Stock.Lines.DoFieldChangewhenDisabled := true;
    Stock.ImportingStockAdjustment := True;
  end;
begin
  done := False;

  DisableForm;
  try
    if not IsPDIFormatFile(txtFilePath.Text, msg, OpenedOk) then begin
      if not OpenedOk then
        MessageDlgXP_Vista(msg,mtInformation,[mbOk],0)
      else
        MessageDlgXP_Vista('This does not seem to be a valid ERP file format (it should be a tab delimited csv file).' +
        #13#10 + #13#10 + msg,mtInformation,[mbOk],0);
      exit;
    end;

    try
      if empty(txtFilePath.Text) then begin
          SpeedButton1Click(Sender);
        end;

      if IsDir(ExtractFileDir(txtFilePath.Text)) then begin
          if IsFile(txtFilePath.Text) then begin
            str :='The exported file will have the tick option ' +
              '"Show Only as Unit of Measure" turned on.  '+
            'This is only showing the Quantity of the selected Unit of Measure.  It is not '+
            'displaying the Quantity of any other Unit of Measure for this product on this line or row, as it is expecting '+
            'you to count the Quantities separately on a different line or row  ie If You have 2 Cartons and 8 singles, it will only '+
            'display as 2 Cartons on this line or row.'+chr(13)+chr(13)+
            'The tick option "Adjustment on In-Stock Quantity" will be turned on.  '+
            'This will calculate the values based on the ''In-Stock'' Column  '+
            'ie If you have 100 in stock and 20 on Sales Order, it will base the adjustment on 100.'+chr(13)+chr(13)+
            'Is it okay to continue importing ' + txtFilePath.Text +'?';
            if MessageDlgXP_Vista(str, mtconfirmation, [mbyes, mbNo] , 0) = mrNo then Exit;

          btnCancel.Enabled := false;
            lblImporting.Caption := 'Please Wait Importing ..... 0%';
            lblImporting.Visible := true;
            LinesCount := LineCount(txtFilePath.Text);
            ImportProgressBar.Min := 0;
            ImportProgressBar.Max := LinesCount;
            ImportProgressBar.Position := ImportProgressBar.Min;
            try
              AssignFile(F, txtFilePath.Text);
              {$I-}
              Reset(F);
              {$I+}
              StockAdjustForm := TfmStockAdjustEntryflat(FindExistingComponent('TfmStockAdjustEntryflat'));
              Stock := StockAdjustForm.StockAdjust;
              Stock.BusObjEvent := DoBusinessObjectEvent;
              Try
                  if not Assigned(Stock) then begin
                    CommonLib.MessageDlgXP_Vista('Error in creating ERP object TStockAdjustLines. ', mtWarning, [mbOK], 0);
                    Exit;
                  end;
                  if (Stock.Dataset.state = dsInsert) or (Stock.Dataset.recordcount <> 0 ) then
                  else begin
                  end;
                  ErrorList:= TStringlist.Create;
                  Try
                    for I := 1 to LinesCount do begin
                      LINESTRING := GetLineOfString(I, LinesCount);
                      LINESTRING := Trim(LINESTRING);
                      fi_recno := I;
                      if not empty(LINESTRING) then
                        ValidateLines(LINESTRING);
                  end;
                  if ErrorList.Count > 0 then begin
                        if Assigned(fErrorLog) then begin
                            strSQL := '';
                            ErrorLog('Data import from : ' + txtFilePath.Text  );
                            ErrorLog(' ');
                            ErrorLog('Error in data import');
                            for I := 0 to errorList.count-1 do ErrorLog (errorList[I]);
                        end;
                        Exit;
                  end;
                  {$I-}
                  Reset(F);
                  {$I+}
                  Stock.Lines.Dataset.DisableControls;
                  try
                    ctr:= 0;
                    Ids := '';
                    stock.Connection.BeginTransaction;
                    try
                      NewStock;
{--------------------}for I := 1 to LinesCount do begin
                          LINESTRING := GetLineOfString(I, LinesCount);
                          LINESTRING := Trim(LINESTRING);
                          if  empty(LINESTRING) then

                          else begin
                              ProcessLineOfString(LINESTRING);
                              //ctr:= ctr+1;
                          end;
                          Stock.Lines.PostDB;
                          if ctr = 400 then begin
                            Stock.Lines.PostDB;
                            Stock.PostDB;
                            if Ids <> '' then Ids := Ids +',';
                            Ids := Ids + IntToStr(Stock.ID);
                            NewStock;
                            ctr:= 0;
                          end;
{--------------------}end;
                      Stock.Lines.PostDB;
                      Stock.PostDB;
                      if not Stock.ValidateData then begin
//                        CommonLib.MessageDlgXP_Vista('The following errors occured during import: ' +
//                          #13#10 + #13#10 +  stock.ResultStatus.Messages +
//                          #13#10 + #13#10 +  'Import has been canceled.', mtWarning, [mbOK], 0);
                        CommonLib.MessageDlgXP_Vista('Import has been canceled.', mtWarning, [mbOK], 0);
                        Stock.Connection.RollbackTransaction;
                        exit;
                      end;
                      if Ids <> '' then Ids := Ids +', ';
                      Ids := Ids + IntToStr(Stock.ID);
                    finally
                      Stock.Connection.CommitTransaction;
                      done := true;
                    end;
                  finally
                    Stock.Lines.Dataset.EnableControls;
                  end;
                  Stock.Dirty := False;
                finally
                  //Stock.Lines.Dataset.EnableControls;
                end;
            finally
              Stock := nil;
            end;
          finally
              CloseFile(f);
          end;
          lblImporting.Visible := true;
          if Ids <> '' then begin
            strSQL :='File "' + txtFilePath.Text + '"  is imported. ' ;
            if pos(',', ids) = 0 then begin
              strSQL:= strSQL + chr(13) + chr(13) +'Stock Adjustment No:' + Ids +chr(13)  +chr(13)  +
                'Please note that this Adjustment is not processed.';
            end else begin
              strSQL:= strSQL + chr(13)  +chr(13) +
                       'Stock Adjustment No(s)  :' + Ids +chr(13)  +chr(13)  +
                       'Please note that none of these stock adjustments(Original no : '+ ImportgroupOriginalno +') are processed.';
            end;
            CommonLib.MessageDlgXP_Vista(strSQL, mtInformation, [mbOK], 0);
            if ErrorList.Count >0 then begin
              if devmode then logtext(ErrorList.text);
              ErrorFilename := Commonlib.TempDir  + '\StockAdjutmentImportBinbatchissues.txt';
              ErrorList.SaveToFile(Errorfilename);
              if CommonLib.MessageDlgXP_Vista( 'The incomplete Batch-bin-Serialised allocation adjustments are ignored while importing. Please refer to '+quotedstr(Errorfilename) +' for details.'+
                  'Would you like to open the file?', mtConfirmation , [mbyes,mbno], 0) = mryes then
                ShellExecute(Handle, 'open', PChar(Errorfilename), '', '', SW_SHOW);

            end;
          end;
        end else begin
          CommonLib.MessageDlgXP_Vista('File "' + txtFilePath.Text + '"' + #13 + 'Does Not Exist !', mtWarning, [mbOK], 0);
          done := false;
        end;
      end else begin
          CommonLib.MessageDlgXP_Vista('Directory "' + ExtractFileDir(txtFilePath.Text) + '"' + #13 + ' Does Not Exist !', mtWarning, [mbOK], 0);
          done := false;
      end;
    finally
      if done then modalresult := mrok else modalresult := mrcancel;
      //Self.close;
    end;
  finally
    EnableForm;
  end;
end;
function  TfrmImportStockAdjustGUI.Lineno(const iLineno:Integer):String;
begin
    REsult := '';
    if iLineNo = 0 then
         REsult := '                 '
    else REsult := ' Line: ' + copy(IntToStr(iLineno) + '     ' , 1, 5);
end;
procedure TfrmImportStockAdjustGUI.ValidateLines(const LineStr: string);
var
  LineString, FirstField: string;
begin
  LineString := LineStr;
  FirstField := '';
  LineString := StripQuotes(LineString);
  FirstField := StrExtStr(LineString, #9, 1);
  if FirstField = TStockAdjustEntry.ExportHeader then begin
      HeaderStrings := ReplaceStr(LineString, #9, #44);
  end else   if FirstField = TStockAdjustEntry.XMLNodeName then begin
      ValidateLinesDetails(LineString);
  end else if FirstField = TStockAdjustEntry.ExportFooter then begin
      HeaderStrings := '';
  end;
end;
procedure TfrmImportStockAdjustGUI.ProcessLineOfString(const LineStr: string);
var
  LineString, FirstField: string;
begin
  LineString := LineStr;
  FirstField := '';
  LineString := StripQuotes(LineString);
  FirstField := StrExtStr(LineString, #9, 1);
  if FirstField = TStockAdjustEntry.ExportHeader then begin
      HeaderStrings := ReplaceStr(LineString, #9, #44);
  end else   if FirstField = TStockAdjustEntry.XMLNodeName then begin
      ProcessLinesDetails(LineString);
  end else if FirstField = TStockAdjustEntry.ExportFooter then begin
      HeaderStrings := '';
  end else begin
    ErrorList.Add('Invalid line :' + LineString);
  end;
end;
procedure TfrmImportStockAdjustGUI.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
begin
    {object is from the stock adjustment form and the tables are in the stock adjustment form}
    inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if sender is TSAELinesFlat then
            if (Assigned(Sender.Owner)) and (Sender.owner is TStockAdjustEntry) then
                if (Assigned(Sender.Owner.Owner)) and (Sender.Owner.Owner is TfmStockAdjustEntryflat) then
                    TSAELinesFlat(Sender).Dataset := TfmStockAdjustEntryflat(Sender.Owner.Owner).qryStockAdjustEntryLines;
        if sender is TStockAdjustEntry then
            if (Assigned(Sender.Owner)) and (Sender.Owner is TfmStockAdjustEntryflat) then
                    TStockAdjustEntry(Sender).Dataset := TfmStockAdjustEntryflat(Sender.Owner.Owner).qryStockAdjustEntry;
    end;
end;

function  TfrmImportStockAdjustGUI.ValidateLinesDetails(const LineString: string): boolean;
var
    fsData :STring;
    strSQL :String;
    function getValue(const fiFieldName:String) :String;
    begin
        fsData:= Trim(StrExtStr(LineString, #9, GetColumnNo(fiFieldName, HeaderStrings)));
        Result := fsData;
    end;
    Function ProductExists(const Value:String):Boolean;
    begin
      Result:= TProduct.idtoggle(Value) <>0 ;
    end;
    Function ClassExists(const Value:String):Boolean;
    begin
      Result:= TDeptClass.idtoggle(Value) <>0 ;
    end;

begin
    strSQL := '';
    TRy

        if getValue('Batchno') <> '' then begin
          getValue('ExpiryDate');
          if fsData <> '' then begin
              if char_length(fsData) = 10 then
                  fsData := Copy(fsData , 9,2) + FormatSettings.DateSeparator + Copy(fsData , 6,2) + FormatSettings.DateSeparator + copy(fsData, 1,4)
              else fsData := '';
              StrtoDate(fsData);
          end;
        end;
    Except
        on e:Exception do begin
            strSQL := lineno(fi_recno)+'Batch Expiry date should be in yyyy-mm-dd format. ' + getValue('ExpiryDate') + ' is in invalid format';
            ErrorList.Add(strSQL);
        end;
    End;
    if getValue('ProductName') = '' then begin
        strSQL := lineno(fi_recno)+'Part name should not be blank';
        ErrorList.Add(strSQL);
    end else  if not ProductExists(fsData) then begin
        strSQL := lineno(fi_recno)+'Part name ' +quotedstr(fsData)+' doesn''t exists';
        ErrorList.Add(strSQL );
    end;
    if getValue('ClassName') = '' then begin
        strSQL := lineno(fi_recno)+'Class name should not be blank';
        ErrorList.Add(strSQL);
    end else if not classExists(fsData) then begin
        strSQL := lineno(fi_recno)+'Class name ' +quotedstr(fsData)+' doesn''t exists';
        ErrorList.Add(strSQL);
    end;
    if getValue('BinLocation') = '' then
      if (getValue('binnumber') <> '')  then begin
        strSQL := lineno(fi_recno)+'Bin number exists without Bin Location.';
        ErrorList.Add(strSQL);
    end;
    if strSQL <> '' then begin
        REsult := False;
        Exit;
    end;

    getValue('AccountName');
    if Stock.Accountname <> fsData then begin
        if fsData <> '' then Stock.AccountId := tcDatautils.getAccountID(fsData);
        Stock.PostDB;
    end;
    result := True;
end;
procedure TfrmImportStockAdjustGUI.WriteGuiPref;
begin
  GuiPrefs.Node['Options.IgnoreIncompleteallocation'].asBoolean := chkIgnoreIncompleteallocation.checked ;
end;

function TfrmImportStockAdjustGUI.ProcessLinesDetails(const LineString: string): boolean;
var
    fsData :STring;
    fb:Boolean;
    function getValue(const fiFieldName:String) :String;
    begin
      fsData := '';
      if GetColumnNo(fiFieldName, HeaderStrings) <> 0 then
        fsData:= Trim(StrExtStr(LineString, #9, GetColumnNo(fiFieldName, HeaderStrings)));
      Result := fsData;
    end;
    Function ProductExists(const Value:String):Boolean;
    begin
      Result:= TProduct.idtoggle(Value) <>0 ;
    end;
    Function ClassExists(const Value:String):Boolean;
    begin
      Result:= TDeptClass.idtoggle(Value) <>0 ;
    end;
begin
  result := true;
  try
    Stock.Connection.BeginNestedTransaction;
    try
      Stock.Lines.New;
      if getValue('ProductName')        <> '' then Stock.Lines.ProductName            := fsdata;
      Stock.Lines.PostDB;
      if getValue('ClassName')          <> '' then Stock.Lines.DeptName               := fsdata;
      if getValue('AccountName')        <> '' then Stock.Lines.AccountName            := fsData;
      if GetValue('Cost')               <> '' then Stock.Lines.Cost                   := strTofloat(fsData);
      if GetValue('UOM')                <> '' then Stock.Lines.UOM                    := fsData;
      if GetValue('finalCount')         <> '' then begin
        Stock.Lines.FinalUOMQty         := strToFloat(fsData);
      end;
      if getValue('Batchnumber')        <> '' then  begin
        Stock.Lines.batchno             := fsData;
        if getValue('ExpiryDate')       <> '' then stock.Lines.Expirydate             := StrToDate(Copy(fsData , 9,2) + FormatSettings.DateSeparator + Copy(fsData , 6,2) + FormatSettings.DateSeparator + copy(fsData, 1,4));
      end;
      if getValue('BinLocation')        <> '' then stock.Lines.BinLocation            := fsData;
      if getValue('BinNumber')          <> '' then stock.Lines.BinNumber              := fsData;
      if getValue('SerialNumber')       <> '' then stock.Lines.SerialNumber           := fsData;
      if Stock.Lines.SerialNumber <> ''  then begin
        if Stock.Lines.AllocationAvailableQty     > 1 then Stock.Lines.AllocationAvailableQty     := 1;
        if Stock.Lines.AllocationInstockQty       > 1 then Stock.Lines.AllocationInstockQty       := 1;
        if Stock.Lines.AllocationAvailableUOMQty  > 1 then Stock.Lines.AllocationAvailableUOMQty  := 1;
        if Stock.Lines.AllocationInStockUOMQty    > 1 then Stock.Lines.AllocationInstockUOMQty    := 1;
      end;
      if   (Stock.Lines.batchno <> '') or (Stock.Lines.BinLocation <> '') or (Stock.Lines.SerialNumber <> '') then begin
        GetValue('BinbatchfinalCount');
        if fsData= '' then if Stock.Lines.SerialNumber <> '' then fsData       := '1' else fsData       := '0';
        Stock.Lines.AllocationFinalUOMQty  := strToFloat(fsData);
      end;
      if Stock.Lines.accountId = 0 then begin
        Stock.Lines.AccountId := Stock.AccountID;
        Stock.Lines.Accountname := Stock.Accountname;
      end;

      Stock.Lines.PostDB;
      if Stock.Lines.binLocation <> '' then
        if Stock.Lines.binId = 0 then
          Createbin(Stock.Lines.ClassID ,Stock.Lines.BinLocation , Stock.Lines.BinNumber);
      fb:=Stock.SilentMode;
      Stock.SilentMode:= True; // this is to avaoid showing the error in the validatedata here - as the errors are recorded into a file
      try
        fsData := LineString;
        if not Stock.Lines.ValidateData then begin
          fsData := fsdata +',' +replacestr(replacestr(Stock.ResultStatus.GetLastFatalStatusItem.Message, NL , '  '), '('+Stock.Lines.Classname+')' , '');
          Stock.Connection.RollbackNestedTransaction;
          Exit;
        end else begin
          if chkIgnoreIncompleteallocation.checked then
            if not Stock.Lines.ValidateAllocationAttribs then begin
              fsData := fsdata +',' +replacestr(replacestr(Stock.ResultStatus.GetLastFatalStatusItem.Message, NL , '  '), '('+Stock.Lines.Classname+')' , '');
              Stock.Connection.RollbackNestedTransaction;
              Exit;
            end;
        end;
        Stock.Connection.CommitNestedTransaction;
      finally
        if (fsdata <> '' ) and not(Sametext(fsdata , LineString))  then         ErrorList.Add(fsData);
        Stock.silentMode := fb;
      end;
    Except
      on E:Exception do begin
        Stock.Connection.RollbackNestedTransaction;
        ErrorList.Add('error on line :'+LineString +E.message);
      end;
    end;
    ctr:= ctr+1;
  Except
    on E:Exception do begin
      ErrorList.Add('error on line :'+LineString +E.message);
    end;
  end;
end;
procedure TfrmImportStockAdjustGUI.ReadnApplyGuiPref;
begin
    if GuiPrefs.Active = False then GuiPrefs.Active := TRue;
    chkIgnoreIncompleteallocation.checked :=  GuiPrefs.Node['Options.IgnoreIncompleteallocation'].asBoolean;
end;

procedure TfrmImportStockAdjustGUI.SpeedButton1Click(Sender: TObject);
begin
  inherited;
if OpenDialog1.Execute then begin
    txtFilePath.Text := Opendialog1.FileName;
  end;
end;

procedure TfrmImportStockAdjustGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  WriteGuiPref;
end;

procedure TfrmImportStockAdjustGUI.FormCreate(Sender: TObject);
begin
  lblIgnoreIncompleteallocation.caption :=  'Turn this tick on if the spreadsheet you are importing has' + NL+
                                            '             Serial numbers in Bins' + NL+
                                            '       OR Bins in Batches' + NL+
                                            '       OR Serial numbers in Batches.' + NL+
                                            'Means any combination of these three, and you have not isolated these scenareos in this spreadsheet you are about to import.' + NL+
                                            'ie. You have a bin Quantity and a serial number Quantity for the same product on the same spreadhseet on different lines' + NL+
                                            '' + NL+
                                            'Ideally, Import each Object on a separate spreadsheet.'+NL+
                                            '         eg: Do Bin import as One spreadsheet , '+NL+
                                            '	  Do Batches Import on a second spreadsheet,'+NL+
                                            '	  Do Serial Number import on a third spreadsheet.';
  inherited;
  AdjustmentDate.displayformat := FormatSettings.ShortDateFormat+' hh:nn:ss am/pm';
end;

procedure TfrmImportStockAdjustGUI.FormShow(Sender: TObject);
begin

  ImportgroupOriginalno := '';
  DisableForm;
  try
    if AccessLevel <> 1 then begin
      AccessLevel := 6;
    end;
    try
      inherited;
    {$IFNDEF DevMode}
      if FileExists('c:\temp\sae\a1.pdi') then txtFilePath.text := 'c:\temp\sae\a1.pdi';
    {$ENDIF}
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
    AdjustmentDate.Datetime := Now;
    ReadnApplyGuiPref;
  finally
    EnableForm;
  end;  
end;
function TfrmImportStockAdjustGUI.GetColumnNo(const ColumnHeading, HeaderStrings: string): integer;
var
  TotalStrLength, CurrentStrLength, Count, I: integer;
  TempStrValue: string;
begin
  Count := 0;
  CurrentStrLength := 0;

  if FastFuncs.PosEx(uppercase(ColumnHeading), uppercase(HeaderStrings)) = 0 then begin
    Result := Count;
    Exit;
  end;

  TotalStrLength := char_length(HeaderStrings);

  for I := 1 to TotalStrLength do begin
    Count        := I;
    TempStrValue := StrExtStr(HeaderStrings, #44, I);

    if (uppercase(TempStrValue) = uppercase(ColumnHeading)) then begin
      Break;
    end;

    CurrentStrLength := CurrentStrLength + char_length(TempStrValue);

    if (CurrentStrLength = TotalStrLength) then begin
      Count := 0;
      Break;
    end;
  end;

  Result := Count;
end;
procedure TfrmImportStockAdjustGUI.cboProductQryBeforeOpen(
  DataSet: TDataSet);
begin
  inherited;
 cboProductQry.ParamByName('xRegionID').asInteger := AppEnv.RegionalOptions.ID;
end;
procedure TfrmImportStockAdjustGUI.Createbin(const fiClassID: Integer;  const fsBinlocation, fsBinnumber: STRing);
begin
    with TfmbinLocation(GetComponentByClassName('TfmbinLocation',TRue, Self)) do begin
        AttachObserver(Self);
        Keyid               := 0;
        Formcolor           := Self.Color;
        ClassId             := fiClassID;
        edtBinLocation.text := fsBinlocation;
        edtBinnumber.text   := fsBinnumber;
        ShowModal;
    end;
end;

function TfrmImportStockAdjustGUI.StripQuotes(  const sString: string): string;
begin
  Result:= sString;
  Result := StringReplace(Result, '""'    , '~|||~' , [rfReplaceAll,rfIgnoreCase]);
  Result := StringReplace(Result, '"'     , ''      , [rfReplaceAll,rfIgnoreCase]);
  Result := StringReplace(Result, '~|||~' , '"'     , [rfReplaceAll,rfIgnoreCase]);
end;

Initialization
  RegisterClassOnce(TfrmImportStockAdjustGUI);

end.



