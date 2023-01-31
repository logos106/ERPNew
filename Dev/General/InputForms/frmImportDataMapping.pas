unit frmImportDataMapping;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  Wwdotdot, Wwdbcomb, StdCtrls, Mask, wwdbedit, Shader, DNMPanel, DNMSpeedButton,
  Grids, AdvObj, BaseGrid, AdvGrid, wwclearbuttongroup, wwradiogroup,
  wwcheckbox, ActnList, BusObjImportDataMap, BusObjBase, AdvEdit, Contnrs,
 JsonObject, IntegerListObj, ProgressDialog, ExportDataObj;

 const
  Col_ColumnNo = 0;
  Col_Width = 1;
  Col_Example = 2;
  Col_FieldName = 3;
  Col_MapField = 4;
  Col_DataType = 5;
  Col_Format = 6;
  STypeNotSupported = 'Internal: Type %s is not currently supported';

type
  TPropDataType = (pdtString, pdtInteger, pdtFloat, pdtBoolean, pdtDateTime);

  TPropDefList = class;
  TfmImportDataMapping = class(TBaseInputGUI)
    qryImportDataMap: TERPQuery;
    qryImportDataMapGlobalRef: TWideStringField;
    qryImportDataMapImportDataMapID: TIntegerField;
    qryImportDataMapImportName: TWideStringField;
    qryImportDataMapImportFileName: TWideStringField;
    qryImportDataMapTypeName: TWideStringField;
    qryImportDataMapMapping: TWideMemoField;
    qryImportDataMapmsTimeStamp: TDateTimeField;
    dsImportDataMap: TDataSource;
    dlgOpen: TOpenDialog;
    ActionList: TActionList;
    actSave: TAction;
    actCancel: TAction;
    actNew: TAction;
    actRefresh: TAction;
    qryImportDataMapActive: TWideStringField;
    actImport: TAction;
    actTestImport: TAction;
    pnlTop: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Name: TLabel;
    edtName: TwwDBEdit;
    cboImportType: TwwDBComboBox;
    Label1: TLabel;
    Label2: TLabel;
    edtImportFileName: TwwDBEdit;
    chkFirstLineNames: TwwCheckBox;
    btnRefresh: TDNMSpeedButton;
    rgSeparatorType: TwwRadioGroup;
    rgSeparatorValue: TwwRadioGroup;
    edtSeparator: TEdit;
    Label3: TLabel;
    lblColumnCount: TLabel;
    cboTextDelimiter: TComboBox;
    edtColumnCount: TAdvEdit;
    pnlGrid: TDNMPanel;
    grdMap: TAdvStringGrid;
    btnFile: TDNMSpeedButton;
    Label4: TLabel;
    pnlFooter: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    btnImport: TDNMSpeedButton;
    btnTest: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnFileClick(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure chkFirstLineNamesClick(Sender: TObject);
    procedure rgSeparatorTypeChange(Sender: TObject);
    procedure rgSeparatorValueChange(Sender: TObject);
    procedure edtSeparatorChange(Sender: TObject);
    procedure cboTextDelimiterChange(Sender: TObject);
    procedure edtColumnCountChange(Sender: TObject);
    procedure cboImportTypeChange(Sender: TObject);
    procedure grdMapGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure grdMapDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure grdMapComboChange(Sender: TObject; ACol, ARow,
      AItemIndex: Integer; ASelection: string);
    procedure grdMapCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure actRefreshExecute(Sender: TObject);
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure edtImportFileNameChange(Sender: TObject);
    procedure actImportExecute(Sender: TObject);
    procedure actTestImportExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    DoingUpdateFormFromData: boolean;
    MapGridHeadings: string;
    PropList: TPropDefList;
    SampleData: TStringList;
    ProgressDialog: TProgressDialog;
    fInitImport: TNotifyEvent;
    fbSavencloseonImport: Boolean;
    fbSilentMode: Boolean;
    fbReadNonMappedfields: Boolean;
    procedure UpdateFormFromData;
    procedure AnalyseFile;
    function FileLineCount: integer;
    procedure DisplayColumns(ColCount: integer; Headings: string = '');
    procedure ClearGrid;
    function FormatIsDateTime(fmt: string): boolean;
    function FormatIsBoolean(fmt: string): boolean;
    function GridColWidths: TIntegerList;
    function DataTypeFromSample(const SampleList: string; var DataType: string; var Format: string): boolean;
    function AnyFieldsMapped: boolean;
    function MappingsOk(var aRow: integer; var aField, aDataType, aFormat: string): boolean;
    procedure DoOnProgress(const desc: string; const RecNo, RecCount: integer);
    procedure DoOnProgressCancel(sender: TObject);
    procedure SetColumnWidths;
    function PropDataTypeToString(const Value :TPropDataType):String;
  Protected
    Importer: TDataExporter;
    Dirty: boolean;
    DataMap: TImportDataMap;
    ImportOK: boolean;
    function SaveData: boolean;virtual;
    function ImportInsertIfIdNotfound :boolean ; virtual;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    Procedure DoDataMapEvent(const DataExporter : TDataExporter; Busobj :TMsBusobj;Map: TJsonObject;   EventValue: string);Virtual;
  public
    procedure DoImportData(TestOnly: boolean = false);
    Property InitImport :TNotifyEvent read fInitImport write fInitImport;
    Procedure InitNewMaping(const MapingName,ImportType, filename:String; const HasColNames:Boolean);
    Procedure UnMapfields(const Datatype :TPropDataType);
    Property SavencloseonImport :Boolean read fbSavencloseonImport write fbSavencloseonImport;
    Property SilentMode :Boolean read fbSilentMode write fbSilentMode;
    Property ReadNonMappedfields :Boolean read fbReadNonMappedfields write fbReadNonMappedfields;
    Procedure IntforType(aTypename, aImportname:String);
  end;


  TPropDef = class
  public
    Name: string;
    DataType: TPropDataType;
    Mapped: boolean;
    function DataTypeAsString: string;
  end;

  TPropDefList = class
  private
    List: TObjectList;
    function GetItem(index: integer): TPropDef;
    function GetItemByName(aName: string): TPropDef;
    function GetNameMapped(aName: string): boolean;
    procedure SetNameMapped(aName: string; const Value: boolean);
  public
    constructor Create;
    destructor Destroy; override;
    property Items[index: integer]: TPropDef read GetItem;
    property ItemByName[aName: string]: TPropDef read GetItemByName;
    procedure Add(aName: string; aDataType: TPropDataType);
    procedure ReadProperties(aClassName: string);
    procedure Sort;
    function CommaText(UnMappedOnly: boolean = true): string;
    property NameMapped[aName: string]: boolean read GetNameMapped write SetNameMapped;
    procedure UnmapAll;

  end;

implementation

{$R *.dfm}

uses
  FormFactory, BusObjConst, DNMExceptions, CommonLib, Types, StrUtils,
  frmImportDataMappingFormatDate, frmImportDataMappingFormatBoolean,
  TypInfo, CSVParserObj, Character, ImportDataMappingConst,
  MemoDialog, AppEnvironment, Main, BusObjectListObj, CommonDbLib, StringUtils, frmImportStockAdjustment,
  frmImportBOM, tcDataUtils;



{ TfmImportDataMapping }

procedure TfmImportDataMapping.actCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmImportDataMapping.actImportExecute(Sender: TObject);
begin
  inherited;
  DoImportData(false);
  if fbSavencloseonImport then
    btnSave.Click;
end;

procedure TfmImportDataMapping.ActionListUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
//  actRefresh.Enabled:= Dirty;
end;

procedure TfmImportDataMapping.actNewExecute(Sender: TObject);
begin
  if qryImportDataMap.State in [dsInsert, dsEdit] then
    qryImportDataMap.post;
  if DataMap.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if not SaveData then Exit;
          self.CommitTransaction;
        end;
      mrNo:
        begin

        end;
      mrCancel:
        begin
          Exit;
        end;
    end;
  end;

  KeyID := 0;
  FormShow(nil);

  DataMap.Dirty := false;
end;

procedure TfmImportDataMapping.actRefreshExecute(Sender: TObject);
begin
  inherited;
  self.AnalyseFile;
end;

procedure TfmImportDataMapping.actSaveExecute(Sender: TObject);
begin
  inherited;
  if qryImportDataMap.State in [dsInsert, dsEdit] then
    qryImportDataMap.post;
  if not SaveData then Exit;
  CommitTransaction;
  Saveclose;
end;

procedure TfmImportDataMapping.actTestImportExecute(Sender: TObject);
begin
  inherited;
  DoImportData(true);
end;

procedure TfmImportDataMapping.AnalyseFile;
var
  f: TextFile;
  x, y: integer;
  line, FirstLine: string;
  sl: TStringList;
  ActualColCount: integer;
  msg: string;
  ColWidths: TIntegerList;
  SampleStep: integer;
  lineCount: integer;
begin
  try
    x:= 0;
    ActualColCount:= 0;
    SampleData.Clear;
    if DataMap.TypeClassName = '' then begin
      MessageDlgXP_Vista('Please select a data type.', mtInformation, [mbOk], 0);
      exit;
    end;
    if FileExists(DataMap.ImportFileName) then begin
      lineCount:= self.FileLineCount;
      if lineCount > 60 then
        SampleStep:= Trunc(lineCount /30)
      else
        SampleStep:= 1;
      sl:= TStringList.Create;
      ColWidths:= self.GridColWidths;
      try
        AssignFile(f,DataMap.ImportFileName);
        Reset(f);
        try
          while not EOF(f) do begin
            Inc(x);
            ReadLn(f,line);
            if x = 1 then
              FirstLine:= Line;

            sl.Clear;
            if DataMap.SeparationType = SeparationType_Seperated then begin
              if not ParseLine(Line,DataMap.SeparatorValue,DataMap.TextDelimiter,SL,msg,false) then begin
                MessageDlgXP_Vista('Data format selected in the "Import Data Mapping" screen does not match the format of the spreadsheet that you are trying to import:' +
                  #13#10 + #13#10 + msg, mtInformation, [mbOk], 0);
                exit;
              end;
              if ActualColCount = 0 then
                ActualColCount:= sl.Count
              else begin
                if ActualColCount <> sl.Count then begin
//                  MessageDlgXP_Vista('Number of columns (' + IntToStr(sl.Count) +
//                    ') for row ' + IntToStr(x) + ' does not match number ' +
//                    'of columns (' + IntToStr(ActualColCount) + ') for previous row.', mtInformation, [mbOk], 0);
                  MessageDlgXP_Vista('In row ' + IntToStr(x) + ' within the spreadsheet there are ' + IntToStr(sl.Count) + ' columns.' + #13#10 +
                    'In the previous rows within the spreadsheet there are ' + IntToStr(ActualColCount) + ' columns.' + #13#10 +
                    'They should match.' + #13#10 +
                    'This is somtimes caused by text columns that contain a comma, these columns should be enclosed by quotes.',
                    mtInformation, [mbOk], 0);
                  exit;
                end;
              end;
            end
            else if DataMap.SeparationType = SeparationType_Fixed then begin
              if Assigned(ColWidths) then begin
                if not ParseLine(Line,ColWidths,sl,msg) then begin
                  MessageDlgXP_Vista('Data format selected in the "Import Data Mapping" screen does not match the format of the spreadsheet that you are trying to import:' +
                    #13#10 + #13#10 + msg, mtInformation, [mbOk], 0);
                  exit;
                end;
                if ActualColCount = 0 then
                  ActualColCount:= sl.Count
                else begin
                  if ActualColCount <> sl.Count then begin
//                    MessageDlgXP_Vista('Number of columns (' + IntToStr(sl.Count) +
//                      ') for row ' + IntToStr(x) + ' does not match number ' +
//                      'of columns (' + IntToStr(ActualColCount) + ') for previous row.', mtInformation, [mbOk], 0);
                    MessageDlgXP_Vista('In row ' + IntToStr(x) + ' within the spreadsheet there are ' + IntToStr(sl.Count) + ' columns.' + #13#10 +
                      'In the previous rows within the spreadsheet there are ' + IntToStr(ActualColCount) + ' columns.' + #13#10 +
                      'They should match.' + #13#10 +
                      'This is somtimes caused by text columns that contain a comma, these columns should be enclosed by quotes.',
                      mtInformation, [mbOk], 0);
                    exit;
                  end;
                end;
              end;
            end;
            { show data from first 20 lines as example }
            if (x > 1) and (Frac(x / SampleStep) = 0) and (sl.Count > 0) then begin
              for y := 0 to sl.Count -1 do begin
                if y > SampleData.Count -1 then
                  SampleData.Add(sl[y])
                else
                  SampleData[y]:= SampleData[y] + ',' + sl[y];
              end;
            end;
          end;
        finally
          CloseFile(f);
        end;

        if x > 0 then begin
          { check data }
          if DataMap.FirstLineHeadings then
            DisplayColumns(ActualColCount,FirstLine)
          else
            DisplayColumns(ActualColCount);

        end;
      finally
        sl.Free;
        ColWidths.Free;
      end;
      Dirty:= false;
    end
    else begin
      MessageDlgXP_Vista('File not found: "' + DataMap.ImportFileName + '"',mtInformation,[mbOk],0);
    end;
  except
    on e: exception do begin
      Dirty:= true;
      MessageDlgXP_Vista('Error reading input file with message: ' + e.Message, mtWarning, [mbOk], 0);
    end;
  end;
end;

function TfmImportDataMapping.AnyFieldsMapped: boolean;
var
  x: integer;
begin
  result:= false;
  for x := 1 to grdMap.RowCount do begin
    if grdMap.Cells[Col_MapField,x] <> '' then begin
      result:= true;
      break;
    end;
  end;
end;

procedure TfmImportDataMapping.btnFileClick(Sender: TObject);
begin
  inherited;
  if qryImportDataMapImportFileName.AsString <> '' then
    dlgOpen.FileName:= qryImportDataMapImportFileName.AsString;
  if dlgOpen.Execute then begin
    EditDb(qryImportDataMap);
    qryImportDataMapImportFileName.AsString:= dlgOpen.FileName;
  end;
end;

procedure TfmImportDataMapping.cboImportTypeChange(Sender: TObject);
var
  BusObjInfo: TBusObjectInfo;
begin
  inherited;
  if cboImportType.Text <> '' then begin
    BusObjInfo:= BusObjectListObj.TBusObjInfoList.Inst.ItemByName[cboImportType.Text];
    if Assigned(BusObjInfo) then begin
      DataMap.TypeClassName:= BusObjInfo.BusObjClassName;
      PropList.ReadProperties(DataMap.TypeClassName);
    end
    else begin
      MessageDlgXP_Vista('Error - Could not find information for import type: "' + cboImportType.Text + '"', mtWarning, [mbOk], 0);
    end;
    Dirty:= true;
  end;
end;

procedure TfmImportDataMapping.cboTextDelimiterChange(Sender: TObject);
begin
  if DoingUpdateFormFromData then exit;
  DataMap.TextDelimiter:= cboTextDelimiter.Text;
  Dirty:= true;
end;

procedure TfmImportDataMapping.chkFirstLineNamesClick(Sender: TObject);
begin
  inherited;
  if DoingUpdateFormFromData then exit;
  DataMap.FirstLineHeadings:= chkFirstLineNames.Checked;
  Dirty:= true;
end;

procedure TfmImportDataMapping.ClearGrid;
begin
  grdMap.Clear;
  grdMap.RowCount:= 2;
  grdMap.ColumnHeaders.CommaText:= MapGridHeadings;
end;

function TfmImportDataMapping.DataTypeFromSample(const SampleList: string;
  var DataType, Format: string): boolean;
type
  TDataFieldType = (ftQuoted,ftNotQuoted,
                    ftBoolean,
                    ftString,
                    ftInteger, ftFloat,
                    ftBlank,
                    ftTrue,ftFalse,ftT,ftF,
                    ftYes,ftNo,ftY,ftN,
                    ftDateTime, ftNotDateTime,
                    ftYearPos1,ftYearPos2,ftYearPos3,
                    ftDayPos1,ftDayPos2,ftDayPos3,
                    ftTimeMins,ftTimeSecs,
                    ftTimeAmPm,
                    ftDashDateSep, ftSlashDateSep);
  TFieldDataTypes = set of TDataFieldType;

var
  sl: TStringList;
  msg: string;
  x: integer;
  s, dateStr, timeStr, ampmStr: string;
  FDT: TFieldDataTypes;
  boolTrueFalse, boolTF, boolYesNo, boolYN: boolean;
  StringArray: TStringDynArray;
  dateSep, timeFormat: string;

  function TrimQuotes(str: string): string;
  begin
    result:= str;
    if (DataMap.TextDelimiter <> '') then begin
      if (Pos(DataMap.TextDelimiter,result) = 1) then
        result:= Copy(result,2,Length(result));
      if (Pos(DataMap.TextDelimiter,result) = Length(Result)) then
        result:= Copy(result,1,Length(result)-1);
    end;
  end;

  function OnlyDateTimeChars(str: string): boolean;
  var
    i: integer;
  begin
    result:= true;
    for i := 1 to Length(str) do begin
      if not (Character.IsNumber(str[i]) or CharInSet(str[i], [' ','/','-',':','a','p'])) then begin
        result:= false;
        break;
      end;
    end;
  end;

begin
  result:= false;
  FDT:= [];
  sl:= TStringList.Create;
  try
    if ParseLine(SampleList,',',DataMap.TextDelimiter,sl,msg,false) then begin
      if sl.Count = 0 then exit;
      for x := 0 to sl.Count -1 do begin
        s:= Lowercase(Trim(sl[x]));
        if s = '' then
          Include(FDT,ftBlank)
        else begin
          if (DataMap.TextDelimiter <> '') then begin
            if (Pos(DataMap.TextDelimiter,s) = 1) then
              Include(FDT,ftQuoted)
            else
              Include(FDT,ftNotQuoted);
            s:= TrimQuotes(s);
          end;
          if s = '' then
            Include(FDT,ftBlank)
          else begin
            if s = 'true' then begin
              Include(FDT,ftBoolean);
              Include(FDT,ftTrue);
            end
            else if s = 'false' then begin
              Include(FDT,ftBoolean);
              Include(FDT,ftFalse);
            end
            else if s = 't' then begin
              Include(FDT,ftBoolean);
              Include(FDT,ftT);
            end
            else if s = 'f' then begin
              Include(FDT,ftBoolean);
              Include(FDT,ftF);
            end
            else if s = 'yes' then begin
              Include(FDT,ftBoolean);
              Include(FDT,ftYes);
            end
            else if s = 'no' then begin
              Include(FDT,ftBoolean);
              Include(FDT,ftNo);
            end
            else if s = 'y' then begin
              Include(FDT,ftBoolean);
              Include(FDT,ftY);
            end
            else if s = 'n' then begin
              Include(FDT,ftBoolean);
              Include(FDT,ftN);
            end
            else if StringIsNumber(StripQuotes(s)) then begin
              if Frac(StringToFloatDef(StripQuotes(s),0)) = 0 then
                Include(FDT,ftInteger)
              else
                Include(FDT,ftFloat);
            end
            else begin
              { is it a date/time }
              if (not (ftNotDateTime in FDT)) and OnlyDateTimeChars(s) then begin
                { try dividing it up into date/time/am parts ... assume space sep }
                dateStr:= '';
                timeStr:= '';
                ampmStr:= '';
                dateSep:= '';
                timeFormat:= '';
                StringArray:= SplitString(s,' ');
                if High(StringArray) < 3 then begin  { should be max of 3 parts ie 0..2}
                  dateStr:= StringArray[0];
                  if High(StringArray) >= 1 then
                    timeStr:= StringArray[1];
                  if High(StringArray) >= 2 then
                    ampmStr:= StringArray[2];

                  if StringCount('/',dateStr) = 2 then begin
                    dateSep:= '/';
                    Include(FDT, ftSlashDateSep);
                  end
                  else if StringCount('-',dateStr) = 2 then begin
                    dateSep:= '-';
                    Include(FDT, ftDashDateSep);
                  end
                  else
                    Include(FDT, ftNotDateTime);

                  if (not (ftNotDateTime in FDT)) then begin
                    if (timeStr <> '') then begin
                      case StringCount(':',timeStr) of
                        1: timeFormat:= 'hh:mm';
                        2: timeFormat:= 'hh:mm:ss';
                        else
                          Include(FDT, ftNotDateTime);
                      end;
                    end;
                    if (not (ftNotDateTime in FDT)) then begin
                      if (ampmStr <> '') then begin
                        if (ampmStr = 'am') or (ampmStr = 'pm') then
                          timeFormat:= timeFormat + 'am/pm'
                        else
                          Include(FDT, ftNotDateTime);
                      end;
                    end;
                  end;
                  if (not (ftNotDateTime in FDT)) then begin
                    { this is a date/time field }
                    Include(FDT, ftDateTime);
                    { now add format information }
                    StringArray:= SplitString(dateStr,dateSep);
                    { which part is year ... }
                    if Length(StringArray[0]) = 4 then
                      Include(FDT, ftYearPos1)
                    else if Length(StringArray[1]) = 4 then
                      Include(FDT, ftYearPos2)
                    else if Length(StringArray[2]) = 4 then
                      Include(FDT, ftYearPos3);
                    { which part is day ... }
                    if (Length(StringArray[0]) <= 2) and (StrToIntDef(StringArray[0],0) > 12) then
                      Include(FDT, ftDayPos1)
                    else if (Length(StringArray[1]) <= 2) and (StrToIntDef(StringArray[1],0) > 12) then
                      Include(FDT, ftDayPos2)
                    else if (Length(StringArray[2]) <= 2) and (StrToIntDef(StringArray[2],0) > 12) then
                      Include(FDT, ftDayPos3);
                    { time format ... }
                    if pos('hh:mm:ss',timeFormat) > 0 then
                      Include(FDT, ftTimeSecs)
                    else if pos('hh:mm',timeFormat) > 0 then
                      Include(FDT, ftTimeMins);
                    if pos('am/pm',timeFormat) > 0 then
                      Include(FDT, ftTimeAmPm);
                  end;
                end;

              end;
              { else its a string }
              Include(FDT,ftString);
            end;
          end;

        end;
      end;
      if ftBoolean in FDT then begin
        if (not (ftString in FDT)) and (not (ftInteger in FDT)) and (not (ftFloat in FDT)) then begin
          boolTrueFalse:= (ftTrue in FDT) or (ftFalse in FDT);
          boolTF:= (ftT in FDT) or (ftF in FDT);
          boolYesNo:= (ftYes in FDT) or (ftNo in FDT);
          boolYN:= (ftY in FDT) or (ftN in FDT);
          if boolTrueFalse and (not (boolTF or boolYesNo or boolYN)) then begin
            Format:= 'true/false';
            DataType:= FieldType_Boolean;
            result:= true;
            exit;
          end
          else if boolTF and (not (boolTrueFalse or boolYesNo or boolYN)) then begin
            Format:= 't/f';
            DataType:= FieldType_Boolean;
            result:= true;
            exit;
          end
          else if boolYesNo and (not (boolTrueFalse or boolTF or boolYN)) then begin
            Format:= 'yes/no';
            DataType:= FieldType_Boolean;
            result:= true;
            exit;
          end
          else if boolYN and (not (boolTrueFalse or boolTF or boolYesNo)) then begin
            Format:= 'y/n';
            DataType:= FieldType_Boolean;
            result:= true;
            exit;
          end
          else
            exit;
        end;

      end;
      if (ftInteger in FDT) or (ftFloat in FDT) then begin
        if not (ftString in FDT) then begin
          Format:= '';
          if (ftFloat in FDT) then
            DataType:= FieldType_Float
          else
            DataType:= FieldType_Integer;
          result:= true;
          exit;
        end;
      end;
      if (ftDateTime in FDT) and (not (ftNotDateTime in FDT)) then begin
        Format:= '';
        if (ftYearPos1 in FDT) and (not (ftYearPos2 in FDT)) and (not (ftYearPos3 in FDT)) then begin
          if (ftDayPos2 in FDT) and (not (ftDayPos1 in FDT)) and (not (ftDayPos3 in FDT)) then begin
            if (ftSlashDateSep in FDT) then
              Format:= 'yyyy/dd/mm'
            else if (ftDashDateSep in FDT) then
              Format:= 'yyyy-dd-mm';
          end
          else if (ftDayPos3 in FDT) and (not (ftDayPos1 in FDT)) and (not (ftDayPos2 in FDT)) then begin
            if (ftSlashDateSep in FDT) then
              Format:= 'yyyy/mm/dd'
            else if (ftDashDateSep in FDT) then
              Format:= 'yyyy-mm-dd';
          end;
        end
        else if (ftYearPos2 in FDT) and (not (ftYearPos1 in FDT)) and (not (ftYearPos3 in FDT)) then begin
          if (ftDayPos1 in FDT) and (not (ftDayPos2 in FDT)) and (not (ftDayPos3 in FDT)) then begin
            if (ftSlashDateSep in FDT) then
              Format:= 'dd/yyyy/mm'
            else if (ftDashDateSep in FDT) then
              Format:= 'dd-yyyy-mm';
          end
          else if (ftDayPos3 in FDT) and (not (ftDayPos1 in FDT)) and (not (ftDayPos2 in FDT)) then begin
            if (ftSlashDateSep in FDT) then
              Format:= 'mm/yyyy/dd'
            else if (ftDashDateSep in FDT) then
              Format:= 'mm-yyyy-dd';
          end;
        end
        else if (ftYearPos3 in FDT) and (not (ftYearPos1 in FDT)) and (not (ftYearPos2 in FDT)) then begin
          if (ftDayPos1 in FDT) and (not (ftDayPos2 in FDT)) and (not (ftDayPos3 in FDT)) then begin
            if (ftSlashDateSep in FDT) then
              Format:= 'dd/mm/yyyy'
            else if (ftDashDateSep in FDT) then
              Format:= 'dd-mm-yyyy';
          end
          else if (ftDayPos2 in FDT) and (not (ftDayPos1 in FDT)) and (not (ftDayPos3 in FDT)) then begin
            if (ftSlashDateSep in FDT) then
              Format:= 'mm/dd/yyyy'
            else if (ftDashDateSep in FDT) then
              Format:= 'mm-dd-yyyy';
          end;
        end;
        if Format <> '' then  begin
          if (ftTimeSecs in FDT) then begin
            Format:= Format + ' hh:mm:ss';
            if (ftTimeAmPm in FDT) then
              Format:= Format + ' am/pm';
          end
          else if (ftTimeMins in FDT) then begin
            Format:= Format + ' hh:mm';
            if (ftTimeAmPm in FDT) then
              Format:= Format + ' am/pm';
          end;
          DataType:= FieldType_DateTime;
          result:= true;
          exit;
        end;
      end;
      if ftString in FDT then begin
        Format:= '';
        DataType:= FieldType_Text;
        result:= true;
        exit;
      end;
      if ftQuoted in FDT then begin
        if not (ftNotQuoted in FDT) then begin
          Format:= '';
          DataType:= FieldType_Text;
          result:= true;
          exit;
        end;
      end;
    end;
  finally
    sl.Free;
  end;
end;

procedure TfmImportDataMapping.DisplayColumns(ColCount: integer;
  Headings: string);
var
  y: integer;
  ColList: TStringList;
  HasColNames: boolean;
  msg: string;
  UseExistingMapping: boolean;
  PropDef: TPropDef;
  DataType, Format: string;
  o: TJsonObject;
begin
  UseExistingMapping:= false;
  ColList:= TStringList.Create;
  try
    HasColNames:= false;
    if ColCount <> (grdMap.RowCount -1) then begin
      ClearGrid;
      if ColCount > 0 then
        grdMap.RowCount:= ColCount + 1;
    end;

    if Headings <> '' then begin
      HasColNames:= true;
      ParseLine(Headings,DataMap.SeparatorValue,DataMap.TextDelimiter,ColList,msg,true);
    end;
    if (ColCount <> DataMap.Columns.Count) and (DataMap.Columns.Count > 0) then begin
      if SilentMode then
        DataMap.Columns.Clear
      else case CommonLib.MessageDlgXP_Vista('The existing mapping does not match the number of columns in this file, do you want to delete this existing mapping?', mtWarning, [mbYes, mbNo], 0) of
        mrYes:
          begin
            DataMap.Columns.Clear;
//            PropList.UnmapAll;
          end;
        mrNo:
          begin
            { load mapping from existing }
            UseExistingMapping:= true;
          end;
      end;
    end;


    PropList.UnmapAll;
    for y := 1 to ColCount do begin
      grdMap.Cells[Col_ColumnNo,y]:= IntToStr(y);
      if HasColNames and (y <= ColList.Count) then begin
        grdMap.Cells[Col_FieldName,y]:= ColList[y-1];
        if (grdMap.Cells[Col_MapField,y] = '') then begin
          if UseExistingMapping and (y < DataMap.Columns.Count) then begin
            o:= DataMap.Columns.Items[y-1].AsObject;
            PropDef:= PropList.ItemByName[o.S['FieldName']];
            if Assigned(PropDef) and (not PropDef.Mapped) then begin
              grdMap.Cells[Col_MapField,y]:= PropDef.Name;
              PropDef.Mapped:= true;
              grdMap.Cells[Col_DataType,y]:= o.S['DataType'];
              grdMap.Cells[Col_Format,y]:= o.S['Format'];
            end;
          end
          else begin
            { try and match to property ... }
            PropDef:= PropList.ItemByName[grdMap.Cells[Col_FieldName,y]];
            if Assigned(PropDef) and (not PropDef.Mapped) then begin
              grdMap.Cells[Col_MapField,y]:= PropDef.Name;
              PropDef.Mapped:= true;
            end;
          end;
        end;
      end;
      if (grdMap.Cells[Col_MapField,y] <> '') and (grdMap.Cells[Col_DataType,y] = '') then begin
        PropDef:= PropList.ItemByName[grdMap.Cells[Col_MapField,y]];
        grdMap.Cells[Col_DataType,y]:= PropDef.DataTypeAsString;
      end;
      if SampleData.Count > 0 then begin
        grdMap.Cells[Col_Example,y]:= SampleData[y-1];
        if (grdMap.Cells[Col_Format,y] = '') and
           ((grdMap.Cells[Col_DataType,y] = FieldType_Boolean) or
            (grdMap.Cells[Col_DataType,y] = FieldType_DateTime)) then begin
          { try and determine data type/format from sample data }
          if DataTypeFromSample(SampleData[y-1],DataType,Format) then begin
            if grdMap.Cells[Col_DataType,y] = DataType then
              grdMap.Cells[Col_Format,y]:= Format;
          end;
        end;
      end;
    end;
  finally
    ColList.Free;
  end;
end;

procedure TfmImportDataMapping.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TImportDataMap then
      TImportDataMap(Sender).DataSet:= qryImportDataMap;
  end;
end;

procedure TfmImportDataMapping.DoDataMapEvent(const DataExporter : TDataExporter; Busobj :TMsBusobj;Map: TJsonObject;   EventValue: string);
begin

end;

procedure TfmImportDataMapping.DoImportData(TestOnly: boolean);
var
  sl: TStringList;
  databasename: string;
  msg: string;
  BusObjInfo: TBusObjectInfo;
  s: string;
begin
  if not self.SaveData then
    exit;
  if TestOnly then begin
    s:= 'Test Import';
    MessageDlgXP_Vista('This is a test to validate the import file, no changes will be saved.',mtInformation,[mbOk],0);
  end
  else
    s:= 'Import';
  databasename:= AppEnv.AppDb.Database;
  if (not TestOnly) and (not Mainform.RemoveAllConnectionsToDB(self.classname + ',TfmStockAllocQtyAutoAdjust,TfmImportDataMappingList,TfmERPSetupExportImportData,TfmERPSetup,TfrmReportSelectorGUI')) then exit;

  if TestOnly or AppEnv.UtilsClient.LockLogon(msg, databasename, 'Performing Data Import') then begin
    try
      Importer:= TDataExporter.Create;
      sl:= TStringList.Create;
      try
        Importer.DataFormat:= dfCSV;
        Importer.StopOnError:= false;
        Importer.Mapping:= DataMap.MapJson;
        Importer.OnProgress:= self.DoOnProgress;
        Importer.TestImport:= TestOnly;
        Importer.DataMapEvent := DoDataMapEvent;
        Importer.ImportInsertIfIdNotfound :=ImportInsertIfIdNotfound;
        Importer.ReadNonMappedfields := ReadNonMappedfields ;

        BusObjInfo:= BusObjectListObj.TBusObjInfoList.Inst.ItemByName[DataMap.TypeName];
        ImportOk:= Importer.ImportDataFromFile(BusObjInfo.BusObjClassName, DataMap.ImportFileName,sl);
        if Importer.ActionCanceled then
          s:= s + ' (cancelled)';
        ProgressDialog.Free;
        ProgressDialog:= nil;
        if ImportOK  then begin
          if fbSavencloseonImport then
              if sl.Count = 0 then
                MessageDlgXP_Vista(s + ' Complete.',mtInformation,[mbOk],0)
              else begin
                MessageDlgXP_Vista(s + ' completed ok with some warnings.',mtInformation,[mbOk],0);
                MemoDialog.DoMemoDialog('Import Warnings',sl.Text,ssBoth);
              end;
        end else begin
          MessageDlgXP_Vista(s + ' completed with some errors.' +
          #13#10 + #13#10 +
          'The lines that could not be processed have been saved into the file: "'+
          Importer.FailFileName + '".',mtWarning,[mbOk],0);
          MemoDialog.DoMemoDialog('Import Errors',sl.Text,ssBoth);
        end;
      finally
        Importer.Free;
        Importer:= nil;
        sl.Free;
      end;
    finally
      if not TestOnly then AppEnv.UtilsClient.UnlockLogon;
    end;
  end
  else begin
    if not TestOnly then
      CommonLib.MessageDlgXP_Vista('Unable to import data, could not lock other users out of ERP: ' + msg, mtInformation, [mbOk], 0);
  end;
end;

procedure TfmImportDataMapping.DoOnProgress(const desc: string; const RecNo,
  RecCount: integer);
begin
  if not Assigned(ProgressDialog) then begin
    ProgressDialog:= TProgressDialog.Create(self);
    ProgressDialog.AllowCancel:= true;
    ProgressDialog.OnCancel:= DoOnProgressCancel;
    if Assigned(Importer) and Importer.TestImport then
      ProgressDialog.Caption:= 'Test ' +  desc
    else
      ProgressDialog.Caption:= desc;
    ProgressDialog.Message:= 'Record ' + FormatFloat('#,##0',RecNo) + ' of ' + FormatFloat('#,##0',RecCount);
    ProgressDialog.MaxValue:= RecCount;
    ProgressDialog.Value:= RecNo;
    ProgressDialog.Execute;
  end
  else begin
//    ProgressDialog.Caption:= desc;
    ProgressDialog.Message:= 'Record ' + FormatFloat('#,##0',RecNo) + ' of ' + FormatFloat('#,##0',RecCount);
    ProgressDialog.MaxValue:= RecCount;
    ProgressDialog.Value:= RecNo;
  end;
end;

procedure TfmImportDataMapping.DoOnProgressCancel(sender: TObject);
begin
  if Assigned(Importer) then begin
    Importer.Active:= false;
  end;
end;

procedure TfmImportDataMapping.edtColumnCountChange(Sender: TObject);
begin
  if DoingUpdateFormFromData then exit;
  DataMap.ColumnCount:= edtColumnCount.IntValue;
  Dirty:= true;
end;

procedure TfmImportDataMapping.edtImportFileNameChange(Sender: TObject);
begin
  inherited;
//  if DoingUpdateFormFromData then exit;
  Dirty:= true;
end;

procedure TfmImportDataMapping.edtSeparatorChange(Sender: TObject);
begin
  if DoingUpdateFormFromData then exit;
  DataMap.SeparatorValue:= edtSeparator.Text;
  Dirty:= true;
end;

function TfmImportDataMapping.FileLineCount: integer;
var
  f: TextFile;
  line: string;
begin
  result:= 0;
  if FileExists(DataMap.ImportFileName) then begin
    AssignFile(f,DataMap.ImportFileName);
    Reset(f);
    try
      while not EOF(f) do begin
        Inc(result);
        ReadLn(f,line);
      end;
    finally
      CloseFile(f);
    end;
  end;
end;

function TfmImportDataMapping.FormatIsBoolean(fmt: string): boolean;
begin
  result := Pos(FieldType_Boolean,fmt) > 0;
end;

function TfmImportDataMapping.FormatIsDateTime(fmt: string): boolean;
begin
  result := Pos(FieldType_DateTime,fmt) > 0;
end;

procedure TfmImportDataMapping.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  RollbackTransaction;
  Action := caFree;
end;

procedure TfmImportDataMapping.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if Dirty or DataMap.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if not SaveData then CanClose:= false;
        end;
      mrNo:
        begin
          CanClose:= true;
        end;
      mrCancel:
        begin
          CanClose:= false;
        end;
    end;
  end;
end;

procedure TfmImportDataMapping.FormCreate(Sender: TObject);
begin
  inherited;
  SilentMode := False;
  fbSavencloseonImport:= TRue;
  fInitImport:= nil;
  DoingUpdateFormFromData:= false;
  Dirty:= false;
  MapGridHeadings:= grdMap.ColumnHeaders.CommaText;
  cboImportType.Items.CommaText:= BusObjectListObj.TBusObjInfoList.Inst.NameList(true,[boImport]);
  if not(Self is TfmImportStockAdjustment) then
    if cboImportType.Items.indexof('Stock Adjustment') >= 0 then
      cboImportType.Items.Delete(cboImportType.Items.indexof('Stock Adjustment'));

  if not(Self is TfmImportBOM) then
    if cboImportType.Items.indexof('BOM List') >= 0 then
      cboImportType.Items.Delete(cboImportType.Items.indexof('BOM List'));


  DataMap:= TImportDataMap.Create(self);
  DataMap.Connection := TMyDacDataConnection.Create(DataMap);
  DataMap.Connection.MyDacConnection := MyConnection;
  DataMap.BusObjEvent := DoBusinessObjectEvent;
  PropList:= TPropDefList.Create;
  SampleData:= TStringList.Create;
  ReadNonMappedfields := False;
end;

procedure TfmImportDataMapping.FormDestroy(Sender: TObject);
begin
  inherited;
  PropList.Free;
  SampleData.Free;
end;

procedure TfmImportDataMapping.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;

      // Roll back any existing transaction
      RollbackTransaction;


      // Put our Database Connection into transaction mode.
      BeginTransaction;

     // qryProcResource.ParamByName('ProcResourceId').asInteger := KeyID;

      if KeyID = 0 then begin
        DataMap.Load(0);
        DataMap.New;
        DataMap.PostDb;
        edtName.ReadOnly:= false;
        cboImportType.ReadOnly:= false;
      end else begin
        DataMap.Load(KeyId);
        edtName.ReadOnly:= true;
        cboImportType.ReadOnly:= true;
      end;
      UpdateFormFromData;
      Dirty:= false;
      DataMap.Dirty:= false;
      if Assigned(fInitImport) then fInitImport(Self);
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
  if KeyID = 0 then
    SetControlFocus(edtName)
  else
    SetControlFocus(edtImportFileName);
end;

procedure TfmImportDataMapping.grdMapCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  inherited;
  CanEdit:= true;
  if grdMap.GetRealCol = Col_Format then
    CanEdit:= false;
end;

procedure TfmImportDataMapping.grdMapComboChange(Sender: TObject; ACol, ARow,
  AItemIndex: Integer; ASelection: string);
var
  OldValue, NewValue: string;
  s: string;
  y: integer;
  PropDef: TPropDef;
begin
  inherited;
  if grdMap.GetRealCol = Col_MapField then begin
    OldValue:= grdMap.OriginalCells[grdMap.GetRealCol, ARow];
    NewValue:= grdMap.Combobox.Text;
    if OldValue <> '' then
      PropList.NameMapped[OldValue]:= false;
    if NewValue <> '' then
      PropList.NameMapped[NewValue]:= true;

    if NewValue <> '' then begin
      PropDef:= PropList.ItemByName[NewValue];
      grdMap.Cells[Col_DataType,ARow]:= PropDef.DataTypeAsString;
    end
    else
      grdMap.Cells[Col_DataType,ARow]:= '';
    grdMap.Cells[Col_Format,ARow]:= '';
  end
  else if grdMap.GetRealCol = Col_DataType then begin
    if FormatIsDateTime(grdMap.Combobox.Text) then begin
      { get last date/time format }
      s:= '';
      for y := 1 to grdMap.RowCount do begin
        if (y <> ARow) and FormatIsDateTime(grdMap.Cells[Col_DataType,y]) then begin
          s:= grdMap.Cells[Col_Format,y];
          Break;
        end;
      end;
      if GetDateTimeFormat(s) then begin
        grdMap.Cells[Col_Format,ARow]:= s;
        grdMap.Refresh;
      end;
    end
    else if FormatIsBoolean(grdMap.Combobox.Text) then begin
      { get last boolean format }
      s:= '';
      for y := 1 to grdMap.RowCount do begin
        if (y <> ARow) and FormatIsBoolean(grdMap.Cells[Col_DataType,y]) then begin
          s:= grdMap.Cells[Col_Format,y];
          Break;
        end;
      end;
      if GetBooleanFormat(s) then begin
        grdMap.Cells[Col_Format,ARow]:= s;
        grdMap.Refresh;
      end;
    end
    else begin
      grdMap.Cells[Col_Format,ARow]:= '';
      grdMap.Refresh;
    end;
  end
  else if grdMap.GetRealCol = Col_Width then begin
    Dirty:= true;
  end;
  grdMap.OriginalCells[grdMap.GetRealCol, ARow]:= grdMap.Combobox.Text;
end;

procedure TfmImportDataMapping.grdMapDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
var
  s: string;
begin
  inherited;
  if (ARow < 0) or (ACol < 0) then
    exit;
  if (grdMap.GetRealCol = Col_Format) then begin
    if (FormatIsDateTime(grdMap.Cells[Col_DataType,ARow])) then begin
      s:= grdMap.Cells[grdMap.GetRealCol,ARow];
      if GetDateTimeFormat(s) then
        grdMap.Cells[grdMap.GetRealCol,ARow]:= s;
    end
    else if (FormatIsBoolean(grdMap.Cells[Col_DataType,ARow])) then begin
      s:= grdMap.Cells[grdMap.GetRealCol,ARow];
      if GetBooleanFormat(s) then
        grdMap.Cells[grdMap.GetRealCol,ARow]:= s;
    end;
  end;
end;

procedure TfmImportDataMapping.grdMapGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
  inherited;
  if ACol in [Col_MapField,Col_DataType] then begin
    AEditor:= edComboList;
    if ACol = Col_MapField then begin
      grdMap.Combobox.Items.CommaText:= PropList.CommaText;
      grdMap.Combobox.Items.Insert(0,'');
//      grdMap.Combobox.ItemIndex:= 0;
    end
    else if ACol = Col_DataType then begin
      grdMap.Combobox.Items.Clear;
      grdMap.Combobox.Items.Add(FieldType_Text);
      grdMap.Combobox.Items.Add(FieldType_Float);
      grdMap.Combobox.Items.Add(FieldType_Integer);
      grdMap.Combobox.Items.Add(FieldType_Boolean);
      grdMap.Combobox.Items.Add(FieldType_DateTime);
    end;
  end
  else if ACol = Col_Width then begin
    AEditor:= edPositiveNumeric;
  end;
end;

function TfmImportDataMapping.GridColWidths: TIntegerList;
var
  IntList: TIntegerList;
  x: integer;
begin
  IntList:= TIntegerList.Create;
  try
    for x := 1 to grdMap.RowCount do begin
      if grdMap.Ints[col_width,x] = 0 then begin
        IntList.Free;
        IntList:= nil;
        break;
      end
      else
        IntList.Add(grdMap.Ints[col_width,x]);
    end;
  finally
    result:= IntList;
  end;
end;

function TfmImportDataMapping.ImportInsertIfIdNotfound: boolean;
begin
  REsult := False;
end;

procedure TfmImportDataMapping.InitNewMaping(const MapingName, ImportType,filename: String; const HasColNames: Boolean);
begin
  DataMap.Edit;
  DataMap.ImportName        := MapingName;
  DataMap.Typename          := ImportType;
  DataMap.ImportFileName    := filename;
  DataMap.FirstLineHeadings := HasColNames;
  DataMap.PostDB;
end;

procedure TfmImportDataMapping.IntforType(aTypename, aImportname: String);
begin
      if keyid =0 then Keyid := ImportDataMapIDFortype(aTypename);
      if KeyId =0 then begin
        DataMap.Load(0);
        DataMap.New;
        DataMap.typename := aTypename;
        DataMap.ImportName := aImportname;
        DataMap.PostDB;
        KeyId := DataMap.ID;
      end;
      if (keyid <> 0) and (aTypename<>'')  then
        cboImportType.readonly := True;

end;

function TfmImportDataMapping.MappingsOk(var aRow: integer; var aField,
  aDataType, aFormat: string): boolean;
var
  x: integer;
begin
  result:= true;
  for x := 1 to grdMap.RowCount -1 do begin
    if grdMap.Cells[Col_MapField,x] <> '' then begin
      { this row is mapped }
      aRow:= x;
      if grdMap.Cells[Col_DataType,x] = '' then  begin
        aField:= grdMap.Cells[Col_MapField,x];
        aDataType:= '';
        aFormat:= '';
        result:= false;
        break;
      end
      else begin
        { check fields that require formatting have it }
        aDataType:= grdMap.Cells[Col_DataType,x];
        if grdMap.Cells[Col_DataType,x] = FieldType_Boolean then begin
          if grdMap.Cells[Col_Format,x] = '' then  begin
            aField:= grdMap.Cells[Col_MapField,x];
            aFormat:= '';
            result:= false;
            break;
          end
        end
        else if grdMap.Cells[Col_DataType,x] = FieldType_DateTime then begin
          if grdMap.Cells[Col_Format,x] = '' then  begin
            aField:= grdMap.Cells[Col_MapField,x];
            aFormat:= '';
            result:= false;
            break;
          end;
        end;
      end;
    end;
  end;
end;

function TfmImportDataMapping.PropDataTypeToString(const Value: TPropDataType): String;
begin
  case value of
    pdtString   : result := FieldType_Text;
    pdtInteger  : result := FieldType_Integer;
    pdtFloat    : result := FieldType_Float;
    pdtBoolean  : result := FieldType_Boolean;
    pdtDateTime : result := FieldType_DateTime;
  end;
end;

procedure TfmImportDataMapping.rgSeparatorValueChange(Sender: TObject);
begin
  if DoingUpdateFormFromData then exit;
  Dirty:= true;

  case rgSeparatorValue.ItemIndex of
    0: edtSeparator.Text := #9;
    1: edtSeparator.Text := ',';
    2: edtSeparator.Text := ';';
    3: edtSeparator.Text := ' ';
    4: DataMap.SeparatorValue := edtSeparator.Text;
  end;
end;

procedure TfmImportDataMapping.rgSeparatorTypeChange(Sender: TObject);
begin
  if DoingUpdateFormFromData then exit;
  Dirty:= true;

  case rgSeparatorType.ItemIndex of
    0: DataMap.SeparationType:= SeparationType_Fixed;
    1: DataMap.SeparationType:= SeparationType_Seperated;
  end;
  rgSeparatorValue.Enabled:= DataMap.SeparationType = SeparationType_Seperated;
  edtSeparator.Enabled:= rgSeparatorValue.Enabled;
  lblColumnCount.Enabled:= not rgSeparatorValue.Enabled;
  edtColumnCount.Enabled:= not rgSeparatorValue.Enabled;
  if not edtColumnCount.Enabled then
    edtColumnCount.IntValue:= 0;

  if rgSeparatorValue.Enabled then
    grdMap.HideColumn(Col_Width)
  else
    grdMap.UnHideColumn(Col_Width);
  SetColumnWidths;
end;

function TfmImportDataMapping.SaveData: boolean;
var
  y: integer;
  o: TJsonObject;
  aRow: integer;
  aField, aDataType, aFormat: string;
begin
  result:= false;
  if Dirty then begin
    MessageDlgXP_Vista('One of more values have changed, please click on the Refresh button to update the mapping for these new values.', mtInformation, [mbOk], 0);
    exit;
  end;
  if not AnyFieldsMapped then begin
    if MessageDlgXP_Vista('No fields have been mapped yet, save anyway?', mtConfirmation, [mbYes,mbNo], 0) = mrNo then
      exit;
  end;
  if not MappingsOk(aRow, aField, aDataType, aFormat) then begin
    if aDataType = '' then
      MessageDlgXP_Vista('There is no Data Type defined for Map to Field "' + aField + '" for file Column No: ' + IntToStr(aRow), mtInformation, [mbOk], 0)
    else
      MessageDlgXP_Vista('There is no Data Format defined for Map to Field "' + aField + '" (' + aDataType + ') for file Column No: ' + IntToStr(aRow), mtInformation, [mbOk], 0);
    grdMap.row := aRow;
    exit;
  end;

  if DataMap.Columns.Count <> (grdMap.RowCount -1) then
    DataMap.Columns.Clear;
  for y:= 0 to grdMap.RowCount -2 do begin
    if y > DataMap.Columns.Count -1 then begin
      o:= TJsonObject.Create;
      DataMap.Columns.Add(o);
    end
    else
      o:= DataMap.Columns[y].AsObject;
    o.I['Width']:= grdMap.Ints[Col_Width,y+1];
    o.S['Example']:= grdMap.Cells[Col_Example,y+1];
    o.S['FieldName']:= grdMap.Cells[Col_FieldName,y+1];
    o.S['MapToField']:= grdMap.Cells[Col_MapField,y+1];
    o.S['DataType']:= grdMap.Cells[Col_DataType,y+1];
    o.S['Format']:= grdMap.Cells[Col_Format,y+1];

  end;
  DataMap.Dirty:= true;

  result:= DataMap.Save;
end;

procedure TfmImportDataMapping.SetColumnWidths;
var
  x, w, adj: integer;
begin
  w:= 0;
  for x:= 0 to grdMap.ColCount -1 do begin
    w:= w + grdMap.ColWidths[x];
  end;
  if DataMap.SeparationType = SeparationType_Fixed then
    adj:= 0
  else
    adj:= 1;
  grdMap.ColWidths[Col_Example-adj]:= grdMap.ColWidths[Col_Example-adj] + (grdMap.Width - w - grdMap.ScrollWidth - 6);
end;

procedure TfmImportDataMapping.UnMapfields(const Datatype: TPropDataType);
var
  y:Integer;
begin
  for y:= 0 to grdMap.RowCount -2 do begin
     if grdMap.Cells[Col_DataType,y+1] = PropDataTypeToString(Datatype) then begin
        grdMap.Cells[Col_MapField,y+1] := '';
     end;
  end;
end;

procedure TfmImportDataMapping.UpdateFormFromData;
var
  y: integer;
  o: TJsonObject;
begin
  DoingUpdateFormFromData:= true;
  try
    chkFirstLineNames.Checked:= DataMap.FirstLineHeadings;
    if DataMap.SeparationType = SeparationType_Fixed then
      rgSeparatorType.ItemIndex:= 0
    else if DataMap.SeparationType = SeparationType_Seperated then
      rgSeparatorType.ItemIndex:= 1;

    if DataMap.SeparatorValue = #9 then
      rgSeparatorValue.ItemIndex:= 0
    else if DataMap.SeparatorValue = ',' then
      rgSeparatorValue.ItemIndex:= 1
    else if DataMap.SeparatorValue = ';' then
      rgSeparatorValue.ItemIndex:= 2
    else if DataMap.SeparatorValue = '' then
      rgSeparatorValue.ItemIndex:= 3
    else
      rgSeparatorValue.ItemIndex:= 4;

    edtSeparator.Text:= DataMap.SeparatorValue;

    cboTextDelimiter.ItemIndex:= cboTextDelimiter.Items.IndexOf(DataMap.TextDelimiter);

    rgSeparatorValue.Enabled:= DataMap.SeparationType = SeparationType_Seperated;
    edtSeparator.Enabled:= rgSeparatorValue.Enabled;
    lblColumnCount.Enabled:= not rgSeparatorValue.Enabled;
    edtColumnCount.Enabled:= not rgSeparatorValue.Enabled;
    if not edtColumnCount.Enabled then
      edtColumnCount.IntValue:= 0;
    if rgSeparatorType.Enabled then
      grdMap.HideColumn(Col_Width)
    else
      grdMap.UnHideColumn(Col_Width);

    SetColumnWidths;
    ClearGrid;
    if DataMap.Columns.Count > 0 then begin
      grdMap.RowCount:= DataMap.Columns.Count + 1;
      for y := 0 to DataMap.Columns.Count -1 do begin
        o:= DataMap.Columns[y].AsObject;
        grdMap.Cells[Col_ColumnNo,y+1]:= IntToStr(y+1);
        grdMap.Cells[Col_Width,y+1]:= IntToStr(o.I['Width']);
        grdMap.Cells[Col_Example,y+1]:= o.S['Example'];
        grdMap.Cells[Col_FieldName,y+1]:= o.S['FieldName'];
        grdMap.Cells[Col_MapField,y+1]:= o.S['MapToField'];
        grdMap.Cells[Col_DataType,y+1]:= o.S['DataType'];
        grdMap.Cells[Col_Format,y+1]:= o.S['Format'];
        PropList.NameMapped[o.S['MapToField']]:= true;
      end;
    end;

  finally
    DoingUpdateFormFromData:= false;
  end;
end;

{ TPropDefList }

procedure TPropDefList.Add(aName: string; aDataType: TPropDataType);
var
  rec: TPropDef;
begin
  rec:= TPropDef.Create;
  rec.Name:= aName;
  rec.DataType:= aDataType;
  rec.Mapped:= false;
  List.Add(rec);
end;

function TPropDefList.CommaText(UnMappedOnly: boolean): string;
var
  x: integer;
  itm: TPropDef;
begin
  result:= '';
  for x := 0 to List.Count -1 do begin
    itm:= Items[x];
    if (not UnMappedOnly) or (UnMappedOnly and (not itm.Mapped)) then begin
      if result <> '' then
        result:= result + ',';
      result:= result + itm.Name;
    end;
  end;
end;

constructor TPropDefList.Create;
begin
  List:= TObjectList.Create(true);
end;

destructor TPropDefList.Destroy;
begin
  List.Free;
  inherited;
end;

function TPropDefList.GetItem(index: integer): TPropDef;
begin
  result:= TPropDef(List[index]);
end;

function TPropDefList.GetItemByName(aName: string): TPropDef;
var
  x: integer;
begin
  result:= nil;
  for x := 0 to List.Count -1 do begin
    if SameText(Items[x].Name,aName) then begin
      result:= Items[x];
      break;
    end;
  end;
end;

function TPropDefList.GetNameMapped(aName: string): boolean;
var
  itm: TPropDef;
begin
  result:= false;
  itm:= ItemByName[aName];
  if Assigned(itm) then
    result:= itm.Mapped;
end;

procedure TPropDefList.ReadProperties(aClassName: string);
var
  Cls: TPersistentClass;
  BusObj: TBusObjBase;
  x: integer;
  PropInfo: PPropInfo;
  Count: integer;
  PropList: PPropList;
  propName: string;
  ExcludeList: TStringList;
  Val: Variant;
begin
  List.Clear;
  Cls := FindClass(aClassName);
  if Assigned(Cls) then begin
    if IsClassParent(Cls, TBusObjBase) then begin
      BusObj:= TBusObjBaseClass(Cls).Create(nil);
      if BusObj is TDatasetBusObj then begin
        TDatasetBusObj(BusObj).Connection:= TMyDacDataConnection.Create(BusObj);
        TDatasetBusObj(BusObj).Connection.Connection:= CommonDbLib.GetSharedMyDacConnection;
        TDatasetBusObj(BusObj).Load(0);
      end;
      try

        ExcludeList:= nil;
        Count := GetPropList(BusObj.ClassInfo, tkProperties, nil);
        GetMem(PropList, Count * SizeOf(PPropInfo));
        try
          GetPropList(BusObj.ClassInfo, tkProperties, PropList);
          PropInfo:= GetPropInfo(BusObj,'ExportExcludeList');
          if Assigned(PropInfo) then begin
            ExcludeList:= TStringList(GetObjectProp(BusObj, 'ExportExcludeList'));
            ExcludeList.CaseSensitive:= false;
          end;

          for x := 0 to Count -1 do begin

            propName:= String(PropList[x].Name);

            if propName = 'ExcludeList' then
              continue
            else if Assigned(ExcludeList) and (ExcludeList.IndexOf(propName) >= 0) then
              continue;

            PropInfo:= GetPropInfo(BusObj,propName);
            if (not Assigned(PropInfo.SetProc)) and (not SameText(propName,'ID')) then
              { this is a read-only property so skip it }
              continue;

            if (not Assigned(PropInfo.GetProc)) then
              { this is a write-only property so skip it }
              continue;

            val:= GetPropValue(BusObj,PropInfo);
            if VarIsNull(val) then

            else
              case PropInfo.PropType^.Kind of
                TTypeKind.tkInteger:
                  Add(propName, pdtInteger);
                TTypeKind.tkInt64:
                  Add(propName, pdtInteger);
                TTypeKind.tkFloat:
                  begin
                    if (CompareText(string(PropInfo^.PropType^.Name),'TDateTime') = 0) then  begin
                      Add(propName, pdtDateTime);
                    end
                    else
                     Add(propName, pdtFloat);
                  end;
                TTypeKind.tkChar:
                  Add(propName, pdtString);
                TTypeKind.tkWChar:
                  Add(propName, pdtString);
                TTypeKind.tkString,
                TTypeKind.tkLString,
                TTypeKind.tkWString,
                TTypeKind.tkUString:
                  Add(propName, pdtString);
                TTypeKind.tkEnumeration:
                  if (CompareText('Boolean', string(PropInfo^.PropType^.Name)) = 0) then
                    Add(propName, pdtBoolean)
                  else
                    Add(propName, pdtString);
                TTypeKind.tkDynArray,
                TTypeKind.tkArray: ;
                TTypeKind.tkClass: ;
                TTypeKind.tkRecord: ;
                TTypeKind.tkPointer: ;
                TTypeKind.tkSet: ;
                TTypeKind.tkMethod: ;
                TTypeKind.tkVariant: ;
                TTypeKind.tkInterface: ;
                TTypeKind.tkClassRef: ;
                TTypeKind.tkProcedure: ;
                else
                  raise Exception.Create(Format(STypeNotSupported,
                      [PropInfo^.Name]));
            end;

          end;

        finally
          FreeMem(PropList, Count * SizeOf(PPropInfo));
        end;
      finally
        BusObj.Free;
      end;
      Sort;
    end;
  end;

end;

procedure TPropDefList.SetNameMapped(aName: string; const Value: boolean);
var
  itm: TPropDef;
begin
  itm:= ItemByName[aName];
  if Assigned(itm) then
    itm.Mapped:= Value;
end;

procedure TPropDefList.Sort;

  function CompareNames(Item1, Item2: Pointer): Integer;
  begin
    Result := CompareText(TPropDef(Item1).Name, TPropDef(Item2).Name);
  end;

begin
  List.Sort(@CompareNames);
end;

procedure TPropDefList.UnmapAll;
var
  x: integer;
begin
  for x := 0 to List.Count-1 do
    Items[x].Mapped:= false;

end;

{ TPropDef }

function TPropDef.DataTypeAsString: string;
begin
  case DataType of
    pdtString: result:= FieldType_Text;
    pdtInteger: result:= FieldType_Integer;
    pdtFloat: result:= FieldType_Float;
    pdtBoolean: result:= FieldType_Boolean;
    pdtDateTime: result:= FieldType_DateTime;
  end;
end;

initialization

  RegisterClass(TfmImportDataMapping);
  FormFact.RegisterMe(TfmImportDataMapping, 'TfmImportDataMappingList_*=ImportDataMapID');


end.
