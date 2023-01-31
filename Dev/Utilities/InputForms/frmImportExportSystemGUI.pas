unit frmImportExportSystemGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, wwdblook, StdCtrls, ExtCtrls, DNMPanel, DB,
  LbCipher, LbClass, Menus, AdvMenus, DBAccess,
  MyAccess, SelectionDialog, AppEvnts,  Buttons, DNMSpeedButton, kbmMemTable,
  kbmMemCSVStreamFormat, ComCtrls,AdvOfficeStatusBar, DatasetSaver, xmldom, XMLIntf, msxmldom,
  XMLDoc, frmLogs, oxmldom, DataState, StrUtils,MyClasses, MySQLErrors,
  ImgList, ERPdbComponents;

type
  TfrmImportExportSystem = class(TBaseInputGUI)
    MainMenu1: TMainMenu;
    General1: TMenuItem;
    Close1: TMenuItem;
    emplate1: TMenuItem;
    CreateNew1: TMenuItem;
    Export1: TMenuItem;
    oCSV1: TMenuItem;
    oXML1: TMenuItem;
    Configurations1: TMenuItem;
    Save1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Import1: TMenuItem;
    N4: TMenuItem;
    MyXML: TXMLDocument;
    DNMPanel3: TDNMPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    lsPlatinum1Tables: TListBox;
    lbSourceTables: TListBox;
    lsPlatinum1TableFields: TListBox;
    lbSourceTableFields: TListBox;
    lbMappedFields: TListBox;
    edtImportFile: TEdit;
    btnSelectFile: TDNMSpeedButton;
    cboOptions: TwwDBLookupCombo;
    cboFileType: TwwDBLookupCombo;
    cboTemplateType: TwwDBLookupCombo;
    btnTemplateEditor: TDNMSpeedButton;
    cboConfiguration: TwwDBLookupCombo;
    DNMPanel2: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    btnImport: TDNMSpeedButton;
    btnSaveConfig: TDNMSpeedButton;
    btnExportXML: TDNMSpeedButton;
    btnExportCSV: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure lsPlatinum1TablesClick(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure cboOptionsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboFileTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure lbSourceTableFieldsDblClick(Sender: TObject);
    procedure CreateNew1Click(Sender: TObject);
    procedure btnTemplateEditorClick(Sender: TObject);
    procedure cboTemplateTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure btnSelectFileClick(Sender: TObject);
    procedure oCSV1Click(Sender: TObject);
    procedure oXML1Click(Sender: TObject);
    procedure lbMappedFieldsKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure btnSaveConfigClick(Sender: TObject);
    procedure cboConfigurationNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure cboConfigurationCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure btnImportClick(Sender: TObject);
    procedure lbMappedFieldsDragDrop(Sender, Source: TObject; X, Y: integer);
    procedure lbSourceTableFieldsStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure lbSourceTableFieldsDragOver(Sender, Source: TObject; X, Y: integer; State: TDragState; var Accept: boolean);
    procedure lbMappedFieldsDragOver(Sender, Source: TObject; X, Y: integer; State: TDragState; var Accept: boolean);
    procedure lsPlatinum1TableFieldsDragOver(Sender, Source: TObject; X, Y: integer; State: TDragState; var Accept: boolean);
    procedure cboConfigurationKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cmdCloseClick(Sender: TObject);

  private
    { Private declarations }
    bOpenedSuccessfully: boolean;
    slDataFile: TStringList;
    qryConfigs: TMyQuery;
    qryFileType: TMyQuery;
    qryImportOption: TMyQuery;
    qryTemplates: TMyQuery;
    qryTemplateLines: TMyQuery;
    qryAllowableTables: TMyQuery;
    qryAllowableFields: TMyQuery;

    DatasetSaver: TDatasetFileSaver;
    LogForm: TfrmLogsGUI;

    procedure CreatePlatinum1TableList;
    procedure CreatePlatinum1TableFieldList;
    procedure CreateFieldFilterList(MyStringList: TStringList);
    procedure LoadConfiguration;
    procedure SaveConfiguration;

    function MapAlreadyExists(const sMapEntry: string): boolean;
    procedure ImportCSVTABTemplate;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  CommonDbLib, DNMExceptions, frmImportExportTemplatesGUI,
  CommonLib, frmImportTemplateCSVTAB,FastFuncs;

{ TfrmImportExportSystem }

procedure TfrmImportExportSystem.FormCreate(Sender: TObject);
begin
  inherited;
  bOpenedSuccessfully := false;

  // Create our objects that we will be requiring.
  slDataFile := TStringList.Create;
  qryConfigs := TMyQuery.Create(nil);
  qryConfigs.Options.FlatBuffers := True;
  qryFileType := TMyQuery.Create(nil);
  qryFileType.Options.FlatBuffers := True;
  qryImportOption := TMyQuery.Create(nil);
  qryImportOption.Options.FlatBuffers := True;
  qryTemplates := TMyQuery.Create(nil);
  qryTemplates.Options.FlatBuffers := True;
  qryTemplateLines := TMyQuery.Create(nil);
  qryTemplateLines.Options.FlatBuffers := True;
  qryAllowableTables := TMyQuery.Create(nil);
  qryAllowableTables.Options.FlatBuffers := True;
  qryAllowableFields := TMyQuery.Create(nil);
  qryAllowableFields.Options.FlatBuffers := True;

  DatasetSaver := TDatasetFileSaver.Create;

  // Now setup our queries.
  qryAllowableTables.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryAllowableTables.SQL.Clear;
  qryAllowableTables.SQL.Add('SELECT * FROM tblImportExportFilteredTableNames ORDER BY TableName;');
  qryAllowableTables.Open;

  qryAllowableFields.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryAllowableFields.SQL.Clear;
  qryAllowableFields.SQL.Add('SELECT * FROM tblImportExportFilteredFields ORDER BY TableName;');
  qryAllowableFields.Open;

  qryConfigs.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryConfigs.SQL.Clear;
  qryConfigs.SQL.Add('SELECT * FROM tblImportExportConfigurations WHERE (ConfigName = "Default") LIMIT 1;');
  qryConfigs.Open;

  qryImportOption.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryImportOption.SQL.Clear;
  qryImportOption.SQL.Add('SELECT * FROM tblImportExportOptionTypes ORDER BY OptionType;');
  qryImportOption.Open;

  qryFileType.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryFileType.SQL.Clear;
  qryFileType.SQL.Add('SELECT * FROM tblImportExportFileTypes ORDER BY FileType;');
  qryFileType.Open;

  qryTemplates.Connection := CommonDbLib.GetSharedMyDacConnection;

  qryTemplateLines.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryTemplateLines.SQL.Clear;
  qryTemplateLines.SQL.Add('SELECT * FROM tblImportExportFileTemplateLines');
  qryTemplateLines.SQL.Add('WHERE TemplateID = :xTemplateID');
  qryTemplateLines.SQL.Add('ORDER BY FieldStart;');
end;

procedure TfrmImportExportSystem.FormShow(Sender: TObject);
var
  sData: string;
begin
  try
    // Inherit from our Base Input Class.
    inherited;

    if Self.AccessLevel <> 1 then begin
      raise ENoAccess.Create('You do not have administration access rights for this feature!');
      Exit;
    end;

    cboOptions.LookupField := 'OptionType';
    cboOptions.LookupTable := qryImportOption;

    cboFileType.LookupField := 'FileType';
    cboFileType.LookupTable := qryFileType;

    cboTemplateType.LookupField := 'TemplateName';
    cboTemplateType.LookupTable := qryTemplates;

    // Setup our default configuration.
    if qryConfigs.RecordCount > 0 then begin
      qryImportOption.Locate('ID', qryConfigs.FieldByName('OptionTypeID').AsInteger, [loCaseInsensitive]);
      cboOptions.Text := qryConfigs.FieldByName('OptionType').AsString;
      cboOptionsCloseUp(Sender, qryImportOption, nil, true);

      qryFileType.Locate('ID', qryConfigs.FieldByName('FileTypeID').AsInteger, [loCaseInsensitive]);
      cboFileType.Text := qryConfigs.FieldByName('FileType').AsString;
      cboFileTypeCloseUp(Sender, qryFileType, nil, true);

      edtImportFile.Text := qryConfigs.FieldByName('ImportFilename').AsString;
      if not Empty(edtImportFile.Text) then begin
        try
          slDataFile.LoadFromFile(edtImportfile.Text);
        except
          edtImportFile.Text := '';
        end;
      end;

      if cboFileType.Text = 'Template' then begin
        // Do we have a template that we need to load in?
        if qryConfigs.FieldByName('TemplateID').AsInteger <> 0 then begin
          qryTemplates.SQL.Clear;
          qryTemplates.SQL.Add('SELECT * FROM tblImportExportFileTemplates ORDER BY TemplateName;');
          qryTemplates.Open;
          qryTemplates.Locate('ID', qryConfigs.FieldByName('TemplateID').AsInteger, [loCaseInsensitive]);
          cboTemplateType.Text := qryConfigs.FieldByName('TemplateName').AsString;
          cboTemplateTypeCloseUp(Sender, qryTemplateLines, nil, true);
        end;
      end;

      if (cboFileType.Text = 'Comma Separated') OR (cboFileType.Text = 'Tab Delimited') then begin
        // Do we have a template that we need to load in?
        if qryConfigs.FieldByName('TemplateID').AsInteger <> 0 then begin
          qryTemplates.SQL.Clear;
          qryTemplates.SQL.Add('SELECT * FROM tbladvimpcsvtabtempl ORDER BY TemplateName;');
          qryTemplates.Open;
          qryTemplates.Locate('advimpcsvtabtemplID', qryConfigs.FieldByName('TemplateID').AsInteger, [loCaseInsensitive]);
          cboTemplateType.Text := qryConfigs.FieldByName('TemplateName').AsString;
          cboTemplateTypeCloseUp(Sender, qryTemplateLines, nil, true);
        end;
      end;

      // Now setup the configuration dropdown control
      qryConfigs.SQL.Clear;
      qryConfigs.SQL.Add('SELECT * FROM tblImportExportConfigurations ORDER BY ConfigName;');
      qryConfigs.Open;

      cboConfiguration.LookupTable := qryConfigs;
      cboConfiguration.LookupField := 'ConfigName';
      qryConfigs.Locate('ConfigName', 'Default', [loCaseInsensitive]);
      cboConfiguration.Text := 'Default';

      lbMappedFields.Clear;
      sData := qryConfigs.FieldByName('MappedFields').AsString;
      ExtractStrings(['@'], [' '], PChar(sData), lbMappedFields.Items);
    end;

    // This must be last!
    bOpenedSuccessfully := true;

    // Exception Handler
  except
    // Handle these known exceptions.
    on EAbort do HandleEAbortException;
    on e: ENoAccess do HandleNoAccessException(e);
    else raise;
  end;
end;

procedure TfrmImportExportSystem.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  // Close down our query controls.
  CloseQueries;

  // Free form from memory.
  Action := caFree;
end;

procedure TfrmImportExportSystem.FormDestroy(Sender: TObject);
var
  bUseInsert: boolean;
  iX: integer;
  sMappedFields, sConfigName: string;
begin
  // Was this form opened successfully?
  if bOpenedSuccessfully then begin
    // Yes, Save default configuration.
    if cboConfiguration.Text = '' then begin
      sConfigName := 'Default';
    end else begin
      //        if cboConfiguration.Text <> 'Default' then
      //           SaveConfiguration;

      sConfigName := 'Default';
    end;

    cboConfiguration.LookupTable := nil;
    qryConfigs.Connection        := CommonDbLib.GetSharedMyDacConnection;
    qryConfigs.SQL.Clear;
    qryConfigs.SQL.Add('SELECT * FROM tblImportExportConfigurations WHERE (ConfigName = ' +
      QuotedStr(sConfigName) + ') LIMIT 1;');
    qryConfigs.Open;

    if qryConfigs.RecordCount > 0 then begin
      bUseInsert := false;
    end else begin
      bUseInsert := true;
    end;

    if bUseInsert then begin
      // Insert new record.
      qryConfigs.Insert;
    end else begin
      // Edit this record.
      qryConfigs.Edit;
    end;

    // Update details.
    qryConfigs.FieldByName('ConfigName').AsString    := sConfigName;
    qryConfigs.FieldByName('OptionType').AsString    := cboOptions.Text;
    qryConfigs.FieldByName('OptionTypeID').AsInteger := qryImportOption.FieldByName('ID').AsInteger;
    qryConfigs.FieldByName('FileType').AsString      := cboFileType.Text;
    qryConfigs.FieldByName('FileTypeID').AsInteger   := qryFileType.FieldByName('ID').AsInteger;

    if qryTemplates.Active then begin
      qryConfigs.FieldByName('TemplateName').AsString := cboTemplateType.Text;
      if (cboFileType.Text = 'Comma Separated') OR (cboFileType.Text = 'Tab Delimited') then begin
        qryConfigs.FieldByName('TemplateID').AsInteger := qryTemplates.FieldByName('AdvImpCSVTABtemplID').AsInteger;
      end
      else begin
        qryConfigs.FieldByName('TemplateID').AsInteger := qryTemplates.FieldByName('ID').AsInteger;
      end;
    end else begin
      qryConfigs.FieldByName('TemplateName').AsString := '';
      qryConfigs.FieldByName('TemplateID').AsInteger := 0;
    end;

    qryConfigs.FieldByName('ImportFilename').AsString := edtImportFile.Text;

    // Now generate the mapped fields blob string.
    sMappedFields := '';
    for iX := 0 to lbMappedFields.Count - 1 do begin
      sMappedFields := sMappedFields + lbMappedFields.Items.Strings[iX] + '@';
    end;

    // Store mapped data.
    qryConfigs.FieldByName('MappedFields').AsString := sMappedFields;

    // Save changes to default configuration.
    qryConfigs.Post;

    // Free up our used objects.
    if Assigned(DatasetSaver) then
      FreeandNil(DatasetSaver);
    if Assigned(slDataFile) then
      FreeandNil(slDataFile);
    if Assigned(qryConfigs) then
      FreeandNil(qryConfigs);
    if Assigned(qryAllowableTables) then
      FreeandNil(qryAllowableTables);
    if Assigned(qryAllowableFields) then
      FreeandNil(qryAllowableFields);
    if Assigned(qryFileType) then
      FreeandNil(qryFileType);
    if Assigned(qryImportOption) then
      FreeandNil(qryImportOption);
    if Assigned(qryTemplates) then
      FreeandNil(qryTemplates);
    if Assigned(qryTemplateLines) then
      FreeandNil(qryTemplateLines);
    if Assigned(LogForm) then LogForm.btnCancel.Click;
  end;
  inherited;
end;

procedure TfrmImportExportSystem.CreatePlatinum1TableList;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SHOW TABLES;');
    qry.Open;

    lsPlatinum1Tables.Clear;
    while not qry.Eof do begin
      if qryAllowableTables.Locate('TableName', qry.Fields[0].AsString, [loCaseInsensitive]) then begin
        lsPlatinum1Tables.Items.Add(qry.Fields[0].AsString);
      end;

      // Fetch Next Record.
      qry.Next;
    end;

    // Return to first record.
    qryAllowableTables.First;
  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TfrmImportExportSystem.CreatePlatinum1TableFieldList;
var
  qry: TMyQuery;
  sTableName: string;
begin
  qry := TMyQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  try
    sTableName     := lsPlatinum1Tables.Items.Strings[lsPlatinum1Tables.ItemIndex];
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SHOW FIELDS FROM `' + sTableName + '`');
    qry.Open;

    lsPlatinum1TableFields.Clear;
    while not qry.Eof do begin
      if qryAllowableFields.Locate('TableName;AllowableField', VarArrayOf([sTableName,
        qry.FieldByName('Field').AsString]), [loCaseInsensitive]) then begin
        lsPlatinum1TableFields.Items.Add(qry.FieldByName('Field').AsString);
      end;

      // Fetch Next Record.
      qry.Next;
    end;

    // Close query.
    qry.Close;

  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TfrmImportExportSystem.lsPlatinum1TablesClick(Sender: TObject);
begin
  inherited;
  if lsPlatinum1Tables.SelCount = 1 then begin
    // Create table field list appropriately to selected table.
    CreatePlatinum1TableFieldList;
  end else begin
    Label1.Enabled         := false;
    Label4.Enabled         := false;
    Label5.Enabled         := false;
    lbSourceTables.Enabled := false;
    lbSourceTableFields.Enabled := false;
    lbMappedFields.Enabled := false;
  end;
end;

function TfrmImportExportSystem.MapAlreadyExists(const sMapEntry: string): boolean;
var
  iX: integer;
begin
  Result := false;
  for iX := 0 to lbMappedFields.Items.Count - 1 do begin
    if lbMappedFields.Items.Strings[iX] = sMapEntry then begin
      Result := true;
      Exit;
    end;
  end;
end;

procedure TfrmImportExportSystem.Close1Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmImportExportSystem.cboOptionsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if cboOptions.Text = '' then Exit;

  if cboOptions.Text = 'Templates' then begin
    qryFileType.Locate('FileType', 'Template', [loCaseInsensitive]);
    cboFileType.Text := qryConfigs.FieldByName('FileType').AsString;
    cboFileTypeCloseUp(Sender, qryFileType, nil, true);
    Label14.Enabled       := false;
    cboFileType.Enabled   := false;
    Label7.Enabled        := true;
    edtImportFile.Enabled := true;
    btnSelectFile.Enabled := true;

    // Clear source tables.
    lbSourceTables.Clear;
    lbSourceTableFields.Clear;

    // Clear mapped fields.
    lbMappedFields.Clear;
  end else begin
    if cboOptions.Text = 'Parts' then begin
      // Enable the following controls.
      Label7.Enabled := false;
      edtImportFile.Enabled := false;
      btnSelectFile.Enabled := false;
      Label14.Enabled := false;
      cboFileType.Enabled := false;
      Label15.Enabled := false;
      cboTemplateType.Enabled := false;
      btnTemplateEditor.Enabled := false;

      lsPlatinum1Tables.Clear;
      lsPlatinum1Tables.Items.Add('tblparts');
      btnImport.Enabled := false;
    end else if cboOptions.Text = 'Clients' then begin
      // Enable the following controls.
      Label7.Enabled := false;
      edtImportFile.Enabled := false;
      btnSelectFile.Enabled := false;
      Label14.Enabled := false;
      cboFileType.Enabled := false;
      Label15.Enabled := false;
      cboTemplateType.Enabled := false;
      btnTemplateEditor.Enabled := false;

      lsPlatinum1Tables.Clear;
      lsPlatinum1Tables.Items.Add('tblclients');
      btnImport.Enabled := false;
    end else begin
      // Enable the following controls.
      Label7.Enabled := true;
      edtImportFile.Enabled := true;
      btnSelectFile.Enabled := true;
      Label14.Enabled := true;
      cboFileType.Enabled := true;

      // Create Platinum1 Table List.
      CreatePlatinum1TableList;
    end;

    // Activate menu export option.
    Export1.Enabled      := true;
    btnExportXML.Enabled := true;
    btnExportCSV.Enabled := true;

    // Clear source tables.
    lbSourceTables.Clear;
    lbSourceTableFields.Clear;

    // Clear mapped fields.
    lbMappedFields.Clear;

    if (cboFileType.Text <> '') and (cboFileType.Enabled) then begin
      qryFileType.Locate('ID', qryConfigs.FieldByName('FileTypeID').AsInteger, [loCaseInsensitive]);
      cboFileType.Text := qryConfigs.FieldByName('FileType').AsString;
      cboFileTypeCloseUp(Sender, qryFileType, nil, true);
    end;
  end;
end;

procedure TfrmImportExportSystem.cboFileTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if cboFileType.Text = '' then Exit;
  if cboFileType.Text = 'Template' then begin
    Label1.Enabled         := true;
    Label4.Enabled         := true;
    Label5.Enabled         := true;
    lbSourceTables.Enabled := true;
    lbSourceTableFields.Enabled := true;
    lbMappedFields.Enabled := true;

    lbSourceTables.Clear;
    lbSourceTables.Items.Add('Template');
    lbSourceTables.ItemIndex  := 0;
    Label15.Enabled           := true;
    cboTemplateType.Enabled   := true;
    btnTemplateEditor.Enabled := true;
    qryTemplates.Close;
    qryTemplates.SQL.Clear;
    qryTemplates.SQL.Add('SELECT * FROM tblImportExportFileTemplates ORDER BY TemplateName;');
    qryTemplates.Open;

    // Create allowable Platinum1 table list.
    lsPlatinum1Tables.Clear;
    lsPlatinum1Tables.Items.Add('tblpartstemporary');

    // Select this entry.
    lsPlatinum1Tables.ItemIndex := 0;

    // Create table field list appropriately to selected table.
    CreatePlatinum1TableFieldList;
  end else
  if cboFileType.Text = 'CSV / TXT / XML' then begin
    Label15.Enabled           := false;
    cboTemplateType.Enabled   := false;
    btnTemplateEditor.Enabled := false;
    qryTemplates.Close;
    // Create Platinum1 Table List.
    CreatePlatinum1TableList;
  end else
  if (cboFileType.Text = 'Comma Separated') OR (cboFileType.Text = 'Tab Delimited') then begin
    Label1.Enabled         := true;
    Label4.Enabled         := true;
    Label5.Enabled         := true;
    lbSourceTables.Enabled := true;
    lbSourceTableFields.Enabled := true;
    lbMappedFields.Enabled := true;

    lbSourceTables.Clear;
    lbSourceTables.Items.Add('Template');
    lbSourceTables.ItemIndex  := 0;
    Label15.Enabled           := true;
    cboTemplateType.Enabled   := true;
    btnTemplateEditor.Enabled := true;
    qryTemplates.Close;
    qryTemplates.SQL.Clear;
    qryTemplates.SQL.Add('SELECT * FROM tblAdvImpCSVTABtempl ');
    if (cboFileType.Text = 'Comma Separated') then begin
      qryTemplates.SQL.Add(' WHERE TemplateType = 1');
    end;
    if (cboFileType.Text = 'Tab Delimited') then begin
      qryTemplates.SQL.Add(' WHERE TemplateType = 2');
    end;
    qryTemplates.SQL.Add(' ORDER BY TemplateName');
    qryTemplates.Open;

    // Create allowable Platinum1 table list.
    lsPlatinum1Tables.Clear;
    lsPlatinum1Tables.Items.Add('tblpartstemporary');

    // Select this entry.
    lsPlatinum1Tables.ItemIndex := 0;

    // Create table field list appropriately to selected table.
    CreatePlatinum1TableFieldList;
  end;
end;

procedure TfrmImportExportSystem.lbSourceTableFieldsDblClick(Sender: TObject);
var
  sMapEntry: string;
begin
  if (lsPlatinum1TableFields.ItemIndex <> -1) and (lbSourceTableFields.ItemIndex <> -1) and
    (lbSourceTables.ItemIndex <> -1) and (lsPlatinum1Tables.ItemIndex <> -1) then begin
    // Here we will need to check the field types to ensure they can be converted
    // safely.  If they can't, then we can't map to it.  for example we cant map
    // a blob field to an integer.

    // Create map entry line.
    sMapEntry := lsPlatinum1TableFields.Items.Strings[lsPlatinum1TableFields.ItemIndex] + ':' +
      lbSourceTableFields.Items.Strings[lbSourceTableFields.ItemIndex];

    // Does this mapping entry already exist?
    if not MapAlreadyExists(sMapEntry) then begin
      // No, then Add Entry to the mapped field list.
      lbMappedFields.Items.Add(sMapEntry);
    end;
  end;
end;

procedure TfrmImportExportSystem.CreateNew1Click(Sender: TObject);
var
  iTempID: integer;
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TfrmImportExportTemplates');
  If not Assigned(tmpComponent) then Exit;
  with TfrmImportExportTemplates(tmpComponent) do begin
    FormStyle := fsNormal;
    ShowModal;
  end;

  iTempID := qryTemplates.FieldByName('ID').AsInteger;
  qryTemplates.Close;
  qryTemplates.Open;
  qryTemplates.Locate('ID', iTempID, [loCaseInsensitive]);
end;

procedure TfrmImportExportSystem.btnTemplateEditorClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  inherited;
  if cboFileType.Text = 'Template' then begin
    tmpComponent := GetComponentByClassName('TfrmImportExportTemplates');
    If not Assigned(tmpComponent) then Exit;
    with TfrmImportExportTemplates(tmpComponent) do begin
      if cboTemplateType.Text <> '' then begin
        KeyID := qryTemplates.FieldByName('ID').AsInteger;
      end else begin
        KeyID := 0;
      end;
      FormStyle := fsNormal;
      ShowModal;
    end;
  end else
  if (cboFileType.Text = 'Comma Separated') or (cboFileType.Text = 'Tab Delimited') then begin
    tmpComponent := GetComponentByClassName('TImportTemplateCSVTAB');
    If not Assigned(tmpComponent) then Exit;
    with TImportTemplateCSVTAB(tmpComponent) do begin
      if cboTemplateType.Text <> '' then begin
        KeyID := qryTemplates.FieldByName('AdvImpCSVTABtemplID').AsInteger;
      end else begin
        KeyID := 0;
      end;
      if cboFileType.Text = 'Comma Separated' then begin
        FileType := iftCSV;
      end;
      if cboFileType.Text = 'Tab Delimited' then begin
        FileType := iftTAB;
      end;
      FileName := edtImportFile.Text;
      FormStyle := fsNormal;
      ShowModal;
      Free;
    end;
  end;
end;

procedure TfrmImportExportSystem.cboTemplateTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
  Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if cboTemplateType.Text = '' then Exit;
  if not qryTemplates.Active then Exit;

  if (cboFileType.Text = 'Comma Separated') OR (cboFileType.Text = 'Tab Delimited') then begin
    qryTemplateLines.SQL.Clear;
    qryTemplateLines.SQL.Add('SELECT * FROM tblAdvImpCSVTABtemplLines');
    qryTemplateLines.SQL.Add('WHERE TemplateID = :xTemplateID');

    qryTemplateLines.Close;
    qryTemplateLines.ParamCheck := true;
    qryTemplateLines.Params.ParamByName('xTemplateID').AsInteger := qryTemplates.FieldByName('AdvImpCSVTABtemplID').AsInteger;
    qryTemplateLines.Open;
  end
  else begin
    qryTemplateLines.SQL.Clear;
    qryTemplateLines.SQL.Add('SELECT * FROM tblImportExportFileTemplateLines');
    qryTemplateLines.SQL.Add('WHERE TemplateID = :xTemplateID');
    qryTemplateLines.SQL.Add('ORDER BY FieldStart;');

    qryTemplateLines.Close;
    qryTemplateLines.ParamCheck := true;
    qryTemplateLines.Params.ParamByName('xTemplateID').AsInteger := qryTemplates.FieldByName('ID').AsInteger;
    qryTemplateLines.Open;
  end;

  lbSourceTables.Clear;
  Label1.Enabled := true;
  lbSourceTables.Enabled := true;
  Label4.Enabled := true;
  lbSourceTableFields.Enabled := true;
  lbSourceTables.Items.Add('Template');
  lbSourceTables.ItemIndex := 0;
  lbSourceTableFields.Clear;

  Label5.Enabled := true;
  lbMappedFields.Enabled := true;
  lbMappedFields.Clear;
  while not qryTemplateLines.Eof do begin
    // Add Field Name
    lbSourceTableFields.Items.Add(qryTemplateLines.FieldByName('FieldName').AsString);

    // Fetch next record
    qryTemplateLines.Next;
  end;

  if (edtImportFile.Text <> '') and (cboTemplateType.Text <> '') and
    (edtImportFile.Enabled) and (cboTemplateType.Enabled) then begin
    btnImport.Enabled := true;
    Import1.Enabled   := true;
  end else begin
    btnImport.Enabled := false;
    Import1.Enabled   := false;
  end;
end;

procedure TfrmImportExportSystem.btnSelectFileClick(Sender: TObject);
var
  fd: TOpenDialog;
begin
  inherited;
  fd := TOpenDialog.Create(Self);
  try
    fd.Title       := 'Please select file to import';
    fd.Filter      := 'All Files|*.*|CSV File|*.csv|Text File|*.txt|XML File|*.xml';
    fd.FilterIndex := 3;
    fd.Options     := [ofFileMustExist, ofPathMustExist];
    fd.DefaultExt  := 'txt';
    // Show file dialog
    if fd.Execute then begin
      edtImportFile.Text := fd.FileName;
    end;

  finally
    // Free our used objects.
    if Assigned(fd) then
      FreeandNil(fd);
  end;

  if (edtImportFile.Text <> '') and (cboTemplateType.Text <> '') and
    (edtImportFile.Enabled) and (cboTemplateType.Enabled) then begin
    btnImport.Enabled := true;
    Import1.Enabled   := true;
  end else begin
    btnImport.Enabled := false;
    Import1.Enabled   := false;
  end;
end;

procedure TfrmImportExportSystem.oCSV1Click(Sender: TObject);
var
  fs: TSaveDialog;
  sl: TStringList;
begin
  inherited;
  if lsPlatinum1Tables.ItemIndex < 0 then begin
    CommonLib.MessageDlgXP_Vista('You must select a Platinum1 table before you can export to a CSV file.', mtInformation, [mbOK], 0);
    Exit;
  end;

  fs := TSaveDialog.Create(self);
  sl := TStringList.Create;
  try
    fs.Title       := 'Save CVS Export file as ...';
    fs.Options     := [ofFileMustExist, ofCreatePrompt];
    fs.Filter      := 'All Files|*.*|CSV File|*.csv';
    fs.FilterIndex := 2;
    fs.DefaultExt  := 'cvs';
    if fs.Execute then begin
      DatasetSaver.FilterList := sl;
      // Create a list of fields to ignore.
      CreateFieldFilterList(sl);
      // Export Table to CVS File.
      DatasetSaver.SaveTableToCVS(lsPlatinum1Tables.Items.Strings[lsPlatinum1Tables.ItemIndex], fs.FileName);
    end;

  finally
    // Free our used objects.
    if Assigned(sl) then
      FreeandNil(sl);
    if Assigned(fs) then
      FreeandNil(fs);
  end;
end;

procedure TfrmImportExportSystem.oXML1Click(Sender: TObject);
var
  fs: TSaveDialog;
  sl: TStringList;
begin
  inherited;
  if lsPlatinum1Tables.ItemIndex < 0 then begin
    CommonLib.MessageDlgXP_Vista('You must select a Platinum1 table before you can export to a XML file.', mtInformation, [mbOK], 0);
    Exit;
  end;

  fs := TSaveDialog.Create(self);
  sl := TStringList.Create;
  try
    fs.Title       := 'Save XML Export file as ...';
    fs.Options     := [ofFileMustExist, ofCreatePrompt];
    fs.Filter      := 'All Files|*.*|Platinum1 XML File|*.xml';
    fs.FilterIndex := 2;
    fs.DefaultExt  := 'xml';
    if fs.Execute then begin
      // Set our field filter list.
      DatasetSaver.FilterList := sl;

      // Create a list of fields to ignore.
      CreateFieldFilterList(sl);

      // Export Table to XML file.
      DatasetSaver.SaveTableToXML(lsPlatinum1Tables.Items.Strings[lsPlatinum1Tables.ItemIndex], fs.FileName);
    end;

  finally
    // Free our used objects.
    if Assigned(sl) then
      FreeandNil(sl);
    if Assigned(fs) then
      FreeandNil(fs);
  end;
end;

procedure TfrmImportExportSystem.lbMappedFieldsKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  inherited;
  // Was the delete key pressed?
  if Key = vk_DELETE then begin
    // Is a mapped field entry selected?
    if lbMappedFields.ItemIndex <> -1 then begin
      // Yes, Delete selected mapped field line.
      lbMappedFields.Items.Delete(lbMappedFields.ItemIndex);
    end;
  end;
end;

procedure TfrmImportExportSystem.CreateFieldFilterList(MyStringList: TStringList);
var
  sTableName: string;
  qry: TMyQuery;
begin
  // Ensure stringlist is valid.
  if not Assigned(MyStringList) then Exit;
  MyStringList.Clear;
  qry := TMyQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  try
    sTableName     := lsPlatinum1Tables.Items.Strings[lsPlatinum1Tables.ItemIndex];
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SHOW FIELDS FROM `' + sTableName + '`');
    qry.Open;

    while not qry.Eof do begin
      if not qryAllowableFields.Locate('TableName;AllowableField', VarArrayOf([sTableName,
        qry.FieldByName('Field').AsString]), [loCaseInsensitive]) then begin
        MyStringList.Add(qry.FieldByName('Field').AsString);
      end;
      // Fetch next field name to check.
      qry.Next;
    end;

  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TfrmImportExportSystem.SaveConfiguration;
var
  bUseInsert: boolean;
  iX: integer;
  sMappedFields, sConfigName: string;
begin
  // Was this form opened successfully?
  if bOpenedSuccessfully then begin
    // Yes, Save default configuration.
    if cboConfiguration.Text = '' then begin
      sConfigName := 'Default';
    end else begin
      sConfigName := cboConfiguration.Text;
    end;

    if qryConfigs.Locate('ConfigName', cboConfiguration.Text, [loCaseInsensitive]) then begin
      bUseInsert := false;
    end else begin
      bUseInsert := true;
    end;

    if bUseInsert then begin
      // Insert new record.
      qryConfigs.Insert;
    end else begin
      // Edit this record.
      qryConfigs.Edit;
    end;

    // Update details.
    qryConfigs.FieldByName('ConfigName').AsString    := sConfigName;
    qryConfigs.FieldByName('OptionType').AsString    := cboOptions.Text;
    qryConfigs.FieldByName('OptionTypeID').AsInteger := qryImportOption.FieldByName('ID').AsInteger;
    qryConfigs.FieldByName('FileType').AsString      := cboFileType.Text;
    qryConfigs.FieldByName('FileTypeID').AsInteger   := qryFileType.FieldByName('ID').AsInteger;

    if qryTemplates.Active then begin
      qryConfigs.FieldByName('TemplateName').AsString := cboTemplateType.Text;
      If (qryTemplates.FindField('ID')=Nil) then
        qryConfigs.FieldByName('TemplateID').AsInteger := qryTemplates.FieldByName('advimpcsvtabtemplID').AsInteger
      else
        qryConfigs.FieldByName('TemplateID').AsInteger := qryTemplates.FieldByName('ID').AsInteger;
    end else begin
      qryConfigs.FieldByName('TemplateName').AsString := '';
      qryConfigs.FieldByName('TemplateID').AsInteger := 0;
    end;

    qryConfigs.FieldByName('ImportFilename').AsString := edtImportFile.Text;

    // Now generate the mapped fields blob string.
    sMappedFields := '';
    for iX := 0 to lbMappedFields.Count - 1 do begin
      sMappedFields := sMappedFields + lbMappedFields.Items.Strings[iX] + '@';
    end;

    // Store mapped data.
    qryConfigs.FieldByName('MappedFields').AsString := sMappedFields;

    // Save changes to default configuration.
    qryConfigs.Post;
  end;
end;

procedure TfrmImportExportSystem.btnSaveConfigClick(Sender: TObject);
begin
  inherited;
  SaveConfiguration;
end;

procedure TfrmImportExportSystem.cboConfigurationNotInList(Sender: TObject; LookupTable: TDataSet;
  NewValue: string; var Accept: boolean);
begin
  inherited;
  SaveConfiguration;
  Accept := true;
end;

procedure TfrmImportExportSystem.LoadConfiguration;
var
  sData: string;
begin
  qryImportOption.Locate('ID', qryConfigs.FieldByName('OptionTypeID').AsInteger, [loCaseInsensitive]);
  cboOptions.Text := qryConfigs.FieldByName('OptionType').AsString;
  cboOptionsCloseUp(nil, qryImportOption, nil, true);

  qryFileType.Locate('ID', qryConfigs.FieldByName('FileTypeID').AsInteger, [loCaseInsensitive]);
  cboFileType.Text := qryConfigs.FieldByName('FileType').AsString;
  cboFileTypeCloseUp(nil, qryFileType, nil, true);

  edtImportFile.Text := qryConfigs.FieldByName('ImportFilename').AsString;
  if not Empty(edtImportFile.Text) then begin
    try
      slDataFile.LoadFromFile(edtImportfile.Text);
    except
      edtImportFile.Text := '';
    end;
  end;

  if cboFileType.Text = 'Template' then begin
    // Do we have a template that we need to load in?
    if qryConfigs.FieldByName('TemplateID').AsInteger <> 0 then begin
      qryTemplates.SQL.Clear;
      qryTemplates.SQL.Add('SELECT * FROM tblImportExportFileTemplates ORDER BY TemplateName;');
      qryTemplates.Open;
      qryTemplates.Locate('ID', qryConfigs.FieldByName('TemplateID').AsInteger, [loCaseInsensitive]);
      cboTemplateType.Text := qryConfigs.FieldByName('TemplateName').AsString;
      cboTemplateTypeCloseUp(nil, qryTemplateLines, nil, true);
    end;
  end;

  lbMappedFields.Clear;
  sData := qryConfigs.FieldByName('MappedFields').AsString;
  ExtractStrings(['@'], [' '], PChar(sData), lbMappedFields.Items);
end;

procedure TfrmImportExportSystem.cboConfigurationCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
  Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if cboConfiguration.Text = '' then Exit;
  LoadConfiguration;
end;

procedure TfrmImportExportSystem.btnImportClick(Sender: TObject);
var
  sExt: string;
begin
  inherited;
  if edtImportFile.Text = '' then Exit;

  if (cboFileType.Text = 'Comma Separated') OR (cboFileType.Text = 'Tab Delimited') then begin
    ImportCSVTABTemplate;
    Exit;
  end;

  if cboOptions.Text = 'From CD / File' then begin
    if cboTemplateType.Text <> '' then begin
      // Import CD Template file.
      DatasetSaver.ImportTemplate(cboTemplateType.Text, TStringList(lbMappedFields.Items), edtImportFile.Text);
    end;

    sExt := ExtractFileExt(edtImportFile.Text);
    if sExt = '.xml' then begin
      //        DatasetSaver.ImportXMLData(edtImportFile.Text, MyXML, MyConnection);
    end;
  end else begin
    sExt := ExtractFileExt(edtImportFile.Text);
    if sExt = '.xml' then begin
      //         DatasetSaver.ImportXMLData(edtImportFile.Text, MyXML, MyConnection);
    end;
  end;
end;

procedure TfrmImportExportSystem.lbMappedFieldsDragDrop(Sender, Source: TObject; X, Y: integer);
var
  sMapEntry: string;
begin
  if (lsPlatinum1TableFields.ItemIndex <> -1) and (lbSourceTableFields.ItemIndex <> -1) and
    (lbSourceTables.ItemIndex <> -1) and (lsPlatinum1Tables.ItemIndex <> -1) then begin
    // Here we will need to check the field types to ensure they can be converted
    // safely.  If they can't, then we can't map to it.  for example we cant map
    // a blob field to an integer.

    // Create map entry line.
    sMapEntry := lsPlatinum1TableFields.Items.Strings[lsPlatinum1TableFields.ItemIndex] + ':' +
      lbSourceTableFields.Items.Strings[lbSourceTableFields.ItemIndex];

    // Does this mapping entry already exist?
    if not MapAlreadyExists(sMapEntry) then begin
      // No, then Add Entry to the mapped field list.
      lbMappedFields.Items.Add(sMapEntry);
    end;
  end;
end;

procedure TfrmImportExportSystem.lbSourceTableFieldsStartDrag(Sender: TObject; var DragObject: TDragObject);
begin
  inherited;
  //
end;

procedure TfrmImportExportSystem.lbSourceTableFieldsDragOver(Sender, Source: TObject; X, Y: integer;
  State: TDragState; var Accept: boolean);
begin
  inherited;
  Accept := true;
end;

procedure TfrmImportExportSystem.lbMappedFieldsDragOver(Sender, Source: TObject; X, Y: integer;
  State: TDragState; var Accept: boolean);
begin
  inherited;
  Accept := true;
end;

procedure TfrmImportExportSystem.lsPlatinum1TableFieldsDragOver(Sender, Source: TObject; X, Y: integer;
  State: TDragState; var Accept: boolean);
begin
  inherited;
  Accept := true;
end;

procedure TfrmImportExportSystem.cboConfigurationKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  inherited;
  // So we are providing a new config name? If so, clear mapped fields.
  if lbMappedFields.Count > 0 then lbMappedFields.Clear;
end;

procedure TfrmImportExportSystem.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if (fsModal in self.FormState) then
    ModalResult:= mrOk
  else
    Close;  
end;

procedure TfrmImportExportSystem.ImportCSVTABTemplate;
Var SL, SLDetail, SLFrom, SLTo, SLMapData, SLSource, slMapList : TStringList;
   qry : TMyQuery;
   index, i, j : integer;
begin
  SL := TStringList.Create;
  SLDetail := TStringList.Create;
  SLFrom := TStringList.Create;
  SLTo := TStringList.Create;
  SLSource := TStringList.Create;
  //slMapList := TStringList.Create;
  SLMapData := TStringList.Create;

  try
    qry := TMyQuery.Create(nil);
    qry.Options.FlatBuffers := True;
    try
      qry.Connection := CommonDbLib.GetSharedMyDacConnection;
      qry.SQL.Text := 'SELECT * FROM tbladvimpcsvtabtempl T INNER JOIN tbladvimpcsvtabtemplLines TL ON TL.TemplateID = T.advimpcsvtabtemplID WHERE TemplateID = :TemplateID';
      qry.ParamByName('TemplateID').AsInteger := qryTemplates.FieldByName('AdvImpCSVTABtemplID').AsInteger;
      qry.Open;

      while not qry.EOF do begin
        SLSource.Add(qry.FieldByName('FieldName').AsString);
        qry.Next;
      end;

      qry.Close;
    finally
      FreeAndNil(qry);
    end;


    //SLSource := TStringList(lbSourceTableFields.Items);

    slMapList := TStringList(lbMappedFields.Items);

    if FileExists(edtImportFile.Text) then begin
      SL.LoadFromFile(edtImportFile.Text);

      for i := 0 to lbMappedFields.Count - 1 do begin
        ExtractStrings([':'], [' '], PChar(slMapList.Strings[i]), SLMapData);
        SLTo.Add(slMapData.Strings[0]);
        SLFrom.Add(slMapData.Strings[1]);
        SLMapData.Clear;
      end;

      try
        qry := TMyQuery.Create(nil);
        qry.Options.FlatBuffers := True;
        qry.Connection := CommonDbLib.GetSharedMyDacConnection;
        qry.SQL.Text := 'SELECT * FROM tblpartstemporary LIMIT 0';
        qry.Open;

        //first line is a header, do not read it
        for i:= 1 to SL.Count - 1 do begin
          if (cboFileType.Text = 'Tab Delimited') then begin
            SL[i] := '"' + FastFuncs.AnsiStringReplace(SL[i],#9,'","', [rfReplaceAll, rfIgnoreCase]) + '"'; // replace all tabs with commas
          end;

          SL[i] := FastFuncs.AnsiStringReplace(SL[i],' ',#255, [rfReplaceAll, rfIgnoreCase]);

          SLDetail.CommaText := SL[i];

          qry.Append;
          for j := 0 to SLDetail.Count - 1 do begin
            index := SLFrom.IndexOf(SLSource[j]);
            if Index > -1 then
              qry.FieldByName(slTo[index]).AsString := FastFuncs.AnsiStringReplace(SLDetail[j],#255,' ', [rfReplaceAll, rfIgnoreCase]);
          end;
          Try
            qry.Post;
          Except
            on E: EMyError do If not (qry.State in [dsInsert]) then qry.Cancel;
            on E: EMySqlException do If not (qry.State in [dsInsert]) then qry.Cancel;
            else raise;
          end;
        end;

        qry.Close;
      finally
        FreeAndNil(qry);
      end;
    end
    else
      CommonLib.MessageDlgXP_Vista('The file ' + QuotedStr(edtImportFile.Text) + ' does not exist.', mtWarning, [mbOK], 0); 
  finally
    FreeandNil(SLMapData);
    FreeandNil(SLSource);
    FreeandNil(SLFrom);
    FreeandNil(SLTo);
    FreeandNil(SLDetail);
    FreeandNil(SL);
  end;
end;

initialization
  RegisterClassOnce(TfrmImportExportSystem);
end.
