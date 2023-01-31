unit ProductOptionsDesignGUI;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, AppEvnts, DB,   StdCtrls,
  Buttons, DNMSpeedButton, wwdbdatetimepicker, ExtCtrls, DNMPanel, wwclearbuttongroup,
  wwradiogroup, Mask, DBCtrls, Wwdbigrd, Grids, Wwdbgrid, wwdblook,
  SelectionDialog, ActnList, Menus, AdvMenus, MyAccess,ERPdbComponents, MemDS, DBAccess,
  DataState, MessageConst, BusObjGeneral, Shader,
  BusObjBase, dmGUIStylers, BusobjJournal, ImgList, ERPDbLookupCombo,
  ProgressDialog, wwcheckbox, wwdbedit, ComCtrls, Generics.Collections,
  Wwdotdot, Wwdbcomb, DNMSizeablePanel, busobjsalebase, busobjOrders,
  VirtualTable;

const
  SBDESIGN_DESTROY = WM_USER + 201;

type
  TConfigList = class;

  TConfig = class(TObject)
    id           : integer;
    parentId     : integer;
    OptionName   : string;
    OptionAbbrev : string;
    OptionCost   : Extended;
    OptionPrice  : Extended;
    ObjectType   : string;
    TemplateName : string;
    TemplateDesc : string;
  public
  end;
  TConfigList = class(TList<TConfig>);

  TfrmProductOptionsDesignGUI = class(TBaseInputGUI)
    lsTDNMSpeedButtonActions: TActionList;
    actMemTrans: TAction;
    actMemTransAuto: TAction;
    pnlTitle: TDNMPanel;

    popMemTrans: TAdvPopupMenu;
    MemorizeTransaction1: TMenuItem;
    MemorizeAutoTransaction1: TMenuItem;
    mnuAuditTrail: TMenuItem;
    mnuCopyToClipboard: TMenuItem;
    mnuPasteFromClipboard: TMenuItem;
    pnlProduct: TDNMPanel;
    lbProduct: TLabel;
    lbProductName: TLabel;
    lbEdCost: TLabel;
    lbEdPrice: TLabel;
    edProductName: TDBEdit;
    edCost: TDBEdit;
    edPrice: TDBEdit;
    tvProduct: TTreeView;
    ToolPanel: TDNMPanel;
    sbDesign: TScrollBox;
    pnlName: TDNMPanel;
    Label4: TLabel;
    lbOptionCost: TLabel;
    lbOptionPrice: TLabel;
    edOPtionName: TEdit;
    edOPtionPrice: TEdit;
    edOptionCost: TEdit;
    qryGeneral: TERPQuery;
    ERPQuery1: TERPQuery;
    cboProductQry: TERPQuery;
    dsProductDetails: TDataSource;
    rgLevel: TRadioGroup;
    btnAdd: TDNMSpeedButton;
    btnEdit: TDNMSpeedButton;
    btnDelete: TDNMSpeedButton;
    edPartsID: TEdit;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cbProduct: TERPDbLookupCombo;
    qryProductLookup: TERPQuery;
    qryProductLookupPARTSID: TIntegerField;
    qryProductLookupPARTNAME: TWideStringField;
    qryProductLookupCOST1: TFloatField;
    qryProductLookupPRICE1: TFloatField;
    cboProductQryPARTSID: TIntegerField;
    cboProductQryPARTNAME: TWideStringField;
    cboProductQryCOST1: TFloatField;
    cboProductQryPRICE1: TFloatField;
    dnmAddOption: TDNMPanel;
    btnAddFromTemplate: TDNMSpeedButton;
    cbTemplates: TComboBox;
    cbAddAllLevel: TCheckBox;
    btnClose: TDNMSpeedButton;
    btnCompleted: TDNMSpeedButton;
    VTable: TVirtualTable;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    //procedure FormCreate(Sender: TObject);
    //procedure FormDestroy(Sender: TObject);

    procedure OptionPanelClick(Sender: TObject);
    procedure btnAddFromTemplateClick(Sender: TObject);
    procedure cbProductChange(Sender: TObject);
    procedure tvProductClick(Sender: TObject);
    procedure tvProductDeletion(Sender: TObject; Node: TTreeNode);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure PostPonedPanelClick(var Message: TMessage); message SBDESIGN_DESTROY;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure comboDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure rgLevelClick(Sender: TObject);
    procedure cbProductBeforeOpenList(Sender: TObject);
    procedure cbTemplatesChange(Sender: TObject);
    procedure cbProductAfterOpenList(Sender: TObject);
    procedure FormResize(Sender: TObject);

    private
      { Private declarations }
      fbChangesMade: boolean;
      FAddTemplateClicked : Boolean;
      ProductConfig : TConfigList;
      FShowPrices   : Boolean;
      FShowCosts    : Boolean;
      FCanWrite     : Boolean;
      MaxId         : Integer;
      FNew          : Boolean;
      FCost         : Extended;
      FPrice        : Extended;
      FProductName  : string;
      FPartName     : string;
      FPartDesc     : string;
      FNewProductId : Integer;
      FFromOptions  : Boolean;
      procedure BuildTreeView(ProgDlg: TProgressDialog);
      procedure BuildPanels;
      procedure PopulateCostName;
      procedure DestroyChildObjects(AParent: TComponent);
      function  CreateStandardChildPanel(AParent: TComponent; ATag: Integer) : TPanel;
      function  CreateTopLevel(AParentPanel: TPanel; ATopLine: TConfig) : TPanel;
      procedure CreateLabels(APanel: TPanel; ALine: TConfig);
      procedure CreateLabelsList(APanel: TPanel; ALine: TConfig);
      function  CreateLabel(APanel: TPanel) : TLabel;
      procedure FillInFromTemplate (ATemplateId: Integer; AChildList: TConfigList; var AObjectTYpe: string);
      procedure CreatePanels(oParentPanel: TPanel;ANode : TTreeNode; AObjectType: string);
      procedure CreateList(oParentPanel: TPanel;ANode : TTreeNode);
      function  FindParentNode(AParentId: Integer) : TTreeNode;
      function  FindNode(AId: Integer) : TTreeNode;
      procedure BeforeShowProc(Sender : TObject);
      procedure AfterResultOKAdd(Sender : TObject);
      procedure AfterResultOKEdit(Sender : TObject);
      procedure AddOption(AThisNode: TTreeNode; ACurrentNode: TTreeNode;  ALines: TConfigList; AObjectType: string);
      function NodeExists(AParentNode: TTreeNode; AText: string) : Boolean;
      procedure AddFromTemplate(ThisNode: TTreeNode; ALines: TConfigList; AObjectType: string);
      procedure ReadguiPref;
      procedure WriteGuiPrefs;

  Protected

  public
    { Public declarations }
    fbFormClosing: boolean;
    property NewProductId : Integer read FNewProductId;
    property FromOptions  : Boolean read FFromOptions write FFromOptions;
    class function DoProductOption(const AOwner:TBaseInputGUI; const Lineobj: TSalesLineBase):Integer; overload; //const productID: Integer): integer;
    class function DoProductOption(const AOwner:TBaseInputGUI; const Lineobj: TPurchaseOrderLine):Integer; overload;//const productID: Integer): integer;

  end;

implementation

uses
   DNMExceptions, FormFactory,  Math,   CommonDbLib, frmRepeat,  CommonLib,  AppEnvironment,
  FastFuncs, BaseFormForm, BusObjConst, tcConst, DNMLib, CommonFormLib, SystemLib,
   ClipBrd, Types, StringUtils, clipboardLib, ProductOptionsInputGUI, BusObjStock, ProductListExpressForm;


{$R *.dfm}

const
   PANEL_HEIGHT              = 60;
   PANEL_WIDTH               = 200;
   LABEL_WIDTH               = 200;
   LIST_PANEL_HEIGHT         = 50;
   FONT_NAME                 = 'Arial';
   FONT_SIZE                 = 8;
   SELECTED_BACKGROUND_COLOR = clGreen;
   SELECTED_FONT_COLOR       = clWhite;
   STRING_SEPARATOR          = '|'; // do not use , or . since they are part of amount fields
   sProductSQL               = 'SELECT P.PartsId, P.PARTNAME,P.COST1,P.PRICE1 FROM tblParts P ';

function  TfrmProductOptionsDesignGUI.NodeExists(AParentNode: TTreeNode; AText: string) : Boolean;
var
  ThisChildNode : TTreeNode;
begin
  Result := False;
  ThisChildNode := AParentNode.GetFirstChild;
  while ThisChildNode <> Nil do begin
    if TConfig(ThisChildNode.Data).OptionName = AText then begin
       Result := True;
       break;
    end;
    ThisChildNode := ThisChildNode.GetNextSibling;
  end;
end;

procedure TfrmProductOptionsDesignGUI.AddOption(AThisNode: TTreeNode;
  ACurrentNode: TTreeNode;   ALines: TConfigList; AObjectType: string);
var
  i              : integer;
  Config         : TConfig;
  NewNode        : TTreeNode;
  WorkingNode    : TTreeNode;
begin
  if rgLevel.ItemIndex = 0 then WorkingNode := AcurrentNode
  else                          WorkingNode := AThisNode;
  TConfig(WorkingNode.Data).ObjectType := AObjectType;
  for I := 0 to ALines.Count -1 do begin
    if NodeExists(WorkingNode,ALines[i].OptionName) then Continue;
    Config              := TConfig.Create;
    Config.OptionName   := ALines[i].OptionName;
    Config.OptionAbbrev := ALines[i].OptionAbbrev;
    Config.OptionCost   := ALines[i].OptionCost;
    Config.OptionPrice  := ALines[i].OptionPrice;
    Config.ObjectType   := ALines[i].ObjectType;
    Config.TemplateName := ALines[i].TemplateName;
    Config.TemplateDesc := ALines[i].TemplateDesc;
    NewNode             := tvProduct.Items.AddChild(WorkingNode, Config.OptionName);
    Config.parentId     := TConfig(WorkingNode.Data).Id;
    Inc(MaxId);
    Config.id           := MaxId;

    if NewNode <> Nil then begin
      NewNode.Data     := Config;
      VTable.Append;
      VTable.FieldByName('Node').ASInteger := Integer(NewNode);
      VTable.FieldByName('id').ASInteger := TConfig(NewNode.Data).id;
      VTable.Post;
      //NewNode.Selected := True;
    end;
  end;
end;

procedure TfrmProductOptionsDesignGUI.AddFromTemplate(ThisNode: TTreeNode; ALines: TConfigList; AObjectTYpe: string);
begin
  if ((cbAddAllLevel.Checked) and (ThisNode <> Nil)) then begin
     AddOption(ThisNode, ThisNode, ALines, AObjectTYpe);
  end else begin
    AddOption(ThisNode, ThisNode, ALines, AObjectTYpe);
  end;
end;

procedure TfrmProductOptionsDesignGUI.btnAddFromTemplateClick(Sender: TObject);
var
  ThisNode       : TtreeNode;
  NodeList       : TList<TTreeNode>;
  i              : Integer;
  ProgDlg        : TProgressDialog;
  oLines         : TConfigList;
  sObjectType    : string;
  ThisObj        : TObject;
  TargetNode     : TTreeNode;
begin
  if tvProduct.Selected = Nil then  exit;
  FAddTemplateClicked := True;
  if cbTemplates.ItemIndex < 0 then begin
     cbTemplates.DroppedDown := True;
     exit;
  end;

  ThisNode        := tvProduct.Selected;
  //tvProduct.FullCollapse;
  if ((rgLevel.ItemIndex = 1) and (ThisNode.Parent = Nil)) then begin
     CommonLib.MessageDlgXP_Vista('You cannot add items at the product level.', mtInformation,
     [mbOK], 0);
     FAddTemplateClicked := False;
     exit;
  end;
  ProgDlg := TProgressDialog.Create(Nil);
  tvProduct.Visible := False;
  tvProduct.Items.BeginUpdate;
  try
    // create a list of nodes at the same level
    NodeList := TList<TTreeNode>.Create;
    oLines   := TConfigList.Create;
    try
      for i := 0 to tvProduct.Items.Count -1 do begin
         if rgLevel.ItemIndex = 0 then begin
           if tvProduct.Items[i].Level = ThisNode.Level then
              NodeList.Add(tvProduct.Items[i]);
         end else begin
           if tvProduct.Items[i].Level = ThisNode.Level-1 then
              NodeList.Add(tvProduct.Items[i]);
         end;
      end;
      ProgDlg.Caption  := 'Adding Options from Template';
      ProgDlg.MaxValue := NodeList.Count;
      ProgDlg.Value    := 1;
      //ProgDlg.Step    := 1;
      ProgDlg.TimerUpdate := true;
      ProgDlg.Execute;
      //LastNodeId      := 0;
      sObjectTYpe     := 'S';
      ThisObj         := cbTemplates.Items.Objects[cbTemplates.ItemIndex];
      FillInFromTemplate(Integer(ThisObj), oLines, sObjectTYpe);
      TConfig(ThisNode.Data).ObjectType := sObjectTYpe;
      if NodeList.Count > 0 then begin
         for i := 0 to NodeList.Count -1 do begin
           //for j := LastNodeId to tvProduct.Items.Count -1 do begin
             TargetNode := FindParentNode(TConfig(NodeList[i].Data).id);
             if TargetNode <> Nil then begin
               //LastNodeId := j;
               AddFromTemplate(TargetNode, oLines, sObjectType);
               ProgDlg.Value       := i;
               ProgDlg.TimerUpdate := true;
               ProgDlg.Execute;
               //break;
             end;
           //end;
         end;
      end;
    finally
      ProgDlg.Value       := NodeList.Count;
      ProgDlg.TimerUpdate := true;
      ProgDlg.Execute;
      NodeList.Free;
      oLines.Free;
    end;
    BuildPanels;
  finally
    tvProduct.Items.EndUpdate;
    tvProduct.Visible := True;
    ProgDlg.Free;
    Self.BringToFront;
    tvProduct.SetFocus;
  end;
  FAddTemplateClicked := False;
end;

procedure TfrmProductOptionsDesignGUI.DestroyChildObjects(AParent: TComponent);
var
  i : integer;
begin
  for i := AParent.ComponentCount -1 downto 0 do begin
    if AParent.Components[i] is TPanel then begin
      AParent.Components[i].Free;
    end;
  end;
end;
{ TfrmProductOptionsDesignGUI }

procedure TfrmProductOptionsDesignGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fbFormClosing := true;
  WriteGuiPrefs;
  inherited;
  CloseQueries;
  Action := caFree;
end;

procedure TfrmProductOptionsDesignGUI.btnCloseClick(Sender: TObject);
var 
  iExitResult: integer;
begin
  DisableForm;
  try
    inherited;
    if fbChangesMade then begin
      iExitResult := CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation,
        [mbYes, mbNo, mbCancel], 0);
      case iExitResult of
        mrYes: btnCompleted.Click;
        mrNo:
          begin;
            RollbackTransaction;
            Close;
          end;
        mrCancel: Exit;
      end;
    end else begin
      Close;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmProductOptionsDesignGUI.FormShow(Sender: TObject);
begin
  inherited;
  DisableForm;
  try
    cbProduct.Visible := (edPartsId.Text = '');
    lbProduct.Visible := cbProduct.Visible;
    if not cbProduct.Visible then begin
      cbProductChange(cbProduct);
      //tvProduct.SetFocus;
    end else begin
      with cboProductQry do begin
        Close;
        SQL.Text := sProductSQL + ' where partsid = -1';
        Open;
      end;
      //cbProduct.ItemIndex := -1;
      //cbProductChange(cbProduct);
    end;
    btnCompleted.Visible := ((FFromOptions and FCanWrite) or (not FFromOptions));
    rgLevel.Visible      := FCanWrite;
    btnAdd.Visible       := FCanWrite;
    btnEdit.Visible      := FCanWrite;
    btnDelete.Visible    := FCanWrite;
    dnmAddOption.Visible := FCanWrite;
    cbAddAllLevel.Visible:= FCanWrite;

    if FFromOptions then begin
       btnCompleted.Caption := 'Save Configuration';
    end else begin
       btnCompleted.Caption := 'Create Product';
    end;
    ReadguiPref;
  finally
    EnableForm;
    cbTemplates.BringToFront;
  end;
end;

procedure TfrmProductOptionsDesignGUI.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
  if not btnClose.Enabled then begin
    CommonLib.MessageDlgXP_Vista('You Cannot Cancel this Conversion. You must Click ''Save''', mtWarning, [mbOK], 0);
    CanClose := false;
    Exit;
  end;
end;


procedure TfrmProductOptionsDesignGUI.FormCreate(Sender: TObject);
begin
  inherited;
  FNewProductId := -1;
  FCanWrite   := (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnAllowProductOptions') < 2);
  FShowPrices := (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnShowProductOptionsPrices') < 2);
  FShowCosts  := (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnShowProductOptionsCosts') < 2);

  FFromOptions  := True;
  qryProductLookup.Close;
  qryProductLookup.Open;

  ProductConfig := TConfigList.Create;

  With cbTemplates do begin
    Clear;
    With qryGeneral do begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT OptionTemplateName,  id from tblproductoptionheader  ';
      Open;
      while not EOF do  begin
        cbTemplates.Items.AddObject(FieldBYName('OptionTemplateName').AsString, TObject(FieldBYName('id').ASInteger));
        Next;
      end;
    end;
  end;
  With qryGeneral do begin
    Close;
    SQL.Clear;
    SQL.Text := 'SELECT Coalesce(Max(id),0) MaxId FROM tblproductheaderdetails  ';
    Open;
    MaxId := FieldBYName('MaxId').ASInteger;
  end;
  lbEdCost.Visible      := FShowCosts;
  lbEdPrice.Visible     := FShowprices;
  lbOptionCost.Visible  := FShowCosts;
  lbOptionPrice.Visible := FShowprices;
  EdCost.Visible        := FShowCosts;
  EdPrice.Visible       := FShowprices;
  edOptionCost.Visible  := FShowCosts;
  edOptionPrice.Visible := FShowprices;

end;

procedure TfrmProductOptionsDesignGUI.FormDestroy(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to tvProduct.Items.Count -1 do begin
    TConfig(tvProduct.Items[i].Data).Free;
  end;
  if ProductConfig <> Nil then begin
    FreeAndNil(ProductConfig);
  end;
  inherited;
end;

procedure TfrmProductOptionsDesignGUI.FormResize(Sender: TObject);
begin
  inherited;
  BuildPanels;
end;

procedure TfrmProductOptionsDesignGUI.OptionPanelClick(Sender: TObject);
var
  ThisTag : Integer;
begin

  if Sender is TPanel then begin
    ThisTag := TPanel(Sender).Tag;
    FindNode(ThisTag);
    PostMessage(self.Handle, SBDESIGN_DESTROY, ThisTag, 0);
    //BuildPanels;
  end
  else if Sender is TComboBox then  begin
    ThisTag := TConfig(TComboBox(Sender).Items.Objects[TComboBox(Sender).ItemIndex]).id;
    TPanel(TComboBox(Sender).Parent).Tag := ThisTag;
    FindNode(ThisTag);
    CreateLabelsList(TPanel(TComboBox(Sender).Parent), TConfig(TComboBox(Sender).Items.Objects[TComboBox(Sender).ItemIndex]));
    PopulateCostName;
    PostMessage(self.Handle, SBDESIGN_DESTROY, ThisTag, 0);
  end
  else begin
    ThisTag := TControl(Sender).Parent.Tag;
    FindNode(ThisTag);
    PostMessage(self.Handle, SBDESIGN_DESTROY, ThisTag, 0);
  end;
end;

procedure TfrmProductOptionsDesignGUI.PopulateCostName;
var
  ThisNode    : TTreeNode;
  NodeList    : TList<TTreeNode>;
  Config      : TConfig;
  ParentNode  : TTreeNode;
  i           : Integer;
begin
  if tvProduct.Selected = Nil then exit;
  FProductName := '';
  FCost        := 0;
  FPrice       := 0;
  FpartName    := '';
  FPartDesc    := '';
  ThisNode := tvProduct.Selected;
  NodeList := TList<TTreeNode>.Create;
  NodeList.Add(ThisNode);
  try
  //get a list of config items who are siblings + parents + 1 level below
    while (1=1) do begin
      ParentNode    := ThisNode.Parent;
      if ParentNode = Nil then break;
      NodeList.Add(ParentNode);
      ThisNode      := ParentNode;
    end;
    for i := NodeList.Count -1 downto 0 do begin
      ThisNode    := NodeList[i];
      Config      := TConfig(ThisNode.Data);
      FCost       := FCost + Config.OptionCost;
      FPrice      := FPrice + Config.OptionPrice;

      edOptionCost.Text := Format('%m', [FCost]);
      edOPtionPrice.Text := Format('%m', [FPrice]);
    end;
    FPartName := cbProduct.Text;
    FPartDesc := 'Model: ' + cbProduct.Text + ' (';
    for i := NodeList.Count -2 downto 0 do begin
      ThisNode    := NodeList[i];
      Config      := TConfig(ThisNode.Data);
      FProductName := FProductName + ' | ' + Config.OptionAbbrev;
      FPartName    := FPartName + Config.OptionAbbrev;
      if i = 0 then
        FPartDesc := FPartDesc + Config.TemplateDesc +': ' + Config.OptionName
      else
        FPartDesc := FPartDesc + Config.TemplateDesc +': ' + Config.OptionName + ' | ';
    end;
    if Trim(Copy(FProductName,3,Length(FProductName))) <> '' then
      edOptionName.Text := cbProduct.Text +  ' (' + Trim(Copy(FProductName,3,Length(FProductName))) + ')'
    else
      edOptionName.Text := cbProduct.Text;
    FPartName := StringReplace(FPartName, ' ', '', [rfReplaceAll]);
    FPartDesc := FPartDesc + ')';
  finally
    NodeList.Free;
  end;
end;

procedure TfrmProductOptionsDesignGUI.rgLevelClick(Sender: TObject);
begin
  inherited;
  cbAddAllLevel.Checked := (rgLevel.ItemIndex = 0);
  cbAddAllLevel.Enabled := (rgLevel.ItemIndex = 0);
end;

procedure TfrmProductOptionsDesignGUI.tvProductClick(Sender: TObject);
begin
  BuildPanels;
end;

procedure TfrmProductOptionsDesignGUI.tvProductDeletion(Sender: TObject; Node: TTreeNode);
begin
  TConfig(Node.Data).Free;
end;

function  TfrmProductOptionsDesignGUI.CreateStandardChildPanel(AParent: TComponent; ATag: Integer) : TPanel;
var
  oPanel : TPanel;
begin
  oPanel                  := TPanel.Create(AParent);
  oPanel.Parent           := sbDesign;
  oPanel.Top              := TControl(AParent).Top + TControl(AParent).Height + 5;
  oPanel.BevelOuter       := bvNone;
  oPanel.BorderStyle      := bsNone;
  oPanel.Ctl3D            := False;
  oPanel.ParentBackground := True;
  oPanel.ParentColor      := True;
  oPanel.ParentFont       := False;
  oPanel.Height           := PANEL_HEIGHT;
  oPanel.Tag              := ATag;
  oPanel.Caption          := '';
  Result                  := oPanel;
  oPanel.Align            := alTop;
  oPanel.AlignWithMargins := True;
  oPanel.OnClick          := OptionPanelClick;
end;

function  TfrmProductOptionsDesignGUI.CreateTopLevel(AParentPanel: TPanel; ATopLine: TConfig) : TPanel;
var
  oPanel : TPanel;
begin
  oPanel                    := TPanel.Create(AParentPanel);
  oPanel.Tag                := AParentPanel.Tag;
  oPanel.Parent             := AParentPanel;
  oPanel.BevelOuter         := bvNone;
  oPanel.ParentBackground   := False;
  oPanel.Ctl3D              := False;
  oPanel.Height             := PANEL_HEIGHT;
  oPanel.Width              := PANEL_WIDTH;
  oPanel.Left               := Trunc((AParentPanel.Width - oPanel.Width) / 2) -10;
  oPanel.Top                := 0;
  oPanel.Color              := SELECTED_BACKGROUND_COLOR;
  oPanel.Font.Color         := SELECTED_FONT_COLOR;
  CreateLabels(oPanel, ATopLine);
  Result                    := oPanel;
  oPanel.OnClick            := OptionPanelClick;
end;

procedure TfrmProductOptionsDesignGUI.CreateLabels(APanel: TPanel; ALine: TConfig);
var
  oLabel1      : TLabel;
  oLabel2      : TLabel;
  oLabel3      : TLabel;
begin
  oLabel1            := CreateLabel(APanel);
  oLabel1.Caption    := ALine.OptionName;
  oLabel1.Top        := 2;
  oLabel1.Font.Style := [fsBold];
//  if not (FShowPrices or FShowCosts) then oLabel1.Top := 20;

  oLabel2            := CreateLabel(APanel);
  oLabel2.Caption    := Format('Cost = %m', [Aline.OptionCost]);
  oLabel2.Top        := 20;
  oLabel2.Visible    := FShowCosts;

  oLabel3            := CreateLabel(APanel);
  oLabel3.Caption    := Format('Price = %m', [Aline.OptionPrice]);
  if FShowCosts then oLabel3.Top        := 37
  else               oLabel3.Top        := 20;
  oLabel3.Font.Style := [fsItalic];
  oLabel3.Visible    := FShowPrices;
end;

procedure TfrmProductOptionsDesignGUI.CreateLabelsList(APanel: TPanel; ALine: TConfig);
var
  oLabel2      : TLabel;
  oLabel3      : TLabel;
  i            : Integer;
begin
  for i := APanel.ControlCount -1 downto 0 do begin
    if APanel.Controls[i] is TLabel then APanel.Controls[i].Free ;
    //else if APanel.Controls[i] is TComboBox then oWidth := APanel.Controls[i].Width;
  end;
  oLabel2            := CreateLabel(APanel);
  oLabel2.Caption    := Format('Cost = %m', [Aline.OptionCost]);
  oLabel2.Top        := 10;
  oLabel2.Left       := Trunc(PANEL_WIDTH*1.8 + 40);
  oLabel2.Width      := LABEL_WIDTH;
  oLabel2.Alignment  := taLeftJustify;
  oLabel2.Visible    := FShowCosts;

  oLabel3            := CreateLabel(APanel);
  oLabel3.Caption    := Format('Price = %m', [Aline.OptionPrice]);
  if FShowCosts then  oLabel3.Top        := 27
  else                oLabel3.Top        := 10;
  oLabel3.Left       := Trunc(PANEL_WIDTH*1.8 + 40); //LABEL_WIDTH + 100;
  oLabel3.Font.Style := [fsItalic];
  oLabel3.Width      := LABEL_WIDTH;
  oLabel3.Alignment  := taLeftJustify;
  oLabel3.Visible    := FShowPrices;
end;

procedure TfrmProductOptionsDesignGUI.comboDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  Columns : TStringDynArray;
  ItemText: string;
  DC      : HDC;
  DrawRect: TRect;
begin
  ItemText  := TComboBox(Control).Items[index];
  Columns   := SplitString(ItemText, STRING_SEPARATOR);

  DC        := TComboBox(Control).Canvas.Handle;
  TComboBox(Control).Canvas.FillRect(Rect);

  DrawRect:= Rect;
  OffsetRect(DrawRect,1,0);
  DrawRect.Right:= DrawRect.Right - (DrawRect.Right - DrawRect.Left) div 2;
  DrawText(DC, Trim(Columns[0]), Length(Columns[0]), DrawRect, 0);
  if ((Length(Columns[1]) = 0) or (not (FShowPrices or FShowCosts))) then exit;
  DrawRect:= Rect;
  OffsetRect(DrawRect,1,0);
  DrawRect.Left:= DrawRect.Left + (DrawRect.Right - DrawRect.Left)
     - TComboBox(Control).Canvas.TextWidth(Trim(Columns[1])) -20;
  DrawText(DC, Trim(Columns[1]), Length(Trim(Columns[1])), DrawRect, 0);
end;

function  TfrmProductOptionsDesignGUI.CreateLabel(APanel:  TPanel) : TLabel;
var
  oLabel      : TLabel;
begin
  oLabel            := Tlabel.Create(APanel);
  oLabel.Parent     := APanel;

  oLabel.Font.Name  := FONT_NAME;
  oLabel.Font.Size  := FONT_SIZE;
  oLabel.Width      := APanel.Width;
  oLabel.AutoSize   := False;
  oLabel.Alignment  := taCenter;
  oLabel.OnClick    := OptionPanelClick;
  oLabel.Left       := 0;

  Result := oLabel;
end;

procedure TfrmProductOptionsDesignGUI.FillInFromTemplate(ATemplateId: Integer; AChildList: TConfigList; var AObjectType: string);
var
   ThisLine        : TConfig;
   ThisTemplateDesc: string;
   ThisTemplateName: string;
begin
  AChildList.Clear;

  With qryGeneral do begin
    Close;
    SQL.Text := 'SELECT * FROM tblproductoptionheader  ' +
                'WHERE id = :pid';
    ParamByName('pid').AsInteger := ATemplateId;
    Open;
    if FieldByName('DisplayTYpe').AsString <> '' then
       AObjectType := FieldByName('DisplayTYpe').AsString
    else
       AObjectType := 'S';
    ThisTemplateName := FieldByName('OptionTemplateName').AsString ;
    ThisTemplateDesc := FieldByName('OptionTemplateDesc').AsString ;
  end;
  With qryGeneral do begin
    Close;
    SQL.Text := 'SELECT * FROM tblproductoptiondetails  ' +
                'WHERE id_header = :pid';
    ParamByName('pid').AsInteger := ATemplateId;
    Open;
    while not EOF do begin
      ThisLine               := TConfig.Create;
      ThisLine.id            := FieldByName('id').AsInteger;
      ThisLine.OptionName    := FieldByName('OptionName').AsString;
      ThisLine.OptionAbbrev  := FieldByName('OptionAbbreviation').AsString;
      ThisLine.OptionCost    := FieldByName('Cost').AsExtended;
      ThisLine.OptionPrice   := FieldByName('Price').AsExtended;
      ThisLine.ObjectType    := 'S';
      ThisLine.TemplateName  := ThisTemplateName;
      ThisLine.TemplateDesc  := ThisTemplateDesc;

//      if cbTemplates.ItemIndex <> -1 then
//        ThisLine.TemplateName  := cbTemplates.Items[cbTemplates.ItemIndex];
      AChildList.Add(ThisLine);
      Next;
    end;
  end;
end;

procedure TfrmProductOptionsDesignGUI.CreatePanels(oParentPanel: TPanel;ANode : TTreeNode; AObjectType: string);
var
  oPanel       : TPanel;
  oPanelWidth  : integer;
  i            : integer;
  oLeft        : integer;
  oMaxPanels   : integer;
  oTotalPanelWidth : integer;
  ThisConfig   : TConfig;
begin
  if AObjectType = 'L' then CreateList(oParentPanel, ANode) else
  begin
    oPanelWidth      := PANEL_WIDTH;
    oMaxPanels       := Min (ANode.count, 7);
    oTotalPanelWidth := oMaxPanels*(oPanelWidth+20);
    oLeft            := Trunc((oParentPanel.Width - oTotalPanelWidth)/2)+10;
    for i := 0 to ANode.Count -1  do
    begin
      oPanel                   := TPanel.Create(oParentPanel);
      ThisConfig               := ANode[i].Data;
      oPanel.Caption           := '';
      oPanel.Tag               := ThisConfig.Id;
      oPanel.Parent            := oParentPanel;
      oPanel.Left              := oLeft;
      oPanel.Width             := oPanelWidth;
      oPanel.Height            := oParentPanel.Height;
      oPanel.Ctl3D             := False;
      oPanel.BevelOuter        := bvNone;
      oPanel.ParentColor       := False;
      oPanel.BorderStyle       := bsSingle;
      oPanel.ParentBackground  := False;
      oPanel.Color             := clBtnFace;
      oPanel.ParentFont        := False;
      oPanel.OnClick           := OptionPanelClick;
      oLeft                    := oLeft + oPanel.Width + 20;
      CreateLabels(oPanel, ThisConfig);
    end;
  end;
end;

procedure TfrmProductOptionsDesignGUI.CreateList(oParentPanel: TPanel;ANode : TTreeNode);
var
  oPanel           : TPanel;
  oPanelWidth      : integer;
  i                : integer;
  oLeft            : integer;
  oMaxPanels       : integer;
  oTotalPanelWidth : integer;
  oComboBox        : TComboBox;
  ThisConfig       : TConfig;
begin
  if (FShowPrices or FShowCosts) then
    oPanelWidth      := PANEL_WIDTH * 3
  else
    oPanelWidth      := PANEL_WIDTH * 2;
  oMaxPanels       := 1;
  oTotalPanelWidth := oMaxPanels*oPanelWidth;
  oLeft            := Trunc((oParentPanel.Width - oTotalPanelWidth)/2) - 5;
  oPanel           := TPanel.Create(oParentPanel);

  oPanel.Caption   := '';

  oPanel.Parent           := oParentPanel;
  oPanel.Left             := oLeft;
  oPanel.Width            := oPanelWidth;
  oPanel.Height           := LIST_PANEL_HEIGHT;
  oPanel.Ctl3D            := False;
  oPanel.BevelOuter       := bvNone;
  oPanel.ParentColor      := False;
  oPanel.BorderStyle      := bsSingle;
  oPanel.ParentBackground := False;
  oPanel.Color            := clBtnFace;
  oComboBox               := TComboBox.Create(oPanel);
  oComboBox.Style         := csOwnerDrawFixed;
  oComboBox.OnDrawItem    := comboDrawItem;
  oComboBox.Parent        := oPanel;
  oComboBox.Align         := alLeft;
  oComboBox.Width         := Trunc(PANEL_WIDTH*1.9);
  oComboBox.AlignWithMargins := True;
  oComboBox.Margins.Top   := 15;
  oComboBox.ParentFont    := False;
  oComboBox.Items.Clear;
  oComboBox.ParentFont    := False;
  oComboBox.Sorted        := True;
  oComboBox.OnChange      := OptionPanelClick;
  oComboBox.OnSelect      := OptionPanelClick;
  oPanel.OnClick          := OptionPanelClick;

  for i := 0 to ANode.Count -1  do
  begin
    ThisConfig := ANode[i].Data;
    if ((FShowPrices) and (FShowCosts)) then
       oComboBox.Items.AddObject(Format('%s%s%3s%m%3s%m', [Copy(ThisConfig.OptionName,1,25), STRING_SEPARATOR,
         ' ', ThisConfig.OptionPrice, ' ', ThisConfig.OptionCost]), ThisConfig)
    else if FShowPrices then
       oComboBox.Items.AddObject(Format('%s%s%3s%m', [Copy(ThisConfig.OptionName,1,25), STRING_SEPARATOR,
         ' ', ThisConfig.OptionPrice]), ThisConfig)
    else if FShowCosts then
       oComboBox.Items.AddObject(Format('%s%s%3s%m', [Copy(ThisConfig.OptionName,1,25), STRING_SEPARATOR,
         ' ', ThisConfig.OptionCost]), ThisConfig)
    else
       oComboBox.Items.AddObject(Format('%s', [Copy(ThisConfig.OptionName,1,25)]), ThisConfig);
  end;
end;

function  TfrmProductOptionsDesignGUI.FindParentNode(AParentId: Integer) : TTreeNode;
begin
  Result := Nil;
  if tvProduct.Items.Count = 0 then exit;
  if AParentId = 0 then exit;
  if VTable.Locate('id', AParentId, []) then Result := TTreeNode(VTable.FieldByName('Node').AsInteger);
end;

function  TfrmProductOptionsDesignGUI.FindNode(AId: Integer) : TTreeNode;
var
  i : Integer;
  tempConfig: TConfig;
begin
  Result := Nil;
  if tvProduct.Items.Count = 0 then exit;
  Result := tvProduct.Items[0];
  for i := 0 to tvProduct.Items.Count -1 do begin
    tempConfig := tvProduct.Items[i].Data;
    if tempConfig.id = AId then  begin
      Result := tvProduct.Items[i];
      tvProduct.Items[i].Selected := True;
      break;
    end;
  end;
end;

procedure TfrmProductOptionsDesignGUI.cbProductAfterOpenList(Sender: TObject);
var
  sMsg : string;
begin
  inherited;
  With qryGeneral do begin
    Close;
    SQL.Text := 'SELECT COUNT(*) as kount FROM tblparts WHERE HasProductOptions = "T" ';
    Open;
    if FieldByName('kount').AsInteger = 0 then begin
      sMsg := 'To Create A New Product Option, tick the Product Option Tick Box ' +
          'at the Bottom of your base Product Card. Ie If you want to create ' +
          'options for "Beds", make a product card called "Beds" and tick the ' +
          'Product Option box. ';

      CommonLib.MessageDlgXP_Vista(sMsg, mtInformation, [mbOK], 0);
      exit;
    end;
  end;
end;

procedure TfrmProductOptionsDesignGUI.cbProductBeforeOpenList(Sender: TObject);
begin
  If not (Sender is TProductListExpressGUI) then exit;
  TProductListExpressGUI(Sender).FilterString := ' HasProductOptions = "T" ';
  inherited;
end;

procedure TfrmProductOptionsDesignGUI.cbProductChange(Sender: TObject);
var
//  oId          : Integer;
  ThisLine     : TConfig;
  partsId      : Integer;
  ProgDlg      : TProgressDialog;
begin
  inherited;
  ProgDlg := TProgressDialog.Create(nil);
  try
    ProductConfig.Clear;
    if cbProduct.Visible then begin
      PartsId        := qryProductLookup.FieldByName('PartsId').AsInteger;
      edPartsId.Text := IntToStr(PartsId);
    end
    else  begin
      partsId        := StrToIntDef(edPartsId.Text, -1);
    end;
    if partsid = -1 then exit;
    With cboProductQry do begin
      Close;
      SQL.Clear;
      SQL.Text := sProductSQL + ' where PartsId = ' + IntToStr(PartsId);
      OPen;
    end;
  //get partsId from either the combo or from the caller
  //populate cst,price etc from TSimpleProduct or the combo

    ProgDlg.Caption  := 'Getting Product Tree';
    ProgDlg.MaxValue := 10;
    ProgDlg.Value    := 1;
    ProgDlg.TimerUpdate := true;
    ProgDlg.Execute;

    With qryGeneral do begin
      Close;
      SQL.Text := 'SELECT id, id_parent Node FROM tblproductheaderdetails LIMIT 1';
      Open;

      vTable.Clear;
      vTable.Assign(qryGeneral);
      vTable.Active := True;
      vTable.IndexFieldNames := 'id';
      vTable.Clear;

      Close;
    end;
    //
    //oid := ThisLine.id;
    With qryGeneral do begin
      Close;
      SQL.Text := 'SELECT '
               +  ' id,  optionname,  id_parent, optioncost,  optionprice, objecttype, optionabbrev, templateName, templateDesc from  '
               +  ' tblproductheaderdetails WHERE id_product = ' + IntToStr(partsId)
               + ' ORDER by id_parent, id';
      Open;
      First;
      while not EOF do begin
        ThisLine               := TConfig.Create;
        ThisLine.id            := FieldByName('id').AsInteger;
        ThisLine.OptionName    := FieldByName('OptionName').AsString;
        ThisLine.OptionAbbrev  := FieldByName('optionabbrev').AsString;
        ThisLine.OptionCost    := FieldByName('OptionCost').AsExtended;
        ThisLine.OptionPrice   := FieldByName('OptionPrice').AsExtended;
        ThisLine.ObjectType    := FieldByName('ObjectType').AsString;
        ThisLine.parentId      := FieldByName('id_parent').AsInteger;
        ThisLine.TemplateName  := FieldByName('templateName').AsString;
        ThisLine.TemplateDesc  := FieldByName('templateDesc').AsString;
        ProductConfig.Add(ThisLine);
        Next;
      end;
    end;

    BuildTreeView(ProgDlg);
    if tvProduct.Items.Count > 0 then begin
      tvProduct.Items[0].Selected := True;
    end;
    ProgDlg.Caption  := 'Building Form';
    ProgDlg.MaxValue := 100;
    ProgDlg.Value    := 95;
    ProgDlg.TimerUpdate := true;
    ProgDlg.Execute;
    BuildPanels;
  finally
    ProgDlg.Free;
  end;
end;

procedure TfrmProductOptionsDesignGUI.cbTemplatesChange(Sender: TObject);
begin
  inherited;
  if FAddTemplateClicked then btnAddFromTemplateClick(Nil);
end;

procedure TfrmProductOptionsDesignGUI.BuildTreeView(ProgDlg: TProgressDialog);
var
  i               : integer;
  tempConfig      : TConfig;
  tempNode        : TTreeNode;
  parentNode      : TTreeNode;
begin
  tvProduct.Items.Clear;
  VTable.Clear;
  tvProduct.Visible := False;
  parentNode        := Nil;
  tvProduct.Items.BeginUpdate;
  try
    ProgDlg.MaxValue := ProductConfig.Count;
    for i := 0  to ProductConfig.Count -1 do
    begin
      if i mod 500 = 0 then begin
        ProgDlg.Caption  := 'Building Product TreeView';
        ProgDlg.Value    := i;
        ProgDlg.TimerUpdate := true;
        ProgDlg.Execute;
        //Application.ProcessMessages;
      end;
      tempConfig := ProductConfig.Items[i];
//      if tempConfig.parentId = 0 then begin //root
//         tempNode            := tvProduct.Items.Add(Nil, tempConfig.OptionName);
//         tempConfig.parentId := 0;
//         tempNode.Data       := tempConfig;
//          VTable.Append;
//          VTable.FieldByName('Node').ASInteger := Integer(tempNode);
//          VTable.FieldByName('id').ASInteger := TConfig(tempNode.Data).id;
//          VTable.Post;
//      end else  begin
        if parentNode <> Nil then begin
          if TConfig(parentNode.Data).id <> tempConfig.parentId then
            parentNode          := FindParentNode(tempConfig.parentId);
        end else
            parentNode          := FindParentNode(tempConfig.parentId);

        tempNode            := tvProduct.Items.AddChild(parentNode, tempConfig.OptionName);
        tempNode.Data       := tempConfig;
        VTable.Append;
        VTable.FieldByName('Node').ASInteger := Integer(tempNode);
        VTable.FieldByName('id').ASInteger := TConfig(tempNode.Data).id;
        VTable.Post;
      //end;
    end;
  finally
    tvProduct.Items.EndUpdate;
    tvProduct.Visible := True;
    tvProduct.Items[0].Selected := True;
    tvProduct.Items[0].Expand(False);
  end;
end;

procedure TfrmProductOptionsDesignGUI.AfterResultOKAdd(Sender: TObject);
var
  Config      : TConfig;
  ThisNode    : TTreeNode;
  NewNode     : TTreeNode;
  CurrentNode : TTreeNode;
begin

  if not (Sender is TfrmProductOptionsInputGUI) then exit;
  if tvProduct.Selected = Nil then  exit;
  CurrentNode := tvProduct.Selected;
  ThisNode := tvProduct.Selected.Parent;
  With Sender As TfrmProductOptionsInputGUI do begin
     Config             := TConfig.Create;
     Config.OptionName  := edOptionName.Text;
     Config.OptionAbbrev:= edOptionAbbrev.Text;
     Config.TemplateName:= '';
     Config.TemplateDesc:= '';
     Config.OptionCost  := edCost.FloatValue;
     Config.OptionPrice := edPrice.FloatValue;
     Config.ObjectType  := 'S';
     Inc(MaxId);
     Config.id          := MaxId;
     if rgLevel.ItemIndex = 0 then begin
       NewNode            := tvProduct.Items.AddChild(CurrentNode, edOptionName.Text);
       Config.parentId    := TConfig(CurrentNode.Data).Id;
     end
     else begin
       NewNode            := tvProduct.Items.AddChild(ThisNode, edOptionName.Text);
       Config.parentId    := TConfig(ThisNode.Data).Id;
     end;
     NewNode.Data       := Config;
     VTable.Append;
     VTable.FieldByName('Node').ASInteger := Integer(NewNode);
     VTable.FieldByName('id').ASInteger := TConfig(NewNode.Data).id;
     VTable.Post;
     NewNode.Selected   := True;
     BuildPanels;
     tvProduct.SetFocus;
  end;
end;

procedure TfrmProductOptionsDesignGUI.AfterResultOKEdit(Sender: TObject);
var
  Config      : TConfig;
  CurrentNode : TTreeNode;
begin
  if not (Sender is TfrmProductOptionsInputGUI) then exit;
  if tvProduct.Selected = Nil then  exit;
  CurrentNode := tvProduct.Selected;
  Config      := CurrentNode.Data;
  With Sender As TfrmProductOptionsInputGUI do begin
     Config.OptionName  := edOptionName.Text;
     Config.OptionAbbrev:= edOptionAbbrev.Text;
     Config.OptionCost  := edCost.FloatValue;
     Config.OptionPrice := edPrice.FloatValue;
  end;
  BuildPanels;
  tvProduct.SetFocus;
end;

procedure TfrmProductOptionsDesignGUI.BeforeShowProc(Sender: TObject);
var
  Config : TConfig;
begin
  if not (Sender is TfrmProductOptionsInputGUI) then exit;
  With Sender As TfrmProductOptionsInputGUI do begin
    Caption               := 'Edit Option';
    Config                := tvProduct.Selected.Data;
    edOptionName.Text     := Config.OptionName;
    edOptionAbbrev.Text   := Config.OptionAbbrev;
    edCost.Text           := Format('%f', [Config.OptionCost]);
    edPrice.Text          := Format('%f', [Config.OptionPrice]);
  end;
end;

procedure TfrmProductOptionsDesignGUI.btnAddClick(Sender: TObject);
begin
  if tvProduct.Selected = Nil then  exit;
  CommonFormLib.OpenERPFormModal('TfrmProductOptionsInputGUI', 0, Nil, False, AfterResultOKAdd);
end;

procedure TfrmProductOptionsDesignGUI.btnDeleteClick(Sender: TObject);
var
  ThisNode : TTreeNode;
begin
  if ((tvProduct.Selected <> Nil) and (tvProduct.Items[0] <> tvProduct.Selected)) then begin
    if VTable.Locate('id', TConfig(tvProduct.Selected.Data).id, []) then begin
      VTable.Delete;
      tvProduct.Selected.Delete;
    end;

    ThisNode := tvProduct.Selected;
    BuildPanels;
    if ThisNode <> Nil then tvProduct.Selected := ThisNode;
  end;
end;

procedure TfrmProductOptionsDesignGUI.btnEditClick(Sender: TObject);
begin
  if tvProduct.Selected = Nil then  exit;
  CommonFormLib.OpenERPFormModal('TfrmProductOptionsINputGUI', 0, BeforeShowProc, False, AfterResultOKEdit);
end;

procedure TfrmProductOptionsDesignGUI.BuildPanels;
var
  ThisNode    : TTreeNode;
  NodeList    : TList<TTreeNode>;
  Config      : TConfig;
  ParentNode  : TTreeNode;
  i           : Integer;
  j           : Integer;
  k           : Integer;
  l           : Integer;
  oChildPanel : TPanel;
  NextConfigId : Integer;
  ComboConfig : TConfig;
begin
  if tvProduct.Selected = Nil then exit;
  FProductName := '';
  FCost        := 0;
  FPrice       := 0;
  ThisNode := tvProduct.Selected;
  NodeList := TList<TTreeNode>.Create;
  NodeList.Add(ThisNode);
  try
  //get a list of config items who are siblings + parents + 1 level below
    while (1=1) do begin
      ParentNode    := ThisNode.Parent;
      if ParentNode = Nil then break;
      NodeList.Add(ParentNode);
      ThisNode      := ParentNode;
    end;
    DestroyChildObjects(sbDesign);
    Config :=  TConfig(NodeList[NodeList.Count-1].Data);
    oChildPanel := CreateStandardChildPanel(sbDesign, Config.id);
    CreateTopLevel(oChildPanel, Config);
    for i := NodeList.Count -1 downto 0 do begin
      ThisNode    := NodeList[i];
      Config      := TConfig(ThisNode.Data);
      oChildPanel := CreateStandardChildPanel(sbDesign, Config.id);
      if i > 0  then  NextConfigId := TConfig(NodeList[i-1].Data).Id
      else NextConfigId := TConfig(NodeList[0].Data).Id;

      //if Config.ObjectType = 'S' then CreatePanels(oChildPanel, ThisNode) ;
      CreatePanels(oChildPanel, ThisNode, Config.ObjectType);
      for j := 0 to oChildPanel.ControlCount -1  do begin
         if oChildPanel.Controls[j] is TPanel then begin
           if Config.ObjectType <> 'L' then begin
              if oChildPanel.Controls[j].Tag = NextConfigId then begin
                TPanel(oChildPanel.Controls[j]).Color      := SELECTED_BACKGROUND_COLOR;
                TPanel(oChildPanel.Controls[j]).Font.Color := SELECTED_FONT_COLOR;
                for k  := 0 to TPanel(oChildPanel.Controls[j]).ControlCount -1  do begin
                  if TPanel(oChildPanel.Controls[j]).Controls[k] is TLabel then begin
                     Tlabel(TPanel(oChildPanel.Controls[j]).Controls[k]).Color := SELECTED_BACKGROUND_COLOR;
                     Tlabel(TPanel(oChildPanel.Controls[j]).Controls[k]).Font.Color := SELECTED_FONT_COLOR;
                  end;
                end;
              end
           end else begin
              for k  := 0 to TPanel(oChildPanel.Controls[j]).ControlCount -1  do begin
                if TPanel(oChildPanel.Controls[j]).Controls[k] is TComboBox then begin
                  for l := 0 to TComboBox(TPanel(oChildPanel.Controls[j]).Controls[k]).Items.Count -1 do begin
                    if TPanel(oChildPanel.Controls[j]).Controls[k] is TComboBox then begin
                      ComboConfig := TConfig(TComboBox(TPanel(oChildPanel.Controls[j]).Controls[k]).Items.Objects[l]);
                      if ComboConfig.id = NextConfigId then begin
                        TComboBox(TPanel(oChildPanel.Controls[j]).Controls[k]).ItemIndex := l;
                        CreateLabelsList(TPanel(oChildPanel.Controls[j]), ComboConfig);
                        break;
                      end;
                    end;
                  end;
                  if TComboBox(TPanel(oChildPanel.Controls[j]).Controls[k]).Text = '' then begin
                     TComboBox(TPanel(oChildPanel.Controls[j]).Controls[k]).DroppedDown := True;
                  end;
                 end;
               end;
            end;
         end;
      end;
    end;
  finally
    PopulateCostName;
    NodeList.Free;
  end;
end;

procedure TfrmProductOptionsDesignGUI.btnSaveClick(Sender: TObject);
var
  sSQL        : string;
  i           : Integer;
  j           : Integer;
  Config      : TConfig;
  ThisProduct : TProduct;
  //ProgDlg     : TProgressDialog;
begin
  Screen.cursor := crHourGlass;
  try
    if FromOptions then begin
      With qryGeneral do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM tblproductheaderdetails WHERE id_product = :pIdProduct') ;
        ParamByName('pIdProduct').AsInteger := StrToIntDef(edPartsId.Text, 0);
        ExecSQL;
      end;
      if FNew then begin
         Config := tvProduct.Items[0].Data;
         With qryGeneral do begin
           Close;
           SQL.Clear;
           SQL.Text := 'INSERT INTO tblproductheader (id, trueerp_product_id, active) values (:id, :trueerp_product_id, ''T'') ';
           ParamByName('id').AsInteger := Config.id;
           ParamByName('trueerp_product_id').AsInteger := StrToInt(edPartsId.Text);
           ExecSQL;
         end;
      end;
      j := 0;
      sSQL := 'INSERT INTO tblproductheaderdetails (id, id_parent, optionname, optioncost, optionprice, optionabbrev, active, objecttype, id_product, templateName, templateDesc) VALUES ';
      for I := 0 to tvProduct.Items.Count -1 do begin
         Config := tvProduct.Items[i].Data;
         Inc(j);
         With qryGeneral do begin
           Close;
           SQL.Clear;
           if j = 100 then begin
             SQL.Clear;
             SQL.Text := Copy(sSQL,1,Length(sSQL)-1); //remove last comma
             ExecSQL;
             Close;
             j := 0;
             SQL.Clear;
             sSQL := 'INSERT INTO tblproductheaderdetails (id, id_parent, optionname, optioncost, optionprice, optionabbrev, active, objecttype, id_product, templateName, templateDesc) VALUES ';
           end;
           sSQL := sSQL + NL +
           Format('(%d, %d, ''%s'', %8.2f, %8.2f, ''%s'', ''T'', ''%s'', %s, ''%s'', ''%s'')',
           [Config.id, Config.parentId, Config.OptionName, Config.OptionCost, Config.OptionPrice, Config.OptionAbbrev,
            Config.ObjectType, edPartsId.Text, Config.TemplateName, Config.TemplateDesc ]) + ',';
         end;
      end;
      if j <> 0 then begin
         qryGeneral.SQL.Clear;
         qryGeneral.SQL.Text := Copy(sSQL,1,Length(sSQL)-1); //remove last comma
         qryGeneral.ExecSQL;
         qryGeneral.Close;
      end;
    end else begin
      ThisProduct             := TProduct.CreateWithNewConn(Nil);
      try
        ThisProduct.LoadSelect('PartName=' + QuotedStr(FPartName));
        if ThisProduct.count=0 then begin
            THisProduct.New;
            THisProduct.ProductName         := FPartName;
            ThisProduct.ProductPrintName    := FPartName;
            ThisProduct.PurchaseDescription := FPartDesc;
            ThisProduct.SalesDescription    := FPartDesc;
            ThisProduct.ProductType         := 'INV';
            ThisProduct.BuyQty1Cost         := Fcost;
            ThisProduct.SellQty1Price       := FPrice;
            ThisProduct.Save;
        end;
        FNewProductId             := ThisProduct.Getid;
      finally
        ThisProduct.Free;
      end;
    end;
  finally
    Screen.cursor := crDefault;
  end;
  Self.Close;
end;


class function TfrmProductOptionsDesignGUI.DoProductOption(const AOwner:TBaseInputGUI; const Lineobj: TSalesLineBase):Integer; //const productID: Integer): integer;
var frm : TfrmProductOptionsDesignGUI;
begin
  frm := TfrmProductOptionsDesignGUI.Create(Nil);
  try
    With frm do begin
      FromOptions    := False;
      edPartsID.Text := IntToStr(Lineobj.productId);
      cbTemplates.BringToFront;
      ShowModal;
      Result := NewProductId;
      if Result>0 then begin
          Lineobj.Deleted := true ;
          Lineobj.PostDb;
          Lineobj.New;
          Lineobj.ProductID := newProductID;
          Lineobj.Qtysold := 1;
          Lineobj.PostDB;
      end;
    end;
  finally
    frm.Free;
  end;
end;

class function TfrmProductOptionsDesignGUI.DoProductOption(const AOwner:TBaseInputGUI; const Lineobj: TPurchaseOrderLine):Integer; //const productID: Integer): integer;
var frm : TfrmProductOptionsDesignGUI;
begin
  frm := TfrmProductOptionsDesignGUI.Create(Nil);
  try
    With frm do begin
      FromOptions    := False;
      edPartsID.Text := IntToStr(Lineobj.productId);
      cbTemplates.BringToFront;
      ShowModal;
      Result := NewProductId;
      if Result>0 then begin
          Lineobj.Deleted := true ;
          Lineobj.PostDb;
          Lineobj.New;
          Lineobj.ProductID := newProductID;
          Lineobj.Qty := 1;
          Lineobj.PostDB;
      end;
    end;
  finally
    frm.Free;
  end;
end;

procedure TfrmProductOptionsDesignGUI.ReadguiPref;
begin
  ActivateGuiPrefs(True);
  if StrToBoolean(GuiPrefs.Node['Options.Maximised'].AsString)  then WindowState := wsMaximized;
end;

procedure TfrmProductOptionsDesignGUI.WriteGuiPrefs;
begin
  GuiPrefs.Node['Options.Maximised'].AsString                 := BooleanToStr(WindowState=wsMaximized );
end;

procedure TfrmProductOptionsDesignGUI.PostPonedPanelClick(var Message: TMessage);
begin
  BuildPanels;
  BringToFront;
end;

initialization
  RegisterClassOnce(TfrmProductOptionsDesignGUI);
end.
