unit CustomizeListObj;

  // Date     Version  Who What
  // -------- -------- --- ------------------------------------------------------
  // 27/07/05  1.00.01 IJB Changed order in which GetViewableFields tries to get
  //                       field data from db (ie for user first, company second,
  //                       default class last).
  // 08/08/05  1.00.02 DMS Added custom OnColumnMove event so that the original
  //                       event of the grid can still be called if needed.

interface

uses
  Windows,  Classes, SysUtils, DB, Graphics, MyAccess,ERPdbComponents, Dialogs,
  Wwdbigrd, Grids, Wwdbgrid, tcTypes;

type
  TCustomizeListObj = class(TObject)
  private
    //    fiGuiID: Integer;
    //    FUserDefault: Boolean;
    slLockList: TStringList;
    FUseColumnWidth: boolean;
    FOnColumnMove: TOnIndexChangeEvent;
    procedure ColumnMoved(Sender: TObject; FromIndex, ToIndex: integer);
    procedure SetUseColumnWidth(const Value: boolean);
    //    procedure SetUserDefault(value: Boolean);
  public
    NoReadOnly: boolean;
    function GetGuiID(const sClassName: string; const iEmployeeID: integer; const sReport: string): integer;
    function GetReportName(const iGuiID: integer): string;

    function GetViewableFields(const sClassName: string; const vEmployeeID: integer;
      var iRowHeight: integer; var sAltRowColor, sFontDetails: string; var sColumnsOrder: string;
      var bGridLines: boolean; var sListMode: string; const sReport: string = ''): boolean; overload;

    function GetViewableFields(const iGuiID: integer; var iRowHeight: integer;
      var sAltRowColor, sFontDetails: string; var sColumnsOrder: string; var bGridLines: boolean; var sListMode: string): boolean;
      overload;

    procedure SaveViewableFields(const sClassName: string; const vEmployeeID: integer;
      const iRowHeight: integer; const sAltRowColor: string; const sFontDetails: string; const sColumnsOrder: string;
      const bGridLines: boolean; const sReport: string; const sTab: string; const sListMode: string; const qryInput: TERPQuery);

    procedure GetPreviousSettings(const wwGrd: TwwDBGrid; const sOwner: string);
    procedure SaveGridDetails(const sControlName, sOwner: string; grdUseGrid: TwwDBGrid);
    procedure BindColumnMovedEvent(DBGrid: TwwDBGrid);

    class function PopulateKeyList: TStringList;
    property LockList: TStringList read slLockList write slLockList;
    property UseColumnWidth: boolean read FUseColumnWidth write SetUseColumnWidth;
    property OnColumnMove: TOnIndexChangeEvent read FOnColumnMove write FOnColumnMove;
  end;

const
  DEFAULTCLASS = 'TPrefSettingsListGUI';

implementation

uses FastFuncs, Forms, AuditObj, CommonDbLib,   AppEnvironment, CommonLib;

function TCustomizeListObj.GetViewableFields(const sClassName: string; const vEmployeeID: integer;
  var iRowHeight: integer; var sAltRowColor, sFontDetails: string; var sColumnsOrder: string;
  var bGridLines: boolean; var sListMode: string; const sReport: string = ''): boolean;
{ 16.7.
  change of interface:
  caller provides vEmployeeID to allow default settings for employee & company
  (we need vEmployeeID so we can read in and change the company default settings -
    even though there might exist user defaults already...)
  sColumnsOrder will be '' unless we can retrieve the class specific settings
}
var
  qryViewableFields: TERPQuery;
  oDatasource: TDataSource;
begin // GetViewableFields
  try
    qryViewableFields := TERPQuery.Create(nil);
    qryViewableFields.Connection := CommonDbLib.GetSharedMyDacConnection;
    oDatasource       := TDataSource.Create(nil);
    try
      oDatasource.DataSet := qryViewableFields;
      with qryViewableFields do begin
        Sql.Add('SELECT GuiID, ColumnsOrder, RowHeight, GridLines,ListMode, ' +
          'AltRowColor, FontDetails ' +
          'FROM tblCustomizedLists ' +
          'WHERE EmployeeID = :xEmployeeID ' +
          'AND ClassName = :xClassName ' +
          'AND Report = :xReport');
        // first try to read user settings for sClassName;
        ParamByName('xEmployeeID').asInteger := vEmployeeID;
        ParamByName('xClassName').asString := sClassName;
        ParamByName('xReport').asString := sReport;
        Open;
        Result := qryViewableFields.RecordCount = 1;
        if not Result then // second try and get company default settings
        begin
          ParamByName('xEmployeeID').asInteger := 0;
          Close;
          Open;
          Result := qryViewableFields.RecordCount = 1;
          if not Result then // third try and get default class settings
          begin
            ParamByName('xClassName').asString := DEFAULTCLASS;
            Close;
            Open;
            Result := qryViewableFields.RecordCount = 1;
          end;
        end;
        if Result then begin
          //          fiGuiID := fieldbyname('GuiID').AsInteger;
          iRowHeight := FieldByName('RowHeight').AsInteger;
          bGridLines := FieldByName('GridLines').AsBoolean;
          sAltRowColor := FieldByName('AltRowColor').AsString;
          sFontDetails := FieldByName('FontDetails').AsString;
          sListMode := FieldByName('ListMode').AsString;
          if ParamByName('xClassName').asString <> DEFAULTCLASS then
            sColumnsOrder := FieldByName('ColumnsOrder').AsString
          else sColumnsOrder := '';
        end;
      end;
    finally
      FreeAndNil(qryViewableFields);
      FreeAndNil(oDatasource);
    end;
  except
    on e: Exception do begin
      raise Exception.Create(e.message);
    end;
  end;
end;

function TCustomizeListObj.GetViewableFields(const iGuiID: integer; var iRowHeight: integer;
  var sAltRowColor, sFontDetails: string; var sColumnsOrder: string; var bGridLines: boolean;
  var sListMode: string): boolean;
var
  qryViewableFields: TERPQuery;
  oDatasource: TDataSource;
begin // GetViewableFields
  try
    qryViewableFields := TERPQuery.Create(nil);
    qryViewableFields.Connection := CommonDbLib.GetSharedMyDacConnection;
    oDatasource       := TDataSource.Create(nil);
    try
      oDatasource.DataSet := qryViewableFields;
      with qryViewableFields do begin
        Sql.Add('SELECT ColumnsOrder, RowHeight, GridLines,ListMode, ' +
          'AltRowColor, FontDetails ' +
          'FROM tblCustomizedLists ' +
          'WHERE GuiID = :xGuiID');
        ParamByName('xGuiID').asInteger := iGuiID;
        Open;
        Result := qryViewableFields.RecordCount = 1;
        if Result then begin
          iRowHeight := FieldByName('RowHeight').AsInteger;
          bGridLines := FieldByName('GridLines').AsBoolean;
          sAltRowColor := FieldByName('AltRowColor').AsString;
          sFontDetails := FieldByName('FontDetails').AsString;
          sColumnsOrder := FieldByName('ColumnsOrder').AsString;
          sListMode := FieldByName('ListMode').AsString;
        end;
      end;
    finally
      FreeAndNil(qryViewableFields);
      FreeAndNil(oDatasource);
    end;
  except
    on e: Exception do begin
      raise Exception.Create(e.message);
    end;
  end;
end;

procedure TCustomizeListObj.SaveViewableFields(const sClassName: string; const vEmployeeID: integer;
  const iRowHeight: integer; const sAltRowColor: string; const sFontDetails: string; const sColumnsOrder: string;
  const bGridLines: boolean; const sReport: string; const sTab: string; const sListMode: string; const qryInput: TERPQuery);
var
  //  qry1: TERPQuery;
  qry: TERPQuery;
  fiGuiID: integer; // make this local (avoiding state)

  procedure PrepareParameters;
  begin
    with qry do begin
      Params.ParamByName('xEmployeeID').AsInteger    := vEmployeeID;
      Params.ParamByName('xClassName').AsString      := sClassName;
      Params.ParamByName('xCreationDate').AsDateTime := Now;
      Params.ParamByName('xRowHeight').AsInteger     := iRowHeight;
      Params.ParamByName('xRowColor').AsString       := sAltRowColor;
      Params.ParamByName('xFontDetails').AsString    := sFontDetails;
      Params.ParamByName('xColumnsOrder').AsString   := sColumnsOrder;

      if bGridLines then begin
        Params.ParamByName('xGridLines').AsString := 'T';
      end else begin
        Params.ParamByName('xGridLines').AsString := 'F';
      end;

      Params.ParamByName('xReport').AsString    := sReport;
      Params.ParamByName('xReportTab').AsString := sTab;
      Params.ParamByName('xListMode').AsString  := sListMode;
    end;
  end;

  procedure PerformInsert;
  begin
    qry.Sql.Add('INSERT HIGH_PRIORITY INTO tblCustomizedLists ' +
      '(EmployeeID, ClassName, CreationDate, RowHeight, ' +
      'GridLines, AltRowColor, ColumnsOrder, FontDetails, Report, ReportTab,ListMode ) ' +
      'VALUES (:xEmployeeID, :xClassName, :xCreationDate, :xRowHeight, ' +
      ':xGridLines, :xRowColor, :xColumnsOrder, :xFontDetails, ' +
      ':xReport, :xReportTab, :xListMode)');
    PrepareParameters;
    qry.Execute;
  end;

  procedure PerformUpdate;
  begin
    with qry do begin
      Sql.Add('UPDATE tblCustomizedLists ' +
        'SET EmployeeID = :xEmployeeID, ' +
        'ClassName = :xClassName, ' +
        'CreationDate = :xCreationDate, ' +
        'RowHeight = :xRowHeight, ' +
        'GridLines = :xGridLines, ' +
        'AltRowColor = :xRowColor, ' +
        'ColumnsOrder = :xColumnsOrder, ' +
        'FontDetails = :xFontDetails, ' +
        'Report = :xReport, ' +
        'ReportTab = :xReportTab, ' +
        'ListMode = :xListMode ' +
        'WHERE GuiID = :xGuiID');
      PrepareParameters;
      Params.ParamByName('xGUIID').AsInteger := fiGuiID;
      Execute;
    end;
  end;
begin // SaveViewableFields
  qry := TERPQuery.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  qry.ParamCheck := true;
  try
    try
      fiGuiID := getGuiID(sClassName, vEmployeeID, sReport);
      if fiGuiID = 0 then begin
        PerformInsert;
      end else begin
        PerformUpdate;
      end;
    finally
      FreeAndNil(qry);
    end;
  except
    on e: Exception do begin
      Audit.AddEntry(e, self);
      raise Exception.Create(e.message);
    end;
  end;
end;

function TCustomizeListObj.GetReportName(const iGuiID: integer): string;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qry.SQL.Add(Format('SELECT Report FROM tblCustomizedLists ' +
      'WHERE GuiID = %d', [iGuiID]));
    qry.Open;
    if qry.RecordCount <> 0 then begin
      Result := Trim(qry.FieldByName('Report').AsString);
    end else begin
      Result := '';
    end;
    qry.Close;
  finally
    FreeAndNil(qry);
  end;
end;

function TCustomizeListObj.GetGuiID(const sClassName: string; const iEmployeeID: integer; const sReport: string): integer;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qry.SQL.Add(Format('SELECT GuiID FROM tblCustomizedLists ' +
      'WHERE ClassName = ''%s'' AND EmployeeID = %d ' +
      'AND Report = "%s"',
      [sClassName, iEmployeeID, sReport]));
    qry.Open;
    if qry.RecordCount = 1 then Result := qry.FieldByName('GuiID').AsInteger
    else Result := 0;
    qry.Close;
  finally
    FreeAndNil(qry);
  end;
end;


class function TCustomizeListObj.PopulateKeyList: TStringList;
var
  iIndex: integer;
begin
  Result := TStringList.Create;
  with TERPQuery.Create(Application) do try
      Connection := CommonDbLib.GetSharedMyDacConnection;
      Sql.Add('SELECT KeyID, KeyName FROM tblPrimaryKeys');
      Open;
      if not IsEmpty then begin
        for iIndex := 0 to RecordCount - 1 do begin
          Result.Add(FieldByName('KeyName').AsString);
          Next;
        end;
      end;
    finally
      Free;
    end;
end;

procedure TCustomizeListObj.GetPreviousSettings(const wwGrd: TWWdbGrid; const sOwner: string);
var
  qry: TERPQuery;
  slFieldInfo, slDataInfo: TStringList;
  iX, iIndex: integer;
  sControlName: string;
  MyKeyOptions: TwwDBGridKeyOptions;
  MyOptions: TwwDBGridOptions;
  MyEditControlOptions: TwwEditControlOptions;
  ColIndex: integer;

  function GetGridColumnIndex(const AFieldName: string): integer;
  var
    I: integer;
  begin
    Result := -1;
    for I := 0 to wwGrd.FieldCount - 1 do begin
      if wwGrd.Columns[I].FieldName = AFieldName then begin
        Result := I;
        Break;
      end;
    end;
  end;  
begin
  //////////////////////////////////////////////////////////////////////////////////
  // Field Information is stored and read as accordingly.
  //
  //////////////////////////////////////////////////////////////////////////////////
  // FieldName ^ Show Field Status ^ Display Column Width ^ Read Status ^ Column Pos ^ Display Label
  //////////////////////////////////////////////////////////////////////////////////
  qry := TERPQuery.Create(nil);
  slDataInfo := TStringList.Create;
  slFieldInfo := TStringList.Create;
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.ParamCheck := true;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tblemployeegridsettings');
    qry.SQL.Add('WHERE (EmployeeID = :xEID AND Owner = :xOwner AND ControlName = :xCName)');
    qry.SQL.Add('LIMIT 1;');
    qry.Params.ParamByName('xEID').AsInteger  := AppEnv.Employee.EmployeeID;
    qry.Params.ParamByName('xOwner').AsString := sOwner;
    if not Assigned(wwGrd) then begin
      // Failed! Can't restore settings if no grid is provided.
      Exit;
    end else begin
      // Set control name.
      sControlName := wwGrd.Name;
    end;

    qry.Params.ParamByName('xCName').AsString := sControlName;
    qry.Open;

    // Do we have a preference setting under the logged in user and criteria?
    if qry.RecordCount > 0 then begin
      MyOptions := wwGrd.Options;
      MyKeyOptions := wwGrd.KeyOptions;
      MyEditControlOptions := wwGrd.EditControlOptions;
      // Clear Grid Selected List.
      wwGrd.Selected.Clear;
      // First remove all default columns.
      ExtractStrings(['|'], [' '], PChar(qry.FieldByName('FieldList').AsString), slDataInfo);
      iIndex := 0;
      for iX := 0 to slDataInfo.Count - 1 do begin
        slFieldInfo.Clear;
        ExtractStrings(['^'], [' '], PChar(slDataInfo.Strings[iX]), slFieldInfo);
        // Is it enabled or not?
        if slFieldInfo.Strings[1] = 'T' then begin
          // Enabled
          wwGrd.Selected.Add(slFieldInfo.Strings[0] + #9 +
            slFieldInfo.Strings[2] + #9 +
            slFieldInfo.Strings[5] + #9 +
            slFieldInfo.Strings[3] + #9);

          try
            TField(wwGrd.Datasource.Dataset.FieldByName(slFieldInfo.Strings[0])).Index := iIndex;
            TField(wwGrd.Datasource.Dataset.FieldByName(slFieldInfo.Strings[0])).Tag := 1;
          except
            Continue;
          end;

          if UseColumnWidth then begin
            ColIndex := GetGridColumnIndex(slFieldInfo.Strings[0]);
            if ColIndex <> -1 then wwGrd.Columns[ColIndex].DisplayWidth := FastFuncs.StrToInt(slFieldInfo.Strings[2])
            else // do it old way
              TField(wwGrd.Datasource.Dataset.FieldByName(slFieldInfo.Strings[0])).DisplayWidth :=
                FastFuncs.StrToInt(slFieldInfo.Strings[2]);
          end else // preserving original code
            TField(wwGrd.Datasource.Dataset.FieldByName(slFieldInfo.Strings[0])).DisplayWidth :=
              FastFuncs.StrToInt(slFieldInfo.Strings[2]);
            
          TField(wwGrd.Datasource.Dataset.FieldByName(slFieldInfo.Strings[0])).DisplayLabel := slFieldInfo.Strings[5];
          Inc(iIndex);
        end;
      end; // End of For iX

      // Restore Grid State.
      wwGrd.ApplySelected;
      wwGrd.KeyOptions := MyKeyOptions;
      wwGrd.EditControlOptions := MyEditControlOptions;
      wwGrd.Options := MyOptions;
    end;

  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);
    if Assigned(slDataInfo) then
      FreeAndNil(slDataInfo);
    if Assigned(slFieldInfo) then
      FreeAndNil(slFieldInfo);
  end;
end;

procedure TCustomizeListObj.SaveGridDetails(const sControlName, sOwner: string; grdUseGrid: TwwDBGrid);
var
  qry: TERPQuery;
  sData, sTitle: string;
  iY, ColIndex: integer;
  slDataInfo: TStringList;

  function LocateFieldSize(const sFieldname: string): integer;
  var
    iX: integer;
  begin
    Result := 0;
    // Are we using a grid?
    if Assigned(grdUseGrid) then begin
      for iX := 0 to grdUseGrid.DataSource.DataSet.FieldCount - 1 do begin
        if sFieldname = grdUseGrid.Fields[iX].FieldName then begin
          Result := grdUseGrid.Fields[iX].DisplayWidth;
          Exit;
        end;
      end;
    end;
  end;

  function LocateFieldIndex(const sFieldname: string): integer;
  var
    iX: integer;
  begin
    Result := 0;
    // Are we using a grid?
    if Assigned(grdUseGrid) then begin
      for iX := 0 to grdUseGrid.FieldCount - 1 do begin
        if sFieldname = grdUseGrid.Fields[iX].FieldName then begin
          Result := iX;
          Exit;
        end;
      end;
    end;
  end;

  function LocateFieldTitle(const sFieldname: string): string;
  var
    iX: integer;
  begin
    // Are we using a dataset control?
    Result := '';
    // Are we using a grid?
    if Assigned(grdUseGrid) then begin
      for iX := 0 to grdUseGrid.FieldCount - 1 do begin
        if sFieldname = grdUseGrid.Fields[iX].FieldName then begin
          Result := grdUseGrid.Fields[iX].DisplayLabel;
          Exit;
        end;
      end;
    end;
  end;

  function LocateFieldReadStatus(const sFieldname: string): boolean;
  var
    iX: integer;
  begin
    // Are we using a grid?
    Result := true;
    if Assigned(grdUseGrid) then begin
      for iX := 0 to grdUseGrid.FieldCount - 1 do begin
        if sFieldname = grdUseGrid.Fields[iX].FieldName then begin
          if NoReadOnly then Result := false
          else Result := grdUseGrid.Fields[iX].ReadOnly;
          Exit;
        end;
      end;

      // Check the grids datasource
      for iX := 0 to grdUseGrid.DataSource.DataSet.FieldCount - 1 do begin
        if sFieldname = grdUseGrid.DataSource.DataSet.Fields[iX].FieldName then begin
          if NoReadOnly then Result := false
          else Result := grdUseGrid.Fields[iX].ReadOnly;
          Exit;
        end;
      end;
    end;
  end;

  function GetGridColumnIndex(const AFieldName: string): integer;
  var
    I: integer;
  begin
    Result := -1;
    for I := 0 to grdUseGrid.FieldCount - 1 do begin
      if grdUseGrid.Columns[I].FieldName = AFieldName then begin
        Result := I;
        Break;
      end;
    end;
  end;  
begin
  qry := TERPQuery.Create(nil);
  slDataInfo := TStringList.Create;
  try
    // First generate the required field info data that we must Save.
    for iY := 0 to grdUseGrid.FieldCount - 1 do begin
      sData := grdUseGrid.Fields[iY].FieldName + '^';
      sData := sData + 'T^';

      if UseColumnWidth then begin
        ColIndex := GetGridColumnIndex(grdUseGrid.Fields[iY].FieldName);
        if ColIndex <> -1 then sData := sData + IntToStr(grdUseGrid.Columns[ColIndex].DisplayWidth) + '^'
        else // do it old fashioned way
          sData := sData + IntToStr(LocateFieldSize(grdUseGrid.Fields[iY].FieldName)) + '^';
      end else sData := sData + IntToStr(LocateFieldSize(grdUseGrid.Fields[iY].FieldName)) + '^';
      
      if not LocateFieldReadStatus(grdUseGrid.Fields[iY].FieldName) then sData := sData + 'F'
      else sData := sData + 'T';

      sData := sData + '^' + IntToStr(LocateFieldIndex(grdUseGrid.Fields[iY].FieldName));
      
      sTitle := LocateFieldTitle(grdUseGrid.Fields[iY].FieldName);
      if sTitle = '' then sTitle := grdUseGrid.Datasource.DataSet.FieldByName(grdUseGrid.Fields[iY].FieldName).DisplayLabel;
          
      sData := sData + '^' + sTitle;
      slDataInfo.Add(sData);
    end;

    // Now finalise the data that we must Save.
    sData := '';
    for iY := 0 to slDataInfo.Count - 1 do begin
      if sData = '' then begin
        sData := sData + slDataInfo.Strings[iY];
      end else begin
        sData := sData + '|' + slDataInfo.Strings[iY];
      end;
    end;

    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.ParamCheck := true;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tblemployeegridsettings');
    qry.SQL.Add('WHERE (EmployeeID = :xEID AND Owner = :xOwner AND ControlName = :xCName)');
    qry.SQL.Add('LIMIT 1;');
    qry.Params.ParamByName('xEID').AsInteger  := AppEnv.Employee.EmployeeID;
    qry.Params.ParamByName('xOwner').AsString := sOwner;
    qry.Params.ParamByName('xCName').AsString := sControlName;
    qry.Open;

    // Do we have a current record?
    if qry.RecordCount > 0 then begin
      qry.Edit;
      qry.FieldByName('FieldList').AsString := sData;
      qry.Post;
    end else begin
      // No, create new record.
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('INSERT HIGH_PRIORITY INTO tblemployeegridsettings (EmployeeID, Owner, ');
      qry.SQL.Add('FieldList, IsGridSetting, GridRowHeight, ControlName) ');
      qry.SQL.Add('VALUES (:xEmpID, :xOwner, :xData, :xIsGrid, :xRowHeight, :xCName);');
      qry.Params.ParamByName('xEmpID').AsInteger := AppEnv.Employee.EmployeeID;
      qry.Params.ParamByName('xOwner').AsString := sOwner;
      qry.Params.ParamByName('xCName').AsString := sControlName;
      qry.Params.ParamByName('xData').AsString := sData;
      if Assigned(grdUseGrid) then begin
        qry.Params.ParamByName('xIsGrid').AsString := 'T';
        qry.Params.ParamByName('xRowHeight').AsInteger := grdUseGrid.RowHeightPercent;
      end else begin
        qry.Params.ParamByName('xIsGrid').AsString := 'F';
        qry.Params.ParamByName('xRowHeight').AsInteger := 100;
      end;

      // Insert new settings for this employee.
      qry.Execute;

      // Now locate our saved record as we now
      // need to write the GlobalRef field.
      qry.SQL.Clear;
      qry.SQL.Add('SELECT * FROM tblemployeegridsettings');
      qry.SQL.Add('WHERE (EmployeeID = :xEID AND Owner = :xOwner AND ControlName = :xCName)');
      qry.SQL.Add('LIMIT 1;');
      qry.Params.ParamByName('xEID').AsInteger := AppEnv.Employee.EmployeeID;
      qry.Params.ParamByName('xOwner').AsString := sOwner;
      qry.Params.ParamByName('xCName').AsString := sControlName;
      qry.Open;

      // Record found?
      if qry.RecordCount > 0 then begin
        // Yes, Store GlobalRef field.
        qry.Edit;
        qry.FieldByName('GlobalRef').AsString := AppEnv.Branch.SiteCode + qry.FieldByName('ID').AsString;
        qry.Post;
      end;
    end;
  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);
    if Assigned(slDataInfo) then
      FreeAndNil(slDataInfo);
  end;
end;

procedure TCustomizeListObj.BindColumnMovedEvent(DBGrid: TwwDBGrid);
begin
  try
    DBGrid.OnColumnMoved := ColumnMoved;
  except
    on e: Exception do begin
      CommonLib.MessageDlgXP_Vista('BindColMoveEvent procedure failed to bind!', mtWarning, [mbOK], 0);
      Exit;
    end;
  end;
end;

  //////////////////////////////////////////////////////////////////////
  // This is the Column Moved Event for a TwwDBGrid.
  // We will use this to monitor our locked columns.
  //
  // We also need to be sure that when we call this event that
  // the locklist property is valid.  If not, you know what happens?!?!
  //////////////////////////////////////////////////////////////////////

procedure TCustomizeListObj.ColumnMoved(Sender: TObject; FromIndex, ToIndex: integer);
var
  iX, iFixedSize: integer;
  arySrcName: array[0..255] of char;
  aryLockName: array[0..255] of char;
  Col: TwwColumn;
begin
  if Assigned(OnColumnMove) then OnColumnMove(Sender, FromIndex, ToIndex);

  // Ensure we have the required variables.
  if not Assigned(Sender) then Exit;
  if not Assigned(slLockList) then Exit;

  // Clear work buffers.
  ZeroMemory(@arySrcName, SizeOf(arySrcName));
  ZeroMemory(@aryLockName, SizeOf(aryLockName));

  // Copy source field name.
  StrPCopy(arySrcName, TwwDBGrid(Sender).Columns[ToIndex].FieldName);
  // lower its case.
  StrLower(arySrcName);

  try
    // Now we need to check this locklist to see if this fieldname
    // is present within.  If it is, we will move this column
    // straight back where we found it and have its initial settings
    // restored.
    for iX := 0 to slLockList.Count - 1 do begin
      // Copy this fieldname and lower its case so case does not matter
      StrPCopy(aryLockName, slLockList.Strings[iX]);
      StrLower(aryLockName);
      // Has the user moved a column that is restricted to move?
      if (ToIndex = 0) or (string(arySrcName) = string(aryLockName)) then begin
        // Get this columns width
        iFixedSize := TwwDBGrid(Sender).Columns[FromIndex].DisplayWidth;
        // Yes, Now move it back where it belongs.
        TwwDBGrid(Sender).RemoveField(slLockList.Strings[iX], true);
        TwwDBGrid(Sender).AddField(slLockList.Strings[iX], FromIndex, true);
        // Save Original Column Information
        Col := TwwDBGrid(Sender).Columns[FromIndex];
        TwwDBGrid(Sender).Columns[FromIndex].DisplayLabel := Col.DisplayLabel;
        TwwDBGrid(Sender).Columns[FromIndex].DisplayWidth := iFixedSize;
        // This must be done to show the new update.
        TwwDBGrid(Sender).RefreshDisplay;
        TwwDBGrid(Sender).RedrawGrid;
        Exit;
      end;
    end;
  except
    // Report Exception!
    on e: Exception do begin
      CommonLib.MessageDlgXP_Vista('ColumnMoved Event for Grid: ' + TwwDBGrid(Sender).Name + ' has failed!' + #13 + #10 + #13 + #10 +
        E.Message, mtWarning, [mbOK], 0);
      Exit;
    end;
  end;
end;

procedure TCustomizeListObj.SetUseColumnWidth(const Value: boolean);
begin
  FUseColumnWidth := Value;
end;

end.
