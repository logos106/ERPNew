unit frmUDDDefinitionEditor;

{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 16/11/05 1.00.00  MV   Initial verson.
 23/11/05 1.00.01  MV   Redesigned to support new daBase Class Objects
 24/11/05 1.00.02  MV   Modified to support new TdaMDCustPropDefList Class Object
 28/11/05 1.00.03  MV   Modified to support changes to daBase Class Objects
 29/11/05 1.00.04  MV   Modified to support dummy master detail definition
 02/12/05 1.00.05  MV   Modified to support setting boolean values for checkbox
                        automation.
 05/12/05 1.00.06  MV   Add support for data type of list.
 06/12/05 1.00.07  MV   Modified to support CategoryName Field required
                        datScopingAddin.
 07/12/05 1.00.08  MV   Modified to support creation of temp table.
 09/12/05 1.00.09  MV   Changed HDDef from private to protected for use with
                        inhertied classes.
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DataState, DBAccess, MyAccess, SelectionDialog,
  AppEvnts, DB,  StdCtrls, Mask, DBCtrls, wwcheckbox, Buttons, DNMSpeedButton,
  ExtCtrls, DNMPanel, ActnList, Grids, BaseGrid, AdvGrid, DBAdvGrid, MemDS,
  Wwdbigrd, Wwdbgrid, wwdbedit, Wwdotdot, Wwdbcomb, daBase, ComCtrls, Menus, AdvMenus,
  Shader;

type
  TUDDDefinitionEditor = class(TBaseInputGUI)
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
    UserDefinedGrid: TAdvStringGrid;
    DNMPanel1: TDNMPanel;
    Label1: TLabel;
    edtName: TEdit;
    Label2: TLabel;
    edtDescription: TEdit;
    edtDate: TDateTimePicker;
    Label3: TLabel;
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
    procedure pnlTopDblClick(Sender: TObject);
    procedure UserDefinedGridGetEditorType(Sender: TObject; ACol, ARow: integer; var AEditor: TEditorType);
    procedure UserDefinedGridHasComboBox(Sender: TObject; ACol, ARow: integer; var HasComboBox: boolean);
    procedure UserDefinedGridCellChanging(Sender: TObject; OldRow, OldCol, NewRow, NewCol: integer; var Allow: boolean);
    procedure UserDefinedGridCanAddRow(Sender: TObject; var CanAdd: boolean);
    procedure UserDefinedGridSelectCell(Sender: TObject; ACol, ARow: integer; var CanSelect: boolean);
    procedure UserDefinedGridCheckBoxClick(Sender: TObject; ACol, ARow: integer; State: boolean);
    procedure UserDefinedGridAutoAddRow(Sender: TObject; ARow: integer);
    procedure UserDefinedGridCellValidate(Sender: TObject; ACol, ARow: integer; var Value: string; var Valid: boolean);
    procedure UserDefinedGridKeyPress(Sender: TObject; var Key: char);
    procedure UserDefinedGridComboChange(Sender: TObject; ACol, ARow, AItemIndex: integer; Const ASelection: string);
    procedure UserDefinedGridButtonClick(Sender: TObject; ACol, ARow: integer);
    procedure edtNameExit(Sender: TObject);
    procedure edtNameEnter(Sender: TObject);
    procedure edtNameKeyPress(Sender: TObject; var Key: Char);
    procedure UserDefinedGridComboCloseUp(Sender: TObject; ARow,
      ACol: Integer);
    procedure UserDefinedGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FDataTypeList: TStringList;
    FCategoryName: string;
    fsTempTableName :String;
    fbChangingcell :boolean;
    procedure DoOpenData;
    procedure InitialiseGrid;
    procedure CreateMasterCustPropDefs;
    function ValidateFormData: boolean;
    Function SaveData :Boolean;
    Function FieldUnique(const FieldName :String; const Data :String; const dataCol, DataRow :Integer) :boolean;
    //function SaveData: boolean;
    function GetHeaderNameIndex(const HeaderName: string): integer;
    function GetCategoryName: string;
    procedure SetCategoryName(const Value: string);
  protected
    HDDef: TdaMDCustPropDefList;
    //Procedure LoadHelpNotes; Override;
  public
    { Public declarations }

    
    property CategoryName: string read GetCategoryName write SetCategoryName;
  end;

{var
  UDDDefinitionEditor: TUDDDefinitionEditor;}

implementation

{$R *.dfm}

uses
  DNMExceptions, DateUtils, // For exception handling in FormShow
  frmUDDPropertyListEditor, CommonDbLib, CommonLib, FastFuncs;    // Only required if FormFact used in initialization

const
  DT_STRING  = 0;
  DT_INTEGER = 1;
  DT_DOUBLE  = 2;
  DT_BOOLEAN = 3;
  DT_DATE    = 4;
  DT_LIST    = 5;
  //SCOPE      = 'Scoping';
  SCOPE      = '';
  DT_Invalidchars = ['~', '`', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '-', '+', '=', '?', '>', '<', ',', '.', '/', ':', '"', '''', ';', '{', '}', '|', '[', ']', '\', ',', ' '];

  // Our main class instantiator
{class function TUDDDefinitionEditor.Instance: TBaseInputGUI;
begin
  if not Assigned(UDDDefinitionEditor) then begin
    UDDDefinitionEditor := TUDDDefinitionEditor.Create(Application);
  end;
  // Return the form handle.
  Result := UDDDefinitionEditor;
end;}
(*Procedure TUDDDefinitionEditor.LoadHelpNotes;
begin
//    inherited;
    AddHelp(Self.ClassName , 'Scoping Definition' ,Self.Classname ,
            'This form lets you define the Scoping. A valid scoping definition ' +
            'will havea  unique name and at least one Property name.') ;
    AddHelp(edtName.Name , 'Scopng definition Name' ,edtName.Name ,
            'The name of the scoping definition is a mandatory field and should be unique.' +
            'The definition can be maximum of 30 characters long and should not contain ' +
            'any special character or space.');
    AddHelp(UserDefinedGrid.Name , 'Scoping Properties' ,UserDefinedGrid.Name ,
            'Here is the properties of the scoping definitions are defined. ' +
            'The Scoping should have at least one property. ' +
            'The property names should be unique within the scoping definition.  ' +
            'The special characters or spaces are not allowed in the property name. ' +
            'Caption of the property will be displayed in the scoping screen, ' +
            'so the caption is a usr-friendly name for the property. ' +
            'The property name should be active to see them in the scoping screens. ' +
            'There are a list of 5 data types available from which the Datatye of the property can be selected. ' +
            'The default value indicates the value of the property when the new ' +
            'record is added and user can change it. ' +
            'List data type let the user to define the list and the scope data can only select from the list.');
    AddHelp(btnSave.Name , 'Save Scope Definition' ,btnSave.Name ,
            'Saves the Scope definition after validation' );
    AddHelp(btnNew.Name , 'New Scope Definition' ,btnNew.Name ,
            'Saves the Scope definition after validation and opens a new blank Scope definition record' );
    AddHelp(btnCancel.Name , 'Cancel Scope Definition' ,btnCancel.Name ,
            'Cancels the changes in the current record and closes the form. ' +
            'If the record was new and not saved, the record will be deleted' );
    AddHelp(chkActive.Name , 'Scope definition Active?' ,chkActive.Name ,
            'Not selecting this check box makes the current Scoping definition inactive. '+
            'This means that Scoping definition will remain in the database but will not be visible '+
            'in the normal lists.' );
end;*)

procedure TUDDDefinitionEditor.FormCreate(Sender: TObject);
begin
  //Self.fbIgnoreAccessLevels := true;
  inherited;
  // If user does not have access to this form so don't process any further
  if ErrorOccurred then Exit;

  FDataTypeList := TStringList.Create;
  FDataTypeList.Add('String');
  FDataTypeList.Add('Integer');
  FDataTypeList.Add('Double');
  FDataTypeList.Add('Boolean');
  FDataTypeList.Add('DateTime');
  FDataTypeList.Add('List');
end;

procedure TUDDDefinitionEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DestroyUserTemporaryTable(fsTempTableName);
  inherited;
  FreeandNil(FDataTypeList);
  RollbackTransaction;
  Action := caFree;
end;

procedure TUDDDefinitionEditor.FormShow(Sender: TObject);
begin
  try
    fbChangingcell := False;
    inherited;
    if ErrorOccurred then Exit;
    UserDefinedGrid.rowcount :=1;
    SetControlFocus(edtName);
    CategoryName := SCOPE;
    HDDef          := TdaMDCustPropDefList.Create(self);
    HDDef.connection := Self.MyConnection;
    if KeyId = 0 then HDDef.TypeName := CategoryName else Hddef.Id := KeyId;
    DoOpenData;
    //TitleLabel.Caption := CategoryName;
    //if TitleLabel.Caption = '' then TitleLabel.Caption := 'Scoping';
    InitialiseGrid;

  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do HandleNoAccessException(e);
  end;
end;

procedure TUDDDefinitionEditor.DoOpenData;
begin
  // rollback if form is called when already open
  RollbackTransaction;
  HDDef.Load;
  if HDDef.MasterDefs.Count = 0 then begin
    CreateMasterCustPropDefs;
  end;
  if Hddef.Id > 0 then begin
    Self.edtName.Text       := Hddef.typename;
    Self.edtDescription.Text:= Hddef.Description;
    Self.edtDate.Date       := Hddef.Date;
    Self.chkActive.Checked  := Hddef.Active;
  end else begin
    {Self.edtName.Text       := 'Scoping';
    Self.edtDescription.Text:= 'Scoping';}
    Self.edtName.Text       := '';
    Self.edtDescription.Text:= '';
    Self.edtDate.Date       := Dateof(Now);
    Self.chkActive.Checked  := True;
  end;
  BeginTransaction;
end;

Function TUDDDefinitionEditor.SaveData :Boolean;
 var ErrMsg :String;
begin
  Result := false;
  if CommonLib.MessageDlgXP_Vista('Do you wish to check the Property Name, DataType and Default Value' + #13 + #10 +
    'as they can not be modified after commiting the Save.',mtconfirmation , [mbnO, mbYes] , 0) = mrYes then begin
    Exit;
  end;

  {change the cell to force the omchangecell event}
  if UserDefinedGrid.Row > 0 then
    if UserDefinedGrid.Col < 5 then UserDefinedGrid.col := 5 else UserDefinedGrid.col := 2;
  
  //if not SaveData then Exit;
  if not ValidateFormData then Exit;
  HDDef.TypeName      := edtName.Text;
  HDDef.Description   := edtDescription.Text;
  HDDef.Date          := edtDate.Date;
  HDDef.Active        := chkActive.Checked;
  HDDef.Save;

  fsTempTableName:=CreateUDDTemporaryTable(CategoryName, false, ErrMsg);
  if fsTempTableName  = '' then begin
    CommonLib.MessageDlgXP_Vista('The scope definition is invalid.  ' + ErrMsg , mtError , [mbOk] , 0);
    Exit;
  end;
  CommitTransaction;
  Notify;
  Result := True;
end;

procedure TUDDDefinitionEditor.actMainSaveExecute(Sender: TObject);
Var CanAdd : boolean;
begin
  inherited;
  CanAdd := true;
  UserDefinedGridCanAddRow(nil,CanAdd);
  if not CanAdd then
    ;// Delete Row

  if not SaveData then Exit;
  HDDef.Dirty := false;
  Close;
end;

procedure TUDDDefinitionEditor.actMainNewExecute(Sender: TObject);
begin
  inherited;
  {if HDDef.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          //if not SaveData then Exit
          if not ValidateFormData then Exit
          else begin
            HDDef.Save;
            CommitTransaction;
            Notify;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
        end;
      mrCancel:
        begin
          Exit;
        end;
    end;

  end;}

  if not SaveData then Exit;

  if assigned(HDDef) then freeandNil(HDDef);
  UserDefinedGrid.ClearRows(1,UserDefinedGrid.Rowcount-1);
  KeyID := 0;
  Self.FormShow(self);

  {Self.Close;
  With TScopingDefinitionEditor(GetComponentByClassName('TScopingDefinitionEditor')) do begin
        KeyId := 0;
        FormStyle := fsMDIChild;
        BringTofront;
  end;}
end;

procedure TUDDDefinitionEditor.actMainCancelExecute(Sender: TObject);
begin
  inherited;
  RollbackTransaction;
  Close;
end;

procedure TUDDDefinitionEditor.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if HDDef.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes: 
        begin
          //if SaveData then begin
          if ValidateFormData then begin 
            CommitTransaction;
            Notify;
            CanClose := true;
          end;
        end;
      mrNo: 
        begin
          // Cancel edits and Rollback changes
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

function TUDDDefinitionEditor.ValidateFormData: boolean;
begin
  Result := False;
  With TMyQuery.Create(nil) do Try
        Options.FlatBuffers := True;
        connection := Self.MyConnection;
        SQL.add('Select * from tblDA where TypeName = ' + quotedStr(edtName.Text) + ' and DAID <> ' + FastFuncs.IntToStr(hddef.id));
        Open;
        if recordcount > 0 then begin
            CommonLib.MessageDlgXP_Vista('Scope definition exists with this name, please provide a unique name' , mtWarning , [mbOk] , 0);
            Exit;
        end;
  finally
      if Active then Close;
      Free;
  end;
  if FastFuncs.Trim(edtName.text) = '' then begin
    CommonLib.MessageDlgXP_Vista('Scope definition name should not be blank' , mtWarning , [mbOk] , 0);
    Exit;
  end;
  if UserDefinedGrid.RowCount <= 1 then begin
    CommonLib.MessageDlgXP_Vista('Scope definition should have at least 1 property' , mtWarning , [mbOk] , 0);
    Exit;
  end;
  Result := true;
end;

{function TUDDDefinitionEditor.SaveData: boolean;
begin
  Result := false;
  if ValidateFormData then begin
    Result := true;
  end;
end;}

procedure TUDDDefinitionEditor.InitialiseGrid;
var
  LoopItems: integer;
  NewRecord: TdaCustPropDef;
begin
  UserDefinedGrid.RowCount := 1;
  UserDefinedGrid.ColWidths[GetHeaderNameIndex('')] := 20;
  if HDDef.DetailDefs.Count > 0 then begin
    for LoopItems := 0 to HDDef.DetailDefs.Count - 1 do begin
      UserDefinedGrid.AddRow;
      UserDefinedGrid.FixedRows := 1;
      UserDefinedGrid.AddCheckBox(GetHeaderNameIndex('Required'), LoopItems + 1, false, false);
      UserDefinedGrid.AddCheckBox(GetHeaderNameIndex('Active'), LoopItems + 1, false, false);
      UserDefinedGrid.AllObjects[GetHeaderNameIndex('Property Name'), LoopItems + 1] := HDDef.DetailDefs.Item[LoopItems];
      UserDefinedGrid.Cells[GetHeaderNameIndex('Property Name'), LoopItems + 1] :=
        TdaCustPropDef(UserDefinedGrid.AllObjects[GetHeaderNameIndex('Property Name'), LoopItems + 1]).PropName;
      UserDefinedGrid.Cells[GetHeaderNameIndex('Caption'), LoopItems + 1] :=
        TdaCustPropDef(UserDefinedGrid.AllObjects[GetHeaderNameIndex('Property Name'), LoopItems + 1]).Caption;
      UserDefinedGrid.Cells[GetHeaderNameIndex('DataType'), LoopItems + 1] :=
        FDataTypeList.Strings[Ord(TdaCustPropDef(UserDefinedGrid.AllObjects[GetHeaderNameIndex('Property Name'),
        LoopItems + 1]).DataType)];
      UserDefinedGrid.SetCheckBoxState(GetHeaderNameIndex('Required'), LoopItems + 1,
        TdaCustPropDef(UserDefinedGrid.AllObjects[GetHeaderNameIndex('Property Name'), LoopItems + 1]).IsRequired);
      UserDefinedGrid.SetCheckBoxState(GetHeaderNameIndex('Active'), LoopItems + 1,
        TdaCustPropDef(UserDefinedGrid.AllObjects[GetHeaderNameIndex('Property Name'), LoopItems + 1]).IsActive);
      if FDataTypeList.Strings[Ord(TdaCustPropDef(UserDefinedGrid.AllObjects[GetHeaderNameIndex('Property Name'),
        LoopItems + 1]).DataType)] = 'Boolean' then begin
        UserDefinedGrid.AddCheckBox(GetHeaderNameIndex('Default Value'), LoopItems + 1, false, false);
        if TdaCustPropDef(UserDefinedGrid.AllObjects[GetHeaderNameIndex('Property Name'),LoopItems +1 ]).defaultValue <> '' then
            UserDefinedGrid.SetCheckBoxState(GetHeaderNameIndex('Default Value'), LoopItems + 1,
                StrToBool(TdaCustPropDef(UserDefinedGrid.AllObjects[GetHeaderNameIndex('Property Name'), LoopItems + 1]).DefaultValue));
      end else if FDataTypeList.Strings[Ord(TdaCustPropDef(UserDefinedGrid.AllObjects[GetHeaderNameIndex('Property Name'),
        LoopItems + 1]).DataType)] = 'List' then begin
        UserDefinedGrid.AddButton(GetHeaderNameIndex(''), LoopItems + 1, 20, 20, '...', haFull, vaFull);
        UserDefinedGrid.Cells[GetHeaderNameIndex('Default Value'), LoopItems + 1] :=
          TdaCustPropDef(UserDefinedGrid.AllObjects[GetHeaderNameIndex('Property Name'), LoopItems + 1]).DefaultValue;
      end else UserDefinedGrid.Cells[GetHeaderNameIndex('Default Value'), LoopItems + 1] :=
          TdaCustPropDef(UserDefinedGrid.AllObjects[GetHeaderNameIndex('Property Name'), LoopItems + 1]).DefaultValue;
    end;
  end else begin
    UserDefinedGrid.AddRow;
    UserDefinedGrid.FixedRows := 1;
    NewRecord       := HDDef.DetailDefs.Add;
    NewRecord.IsNew := true;
    UserDefinedGrid.AllObjects[GetHeaderNameIndex('Property Name'), 1] := NewRecord;
    UserDefinedGrid.AddCheckBox(GetHeaderNameIndex('Required'), 1, false, false);
    UserDefinedGrid.AddCheckBox(GetHeaderNameIndex('Active'), 1, false, false);
  end;
end;

procedure TUDDDefinitionEditor.pnlTopDblClick(Sender: TObject);
begin
  inherited;
  CommonLib.MessageDlgXP_Vista(HDDef.DetailDefs.XML, mtInformation , [mbOK], 0);
end;

procedure TUDDDefinitionEditor.UserDefinedGridGetEditorType(Sender: TObject; ACol, ARow: integer; var AEditor: TEditorType);
var
  TmpStr: string;
begin
  inherited;

  if UserDefinedGrid.Cells[ACol, 0] = 'DataType' then begin
    AEditor := edComboList;
    UserDefinedGrid.Combobox.Items.Assign(FDataTypeList);
  end;

  if UserDefinedGrid.Cells[ACol, 0] = 'Default Value' then begin
    TmpStr := UserDefinedGrid.Cells[GetHeaderNameIndex('DataType'), ARow];
    case FDataTypeList.IndexOf(TmpStr) of

      DT_DATE:
        begin
          AEditor := edDateEdit;
        end;

      DT_LIST:
        begin
          AEditor := edComboList;
          UserDefinedGrid.Combobox.Items.CommaText := HDDef.DetailDefs.Item[ARow - 1].Params.ListValues;
        end;
    end;
  end;
end;

procedure TUDDDefinitionEditor.UserDefinedGridHasComboBox(Sender: TObject; ACol, ARow: integer; var HasComboBox: boolean);
begin
  inherited;
  if UserDefinedGrid.Cells[ACol, 0] = 'DataType' then HasComboBox := true;
end;
Function TUDDDefinitionEditor.FieldUnique(const FieldName :String ; const Data :String ; const dataCol, DataRow :Integer) :boolean;

var
    ctr :Integer;
begin
    Result := True;
    for ctr := 1 to UserDefinedGrid.Rowcount-1 do begin
        if ctr <> Datarow then begin
                if UserDefinedGrid.Cells[GetHeaderNameIndex(fieldName), ctr] = Data then begin
                    Result := false;
                    Exit;
                end;
        end;
    end;
end;
procedure TUDDDefinitionEditor.UserDefinedGridCellChanging(Sender: TObject; OldRow, OldCol, NewRow, NewCol: integer;
  var Allow: boolean);
var
  TmpStr: string;
begin
  inherited;
  if IsFlag('DeletingRow') then Exit;
  //if fbChangingcell then Exit;
  //fbChangingcell := true;
  {selecting oolean data type automatically sets true to the default value, then changing the data type
  removes it from the grid, but not calling the on cell change event which does the intialisation
  of the datatype. here enforcing the initialization}
  if UserDefinedGrid.Cells[OldCol, 0] <> 'Default Value' then begin
    TdaCustPropDef(UserDefinedGrid.AllObjects[GetHeaderNameIndex('Property Name'), OldRow]).DefaultValue :=
      UserDefinedGrid.Cells[GetHeaderNameIndex('Default Value'), OldRow];
  end;

  {when row is changed, if the caption is blank, initialise it to the property name }
  if OldRow <> newrow then begin
    if UserDefinedGrid.Cells[GetHeaderNameIndex('Caption'), OldRow] = '' then
        UserDefinedGrid.Cells[GetHeaderNameIndex('Caption'), OldRow] := UserDefinedGrid.Cells[GetHeaderNameIndex('Property Name'), OldRow] ;
  end;
  if UserDefinedGrid.Cells[OldCol, 0] = 'Property Name' then begin
    {if property name is not unique, then set the ell back to the proeprty name}
    if not FieldUnique('Property Name' , UserDefinedGrid.Cells[OldCol, OldRow] , Oldcol, Oldrow) then begin
        CommonLib.MessageDlgXP_Vista('Property name should be unique within scope definition', mtError, [mbOk] , 0);
        Allow := False;
        Exit;
    end;
    TdaCustPropDef(UserDefinedGrid.AllObjects[GetHeaderNameIndex('Property Name'), OldRow]).PropName :=
      UserDefinedGrid.Cells[OldCol, OldRow];
  end else if UserDefinedGrid.Cells[OldCol, 0] = 'Caption' then begin
    {if caption is not unique, then set the ell back to the Caption.
    the caption should be unique for the scope data - scope data gris identifies the column with the
    caption of the property}
    if not FieldUnique('Caption' , UserDefinedGrid.Cells[OldCol, OldRow] , Oldcol, Oldrow) then begin
        CommonLib.MessageDlgXP_Vista('Caption should be unique within Scope definition', mtError, [mbOk] , 0);
        Allow := false;
        Exit;
    end;
    TdaCustPropDef(UserDefinedGrid.AllObjects[GetHeaderNameIndex('Property Name'), OldRow]).Caption :=
      UserDefinedGrid.Cells[OldCol, OldRow];
  end else if UserDefinedGrid.Cells[OldCol, 0] = 'DataType' then begin
    TmpStr := UserDefinedGrid.Cells[OldCol, OldRow];
    TdaCustPropDef(UserDefinedGrid.AllObjects[GetHeaderNameIndex('Property Name'), OldRow]).DataType :=
      TdaCustPropDataType(FDataTypeList.IndexOf(TmpStr));
  end else if UserDefinedGrid.Cells[OldCol, 0] = 'Default Value' then begin
    TdaCustPropDef(UserDefinedGrid.AllObjects[GetHeaderNameIndex('Property Name'), OldRow]).DefaultValue :=
      UserDefinedGrid.Cells[OldCol, OldRow];
  end;
  //fbChangingcell := False;
end;

procedure TUDDDefinitionEditor.UserDefinedGridCanAddRow(Sender: TObject; var CanAdd: boolean);
begin
  inherited;
  if (UserDefinedGrid.Cells[GetHeaderNameIndex('Property Name'), UserDefinedGrid.Row] = '') or
    (UserDefinedGrid.Cells[GetHeaderNameIndex('DataType'), UserDefinedGrid.Row] = '') then begin
    CanAdd := false;
  end;
end;

procedure TUDDDefinitionEditor.UserDefinedGridSelectCell(Sender: TObject; ACol, ARow: integer; var CanSelect: boolean);
begin
  inherited;
  if IsFlag('DeletingRow') then Exit;
  if not TdaCustPropDef(UserDefinedGrid.AllObjects[GetHeaderNameIndex('Property Name'), ARow]).IsNew then begin
    if UserDefinedGrid.Cells[ACol, 0] = 'Property Name' then CanSelect := false
    else if UserDefinedGrid.Cells[ACol, 0] = 'DataType' then CanSelect := false;
  end;
end;

procedure TUDDDefinitionEditor.UserDefinedGridCheckBoxClick(Sender: TObject; ACol, ARow: integer; State: boolean);
begin
  inherited;

  if UserDefinedGrid.Cells[ACol, 0] = 'Required' then begin
    TdaCustPropDef(UserDefinedGrid.AllObjects[GetHeaderNameIndex('Property Name'), ARow]).IsRequired := State;
  end else if UserDefinedGrid.Cells[ACol, 0] = 'Active' then begin
    TdaCustPropDef(UserDefinedGrid.AllObjects[GetHeaderNameIndex('Property Name'), ARow]).IsActive := State;
  end else if UserDefinedGrid.Cells[ACol, 0] = 'Default Value' then begin
    TdaCustPropDef(UserDefinedGrid.AllObjects[GetHeaderNameIndex('Property Name'), ARow]).DefaultValue :=
      BoolToStr(State, true);
  end;
end;

procedure TUDDDefinitionEditor.UserDefinedGridAutoAddRow(Sender: TObject; ARow: integer);
var
  NewRecord: TdaCustPropDef;
begin
  inherited;

  NewRecord := HDDef.DetailDefs.Add;
  NewRecord.IsNew := true;
  UserDefinedGrid.AllObjects[GetHeaderNameIndex('Property Name'), ARow + 1] := NewRecord;
  UserDefinedGrid.AddCheckBox(GetHeaderNameIndex('Required'), ARow + 1, false, false);
  UserDefinedGrid.AddCheckBox(GetHeaderNameIndex('Active'), ARow + 1, false, false);
end;

function TUDDDefinitionEditor.GetHeaderNameIndex(const HeaderName: string): integer;
var
  Found: boolean;
  ColCount: integer;
begin
  Result := 0;
  Found := false;
  ColCount := 0;
  while (not Found) and  (ColCount < UserDefinedGrid.ColCount) do begin
    if UserDefinedGrid.Cells[ColCount, 0] = HeaderName then begin
      Result := ColCount;
      Found := true;
    end;
    Inc(ColCount);
  end;
end;

procedure TUDDDefinitionEditor.UserDefinedGridCellValidate(Sender: TObject; ACol, ARow: integer;
  var Value: string; var Valid: boolean);
var
  TmpStr: string;
begin
  inherited;

  if UserDefinedGrid.Cells[ACol, 0] = 'Default Value' then begin
    TmpStr := UserDefinedGrid.Cells[GetHeaderNameIndex('DataType'), ARow];
    case FDataTypeList.IndexOf(TmpStr) of

      DT_INTEGER:
        begin
          try
            FastFuncs.StrToInt(Value);
          except
            Value := '0';
            CommonLib.MessageDlgXP_Vista('Invalid DataType - Integer expected', mtWarning , [mbOK], 0);
          end;
        end;

      DT_DOUBLE:
        begin
          try
            StrToFloat(Value);
          except
            Value := '0.0';
            CommonLib.MessageDlgXP_Vista('Invalid DataType - Decimal expected', mtWarning , [mbOK], 0);
          end;
        end;

      DT_DATE:
        begin
          try
            StrToDateTime(Value);
          except
            Value := '01/01/1990';
            CommonLib.MessageDlgXP_Vista('Invalid DataType - Date expected', mtWarning , [mbOK], 0);
          end;
        end;
    end;
  end;
end;

procedure TUDDDefinitionEditor.UserDefinedGridKeyPress(Sender: TObject; var Key: char);
var
  TmpStr: string;
  tmpCol, tmpRow: integer;
begin
  inherited;
  
  // Initialise local variables
  tmpCol := UserDefinedGrid.Col;
  tmpRow := UserDefinedGrid.Row;

  if UserDefinedGrid.Cells[tmpCol, 0] = 'Property Name' then begin
    if  (Key in DT_Invalidchars ) then Key := #0 else
        if FastFuncs.StrLength(UserDefinedGrid.Cells[tmpCol, tmpRow])>30 then
            if Key <> char(VK_BACK) then Key := char(0);
  end else if UserDefinedGrid.Cells[tmpCol, 0] = 'Default Value' then begin
    TmpStr := UserDefinedGrid.Cells[GetHeaderNameIndex('DataType'), tmpRow];
    case FDataTypeList.IndexOf(TmpStr) of

      DT_INTEGER:
        begin
          if (not (Key in [char(VK_BACK), '0'..'9'])) then Key := #0;
        end;

      DT_DOUBLE:
        begin
          if (not (Key in [char(VK_BACK), '.', '0'..'9'])) then Key := #0;
        end;
    end;
  end;
end;

procedure TUDDDefinitionEditor.CreateMasterCustPropDefs;
var
  LoopItems: integer;
begin
  for LoopItems := 0 to 3 do begin
    HDDef.MasterDefs.Add;
    case LoopItems of

      0:
        begin
          HDDef.MasterDefs.Item[LoopItems].PropName := 'Date';
          HDDef.MasterDefs.Item[LoopItems].Caption := 'Date';
          HDDef.MasterDefs.Item[LoopItems].DataType := TdaCustPropDataType(cdtDateTime);
        end;

      1:
        begin
          HDDef.MasterDefs.Item[LoopItems].PropName := 'EmployeeID';
          HDDef.MasterDefs.Item[LoopItems].Caption := 'Employee ID';
          HDDef.MasterDefs.Item[LoopItems].DataType := TdaCustPropDataType(cdtInteger);
        end;

      2:
        begin
          HDDef.MasterDefs.Item[LoopItems].PropName := 'Description';
          HDDef.MasterDefs.Item[LoopItems].Caption := 'Description';
          HDDef.MasterDefs.Item[LoopItems].DataType := TdaCustPropDataType(cdtString);
        end;

      3:
        begin
          HDDef.MasterDefs.Item[LoopItems].PropName := 'RefNo';
          HDDef.MasterDefs.Item[LoopItems].Caption := 'Reference No';
          HDDef.MasterDefs.Item[LoopItems].DataType := TdaCustPropDataType(cdtString);
        end;
    end;
    HDDef.MasterDefs.Item[LoopItems].IsRequired := true;
    HDDef.MasterDefs.Item[LoopItems].IsActive   := true;
    HDDef.MasterDefs.Item[LoopItems].IsNew      := true;
  end;
end;

procedure TUDDDefinitionEditor.UserDefinedGridComboChange(Sender: TObject; ACol, ARow, AItemIndex: integer;
 Const ASelection: string);
begin
  inherited;

  if UserDefinedGrid.Cells[ACol, 0] = 'DataType' then begin
    case AItemIndex of

      DT_BOOLEAN:
        begin
          UserDefinedGrid.AddCheckBox(GetHeaderNameIndex('Default Value'), ARow, true, false);
          TdaCustPropDef(UserDefinedGrid.AllObjects[GetHeaderNameIndex('Property Name'), ARow]).DefaultValue :=
            BoolToStr(true, true);
        end;

      DT_LIST:
        begin
          UserDefinedGrid.AddButton(GetHeaderNameIndex(''), ARow, 20, 20, '...', haFull, vaFull);
        end;

      else UserDefinedGrid.RemoveCheckBox(GetHeaderNameIndex('Default Value'), ARow);
    end;
  end else if UserDefinedGrid.Cells[ACol, 0] = 'Default Value' then begin
    TdaCustPropDef(UserDefinedGrid.AllObjects[GetHeaderNameIndex('Property Name'), ARow]).DefaultValue := ASelection;
  end;
end;

procedure TUDDDefinitionEditor.UserDefinedGridButtonClick(Sender: TObject; ACol, ARow: integer);
var
    Form :TUDDListEditor;
begin
  inherited;
  form := TUDDListEditor(GetComponentByClassName('TUDDListEditor'));
  Try
    Form.Definition := HDDef.DetailDefs.Item[ARow - 1];
    Form.ShowModal;
  Finally
    FreeandNil(Form);
  end;
  {Application.CreateForm(TUDDListEditor, UDDListEditor);
  UDDListEditor.Definition := HDDef.DetailDefs.Item[ARow - 1];
  UDDListEditor.ShowModal;}
end;

function TUDDDefinitionEditor.GetCategoryName: string;
begin
  Result := FCategoryName;
end;

procedure TUDDDefinitionEditor.SetCategoryName(const Value: string);
begin
  if FCategoryName <> Value then FCategoryName := Value;
end;

procedure TUDDDefinitionEditor.edtNameExit(Sender: TObject);
begin
  inherited;
    CategoryName     := FastFuncs.Trim(edtName.Text);
end;

procedure TUDDDefinitionEditor.edtNameEnter(Sender: TObject);
begin
  inherited;
    CategoryName     := FastFuncs.Trim(edtName.Text);
end;

procedure TUDDDefinitionEditor.edtNameKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
    if Key in DT_Invalidchars then Key := char(0)
    else if FastFuncs.StrLength(edtName.Text) > 30 then  //TABLE IS PREFIXED WITH TMP_ AND THE TABLE NAME CAN HAVE MAX 64 CHAR
        if key <> char(VK_BACK) then Key := char(0);
end;

procedure TUDDDefinitionEditor.UserDefinedGridComboCloseUp(Sender: TObject;
  ARow, ACol: Integer);
begin
  inherited;
    UserDefinedGridComboChange(Sender, Acol, ARow , 0, '');
end;

procedure TUDDDefinitionEditor.UserDefinedGridKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
Var CanAdd : boolean;
begin
  inherited;
  CanAdd := true;
  UserDefinedGridCanAddRow(nil,CanAdd);
  if (Key = VK_TAB) and CanAdd then begin
    if (UserDefinedGrid.Col = UserDefinedGrid.ColCount - 1) AND
       (UserDefinedGrid.Row = UserDefinedGrid.RowCount - 1) then begin
      UserDefinedGrid.AddRow;
      UserDefinedGridAutoAddRow(nil,UserDefinedGrid.Row);
      UserDefinedGrid.Col := 0;
      UserDefinedGrid.Row := UserDefinedGrid.Row + 1;
      Key := VK_DOWN;
    end;
    Exit;
  end;
  if (Key = VK_DELETE) then begin
    if (Shift = [ssCtrl]) then begin
      if (CommonLib.MessageDlgXP_Vista('You are about to delete Record (' + FastFuncs.IntToStr(UserDefinedGrid.Row) + ')' + #13 + #10 +
      'Do you wish to continue?', mtConfirmation, [mbYes,mbNo], 0) = mrYes) then begin

        if (UserDefinedGrid.Row = 1) and (UserDefinedGrid.RowCount = 2) then begin
          UserDefinedGrid.ClearRows(UserDefinedGrid.Row, 1);
          UserDefinedGridAutoAddRow(nil,UserDefinedGrid.Row-1);
        end
        else begin
          // Delete detail record
          HDDef.DetailDefs.Delete(UserDefinedGrid.Row-1);
          AddFlag('DeletingRow');
          UserDefinedGrid.RemoveRows(UserDefinedGrid.Row,1);
          RemoveFlag('DeletingRow');
        end;
      end;
    end
    else begin
      if not UserDefinedGrid.EditMode then begin
        UserDefinedGrid.Cells[UserDefinedGrid.Col, UserDefinedGrid.Row] := '';
        UserDefinedGrid.RepaintCell(UserDefinedGrid.Row,UserDefinedGrid.Col);
      end;
    end;
  end;
end;

initialization

finalization

end.
