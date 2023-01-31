unit frmButtonArrayCustomise;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmPadBaseInput, ActnList, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, AdvSmoothExpanderGroup, ExtCtrls, AdvSmoothButton, JsonObject,
  frameButtonArray, AdvSmoothListBox, AdvSmoothComboBox, AdvSmoothLabel,
  StdCtrls, AdvCombo, AdvSmoothPopup, AdvSmoothPanel, AdvSmoothExpanderPanel,
  AdvEdit, wwclearbuttongroup, wwradiogroup, wwdblook, DBAdvSmoothComboBox,
  Grids, Wwdbigrd, Wwdbgrid, kbmMemTable, BusObjPreference, wwcheckbox, Mask,
  wwdbedit, Wwdotdot, Wwdbcomb, ProgressDialog;

type
  TfmButtonArrayCustomise = class(TfmPadBaseInput)
    btnSave: TAdvSmoothButton;
    btnCancel: TAdvSmoothButton;
    ButtonArray: TfrButtonArray;
    lblKeypadName: TAdvSmoothLabel;
    popupKeypadName: TAdvSmoothPopup;
    qryProducts: TERPQuery;
    lblKeyFunction: TLabel;
    rbProduct: TRadioButton;
    lblFunctionProduct: TLabel;
    rbKeypad: TRadioButton;
    lblFunctionKeypad: TLabel;
    Bevel1: TBevel;
    rbFunction: TRadioButton;
    lblFunctionSpecial: TLabel;
    grdSelect: TwwDBGrid;
    lblKeyProperties: TAdvSmoothLabel;
    edtKeyText: TEdit;
    lblKeyDisplayName: TLabel;
    Bevel5: TBevel;
    btnFontColour: TAdvSmoothButton;
    actFontColour: TAction;
    actButtonColour: TAction;
    btnButtonColour: TAdvSmoothButton;
    actButtonFont: TAction;
    btnButtonFont: TAdvSmoothButton;
    dlgColour: TColorDialog;
    dlgFont: TFontDialog;
    dsSelect: TDataSource;
    lblFunctionNone: TLabel;
    rbNone: TRadioButton;
    tblKeypads: TkbmMemTable;
    qryProductsName: TWideStringField;
    qryProductsDescription: TWideStringField;
    actDeleteKeypad: TAction;
    btnDeleteKeypad: TAdvSmoothButton;
    cboDepartment: TwwDBLookupCombo;
    qryDepartment: TERPQuery;
    lblDepartment: TAdvSmoothLabel;
    chkHomeAfterClick: TCheckBox;
    lblHomeAfterClick: TLabel;
    cboKeypad: TwwDBComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actCancelExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure popupKeypadNameButtonClick(Sender: TObject; Index: Integer);
    procedure actFontColourExecute(Sender: TObject);
    procedure actButtonColourExecute(Sender: TObject);
    procedure actButtonFontExecute(Sender: TObject);
    procedure edtKeyTextChange(Sender: TObject);
    procedure rbClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdSelectDblClick(Sender: TObject);
    procedure actDeleteKeypadExecute(Sender: TObject);
    procedure cboDepartmentCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure chkHomeAfterClickClick(Sender: TObject);
    procedure cboKeypadCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure grdSelectCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
    fDoingUpdateDisplay: boolean;
    fConfig: TJsonObject;
    fCurrentDepartment: string;
    fsKeypadName: string;
    CurrentFunctionValue: string;
    procedure DoOnArrayButtonClick(Button: TAdvSmoothButton; FunctionType, FunctionValue: string);
    procedure DoOnKeypadSelect(aSender: TObject);
    procedure DoOnConfigAssign(aSender: TObject);
    function AddNewKeypad(newKeypadName: string): boolean;
    function GetConfig: TJsonObject;
    procedure SaveKeypad;
//    procedure SetConfig(const Value: TJsonObject);
    procedure UpdateDisplayForButton;
    procedure LoadConfig;
    procedure SaveConfig;
//    procedure SetConfig(const Value: TJsonObject);
    function GetDepartmentName: string;
    procedure SetDepartmentName(const Value: string);
  public
    property Config: TJsonObject read GetConfig; // write SetConfig;
    property DepartmentName: string read GetDepartmentName write SetDepartmentName;
    Property KeypadName:string read fsKeypadName write fsKeypadName;
  end;

function DoCustomiseButtons(aDepartmentName: string; PadName:String): boolean;

implementation

{$R *.dfm}

uses
  Vista_MessageDlg, JsonObjectUtils, BusObjBase;

function DoCustomiseButtons(aDepartmentName: string; PadName:String): boolean;
var
  form: TfmButtonArrayCustomise;
begin
  form:= TfmButtonArrayCustomise.Create(nil);
  form.DepartmentName:= aDepartmentName;
  form.KeyPadname := Padname;
  try
    result:= form.ShowModal = mrOk;
  finally
    form.Free;
  end;
end;

procedure TfmButtonArrayCustomise.actButtonColourExecute(Sender: TObject);
begin
  inherited;
  if Assigned(ButtonArray.SelectedButton) then begin
    dlgColour.Color:= ButtonArray.SelectedButton.Color;
    if dlgColour.Execute then begin
      ButtonArray.SelectedButton.Color:= dlgColour.Color;
    end;
  end;
end;

procedure TfmButtonArrayCustomise.actButtonFontExecute(Sender: TObject);
begin
  inherited;
  if Assigned(ButtonArray.SelectedButton) then begin
    dlgFont.Font.Assign(ButtonArray.SelectedButton.Appearance.Font);
    if dlgFont.Execute then begin
      ButtonArray.SelectedButton.Appearance.Font.Assign(dlgFont.Font);
    end;
  end;
end;

procedure TfmButtonArrayCustomise.actCancelExecute(Sender: TObject);
begin
  inherited;
  RollbackTransaction;
  ModalResult:= mrCancel;
end;

procedure TfmButtonArrayCustomise.actDeleteKeypadExecute(Sender: TObject);
var
  s: string;
begin
  inherited;
  s:= cboKeypad.Text;
  if ButtonArray.DeleteKeypad(s) then begin
     { remove from combo }
    cboKeypad.Items.Delete(cboKeypad.Items.IndexOf(s));
    ButtonArray.SelectedKeypadName:= 'Home';
  end;
end;

procedure TfmButtonArrayCustomise.actFontColourExecute(Sender: TObject);
begin
  inherited;
  if Assigned(ButtonArray.SelectedButton) then begin
    dlgColour.Color:= ButtonArray.SelectedButton.Appearance.Font.Color;
    if dlgColour.Execute then begin
      ButtonArray.SelectedButton.Appearance.Font.Color:= dlgColour.Color;
    end;
  end;
end;

procedure TfmButtonArrayCustomise.actSaveExecute(Sender: TObject);
begin
  inherited;
  SaveConfig;
  CommitTransaction;
  ModalResult:= mrOk;
end;

function TfmButtonArrayCustomise.AddNewKeypad(newKeypadName: string): boolean;
begin
  result:= ButtonArray.AddKeypad(newKeypadName);
  if result then begin
    cboKeypad.Items.Insert(cboKeypad.Items.Count-1,newKeypadName);
    ButtonArray.SelectedKeypadName:= newKeypadName;
  end;
end;

procedure TfmButtonArrayCustomise.cboDepartmentCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if fCurrentDepartment <> cboDepartment.Text then begin
    if Assigned(fConfig) then begin
      { save the current config to db }
      SaveConfig;
    end;
    fCurrentDepartment:= cboDepartment.Text;
    if fCurrentDepartment <> '' then begin
      LoadConfig;
    end
    else begin
      fConfig.Free;
      fConfig:= nil;
    end;
    ButtonArray.Config:= fConfig;
  end;
end;

procedure TfmButtonArrayCustomise.cboKeypadCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  inherited;
  if cboKeypad.Text = '[Create New]' then begin
    popupKeypadName.FooterCaption:= '';
    popupKeypadName.Control:= TEdit.Create(nil);
    TEdit(popupKeypadName.Control).Font:= self.Font;
    popupKeypadName.PopupAtControl(cboKeyPad,pdTopLeft);
  end
  else if cboKeypad.ItemIndex > -1 then begin
    ButtonArray.SelectedKeypadName:= cboKeypad.Text;
  end;
  actDeleteKeypad.Enabled:= (cboKeypad.Text <> 'Home') and (cboKeypad.Text <> '[Create New]');
end;

procedure TfmButtonArrayCustomise.chkHomeAfterClickClick(Sender: TObject);
begin
  inherited;
  if Assigned(ButtonArray.SelectedButton) then
    ButtonArray.SelectedButtonConfig.B['HomeAfterClick']:= chkHomeAfterClick.Checked;

end;

procedure TfmButtonArrayCustomise.DoOnArrayButtonClick(Button: TAdvSmoothButton; FunctionType, FunctionValue: string);
begin
  UpdateDisplayForButton;
end;

procedure TfmButtonArrayCustomise.DoOnConfigAssign(aSender: TObject);
begin
  ButtonArray.PopulateKeypadNames(cboKeypad.Items);
  cboKeypad.Items.Add('[Create New]');
  cboKeypad.ItemIndex:= cboKeypad.Items.IndexOf('Home');
end;

procedure TfmButtonArrayCustomise.DoOnKeypadSelect(aSender: TObject);
var
  sl: TStringList;
  x: integer;
begin
  cboKeypad.ItemIndex:= cboKeypad.Items.IndexOf(ButtonArray.SelectedKeypadName);
  sl:= TStringList.Create;
  try
    ButtonArray.PopulateKeypadNames(sl,true);
    tblKeypads.EmptyTable;
    for x := 0 to sl.Count-1 do begin
      tblKeypads.Insert;
      tblKeypads.Fields[0].AsString:= sl[x];
      tblKeypads.Post;
    end;
  finally
    sl.Free;
  end;


  UpdateDisplayForButton;
end;

procedure TfmButtonArrayCustomise.edtKeyTextChange(Sender: TObject);
begin
  inherited;
  ButtonArray.SelectedButton.Caption:= edtKeyText.Text;
end;

procedure TfmButtonArrayCustomise.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action:= caFree;
end;

procedure TfmButtonArrayCustomise.FormCreate(Sender: TObject);
var
  SavedColor: TColor;
begin
  SavedColor:= self.Color;
  inherited;
  self.Color:= SavedColor;
  fDoingUpdateDisplay:= false;
  qryProducts.Open;
  tblKeypads.CreateTableAs(qryProducts, [mtcpoStructure, mtcpoProperties]);
  tblKeypads.Open;
  fConfig:= nil;
  fCurrentDepartment:= '';
  ButtonArray.DesignMode:= true;
  ButtonArray.OnButtonClick:= DoOnArrayButtonClick;
  ButtonArray.OnKeypadSelect:= DoOnKeypadSelect;
  ButtonArray.OnConfigAssign:= DoOnConfigAssign;
end;

procedure TfmButtonArrayCustomise.FormShow(Sender: TObject);
begin
  inherited;
  BeginTransaction;
  qryDepartment.Open;
  fCurrentDepartment:= DepartmentName;
  LoadConfig;
  ButtonArray.Config:= fConfig;
  ButtonArray.SelectedKeypadName:= 'Home';
end;

function TfmButtonArrayCustomise.GetConfig: TJsonObject;
begin
  Result := fConfig;
end;

function TfmButtonArrayCustomise.GetDepartmentName: string;
begin
  result:= cboDepartment.Text;
end;

procedure TfmButtonArrayCustomise.grdSelectCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if CurrentFunctionValue <> '' then begin
    if grdSelect.DataSource.DataSet.FieldByName('Name').AsString = CurrentFunctionValue then begin
      ABrush.Color := clYellow;



    end;
  end;
end;

procedure TfmButtonArrayCustomise.grdSelectDblClick(Sender: TObject);
begin
  inherited;
  if Assigned(ButtonArray.SelectedButton) then begin
    ButtonArray.SelectedButtonConfig.S['FunctionValue']:=
      grdSelect.DataSource.DataSet.FieldByName('Name').AsString;
    if edtKeyText.Text = '' then
      edtKeyText.Text:=
        grdSelect.DataSource.DataSet.FieldByName('Name').AsString;
  end;
end;

procedure TfmButtonArrayCustomise.LoadConfig;
var
  Pref: TPreference;
begin
  if fCurrentDepartment = '' then
    exit;
  Pref:= TPreference.Create(nil);
  try
    Pref.Connection:= TMyDacDataConnection.Create(Pref);
    Pref.Connection.Connection:= MyConnection;
    Pref.Load(0,'KeypadConfig',KeypadName,fCurrentDepartment);
    if not Assigned(fConfig) then
      fConfig:= TJsonObject.Create;
    fConfig.AsString:= Pref.PrefValue;
  finally
    Pref.Free;
  end;
end;

procedure TfmButtonArrayCustomise.popupKeypadNameButtonClick(Sender: TObject;
  Index: Integer);
begin
  inherited;
  if Index = 0 then begin
    { validate and save new keypad }
    if AddNewKeypad(TEdit(popupKeypadName.Control).Text) then begin
      popupKeypadName.ClosePopup;
    end
    else begin
      exit;
    end;
  end
  else begin
    popupKeypadName.ClosePopup;
  end;
  popupKeypadName.Control.Free;
end;

procedure TfmButtonArrayCustomise.rbClick(Sender: TObject);
begin
  inherited;
  if fDoingUpdateDisplay then exit;

  if Assigned(ButtonArray.SelectedButton) then begin
    if Sender = rbNone then begin
      ButtonArray.ResetButton(ButtonArray.SelectedButton);
      chkHomeAfterClick.Checked:= false;
    end
    else if Sender = rbProduct then begin
      ButtonArray.ResetButton(ButtonArray.SelectedButton);
      ButtonArray.SelectedButtonConfig.S['FunctionType']:= 'Product';
      chkHomeAfterClick.Checked:= true;
      ButtonArray.SelectedButton.Color:= 8454143;
    end
    else if Sender = rbKeypad then begin
      ButtonArray.ResetButton(ButtonArray.SelectedButton);
      ButtonArray.SelectedButtonConfig.S['FunctionType']:= 'Keypad';
      chkHomeAfterClick.Checked:= false;
      ButtonArray.SelectedButton.Color:= 4227327;
    end
    else if Sender = rbFunction then begin
      ButtonArray.ResetButton(ButtonArray.SelectedButton);
      ButtonArray.SelectedButtonConfig.S['FunctionType']:= 'Function';
      chkHomeAfterClick.Checked:= true;
    end;
    ButtonArray.SelectedButtonConfig.B['HomeAfterClick']:= chkHomeAfterClick.Checked;
    UpdateDisplayForButton;
  end;
end;

procedure TfmButtonArrayCustomise.SaveConfig;
var
  Pref: TPreference;
begin
  if (fCurrentDepartment = '') or (not Assigned(fConfig)) then
    exit;
  SaveKeypad;
  Pref:= TPreference.Create(nil);
  try
    Pref.Connection:= TMyDacDataConnection.Create(Pref);
    Pref.Connection.Connection:= MyConnection;
    Pref.Load(0,'KeypadConfig',KeypadName,fCurrentDepartment);
    Pref.PrefValue:= fConfig.AsString;
    Pref.Save;
  finally
    Pref.Free;
  end;
end;

procedure TfmButtonArrayCustomise.SaveKeypad;
begin
  { force ButtonArray to save buttons to json config }
  ButtonArray.SelectedKeypadName:= ButtonArray.SelectedKeypadName;
end;

//procedure TfmButtonArrayCustomise.SetConfig(const Value: TJsonObject);
//begin
//  ButtonArray.Config:= Value;
//  ButtonArray.PopulateKeypadNames(cboKeypad.Items);
//  cboKeypad.Items.Add('[Create New]');
//end;

procedure TfmButtonArrayCustomise.SetDepartmentName(const Value: string);
begin
  qryDepartment.Open;
  if qryDepartment.Locate(cboDepartment.LookupField,Value,[loCaseInsensitive]) then begin
    cboDepartment.Text:= qryDepartment.FieldByName(cboDepartment.LookupField).AsString;
  end;
end;

procedure TfmButtonArrayCustomise.UpdateDisplayForButton;
var
  FunctionValue: string;
begin
  if fDoingUpdateDisplay then exit;
  fDoingUpdateDisplay:= true;
  try
    CurrentFunctionValue := '';
    if Assigned(ButtonArray.SelectedButton) then begin
      if ButtonArray.SelectedButtonConfig.S['FunctionType'] = 'Product' then begin
        rbProduct.Checked:= true;
        dsSelect.DataSet:= qryProducts;
        grdSelect.Visible:= true;
        FunctionValue:= ButtonArray.SelectedButtonConfig.S['FunctionValue'];
        CurrentFunctionValue := FunctionValue;
        if FunctionValue <> '' then
          grdSelect.DataSource.DataSet.Locate('Name',FunctionValue,[loCaseInsensitive]);
      end
      else if ButtonArray.SelectedButtonConfig.S['FunctionType'] = 'Keypad' then begin
        rbKeypad.Checked:= true;
        dsSelect.DataSet:= tblKeypads;
        grdSelect.Visible:= true;
        FunctionValue:= ButtonArray.SelectedButtonConfig.S['FunctionValue'];
        CurrentFunctionValue := FunctionValue;
        if FunctionValue <> '' then
          grdSelect.DataSource.DataSet.Locate('Name',FunctionValue,[loCaseInsensitive]);
      end
      else if ButtonArray.SelectedButtonConfig.S['FunctionType'] = 'Function' then begin
        rbFunction.Checked:= true;
        grdSelect.Visible:= false;
      end
      else begin
        rbNone.Checked:= true;
        grdSelect.Visible:= false;
      end;

    end
    else begin
      rbNone.Checked:= true;
    end;

    if rbNone.Checked then begin
      edtKeyText.Enabled:= false;
      edtKeyText.Clear;
      rbNone.Enabled:= false;
      rbProduct.Enabled:= false;
      rbKeypad.Enabled:= false;
      rbFunction.Enabled:= false;
      rbNone.Checked:= true;
      grdSelect.Visible:= false;
      actFontColour.Enabled:= false;
      actButtonColour.Enabled:= false;
      actButtonFont.Enabled:= false;
      chkHomeAfterClick.Enabled:= false;
    end
    else begin
      edtKeyText.Enabled:= true;
      edtKeyText.Text:= ButtonArray.SelectedButton.Caption;
      rbNone.Enabled:= true;
      rbProduct.Enabled:= true;
      rbKeypad.Enabled:= true;
      rbFunction.Enabled:= true;
      grdSelect.Visible:= true;
      actFontColour.Enabled:= true;
      actButtonColour.Enabled:= true;
      actButtonFont.Enabled:= true;
      chkHomeAfterClick.Enabled:= rbProduct.Checked or rbFunction.Checked;
      chkHomeAfterClick.Checked:= ButtonArray.SelectedButtonConfig.B['HomeAfterClick'];
    end;

    if Assigned(ButtonArray.SelectedButton) then begin
      rbNone.Enabled:= true;
      rbProduct.Enabled:= true;
      rbKeypad.Enabled:= true;
      rbFunction.Enabled:= true;
    end;

  finally
    fDoingUpdateDisplay:= false;
  end;
end;

end.
