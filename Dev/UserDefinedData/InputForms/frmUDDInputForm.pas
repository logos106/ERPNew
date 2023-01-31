unit frmUDDInputForm;

{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 16/11/05 1.00.00  MV   Initial verson.
 01/12/05 1.00.01  MV   Redesigned to support new daBase Class Objects
 01/12/05 1.00.02  MV   Added support for new header
 02/12/05 1.00.03  MV   Modified to support Date and Description of daBase and
                        added checkbox automation.
 05/12/05 1.00.04  MV   Add support for data type of list.
 06/12/05 1.00.05  MV   Modified to support CategoryName Field required
                        datScopingAddin.
 06/12/05 1.00.06  MV   Add Scope Report Printing functionality.
 08/12/05 1.00.07  MV   Added record selection Report Printing functionality and
                        Added ComboList update for xml property list.
 15/12/05 1.00.08  MV   Fixed Access Violation if defintions are not defined.  
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DataState, DBAccess, MyAccess, SelectionDialog,
  AppEvnts, DB,  StdCtrls, Mask, DBCtrls, wwcheckbox, Buttons, DNMSpeedButton,
  ExtCtrls, DNMPanel, ActnList, MemDS, wwdbdatetimepicker, wwdblook,
  wwdbedit, Grids, Wwdbigrd, Wwdbgrid, BaseGrid, AdvGrid, ComCtrls, daBase,
  Menus, AdvMenus, Shader;

type
  TUDDInputForm = class(TBaseInputGUI)
    pnlBottom: TDNMPanel;
    Label50: TLabel;
    btnSave: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    pnlTop: TDNMPanel;
    alMain: TActionList;
    actMainSave: TAction;
    actMainNew: TAction;
    actMainCancel: TAction;
    DetailsGrid: TAdvStringGrid;
    qryEmployeeID: TMyQuery;
    btnPrint: TDNMSpeedButton;
    qryScopeDefinitions: TMyQuery;
    qryScopeDefinitionsDAID: TIntegerField;
    qryScopeDefinitionsTypename: TStringField;
    qryScopeDefinitionsDescription: TStringField;
    DNMPanel1: TDNMPanel;
    lblDate: TLabel;
    DateTimePicker: TDateTimePicker;
    Label2: TLabel;
    EmployeeLookup: TwwDBLookupCombo;
    Label4: TLabel;
    cboDefinition: TwwDBLookupCombo;
    Label1: TLabel;
    edtDescription: TEdit;
    Label3: TLabel;
    chkSelectAll: TCheckBox;
    btnImport: TDNMSpeedButton;
    btnExport: TDNMSpeedButton;
    actMainImport: TAction;
    actMainExport: TAction;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure actMainSaveExecute(Sender: TObject);
    procedure actMainNewExecute(Sender: TObject);
    procedure actMainCancelExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure DateTimePickerChange(Sender: TObject);
    procedure EmployeeLookupChange(Sender: TObject);
    procedure edtDescriptionChange(Sender: TObject);
    procedure DetailsGridAutoAddRow(Sender: TObject; ARow: integer);
    procedure DetailsGridCellValidate(Sender: TObject; ACol, ARow: integer; var Value: string; var Valid: boolean);
    procedure DetailsGridGetEditorType(Sender: TObject; ACol, ARow: integer; var AEditor: TEditorType);
    procedure DetailsGridHasComboBox(Sender: TObject; ACol, ARow: integer; var HasComboBox: boolean);
    procedure DetailsGridRowUpdate(Sender: TObject; OldRow, NewRow: integer);
    procedure chkActiveClick(Sender: TObject);
    procedure DetailsGridCheckBoxClick(Sender: TObject; ACol, ARow: integer; State: boolean);
    procedure btnPrintClick(Sender: TObject);
    procedure chkSelectAllClick(Sender: TObject);
    procedure DetailsGridEnter(Sender: TObject);
    procedure cboDefinitionCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure qryEmployeeIDAfterOpen(DataSet: TDataSet);
    procedure DetailsGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actMainImportExecute(Sender: TObject);
    procedure actMainExportExecute(Sender: TObject);
  private
    HDData: TdaMDCustBase;
    FCategoryName: string;
    fsTempTableName :String;
    procedure DoOpenData;
    procedure InitialiseGrid;
    procedure FillNoColumn;
    function GetHeaderNameIndex(const HeaderName: string): integer;
    function ValidateFormData: boolean;
    function SaveData: boolean;
    function GetCategoryName: string;
    procedure SetCategoryName(const Value: string);
    procedure CreateTableOfUDDData(const HDDataPtr: TdaMDCustBase);
    function GetSCVExportStringList : TStringList;
    procedure ImportSCVStringList(const SL:TStringList);
  Protected
    (*Procedure LoadHelpNotes; Override;*)
  public
    procedure UpdateMe; override;
    property CategoryName: string read GetCategoryName write SetCategoryName;
  end;


implementation

{$R *.dfm}

uses
  DNMExceptions,
     
  CommonDbLib,  DateUtils, CommonLib, AppEnvironment, FastFuncs;

const
  DT_STRING  = 0;
  DT_INTEGER = 1;
  DT_DOUBLE  = 2;
  DT_BOOLEAN = 3;
  DT_DATE    = 4;
  DT_LIST    = 5;
    

(*Procedure TUDDInputForm.LoadHelpNotes;
begin

end;*)
procedure TUDDInputForm.FormCreate(Sender: TObject);
begin
  inherited;

  if ErrorOccurred then Exit;
  CategoryName := '';
end;

procedure TUDDInputForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  RollbackTransaction;
  FreeandNil(HDData);
  DestroyUserTemporaryTable(fsTempTableName);
  Action := caFree;
end;

procedure TUDDInputForm.FormShow(Sender: TObject);
begin
  try
    inherited;
    if ErrorOccurred then Exit;
    DateTimePicker.Date := dateOf(now);
    cboDefinition.enabled := True;
    DetailsGrid.RowCount := 1;
    DetailsGrid.ColCount := 1;
    if qryEmployeeID.Active = False then qryEmployeeID.Open;
    HDData          := TdaMDCustBase.Create(Self);
    HDData.connection := Self.MyConnection;
    HDData.TypeName := CategoryName;

    if (CategoryName <> '') or (KeyId <> 0) then
        DoOpenData
    else begin
        if qryScopeDefinitions.Active = False then qryScopeDefinitions.Open;
        SetControlFocus(cboDefinition);
    end;

  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do HandleNoAccessException(e);
  end;
end;

procedure TUDDInputForm.DoOpenData;
begin
  RollbackTransaction;

  if qryEmployeeID.Active = False then qryEmployeeID.Open;

  HDData.ID := KeyID;
  if KeyID > 0 then begin
    HDData.Load;
  end else begin
    HDData.New;
    DateTimePicker.Date := DateOf(now);
    chkActive.checked := true;
    HDData.Active :=True;
    // calling the event explicitly as the component has the system date as the default value.
    // Moving the same value will not fire the onchange event.
    DateTimePickerChange(DateTimePicker);
    SetControlFocus(cboDefinition);
  end;
  BeginTransaction;

  if qryScopeDefinitions.Active = False then qryScopeDefinitions.Open;
  if HDData.ID > 0 then begin
    DateTimePicker.DateTime := HDData.Master.ByName['Date'].AsDateTime;
    qryEmployeeID.Locate('EmployeeID', HDData.Master.ByName['EmployeeID'].AsInteger, [loCaseInsensitive]);
    EmployeeLookup.Text := qryEmployeeID.FieldByName('EmployeeName').AsString;
    edtDescription.Text := HDData.Description;
    chkActive.Checked   := HDData.Active;
    if qryScopeDefinitions.Locate('DAID' , HDData.parentId,[loCaseInsensitive]) then begin
        cboDefinition.Text :=qryScopeDefinitionsTypename.asString ;
        cboDefinition.Enabled := False;
        btnImport.Enabled := true;
    end;
  end else begin
    if HDData.MDCustPropDefs.MasterDefs.Count > 0 then begin
      DateTimePicker.DateTime := Dateof(Now);
      // calling the event explicitly as the component has the system date as the default value.
      // Moving the same value will not fire the onchange event.
      DateTimePickerChange(DateTimePicker);
      HDData.Master.ByName['Date'].AsDateTime := Date;
      if qryScopeDefinitions.Locate('DAID' , HDData.parentId,[loCaseInsensitive]) then begin
        cboDefinition.Text :=qryScopeDefinitionsTypeName.asString;
        edtDescription.Text :=qryScopeDefinitionsDescription.asString;
      end;
    end else begin

    end
  end;

  if EmployeeLookup.Text = '' then DetailsGrid.Enabled := false;

  InitialiseGrid;

  HDData.Dirty := false;
end;

procedure TUDDInputForm.actMainSaveExecute(Sender: TObject);
begin
  inherited;
  HDData.Save;
  if HDData.MDCustPropDefs.Dirty then HDData.MDCustPropDefs.Save;
  if not SaveData then Exit;
  CommitTransaction;
  Notify;
  HDData.Dirty := false;
  Close;
end;

procedure TUDDInputForm.actMainNewExecute(Sender: TObject);
begin
  inherited;
  if HDData.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes: 
        begin
          if not SaveData then Exit
          else begin
            CommitTransaction;
            Notify;
          end;
        end;
      mrNo: 
        begin
          RollbackTransaction;
        end;
      mrCancel: 
        begin
          Exit;
        end;
    end;
  end;


  KeyID := 0;
  CategoryName := '';
  Self.FormShow(Self);
end;

procedure TUDDInputForm.actMainCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TUDDInputForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
  if ErrorOccurred then Exit;

  CanClose := false;
  if HDData.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes: 
        begin
          if SaveData then begin
            CommitTransaction;
            Notify;
            CanClose := true;
          end;
        end;
      mrNo: 
        begin
          RollbackTransaction;
          CanClose := true;
        end;
      mrCancel: 
        begin
          CanClose := false;
        end;
    end;
  end else begin
    CanClose := true;
  end;
end;

function TUDDInputForm.ValidateFormData: boolean;
begin
  Result := true;
end;

function TUDDInputForm.SaveData: boolean;
begin
  Result := false;
  if ValidateFormData then begin
    Result := true;
  end;
end;

procedure TUDDInputForm.UpdateMe;
begin
  // Close/re-open queryies to refresh data
end;

function TUDDInputForm.GetHeaderNameIndex(const HeaderName: string): integer;
var
  Found: boolean;
  ColCount: integer;
begin
  Result := 0;
  Found := false;
  ColCount := 0;
  while (not Found) and (ColCount < DetailsGrid.ColCount) do begin
    if DetailsGrid.Cells[ColCount, 0] = HeaderName then begin
      Result := ColCount;
      Found := true;
    end;
    Inc(ColCount);
  end;
end;

procedure TUDDInputForm.InitialiseGrid;
var
  LoopItems, LoopColumn: integer;
  ColumnHeader, PropertyName: string;
begin

  DetailsGrid.RowCount := 1;
  DetailsGrid.ColWidths[0] := 45;

  if HDData.MDCustPropDefs.DetailDefs.Count > 0 then begin
    for LoopItems := 0 to HDData.MDCustPropDefs.DetailDefs.Count - 1 do begin
      if HDData.MDCustPropDefs.DetailDefs.Item[LoopItems].IsActive then begin
        DetailsGrid.AddColumn;
        DetailsGrid.Cells[DetailsGrid.ColCount - 1, 0] := HDData.MDCustPropDefs.DetailDefs.Item[LoopItems].Caption;
      end;
    end;
    DetailsGrid.AddColumn;
    DetailsGrid.Cells[DetailsGrid.ColCount - 1, 0] := 'Selected';
  end;

  if DetailsGrid.ColCount > 1 then 
    DetailsGrid.FixedCols := 1;

  if HDData.Detail.Count > 0 then begin
    for LoopItems := 0 to HDData.Detail.Count - 1 do begin
      DetailsGrid.AddRow;
      DetailsGrid.FixedRows := 1;
      DetailsGrid.AllObjects[GetHeaderNameIndex('No'), LoopItems + 1] := HDData.Detail.Item[LoopItems];
      DetailsGrid.Cells[GetHeaderNameIndex('No'), LoopItems + 1] := FastFuncs.IntToStr(LoopItems + 1);

      // Populate row with data column
      for LoopColumn := 0 to HDData.MDCustPropDefs.DetailDefs.Count - 1 do begin
        if HDData.MDCustPropDefs.DetailDefs.Item[LoopColumn].IsActive then begin
          ColumnHeader := HDData.MDCustPropDefs.DetailDefs.Item[LoopColumn].Caption;
          PropertyName := HDData.MDCustPropDefs.DetailDefs.Item[LoopColumn].PropName;
          if HDData.MDCustPropDefs.DetailDefs.Item[LoopColumn].DataType = TdaCustPropDataType(cdtBoolen) then begin
            DetailsGrid.AddCheckBox(GetHeaderNameIndex(ColumnHeader), LoopItems + 1, false, false);
            DetailsGrid.SetCheckBoxState(GetHeaderNameIndex(ColumnHeader), LoopItems + 1,
              TdaCustPropList(DetailsGrid.AllObjects[GetHeaderNameIndex('No'), LoopItems + 1]).ByName[PropertyName].AsBoolean);
          end else begin
            DetailsGrid.Cells[GetHeaderNameIndex(ColumnHeader), LoopItems + 1] :=
              TdaCustPropList(DetailsGrid.AllObjects[GetHeaderNameIndex('No'), LoopItems + 1]).ByName[PropertyName].Value;
          end;
        end;
      end;
      DetailsGrid.AddCheckBox(GetHeaderNameIndex('Selected'), LoopItems + 1, false, false);
    end;
  end else begin
    DetailsGrid.AddRow;
    DetailsGrid.FixedRows := 1;
    HDData.Detail.Add;
    DetailsGrid.AllObjects[GetHeaderNameIndex('No'), 1] := HDData.Detail.Item[0];

    // Is checkbox required
    for LoopColumn := 0 to HDData.MDCustPropDefs.DetailDefs.Count - 1 do begin
      if HDData.MDCustPropDefs.DetailDefs.Item[LoopColumn].IsActive then begin
        ColumnHeader := HDData.MDCustPropDefs.DetailDefs.Item[LoopColumn].Caption;
        PropertyName := HDData.MDCustPropDefs.DetailDefs.Item[LoopColumn].PropName;
        if HDData.MDCustPropDefs.DetailDefs.Item[LoopColumn].DataType = TdaCustPropDataType(cdtBoolen) then DetailsGrid.AddCheckBox(GetHeaderNameIndex(ColumnHeader), 1, true, false);
      end;
    end;
    // Add checkbox for the selected column
    DetailsGrid.AddCheckBox(GetHeaderNameIndex('Selected'), 1, true, false)
  end;
end;

procedure TUDDInputForm.DateTimePickerChange(Sender: TObject);
begin
  inherited;
  if not assigned(HdData) then Exit;
  if HDData.Master.Count > 0 then begin
    HDData.Master.Item[0].AsDateTime := DateTimePicker.Date;
  end;  
  HDData.Date := DateTimePicker.Date;
end;

procedure TUDDInputForm.EmployeeLookupChange(Sender: TObject);
begin
  inherited;
  //qryEmployeeID.Locate('EmployeeName', EmployeeLookup.Text, [loCaseInsensitive]);
  if Assigned(HDData) then
    if cboDefinition.TEXt <> '' then begin
        if HDData.Master.Count > 1 then begin
          HDData.Master.Item[1].AsInteger := qryEmployeeID.FieldByName('EmployeeID').AsInteger;
        end;  
        DetailsGrid.Enabled := true;
    end;
end;

procedure TUDDInputForm.edtDescriptionChange(Sender: TObject);
begin
  inherited;
  if not assigned(HdData) then Exit;
  if HDData.Master.Count > 1 then begin
    HDData.Master.Item[3].Value := edtDescription.Text;
  end;  
  HDData.Description := edtDescription.Text;
end;

procedure TUDDInputForm.DetailsGridAutoAddRow(Sender: TObject; ARow: integer);
var
  LoopColumn: integer;
  ColumnHeader, PropertyName: string;
begin
  inherited;
  // Add new detail record
  HDData.Detail.Add;
  DetailsGrid.AllObjects[GetHeaderNameIndex('No'), ARow + 1] := HDData.Detail.Item[ARow];

  // Is checkbox required
  for LoopColumn := 0 to HDData.MDCustPropDefs.DetailDefs.Count - 1 do begin
    if HDData.MDCustPropDefs.DetailDefs.Item[LoopColumn].IsActive then begin
      ColumnHeader := HDData.MDCustPropDefs.DetailDefs.Item[LoopColumn].Caption;
      PropertyName := HDData.MDCustPropDefs.DetailDefs.Item[LoopColumn].PropName;
      if HDData.MDCustPropDefs.DetailDefs.Item[LoopColumn].DataType = TdaCustPropDataType(cdtBoolen) then DetailsGrid.AddCheckBox(GetHeaderNameIndex(ColumnHeader), ARow + 1, false, false);
    end;
  end;
  DetailsGrid.AddCheckBox(GetHeaderNameIndex('Selected'), ARow + 1, false, false);
  FillNoColumn;
end;

procedure TUDDInputForm.DetailsGridCellValidate(Sender: TObject; ACol, ARow: integer; var Value: string; var Valid: boolean);
var
  LoopItems: integer;
  ColumnHeader, PropertyName: string;
  DType: integer;
  Found: boolean;
  tmpList: TStringList;
  LoopList, ItemRef: integer;
begin
  //if Value = '' then Exit;
  inherited;
  ItemRef := 0;
  DType := 0;
  tmpList := TStringList.Create;
  Try
    // Aquire object details
    ColumnHeader := DetailsGrid.Cells[ACol, 0];
    for LoopItems := 0 to HDData.MDCustPropDefs.DetailDefs.Count - 1 do begin
      if HDData.MDCustPropDefs.DetailDefs.Item[LoopItems].Caption = ColumnHeader then begin
        PropertyName := HDData.MDCustPropDefs.DetailDefs.Item[LoopItems].PropName;
        DType := Ord(HDData.MDCustPropDefs.DetailDefs.Item[LoopItems].DataType);
        tmpList.CommaText := HDData.MDCustPropDefs.DetailDefs.Item[LoopItems].Params.ListValues;
        ItemRef := LoopItems;
      end;
    end;

    if not (Value = '') then begin

      // Validate data before committing value
      case DType of

        DT_INTEGER:
          begin
            try
              FastFuncs.StrToInt(Value);
            except
              Value := '0';
              CommonLib.MessageDlgXP_Vista('Invalid DataType - Integer expected', mtWarning , [mbOK], 0);
              Exit;
            end;
          end;

        DT_DOUBLE:
          begin
            try
              StrToFloat(Value);
            except
              Value := '0.0';
              CommonLib.MessageDlgXP_Vista('Invalid DataType - Decimal expected', mtWarning , [mbOK], 0);
              Exit;
            end;
          end;

        DT_DATE:
          begin
            try
              StrToDateTime(Value);
            except
              Value := '01/01/1990';
              CommonLib.MessageDlgXP_Vista('Invalid DataType - Date expected', mtWarning , [mbOK], 0);
              Exit;
            end;
          end;

        DT_LIST:
          begin
            tmpList.CaseSensitive := false;
            Found := false;
            LoopList := 0;
            while (not Found) and (LoopList < tmpList.Count - 1) do begin
              if FastFuncs.SameText(tmpList.Strings[LoopList], Value) then Found := true;
              Inc(LoopList);
            end;
            if not Found then begin
              if HDData.MDCustPropDefs.DetailDefs.Item[ItemRef].Params.UserCanEditList then begin
                tmpList.Add(Value);
                HDData.MDCustPropDefs.DetailDefs.Item[ItemRef].Params.ListValues := tmpList.CommaText;
                HDData.MDCustPropDefs.Save;
              end;
            end;
          end;
      end;
    end; // if value <> ''  

    // Update the object value

  Finally
    TdaCustPropList(DetailsGrid.AllObjects[GetHeaderNameIndex('No'), ARow]).ByName[PropertyName].Value := Value;
    FreeandNil(tmpList);
  end;
end;

procedure TUDDInputForm.DetailsGridGetEditorType(Sender: TObject; ACol, ARow: integer; var AEditor: TEditorType);
var
  ColumnHeader: string;
  LoopItems: integer;
begin
  inherited;

  // Aquire object details
  ColumnHeader := DetailsGrid.Cells[ACol, 0];
  for LoopItems := 0 to HDData.MDCustPropDefs.DetailDefs.Count - 1 do begin
    if (HDData.MDCustPropDefs.DetailDefs.Item[LoopItems].Caption = ColumnHeader) and
      (HDData.MDCustPropDefs.DetailDefs.Item[LoopItems].DataType = TdaCustPropDataType(cdtDateTime)) then begin
      AEditor := edDateEdit;
    end else if (HDData.MDCustPropDefs.DetailDefs.Item[LoopItems].Caption = ColumnHeader) and
      (HDData.MDCustPropDefs.DetailDefs.Item[LoopItems].DataType = TdaCustPropDataType(cdtList)) then begin
      if HDData.MDCustPropDefs.DetailDefs.Item[LoopItems].Params.UserCanEditList then AEditor := edComboEdit
      else AEditor := edComboList;
      DetailsGrid.Combobox.Items.CommaText := HDData.MDCustPropDefs.DetailDefs.Item[LoopItems].Params.ListValues;
    end;
  end;
end;

procedure TUDDInputForm.DetailsGridHasComboBox(Sender: TObject; ACol, ARow: integer; var HasComboBox: boolean);
var
  ColumnHeader: string;
  LoopItems: integer;
begin
  inherited;

  // Aquire object details
  ColumnHeader := DetailsGrid.Cells[ACol, 0];
  for LoopItems := 0 to HDData.MDCustPropDefs.DetailDefs.Count - 1 do begin
    if (HDData.MDCustPropDefs.DetailDefs.Item[LoopItems].Caption = ColumnHeader) and
      (HDData.MDCustPropDefs.DetailDefs.Item[LoopItems].DataType = TdaCustPropDataType(cdtList)) then begin
      HasComboBox := true;
    end;
  end;
end;

procedure TUDDInputForm.DetailsGridRowUpdate(Sender: TObject; OldRow, NewRow: integer);
var
  LoopColumn: integer;
  ColumnHeader, PropertyName: string;
begin
  inherited;

  // Aquire object details
  for LoopColumn := 0 to HDData.MDCustPropDefs.DetailDefs.Count - 1 do begin
    ColumnHeader := HDData.MDCustPropDefs.DetailDefs.Item[LoopColumn].Caption;
    PropertyName := HDData.MDCustPropDefs.DetailDefs.Item[LoopColumn].PropName;

    // Update the object value
    if HDData.MDCustPropDefs.DetailDefs.Item[LoopColumn].IsActive then begin
      if HDData.MDCustPropDefs.DetailDefs.Item[LoopColumn].DataType = TdaCustPropDataType(cdtBoolen) then begin
        DetailsGrid.SetCheckBoxState(GetHeaderNameIndex(ColumnHeader), NewRow,
          TdaCustPropList(DetailsGrid.AllObjects[GetHeaderNameIndex('No'), NewRow]).ByName[PropertyName].AsBoolean);
      end else begin
        DetailsGrid.Cells[GetHeaderNameIndex(ColumnHeader), NewRow] :=
          TdaCustPropList(DetailsGrid.AllObjects[GetHeaderNameIndex('No'), NewRow]).ByName[PropertyName].Value;
      end;
    end;
  end;
end;

procedure TUDDInputForm.chkActiveClick(Sender: TObject);
begin
  inherited;
  HDData.Active := chkActive.Checked;
end;

procedure TUDDInputForm.DetailsGridCheckBoxClick(Sender: TObject; ACol, ARow: integer; State: boolean);
var
  LoopItems: integer;
  ColumnHeader, PropertyName: string;
begin
  inherited;

  ColumnHeader := DetailsGrid.Cells[ACol, 0];
  if ColumnHeader = 'Selected' then begin
    HDData.Detail.Item[ARow - 1].Selected := State;
  end else begin
    for LoopItems := 0 to HDData.MDCustPropDefs.DetailDefs.Count - 1 do begin
      if HDData.MDCustPropDefs.DetailDefs.Item[LoopItems].Caption = ColumnHeader then begin
        PropertyName := HDData.MDCustPropDefs.DetailDefs.Item[LoopItems].PropName;
      end;
    end;

    TdaCustPropList(DetailsGrid.AllObjects[GetHeaderNameIndex('No'), ARow]).ByName[PropertyName].AsBoolean := State;
  end;
end;

procedure TUDDInputForm.btnPrintClick(Sender: TObject);
begin
  inherited;
  CreateTableOfUDDData(HDData);
end;

function TUDDInputForm.GetCategoryName: string;
begin
  Result := FCategoryName;
end;

procedure TUDDInputForm.SetCategoryName(const Value: string);
begin
  if FCategoryName <> Value then FCategoryName := Value;
end;

procedure TUDDInputForm.CreateTableOfUDDData(const HDDataPtr: TdaMDCustBase);
var
  qryAppend: TMyQuery;
  LoopItems, LoopColumn: integer;
  PropertyName, repSQL: string;
  ErrMsg:String;
begin
  DestroyUserTemporaryTable(fsTempTableName);
  fsTempTableName:=CreateUDDTemporaryTable(HDDataPtr.TypeName, true, ErrMsg);
  if fsTempTableName = '' then begin
      CommonLib.MessageDlgXP_Vista('The scope data given is invalid.  ' + ErrMsg , mtError , [mbOk] , 0);
      Exit;
  end;

  // Append data to table.
  if HDDataPtr.Detail.Count > 0 then begin
    qryAppend := TMyQuery.Create(nil);
    qryAppend.Options.FlatBuffers := True;
    qryAppend.connection := Self.MyConnection;
    try
      qryAppend.SQL.Add(' SELECT * FROM ' + fsTempTableName + '; ');
      qryAppend.Open;

      for LoopItems := 0 to HDDataPtr.Detail.Count - 1 do begin
        if HDDataPtr.Detail.Item[LoopItems].Selected then begin
          qryAppend.Append;

          // Populate record
          for LoopColumn := 0 to HDDataPtr.MDCustPropDefs.MasterDefs.Count - 1 do begin
            PropertyName := HDDataPtr.MDCustPropDefs.MasterDefs.Item[LoopColumn].PropName;
            if HDDataPtr.MDCustPropDefs.MasterDefs.Item[LoopColumn].IsActive then begin
              qryAppend.FieldByName(PropertyName).AsString := HDDataPtr.Master.ByName[PropertyName].Value;
            end;
          end;

          for LoopColumn := 0 to HDDataPtr.MDCustPropDefs.DetailDefs.Count - 1 do begin
            PropertyName := HDDataPtr.MDCustPropDefs.DetailDefs.Item[LoopColumn].PropName;
            if HDDataPtr.MDCustPropDefs.DetailDefs.Item[LoopColumn].IsActive then begin
              qryAppend.FieldByName(PropertyName).AsString := HDDataPtr.Detail.Item[LoopItems].ByName[PropertyName].Value;
            end;
          end;
          qryAppend.Post;
        end;
      end;
      qryAppend.Close;
    finally
      FreeandNil(qryAppend);
    end;
  end;

  fbReportSQLSupplied := true;

  repSQL := 'SELECT T.* , E.EmployeeName FROM ' + fsTempTableName + ' T RIGHT JOIN tblEmployees E ON T.EmployeeID = E.EmployeeID;';

  PrintTemplateReport('Scope Report', repSQL, false, 0);
end;

procedure TUDDInputForm.chkSelectAllClick(Sender: TObject);
var
  LoopRows: integer;
begin
  inherited;
  for LoopRows := 1 to DetailsGrid.RowCount - 1 do begin
    DetailsGrid.SetCheckBoxState(GetHeaderNameIndex('Selected'), LoopRows, chkSelectAll.Checked);
    HDData.Detail.Item[LoopRows - 1].Selected := chkSelectAll.Checked;
  end;
end;

procedure TUDDInputForm.DetailsGridEnter(Sender: TObject);
begin
  inherited;
    if cboDefinition.text = '' then begin
        cboDefinition.Enabled := True;
        cboDefinition.SetFocus
    end else begin
        cboDefinition.Enabled  := False;
        btnImport.Enabled := true;
    end;
end;

procedure TUDDInputForm.cboDefinitionCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
    CategoryName := qryScopeDefinitionsTypename.asString;
    Self.formShow(Self);
    HDData.ParentID :=qryScopeDefinitionsdaId.asInteger;
    edtDescription.Text :=qryScopeDefinitionsDescription.asString;
    if qryEmployeeID.Active = False then qryEmployeeID.Open;
    if FastFuncs.Trim(EmployeeLookup.Text) = '' then
        if qryEmployeeID.Locate('EmployeeID', AppEnv.Employee.EmployeeID,[]) then begin
            EmployeeLookup.Text :=qryEmployeeID.FieldByname('EmployeeName').asString;
        end;
    btnImport.Enabled := true;    
end;

procedure TUDDInputForm.qryEmployeeIDAfterOpen(DataSet: TDataSet);
begin
  inherited;
  EmployeeLookup.Enabled := true;
end;

procedure TUDDInputForm.DetailsGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
Var LoopColumn : integer;
    ColumnHeader, PropertyName: string;
begin
  inherited;
  if (Key = VK_DELETE) then begin
    if (Shift = [ssCtrl]) then begin
      if (MessageBox(0,
      'You are about to delete Record' + #13 + #10 +
      'Do you wish to continue?', 'Database Record Deletion Warning',
      MB_ICONWARNING or MB_YESNO) = idYes) then begin
        // Delete detail record
        HDData.Detail.Delete(DetailsGrid.Row-1);
        DetailsGrid.RemoveRows(DetailsGrid.Row,1);
        FillNoColumn;
      end;
    end
    else begin
      if not DetailsGrid.EditMode then begin
        HDData.Detail.Item[DetailsGrid.Row-1].Item[DetailsGrid.Col-1].Value := '';
        DetailsGrid.Cells[DetailsGrid.Col, DetailsGrid.Row] := '';
        DetailsGrid.RepaintCell(DetailsGrid.Row,DetailsGrid.Col);
      end;
    end;
  end
  else if (Key = VK_INSERT) then begin
    HDData.Detail.Insert(DetailsGrid.Row - 1);

  DetailsGrid.InsertRows(DetailsGrid.Row,1);

  DetailsGrid.AllObjects[GetHeaderNameIndex('No'), DetailsGrid.Row] := HDData.Detail.Item[DetailsGrid.Row-1];

  // Is checkbox required
  for LoopColumn := 0 to HDData.MDCustPropDefs.DetailDefs.Count - 1 do begin
    if HDData.MDCustPropDefs.DetailDefs.Item[LoopColumn].IsActive then begin
      ColumnHeader := HDData.MDCustPropDefs.DetailDefs.Item[LoopColumn].Caption;
      PropertyName := HDData.MDCustPropDefs.DetailDefs.Item[LoopColumn].PropName;
      if HDData.MDCustPropDefs.DetailDefs.Item[LoopColumn].DataType = TdaCustPropDataType(cdtBoolen) then DetailsGrid.AddCheckBox(GetHeaderNameIndex(ColumnHeader), DetailsGrid.Row , false, false);
    end;
  end;
  DetailsGrid.AddCheckBox(GetHeaderNameIndex('Selected'), DetailsGrid.Row, false, false);
  FillNoColumn;

  end;
end;

procedure TUDDInputForm.FillNoColumn;
Var i: integer;
begin
  for i := 1 to DetailsGrid.RowCount - 1 do begin
    DetailsGrid.Cells[GetHeaderNameIndex('No'),i] := FastFuncs.IntToStr(i);
  end;
end;

procedure TUDDInputForm.actMainImportExecute(Sender: TObject);
Var SL : TStringList;
begin
  inherited;
  if OpenDialog1.Execute() then begin
    if FileExists(OpenDialog1.FileName) then begin
      SL := TStringList.Create;
      try
        SL.LoadFromFile(OpenDialog1.FileName);
        ImportSCVStringList(SL);
      finally
        FreeandNil(SL);
      end;
    end
    else begin
      CommonLib.MessageDlgXP_Vista('File does not exist!', mtError, [mbOK], 0);
      Exit;
    end;
  end;
end;

procedure TUDDInputForm.actMainExportExecute(Sender: TObject);
begin
  inherited;
  if SaveDialog1.Execute() then begin
    GetSCVExportStringList.SaveToFile(SaveDialog1.FileName);
  end;
end;

function TUDDInputForm.GetSCVExportStringList: TStringList;
Var i, LoopItems, LoopColumn  : integer;
  ColumnHeader, PropertyName : string;
begin
  Result := TStringList.Create;

  // make header string
  Result.Add('');
  for i := 0 to HDData.MDCustPropDefs.DetailDefs.Count - 1 do begin
    if HDData.MDCustPropDefs.DetailDefs.Item[i].IsActive then begin
      Result[0] := Result[0] + HDData.MDCustPropDefs.DetailDefs.Item[i].PropName;
      if i < HDData.MDCustPropDefs.DetailDefs.Count - 1 then
        Result[0] := Result[0] + ',';
    end;
  end;

  //make details strings
    for LoopItems := 0 to HDData.Detail.Count - 1 do begin
      Result.Add('');
      // Populate row with data column
      for LoopColumn := 0 to HDData.MDCustPropDefs.DetailDefs.Count - 1 do begin
        if HDData.MDCustPropDefs.DetailDefs.Item[LoopColumn].IsActive then begin
          ColumnHeader := HDData.MDCustPropDefs.DetailDefs.Item[LoopColumn].Caption;
          PropertyName := HDData.MDCustPropDefs.DetailDefs.Item[LoopColumn].PropName;
          Result[LoopItems+1] := Result[LoopItems+1] + AnsiQuotedStr(TdaCustPropList(DetailsGrid.AllObjects[GetHeaderNameIndex('No'), LoopItems + 1]).ByName[PropertyName].Value,'"');
          if LoopColumn < HDData.MDCustPropDefs.DetailDefs.Count - 1 then
            Result[LoopItems+1] := Result[LoopItems+1] + ',';
        end;
      end;
    end;
end;

procedure TUDDInputForm.ImportSCVStringList(const SL: TStringList);
Var
  LoopItems, LoopColumn, GridLinesCount: integer;
 // ColumnHeader, PropertyName: string;
  LineList : TStringList;
begin
  if DetailsGrid.RowCount > 2 then begin
    GridLinesCount := DetailsGrid.RowCount-1;
  end
  else begin
    GridLinesCount := DetailsGrid.RowCount-2;
  end;

  if SL.Count > 0 then begin
    for LoopItems := 1 to SL.Count - 1 do begin
      if (DetailsGrid.RowCount > 2) or (LoopItems > 1) then begin
        DetailsGrid.AddRow;
        HDData.Detail.Add;
      end;
        
      DetailsGrid.Cells[GetHeaderNameIndex('No'), LoopItems + GridLinesCount] := FastFuncs.IntToStr(LoopItems + GridLinesCount);
      LineList := TStringList.Create;
      try
        Linelist.Clear;
        LineList.CommaText := SL[LoopItems];
        // Populate row with data column
        for LoopColumn := 1 to DetailsGrid.ColCount - 2 do begin
          DetailsGrid.Cells[LoopColumn, LoopItems + GridLinesCount] := LineList[LoopColumn - 1];
          HDData.Detail.Item[LoopItems + GridLinesCount - 1].Item[LoopColumn-1].Value := LineList[LoopColumn - 1];
          end;
      finally
        FreeandNil(LineList);
      end;
      DetailsGrid.AllObjects[GetHeaderNameIndex('No'), LoopItems + GridLinesCount] := HDData.Detail.Item[LoopItems + GridLinesCount - 1];
      DetailsGrid.AddCheckBox(GetHeaderNameIndex('Selected'), LoopItems + GridLinesCount, true, false);
    end;
  end;

end;

initialization

finalization
end.
