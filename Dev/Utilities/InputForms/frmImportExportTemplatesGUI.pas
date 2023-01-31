unit frmImportExportTemplatesGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts,
  DB,  StdCtrls, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel, MemDS, Mask, wwdbedit,
  Wwdotdot, Wwdbcomb, Grids, Wwdbigrd, Wwdbgrid, wwdblook, kbmMemTable,
  wwcheckbox, DataState, Menus, AdvMenus, Shader;

type
  TfrmImportExportTemplates = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    grdLines: TwwDBGrid;
    DNMPanel3: TDNMPanel;
    Label2: TLabel;
    qryTemplates: TERPQuery;
    cboTemplateName: TwwDBLookupCombo;
    cmdSave: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    qryTemplateLines: TERPQuery;
    dsTemplateLines: TDataSource;
    qryTemplatesID: TIntegerField;
    qryTemplatesTemplateName: TStringField;
    cboFieldType: TwwDBComboBox;
    memLines: TkbmMemTable;
    memLinesFieldName: TStringField;
    memLinesFieldType: TStringField;
    memLinesFieldSize: TIntegerField;
    memLinesFieldStart: TIntegerField;
    memLinesFieldEnd: TIntegerField;
    memLinesFieldDescription: TStringField;
    memLinesGlobalRef: TStringField;
    memLinesID: TIntegerField;
    memLinesTemplateID: TIntegerField;
    btnDelete: TwwIButton;
    dsTemplates: TDataSource;
    qryTemplateLinesID: TIntegerField;
    qryTemplateLinesTemplateID: TIntegerField;
    qryTemplateLinesFieldName: TStringField;
    qryTemplateLinesFieldType: TStringField;
    qryTemplateLinesFieldSize: TIntegerField;
    qryTemplateLinesFieldStart: TIntegerField;
    qryTemplateLinesFieldEnd: TIntegerField;
    qryTemplateLinesFieldDescription: TStringField;
    qryTemplateLinesGlobalRef: TStringField;
    qryTemplateLinesAPrecision: TIntegerField;
    memLinesAPrecision: TIntegerField;
    grdDiscountLines: TwwDBGrid;
    lblDiscountCode: TLabel;
    btnClear: TDNMSpeedButton;
    qryTemplateDiscountLines: TERPQuery;
    dsTemplateDiscountLines: TDataSource;
    btnDeleteCode: TwwIButton;
    memDiscountLines: TkbmMemTable;
    qryTemplateDiscountLinesID: TIntegerField;
    qryTemplateDiscountLinesTemplateID: TIntegerField;
    qryTemplateDiscountLinesGlobalRef: TStringField;
    qryTemplateDiscountLinesDiscountCode: TStringField;
    qryTemplateDiscountLinesDiscPercent1: TFloatField;
    qryTemplateDiscountLinesDiscPercent2: TFloatField;
    qryTemplateDiscountLinesDiscPercent3: TFloatField;
    memDiscountLinesDiscountCode: TStringField;
    memDiscountLinesDiscPercent1: TFloatField;
    memDiscountLinesDiscPercent2: TFloatField;
    memDiscountLinesDiscPercent3: TFloatField;
    memDiscountLinesTemplateID: TIntegerField;
    memDiscountLinesID: TIntegerField;
    memDiscountLinesGlobalRef: TStringField;
    qryTemplateLinesIsDiscount: TStringField;
    memLinesIsDiscount: TStringField;
    qryTemplateDiscountLinesBuyQty1: TIntegerField;
    qryTemplateDiscountLinesBuyQty2: TIntegerField;
    qryTemplateDiscountLinesBuyQty3: TIntegerField;
    memDiscountLinesBuyQty1: TIntegerField;
    memDiscountLinesBuyQty2: TIntegerField;
    memDiscountLinesBuyQty3: TIntegerField;
    Label3: TLabel;
    grdSellMarkups: TwwDBGrid;
    btnDeleteMarkup: TwwIButton;
    dsSellMarkups: TDataSource;
    qrySellPriceMarkups: TERPQuery;
    memSellMarkups: TkbmMemTable;
    qrySellPriceMarkupsID: TIntegerField;
    qrySellPriceMarkupsPriceMarkup1: TFloatField;
    qrySellPriceMarkupsPriceMarkup2: TFloatField;
    qrySellPriceMarkupsPriceMarkup3: TFloatField;
    qrySellPriceMarkupsWholesaleMarkup: TFloatField;
    qrySellPriceMarkupsTemplateID: TIntegerField;
    memSellMarkupsID: TIntegerField;
    memSellMarkupsPriceMarkup1: TFloatField;
    memSellMarkupsPriceMarkup2: TFloatField;
    memSellMarkupsPriceMarkup3: TFloatField;
    memSellMarkupsWholesaleMarkup: TFloatField;
    memSellMarkupsTemplateID: TIntegerField;
    qrySellPriceMarkupsQty1: TIntegerField;
    qrySellPriceMarkupsQty2: TIntegerField;
    qrySellPriceMarkupsQty3: TIntegerField;
    memSellMarkupsQty1: TIntegerField;
    memSellMarkupsQty2: TIntegerField;
    memSellMarkupsQty3: TIntegerField;
    memSellMarkupsGlobalRef: TStringField;
    qrySellPriceMarkupsGlobalRef: TStringField;
    qryClientType: TERPQuery;
    qrySellPriceMarkupsCustomerTypeID: TIntegerField;
    qrySellPriceMarkupsCustomerTypeName: TStringField;
    memSellMarkupsCustomerTypeID: TIntegerField;
    memSellMarkupsCustomerTypeName: TStringField;
    cboClientType: TwwDBLookupCombo;
    qryClientTypeClientTypeID: TIntegerField;
    qryClientTypeTypeName: TStringField;
    Label4: TLabel;
    cboClonePart: TwwDBLookupCombo;
    qryPart: TERPQuery;
    qryTemplatesClonePartID: TIntegerField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure memLinesBeforePost(DataSet: TDataSet);
    procedure cboTemplateNameNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure grdLinesExit(Sender: TObject);
    procedure cboTemplateNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure memLinesFieldSizeChange(Sender: TField);
    procedure btnClearClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure memLinesFieldTypeChange(Sender: TField);
    procedure btnDeleteCodeClick(Sender: TObject);
    procedure memLinesIsDiscountChange(Sender: TField);
    procedure memDiscountLinesDiscPercent2Change(Sender: TField);
    procedure memDiscountLinesDiscPercent1Change(Sender: TField);
    procedure memDiscountLinesDiscPercent3Change(Sender: TField);
    procedure memDiscountLinesBuyQty1Change(Sender: TField);
    procedure memDiscountLinesBuyQty2Change(Sender: TField);
    procedure memDiscountLinesBuyQty3Change(Sender: TField);
    procedure qryTemplateDiscountLinesAfterOpen(DataSet: TDataSet);
    procedure qryTemplateLinesAfterOpen(DataSet: TDataSet);
    procedure memSellMarkupsQty1Change(Sender: TField);
    procedure memSellMarkupsQty2Change(Sender: TField);
    procedure memSellMarkupsQty3Change(Sender: TField);
    procedure btnDeleteMarkupClick(Sender: TObject);
    procedure qryClientTypeAfterOpen(DataSet: TDataSet);
    procedure cboClientTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure memSellMarkupsPriceMarkup1Change(Sender: TField);
    procedure memSellMarkupsPriceMarkup2Change(Sender: TField);
    procedure memSellMarkupsPriceMarkup3Change(Sender: TField);
    procedure qryPartAfterOpen(DataSet: TDataSet);
    procedure cboClonePartNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);

  private
    { Private declarations }
    fbInitialising: boolean;
    fbChangingPrecision: boolean;
    fbUpdating: boolean;
    procedure CalcFieldStartEndStats;
    procedure SaveTemplateDetails;
    procedure CheckForDiscountEditing;
    
  public
    { Public declarations }
    

  end;

//var
//  frmImportExportTemplates: TfrmImportExportTemplates;

implementation

{$R *.dfm}

uses
  CommonDbLib, DNMExceptions,  AppEnvironment, CommonLib;

procedure TfrmImportExportTemplates.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmImportExportTemplates.FormCreate(Sender: TObject);
begin
  Self.fbIgnoreAccessLevels := true;
  inherited;
  // Set this to false so we can use tab features on form.
  fbTabSettingEnabled := false;
  fbChangingPrecision := false;
  fbUpdating := false;
  qryTemplates.Connection := CommonDbLib.GetSharedMyDacConnection;
end;

procedure TfrmImportExportTemplates.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      fbInitialising           := true;
      qryClientType.Connection := CommonDbLib.GetSharedMyDacConnection;

      inherited;

      OpenQueries;

      // Are we reviewing a preset template?
      if KeyID <> 0 then begin
        // Locate and Setup.
        if qryTemplates.Locate('ID', KeyID, [loCaseInsensitive]) then begin
          cboTemplateName.Text := qryTemplates.FieldByName('TemplateName').AsString;
          cboTemplateNameCloseUp(Sender, qryTemplates, nil, true);
          cboTemplateName.Enabled := false;
        end;

        // Locate the clone part id if one has been choosen.
        if qryTemplates.FieldByName('ClonePartID').AsInteger <> 0 then begin
          if qryPart.Locate('PARTSID', qryTemplates.FieldByName('ClonePartID').AsVariant, [loCaseInsensitive]) then begin
            cboClonePart.Text := qryPart.FieldByName('PartName').AsString;
          end;
        end;
      end;

      // Exception Handler
    except
      // Handle these known exceptions.
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else raise;
    end;

    fbInitialising := false;
  finally
    EnableForm;
  end;  
end;

procedure TfrmImportExportTemplates.cmdSaveClick(Sender: TObject);
begin
  inherited;
  // Save Run Details.
  SaveTemplateDetails;
  // Close form and return status.
  ModalResult := mrOk;
end;

procedure TfrmImportExportTemplates.cmdCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfrmImportExportTemplates.memLinesBeforePost(DataSet: TDataSet);
begin
  inherited;
  memLines.FieldByName('TemplateID').AsInteger := qryTemplates.FieldByName('ID').AsInteger;
end;

procedure TfrmImportExportTemplates.cboTemplateNameNotInList(Sender: TObject; LookupTable: TDataSet;
  NewValue: string; var Accept: boolean);
begin
  inherited;
  LookupTable.Insert;
  LookupTable.FieldByName('TemplateName').AsString := NewValue;
  LookupTable.Post;
  Accept := true;
  Application.ProcessMessages;

  // Now select this new template as the one to edit.
  fbInitialising := true;
  qryTemplateLines.Close;
  qryTemplateLines.ParamCheck := true;
  qryTemplateLines.Params.ParamByName('xTemplateID').AsInteger := qryTemplates.FieldByName('ID').AsInteger;
  qryTemplateLines.Open;

  memLines.LoadFromDataSet(qryTemplateLines, []);

  qryTemplateDiscountLines.Close;
  qryTemplateDiscountLines.ParamCheck := true;
  qryTemplateDiscountLines.Params.ParamByName('xTemplateID').AsInteger := qryTemplates.FieldByName('ID').AsInteger;
  qryTemplateDiscountLines.Open;

  memDiscountLines.LoadFromDataSet(qryTemplateDiscountLines, []);

  cmdSave.Enabled := true;
  fbInitialising := false;
end;

procedure TfrmImportExportTemplates.CalcFieldStartEndStats;
var
  iX: integer;
  bFirst: boolean;
  memCopy: TKbmMemTable;
  sFieldName, sFieldType: string;
begin
  memLines.DisableControls;
  memCopy := TKbmMemTable.Create(nil);
  try
    fbInitialising := true;
    sFieldName     := memLines.FieldByName('FieldName').AsString;
    sFieldType     := memLines.FieldByName('FieldType').AsString;
    
    memCopy.LoadFromDataSet(memLines, [mtcpoStructure, mtcpoProperties]);

    iX     := 1;
    bFirst := true;
    while not memCopy.Eof do begin
      memCopy.Edit;
      if bFirst then begin
        memCopy.FieldByName('FieldStart').AsInteger := iX;
        memCopy.FieldByName('FieldEnd').AsInteger := (iX + memCopy.FieldByName('FieldSize').AsInteger) - 1;
        bFirst := false;
      end else begin
        if memCopy.FieldByName('FieldSize').AsInteger > 0 then begin
          memCopy.FieldByName('FieldStart').AsInteger := iX;
          memCopy.FieldByName('FieldEnd').AsInteger := (iX + memCopy.FieldByName('FieldSize').AsInteger) - 1;
        end;
      end;

      // Fetch next Record.
      iX := iX + memCopy.FieldByName('FieldSize').AsInteger;
      memCopy.Next;
    end;

    memLines.LoadFromDataSet(memCopy, []);
    Application.ProcessMessages;
    memLines.Locate('FieldName;FieldType', VarArrayOf([sFieldName, sFieldType]), [loCaseInsensitive]);
    memLines.EnableControls;
    memLines.Edit;

    fbInitialising := false;
  finally
    // Free our used objects.
    if Assigned(memCopy) then
      FreeandNil(memCopy);
  end;
end;

procedure TfrmImportExportTemplates.grdLinesExit(Sender: TObject);
begin
  inherited;
  if memLines.Active then begin
    if memLines.State = dsEdit then begin
      memLines.Post;
    end;
  end;
end;

procedure TfrmImportExportTemplates.cboTemplateNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
  Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if cboTemplateName.Text = '' then Exit;
  if qryTemplateLines.Active then begin
    SaveTemplateDetails;
  end;

  fbInitialising := true;
  qryTemplateLines.Close;
  qryTemplateLines.ParamCheck := true;
  qryTemplateLines.Params.ParamByName('xTemplateID').AsInteger := qryTemplates.FieldByName('ID').AsInteger;
  qryTemplateLines.Open;

  // Store our fetch data to our memory table.
  memLines.LoadFromDataSet(qryTemplateLines, []);

  ////////////////////////////////////////////////
  // Now retrieve our known stored discount codes
  ////////////////////////////////////////////////
  qryTemplateDiscountLines.Close;
  qryTemplateDiscountLines.ParamCheck := true;
  qryTemplateDiscountLines.Params.ParamByName('xTemplateID').AsInteger := qryTemplates.FieldByName('ID').AsInteger;
  qryTemplateDiscountLines.Open;

  memDiscountLines.LoadFromDataSet(qryTemplateDiscountLines, []);

  ////////////////////////////////////////////////
  // Now retrieve our known Sell Markups
  ////////////////////////////////////////////////
  qrySellPriceMarkups.Close;
  qrySellPriceMarkups.ParamCheck := true;
  qrySellPriceMarkups.Params.ParamByName('xTemplateID').AsInteger := qryTemplates.FieldByName('ID').AsInteger;
  qrySellPriceMarkups.Open;

  memSellMarkups.LoadFromDataSet(qrySellPriceMarkups, []);

  cmdSave.Enabled := true;
  fbInitialising := false;
  // Determine if we are enabling discount editing
  CheckForDiscountEditing;
end;

procedure TfrmImportExportTemplates.memLinesFieldSizeChange(Sender: TField);
begin
  if fbInitialising then Exit;
  CalcFieldStartEndStats;
end;

procedure TfrmImportExportTemplates.btnClearClick(Sender: TObject);
begin
  inherited;
  fbInitialising := true;
  memLines.DisableControls;
  memLines.EmptyTable;
  memLines.EnableControls;

  memSellMarkups.DisableControls;
  memSellMarkups.EmptyTable;
  memSellMarkups.EnableControls;

  memDiscountLines.DisableControls;
  memDiscountLines.EmptyTable;
  memDiscountLines.EnableControls;
  fbInitialising := false;
end;

procedure TfrmImportExportTemplates.btnDeleteClick(Sender: TObject);
begin
  inherited;
  // Delete record.
  memLines.Delete;
end;

procedure TfrmImportExportTemplates.memLinesFieldTypeChange(Sender: TField);
begin
  inherited;
  if (memLines.FieldByName('APrecision').IsNull) or
    (memLines.FieldByName('APrecision').AsString = '') then begin
    memLines.FieldByName('APrecision').AsInteger := 0;
  end;
end;

// Save the template details.
procedure TfrmImportExportTemplates.SaveTemplateDetails;
var
  iTemplateID: integer;
begin
  // Get template record ID
  iTemplateID := qryTemplates.FieldByName('ID').AsInteger;

  // If a part has been selected for cloning then store its related ID.
  if cboClonePart.Text <> '' then begin
    qryTemplates.Edit;
    qryTemplates.FieldByName('ClonePartID').AsInteger := qryPart.FieldByName('PartsID').AsInteger;
    qryTemplates.Post;
  end;
  
  // Goto first record.
  qryTemplateLines.First;
  while not qryTemplateLines.Eof do begin
    // Delete Record.
    qryTemplateLines.Delete;
  end;

  // Save our File Template Data
  if memLines.Active then begin
    // Disable all binded data-aware control.
    memLines.DisableControls;
    // Goto our first record.
    memLines.First;
    while not memLines.Eof do begin
      // Create new record.
      qryTemplateLines.Insert;
      qryTemplateLines.FieldByName('FieldName').AsString := memLines.FieldByName('FieldName').AsString;
      qryTemplateLines.FieldByName('FieldType').AsString := memLines.FieldByName('FieldType').AsString;
      qryTemplateLines.FieldByName('IsDiscount').AsString := memLines.FieldByName('IsDiscount').AsString;
      qryTemplateLines.FieldByName('FieldSize').AsInteger := memLines.FieldByName('FieldSize').AsInteger;
      qryTemplateLines.FieldByName('APrecision').AsInteger := memLines.FieldByName('APrecision').AsInteger;
      qryTemplateLines.FieldByName('FieldStart').AsInteger := memLines.FieldByName('FieldStart').AsInteger;
      qryTemplateLines.FieldByName('FieldEnd').AsInteger := memLines.FieldByName('FieldEnd').AsInteger;
      qryTemplateLines.FieldByName('FieldDescription').AsString := memLines.FieldByName('FieldDescription').AsString;
      qryTemplateLines.FieldByName('TemplateID').AsInteger := iTemplateID;
      qryTemplateLines.Post;
      qryTemplateLines.Edit;
      qryTemplateLines.FieldByName('GlobalRef').AsString := AppEnv.Branch.SiteCode + qryTemplateLines.FieldByName('ID').AsString;
      qryTemplateLines.Post;
      // Fetch next record.
      memLines.Next;
    end;
    // Re-enable all binded data-aware controls.
    memLines.EnableControls;
  end;

  // Now save our known discount lines.
  if memDiscountLines.Active then begin
    // Goto first record.
    qryTemplateDiscountLines.First;
    while not qryTemplateDiscountLines.Eof do begin
      // Delete Record.
      qryTemplateDiscountLines.Delete;
    end;

    // Disable all binded data-aware controls.
    memDiscountLines.DisableControls;
    // Goto first record.
    memDiscountLines.First;
    while not memDiscountLines.Eof do begin
      // Create new discount record.
      qryTemplateDiscountLines.Insert;
      qryTemplateDiscountLines.FieldByName('DiscountCode').AsString := memDiscountLines.FieldByName('DiscountCode').AsString;
      qryTemplateDiscountLines.FieldByName('BuyQty1').AsInteger := memDiscountLines.FieldByName('BuyQty1').AsInteger;
      qryTemplateDiscountLines.FieldByName('BuyQty2').AsInteger := memDiscountLines.FieldByName('BuyQty2').AsInteger;
      qryTemplateDiscountLines.FieldByName('BuyQty3').AsInteger := memDiscountLines.FieldByName('BuyQty3').AsInteger;
      qryTemplateDiscountLines.FieldByName('DiscPercent1').AsFloat := memDiscountLines.FieldByName('DiscPercent1').AsFloat;
      qryTemplateDiscountLines.FieldByName('DiscPercent2').AsFloat := memDiscountLines.FieldByName('DiscPercent2').AsFloat;
      qryTemplateDiscountLines.FieldByName('DiscPercent3').AsFloat := memDiscountLines.FieldByName('DiscPercent3').AsFloat;
      qryTemplateDiscountLines.FieldByName('TemplateID').AsInteger := iTemplateID;
      qryTemplateDiscountLines.Post;
      qryTemplateDiscountLines.Edit;
      qryTemplateDiscountLines.FieldByName('GlobalRef').AsString :=
        AppEnv.Branch.SiteCode + qryTemplateDiscountLines.FieldByName('ID').AsString;
      qryTemplateDiscountLines.Post;
      // Fetch next record.
      memDiscountLines.Next;
    end;
    // Re-enable data-aware controls.
    memDiscountLines.EnableControls;
  end;

  // Now save our Known Sell Markups.
  if memSellMarkups.Active then begin
    qrySellPriceMarkups.First;
    // Goto first record.
    while not qrySellPriceMarkups.Eof do begin
      // Delete Record.
      qrySellPriceMarkups.Delete;
    end;

    // Disable all binded data-aware controls.
    memSellMarkups.DisableControls;
    // Goto first record.
    memSellMarkups.First;
    while not memSellMarkups.Eof do begin
      // Create new discount record.
      qrySellPriceMarkups.Insert;
      qrySellPriceMarkups.FieldByName('CustomerTypeID').AsInteger := memSellMarkups.FieldByName('CustomerTypeID').AsInteger;
      qrySellPriceMarkups.FieldByName('CustomerTypeName').AsString := memSellMarkups.FieldByName('CustomerTypeName').AsString;
      qrySellPriceMarkups.FieldByName('Qty1').AsInteger := memSellMarkups.FieldByName('Qty1').AsInteger;
      qrySellPriceMarkups.FieldByName('PriceMarkup1').AsFloat := memSellMarkups.FieldByName('PriceMarkup1').AsFloat;
      qrySellPriceMarkups.FieldByName('Qty2').AsInteger := memSellMarkups.FieldByName('Qty2').AsInteger;
      qrySellPriceMarkups.FieldByName('PriceMarkup2').AsFloat := memSellMarkups.FieldByName('PriceMarkup2').AsFloat;
      qrySellPriceMarkups.FieldByName('Qty3').AsInteger := memSellMarkups.FieldByName('Qty3').AsInteger;
      qrySellPriceMarkups.FieldByName('PriceMarkup3').AsFloat := memSellMarkups.FieldByName('PriceMarkup3').AsFloat;
      qrySellPriceMarkups.FieldByName('TemplateID').AsInteger := iTemplateID;
      qrySellPriceMarkups.Post;
      qrySellPriceMarkups.Edit;
      qrySellPriceMarkups.FieldByName('GlobalRef').AsString :=
        AppEnv.Branch.SiteCode + qryTemplateDiscountLines.FieldByName('ID').AsString;
      qrySellPriceMarkups.Post;
      // Fetch next record.
      memSellMarkups.Next;
    end;
    // Re-enable data-aware controls.
    memSellMarkups.EnableControls;
  end;
end;

procedure TfrmImportExportTemplates.btnDeleteCodeClick(Sender: TObject);
begin
  inherited;
  // Delete record.
  memDiscountLines.Delete;
end;

procedure TfrmImportExportTemplates.memLinesIsDiscountChange(Sender: TField);
var
  iRecID: integer;
begin
  // If the field was unchecked then no need, just exit.
  if fbInitialising then Exit;
  // Has the field been unchecked?
  if Sender.AsString = 'F' then begin
    // Yes, disable Discount Editor.
    lblDiscountCode.Enabled     := false;
    grdDiscountLines.Enabled    := false;
    grdDiscountLines.TitleColor := $00CDCDCD;
    grdDiscountLines.Color      := $00BCBCBC;
    // We are done.
    Exit;
  end;

  iRecID := memLines.FieldByName('ID').AsInteger;

  memLines.DisableControls;
  memLines.First;
  while not memLines.Eof do begin
    // Is this the record that was just checked?
    if memLines.FieldByName('ID').AsInteger = iRecID then begin
      // Yes, then get next record and move on.
      memLines.Next;
      // Moving on ...
      Continue;
    end;

    // Uncheck Is Discount field.
    memLines.Edit;
    memLines.FieldByName('IsDiscount').AsString := 'F';
    memLines.Post;

    // Fetch next record.
    memLines.Next;
  end;

  memLines.Locate('ID', iRecID, [loCaseInsensitive]);
  memLines.EnableControls;
  memLines.Edit;
  lblDiscountCode.Enabled := true;
  grdDiscountLines.Enabled := true;
  grdDiscountLines.TitleColor := $00EFEFEF;
  grdDiscountLines.Color := clWhite;
end;

procedure TfrmImportExportTemplates.memDiscountLinesDiscPercent2Change(Sender: TField);
begin
  // if we are updating discounts then exit to prevent
  // recursive event firing.
  if fbInitialising then Exit;
  if fbUpdating then Exit;
  // State we are performing the update check.
  fbUpdating := true;
  // Check Discount entries.
  if Sender.AsFloat < memDiscountLines.FieldByName('DiscPercent1').AsFloat then begin
    Sender.AsFloat := memDiscountLines.FieldByName('DiscPercent1').AsFloat;
  end;

  // State that the update check has finished.
  fbUpdating := false;
end;

procedure TfrmImportExportTemplates.memDiscountLinesDiscPercent1Change(Sender: TField);
begin
  // if we are updating discounts then exit to prevent
  // recursive event firing.
  if fbInitialising then Exit;
  if fbUpdating then Exit;
  // State we are performing the update check.
  fbUpdating := true;
  // Check Discount entries.
  if Sender.AsFloat > memDiscountLines.FieldByName('DiscPercent2').AsFloat then begin
    memDiscountLines.FieldByName('DiscPercent2').AsFloat := Sender.AsFloat;
    memDiscountLines.FieldByName('DiscPercent3').AsFloat := Sender.AsFloat;
  end;

  // State that the update check has finished.
  fbUpdating := false;
end;

procedure TfrmImportExportTemplates.memDiscountLinesDiscPercent3Change(Sender: TField);
begin
  // if we are updating discounts then exit to prevent
  // recursive event firing.
  if fbInitialising then Exit;
  if fbUpdating then Exit;
  // State we are performing the update check.
  fbUpdating := true;
  // Check Discount entries.
  if Sender.AsFloat < memDiscountLines.FieldByName('DiscPercent2').AsFloat then begin
    Sender.AsFloat := memDiscountLines.FieldByName('DiscPercent2').AsFloat;
  end;

  // State that the update check has finished.
  fbUpdating := false;
end;

procedure TfrmImportExportTemplates.memDiscountLinesBuyQty1Change(Sender: TField);
begin
  // if we are updating discounts then exit to prevent
  // recursive event firing.
  if fbInitialising then Exit;
  if fbUpdating then Exit;
  // State we are performing the update check.
  fbUpdating := true;
  // Check Quantity entries.
  if Sender.AsInteger > memDiscountLines.FieldByName('BuyQty2').AsInteger then begin
    memDiscountLines.FieldByName('BuyQty2').AsFloat := Sender.AsFloat;
    memDiscountLines.FieldByName('BuyQty3').AsFloat := Sender.AsFloat;
  end;

  // State that the update check has finished.
  fbUpdating := false;
end;

procedure TfrmImportExportTemplates.memDiscountLinesBuyQty2Change(Sender: TField);
begin
  // if we are updating discounts then exit to prevent
  // recursive event firing.
  if fbInitialising then Exit;
  if fbUpdating then Exit;
  // State we are performing the update check.
  fbUpdating := true;
  // Check Quantity entries.
  if Sender.AsInteger < memDiscountLines.FieldByName('BuyQty1').AsInteger then begin
    Sender.AsInteger := memDiscountLines.FieldByName('BuyQty1').AsInteger;
  end;

  // State that the update check has finished.
  fbUpdating := false;
end;

procedure TfrmImportExportTemplates.memDiscountLinesBuyQty3Change(Sender: TField);
begin
  // if we are updating discounts then exit to prevent
  // recursive event firing.
  if fbInitialising then Exit;
  if fbUpdating then Exit;
  // State we are performing the update check.
  fbUpdating := true;
  // Check Quantity entries.
  if Sender.AsInteger < memDiscountLines.FieldByName('BuyQty2').AsInteger then begin
    Sender.AsInteger := memDiscountLines.FieldByName('BuyQty2').AsInteger;
  end;

  // State that the update check has finished.
  fbUpdating := false;
end;

procedure TfrmImportExportTemplates.CheckForDiscountEditing;
var
  iRecID: integer;
begin
  iRecID := memLines.FieldByName('ID').AsInteger;
  memLines.DisableControls;
  memLines.First;
  while not memLines.Eof do begin
    if memLines.FieldByName('IsDiscount').AsString = 'T' then begin
      grdDiscountLines.TitleColor := $00EFEFEF;
      grdDiscountLines.Color := clWhite;
      grdDiscountLines.Enabled := true;
      lblDiscountCode.Enabled := true;
      memLines.Locate('ID', iRecID, [loCaseInsensitive]);
      memLines.EnableControls;
      Exit;
    end;

    // Fetch next record.
    memLines.Next;
  end;

  grdDiscountLines.TitleColor := $00CDCDCD;
  grdDiscountLines.Color := $00BCBCBC;
  grdDiscountLines.Enabled := false;
  lblDiscountCode.Enabled := false;
  memLines.Locate('ID', iRecID, [loCaseInsensitive]);
  memLines.EnableControls;
end;

procedure TfrmImportExportTemplates.qryTemplateDiscountLinesAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryTemplateDiscountLines.IndexFieldNames := 'DiscountCode ASC CIS';
end;

procedure TfrmImportExportTemplates.qryTemplateLinesAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryTemplateLines.IndexFieldNames := 'FieldStart ASC CIS';
end;

procedure TfrmImportExportTemplates.memSellMarkupsQty1Change(Sender: TField);
begin
  inherited;
  // if we are updating discounts then exit to prevent
  // recursive event firing.
  if fbInitialising then Exit;
  if fbUpdating then Exit;
  // State we are performing the update check.
  fbUpdating := true;
  // Check Quantity entries.
  if Sender.AsInteger > memSellMarkups.FieldByName('Qty2').AsInteger then begin
    memSellMarkups.FieldByName('Qty2').AsFloat := Sender.AsFloat;
    memSellMarkups.FieldByName('Qty3').AsFloat := Sender.AsFloat;
  end;

  // State that the update check has finished.
  fbUpdating := false;
end;

procedure TfrmImportExportTemplates.memSellMarkupsQty2Change(Sender: TField);
begin
  inherited;
  // if we are updating discounts then exit to prevent
  // recursive event firing.
  if fbInitialising then Exit;
  if fbUpdating then Exit;
  // State we are performing the update check.
  fbUpdating := true;
  // Check Quantity entries.
  if Sender.AsInteger < memSellMarkups.FieldByName('Qty1').AsInteger then begin
    Sender.AsInteger := memSellMarkups.FieldByName('Qty1').AsInteger;
  end;

  // State that the update check has finished.
  fbUpdating := false;
end;

procedure TfrmImportExportTemplates.memSellMarkupsQty3Change(Sender: TField);
begin
  inherited;
  // if we are updating discounts then exit to prevent
  // recursive event firing.
  if fbInitialising then Exit;
  if fbUpdating then Exit;
  // State we are performing the update check.
  fbUpdating := true;
  // Check Quantity entries.
  if Sender.AsInteger < memSellMarkups.FieldByName('Qty2').AsInteger then begin
    Sender.AsInteger := memSellMarkups.FieldByName('Qty2').AsInteger;
  end;

  // State that the update check has finished.
  fbUpdating := false;
end;

procedure TfrmImportExportTemplates.btnDeleteMarkupClick(Sender: TObject);
begin
  inherited;
  // Delete Record.
  memSellMarkups.Delete;
end;

procedure TfrmImportExportTemplates.qryClientTypeAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryClientType.IndexFieldNames := 'TypeName ASC CIS';
end;

procedure TfrmImportExportTemplates.cboClientTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
  Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  FillTable.Edit;
  FillTable.FieldByName('CustomerTypeID').AsInteger := LookupTable.FieldByName('ClientTypeID').AsInteger;
end;

procedure TfrmImportExportTemplates.memSellMarkupsPriceMarkup1Change(Sender: TField);
begin
  inherited;
  // if we are updating discounts then exit to prevent
  // recursive event firing.
  if fbInitialising then Exit;
  if fbUpdating then Exit;

  // State we are performing the update check.
  fbUpdating := true;

  // Check Discount entries.
  if Sender.AsFloat > memSellMarkups.FieldByName('PriceMarkup2').AsFloat then begin
    memSellMarkups.FieldByName('PriceMarkup2').AsFloat := Sender.AsFloat;
    memSellMarkups.FieldByName('PriceMarkup3').AsFloat := Sender.AsFloat;
  end;

  // State that the update check has finished.
  fbUpdating := false;
end;

procedure TfrmImportExportTemplates.memSellMarkupsPriceMarkup2Change(Sender: TField);
begin
  inherited;
  // if we are updating discounts then exit to prevent
  // recursive event firing.
  if fbInitialising then Exit;
  if fbUpdating then Exit;

  // State we are performing the update check.
  fbUpdating := true;

  // Check Discount entries.
  if Sender.AsFloat < memSellMarkups.FieldByName('PriceMarkup1').AsFloat then begin
    Sender.AsFloat := memSellMarkups.FieldByName('PriceMarkup1').AsFloat;
  end;

  // State that the update check has finished.
  fbUpdating := false;
end;

procedure TfrmImportExportTemplates.memSellMarkupsPriceMarkup3Change(Sender: TField);
begin
  inherited;
  // if we are updating discounts then exit to prevent
  // recursive event firing.
  if fbInitialising then Exit;
  if fbUpdating then Exit;

  // State we are performing the update check.
  fbUpdating := true;

  // Check Discount entries.
  if Sender.AsFloat < memSellMarkups.FieldByName('PriceMarkup2').AsFloat then begin
    Sender.AsFloat := memSellMarkups.FieldByName('PriceMarkup2').AsFloat;
  end;

  // State that the update check has finished.
  fbUpdating := false;
end;

procedure TfrmImportExportTemplates.qryPartAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryPart.IndexFieldNames := 'PARTNAME ASC CIS';
end;

procedure TfrmImportExportTemplates.cboClonePartNotInList(Sender: TObject; LookupTable: TDataSet;
  NewValue: string; var Accept: boolean);
begin
  inherited;
  Accept := false;
end;

initialization
  RegisterClassOnce(TfrmImportExportTemplates);

end.
