unit HTMLExport;
interface
uses
  Windows, Sysutils, classes, Graphics, Controls, DB, contnrs,
  wwdbGrid, wwdbigrd, wwStr, wwDbComb, wwRadioGroup, wwCheckbox, wwMemo,
  HTMLLib, ERPdbComponents, Dialogs;

type
  // Number of extra fields
  TGetCount = function : integer of object;
  // Display name of the column
  TGetExtraName = function (idx : integer) : string of object;
  // Data field of the column
  TGetExtraData = function(idx, linkId : integer) : TField of object;
  // File name of the column, if we need it
  TGetExtraFileName = function (idx, LinkId : integer) : string of object;

  THTMLExport = class
  private
    fFileName: string;
    fGrid: TwwDbGrid;
    fFilePath: string;
    fSubFolder: string;
    fPage : TSTringList;
    fHTMLBorderWidth: integer;
    fShowHeader: boolean;
//    fQuery: TERPQuery;
    fExportFieldTitle: TStringList;
    fExportFieldList: TStringList;
    fTitleColor: TColor;
    fTitleFont: TFont;
    fTitleName: string;
    fDummyFont: TFont;
    fTitleAlignment: TAlignment;
    fShowRecordNo: boolean;
    fDataFont: TFont;
    fGridFont: TFont;
    fBrush: TBrush;
    fLinkField: string;
    FOnExtraColumnCount: TGetCount;
    fOnGetExtraColumnData: TGetExtraData;
    fOnGetExtraColumnName: TGetExtraName;
    fOnGetExtraFileName: TGetExtraFileName;
    procedure SetFileName(const Value: string);
    function GetPage: TStringList;
//    procedure SetQuery(const Value: TERPQuery);
    function GetExportFieldList: TStringList;
    function GetExportFieldTitle: TStringList;
    procedure SetGrid(const Value: TwwDbGrid);
    procedure SetTitleFont(const Value: TFont);
  protected
    // helpers by the filed type
    procedure DoControlURLLink(const AControlType, ADataStr : string; idx : integer; sl : TStringList);
    procedure DoControlCombo(CustomEdit : TWinControl;  const DataStr : string; CurRow : integer; sl: TStringList);
    procedure DoCustomEdit(const Parameters : string; var DataStr : string; CurRow : integer; sl : TStringList);


    procedure WriteHTMLHeader;
    procedure WriteTableHeader;
    procedure WriteTableFooter;
    procedure WriteHtmlTrailer;
    procedure DoExecute;
    procedure WriteDataRow(curRow : integer);

    // Build list of fields to export;
    procedure BuildExportList;

    procedure SetDataFonts(aTitle : boolean);

    function GetExtraColumnCount : integer;
    function GetExtraColumnName(idx : integer) : string;
    function GetExtraColumnData(idx, LinkId : integer) : TField;
    function GetExtraFileName(idx, LinkId : integer) : string;

    property FilePath : string read fFilePath write fFilePath;
    property SubFolder : string read fSubFolder write fSubFolder;
    property FileName : string read fFileName write SetFileName;
    property Grid : TwwDbGrid read fGrid write SetGrid;
    property Page : TStringList read GetPage;
    property ExportFieldList : TStringList read GetExportFieldList write fExportFieldList;
    property ExportFieldTitle : TStringList read GetExportFieldTitle write fExportFieldTitle;
    property DummyFont : TFont read fDummyFont write fDummyFont;
    property GridFont : TFont read fGridFont write fGridFont;
    property GridBrush : TBrush read fBrush write fBrush;
  public
//    Constructor Create;overload;
    Constructor Create(aGrid : TwwDbGrid = nil);overload;
    destructor Destroy; override;

    procedure Execute;overload;
    procedure Execute(const aFileName : string; aGrid : TwwDbGrid);overload;


    property HTMLBorderWidth : integer read fHTMLBorderWidth write fHTMLBorderWidth;
    property ShowHeader : boolean read fShowHeader write fShowHeader;

    //---- Title formatting
    property TitleColor : TColor read fTitleColor write fTitleColor;  // Background colour
    property TitleFont : TFont read fTitleFont write SetTitleFont;
    property TitleName : string read fTitleName write fTitleName;
    property TitleAlignment : TAlignment read fTitleAlignment write fTitleAlignment;
    //---- Table properties
    // Show record number in the table
    property ShowRecordNo : boolean read fShowRecordNo write fShowRecordNo;
    //-- data formatting
    property DataFont : TFont read fDataFont write fDataFont;
    //---------- pictures
    //----- Extra query properies
    // Link filed name. Must be the same field we have on the grid data source
    property LinkField : string read fLinkField write fLinkField;

    property OnGetExtraColumnCount : TGetCount read FOnExtraColumnCount write fOnExtraColumnCount;
    property OnGetExtraColumnName : TGetExtraName read fOnGetExtraColumnName write fOnGetExtraColumnName;
    property OnGetExtraColumnData : TGetExtraData read fOnGetExtraColumnData write fOnGetExtraColumnData;
    property OnGetExtraFileName : TGetExtraFileName read fOnGetExtraFileName write fOnGetExtraFileName;
  end;

implementation


function getdbcol(Grid:TwwDBGrid; col:integer) : integer;
begin
   result:= col;
   if wwdbigrd.dgIndicator in Grid.Options then
     result:= col - 1;
end;

Function XIndicatorOffset(Grid : TwwDBGrid): integer;
begin
  if dgIndicator in Grid.Options then
    result := 1
  else
    result := 0;
end;

{ THTMLExport }

procedure THTMLExport.BuildExportList;
var
  idx : integer;
  Accept : boolean;
  lName : string;
begin
  // free old stuff
  FreeAndNil(fExportFieldList);
  FreeAndNil(fExportFieldTitle);

    for idx := 0 to Grid.Datalink.FieldCount - 1 do
    begin
      Accept := True;
      if Assigned(Grid.OnExportField) then
        Grid.DoExportField(Grid, Grid.DataLink.Fields[idx], Accept);
      if Accept then
      begin
       lName := Grid.DataSource.DataSet.FieldDefs[idx].Name;
       ExportFieldList.Add(lName);
       ExportFieldTitle.Add(Grid.DataLink.Fields[idx].DisplayName);
      end;
    end;
end;

procedure THTMLExport.DoControlCombo(CustomEdit : TWinControl; const DataStr : string; CurRow : integer; sl: TStringList);
var
  Pos1,
  j : integer;
  ComboSTr,
  DisplayStr : string;
begin
  with Twwdbcombobox(customedit) do
  begin
    sl.Add('<Select Name="wwCombo'+inttostr(currow)+'">');
    for j:= 0 to Items.count-1 do
    begin
      if MapList then
      begin
        Pos1 := 1;
        displaystr := strGetToken(Items[j],#9,Pos1);
        combostr := combostr+'<Option Value="'+strGetToken(Items[j],#9,Pos1)+'"';
        if SameText(DataSTr, displaystr) then
          combostr := combostr +' selected';
        sl.Add(comboStr + '>' + DisplayStr);
      end
      else
      begin
        combostr := '<Option Value="' + Items[j]+'"';
        if SameTExt(DataStr, Items[j]) then
          combostr := combostr +' selected';
        sl.Add(combostr +'>'+Items[j]);
      end;
    end;
  sl.Add('</Select>');
  end;
end;

procedure THTMLExport.DoControlURLLink(const AControlType, ADataStr : string; idx: integer; sl: TStringList);
var
  Pos1, pos2, pos3 : integer;
  URLDisplay, LinkAddress : string;
begin
  if (AControlType = 'URL-Link') then
  begin
    Grid.GetURLLink(Grid.Datalink.Fields[idx].asString, URLDisplay, LinkAddress);

    if SameText(URLDisplay,LinkAddress) then
    begin
      //  Check for e-mail link
      pos1:= AnsiPos('@', LinkAddress);
      pos2:= AnsiPos('.', LinkAddress);
      pos3:= AnsiPos('MAILTO:',AnsiUpperCase(LinkAddress));
      if (pos1>1) and (pos2>pos1) and (pos3 <=0) then
        LinkAddress:= 'MailTo:' + LinkAddress;
    end;

    sl.Add('<A href="'+LinkAddress+'">'+ADataStr+'</A>');
  end;
end;

procedure THTMLExport.DoCustomEdit(const Parameters : string;
  var DataStr: string; CurRow : integer; sl: TStringList);
var
  Pos1 : integer;
  j : integer;
  ControlName : string;
  RadioStr : string;
  CustomEdit : TWinControl;
begin
  Pos1:= 1;
  controlname:= strGetToken(Parameters, ';', Pos1);
  customEdit:= Grid.GetComponent(controlname);
  if customEdit is TwwRadioGroup then
  begin
    with TwwRadioGroup(customedit) do
    begin
      radiostr :='';
      for j:= 0 to Items.count-1 do
      begin
        radiostr := radiostr + '<input align="middle" type="radio" value="'+GetButtonValue(j)+'" name="radio'+inttostr(currow)+'"';
        if SameText(DataStr, GetDisplayValue(GetButtonValue(j))) then
          radiostr := radiostr +' checked';
        sl.Add(radiostr+'>'+items[j]+'<BR>');
      end;
    end;
  end
  else if customedit is TwwCheckbox then
  begin
    with TwwCheckbox(customedit) do
    begin
      if SameText(datastr,ValueChecked) then
        sl.Add('<input align="middle" type="checkbox" checked >')
      else
        sl.Add('<INPUT ALIGN="middle" TYPE="checkbox" >');
    end;
  end
  else if customedit is TwwDBComboBox then
  begin
    DoControlCombo(CustomEdit, datastr, Currow, sl);
  end
  else
  begin
    if DataStr = '' then
      DataStr := '&nbsp;';
  end;
end;

constructor THTMLExport.Create(aGrid: TwwDbGrid);
begin

  inherited Create;
  HTMLBorderWidth := 1;  // default
  ShowHeader := true;
  // Create fonts
  DummyFont := TFont.Create;
  DummyFont.Name := 'Arial';
  DummyFont.Size := 10;
  TitleFont := DummyFont;
  TitleColor := clWhite;
  TitleName := 'Customer Type Price List';
  TitleAlignment := taCenter;
  ShowRecordNo := false;
  DataFont := DummyFont;
  Grid := aGrid;
end;

destructor THTMLExport.Destroy;
begin
  // do NOT destroy grid!
  DummyFont.Free;
  fExportFieldTitle.Free;
  fExportFieldList.Free;
  inherited;
end;

{$WARN SYMBOL_PLATFORM OFF}
procedure THTMLExport.DoExecute;
var
  idx : integer;
  lFileDialog : TSaveDialog;

begin
  if not Grid.DataLink.Active then
    exit;

  //lFileDialog := TFileSaveDialog.Create(nil);
  lFileDialog := TSaveDialog.Create(nil);
  try
    lFileDialog.Title := TitleName;
    lFileDialog.Filter := 'HTML File|*.htm,*.html';
    if lFileDialog.Execute then
      FileName := lFileDialog.FileName
    else
      exit;
  finally
    lFileDialog.Free;
  end;

  BuildExportList;

  Page;  // Create page
  try
    WriteHTMLHeader;
    WriteTableHeader;

    if Grid.SelectedList.Count > 0 then
    begin
      for idx :=0 to Grid.SelectedList.count-1 do
        WriteDataRow(idx);
    end
    else
    begin
      Grid.DataSource.DataSet.First;
      idx := 0;
      while not Grid.DataSource.DataSet.Eof do
      begin
        WriteDataRow(idx);
        idx := idx + 1;
        Grid.DataSource.DataSet.Next;
      end;

    end;

    WriteTableFooter;
    WriteHtmlTrailer;

    Page.SaveToFile(ChangeFileExt(FilePath + FileName,'.html'), TEncoding.UTF8);
  finally
    FreeAndNil(fPage);
  end;
end;
{$WARN SYMBOL_PLATFORM ON}

procedure THTMLExport.Execute(const aFileName: string; aGrid: TwwDbGrid);
begin
  FileName := aFileName;
  Grid := aGrid;
  Execute;
end;

function THTMLExport.GetExportFieldList: TStringList;
begin
  if not assigned(fExportFieldList) then
    fExportFieldList := TStringList.Create;
  Result := fExportFieldList;
end;

function THTMLExport.GetExportFieldTitle: TStringList;
begin
  if not assigned(fExportFieldTitle) then
    fExportFieldTitle := TStringList.Create;
  Result := fExportFieldTitle;
end;

function THTMLExport.GetExtraColumnCount: integer;
begin
  if assigned(OnGetExtraColumnCount) then
    Result := OnGetExtraColumnCount
  else
    Result := 0;
end;

function THTMLExport.GetExtraColumnData(idx, LinkId: integer): TField;
begin
  if Assigned(OnGetExtraColumnData) then
    Result := OnGetExtraColumnData(idx, LinkId)
  else
    Result := nil;

end;

function THTMLExport.GetExtraColumnName(idx: integer): string;
begin
  if assigned(OnGetExtraColumnName) then
    Result := OnGetExtraColumnName(idx)
  else
    Result := '';
end;

function THTMLExport.GetExtraFileName(idx, LinkId: integer): string;
begin
  if assigned(OnGetExtraFileName) then
    Result := OnGetExtraFileName(idx, linkid)
  else
    Result := '';
end;

function THTMLExport.GetPage: TStringList;
begin
  if not assigned(fPage) then
    fPage := TStringList.Create;
  Result := fPage;
end;

procedure THTMLExport.SetDataFonts(aTitle : boolean);
begin
  if not assigned(fGridFont) then
    gridFont := TFont.Create;
  if not assigned(fBrush) then
    GridBrush := TBrush.Create;

  if aTitle then
  begin
    if TitleFont <> DummyFont then
      gridFont.Assign(Grid.Canvas.Font)
    else
      gridFont.assign(TitleFont);
  end
  else
  begin
    if DataFont <> DummyFont then
      gridFont.Assign(Grid.Canvas.Font)
    else
      gridFont.assign(DataFont);
  end;
  gridBrush.Assign(Grid.Canvas.Brush);
  GridBrush.Color:=TitleColor;
end;

procedure THTMLExport.SetFileName(const Value: string);
begin
  fFileName := ExtractFileName(Value);
  FilePath := ExtractFilePath(Value);
end;

procedure THTMLExport.SetGrid(const Value: TwwDbGrid);
begin
  fGrid := Value;
  // Get fonts from the grid
  if Assigned(fGrid) then
    DataFont.Assign(Grid.Font)
  else if not assigned(fDataFont) then
    DataFont.Assign(DummyFont);
end;

procedure THTMLExport.SetTitleFont(const Value: TFont);
begin
  fTitleFont := Value;
end;

procedure THTMLExport.WriteDataRow(curRow : integer);
var i,j : integer;
  AControlType, Parameters: String;
  checkstr,uncheckstr:string;
  Rowstr,tempstr:String;
  sl : TStringList;
  lExtraField : TField;
  lExtraLink : integer;
  lExtraFile : string;
  lTemp,
  lTemp1 : string;

begin
  SetDataFonts(false);
  Page.Add('<TR VALIGN="TOP" ' + HTMLFont(DataFont)+'>');

  sl := TStringList.Create;
  try
  if ShowRecordNo then
    Page.Add('<TD WIDTH="0*" NOWRAP ALIGN="right" scope="row" '+HTMLFont(TitleFont)+' '+BGColor(TitleColor)+'>'+
              IntToStr(curRow)+'</TD>');
  for i:=0 to exportFieldList.Count-1 + GetExtraColumnCount do
  begin
    if i < exportFieldList.Count then
    begin
      Grid.DoCalcCellColors(Grid.DataLink.Fields[i], [], False, gridFont, gridBrush);
      Grid.GetControlInfo(Grid.Datalink.Fields[i].FieldName, AControlType, Parameters);
      tempstr := TrimRight(Grid.GetFieldValue(i));  //6/3/2001-PYW-Strip Trailing Spaces.
      if (AControlType = 'CheckBox') then
      begin
        Grid.isCheckBox(i+xIndicatorOffset(grid), 1, checkstr, uncheckstr);
        if tempstr = checkstr then
          sl.Add('<input align="middle" type="checkbox" checked >')
        else
          sl.Add('<INPUT ALIGN="middle" TYPE="checkbox" >');
      end
      else if (AControlType = 'CustomEdit') then
      begin
        DoCustomEdit(Parameters, tempstr, Currow, sl);
      end;

      DoControlURLLink(AControlType, tempstr, i, sl);
      RowStr := '<TD NOWRAP';

      if AControlType<>'CheckBox' then
        RowStr := RowStr + ' ALIGN="'+HTMLAlignment(Grid.DataLink.Fields[i].Alignment)+'"';

      Grid.DoCalcCellColors(Grid.DataLink.Fields[i], [], False, gridFont, gridBrush);

    end
    else
    begin
      RowStr := '<TD NOWRAP';
      lExtraField := Grid.DataSource.DataSet.FindField(LinkField);
      if assigned(lExtraField) then
      begin
        lExtraLink := lExtraField.AsInteger;
        lExtraField := GetExtraColumnData(i - exportFieldList.Count - 1, lExtraLink);
        if lExtraField is TBlobField then
        begin
          lExtraFile := GetExtraFileName(i - exportFieldList.Count - 1, lExtraLink);
          lExtraFile := StringReplace(lExtraFile, '\', '_', [rfReplaceAll]);
          lExtraFile := StringReplace(lExtraFile, '/', '_', [rfReplaceAll]);
          if lExtraFile = '' then
            Continue;
          lTemp := ExpandFileName(FilePath + FileName);
          lTemp1 := ExtractFileExt(FileName);
          if lTemp1 <> '' then
            lTemp := copy(lTemp, 1, length(lTemp) - length(lTemp1));
          lTemp := lTemp + 'Files';
          //DirectoryExists(lTemp, true);
          ForceDirectories(lTemp);
          lTemp1 := lTemp + '\' + lExtraFile;
          if not FileExists(lTemp1) then
            (lExtraField as TBlobField).SaveToFile(lTemp1);

          sl.Add('<IMG SRC="' + lTemp1 + '">');
        end
        else
        begin
          tempstr := ''; //Page.Add('<TD>' + lExtraField.AsString + '</TD>');
        end;
      end
      else
      tempstr := '';
    end;

    RowStr := RowStr + ' ' + HTMLFont(gridFont) + ' ' + BGColor(gridBrush.Color);
      if ((AControlType = 'RichEdit') or ((Grid.DataLink.Fields[i] is TMemoField) and (mGridShow in Grid.MemoAttributes))) then
        RowStr := RowStr + ' WIDTH="'+inttostr(Trunc(Grid.ColWidthsPixels[i+xIndicatorOffset(Grid)]))+'" SCOPE="row">'+HTMLFontStyle(tempstr, gridfont)+'</TD>'
      else if tempstr='' then
        RowStr := RowStr + ' WIDTH="0*" SCOPE="row">&nbsp;</TD>'
      else if sl.Count > 0 then
      begin
        Page.Add(RowStr + ' WIDTH="0*" SCOPE="row">' );
        for j := 0 to sl.Count - 1 do
          Page.Add(sl[j]);
        sl.Clear;
        RowStr := '</TD>';
      end
      else
        RowStr := RowStr + ' WIDTH="0*" SCOPE="row">' + HTMLFontStyle(tempstr, gridfont)+'</TD>';
      Page.Add(RowStr);
      RowStr := '';  // when it is the last column, we can get extra /TD
  end;

  Page.Add(RowStr + '</TR>');

  finally
    sl.Free;
  end;
end;

procedure THTMLExport.WriteHTMLHeader;
begin
  Page.add('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">');
  Page.Add('<META HTTP-EQUIV="CONTENT-TYPE" CONTENT="text/html; charset=UTF-8">');
  Page.Add('<HTML>');
  Page.Add('<Head>');
  Page.Add('<TITLE>Customer Type Price List</TITLE>');
	Page.Add('<META NAME="GENERATOR" CONTENT="TrueERP">');
  Page.Add('</HEAD>');
  Page.Add('<BODY>');

end;

procedure THTMLExport.WriteHtmlTrailer;
begin
  Page.Add('</BODY>');
  Page.Add('</TABLE>');
  Page.Add('</HTML>');
end;

procedure THTMLExport.WriteTableFooter;
begin
  Page.Add('</TBODY>');
end;

procedure THTMLExport.WriteTableHeader;
var
  sFont,
  sHtml : string;
  i, j : integer;
  lGroupAssigned : boolean;
  startCol,
  endCol : integer;
  groupCount : integer;
begin
//  lgroupAssigned := false;
  sHtml :='<TABLE ALIGN=Center BORDER="'+inttostr(HTMLBorderWidth)+'" CELLPADDING="1" CELLSPACING="0"';

  if Grid.BiDiMode = bdLeftToRight then
    sHtml := sHtml + ' dir="LTR"'
  else
    sHtml := sHtml + ' dir="RTL"';

  Page.Add(sHtml + '>');  // Transparent grid

  // Headers
  Page.Add('<THEAD>');
  BuildExportList;
  if ShowHeader then
  begin
    Page.Add('<TR ' + HTMLFont(Grid.TitleFont) + ' ' + BGColor(Grid.TitleColor) + '>');
    startCol := exportFieldList.count + GetExtraColumnCount;
    if ShowRecordNo then
      startCol := startCol + 1;
    Page.Add('<TH colspan="'+IntToStr(startCol)+ '" scope="colgroup">'+TitleName+'</TH></TR>');
  end;

  //Now Do Titles and Group Children
  j:=0;
  lGroupAssigned := False;
  // Loop Twice.  Once for normal titles and the Group Header if there is one and once for the group children.
  while j<2 do
  begin
    i:=0;
    //Set Title's Font Properties
    Page.Add('<TR ' + HTMLFont(TitleFont) + ' ' + BGColor(Grid.TitleColor) + ' ALIGN=' + HTMLAlignment(TitleAlignment)+'>');

    // If this is the RecordNo title then make sure it spans two rows.  Only do this the first time.
    if (j=0) and (ShowRecordNo) then
    begin
      Page.Add('<TD ALIGN="CENTER" '+ HTMLFont(TitleFont)+ ' SCOPE="col" ' + BGColor(Grid.TitleColor) + ' RowSpan="2"> '+
                HTMLFontStyle('#', TitleFont) + '</TD>');
    end;

    // Now iterate through the fields.
    while (i <= ExportFieldList.Count-1 + GetExtraColumnCount) do
    begin
      SetDataFonts(true);
      sFont := '';
      if (gridfont.Name <> TitleFont.Name) or (GridFont.Size <> TitleFont.Size) or
         (gridfont.Color <> TitleFont.color) then
        sFont := ' ' + HTMLFont(GridFont) + ' ' + BGColor(Grid.TitleColor);
        if (j>0) or ((i < ExportFieldList.Count) and (Grid.Columns[getdbcol(Grid, i + xIndicatorOffset(Grid))].GroupName = '')) or
           (i >= ExportFieldList.Count) then
        begin
            if j=0 then
            begin
              Page.Add('<TD' + sFont + ' ALIGN="' + HTMLAlignment(TitleAlignment)+
                       '" SCOPE="col" ' + BGColor(Grid.TitleColor) +
                       ' RowSpan="2">');
              if (i < ExportFieldList.Count) then
                Page[Page.Count - 1] := Page[Page.Count - 1] +
                   HTMLFontStyle(StringReplace(Grid.Columns[getdbcol(Grid,i + xIndicatorOffset(Grid))].DisplayLabel,'~','<BR>',[rfReplaceAll, rfIgnoreCase]), GridFont) + '</TD>'
              else
                Page[Page.Count - 1] := Page[Page.Count - 1] +
                   HTMLFontStyle(GetExtraColumnName(i - ExportFieldList.Count - 1), GridFont) + '</TD>';
            end
            else if ((i < ExportFieldList.Count) and (Grid.Columns[getdbcol(Grid, i+xIndicatorOffset(Grid))].GroupName <> '')) then
            begin
              Page.Add('<TD'+ sFont+ ' ALIGN="'+HTMLAlignment(TitleAlignment)+ '" SCOPE="col" ' + BGColor(Grid.TitleColor) + '>' +
                        HTMLFontStyle(StringReplace(Grid.Columns[getdbcol(Grid, i+xIndicatorOffset(Grid))].DisplayLabel,'~','<BR>', [rfReplaceAll, rfIgnoreCase]), GridFont) +
                                    '</TD>');
            end;
          inc(i);
        end
        else
        begin
          Grid.GroupNameCellRect(i+xIndicatorOffset(grid), 0, startcol, endcol, false);
          groupCount := endCol - startCol + 1;
          if groupCount > 0 then
          begin  // it is the grid mode
            Page.Add('<TD' + sFont + ' SCOPE="col" ' + BGColor(Grid.TitleColor) +
                     ' ALIGN=CENTER ColSpan="'+inttostr(groupCount) + '">' +
                     HTMLFontStyle(Grid.Columns[getdbcol(Grid,i+xIndicatorOffset(grid))].GroupName,GridFont) + '</TD>');
            lgroupassigned := True;
          end;
          inc(i,endcol-startcol+1);
        end;
      end;
    inc(j);
    Page.Add('</TR>');
    if not lgroupassigned then
      break;
  end; //End While j<2
  if j = 1 then
    Page.Add('<TR></TR>');
  Page.Add('</THEAD>');
  Page.Add('<TBODY>');
end;

procedure THTMLExport.Execute;
begin
  if not assigned(fGrid) then
    exit;
  if not assigned(fExportFieldList) then
    BuildExportList;

  DoExecute;
end;

end.
