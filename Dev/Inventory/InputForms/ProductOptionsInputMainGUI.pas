unit ProductOptionsInputMainGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DBCtrls, Grids, DBGrids, Wwdbigrd, Wwdbgrid,
  DNMSpeedButton, DNMPanel, Shader;

type
  TfrmProductOptionsMain = class(TBaseInputGUI)
    dsProductHeader: TDataSource;
    dsProductDetails: TDataSource;
    qryProductHeader: TERPQuery;
    qryProductDetails: TERPQuery;
    qryGeneral: TERPQuery;
    BasePanel: TDNMPanel;
    Panel1: TDNMPanel;
    Configure: TLabel;
    lbConfig: TListBox;
    qryProductDetailsid: TIntegerField;
    qryProductDetailsid_header: TIntegerField;
    qryProductDetailsOptionName: TWideStringField;
    qryProductDetailsOptionAbbreviation: TWideStringField;
    qryProductDetailsActive: TWideStringField;
    qryProductDetailsCost: TFloatField;
    qryProductDetailsPrice: TFloatField;
    pnlFooter: TDNMPanel;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryProductHeaderActive: TWideStringField;
    qryProductHeaderDisplayType: TWideStringField;
    OptionsListPanel: TDNMPanel;
    dbgProductGrid: TwwDBGrid;
    ProductDesignPanel: TDNMPanel;
    GridPanel: TDNMPanel;
    LeftPanel: TDNMPanel;
    dbgProductHeader: TwwDBGrid;
    RightPanel: TDNMPanel;
    dbgProductDetails: TwwDBGrid;
    Panel4: TDNMPanel;
    Label1: TLabel;
    dbcListStyle: TComboBox;
    DBCheckBox1: TDBCheckBox;
    dsProducts: TDataSource;
    qryProducts: TERPQuery;
    qryProductsPARTSID: TIntegerField;
    qryProductsPARTNAME: TWideStringField;
    qryProductsProductPrintName: TWideStringField;
    qryProductsCOST1: TFloatField;
    qryProductsPRICE1: TFloatField;
    btnEdit: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    qryProductsPARTSDESCRIPTION: TWideStringField;
    qryProductHeaderid: TIntegerField;
    qryProductHeaderOptionTemplateName: TWideStringField;
    qryProductHeaderOptionTemplateDesc: TWideStringField;
    procedure qryProductHeaderAfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbConfigClick(Sender: TObject);
    procedure qryProductDetailsBeforePost(DataSet: TDataSet);
    procedure qryProductDetailsOptionNameChange(Sender: TField);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qryProductHeaderAfterOpen(DataSet: TDataSet);
    procedure qryProductHeaderBeforePost(DataSet: TDataSet);
    procedure dbcListStyleChange(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure dbgProductGridDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure mnuCopyToClipboardClick(Sender: TObject);
    procedure mnuPasteFromClipboardClick(Sender: TObject);
    procedure mnuDeleteClick(Sender: TObject);
  private
    { Private declarations }
    FShowPrices : Boolean;
    FShowCosts  : Boolean;
    FCanWrite   : Boolean;
    procedure DoConfigRefresh(Sender: TObject);
    procedure ConvertDisplayStyle(ADisplay: string);
    procedure BeforeOpenDesignGUI(Sender: TObject);
  public
    { Public declarations }
  end;

var
  frmProductOptionsMain: TfrmProductOptionsMain;

implementation

uses
   DNMExceptions, FormFactory,
  Math, ChartOfAccountsListForm, frmChartOfAccountsFrm,
  CommonDbLib, frmRepeat,  PaymentsLibGUI, CommonLib,  AppEnvironment,
  FastFuncs, BaseFormForm, BusObjConst, tcConst, DNMLib, CommonFormLib,
  TransAuditTrail, ClipBrd, Types, StringUtils, clipboardLib, ProductOptionsDEsignGUI;
{$R *.dfm}

procedure TfrmProductOptionsMain.btnCancelClick(Sender: TObject);
begin
  inherited;
  self.RollbackTransaction;
  Self.Close;
end;

procedure TfrmProductOptionsMain.btnEditClick(Sender: TObject);
begin
  inherited;
  CommonFormLib.OpenERPFormModal('TfrmProductOptionsDesignGUI', 0, BeforeOpenDesignGUI, False, Nil);
  DoConfigRefresh(Sender);
end;

procedure TfrmProductOptionsMain.BeforeOpenDesignGUI(Sender: TObject);
begin
  If not (Sender is TfrmProductOptionsDesignGUI) then exit;
  With Sender as TfrmProductOptionsDesignGUI do begin
    edPartsId.Text := qryProducts.FieldByName('PartsId').Asstring;
  end;
end;

procedure TfrmProductOptionsMain.btnNewClick(Sender: TObject);
begin
  inherited;
//  sMsg := 'To Create A New Product Option, tick the Product Option Tick Box ' +
//          'at the Bottom of your base Product Card. Ie If you want to create ' +
//          'options for "Beds", make a product card called "Beds" and tick the ' +
//          'Product Option box. ';
//  With qryGeneral do begin
//    Close;
//    SQL.Text := 'SELECT COUNT(*) as kount FROM tblparts WHERE HasProductOptions = "T" ';
//    Open;
//    if FieldByName('kount').AsInteger = 0 then begin
//      CommonLib.MessageDlgXP_Vista(sMsg, mtInformation, [mbOK], 0);
//      exit;
//    end;
//  end;
  CommonFormLib.OpenERPForm('TfrmProductOptionsDesignGUI', 0, Nil, Nil, True);
end;

procedure TfrmProductOptionsMain.btnOKClick(Sender: TObject);
begin
  inherited;
  if qryProductHeader.State in [dsEdit, dsInsert] then qryProductHeader.Post;
  if qryProductDetails.State in [dsEdit, dsInsert] then qryProductDetails.Post;
  self.CommitTransaction;
  Close;
end;

procedure TfrmProductOptionsMain.dbcListStyleChange(Sender: TObject);
begin
  inherited;
  qryProductHeader.edit;
  qryProductHeader.FieldByName('DisplayType').AsString := Copy(dbcListStyle.Text,1,1);
  qryProductHeader.Post;
end;

procedure TfrmProductOptionsMain.FormActivate(Sender: TObject);
begin
  inherited;
  lbConfigClick(Nil);
end;

procedure TfrmProductOptionsMain.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmProductOptionsMain.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := True;
end;

procedure TfrmProductOptionsMain.FormCreate(Sender: TObject);
var
  i            : integer;
begin
  AllowCustomiseGrid         := true;
//  GridstoExcludefromcustomize := 'dbgProductHeader, dbgProductGrid';
  GridstoExcludefromcustomize := 'dbgProductGrid';
  FCanWrite   := (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnAllowProductOptions') < 2);
  FShowPrices := (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnShowProductOptionsPrices') < 2);
  FShowCosts  := (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnShowProductOptionsCosts') < 2);

  inherited;
  //GuiPrefs.Elements.Add('TwwDbGridGuiElement', dbgProductHeader);
  GuiPrefs.Elements.Add('TwwDbGridGuiElement', dbgProductGrid);
  fbTabSettingEnabled        := False;
  qryProductHeader.Active    := True;
  lbConfig.ItemIndex         := 0;


  if FCanWrite then begin
    if Assigned(dbgProductDetails.Popupmenu) then begin
       for i := 0 to dbgProductDetails.PopupMenu.Items.count -1 do begin
         if StringReplace(dbgProductDetails.PopupMenu.Items[i].caption, '&', '', [rfReplaceAll]) = 'Delete' then begin
            dbgProductDetails.PopUpMenu.Items[i].OnClick := mnuDeleteClick;
            break;
         end;
       end;
    end;
    if Assigned(dbgProductHeader.Popupmenu) then begin
       for i := 0 to dbgProductHeader.PopupMenu.Items.count -1 do begin
         if StringReplace(dbgProductHeader.PopupMenu.Items[i].caption, '&', '', [rfReplaceAll]) = 'Delete' then begin
            dbgProductDetails.PopUpMenu.Items[i].OnClick := mnuDeleteClick;
            break;
         end;
       end;
    end;

  end;
end;

procedure TfrmProductOptionsMain.FormShow(Sender: TObject);
begin
  inherited;
  CustomiseGrid.Visible := False;
  if not FShowPrices then begin
    GuiPrefs.DbGridElement[dbgProductDetails].RemoveFields('Price');
    GuiPrefs.DbGridElement[dbgProductGrid].RemoveFields('Price1');
  end;

  if not FShowCosts then begin
    GuiPrefs.DbGridElement[dbgProductDetails].RemoveFields('Cost');
    GuiPrefs.DbGridElement[dbgProductGrid].RemoveFields('Cost1');
  end;

  if not FCanWrite then begin
    dbgProductDetails.KeyOptions := [];
    dbgProductHeader.KeyOptions  := [];
  end;

  dbgProductHeader.ReadOnly  := not FCanWrite;
  dbgProductDetails.ReadOnly := not FCanWrite;
  qryProductHeader.ReadOnly  := not FCanWrite;
  qryProductDetails.ReadOnly := not FCanWrite;

  btnOK.Enabled              := FCanWrite;
  btnNew.Enabled             := FCanWrite;
  lbConfigClick(Nil);
end;

procedure TfrmProductOptionsMain.qryProductDetailsBeforePost(DataSet: TDataSet);
begin
  inherited;
  if qryProductHeader.State in [dsInsert, dsEDit] then qryProductHeader.post;

  With qryProductDetails do begin
    if FieldByName('id_header').IsNull then FieldByName('id_header').AsInteger := qryProductHeader.FieldByName('id').ASInteger;
  end;
end;

procedure TfrmProductOptionsMain.qryProductDetailsOptionNameChange(
  Sender: TField);
begin
  inherited;
  With qryProductDetails do begin
    FieldByName('OptionAbbreviation').AsString :=  Copy(FieldByName('OptionName').AsString,1,25);
  end;
end;

procedure TfrmProductOptionsMain.qryProductHeaderAfterOpen(DataSet: TDataSet);
begin
  inherited;
  ConvertDisplayStyle(Dataset.FieldByName('DisplayType').AsString);
end;

procedure TfrmProductOptionsMain.ConvertDisplayStyle(ADisplay: string);
begin
  if ADisplay = 'S' then dbcListStyle.ItemIndex := 0 else
  if ADisplay = 'L' then dbcListStyle.ItemIndex := 1 else
                         dbcListStyle.ItemIndex := 0;
end;

procedure TfrmProductOptionsMain.qryProductHeaderAfterScroll(DataSet: TDataSet);
begin
  inherited;
  ConvertDisplayStyle(Dataset.FieldByName('DisplayType').AsString);
  With qryProductDetails do begin
    Close;
    ParamByName('pIdHeader').AsInteger := qryProductHeader.FieldByName('id').ASInteger;
    Open;
  end;
end;

procedure TfrmProductOptionsMain.qryProductHeaderBeforePost(DataSet: TDataSet);
begin
  inherited;
  if Dataset.FieldByName('DisplayType').AsString = '' then begin
    Dataset.edit;
    Dataset.FieldByName('DisplayType').AsString := Copy(dbcListStyle.Text,1,1);
  end;
end;

procedure TfrmProductOptionsMain.dbgProductGridDblClick(Sender: TObject);
begin
  inherited;
  DisableForm;
  try
    btnEditClick(Sender);
  finally
    EnableForm;
  end;
end;

procedure TfrmProductOptionsMain.lbConfigClick(Sender: TObject);
begin
  ProductDesignPanel.Visible  := False;
  OptionsListPanel.Visible    := False;
  qryProductHeader.Close;
  qryProductDetails.Close;
  qryProducts.Close;

  qryProductHeader.Open;
  qryProductDetails.Open;
  qryProducts.Open;

  if lbConfig.ItemIndex = 0 then begin
    TitleLabel.Caption         := 'Setup' ;
    ProductDesignPanel.Visible := True;
    ProductDesignPanel.Parent  := BasePanel;
    ProductDesignPanel.Align   := alClient;
    setlength(buttons, 2);
    buttons[0]                 := btnOK.Name;
    buttons[1]                 := btnCancel.Name;
    CentraliseButtons(pnlFooter,0,0,4);
    btnNew.Visible             := False;
    btnEdit.Visible            := False;
    btnOK.BringToFront;
    btnCancel.BringToFront;
  end else if lbConfig.ItemIndex = 1 then begin
    TitleLabel.Caption         := 'Created Options';
    OptionsListPanel.Visible   := True;
    OptionsListPanel.Parent    := BasePanel;
    OptionsListPanel.Align     := alClient;
    btnNew.Visible             := True;
    btnEdit.Visible            := True;
    btnEdit.Enabled            := qryProducts.RecordCount > 0;
    setlength(buttons, 4);
    buttons[0]                 := btnOK.Name;
    buttons[1]                 := btnEdit.Name;
    buttons[2]                 := btnNew.Name;
    buttons[3]                 := btnCancel.Name;
    CentraliseButtons(pnlFooter,0,0,4);
  end;
end;

procedure TfrmProductOptionsMain.mnuCopyToClipboardClick(Sender: TObject);
begin
  inherited;
  QryToClipBoard(qryProductdetails);
end;

procedure TfrmProductOptionsMain.mnuDeleteClick(Sender: TObject);
begin
  inherited;
  if ActiveControl = dbgProductDetails then begin
    With qryProductDetails do begin
      if not Active then exit;
      if RecordCount = 0 then exit;
      if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtWarning, [mbYes, mbNo, mbCancel], 0) = mrYes then
        Delete;
    end;
  end else
  if ActiveControl = dbgProductHeader then begin
    With qryProductHeader do begin
      if not Active then exit;
      if RecordCount = 0 then exit;
      if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtWarning, [mbYes, mbNo, mbCancel], 0) = mrYes then begin
        With qryGeneral do begin
          SQL.Text := 'DELETE FROM tblProductOptionDetails WHERE id_header = ' +  qryProductHeader.FieldBYName('id').AsString;
          ExecSQL;
        end;
        Delete;
      end;
    end;
  end;
end;

procedure TfrmProductOptionsMain.mnuPasteFromClipboardClick(Sender: TObject);
begin
  inherited;
  if AccessLevel > 2 then exit;
  ClipBoardtoQry(qryProductdetails);
end;

procedure TfrmProductOptionsMain.DoConfigRefresh(Sender: TObject);
begin
  qryProducts.Close;
  qryProducts.Open;
end;

initialization
  RegisterClassOnce(TfrmProductOptionsMain);
end.
