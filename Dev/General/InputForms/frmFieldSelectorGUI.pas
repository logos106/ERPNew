unit frmFieldSelectorGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, DNMPanel, DBAccess, MyAccess,ERPdbComponents, Wwdbigrd, Grids,
  SelectionDialog, AppEvnts, DB,  StdCtrls, Buttons, DNMSpeedButton, CheckLst, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, DataState, Menus, AdvMenus, MemDS, Shader;

type
  TfrmFieldSelector = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    lstFields: TCheckListBox;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    DNMPanel2: TDNMPanel;
    btnSelectAll: TDNMSpeedButton;
    qryNone: TERPQuery;
    btnUnselect: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnUnselectClick(Sender: TObject);
    procedure lstFieldsClickCheck(Sender: TObject);

  private
    { Private declarations }
    grdUseGrid: TwwDBGrid;
    dsDataset: TDataset;
    strOwner, strComponentName: string;
    slExclusion: TStringList;
    slRequired: TStringList;

  public
    { Public declarations }
    
    procedure GetPreviousSettings(const sControlName, sOwner: string);
    procedure SaveFieldSettings(const sControlName, sOwner: string);
    property UseGrid: TwwDBGrid read grdUseGrid write grdUseGrid default nil;
    property UseDataset: TDataset read dsDataset write dsDataset default nil;
    property ControlName: string read strComponentName write strComponentName;
    property ControlOwner: string read strOwner write strOwner;
    property ExclusionList: TStringList read slExclusion write slExclusion;
    property RequiredList: TStringList read slRequired write slRequired;
  end;


implementation

{$R *.dfm}

uses
  CommonDbLib,  DNMExceptions, FastFuncs,
  AppEnvironment, CommonLib;

const
  PATTERN_MASK = ' (X)';  

procedure TfrmFieldSelector.btnCancelClick(Sender: TObject);
begin
  inherited;
  Self.ModalResult := mrCancel;
end;

procedure TfrmFieldSelector.FormShow(Sender: TObject);
var
  iX: integer;

  function InExclusionList(const sFieldName: string): boolean;
  var
    iY: integer;
  begin
    Result := false;
    if not Assigned(slExclusion) then Exit;
    if slExclusion.Count = 0 then Exit;
    for iY := 0 to slExclusion.Count - 1 do begin
      if Sysutils.SameText(slExclusion.Strings[iY], sFieldName) then begin
        Result := true;
        Exit;
      end;
    end;
  end;
  
  function InRequiredList(const sFieldName: string): boolean;
  var
    iY: integer;
  begin
    Result := false;
    if not Assigned(slRequired) then Exit;
    if slRequired.Count = 0 then Exit;
    for iY := 0 to slRequired.Count - 1 do begin
      if Sysutils.SameText(slRequired.Strings[iY], sFieldName) then begin
        Result := true;
        Exit;
      end;
    end;
  end;
begin
  DisableForm;
  try
    try
      inherited;

      OpenQueries;

      lstFields.Items.Clear;

      // Add all fields to our list.
      lstFields.Sorted := false;
      if Assigned(UseDataset) then begin
        for iX := 1 to dsDataset.FieldCount do begin
          if not InExclusionList(dsDataSet.Fields[iX - 1].FieldName) then begin
            if InRequiredList(dsDataSet.Fields[iX - 1].FieldName) then begin
              lstFields.Items.Add(dsDataSet.Fields[iX - 1].FieldName + PATTERN_MASK);
            end else begin
              lstFields.Items.Add(dsDataSet.Fields[iX - 1].FieldName);
            end;
          end;
        end;
      end else if Assigned(UseGrid) then begin
        for iX := 1 to grdUseGrid.DataSource.DataSet.FieldCount do begin
          if not InExclusionList(grdUseGrid.DataSource.DataSet.Fields[iX - 1].FieldName) then begin
            if InRequiredList(grdUseGrid.DataSource.DataSet.Fields[iX - 1].FieldName) then begin
              lstFields.Items.Add(grdUseGrid.DataSource.DataSet.Fields[iX - 1].FieldName + PATTERN_MASK);
            end else begin
              lstFields.Items.Add(grdUseGrid.DataSource.DataSet.Fields[iX - 1].FieldName);
            end;
          end;
        end;
      end;

      //    lstFields.Sorted := True;
      GetPreviousSettings(ControlName, ControlOwner);

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
end;

procedure TfrmFieldSelector.SaveFieldSettings(const sControlName, sOwner: string);
var
  qry: TERPQuery;
  sData: string;
  iY: integer;
  slDataInfo: TStringList;
  sTitle, sFieldName: string;
  
  function LocateFieldSize(const sFieldname: string): integer;
  var
    iX: integer;
  begin
    Result := 0;
    // Are we using a dataset control?
    if Assigned(dsDataset) then begin
      // Yes, locate field name and get info.
      for iX := 0 to dsDataset.FieldCount - 1 do begin
        if sFieldname = dsDataset.Fields[iX].FieldName then begin
          Result := dsDataset.Fields[iX].DisplayWidth;
          Exit;
        end;
      end;

      // Are we using a grid?
    end else if Assigned(grdUseGrid) then begin
      for iX := 0 to grdUseGrid.DataSource.DataSet.FieldCount - 1 do begin
        if sFieldname = grdUseGrid.DataSource.DataSet.Fields[iX].FieldName then begin
          Result := grdUseGrid.DataSource.DataSet.Fields[iX].DisplayWidth;
          Exit;
        end;
      end;
    end;
  end;

  function LocateFieldIndex(const sFieldname: string): integer;
  var
    iX: integer;
  begin
    // Are we using a dataset control?
    Result := 0;
    if Assigned(dsDataset) then begin
      // Yes, locate field name and get info.
      for iX := 0 to dsDataset.FieldCount - 1 do begin
        if sFieldname = dsDataset.Fields[iX].FieldName then begin
          Result := iX;
          Exit;
        end;
      end;

      // Are we using a grid?
    end else if Assigned(grdUseGrid) then begin
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
    if Assigned(dsDataset) then begin
      // Yes, locate field name and get info.
      for iX := 0 to dsDataset.FieldCount - 1 do begin
        if sFieldname = dsDataset.Fields[iX].FieldName then begin
          Result := dsDataset.Fields[iX].DisplayLabel;
          Exit;
        end;
      end;

      // Are we using a grid?
    end else if Assigned(grdUseGrid) then begin
      for iX := 0 to grdUseGrid.FieldCount - 1 do begin
        if sFieldname = grdUseGrid.Fields[iX].FieldName then begin
          Result := grdUseGrid.Fields[iX].DisplayLabel;
          Exit;
        end;
      end;

      if Result = '' then begin
        for iX := 0 to grdUseGrid.Datasource.DataSet.FieldCount - 1 do begin
          if sFieldname = grdUseGrid.Datasource.DataSet.Fields[iX].FieldName then begin
            Result := grdUseGrid.Datasource.DataSet.Fields[iX].DisplayLabel;
            Exit;
          end;
        end;
      end;
    end;
  end;

  function LocateFieldReadStatus(const sFieldname: string): boolean;
  var
    iX: integer;
  begin
    // Are we using a dataset control?
    Result := true;
    if Assigned(dsDataset) then begin
      // Yes, locate field name and get info.
      for iX := 0 to dsDataset.FieldCount - 1 do begin
        if sFieldname = dsDataset.Fields[iX].FieldName then begin
          Result := dsDataset.Fields[iX].ReadOnly;
          Exit;
        end;
      end;

      // Are we using a grid?
    end else if Assigned(grdUseGrid) then begin
      for iX := 0 to grdUseGrid.FieldCount - 1 do begin
        if sFieldname = grdUseGrid.Fields[iX].FieldName then begin
          Result := grdUseGrid.Fields[iX].ReadOnly;
          Exit;
        end;
      end;

      // Check the grids datasource
      for iX := 0 to grdUseGrid.DataSource.DataSet.FieldCount - 1 do begin
        if sFieldname = grdUseGrid.DataSource.DataSet.Fields[iX].FieldName then begin
          Result := grdUseGrid.DataSource.DataSet.Fields[iX].ReadOnly;
          Exit;
        end;
      end;
    end;
  end;
begin
  qry := TERPQuery.Create(nil);
  slDataInfo := TStringList.Create;
  try
    // First generate the required field info data that we must Save.
    for iY := 0 to lstFields.Count - 1 do begin
      sFieldName := StringReplace(lstFields.Items.Strings[iY], PATTERN_MASK, '', [rfReplaceAll, rfIgnoreCase]);
      sData := sFieldName + '^';
      if lstFields.Checked[iY] then begin
        sData := sData + 'T^';
      end else begin
        sData := sData + 'F^';
      end;

      sData := sData + IntToStr(LocateFieldSize(sFieldName)) + '^';
      if not LocateFieldReadStatus(sFieldName) then begin
        sData := sData + 'F';
      end else begin
        sData := sData + 'T';
      end;

      sData := sData + '^' + IntToStr(LocateFieldIndex(sFieldName));
      sTitle := LocateFieldTitle(sFieldName);
      if sTitle = '' then sTitle := '-';
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
      FreeandNil(slDataInfo);
  end;
end;


procedure TfrmFieldSelector.GetPreviousSettings(const sControlName, sOwner: string);
var
  qry: TERPQuery;
  slFieldInfo, slDataInfo: TStringList;
  iX, iPos: integer;

  function LocateStringInList(const sSearchText: string): integer;
  var
    iY: integer;
    Buffer: array[0..255] of char;
    sThisString: string;
  begin
    sThisString := string(Buffer);
    for iY := 0 to lstFields.Count - 1 do begin
      StrPCopy(Buffer, lstFields.Items.Strings[iY]);
      sThisString := string(Buffer);
      sThisString := StringReplace(sThisString, PATTERN_MASK, '', [rfReplaceAll, rfIgnoreCase]);
      if sThisString = sSearchText then begin
        Result := iY;
        Exit;
      end;
    end;

    Result := -1;
  end;
begin
  ////////////////////////////////////////////////////////////////////////////////////////
  // Field Information is stored and read as accordingly.
  //
  ////////////////////////////////////////////////////////////////////////////////////////
  // FieldName ^ Show Field Status ^ Display Column Width ^ Read Status ^ Column Position
  ////////////////////////////////////////////////////////////////////////////////////////
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
    qry.Params.ParamByName('xCName').AsString := sControlName;
    qry.Open;

    // Do we have a preference setting under the logged in user and criteria?
    if qry.RecordCount > 0 then begin
      // First we will need to build a field list.
      slDataInfo.Clear;
      ExtractStrings(['|'], [' '], PChar(qry.FieldByName('FieldList').AsString), slDataInfo);
      for iX := 1 to slDataInfo.Count do begin
        slFieldInfo.Clear;
        ExtractStrings(['^'], [' '], PChar(slDataInfo.Strings[iX - 1]), slFieldInfo);
        iPos := LocateStringInList(slFieldInfo.Strings[0]);
        // Did we find the field name?
        if iPos > -1 then begin
          // Is it enabled or not?
          if slFieldInfo.Strings[1] = 'T' then begin
            // Enabled
            lstFields.Checked[iPos] := true;
          end else begin
            // Not Enabled.
            lstFields.Checked[iPos] := false;
          end;
        end;
      end; // End of For iX
    end else begin
      // If we get to this point then it means there
      // was no previous settings, so check all entries.
      if Assigned(UseGrid) then begin
        // First we will need to build a field list.
        slDataInfo.Clear;
        for iX := 0 to UseGrid.GetColCount - 1 do begin
          slDataInfo.Add(UseGrid.Columns[iX].FieldName);
        end;

        // Now determine which needs to be checked and unchecked
        // within the display field list.
        for iX := 0 to slDataInfo.Count - 1 do begin
          iPos := LocateStringInList(slDataInfo.Strings[iX]);
          // Did we find the field name?
          if iPos > -1 then begin
            lstFields.Checked[iPos] := true;
          end;
        end; // End of For iX
      end else begin
        for iX := 0 to lstFields.Count - 1 do begin
          lstFields.Checked[iX] := true;
        end;
      end;
    end;

  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);
    if Assigned(slDataInfo) then FreeandNil(slDataInfo);
    if Assigned(slFieldInfo) then FreeandNil(slFieldInfo);
  end;
end;

procedure TfrmFieldSelector.btnOKClick(Sender: TObject);
begin
  inherited;
  SaveFieldSettings(ControlName, ControlOwner);
  ModalResult := mrOk;
end;

procedure TfrmFieldSelector.btnSelectAllClick(Sender: TObject);
var
  iX: integer;
begin
  inherited;
  for iX := 0 to lstFields.Count - 1 do begin
    lstFields.Checked[iX] := true;
  end;
end;

procedure TfrmFieldSelector.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmFieldSelector.btnUnselectClick(Sender: TObject);
var
  iX: integer;

  function IsColumnRequired(const sFieldname: string): boolean;
  var
    iX: integer;
    Buffer: array[0..255] of char;
    Buffer2: array[0..255] of char;
    sThisString: string;
  begin
    // Is our required list valid? If not, then exit.
    Result := false;
    if not Assigned(RequiredList) then Exit;
    StrPCopy(Buffer, sFieldname);
    StrLower(Buffer);
    sThisString := string(Buffer);
    sThisString := StringReplace(sThisString, PATTERN_MASK, '', [rfReplaceAll, rfIgnoreCase]);

    // Check through our required list.
    for iX := 0 to RequiredList.Count - 1 do begin
      StrPCopy(Buffer2, slRequired.Strings[iX]);
      StrLower(Buffer2);
      if sThisString = string(Buffer2) then begin
        Result := true;
        Exit;
      end;
    end;
  end;  
begin
  inherited;
  for iX := 0 to lstFields.Count - 1 do begin
    if not (IsColumnRequired(lstFields.Items.Strings[iX])) then lstFields.Checked[iX] := false;
  end;
end;

procedure TfrmFieldSelector.lstFieldsClickCheck(Sender: TObject);

  function IsColumnRequired(const sFieldname: string): boolean;
  var
    iX: integer;
    Buffer: array[0..255] of char;
    Buffer2: array[0..255] of char;
    sThisString: string;
  begin
    // Is our required list valid? If not, then exit.
    Result := false;
    if not Assigned(RequiredList) then Exit;
    StrPCopy(Buffer, sFieldname);
    StrLower(Buffer);
    sThisString := string(Buffer);
    sThisString := StringReplace(sThisString, PATTERN_MASK, '', [rfReplaceAll, rfIgnoreCase]);

    // Check through our required list.
    for iX := 0 to RequiredList.Count - 1 do begin
      StrPCopy(Buffer2, slRequired.Strings[iX]);
      StrLower(Buffer2);
      if sThisString = string(Buffer2) then begin
        Result := true;
        Exit;
      end;
    end;
  end;  
begin
  inherited;
  if (IsColumnRequired(lstFields.Items.Strings[lstFields.ItemIndex])) and
    (not lstFields.Checked[lstFields.ItemIndex]) then begin
    lstFields.Checked[lstFields.ItemIndex] := true;
  end;
end;

initialization
  RegisterClassOnce(TfrmFieldSelector);

end.
