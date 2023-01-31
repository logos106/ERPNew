unit CustomizePOSGUI;

interface
{$I ERP.inc}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls,AdvOfficeStatusBar, StdCtrls, Buttons, DNMSpeedButton, POSBtnMatrixObj, BaseInputForm,
  DB,  DBCtrls, Grids, DBGrids, Wwdbigrd, Wwdbgrid, wwdblook, MemDS,
  DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, DataState, Menus, AdvMenus, Shader,
  DNMPanel, ImgList, ProgressDialog,  POSConst;




var
  iChosenIndex: integer;   // populated by POSChgPadGUI etc

type
  TFnAccess = record
    FnID: integer;
    HasAccess: integer;
  end;

type
  TCustomizePOSForm = class(TBaseInputGUI)
    POSButtonsPanel: TPanel;
    Bevel1: TBevel;
    barTopText: TTrackBar;

    Label1: TLabel;
    edtLine1: TEdit;
    edtLine2: TEdit;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lblLocn: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    dlgFont: TFontDialog;
    Label18: TLabel;
    lblFontTest: TStaticText;
    btnFont: TDNMSpeedButton;
    Bevel4: TBevel;
    btnFontColour: TDNMSpeedButton;
    btnBgColour: TDNMSpeedButton;
    pnlFontColour: TPanel;
    pnlBgColour: TPanel;
    Label19: TLabel;
    Label20: TLabel;
    Bevel5: TBevel;
    Label21: TLabel;
    dlgColour: TColorDialog;
    Bevel6: TBevel;
    Label22: TLabel;
    edtHotKey: TEdit;
    Bevel8: TBevel;
    Label23: TLabel;
    Bevel7: TBevel;
    rbtProduct: TRadioButton;
    rbtFunction: TRadioButton;
    Label25: TLabel;
    Label26: TLabel;
    lblFunction: TLabel;
    lblGroup: TLabel;
    btnReset: TDNMSpeedButton;
    btnResetAll: TDNMSpeedButton;
    lblDefaultFont: TLabel;
    Bevel9: TBevel;
    dscParts: TDataSource;
    dscOtherFn: TDataSource;
    grdFunc: TwwDBGrid;
    btnProdList: TDNMSpeedButton;
    edtPartID: TEdit;
    btnCancel: TDNMSpeedButton;
    Bevel10: TBevel;
    cboKeypad: TComboBox;
    btnKeypads: TDNMSpeedButton;
    Bevel11: TBevel;
    lblPadTitle: TLabel;
    btnSave: TDNMSpeedButton;
    btnCopy: TDNMSpeedButton;
    btnPaste: TDNMSpeedButton;
    dlgSave: TSaveDialog;
    dlgOpen: TOpenDialog;
    btnTills: TDNMSpeedButton;
    Bevel12: TBevel;
    dsFuncRooms: TDataSource;
    dsFuncRooms2: TDataSource;
    qryFuncRooms: TERPQuery;
    qryFuncRooms2: TERPQuery;
    qryPads: TERPQuery;
    qryParts: TERPQuery;
    qryOtherFn: TERPQuery;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    edtSearch: TEdit;
    lblSearch: TLabel;
    optSelection: TRadioGroup;
    QryUOMs: TERPQuery;
    dsUOMs: TDataSource;
    DNMSpeedButton1: TDNMSpeedButton;
    Bevel13: TBevel;
    Bevel14: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure barTopTextChange(Sender: TObject);
    procedure PanelBtnClick(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure edtLine1KeyPress(Sender: TObject; var Key: char);
    procedure edtLine1Exit(Sender: TObject);
    procedure edtLine2KeyPress(Sender: TObject; var Key: char);
    procedure edtLine2Exit(Sender: TObject);
    procedure btnFontColourClick(Sender: TObject);
    procedure btnBgColourClick(Sender: TObject);
    procedure edtHotKeyKeyPress(Sender: TObject; var Key: char);
    procedure edtHotKeyExit(Sender: TObject);
    procedure rbtProductClick(Sender: TObject);
    procedure rbtFunctionClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure btnResetAllClick(Sender: TObject);
    procedure grdFuncDblClick(Sender: TObject);
    procedure btnProdListClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtPartIDChange(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cboKeypadChange(Sender: TObject);
    procedure btnKeypadsClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure btnPasteClick(Sender: TObject);
    procedure btnTillsClick(Sender: TObject);
    procedure qryPartsAfterOpen(DataSet: TDataSet);
    procedure qryPartsBeforeOpen(DataSet: TDataSet);
    procedure grdFuncKeyPress(Sender: TObject; var Key: char);
    procedure grdFuncMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edtSearchKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure optSelectionClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    bIsChanged: boolean;  // True if change made
    oBtnMatrix: TPOSBtnMatrix;
    KeyfieldName:String;
    ayiKeypadID: array[0..MAX_KEYPAD - 1] of integer;
    figroupID :Integer;
    procedure LoadProdList(const iPartID: integer = 0);
    procedure LoadOtherList(const iFn: integer);
    procedure LoadUOMs(const sUOMName:String='');
    procedure InitFnListBox;
    procedure UpdateControls;
    procedure SetBtnToGridPart;
    Procedure SetBtnToGridUOM;
    procedure SetBtnToGridGroup;
    procedure SetBtnToFn(const iFn: integer);
    procedure SetBtnToGridFn;
    procedure PopulatePadCombo;
    procedure LoadKeypad(const iKeypadID: integer);
    procedure SaveKeypad(const iKeypadID: integer);
    procedure OnProductSelect(Sender: TwwDbGrid);
    Procedure Selectgrooup(Sender: TwwDbGrid) ;
    procedure ProcessSelection;
    Procedure FixedAmountentry(const FunctionID: Integer; functioname , functionDesc :String; Oldvalue:Double);
  public
    { Public declarations }

//    procedure Notify; override;
    // -----------------
    // Daniel: 16/3/2004
    // -----------------
    function LocateChangeButton(const KeypadMainID, KeypadToID: integer): boolean;
    function CreateNewChangeButton(const KeypadID, KeypadToID: integer; const PadName: string): boolean;
    // -----------------
  end;

var
  CustomizePOSForm: TCustomizePOSForm;

implementation

{$R *.DFM}

uses
  ProductListForm, POSScreenGUI, POSChgPadGUI,
  POSEditPadsGUI, DNMExceptions, CommonDbLib, POSSalesmanGUI,
  POSTillsGUI, POSMemoGUI, CommonLib, FastFuncs,
  BusobjProdAttribGroup, BusObjBase, ProdAttribGroups,
  POSTableSelector,FuncRoomForm,TableManagementForm,tcDataUtils, tcConst,
  CommonFormLib;

const
  A_ASCII     = 65;
  CR_ASCII    = 13;
  CR          = #13;
  TAB         = #9;
  Null_Str    = #0;
  BS_Str      = #8;
  NO_FUNC     = 'No Function Set';
  PRIMARY_PAD = 1;  // id of primary keypad

  // Colours
  CL_CANARY    = $0080FFFF;
  CL_NICE_BLUE = $00C8996A;

procedure TCustomizePOSForm.FormCreate(Sender: TObject);
begin
  inherited;
  fbTabSettingEnabled := false;

  // Initialize funcGrid options
  grdFunc.Options := grdFunc.Options + [dgRowSelect];

  // Connection strings for queries
  qryParts.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryOtherFn.Connection := CommonDbLib.GetSharedMyDacConnection;
  QryUOMs.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryFuncRooms.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryFuncRooms2.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryPads.Connection := CommonDbLib.GetSharedMyDacConnection;
  lblFunction.Caption := NO_FUNC;
end;

procedure TCustomizePOSForm.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    figroupID := 0;
    Processingcursor(true);
    try
      try
        inherited;

        // Create the POS button matrix with buttons that will stay down when selected
        oBtnMatrix := TPOSBtnMatrix.Create(POSButtonsPanel, lblDefaultFont.Font, true);
        oBtnMatrix.KeypadID := PRIMARY_PAD;

        // Load variable button details from file
        if not oBtnMatrix.LoadFromDB then CommonLib.MessageDlgXP_Vista('Could not load primary Keypad from Database',
            mtWarning, [mbOK], 0);

        oBtnMatrix.SelectButton(1, 1);
        PopulatePadCombo;

        //### Open Stuff ##
        qryPads.Open;
        qryFuncRooms.Open;
        qryFuncRooms2.Open;

        // Get all the part details
        with qryParts do begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT PARTSID, PARTTYPE, ' +
            'PARTNAME AS "Name", ' +
            'PARTSDESCRIPTION AS "Description"');
          SQL.Add('FROM tblparts WHERE Active = "T";');
          Open;
          FieldByName('PARTSID').Visible := false;
          FieldByName('PARTTYPE').Visible := false;
        end;

        // Get the function details
        with qryOtherFn do begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT FunctionID, FunctionName, Description, Hint, ' +
            'CaptionLine1, CaptionLine2, ' +
            'FontColour, FontName, FontSize, FontBold, FontUnderline, ' +
            'FontItalic, BackgroundColour, TopMargin, Active');
          SQL.Add('FROM tblPOSFunctions WHERE Active = "T"');
          {$IFNDEF DevMode}
            SQL.Add('and FunctionName <> "DevMode"');
          {$ENDIF}
          SQL.Add('ORDER BY  FunctionName ASC');
          Open;

          FieldByName('FunctionID').Visible := false;
          FieldByName('CaptionLine1').Visible := false;
          FieldByName('CaptionLine2').Visible := false;
          FieldByName('FontColour').Visible := false;
          FieldByName('FontName').Visible := false;
          FieldByName('FontSize').Visible := false;
          FieldByName('FontBold').Visible := false;
          FieldByName('FontItalic').Visible := false;
          FieldByName('FontUnderline').Visible := false;
          FieldByName('BackgroundColour').Visible := false;
          FieldByName('TopMargin').Visible := false;
          FieldByName('Active').Visible := false;
        end;
        if QryUOMs.active = False then QryUOMs.open;
        //QryUOMs.FieldByName('UnitID').Visible := false;
        qryParts.First;
        UpdateControls;

        bIsChanged := false;
      except
        on EAbort do HandleEAbortException;
        on e: ENoAccess do HandleNoAccessException(e);
        else raise;
      end;
    finally
      Processingcursor(False);
    end;
  finally
    EnableForm;
  end;
end;

procedure TCustomizePOSForm.FormActivate(Sender: TObject);
begin
  inherited;
  WindowState := wsnormal;
end;

procedure TCustomizePOSForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Notify;
  Action := caFree;
  CustomizePOSForm := nil;
  inherited;
end;



procedure TCustomizePOSForm.barTopTextChange(Sender: TObject);
  { Track Bar changed so relocate the top of the text }
begin
  if oBtnMatrix.Selected <> nil then begin
    barTopText.Position := oBtnMatrix.Selected.ArrangeText(barTopText.Position);
  end;
end;

procedure TCustomizePOSForm.PanelBtnClick(Sender: TObject);
  { Get here when click on any of the POS buttons }
begin
  // Define button clicked as 'Selected'
  oBtnMatrix.SelectButton(Sender);

  if (oBtnMatrix.SelRow = MAX_ROW) and
    (oBtnMatrix.SelCol = MAX_COL) and
    (oBtnMatrix.Selected.Func.FnID = FN_MAIN_PAD) then begin
    if CommonLib.MessageDlgXP_Vista('Unless this is a primary Keypad, do not change this button' +
      #13'It is used to return to the Primary Keypad. Change?',
      mtConfirmation, [mbYes, mbNo], 0) <> mrYes then begin
      oBtnMatrix.SelectButton(1, 1);
    end;
  end;

  // Load this button's properties into the form's control objects
  UpdateControls;
end;

procedure TCustomizePOSForm.btnFontClick(Sender: TObject);
begin
  dlgFont.Font.Assign(oBtnMatrix.Selected.Line1.Font);
  if dlgFont.Execute then begin
    with oBtnMatrix.Selected do begin
      Line1.Font.Assign(dlgFont.Font);
      Line2.Font.Assign(dlgFont.Font);
    end;

    lblFontTest.Font.Assign(dlgFont.Font);
    lblFontTest.Font.Color := clBlack;
    oBtnMatrix.Selected.ResizeLines;
    barTopTextChange(Sender); // Realign text
    bIsChanged := true;
  end;
end;

procedure TCustomizePOSForm.edtLine1KeyPress(Sender: TObject; var Key: char);
begin
  if Key = Chr(CR_ASCII) then begin
    Key := #0;   // eat CR
    oBtnMatrix.Selected.Line1.Caption := edtLine1.Text;
    oBtnMatrix.Selected.ResizeLines;
    barTopText.Position := oBtnMatrix.Selected.ArrangeText(barTopText.Position);
    bIsChanged          := true;
  end;
end;

procedure TCustomizePOSForm.edtLine1Exit(Sender: TObject);
begin
  oBtnMatrix.Selected.Line1.Caption := edtLine1.Text;
  oBtnMatrix.Selected.ResizeLines;
  barTopText.Position := oBtnMatrix.Selected.ArrangeText(barTopText.Position);
  bIsChanged := true;
end;

procedure TCustomizePOSForm.edtLine2KeyPress(Sender: TObject; var Key: char);
begin
  if Key = Chr(CR_ASCII) then begin
    Key := #0;   // eat CR
    oBtnMatrix.Selected.Line2.Caption := edtLine2.Text;
    oBtnMatrix.Selected.ResizeLines;
    barTopText.Position := oBtnMatrix.Selected.ArrangeText(barTopText.Position);
    bIsChanged          := true;
  end;
end;

procedure TCustomizePOSForm.edtLine2Exit(Sender: TObject);
begin
  oBtnMatrix.Selected.Line2.Caption := edtLine2.Text;
  oBtnMatrix.Selected.ResizeLines;
  barTopText.Position := oBtnMatrix.Selected.ArrangeText(barTopText.Position);
  bIsChanged := true;
end;


procedure TCustomizePOSForm.btnFontColourClick(Sender: TObject);
begin
  if dlgColour.Execute then begin
    pnlFontColour.Color := dlgColour.Color;
    with oBtnMatrix.Selected do begin
      Line1.Font.Color := dlgColour.Color;
      Line2.Font.Color := dlgColour.Color;
    end;
    oBtnMatrix.Selected.ResizeLines;
    bIsChanged := true;
  end;
end;

procedure TCustomizePOSForm.btnBgColourClick(Sender: TObject);
begin
  if dlgColour.Execute then begin
    pnlBgColour.Color := dlgColour.Color;
    oBtnMatrix.Selected.Panel.Color := dlgColour.Color;
    bIsChanged        := true;
  end;
end;

procedure TCustomizePOSForm.edtHotKeyKeyPress(Sender: TObject; var Key: char);
begin
  case Key of
    Null_Str:
      begin
        Key := '*';
        edtHotKeyExit(Sender);
      end;
    BS_Str:
      begin
        edtHotKey.Clear;
        Key := '*';
        edtHotKeyExit(Sender);
      end;
    CR:
      begin
        Key := '*';
        edtHotKeyExit(Sender);
      end;
    '*':
      begin
        edtHotKey.Clear;
        Key := '*';
        CommonLib.MessageDlgXP_Vista('Invalid ShortCut Key' + #13#10 + 'Try Another Letter',
          mtWarning, [mbOK], 0);
      end;
    else oBtnMatrix.SetHotKey(Key); { TODO : Set to upper case }
  end;
end;

procedure TCustomizePOSForm.edtHotKeyExit(Sender: TObject);
begin
  if (char_length(edtHotKey.Text) = 0) or (edtHotKey.Text = ' ') then oBtnMatrix.SetHotKey('*')
  else oBtnMatrix.SetHotKey(edtHotKey.Text[1]);
  bIsChanged := true;
end;

procedure TCustomizePOSForm.rbtProductClick(Sender: TObject);
begin
  LoadProdList;
end;

procedure TCustomizePOSForm.rbtFunctionClick(Sender: TObject);
begin
  LoadOtherList(0);
end;

procedure TCustomizePOSForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(oBtnMatrix);
  inherited;
end;

procedure TCustomizePOSForm.btnResetClick(Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('This procedure will reset this key'#13'Do you wish to Continue?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    oBtnMatrix.Selected.ResetBtn(oBtnMatrix.DefFont);
    bIsChanged := true;
  end;
end;

procedure TCustomizePOSForm.btnResetAllClick(Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('This procedure will reset all keys'#13'Do you wish to Continue?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    oBtnMatrix.ResetMatrix;
    if oBtnMatrix.KeypadID <> PRIMARY_PAD then begin
      oBtnMatrix.SelectButton(MAX_ROW, MAX_COL);
      Self.SetBtnToFn(FN_MAIN_PAD);
    end;
    oBtnMatrix.SelectButton(1, 1);
    bIsChanged := true;
  end;
end;

procedure TCustomizePOSForm.LoadProdList(const iPartID: integer = 0);
begin
  lblGroup.Caption := 'Select Product';
  btnProdList.Visible := true;
  optSelection.itemindex := 0;//rbtProduct.Checked := true;
  grdFunc.Visible := true;
  lblGroup.Visible := true;
  lblSearch.Visible := true;
  edtSearch.Visible := true;
  lblFunction.Caption := string(oBtnMatrix.Selected.Func.Description);
  lblFunction.Visible := true;
  grdFunc.DataSource := dscParts;
  KeyfieldName := 'name';
  grdFunc.Columns[0].DisplayWidth := 15;  // this is the partname column
  btnProdList.enabled := true;
  if iPartID <> 0 then begin
    qryParts.Locate('PARTSID', iPartID, [loCaseInsensitive]);
//    PopulateUnitCombo(iPartID, oBtnMatrix.Selected.Func.SubFn);
  end;
  grdFunc.RedrawGrid;
end;

procedure TCustomizePOSForm.LoadUOMs(const sUOMName:String='');
begin
  lblGroup.Caption := 'Select Unit of Measure';
  btnProdList.Visible := false;
  optSelection.itemindex  := 2;
  grdFunc.Visible := true;
  lblGroup.Visible := true;
  lblSearch.Visible := true;
  edtSearch.Visible := true;
  lblFunction.Caption := string(oBtnMatrix.Selected.Func.Description);
  lblFunction.Visible := true;
  grdFunc.DataSource := dsUOMs;
  KeyfieldName := 'unitname';
  grdFunc.Columns[0].DisplayWidth := 15;
  if sUOMName <> '' then begin
    QryUOMs.Locate('Unitname', sUOMName, [loCaseInsensitive]);
  end;
  grdFunc.RedrawGrid;
end;

procedure TCustomizePOSForm.LoadOtherList(const iFn: integer);
begin
  lblGroup.Caption := 'Select Function';
  btnProdList.Visible := false;
  //rbtFunction.Checked := true;
  optSelection.itemindex  := 1;
  grdFunc.Visible := true;
  lblGroup.Visible := true;
  lblSearch.Visible := true;
  edtSearch.Visible := true;
  lblFunction.Caption := string(oBtnMatrix.Selected.Func.Description);
  lblFunction.Visible := true;
  grdFunc.DataSource := dscOtherFn;
  KeyfieldName := 'functionname';
  grdFunc.Columns[0].DisplayWidth := 15;  // this is the Function name column
  if iFn <> 0 then begin
    qryOtherFn.Locate('FunctionID', iFn, [loCaseInsensitive]);
  end;
  grdFunc.RedrawGrid;
end;

procedure TCustomizePOSForm.InitFnListBox;
begin
  lblFunction.Caption := NO_FUNC;
  with oBtnMatrix.Selected do begin
    // Initialize the Function List Box accordingly
    if Func.FnID = FN_NONE then begin
      //rbtProduct.Checked := false;
      //rbtFunction.Checked := false;
      optSelection.itemindex := -1;
      grdFunc.Visible := false;
      lblGroup.Visible := false;
      lblSearch.Visible := false;
      edtSearch.Visible := false;
      btnProdList.Enabled := False;
    end else if Func.FnID = FN_PRODUCT then begin
      btnProdList.enabled := true;
      LoadProdList(Func.PartNumber);
    end else if Func.FnID = FN_SINGLE_UOM then begin
      btnProdList.enabled := true;
      LoadUOMs(Func.Description);
    end else begin
      LoadOtherList(Func.FnID);
    end;
  end;
end;

procedure TCustomizePOSForm.UpdateControls;
  { Updates the forms controls according to the selcted POS button }
begin
  with oBtnMatrix.Selected do begin
    pnlFontColour.Color := Line1.Font.Color;
    pnlBgColour.Color   := Panel.Color;
    lblFontTest.Font.Assign(Line1.Font);
    lblFontTest.Font.Color := clBlack;
    barTopText.Position    := Line1.Top;
    edtLine1.Text          := Line1.Caption;
    edtLine2.Text          := Line2.Caption;

    if edtHotKey.Text = BS_Str then begin
      edtHotKey.Text := '';
      HotKey.Caption := '*';
    end;

    if HotKey.Caption = '*' then edtHotKey.Text := ''
    else edtHotKey.Text := HotKey.Caption;
    InitFnListBox;
    lblFunction.Caption := string(Func.Description);
  end;
  lblLocn.Caption := Chr(A_ASCII - 1 + oBtnMatrix.SelRow) + IntToStr(oBtnMatrix.SelCol);
end;

procedure TCustomizePOSForm.grdFuncDblClick(Sender: TObject);
begin
  ProcessSelection;
end;

procedure TCustomizePOSForm.ProcessSelection;
  Function OldValue:Double;
  begin
      result :=0;
      Try
        result := strValue(edtLine1.text);
      Except
          //kill the exception
      end;
  end;
begin
  with oBtnMatrix.Selected do begin
    //if rbtProduct.Checked = true then begin
    if optSelection.itemindex =0 then begin
      SetBtnToGridPart;
    end else if optSelection.itemindex =2 then begin
      SetBtnToGridUOM;
    end else begin
      if (qryOtherFn.Fieldbyname('FunctionID').asInteger in [  FN_FIXED_PCENT_DISC_ITM ,FN_FIXED_PCENT_DISC_TOT ,FN_FIXED_PCENT_SURCH_ITM,FN_FIXED_PCENT_SURCH_TOT , FN_FIXED_DISC, FN_FIXED_SURCH]) then begin
        SetBtnToGridFn;
        FixedAmountentry( qryOtherFn.Fieldbyname('FunctionID').asInteger ,
                          qryOtherFn.fieldByname('functionname').asString,
                          qryOtherFn.fieldByname('Description').asString,OldValue);
      end else if (qryOtherFn.FieldByName('FunctionName').AsString = 'Table Selector') then begin
      //  lblUnitsLabel.Enabled := true;
     //   cboRooms.Enabled := true;
     //   if cboRooms.Text <> '' then begin
          oBtnMatrix.Selected.Func.RoomID := tcDataUtils.getFuncRoomID('DefaultRoom');  //qryFuncRooms2.FieldByName('RoomID').AsInteger;
          SetBtnToGridFn;
    //    end;
      end else if Sysutils.SameText(qryOtherFn.FieldByName('FunctionName').AsString , 'Memo (Preset)') then begin
        with TPOSMemoPopUpFrm.Create(Self) do try
            edtMemo.Text := string(oBtnMatrix.Selected.Func.Memo);
            if ShowModal = mrOk then begin
              {$warnings off}
              oBtnMatrix.Selected.Func.Memo := edtMemo.Text;
              {$warnings on}
            end;
          finally
            Free;
          end;
        SetBtnToGridFn;
      end else if Sysutils.SameText(qryOtherFn.FieldByName('FunctionName').AsString , 'Sub Product') then begin
        figroupID := 0;
        try
        With TProdAttribGroupsGUI.Create(Self) do try
            ShowGridonly := True;
            OnGridDataSelect := Selectgrooup;
            showModal;
        finally
            Free;
        end;
        if figroupID <> 0 then SetBtnToGridGroup;
        finally
            figroupID := 0;
        end;
      end else begin
        SetBtnToGridFn;
      end;
    end;
  end;
  UpdateControls;
  bIsChanged := true;
end;

procedure TCustomizePOSForm.btnProdListClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  edtPartID.Text := '';
  if not FormStillOpen('TProductListGUI') then begin
    tmpComponent := GetComponentByClassName('TProductListGUI');
    If not Assigned(tmpComponent) then Exit;
    with TProductListGUI(tmpComponent) do begin
        FormStyle := fsMDIChild;
        OnGridDataSelect := OnProductSelect;
    end;
    end else begin
     TProductListGUI(FindExistingComponent('TProductListGUI')).Show;
  end;
end;


procedure TCustomizePOSForm.OnProductSelect(Sender: TwwDbGrid);
begin
  edtPartID.Text := Sender.DataSource.DataSet.FieldByName('PARTSID').AsString;
end;

procedure TCustomizePOSForm.edtPartIDChange(Sender: TObject);
{ we get here after we return from ProductListGUI. It returns the part ID
  to the edtPartID component. }
begin
  if char_length(edtPartID.Text) <> 0 then begin
    qryParts.First;
    while not qryParts.Eof do begin
      if qryParts.FieldByName('PARTSID').AsString = edtPartID.Text then begin
        SetBtnToGridPart;
        UpdateControls;
        bIsChanged := true;
        Break;
      end;
      qryParts.Next;
    end;
  end;
end;
procedure TCustomizePOSForm.SetBtnToGridGroup;
begin
  with oBtnMatrix.Selected do begin
    Func.FnID        := FN_SUB_PRODUCT;
    Func.SubFn       := 0;
    {$warnings off}
    Func.Description := TProdAttribGroups.IDToggle(figroupID);
    {$warnings on}
    Func.PartNumber  := figroupID;
    Line1.Top        := 15;
    Line1.Caption    := string(Func.Description);
    Line2.Caption    := '(Group)';
    Panel.Color      := CL_NICE_BLUE;
    Line1.Font.Color := clblack;
    Line2.Font.Color := clblack;
    ArrangeText(Line1.Top);
    ResizeLines;
  end;
//  PopulateUnitCombo(oBtnMatrix.Selected.Func.PartNumber, 0);
  bIsChanged := true;
end;
Procedure TCustomizePOSForm.SetBtnToGridUOM;
begin
  with oBtnMatrix.Selected do begin
    Func.FnID        := FN_SINGLE_UOM;
    Func.SubFn       := 0;
    {$warnings off}
    Func.Description := QryUOMs.FieldByName('UnitName').AsString;
    {$warnings on}
    //Func.PartNumber  := QryUOMs.FieldByName('UnitID').AsInteger;
    Line1.Top        := 15;
    Line1.Caption    := QryUOMs.FieldByName('UnitName').AsString;//'Preset';
    Line2.Caption    := '(UOM)';
    Panel.Color      := CL_NICE_BLUE;
    Line1.Font.Color := clblack;
    Line2.Font.Color := clblack;
    ArrangeText(Line1.Top);
    ResizeLines;
  end;
//  PopulateUnitCombo(oBtnMatrix.Selected.Func.PartNumber, 0);
  bIsChanged := true;

end;
procedure TCustomizePOSForm.SetBtnToGridPart;
begin
  with oBtnMatrix.Selected do begin
    Func.FnID        := FN_PRODUCT;
    Func.SubFn       := 0;
    {$warnings off}
    Func.Description := qryParts.FieldByName('Description').AsString;
    {$warnings on}
    Func.PartNumber  := qryParts.FieldByName('PARTSID').AsInteger;
    Line1.Top        := 15;
    Line1.Caption    := qryParts.FieldByName('name').AsString;//'Preset';
    Line2.Caption    := '(Product)';
    Panel.Color      := CL_NICE_BLUE;
    Line1.Font.Color := clblack;
    Line2.Font.Color := clblack;
    ArrangeText(Line1.Top);
    ResizeLines;
  end;
//  PopulateUnitCombo(oBtnMatrix.Selected.Func.PartNumber, 0);
  bIsChanged := true;
end;

procedure TCustomizePOSForm.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveKeypad(ayiKeypadID[cboKeyPad.ItemIndex]);
  Close;
end;

procedure TCustomizePOSForm.SaveKeypad(const iKeypadID: integer);
begin
  //  oBtnMatrix.KeypadID := ayiKeypadID[cboKeyPad.ItemIndex];
  oBtnMatrix.KeypadID := iKeypadID;
  oBtnMatrix.SaveToDB;
  bIsChanged := false;
end;

procedure TCustomizePOSForm.btnCancelClick(Sender: TObject);
begin
  bIsChanged := false;
  Close;
end;


//procedure TCustomizePOSForm.Notify;
//var
//  i: integer;
//begin
//  for i := 0 to flstObservers.Count - 1 do begin
//    {This is a way of determining if the observer is still open/active}
//    if TPOSScreenForm(flstObservers[i]).qryProduct.Active then begin
//      TPOSScreenForm(flstObservers[i]).UpdateMe;
//    end;
//  end;
//end;

procedure TCustomizePOSForm.cboKeypadChange(Sender: TObject);
var
  i, iIndex, iChoice: integer;
  bFound: boolean;
begin
  inherited;
  iChoice := mrNo;
  lblPadTitle.Caption := cboKeypad.Text;
  if bIsChanged then begin
    // if any changes mad to keypad then ask if want to Save
    iChoice := CommonLib.MessageDlgXP_Vista('Save Changes to this Keypad', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
    if iChoice = mrYes then begin
      SaveKeypad(oBtnMatrix.KeypadID);
    end;
  end;

  if (iChoice = mrYes) or (iChoice = mrNo) then begin
    // load new keypad
    LoadKeypad(ayiKeypadID[cboKeyPad.ItemIndex]);
  end else begin
    // Cancelled, so Return combo to original value
    bFound := false;
    iIndex := 1;
    for i := 1 to MAX_KEYPAD do begin
      if ayiKeypadID[oBtnMatrix.KeyPadID] = oBtnMatrix.KeypadID then begin
        bFound := true;
        iIndex := i;
        Break;
      end;
    end;

    cboKeypad.ItemIndex := iIndex;
    if not bFound then begin
      CommonLib.MessageDlgXP_Vista('Could not Find Keypad ID, will resort to Primary', mtWarning,
        [mbOK], 0);
    end;
  end;
end;

procedure TCustomizePOSForm.LoadKeypad(const iKeypadID: integer);
begin
  bIsChanged := false;
  oBtnMatrix.ResetMatrix;
  oBtnMatrix.KeypadID := iKeypadID;
  if not oBtnMatrix.LoadFromDB then begin
    if oBtnMatrix.KeypadID <> PRIMARY_PAD then begin
      if oBtnMatrix.aryPOSBtn[MAX_ROW, MAX_COL].Func.FnID <> FN_MAIN_PAD then begin
        oBtnMatrix.SelectButton(MAX_ROW, MAX_COL);
        Self.SetBtnToFn(FN_MAIN_PAD);
        bIsChanged := true;
      end
    end;
  end;
  oBtnMatrix.SelectButton(1, 1);
  UpdateControls;
end;

procedure TCustomizePOSForm.SetBtnToFn(const iFn: integer);
begin
  if iFn <> 0 then begin
    qryOtherFn.Locate('FunctionID', iFn, [loCaseInsensitive]);
  end;
  SetBtnToGridFn;
end;

procedure TCustomizePOSForm.SetBtnToGridFn;
var
  iCode: integer;
begin
  with oBtnMatrix.Selected do begin
    with qryOtherFn do begin
      Func.FnID := FieldByName('FunctionID').AsInteger;
      {$warnings off}
      Func.Description := FieldByName('FunctionName').AsString;
      {$warnings on}
      // Are we working with the Table Selector?
      if Func.FnID = FN_TABLE_SELECTOR then begin
        // Yes, Store Room ID.
        Func.RoomID := qryFuncRooms2.FieldByName('RoomID').AsInteger;
      end;
      SetHint(fieldbyname('hint').asString);

      Func.PartNumber := 0;
      Func.Price := 0.0;
      Line1.Top := 15;  // change this to read margin
      Line1.Caption := FieldByName('CaptionLine1').AsString;
      Line2.Caption := FieldByName('CaptionLine2').AsString;
      Panel.Color := FieldByName('BackgroundColour').AsInteger;
      Line1.Font.Name := FieldByName('FontName').AsString;
      Line2.Font.Name := FieldByName('FontName').AsString;
      Line1.Font.Size := FieldByName('FontSize').AsInteger;
      Line2.Font.Size := FieldByName('FontSize').AsInteger;
      Line1.Font.Color := FieldByName('FontColour').AsInteger;
      Line2.Font.Color := FieldByName('FontColour').AsInteger;
      Line1.Font.Style := [];
      Line2.Font.Style := [];
      if FieldByName('FontBold').AsString = 'T' then begin
        Line1.Font.Style := Line1.Font.Style + [fsBold];
        Line2.Font.Style := Line2.Font.Style + [fsBold];
      end;
      if FieldByName('FontItalic').AsString = 'T' then begin
        Line1.Font.Style := Line1.Font.Style + [fsItalic];
        Line2.Font.Style := Line2.Font.Style + [fsItalic];
      end;
      if FieldByName('FontUnderline').AsString = 'T' then begin
        Line1.Font.Style := Line1.Font.Style + [fsUnderline];
        Line2.Font.Style := Line2.Font.Style + [fsUnderline];
      end;
      if Func.FnID = FN_CHG_PAD then begin
        with TPOSChgPadPopUp.Create(Self) do try
            if ShowModal = mrOk then begin
              Func.SubFn := iChosenIndex;
            end;
          finally
            Free;
          end;
      end else if Func.FnID = FN_SALESMAN_ID then begin
        with TPOSSalesmanPopUp.Create(Self) do try
            if ShowModal = mrOk then begin
              Val(edtEmpID.Text, Func.SubFn, iCode);
              if iCode <> 0 then begin
                CommonLib.MessageDlgXP_Vista('Invalid Employee ID', mtWarning, [mbOK], 0);
                Func.SubFn := 0;
              end;
            end;
          finally
            Free;
          end;
      end;
    end;
    ArrangeText(Line1.Top);
    ResizeLines;
  end;
end;

procedure TCustomizePOSForm.PopulatePadCombo;
var
  qry: TERPQuery;
  i: integer;
begin
  qry := TERPQuery.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    with qry do begin
      // Keypad table
      SQL.Clear;
      SQL.Add('SELECT KeypadID, Description ' +
        'FROM tblPOSKeypads WHERE Active = ' + QuotedStr('T'));
      Open;
      if not IsEmpty then begin
        cboKeypad.Items.Clear;
        i := 0;
        First;
        while not Eof do begin
          ayiKeypadID[i] := qry.FieldByName('KeypadID').AsInteger;
          cboKeypad.Items.Add(qry.FieldByName('Description').AsString);
          Next;
          Inc(i);
        end;
      end else begin
        CommonLib.MessageDlgXP_Vista('No Keypads Registered In Database', mtWarning, [mbOK], 0);
      end;
      cboKeypad.ItemIndex := 0;
      lblPadTitle.Caption := cboKeypad.Text;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TCustomizePOSForm.btnKeypadsClick(Sender: TObject);
var
  iChoice: integer;
begin
  inherited;
  iChoice := mrOk;  // just to stop compiler whinging
  if bIsChanged then begin
    // if any changes made to keypad then ask if want to Save
    iChoice := CommonLib.MessageDlgXP_Vista('Save Changes to this Keypad', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
    if iChoice = mrYes then begin
      oBtnMatrix.SaveToDB;
    end;
  end;

  if iChoice <> mrCancel then begin
    with TPOSEditPadsPopUp.Create(Self) do try
        if ShowModal = mrOk then begin
          PopulatePadCombo;

          oBtnMatrix.KeypadID := PRIMARY_PAD;
          oBtnMatrix.LoadFromDb;
        end;
      finally
        Free;
      end;
  end;
end;

function TCustomizePOSForm.LocateChangeButton(const KeypadMainID, KeypadToID: integer): boolean;
var
  Qry: TERPQuery;
begin
  Qry := nil;
  Result := true;
  try
    Qry := TERPQuery.Create(nil);
    Qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT * FROM tblposkeypadcustomize');
    Qry.SQL.Add('WHERE (KeypadID = ' + IntToStr(KeypadMainID) + ' AND FunctionNo = ' +
      IntToStr(FN_CHG_PAD) + ' AND FunctionType = ' + IntToStr(KeypadToID) + ')');
    Qry.Open;
    if Qry.RecordCount < 1 then begin
      Result := false;
      Exit;
    end;
  finally
    if Assigned(Qry) then FreeAndNil(qry);
  end;
end;

function TCustomizePOSForm.CreateNewChangeButton(const KeypadID, KeypadToID: integer; const PadName: string): boolean;
var
  Qry: TERPQuery;
  QryKeypad: TERPQuery;
begin
  Qry := nil;
  QryKeypad := nil;
  Result := true;

  try
    try
      Qry := TERPQuery.Create(nil);
      Qry.Connection := CommonDbLib.GetSharedMyDacConnection;

      QryKeypad := TERPQuery.Create(nil);
      QryKeypad.Connection := CommonDbLib.GetSharedMyDacConnection;
      QryKeypad.SQL.Clear;
      QryKeypad.SQL.Add('SELECT * FROM tblposkeypads WHERE KeypadID = ' + IntToStr(KeypadID));
      QryKeypad.Open;

      if KeypadID = KeypadToID then begin
        CommonLib.MessageDlgXP_Vista('Currently keypad ' + QryKeypad.FieldByName('Description').AsString +
          ' cannot be opened from it''s own keypad!', mtWarning, [mbOK], 0);
        Result := false;
        // We are done, cannot do anymore here!
        Exit;
      end;

      Qry.SQL.Clear;
      Qry.SQL.Add('SELECT * FROM tblposkeypadcustomize');
      Qry.SQL.Add('WHERE (KeypadID = ' + IntToStr(KeypadID) + ' AND FunctionNo = -1 AND (Keyname BETWEEN ''A%'' AND ''H%''))');
      Qry.SQL.Add('ORDER BY KeyName DESC');
      Qry.Open;

      // Do we have any free buttons?
      if Qry.RecordCount < 1 then begin
        // No report it and fail function.
        CommonLib.MessageDlgXP_Vista('Currently keypad ' + QryKeypad.FieldByName('Description').AsString +
          ' is full and cannot place anymore buttons!', mtWarning, [mbOK], 0);
        Result := false;
        // We are done, cannot do anymore here!
        Exit;
      end;

      // Change Unused Record to CHANGE PAD.
      with Qry do begin
        First;
        Edit;
        FieldByName('CaptionLine1').AsString := PadName;
        FieldByName('CaptionLine2').AsString := 'Keypad';
        FieldByName('FunctionNo').AsInteger := FN_CHG_PAD;
        FieldByName('FunctionType').AsInteger := KeypadToID;
        FieldByName('FunctionName').AsString := 'Change Keypad';
        FieldByName('TopMargin').AsInteger := 13;
        FieldByName('FontColour').AsInteger := -2147483640;
        FieldByName('BackgroundColour').AsInteger := 8421631;
        FieldByName('Hint').AsString := 'Allows you to change to the ' + qryKeypad.FieldByName('Description').AsString +
          ' keypad.';
        Post;
      end;
    except
      Result := false;
      Exit;
    end;
  finally
    if Assigned(Qry) then FreeAndNil(qry);
    if Assigned(QryKeypad) then
      FreeAndNil(QryKeypad);
  end;
end;

procedure TCustomizePOSForm.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  OpenERPform('Tfmpostilleopconfig' , 0);
end;

procedure TCustomizePOSForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
  if bIsChanged then begin
    //case CommonLib.MessageDlgXP_Vista('You have made changes. Do you wish to Save?',
//      mtInformation, [mbYes, mbNo, mbCancel], 0) of
//      mrYes:
//        begin
//          SaveKeypad(ayiKeypadID[cboKeyPad.ItemIndex]);
//          CanClose := true;
//        end;
//      mrNo: CanClose := true;
//      mrCancel: CanClose := false;
//    end;
  end;
end;

procedure TCustomizePOSForm.btnCopyClick(Sender: TObject);
begin
  (*dlgSave.FileName := cboKeyPad.Text + '.pad';
  if dlgSave.Execute then oBtnMatrix.SaveToFile(dlgSave.FileName);*)
end;

procedure TCustomizePOSForm.btnPasteClick(Sender: TObject);
begin
  inherited;
  (*dlgOpen.FileName := cboKeyPad.Text + '.pad';
  if dlgOpen.Execute then begin
    oBtnMatrix.ResetMatrix;
    oBtnMatrix.LoadFromFile(dlgOpen.FileName);
  end;
  UpdateControls;*)
end;

procedure TCustomizePOSForm.btnTillsClick(Sender: TObject);
begin
  with TPOSTillsPopUp.Create(Self) do try
      if ShowModal = mrOk then begin;   { TODO : Code to change main keypad on return }
      end;
    finally
      Free;
    end;
end;

procedure TCustomizePOSForm.qryPartsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryParts.IndexFieldNames := QuotedStr('Name') + ' ASC CIS';  {Fix for Order By Slow With 100 Thousand Parts}
end;

procedure TCustomizePOSForm.qryPartsBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Application.ProcessMessages;
end;

procedure TCustomizePOSForm.optSelectionClick(Sender: TObject);
begin
  inherited;
  if optSelection.itemindex =0 then LoadProdList
  else if optSelection.itemindex =1 then LoadOtherList(0)
  else if optSelection.itemindex =2 then LoadUOMs;
end;

procedure TCustomizePOSForm.grdFuncKeyPress(Sender: TObject; var Key: char);
const
  ENTER_KEY = 13;
begin
  inherited;
  if Key = char(ENTER_KEY) then begin
    Key := #0;
    grdFuncDblClick(Sender);
  end;
end;
procedure TCustomizePOSForm.Selectgrooup(Sender: TwwDbGrid);
begin
  figroupID := Sender.DataSource.DataSet.fieldbyname('Pag_ID').AsInteger;
end;

procedure TCustomizePOSForm.grdFuncMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  ProcessSelection;
end;

procedure TCustomizePOSForm.FixedAmountentry(const FunctionID: Integer; functioname , functionDesc :String; Oldvalue:Double);
var
  (*Value:String;*)
  dValue:Double;
begin
  //Value := UserInput(functioname , functionDesc , FloatToStrF(OldValue, ffNumber, 15, 2), TfloatData  , True , Self.Color);
  dValue := commonlib.CustomInputFloat(functioname , functionDesc ,FloatToStrF(OldValue, ffNumber, 15, 2));
  if dValue <0 then exit;
  (*dValue := 0;
  if IsNumeric(Value) then
    dValue := StrToFloat(Value);*)
  if functionId = FN_FIXED_PCENT_DISC_ITM  then begin
    oBtnMatrix.Selected.line1.caption :=FloatToStrF(dValue, ffNumber, 15, 2)+'% Item';
    oBtnMatrix.Selected.line2.caption:= 'Discount';
  end else if functionId = FN_FIXED_PCENT_DISC_TOT  then  begin
    oBtnMatrix.Selected.line1.caption :=FloatToStrF(dValue, ffNumber, 15, 2)+'% Total';
    oBtnMatrix.Selected.line2.caption:= 'Discount';
  end else if functionId = FN_FIXED_PCENT_SURCH_ITM  then  begin
    oBtnMatrix.Selected.line1.caption :=FloatToStrF(dValue, ffNumber, 15, 2)+'% Item';
    oBtnMatrix.Selected.line2.caption:= 'Surcharge';
  end else if functionId = FN_FIXED_PCENT_SURCH_TOT then  begin
    oBtnMatrix.Selected.line1.caption :=FloatToStrF(dValue, ffNumber, 15, 2)+'% Total';
    oBtnMatrix.Selected.line2.caption:= 'Surcharge';
  end else if functionId = FN_FIXED_DISC then  begin
    oBtnMatrix.Selected.line1.caption :=FloatToStrF(dValue, ffCurrency, 15, CurrencyRoundPlaces);
    oBtnMatrix.Selected.line2.caption:= 'Discount';
  end else if functionId = FN_FIXED_SURCH then  begin
    oBtnMatrix.Selected.line1.caption :=FloatToStrF(dValue, ffCurrency, 15, CurrencyRoundPlaces);
    oBtnMatrix.Selected.line2.caption:= 'Surcharge';
  end;
end;

procedure TCustomizePOSForm.edtSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
    if KeyfieldName = '' then exit;
    if grdFunc.DataSource.DataSet.FindField(KeyfieldName) <> nil then
      grdFunc.DataSource.DataSet.Locate(KeyfieldName , edtSearch.Text , [loCaseInsensitive, loPartialKey]);

end;

initialization
  RegisterClassOnce(TCustomizePOSForm);
end.

