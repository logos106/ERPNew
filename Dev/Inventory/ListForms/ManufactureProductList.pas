

unit ManufactureProductList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, kbmMemTable,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  ComCtrls, wwriched, DNMAction, TextFileObj, DAScript, MyScript, wwcheckbox,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TManufactureProductListGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainPARTSID: TIntegerField;
    qryMainPARTTYPE: TWideStringField;
    qryMainPARTNAME: TWideStringField;
    qryMainPARTSDESCRIPTION: TWideStringField;
    qryMainPURCHASEDESC: TWideStringField;
    qryMainBARCODE: TWideStringField;
    qryMainPRODUCTCODE: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainManufactureTime: TFloatField;
    qryMainNormalDeliveryTime: TFloatField;
    qryMainTree: TWideStringField;
    btnPrintTree: TDNMSpeedButton;
    SaveDialog1: TSaveDialog;
    Qry: TERPQuery;
    QryTAXCODE: TWideStringField;
    QryGlobalRef: TWideStringField;
    QryPARTSID: TIntegerField;
    QryPARTTYPE: TWideStringField;
    QryPRODUCTGROUP: TWideStringField;
    QryPARTNAME: TWideStringField;
    QryPARTSDESCRIPTION: TWideStringField;
    QryPURCHASEDESC: TWideStringField;
    QryINCOMEACCNT: TWideStringField;
    QryASSETACCNT: TWideStringField;
    QryCOGSACCNT: TWideStringField;
    QryBARCODE: TWideStringField;
    QryPRODUCTCODE: TWideStringField;
    QryPURCHTAXCODE: TWideStringField;
    QryPREFEREDSUPP: TWideStringField;
    QrySpecialDiscount: TWideStringField;
    QrySNTracking: TWideStringField;
    QryMultipleBins: TWideStringField;
    Qrybatch: TWideStringField;
    QryAutoBatch: TWideStringField;
    QryAutoReorder: TWideStringField;
    QryBuyQTY1: TIntegerField;
    QryBuyQTY2: TIntegerField;
    QryBuyQTY3: TIntegerField;
    QryCOST1: TFloatField;
    QryCOST2: TFloatField;
    QryCOST3: TFloatField;
    QryAvgCost: TFloatField;
    QrySellQTY1: TIntegerField;
    QrySellQTY2: TIntegerField;
    QrySellQTY3: TIntegerField;
    QryPRICE1: TFloatField;
    QryPRICE2: TFloatField;
    QryPRICE3: TFloatField;
    QryWHOLESALEPRICE: TFloatField;
    QryActive: TWideStringField;
    Qryproductcomment: TWideStringField;
    Qrypriceinc1: TFloatField;
    Qrypriceinc2: TFloatField;
    Qrypriceinc3: TFloatField;
    Qryretail1: TFloatField;
    Qryretail2: TFloatField;
    Qryretail3: TFloatField;
    QryDescription: TWideStringField;
    QryQuantity: TFloatField;
    QryTotalQty: TFloatField;
    QryAddToSale: TWideStringField;
    QryPartSource: TWideStringField;
    QryInputType: TWideStringField;
    QryPrice: TFloatField;
    QryCost: TFloatField;
    QryProductname: TWideMemoField;
    QryProcess: TWideStringField;
    QryUOM: TWideStringField;
    QryExportProductTree: TERPQuery;
    OpenDialog1: TOpenDialog;
    QryExportProductTreeProcTreeId: TLargeintField;
    QryExportProductTreeParentId: TLargeintField;
    QryExportProductTreeMasterID: TIntegerField;
    QryExportProductTreePartsID: TIntegerField;
    QryExportProductTreePartname: TWideStringField;
    QryExportProductTreeSequenceDown: TIntegerField;
    QryExportProductTreeSequenceUp: TIntegerField;
    QryExportProductTreeCaption: TWideStringField;
    QryExportProductTreeDescription: TWideStringField;
    QryExportProductTreeDetails: TWideMemoField;
    QryExportProductTreeTreePartsID: TIntegerField;
    QryExportProductTreeTreePartsName: TWideStringField;
    QryExportProductTreeQuantity: TFloatField;
    QryExportProductTreeTotalQty: TFloatField;
    QryExportProductTreeTotalQtyOriginal: TFloatField;
    QryExportProductTreeHideOnPrint: TWideStringField;
    QryExportProductTreeAddToSale: TWideStringField;
    QryExportProductTreeInputType: TWideStringField;
    QryExportProductTreeCustomInputClass: TWideStringField;
    QryExportProductTreeTreePricechanged:TWideStringField;
    QryExportProductTreePrice: TFloatField;
    QryExportProductTreeCost: TFloatField;
    QryExportProductTreeSelected: TWideStringField;
    QryExportProductTreeComplete: TWideStringField;
    QryExportProductTreeLevel: TLargeintField;
    QryExportProductTreeInfo: TWideMemoField;
    QryExportProductTreeTreePartUOMQuantity: TFloatField;
    QryExportProductTreeUOMID: TIntegerField;
    QryExportProductTreeUOM: TWideStringField;
    QryExportProductTreeTreePartUOMTotalQty: TFloatField;
    QryExportProductTreeMultiplier: TFloatField;
    QryExportProductTreeProcessStepSeq: TIntegerField;
    QryExportProductTreeDuration: TFloatField;
    QryExportProductTreeSetupDuration: TFloatField;
    QryExportProductTreeBreakdownDuration: TFloatField;
    QryExportProductTreeProcessPartPartID: TIntegerField;
    QryExportProductTreeResourceDescription: TWideStringField;
    QryExportProductTreeProcResourceId: TIntegerField;
    QryExportProductTreeResourceName: TWideStringField;
    QryExportProductTreeProcessStep: TWideStringField;
    QryExportProductTreeProcessStepID: TIntegerField;
    btnPdiExport: TDNMSpeedButton;
    btnpdiImport: TDNMSpeedButton;
    btnSelectall: TDNMSpeedButton;
    actSelectAll: TDNMAction;
    Qrysub: TERPQuery;
    dsSub: TDataSource;
    QrysubpartsID: TIntegerField;
    report1n2: TSplitter;
    QrysubDescription: TWideStringField;
    QrysubTreePartUOMQuantity: TFloatField;
    QrysubTreePartUOMTotalQty: TFloatField;
    QrysubUOM: TWideStringField;
    pgMain: TPageControl;
    tabBOA: TTabSheet;
    tabParts: TTabSheet;
    QryBOA: TERPQuery;
    dsBOA: TDataSource;
    btnPrintBOM: TDNMSpeedButton;
    btnPrintBOA: TDNMSpeedButton;
    QryBOApartsID: TIntegerField;
    QryBOADescription: TWideStringField;
    grdBOA: TwwDBGrid;
    wwIButton1: TwwIButton;
    grdsub: TwwDBGrid;
    wwIButton2: TwwIButton;
    QryBOADuration: TTimeField;
    QryBOASetupduration: TTimeField;
    QryBOAbreakdownduration: TTimeField;
    btnBOMHistory: TDNMSpeedButton;
    QryBOAtree: TWideStringField;
    Qrysubtree: TWideStringField;
    QryExportProductTreeComments: TWideMemoField;
    qryMainSNTracking: TWideStringField;
    qryMainMultipleBins: TWideStringField;
    qryMainbatch: TWideStringField;
    QrysubSubpartsID: TIntegerField;
    QrysubSubPartname: TWideStringField;
    btnhelp: TDNMSpeedButton;
    procedure btnPrintTreeClick(Sender: TObject);
    procedure btnpdiImportClick(Sender: TObject);
    procedure btnhelpClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure btnPdiExportClick(Sender: TObject);
    procedure actSelectAllExecute(Sender: TObject);
    procedure actSelectAllUpdate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); override;
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure btnPrintBOAClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure report1n2Moved(Sender: TObject);
    procedure report1n2CanResize(Sender: TObject; var NewSize: Integer; var Accept: Boolean);
    procedure btnPrintBOMClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure btnBOMHistoryClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
    (*F: TextFile;*)
    TF:TTextfile;
    tablename :String;

    function MakeExportFile(const FileName: string): boolean;
    Procedure AddLinetoFile(fQry:TMyQuery; AddHeader:boolean =False );
    Procedure CloseFile;
    Procedure LoadQryExportProductTree(OnlyStructure:Boolean=False);
    Function ImportIntoTempTable:boolean;
    Procedure DoImport;
    function MakeLine(fQry: TMyQuery; AddHeader: boolean): String;
    Function ValidProductTreeToImport(FieldNames:string ):Boolean;
    procedure ResetSubgrids;
    (*procedure btnExportTreeClick(Sender: TObject);*)
    procedure ImportSolidWorks;
    procedure BeforeShowProductBOMHistory(Sender: TObject);
    procedure CallExport(Sender: TObject);
    procedure CallImport(Sender: TObject);
  Protected
    Procedure SetGridColumns;Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    Procedure CopyParamsto(Sender:TObject);Override;

  public
    Procedure RefreshQuery;override;
  end;

implementation

uses CommonLib, FastFuncs, ProductQtyLib, CommonDbLib, tcDataUtils,
  BusObjProcess, tcConst, BusobjProductProperties,
  BusObjProductTreetoImport, BusObjBase, CommonFormLib, BaseInputForm,
  JSONObject, AppEnvironment, DNMLib, TemplateReportsLib,
  SolidWorksLib, frmUserRadioSelect, ProductBOMHistory, BOMProductsList;

const
  etSimple         = 'Simple Export';
  etManProductList = 'Man Product List';
  etProductTree    = 'Product Tree';
  etSolidWorksBOM  = 'SolidWorks BOM';
{$R *.dfm}
{ TManufactureProductListGUI }

procedure TManufactureProductListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('Tree');
end;

procedure TManufactureProductListGUI.btnPrintBOAClick(Sender: TObject);
var
  Reportname:String;
begin
  inherited;
  Reportname := GetDefaultTemplate('Product BOA List');
  if Reportname = '' then Reportname :='Product BOA List';
  ReportSQLSupplied := False;
  PrintTemplateReport(Reportname , '~|||~Where PartsId = ' + inttostr(Qrymainpartsid.AsInteger)+'~|||~ Where P.PartsId = ' + inttostr(QrymainPartsID.asInteger) +' order by P.partsID , PT.SequenceDown, PT.ParentId', Not(Appenv.Employee.ShowPreview) ,1);
end;

procedure TManufactureProductListGUI.btnPrintBOMClick(Sender: TObject);
var
  Reportname:String;
begin
  inherited;
  Reportname := GetDefaultTemplate('Product BOM List');
 if Reportname = '' then Reportname :='Product BOM List';
  ReportSQLSupplied := False;
  PrintTemplateReport(Reportname , '~|||~Where PartsId = ' + inttostr(Qrymainpartsid.AsInteger)+'~|||~ Where P.PartsId = ' + inttostr(QrymainPartsID.asInteger)+' order by P.partsID , PT.SequenceDown, PT.ParentId' , Not(Appenv.Employee.ShowPreview) ,1);

end;

procedure TManufactureProductListGUI.btnPrintTreeClick(Sender: TObject);
var
  strSQL:String;
begin
  inherited;
  strSQL:= SelectedIDs('PartsID' );
  if strSQL = '' then strSQL := IDs('PartsID');
  strSQL:= ProductPrintTreeSQL(strSQL) +
          '~|||~' +companyInfoSQL ;
  ReportSQLSupplied := true;
  PrintTemplateReport('Product List(Tree)' , strSQL , False, 1);
end;
function TManufactureProductListGUI.MakeExportFile(const FileName: string): boolean;
begin
  (*Result := true;
  try
    if FileExists(FileName) then DeleteFile(FileName);
    {$I-}
    AssignFile(F, FileName);
    Rewrite(F);
    IOResult;
    {$I+}
  except
    Result := false;
    CommonLib.MessageDlgXP_Vista('Unable to create file: ' + FileName, mtWarning, [mbOK], 0);
    try
      CloseFile;
    except
    end;
  end;*)
  Result := True;
  Try
    TF:= TTextfile.Create(Filename , tfmCreate);
  Except
    Result := false;
    CommonLib.MessageDlgXP_Vista('Unable to create file: ' + FileName, mtWarning, [mbOK], 0);
  End;

end;


(*procedure TManufactureProductListGUI.btnExportTreeClick(Sender: TObject);
var
  strSQL:String;
  filename :String;
begin
  inherited;

  if SaveDialog1.Execute then begin
    filename := SaveDialog1.FileName;
  end else exit;

  if not MakeExportFile(filename) then
          Exit;
  try
    strSQL:= SelectedIDs('PartsID' );
    if strSQL = '' then strSQL := IDs('PartsID');
    strSQL:= ProductPrintTreeSQL(strSQL);
    closeDb(Qry);
    Qry.SQL.clear;
    Qry.SQl.add(strSQL);
    Qry.open;
    showProgressbar('Please Wait' , Qry.recordcount+1);
    try
      AddLinetoFile(Qry,True);
        stepProgressbar;
      if Qry.RecordCount > 0 then begin
        Qry.First;
        while Qry.Eof = False do begin
          AddLinetoFile(Qry);
          stepProgressbar;
          Qry.Next;
        end;
      end;
    finally
        HideProgressbar;
    end;
  finally
    Closefile;
  end;
end;*)

procedure TManufactureProductListGUI.AddLinetoFile(fQry:TMyQuery;AddHeader: boolean);
begin
  (*Writeln(F, MakeLine(fQry , AddHeader));*)
  TF.WriteLine(MakeLine(fQry , AddHeader));
end;
function TManufactureProductListGUI.MakeLine(fQry:TMyQuery;AddHeader: boolean):String;
var
  str:String;
  I: integer;
  FieldsToExclude:String;
begin
  fieldstoExclude := QuotedStr('Quantity')+',' +
                     QuotedStr('Complete')+',' +
                     QuotedStr('TreePartUOMTotalQty')+',' +
                     QuotedStr('PartsID')+',' +
                     QuotedStr('TreePartsID')+',' +
                     QuotedStr('TotalQtyOriginal')+',' +
                     //QuotedStr('TotalQtyUsed')+',' +
                     QuotedStr('CustomInputClass')+',' +
                     QuotedStr('UOMID')+',' +
                     QuotedStr('ProcessPartPartID')+',' +
                     QuotedStr('ProcResourceId')+',' +
                     QuotedStr('ProcessStepID')+',' +
                     QuotedStr('TotalQty');

  Str := '';
  with fQry do begin
    for I := 0 to fQry.FieldCount - 1 do begin
      if (FastFuncs.PosEx(QuotedStr(Fields[I].fieldName), fieldstoExclude) <> 0 ) then continue; 
      if AddHeader then begin
        Str := Str + Commonlib.ReplaceStr(Fields[I].DisplayLabel, #9, ' ') + #9;
      end else if (Fields[I].DataType = ftDate) or (Fields[I].DataType = ftDateTime) then begin
        if Fields[I].AsDateTime <> 0 then begin
          Str := Str + FormatDateTime(FormatSettings.ShortDateformat, Fields[I].AsDateTime) + #9;
        end else begin
          Str := Str + #9;
        end;
      end else begin
        Str := Str + Commonlib.ReplaceStr(Trim(Fields[I].AsString), #9, ' ') + #9;
      end;
    end;
  end;
  Str := Copy(Str, 0, char_length(Str) - 1);
  str:= replacestr(str , chr(13) , '');
  str:= replacestr(str , #$D#$A , '');
  result :=str;
end;



procedure TManufactureProductListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  opendb(Qrysub);
  opendb(QryBOA);
  grdsub.FooterColor := grdmain.FooterColor;
  grdsub.titleColor := grdmain.titleColor;
  grdBOA.FooterColor := grdmain.FooterColor;
  grdBOA.titleColor := grdmain.titleColor;
end;

procedure TManufactureProductListGUI.ReadnApplyGuiPrefExtra;
var
  x:Integer;
begin
  inherited;
  x := GuiPrefs.Node['Grpfilters.verticalsplit'].asInteger;
  if x<=0 then x:= 235;
  pgMain.width := x;
  RealignTabControl(pgMain, 1);
end;

procedure TManufactureProductListGUI.RefreshQuery;
begin
  inherited;
  if devmode then begin
    if GuiPrefs.Node.Exists('Options.PartsID') then
      Qrymain.locate('PartsId',  GuiPrefs.Node['Options.PartsID'].asInteger , []);
  end;

end;

procedure TManufactureProductListGUI.report1n2CanResize(Sender: TObject; var NewSize: Integer; var Accept: Boolean);
begin
  inherited;
  RealignTabControl(pgMain, 1);
end;

procedure TManufactureProductListGUI.report1n2Moved(Sender: TObject);
begin
  inherited;
  RealignTabControl(pgMain, 1);
end;

procedure TManufactureProductListGUI.CloseFile;
begin
  (*try
    Flush(F);
    System.CloseFile(F);
  except
  end;*)
  FreeandNil(TF);
end;

procedure TManufactureProductListGUI.LoadQryExportProductTree(OnlyStructure:Boolean=False);
var
  strSQL:String;
begin
    strSQL:= SelectedIDs('PartsID' );
    if strSQL = '' then strSQL := IDs('PartsID');
    if strSQL = ''  then strSQL :='0';

    closeDB(QryExportProductTree);
    QryExportProductTree.SQL.clear;
    QryExportProductTree.SQL.Add(TProductTreeToImport.ExportProductTreeSQL(strSQL));
    if OnlyStructure then QryExportProductTree.SQL.Add('Limit 0');
    opendb(QryExportProductTree);
end;

procedure TManufactureProductListGUI.CallImport(Sender: TObject);
begin
  if sender.ClassNameIs('TBOMProductsListGUI') then
    TBOMProductsListGUI(Sender).cmdImport.Click;
end;
procedure TManufactureProductListGUI.CallExport(Sender: TObject);
begin
  if sender.ClassNameIs('TBOMProductsListGUI') then
    TBOMProductsListGUI(Sender).cmdExport.Click;
end;
procedure TManufactureProductListGUI.CopyParamsto(Sender: TObject);
begin
  inherited;
  if sender.ClassNameIs('TBOMProductsListGUI') then begin
    TBOMProductsListGUI(Sender).NonSearchMode := TRue;
    TBOMProductsListGUI(Sender).SearchMode := smFullList;
  end;
end;

procedure TManufactureProductListGUI.btnpdiImportClick(Sender: TObject);
var
  sel: string;
begin
  if frmUserRadioSelect.DoSelect('"' + etSimple +'","' + etProductTree + '","' + etSolidWorksBOM + '"','Import','Import Type', sel) then begin
    if SameText(Sel, etSimple) then begin
      OpenERPListForm('TBOMProductsListGUI' , copyparamsto , CallImport);
      Self.CloseWait;
    end else if SameText(Sel,etProductTree ) then begin
      OpenDialog1.Filter := 'ERP Data Import (*.pdi)|*.pdi|All Files (*.*)|*.*';
      if not ImportIntoTempTable then exit;
      DoImport;
    end
    else if SameText(Sel, etSolidWorksBOM ) then begin
      OpenDialog1.Filter := etSolidWorksBOM + ' (*.xml)|*.xml|All Files (*.*)|*.*';
      ImportSolidWorks;
    end;
  end;


end;

function TManufactureProductListGUI.ImportIntoTempTable:boolean;
var
  FileName:String;
  LineString:String;
  ST:TStringlist;
  stInsert:String;
  Ctr:Integer;
  StFieldNames,StValues:TStringList;
  stnumericFields:TStringList;

  Procedure SetNumericfields;
  begin
    StNumericFields.add('ProcessStepSeq');
    StNumericFields.add('Duration');
    StNumericFields.add('SetupDuration');
    StNumericFields.add('BreakdownDuration');
    StNumericFields.add('FixedAmount');
  end;

  Procedure IfNullSero;
  var
    x:Integer;
  begin
    for x := 0 to StNumericFields.count-1 do begin
      stInsert := replaceStr(stInsert , '`'+StNumericFields[x]+'`=''''' ,'`'+StNumericFields[x]+'`=0 ');
    end;
  end;

begin
  result := False;
  if OpenDialog1.Execute then begin
    Filename := Opendialog1.FileName;
  end;
  if not FileExists(FileName) then Exit;

  tablename := CreateUserTemporaryTable('tmp_producttree');

  StNumericFields:= TStringList.create;
  ST:= TStringlist.create;
  StFieldNames:= tStringList.Create;
  StValues:= tStringList.Create;
  try
    SetnumericFields;
    StValues.QuoteChar:= '''';
    StValues.Delimiter := ',';
    ST.ADD('Truncate  '+ tablename +';');
    (*AssignFile(F, FileName);*)
    TF:=TTextFile.Create(Filename, tfmOpenRead);
    try
      try
        (*{$I-}
        Reset(F);
        {$I+}
        IOResult;*)
        (*Readln(F , LineString);//first line is heading*)
        LineString := TF.REadline;
        LineString := StripQuotes(Commonlib.ReplaceStr(LineString, #39, ''));
        if not ValidProductTreeToImport(LineString) then begin
            MessageDlgXP_Vista(filename +' Is Not a Valid Product Tree File.  Import Failed.' , mtWarning , [mbok], 0);
            Exit;
        end;
        LineString := Commonlib.ReplaceStr(LineString, #9, '`' +#44+'`');
        LineString := '`' + LineString + '`';
        StFieldNames.Commatext := LineString;
        while not (*Eof(F)*)TF.EOF do begin
          (*Readln(F , LineString);*)
          LineString := TF.REadline;
          LineString := StripQuotes(Commonlib.ReplaceStr(LineString, #39, ''));
          LineString := Commonlib.ReplaceStr(LineString, #9, #39 + #44 + #39);
          LineString := #39 + LineString + #39;
          StValues.Clear;
          StValues.delimitedtext := LineString;
          if stValues.count = stfieldnames.count then begin
            stInsert:= '';
             for ctr:= 0 to stFieldnames.count-1 do begin
              if stInsert <> '' then stInsert := stInsert +',';
              stInsert :=stInsert + stfieldnames[ctr] +'=' + Quotedstr(stValues[ctr]);
             end;
            IfNullSero;
            ST.add('insert IGNORE into '+tablename +' Set '+stInsert+';' );
          end else begin
            MessageDlgXP_Vista('In ' +FileName +': The Number of Columns in the Header Row Does Not Match With The Number Of Columns in Data Row(s).  Please Contact ERP Support' , mtWarning, [mbok],0);
            Exit;
          end;
        end;

        if st.Count <> 0 then begin
          With CommonDbLib.TempMyScript do try
            SQL.add(st.text);
              Execute;
              result := TRue;
          finally
              Free;
          end;
        end else begin
          Exit;
        end;
      except
        CommonLib.MessageDlgXP_Vista('File is Already in Use!', mtWarning, [mbOK], 0);
        Exit;
      end;
    Finally
        CloseFile;
    end;
  finally
      FreeandNil(ST);
      Freeandnil(StFieldNames);
      Freeandnil(StValues);
      FreeAndnil(StNumericFields);
  end;
end;


procedure TManufactureProductListGUI.ImportSolidWorks;
var
  ProductId: integer;
  aFileName: string;
begin
  if OpenDialog1.Execute then begin
    aFilename := Opendialog1.FileName;
    if TSolidWorksImport.ImportSolidWorksBOM(aFileName, ProductId) then begin
      self.RefreshQuery;
      qryMain.Locate('PartsId',ProductId,[]);
      grdMain.SelectRecord;
    end;
  end;
end;

procedure TManufactureProductListGUI.DoImport;
var
  DataGrid:TProductTreeToImport;
begin
With CommonDbLib.TempMyQuery do try
  SQL.add('Select Distinct masterId from ' +tablename );
  Open;
  if recordcount = 0 then exit;
  First;
  showProgressbar('Please Wait' , Recordcount*4);
  try
    While Eof= False do begin
      DataGrid:=TProductTreeToImport.create(Self, tablename);
      try
        DataGrid.Connection := TMyDacDataConnection.create(DataGrid);
        DataGrid.Connection.Connection := GetNewMyDacConnection(DataGrid);
        DataGrid.loadSelect('MasterID=' +IntToStr(FieldByname('MasterID').asInteger));
        stepProgressbar;
        if DataGrid.count = 0 then begin
          stepProgressbar;
          stepProgressbar;
          stepProgressbar;
          continue;
        end else begin
          stepProgressbar;
          if DataGrid.ValidateForImport then begin
            stepProgressbar;
            DataGrid.DoImport;
            stepProgressbar;
          end;
        end;
      finally
        Freeandnil(DataGrid);
      end;
      Next;
      stepProgressbar;
    end;
  finally
    Commondblib.DestroyUserTemporaryTable(Tablename);
    HideProgressbar;
  end;
finally
    if active then close;
    Free;
end;
end;

procedure TManufactureProductListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
end;

procedure TManufactureProductListGUI.FormResize(Sender: TObject);
begin
  inherited;
  RealignTabControl(pgMain, 1);
  ResetSubgrids;
end;

procedure TManufactureProductListGUI.FormShow(Sender: TObject);
begin
  inherited;
  RealignTabControl(pgMain, 1);
  ResetSubgrids;
end;
procedure TManufactureProductListGUI.ResetSubgrids;
begin
  btnPrintBOM.Top := tabParts.Height - btnPrintBOM.Height -2;
  btnPrintBOA.Top := btnPrintBOM.top;
  grdBOA.Height := tabBOA.Height-btnPrintBOM.height-2;
  grdsub.Height :=grdBOA.Height ;
end;

procedure TManufactureProductListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if (QrysubSubpartsID.asInteger <>0) then
      ABrush.color := GridColhighLightGreen;
end;

procedure TManufactureProductListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:  GroupFilterString := '(Active = "T")';
    1:  GroupFilterString := '(Active ="F")';
  end;
  inherited;
end;

procedure TManufactureProductListGUI.btnBOMHistoryClick(Sender: TObject);
begin
  inherited;
    OpenERPListForm('TProductBOMHistoryGUI',BeforeShowProductBOMHistory);
end;
Procedure TManufactureProductListGUI.BeforeShowProductBOMHistory(Sender: TObject);
begin
  if not(Sender is TProductBOMHistoryGUI) then exit;
  TProductBOMHistoryGUI(Sender).ProductID:= Qrymainpartsid.AsInteger;

end;
procedure TManufactureProductListGUI.btnhelpClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TProductTreeExportHelpGUI');
end;

procedure TManufactureProductListGUI.cmdExportClick(Sender: TObject);
var
  sel: string;
begin
//  inherited;
  if frmUserRadioSelect.DoSelect('"' + etSimple +'","' + etManProductList + '","' + etProductTree + '"','Export','Export Type', sel) then begin
    if SameText(Sel,  etSimple ) then begin
        OpenERPListForm('TBOMProductsListGUI' , copyparamsto , CallExport);
        Self.CloseWait;
    end else if SameText(Sel,  etManProductList ) then
      Inherited
    else if SameText(Sel,  etProductTree ) then
      btnPdiExportClick(Sender);
  end;
end;

procedure TManufactureProductListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TfrmParts');
    if Assigned(Form) then begin //if has acess
      with TBaseInputGUI(Form) do begin
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end;

end;

function TManufactureProductListGUI.ValidProductTreeToImport(  FieldNames: string): Boolean;
var
  s:String;
begin
//  LoadQryExportProductTree(True);
  s:= MakeLine(QryExportProductTree , True);
  Result := Sysutils.SameText(s , fieldNames);
end;

procedure TManufactureProductListGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Grpfilters.verticalsplit'].asInteger := pgmain.Width ;
  GuiPrefs.Node['Options.PartsID'].asInteger         := QrymainpartsID.asInteger;
end;

procedure TManufactureProductListGUI.btnPdiExportClick(Sender: TObject);
var
  filename :String;
begin
  LoadQryExportProductTree(False);
  if QryExportProductTree.recordcount = 0 then begin
    MessageDlgXP_Vista('Please Select the Product To Be Exported.', mtInformation , [mbok], 0);
    exit;
  end;

  if SaveDialog1.Execute then begin
    filename := SaveDialog1.FileName;
  end else exit;
  if not MakeExportFile(filename) then
          Exit;
  try
     AddLinetoFile(QryExportProductTree, true);
      if QryExportProductTree.RecordCount > 0 then begin
        QryExportProductTree.First;
        while QryExportProductTree.Eof = False do begin
          AddLinetoFile(QryExportProductTree);
          QryExportProductTree.Next;
        end;
      end;
  finally
    Closefile;
  end;
end;

procedure TManufactureProductListGUI.actSelectAllExecute(Sender: TObject);
begin
  inherited;
  if actSelectAll.Caption = 'Select All' then begin
    grdmain.SelectAll;
    actSelectAll.Caption := 'Unselect All'
  end else begin
    grdmain.UnSelectAll;
    actSelectAll.Caption := 'Select All'
  end;
end;

procedure TManufactureProductListGUI.actSelectAllUpdate(Sender: TObject);
begin
  inherited;
  if grdmain.selectedlist.count=grdmain.Datasource.dataset.RecordCount then
    actSelectAll.Caption := 'Unselect All'
  else
    actSelectAll.Caption := 'Select All';
end;

initialization
  RegisterClassOnce(TManufactureProductListGUI);

end.
