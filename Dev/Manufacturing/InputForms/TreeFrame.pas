unit TreeFrame;

{

  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  12/06/07 1.00.01  DSP - Initial version.

}
{$I ERP.inc}

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, VirtualTrees, Menus, AdvMenus, ExtCtrls, StdCtrls, DNMPanel, ComCtrls, AdvOfficeStatusBar, ActiveX, DNMSpeedButton,
  wwMemo,  BusObjProcess, dmGUIStylers, AppEvnts, Wwdbgrid, MyAccess, ERPdbComponents, wwcheckbox , VTEditControl , ClientDiscountObj;

const
  WM_STARTEDITING = WM_USER + 101;

  cHalfCheckBoxWidth = 8;

  cAddToSaleIndex   = 0;
  cHideOnPrintIndex = 1;
  cMakecoupnsIndex  = 2;
  cZeroWhenLessthan1index = 3;
  cRoundtoNextNumberindex = 4;
  cRoundtoPrevNumberindex = 5;
  cIgnoreItemCommentsIndex = 6;

  cMaxCheckBoxes    = 7;

  cDisplayRectOffset = 3;

  cPartNameColumn     	=	0	;//	 0;
  cQtyPercolumn       	=	1	;//	 1;
  cPartDescColumn     	=	2	;//	 2;
  //cOptionColumn       	=	3	;//	 3;
  cFormulaQty         	=	3;//4	;//	 4;
  cFormulaQty1        	=	4;//5	;//	 5;
  cFormulaQty2        	=	5;//6	;//	 6;
  cFormulaQty3        	=	6;//7	;//	 7;
  cFormulaQty4        	=	7;//8	;//	 8;
  cFormulaQty5        	=	8;//9	;//	 9;
  cQtyColumn          	=	9;//3	;//	 3;
  cStockQty           	=	10	;//	 10;
  cbFormulaQty        	=	11	;//	 11;
  cbFormulaQty1       	=	12	;//	 12;
  cbFormulaQty2       	=	13	;//	 13;
  cbFormulaQty3       	=	14	;//	 14;
  cbFormulaQty4       	=	15	;//	 15;
  cbFormulaQty5       	=	16	;//	 16;
  cbuildQty           	=	17	;//	 17;
  coFormulaQty        	=	18	;//	 18;
  coFormulaQty1       	=	19	;//	 19;
  coFormulaQty2       	=	20	;//	 20;
  coFormulaQty3       	=	21	;//	 21;
  coFormulaQty4       	=	22	;//	 22;
  coFormulaQty5       	=	23	;//	 23;
  cOrderqty           	=	24	;//	 24;
  cUOM                	=	25	;//	 25;
  cInfoColumn         	=	26	;//	 35;
  cOptionColumn       	=	27;//26	;//	 26;
  cAvgCostColumn      	=	28;//27	;//	 27;
  cCostColumn         	=	29;//28	;//	 28;
  cLabourPriceColumn  	=	30;//29	;//	 29;
  cUnitPriceColumn    	=	31;//30	;//	 30;
  cPriceColumn        	=	32;//31	;//	 31;
  cProcessStepsColumn 	=	33;//32	;//	 32;
  cProcessStepExtraInfo	=	34;//33	;//	33;
  cInputTypeColumn    	=	35;//34	;//	 34;
  //cInfoColumn         	=	35	;//	 35;
  cPriceMatrix        	=	36	;//	 36;
  cAddToSaleColumn    	=	37	;//	 37;
  cHideOnPrintColumn  	=	38	;//	 38;
  cUOMQty             	=	39	;//	 39;
  cTotalQtyColumn     	=	40	;//	 40;
  cSourceColumn       	=	41	;//	 41;
  cDetailsColumn      	=	42	;//	 42;
  cCustomInputColumn  	=	43	;//	 43;
  cQtyPerCoupon       	=	44	;//	 44;
  cRAtePercoupon      	=	45	;//	 45;
  cMakeCoupons        	=	46	;//	 46;
  cZeroWhenLessthan1    = 47	;//	 47;
  cRoundtoNextNumber    = 48	;//	 48;
  cRoundtoPrevNumber    = 49	;//	 49;
  cIgnoreItemComments   = 50 ;
  cSubBOMProcessOrder   = 51 ;



type

  PNodeData = ^TNodeData;

  TNodeData = record
    Captions: array of string;
    CheckBoxes: array of TCheckBox;
    Data: TProcTreeNode;
  end;

  TTreeFrameEvent = (tfeSaveandClose =1, tfeSaveandOpenSmartOrder =2);
  TTreeFrameEventProc = Procedure (const value :TTreeFrameEvent) of Object;


  TTreeMode = (tmTemplate, tmInput);

  TframeTree = class;

  TVTFrameEditControl = class(TVTEditControlbase, IVTEditLink)
    Private
      function getcolumwidth(nodeData: PNodeData;iWidth:Integer;ParentNodeData:PNodeData): Integer;
      Function frameTree :TframeTree ;
      Function EnableSubBOMProcessOrder(Node: PVirtualNode; NodeData: PNodeData):Boolean;
    Protected
      function getEditcontrol(aColumn: TColumnIndex): TEditControlType; Override;
      procedure HandleComboBoxCloseUp(Sender: TObject);Override;
    Public
      function BeginEdit  : Boolean; stdcall;
      function CancelEdit : Boolean; stdcall;
      function EndEdit    : Boolean; stdcall;
      function GetBounds  : TRect  ; stdcall;
      function PrepareEdit(Tree: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex): Boolean; stdcall;
      procedure ProcessMessage(var message: TMessage); stdcall;
      procedure SetBounds(R: TRect); stdcall;
  end;
  TProc = Procedure of Object;
  TframeTree = class(TFrame)
    mnuTree: TAdvPopupMenu;
    miAddBranch: TMenuItem;
    miInsert: TMenuItem;
    miDelete: TMenuItem;
    vstProcessPart: TVirtualStringTree;
    ApplicationEvents1: TApplicationEvents;
    dlgInfo: TwwMemoDialog;
    pnlOptions: TDNMPanel;
    lblHint: TLabel;
    lblDetails: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    chkHideQtyPercolumn: TCheckBox;
    pnlFooter: TDNMPanel;
    lblTotalCost: TLabel;
    lblTotalPrice: TLabel;
    TmrMsg: TTimer;
    Memo1: TMemo;
    lblmsg: TLabel;
    chkHideFormulacolumns: TCheckBox;
    AddProduct1: TMenuItem;
    Label1: TLabel;
    lblTotalQty: TLabel;
    lblcostIncLabour: TLabel;
    mnuRecalculatePricefromProduct: TMenuItem;
    btnBOMcostnPriceCalc: TDNMSpeedButton;
    lblFooterMsg: TLabel;
    mnutreeProductsAvgCostList1: TMenuItem;
    mnuInfosep: TMenuItem;
    mnuInfoToSales: TMenuItem;
    mnuInfofromSales: TMenuItem;
    procedure vstProcessPartInitNode(const Sender: TBaseVirtualTree; const ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vstProcessPartFreeNode(const Sender: TBaseVirtualTree; const Node: PVirtualNode);
    procedure vstProcessPartGetText(const Sender: TBaseVirtualTree; const Node: PVirtualNode; const Column: TColumnIndex; const TextType: TVSTTextType; var CellText: string);
    procedure vstProcessPartNewText(const Sender: TBaseVirtualTree; const Node: PVirtualNode; const Column: TColumnIndex; const NewText: string);
    procedure vstProcessPartEditing(const Sender: TBaseVirtualTree; const Node: PVirtualNode; const Column: TColumnIndex; var Allowed: Boolean);
    procedure vstProcessPartCreateEditor(const Sender: TBaseVirtualTree; const Node: PVirtualNode; const Column: TColumnIndex; out EditLink: IVTEditLink);
    procedure miAddBranchClick(Sender: TObject);
    procedure miInsertClick(Sender: TObject);
    procedure miDeleteClick(Sender: TObject);
    procedure vstProcessPartDragOver(const Sender: TBaseVirtualTree; const Source: TObject; const Shift: TShiftState; const State: TDragState; const Pt: TPoint; const Mode: TDropMode;
      var Effect: Integer; var Accept: Boolean);
    procedure vstProcessPartDragDrop(const Sender: TBaseVirtualTree; const Source: TObject; const DataObject: IDataObject; const Formats: TFormatArray; const Shift: TShiftState; const Pt: TPoint;
      var Effect: Integer; const Mode: TDropMode);
    procedure vstProcessPartMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure vstProcessPartColumnClick(Sender: TBaseVirtualTree; Column: TColumnIndex; Shift: TShiftState);
    procedure vstProcessPartAfterCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; CellRect: TRect);
    procedure vstProcessPartCollapsed(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstProcessPartExit(Sender: TObject);
    procedure HandleDblClick(Sender: TObject);
    procedure mnuTreePopup(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure vstProcessPartAfterPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas);
    procedure chkHideQtyPercolumnClick(Sender: TObject);
    procedure vstProcessPartClick(Sender: TObject);
    procedure chkHideFormulacolumnsClick(Sender: TObject);
    procedure AddProduct1Click(Sender: TObject);
    procedure pnlFooterDblClick(Sender: TObject);
    procedure lblTotalQtyDblClick(Sender: TObject);
    procedure lblTotalCostDblClick(Sender: TObject);
    procedure lblcostIncLabourDblClick(Sender: TObject);
    procedure lblTotalPriceDblClick(Sender: TObject);
    procedure mnuRecalculatePricefromProductClick(Sender: TObject);
    procedure vstProcessPartBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure vstProcessPartDrawText(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      const Text: string; const CellRect: TRect; var DefaultDraw: Boolean);
    procedure btnBOMcostnPriceCalcClick(Sender: TObject);
    procedure mnutreeProductsAvgCostList1Click(Sender: TObject);
    procedure mnuInfoToSalesClick(Sender: TObject);
    procedure mnuInfofromSalesClick(Sender: TObject);
    procedure dlgInfoUserButton1Click(Dialog: TwwMemoDlg; Memo: TMemo);
  private
    FCurrentNode: PVirtualNode;
    FVTEditControl: TVTFrameEditControl;
    FTreeMode: TTreeMode;
    FProcessTreeID: Integer;
    FTreeNodeRoot: TProcTreeNode;
    FTreeRootNodeAssigned: Boolean;
    FAppSettingCheckBox: Boolean;
    FClearAndLoad: Boolean;
    FStoredOnMessage: TMessageEvent;
    FMouseButton: TMouseButton;
    FBuildingVisualTree: Boolean;
    FPopupModified: Boolean;
    FGenericStr: string;
    fTransConnection: TERPConnection;
    coloursInited:Boolean;
    fTreeFrameEventProc :TTreeFrameEventProc;
    fdValue:double;
    fdProductPrice, fdProductcost:double;
    fDoCheckForCostnPricechange: TProc;
    ClientDiscountObj: TClientDiscountObj;
    fiHighlightcolumn: Integer;
    fsHighlightcolumnMsg: String;
    OTFPartIDs:String;
    OTFPartIDscount:Integer;
    ChoosingOTFProduct :Boolean;
    fbonMultiSelectProduct :Boolean;
    dlgInfoMemo: TMemo;
    function GetCheckBoxIndex(const Column: Integer): Integer;
    procedure HandleCheckBoxClick(Sender: TObject);
    procedure HandleButtonClick(Sender: TObject);
    procedure SetTreeMode(const Value: TTreeMode);
    procedure SetProcessTreeID(const Value: Integer);
    procedure SetTreeNodeRoot(const Value: TProcTreeNode);
    procedure BuildVisualTree(const VisualNode: PVirtualNode);
    procedure SetNodeDataFields(const Node: PVirtualNode);
    procedure DisplayCheckBoxes(const Node: PVirtualNode; Expanded: Boolean; const Visible: Boolean = False);
    procedure DisplayRequiredNodes(const Node: PVirtualNode; out Visible: Boolean);
    procedure GetExpandedList(const Node: PVirtualNode; const NodeList: TList);
    procedure ExpandList(const NodeList: TList);
    function FindMatchingParent(const Node: PVirtualNode; const PartsID: Integer): Boolean;
    procedure CheckOptions(const Node: PVirtualNode);
    procedure ShowPopupForm(const ClassStr: string; const TreeNode: TProcTreeNode);
    procedure WMStartEditing(var Msg: TMessage); message WM_STARTEDITING;
    procedure SetTreeReadOnly(const Value: Boolean);
    function GetTreeReadOnly: Boolean;
    procedure DisplayForMode;
    procedure SetRootNodeData(const ProcTreeNode: TProcTreeNode);
    function GetRootNodeData: TProcTreeNode;
    procedure setHideQtyPer(const Value: Boolean);
    function getHideQtyPer: Boolean;
    procedure ShowPartsPriceMatrix(NodeData: PNodeData);
    procedure showFormulacolumns(const ForTemplate :Boolean; isSalesOrder:Boolean);
    //procedure Initcolours;
    procedure ShowFormulaQty(var CellText: string; const Value: Double);
//    procedure LogNode(NodeData: PNodeData);
    function getHideFormulacolumns: Boolean;
    procedure setHideFormulacolumns(const Value: Boolean);
    procedure AddBranch(var NodeData: PNodeData; var newNode: PVirtualNode);
    function NodeType(const Sender: TBaseVirtualTree; Node: PVirtualNode): TPersistentClass;
    procedure showInmsgform(const Msgcaption, MsgText, Msg1 , Msg2 , fieldnames,displaywidths: String);
    procedure Setcolumnwidths;
    procedure SetTreecolumn(Node: PVirtualNode; const Value: Integer);
    procedure CheckForCostnPricechange;
    Function ProductformulaEntry(Node: PVirtualNode;var NodeData: PNodeData):Boolean ;
    function CostinTreeFormat:String;
    procedure initFormulaQtysfromFirstnode(NodeData: PNodeData);
    Function initFormulaQtysfromFirstnodeCallback(ParentNodeData: TProcTreeNode; NodeData: PNodeData):Boolean;
    procedure SetHighlightcolumn(const Value: Integer);
    Procedure SetHighlightcolumnMsg(const Value:String);
    procedure DeleteNode(Node: PVirtualNode);
    procedure OnSelectProduct(aVTEditControl: TVTFrameEditControl;Sender: TObject;PartId: Integer; Partname,PartDescription: String; nodedata: PNodeData;Node: PVirtualNode);
    procedure initProductListExpress(Sender: TObject);
    procedure onMultiSelectProduct(Sender: TwwDbGrid);
    procedure DoMultiSelectProduct(Qry :TERPQuery);
    procedure CheckForLinkedSubs(aNode: TProcTreeNode; IsQuantityChange: boolean = false);
    procedure ChecknAddFormulaRelatedProducts(aParentNode: PVirtualNode;newNode: PVirtualNode);
    procedure UnSelectNode(aNode: PVirtualNode);
    function SaleReadonly: Boolean;
    procedure updatecomments(Sender: TwwDbGrid);

  Protected

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SaveTree;
    property RootNodeData: TProcTreeNode read GetRootNodeData write SetRootNodeData;
    property TreeMode: TTreeMode read FTreeMode write SetTreeMode;
    property ProcessTreeID: Integer read FProcessTreeID write SetProcessTreeID;
    property TreeNodeRoot: TProcTreeNode read FTreeNodeRoot write SetTreeNodeRoot;
    property TreeRootNodeAssigned: Boolean read FTreeRootNodeAssigned;
    property ClearAndLoad: Boolean read FClearAndLoad write FClearAndLoad;
    property PopupModified: Boolean read FPopupModified write FPopupModified;
    property GenericStr: string read FGenericStr write FGenericStr;
    property TreeReadOnly: Boolean read GetTreeReadOnly write SetTreeReadOnly;
    procedure RebuildVisualTree;
    property TransConnection: TERPConnection read fTransConnection write fTransConnection;
    property HideQtyPer: Boolean read getHideQtyPer write setHideQtyPer;
    Property HideFormulacolumns :Boolean read getHideFormulacolumns write setHideFormulacolumns;
    procedure ExplainSelectedNode;
    Property TreeFrameEventProc :TTreeFrameEventProc read fTreeFrameEventProc write fTreeFrameEventProc;
    Property Treecolumn[Node: PVirtualNode]:Integer write SetTreecolumn;
    Procedure ShowPricecostCalc(CostnPriceCalc:TNotifyEvent; showCalcOption:boolean; Msg:String);
    Property ProductPrice : double read fdProductPrice   write fdProductPrice;
    Property Productcost:double read fdProductcost   write fdProductcost;
    Property DoCheckForCostnPricechange :TProc read fDoCheckForCostnPricechange write fDoCheckForCostnPricechange;
    Procedure ResetCaptions;
    Property Highlightcolumn :Integer read fiHighlightcolumn write SetHighlightcolumn;
    Property HighlightcolumnMsg :String read fsHighlightcolumnMsg write setHighlightcolumnMsg;
    Procedure DeleteTree;
    procedure MultiSelectProduct;
    procedure TimerMsg(const Value: String; Secondstoshow: Integer=5; msgColor:TColor = clred);
    Function EnableSubBOMProcessOrder(Node: PVirtualNode; NodeData: PNodeData):Boolean;
  end;
  var
    DoopenProductList:Boolean;

  procedure RefreshQty(const Node: PVirtualNode;NodeData: PNodeData; DoCalPrice:Boolean =TRue);
  Procedure CalcPrice(const node:TProcTreeNode);
  Function colnumtoName(Const Value:Integer):String;
implementation

{$R *.dfm}

uses CommonLib, BusObjNDSBase, frmProcTreeProcessStepEdit, BaseProcTreeEdit,
  FastFuncs, Messageconst, ProcessDataUtils, RegPopupObj, NodePropertiesLink,
  AppEnvironment, LogUtils, ProcessUtils,
  UserProductSelect, frmpartsPriceMatrixInput, PartsPriceMatrixLib,
  tcConst, tcTypes, PartCalcFormulaObj, BusObjStock , math, frmMessageBase,
  frmMessageWithList, BaseInputForm, frmTreeProductSepc, mask, LogLib,
  CommonFormLib, ProductListExpressForm, BaseListLib, MAIN , dateutils,
  tcDataUtils, TreeProductsAvgCostList, DbSharedObjectsObj,
CommonDbLib , sndkey32;

const
  cMaxColumns = 52;
  cEllipsisText = '[...]';

  cCheckBoxColumns: array [0 .. cMaxCheckBoxes - 1] of Integer = (cAddToSaleColumn, cHideOnPrintColumn , cMakeCoupons , cZeroWhenLessthan1,cRoundtoNextNumber,cRoundtoPrevNumber, cIgnoreItemComments);
  cTreeFrameColumnControls: array [0 .. cMaxColumns - 1] of TEditControlType =
        ((*cPartNameColumn*)ectEdit,
           (*cQtyPercolumn*)ectEdit,
         (*cPartDescColumn*)ectEdit,
           {(*cOptionColumn*)ectComboBox,}
              (*cQtyColumn*)ectEdit,
             (*cFormulaQty*)ectEdit,
            (*cFormulaQty1*)ectEdit,
            (*cFormulaQty2*)ectEdit,
            (*cFormulaQty3*)ectEdit,
            (*cFormulaQty4*)ectEdit,
            (*cFormulaQty5*)ectEdit,
               (*cStockQty*)ectEdit,
            (*cbFormulaQty*)ectEdit,
           (*cbFormulaQty1*)ectEdit,
           (*cbFormulaQty2*)ectEdit,
           (*cbFormulaQty3*)ectEdit,
           (*cbFormulaQty4*)ectEdit,
           (*cbFormulaQty5*)ectEdit,
               (*cbuildQty*)ectEdit,
            (*coFormulaQty*)ectEdit,
           (*coFormulaQty1*)ectEdit,
           (*coFormulaQty2*)ectEdit,
           (*coFormulaQty3*)ectEdit,
           (*coFormulaQty4*)ectEdit,
           (*coFormulaQty5*)ectEdit,
               (*cOrderqty*)ectEdit,
                    (*cUOM*)ectNone,
             (*cInfoColumn*)ectEdit,
           (*cOptionColumn*)ectComboBox,
          (*cAvgCostColumn*)ectNone,
             (*cCostColumn*)ectNone,
      (*cLabourPriceColumn*)ectNone,
        (*cUnitPriceColumn*)ectEdit,
            (*cPriceColumn*)ectNone,
     (*cProcessStepsColumn*)ectButton,
     (*cProcessStepExtraInfo*)ectEdit,
        (*cInputTypeColumn*)ectComboBox,
            //(*cInfoColumn*)ectEdit,
            (*cPriceMatrix*)ectButton,
        (*cAddToSaleColumn*)ectNone,
      (*cHideOnPrintColumn*)ectNone,
                 (*cUOMQty*)ectNone,
         (*cTotalQtyColumn*)ectNone,
           (*cSourceColumn*)ectComboBox,
          (*cDetailsColumn*)ectButton,
      (*cCustomInputColumn*)ectComboBox,
           (*cQtyPerCoupon*)ectEdit,
          (*cRAtePercoupon*)ectEdit,
            (*cMakeCoupons*)ectNone,
      (*cZeroWhenLessthan1*)ectComboBox,
      (*cRoundtoNextNumber*)ectComboBox,
      (*cRoundtoPrevNumber*)ectComboBox,
      (*cIgnoreItemComments*)ectComboBox,
      (*cSubBOMProcessOrder*)ectComboBox);
//             (*cInfoColumn*)ectEdit);
var
  HideException: Boolean = False;



function TframeTree.CostinTreeFormat: String;
var
  ctr:Integer;
begin
  REsult := '#,##0.';
  ctr:=Appenv.CompanyPrefs.CostDecimalPlacesinTree ;
  if ctr=0 then ctr:= 2;
  while ctr>0 do begin
    Result := REsult +'0';
    ctr:= ctr-1;
  end;
end;

constructor TframeTree.Create(AOwner: TComponent);
begin
  fbonMultiSelectProduct := False;
  ChoosingOTFProduct := False;
  fiHighlightcolumn := -1;
  fsHighlightcolumnMsg := '';
  fTreeFrameEventProc := nil;
  DoopenProductList:= False;
  try
    inherited;
    dlgInfoMemo := nil;
    mnutreeProductsAvgCostList1.visible := Devmode;
    OTFPartIDs:= '';
    OTFPartIDscount:=0;
    ClientDiscountObj := TClientDiscountObj.Create;

    coloursInited:= False;
    fTransConnection := nil;
    FCurrentNode := nil;
    FVTEditControl := nil;
    FTreeMode := tmTemplate;
    FProcessTreeID := 0;
    FTreeNodeRoot := nil;
    FAppSettingCheckBox := False;
    FClearAndLoad := True;
    FMouseButton := mbLeft;
    FBuildingVisualTree := False;
    FPopupModified := False;
    FGenericStr := '';
    FStoredOnMessage := Application.OnMessage;

    vstProcessPart.NodeDataSize := SizeOf(TNodeData);
    FTreeRootNodeAssigned := False;
    lblDetails.Caption := '';

    ResetCaptions;
  except
    on E: Exception do begin
      LogD('TframeTree.Create - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

destructor TframeTree.Destroy;
begin
  try
    if not FTreeRootNodeAssigned then begin
      FreeandNil(FTreeNodeRoot);
    end;
    Application.OnMessage := FStoredOnMessage;
    Freeandnil(ClientDiscountObj);
    inherited;
  except
    on E: Exception do begin
      LogD('TframeTree.Destroy - Exception: ' + E.Message);
      raise;
    end;
  end;
end;
function  TframeTree.NodeType( const Sender: TBaseVirtualTree; Node: PVirtualNode):TPersistentClass;
var
  NodeData: PNodeData;
begin
  result :=  TProcTreeNode;
  if node = nil then exit;
  NodeData := Sender.GetNodeData(Node);
  if Assigned(NodeData) then
    if Assigned(nodedata.data) then
      result := GetClass(nodedata.data.classname);
end;
procedure TframeTree.vstProcessPartInitNode(const Sender: TBaseVirtualTree; const ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  index: Integer;
  NodeData: PNodeData;
  ParentNodeData: PNodeData;
begin
  try
    if (Sender is TVirtualStringTree) then begin
      NodeData := Sender.GetNodeData(Node);

      if Assigned(NodeData) then begin
        Setlength(NodeData.Captions, TVirtualStringTree(Sender).Header.Columns.Count);
        Setlength(NodeData.CheckBoxes, cMaxCheckBoxes);
        //NodeData.Data := TProcTreeNode.Create(nil);
        NodeData.Data :=  TProcTreeNode(GetComponentByClassType(NodeType(Sender,ParentNode) , False  , nil));
        if Assigned(fTransConnection) then FTreeNodeRoot.Storer.Connection := fTransConnection;

        for index := 0 to cMaxCheckBoxes - 1 do begin
          NodeData.CheckBoxes[index] := TCheckBox.Create(nil);
          NodeData.CheckBoxes[index].Hide;
          NodeData.CheckBoxes[index].Tag := Integer(Node);
          NodeData.CheckBoxes[index].OnClick := HandleCheckBoxClick;
          NodeData.CheckBoxes[index].Parent := Sender;
        end;

        for index := 0 to TVirtualStringTree(Sender).Header.Columns.Count - 1 do NodeData.Captions[index] := '';

        if Assigned(ParentNode) and (ParentNode <> Sender.RootNode) then begin
          FAppSettingCheckBox := True;
          NodeData.Data.HideOnPrint := True;
          NodeData.Data.Dirty := False;
          NodeData.CheckBoxes[cHideOnPrintIndex].Checked := True;
          FAppSettingCheckBox := False;
          NodeData.Captions[cInputTypeColumn] := 'None';
        end;

        if Assigned(NodeData.Data.ParentNode) then begin
          if NodeData.Data.ParentNode.InputType <> itOption then NodeData.Captions[cQtyColumn] := '0';
        end
        else NodeData.Captions[cQtyColumn] := '0';

        NodeData.Captions[cSourceColumn] := 'Manufacture';

        if Assigned(ParentNode) and (ParentNode <> Sender.RootNode) and (not FBuildingVisualTree) then begin
          ParentNodeData := Sender.GetNodeData(ParentNode);
          ParentNodeData.Data.Children.Add(NodeData.Data);
        end;

        if Node = Sender.RootNode.FirstChild then NodeData.Data.IgnoreAccessLevel := True;
      end;
    end;
  except
    on E: Exception do begin
      LogD('TframeTree.vstProcessPartInitNode - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TframeTree.vstProcessPartFreeNode(const Sender: TBaseVirtualTree; const Node: PVirtualNode);
var
  index: Integer;
  NodeData: PNodeData;
begin
  try
    NodeData := Sender.GetNodeData(Node);

    for index := 0 to cMaxCheckBoxes - 1 do NodeData.CheckBoxes[index].Free;

    Finalize(NodeData^);
  except
    on E: Exception do begin
      LogD('TframeTree.vstProcessPartFreeNode - Exception: ' + E.Message);
      raise;
    end;
  end;
end;
procedure TframeTree.ShowFormulaQty( var CellText: string; const Value:Double);
begin
  if Value =0 then Celltext := ''
  else CellText := FormatFloat('##########0.##########', Value );
end;
Function TframeTree.EnableSubBOMProcessOrder(Node: PVirtualNode; NodeData: PNodeData):Boolean;
begin
  Result := (NodeData.Data.Children.count <>0) and
            (NodeData.Data.PartsID <>0) and
            (Node <> vstProcessPart.RootNode.FirstChild )
end;
procedure TframeTree.vstProcessPartGetText(const Sender: TBaseVirtualTree; const Node: PVirtualNode; const Column: TColumnIndex; const TextType: TVSTTextType; var CellText: string);
var
  NodeData: PNodeData;
  CurSym: string;
  xPrice: double;
begin
  try
    NodeData := Sender.GetNodeData(Node);
    CellText := '';
    if Assigned(NodeData) then begin
      CurSym := AppEnv.RegionalOptions.CurrencySymbol;
{-->} if NodeData.Data.IsRoot then begin
        lblTotalCost.Caption    := 'Cost :'             + FormatFloat(CurSym + '#,##0.00;(' + CurSym + '#,##0.00)', NodeData.Data.cost);
        lblTotalPrice.Caption   := 'Price With Labour :' + FormatFloat(CurSym + '#,##0.00;(' + CurSym + '#,##0.00)', NodeData.Data.Price);
        lblcostIncLabour.Caption:= 'Cost With Labour :'  + FormatFloat(CurSym + '#,##0.00;(' + CurSym + '#,##0.00)', NodeData.Data.CostIncLabour);
        try
          TProcTreeNode(NodeData.Data.RootNode).CalcchildQty();
        Except
        end;
        lblTotalQty.Caption := 'Total Qty :' + FormatFloat('#,###,##0.00####;(' + '#,###,##0.00####)', NodeData.Data.childrenQty);

      end;
{-->} if (Column = cQtyColumn) and Assigned(NodeData.Data.ParentNode) then begin
        if (((NodeData.Data.InputType = itNone) and (self.FTreeMode <> tmTemplate)) or (NodeData.Data.ParentNode.InputType = itOption))  then CellText := ''
        else CellText := NodeData.Captions[Column];
{-->} end else if (Column = cSourceColumn) then begin
        if (NodeData.Data.IsRoot) then CellText := NodeData.Captions[Column]
        else CellText := '';
{-->} end else if (Column in [cAvgCostColumn , cCostColumn, cPriceColumn,cUnitPriceColumn, cUOMQty, cUOM,  cTotalQtyColumn, cQtyColumn]) then begin
        if (not NodeData.Data.IsOptionItem) or (NodeData.Data.Selected) then begin

               if (Column = cCostColumn   ) then CellText := FormatFloat(CurSym + ''+CostinTreeFormat+';(' + CurSym + ''+CostinTreeFormat+')', NodeData.Data.cost  )
          else if (Column = cAvgCostColumn) then CellText := FormatFloat(CurSym + ''+CostinTreeFormat+';(' + CurSym + ''+CostinTreeFormat+')', NodeData.Data.ProductUnitCost )
          else if (Column = cPriceColumn) then begin
            if (NodeData.Data.matrixprice <> 0) and (NodeData.Data.PriceExLabour = 0) then
                CellText := FormatFloat(CurSym + '#,##0.00;(' + CurSym + '#,##0.00)', NodeData.Data.matrixprice  )
            else CellText := FormatFloat(CurSym + '#,##0.00;(' + CurSym + '#,##0.00)', NodeData.Data.PriceExLabour  );
          end else if column = cUnitPriceColumn then begin
            CellText := FormatFloat(CurSym + '#,##0.00;(' + CurSym + '#,##0.00)', NodeData.Data.ProductUnitPrice  )
          end else if (Column = cUOMQty) then
              CellText := FormatFloat('##########0.##########', NodeData.Data.QtyFor1UOMParent) + ' x ' + NodeData.Data.TreePartUOM + ' (' + FormatFloat('##########0.##########',NodeData.Data.TReePartUOMMultiplier) + ')'
          else if (Column = cUOM)  then CellText := NodeData.Data.TreePartUOM + ' (' + FormatFloat('##########0.##########',NodeData.Data.TReePartUOMMultiplier) + ')'
          else if (Column = cTotalQtyColumn) then
              CellText := FormatFloat('##########0.##########', NodeData.Data.QtyForUOMParent) + ' x ' + NodeData.Data.TreePartUOM + ' (' + FormatFloat('##########0.##########',NodeData.Data.TReePartUOMMultiplier) + ')'
            { CellText:= Formatfloat('##########0.##########',NodeData.Data.TreePartUOMTotalQty)+ ' x ' + NodeData.Data.TreePartUOM+' (' +floatToStr(NodeData.Data.TReePartUOMMultiplier)+')'//FloatToStr(NodeData.Data.TotalQty); }
          else if (Column = cQtyColumn) then begin
            CellText := FormatFloat('##########0.##########', NodeData.Data.TreePartUOMQuantity  ); // FloatToStr(NodeData.Data.Quantity);
          end;
        end;
{-->} end else if (Column = cLabourPriceColumn) then begin
        xPrice := NodeData.Data.ProcesstepPrice; // * NodeData.Data.TreePartUOMTotalQty;
        if xPrice <> 0 then CellText := FormatFloat(CurSym + '#,##0.00;(' + CurSym + '#,##0.00)', xPrice);
{-->} end else if (Column = cPartNameColumn) and (NodeData.Captions[Column] = '') then begin CellText := 'New (Dbl click for product)';
{-->} end else if (Column = cPartDescColumn) and (NodeData.Data.Description <> '') then begin CellText := NodeData.Data.Description;
//{-->} end else if (Column = cProcessStepExtraInfo) and (NodeData.Data.processstepExtaInfo <> '') then begin CellText := NodeData.Data.processstepExtaInfo;

{-->} end else if (Column = cFormulaQty ) then begin ShowFormulaQty(Celltext ,NodeData.Data.FormulaQtyValue);
{-->} end else if (Column = cFormulaQty1) then begin ShowFormulaQty(Celltext ,NodeData.Data.FormulaQtyValue1);
{-->} end else if (Column = cFormulaQty2) then begin ShowFormulaQty(Celltext ,NodeData.Data.FormulaQtyValue2);
{-->} end else if (Column = cFormulaQty3) then begin ShowFormulaQty(Celltext ,NodeData.Data.FormulaQtyValue3);
{-->} end else if (Column = cFormulaQty4) then begin ShowFormulaQty(Celltext ,NodeData.Data.FormulaQtyValue4);
{-->} end else if (Column = cFormulaQty5) then begin ShowFormulaQty(Celltext ,NodeData.Data.FormulaQtyValue5);
{-->} end else if (Column = cbFormulaQty) then begin ShowFormulaQty(Celltext ,NodeData.Data.BuildFormulaQtyValue);
{-->} end else if (Column = cbFormulaQty1) then begin ShowFormulaQty(Celltext ,NodeData.Data.BuildFormulaQtyValue1);
{-->} end else if (Column = cbFormulaQty2) then begin ShowFormulaQty(Celltext ,NodeData.Data.BuildFormulaQtyValue2);
{-->} end else if (Column = cbFormulaQty3) then begin ShowFormulaQty(Celltext ,NodeData.Data.BuildFormulaQtyValue3);
{-->} end else if (Column = cbFormulaQty4) then begin ShowFormulaQty(Celltext ,NodeData.Data.BuildFormulaQtyValue4);
{-->} end else if (Column = cbFormulaQty5) then begin ShowFormulaQty(Celltext ,NodeData.Data.BuildFormulaQtyValue5);

{-->} end else if (Column = coFormulaQty ) then begin ShowFormulaQty(Celltext ,NodeData.Data.OrderFormulaQtyValue);
{-->} end else if (Column = coFormulaQty1) then begin ShowFormulaQty(Celltext ,NodeData.Data.OrderFormulaQtyValue1);
{-->} end else if (Column = coFormulaQty2) then begin ShowFormulaQty(Celltext ,NodeData.Data.OrderFormulaQtyValue2);
{-->} end else if (Column = coFormulaQty3) then begin ShowFormulaQty(Celltext ,NodeData.Data.OrderFormulaQtyValue3);
{-->} end else if (Column = coFormulaQty4) then begin ShowFormulaQty(Celltext ,NodeData.Data.OrderFormulaQtyValue4);
{-->} end else if (Column = coFormulaQty5) then begin ShowFormulaQty(Celltext ,NodeData.Data.OrderFormulaQtyValue5);

{-->} end else if (Column = cStockQty) then begin CellText := FormatFloat('##########0.##########', NodeData.Data.FromStockUOMQty );
{-->} end else if (Column = cbuildQty) then begin CellText := FormatFloat('##########0.##########', NodeData.Data.ManufactureUOMQty );
{-->} end else if (Column = cOrderQty) then begin CellText := FormatFloat('##########0.##########', NodeData.Data.OnorderUOMQty );
{-->} end else if (Column = cSubBOMProcessOrder)  then begin
(*        if (NodeData.Data.Children.count =0) or (NodeData.Data.PartsID =0) or (Node = Sender.RootNode.FirstChild ) then CellText := ''
        else CellText := cSubBOMProcessOrderText[NodeData.Data.SubBOMProcessOrder];*)
        if EnableSubBOMProcessOrder(Node , nodedata) then CellText := cSubBOMProcessOrderText[NodeData.Data.SubBOMProcessOrderCode] else CellText := '';
{-->} end else begin CellText := NodeData.Captions[Column];
      end;
    end;
  except
    on E: Exception do begin
    end;
  end;
end;
Procedure CalcPrice(const node:TProcTreeNode);
begin
  Processingcursor(True);
  try
    node.calcPrice;
  finally
    Processingcursor(False);
  end;
end;
Procedure RefreshQty(const Node: PVirtualNode;NodeData: PNodeData; DoCalPrice:Boolean =TRue);
begin
  if NodeData.data.MasterType = mtSalesOrder then begin
    NodeData.Captions[cbFormulaQty]  := FormatFloat('##########0.##########', NodeData.Data.BuildFormulaQtyValue  );
    NodeData.Captions[cbFormulaQty1] := FormatFloat('##########0.##########', NodeData.Data.BuildFormulaQtyValue1  );
    NodeData.Captions[cbFormulaQty2] := FormatFloat('##########0.##########', NodeData.Data.BuildFormulaQtyValue2  );
    NodeData.Captions[cbFormulaQty3] := FormatFloat('##########0.##########', NodeData.Data.BuildFormulaQtyValue3  );
    NodeData.Captions[cbFormulaQty4] := FormatFloat('##########0.##########', NodeData.Data.BuildFormulaQtyValue4  );
    NodeData.Captions[cbFormulaQty5] := FormatFloat('##########0.##########', NodeData.Data.BuildFormulaQtyValue5  );
    NodeData.Captions[coFormulaQty]  := FormatFloat('##########0.##########', NodeData.Data.OrderFormulaQtyValue  );
    NodeData.Captions[coFormulaQty1] := FormatFloat('##########0.##########', NodeData.Data.OrderFormulaQtyValue1  );
    NodeData.Captions[coFormulaQty2] := FormatFloat('##########0.##########', NodeData.Data.OrderFormulaQtyValue2  );
    NodeData.Captions[coFormulaQty3] := FormatFloat('##########0.##########', NodeData.Data.OrderFormulaQtyValue3  );
    NodeData.Captions[coFormulaQty4] := FormatFloat('##########0.##########', NodeData.Data.OrderFormulaQtyValue4  );
    NodeData.Captions[coFormulaQty5] := FormatFloat('##########0.##########', NodeData.Data.OrderFormulaQtyValue5  );
    NodeData.Captions[cStockQty]   := FormatFloat('##########0.##########', NodeData.Data.FromStockUOMQty );
    NodeData.Captions[cOrderQty]   := FormatFloat('##########0.##########', NodeData.Data.OnorderUOMQty );
    NodeData.Captions[cbuildQty]   := FormatFloat('##########0.##########', NodeData.Data.ManufactureUOMQty );
  end;
  NodeData.Captions[cQtyColumn]    := FormatFloat('##########0.##########', NodeData.Data.TreePartUOMQuantity  );
  NodeData.Captions[cFormulaQty]   := FormatFloat('##########0.##########', NodeData.Data.FormulaQtyValue  );
  NodeData.Captions[cFormulaQty1]  := FormatFloat('##########0.##########', NodeData.Data.FormulaQtyValue1  );
  NodeData.Captions[cFormulaQty2]  := FormatFloat('##########0.##########', NodeData.Data.FormulaQtyValue2  );
  NodeData.Captions[cFormulaQty3]  := FormatFloat('##########0.##########', NodeData.Data.FormulaQtyValue3  );
  NodeData.Captions[cFormulaQty4]  := FormatFloat('##########0.##########', NodeData.Data.FormulaQtyValue4  );
  NodeData.Captions[cFormulaQty5]  := FormatFloat('##########0.##########', NodeData.Data.FormulaQtyValue5  );

  if NodeData.Data.TreePartUOMQuantity = 0 then begin
    NodeData.Data.QtyPer := 0;
  end
  else NodeData.Data.QtyPer := 1 / NodeData.Data.TreePartUOMQuantity;
  if DoCalPrice then  CalcPrice(TProcTreeNode(NodeData.Data.RootNode));
end;
procedure TframeTree.SetTreecolumn(Node: PVirtualNode; const Value: Integer);
begin
  if Value <0 then exit;
  SetControlFocus(vstProcessPart);
  vstProcessPart.FocusedColumn :=Value;
  vstProcessPart.EditNode(Node, Value);
  vstProcessPart.ScrollIntoView(node , true, true);
end;
procedure TframeTree.vstProcessPartNewText(const Sender: TBaseVirtualTree; const Node: PVirtualNode; const Column: TColumnIndex; const NewText: string);
var
  NodeData: PNodeData;
  fd:double;
  s:String;

  Procedure AddspecialPrice(const fdPrice :Double);
  begin
    if NodeData.data.MasterType = mtProduct then Exit;
    if not(NodeData.Data is  TSalesLineProcTree) then Exit;
    if TSalesLineProcTree(NodeData.Data).PartsId =0 then exit;

    if CommonLib.MessageDlgXP_Vista('Do You Wish To Add This Product To' + #13 + #10 + 'Customers Special Price List ?', mtconfirmation, [mbYes, mbNo], 0 ) = mryes then begin
      ClientDiscountObj.Client_Add_SpecialPrice(TSalesLineProcTree(NodeData.Data).Sales.CustomerID, TSalesLineProcTree(NodeData.Data).PartsId ,fdPrice );
    end;
  end;


Procedure RefreshQtys(xNode: PVirtualNode);
var
  x:Integer;
  ChildNode: PVirtualNode;
begin
   SetNodeDataFields(xNode);
   ChildNode := xNode.FirstChild;
    for x := 0 to xNode.ChildCount - 1 do begin
      RefreshQtys(Childnode);
      ChildNode := ChildNode.NextSibling;
    end;
  end;
begin
  try
      try
        NodeData := Sender.GetNodeData(Node);

    NodeData.Captions[Column] := NewText;

    if NodeData.data.isroot and (Column in [cStockQty ,cbuildQty, cOrderqty , cQtyColumn, cQtyPercolumn]) then begin
          MessageDlgXP_vista('Quantity cannot be changed in the Root node', mtInformation, [mbok], 0);
          RefreshQtys(Node);
          Sender.Refresh;
          Exit;
    end;

    case Column of
          cRAtePercoupon : begin          NodeData.Data.RAtePercoupon := strValue(NewText);   end;
          cQtyPerCoupon  : begin          NodeData.Data.QtyPerCoupon  := strValue(NewText);   end;
          cPartNameColumn: begin          NodeData.Data.Caption := NewText;         end;
          cPartDescColumn: begin          NodeData.Data.Description := NewText;     end;
          cInfoColumn    : begin          NodeData.Data.Info := NewText;            end;
          cUnitPriceColumn:begin
            if (NodeData.Data.PartsID <=0) or (NodeData.Data.children.count >0) then else begin
              fdValue := strValue(Newtext);
              if NodeData.Data.ProductUnitPrice  <> fdValue then begin
                NodeData.Data.ProductUnitPrice := fdValue;
                NodeData.Data.TreePricechanged := TRue;
                AddspecialPrice(fdValue);
                CalcPrice(TProcTreeNode(NodeData.Data.RootNode));
                Sender.Refresh;
                end;
              end;
            end;
          cFormulaQty: begin NodeData.Data.FormulaQtyValue  := strValue(Newtext);RefreshQty(node,nodeData);Sender.Refresh; end;
          cFormulaQty1:begin NodeData.Data.FormulaQtyValue1 := strValue(Newtext);RefreshQty(node,nodeData);Sender.Refresh; end;
          cFormulaQty2:begin NodeData.Data.FormulaQtyValue2 := strValue(Newtext);RefreshQty(node,nodeData);Sender.Refresh; end;
          cFormulaQty3:begin NodeData.Data.FormulaQtyValue3 := strValue(Newtext);RefreshQty(node,nodeData);Sender.Refresh; end;
          cFormulaQty4:begin NodeData.Data.FormulaQtyValue4 := strValue(Newtext);RefreshQty(node,nodeData);Sender.Refresh; end;
          cFormulaQty5:begin NodeData.Data.FormulaQtyValue5 := strValue(Newtext);RefreshQty(node,nodeData);Sender.Refresh; end;


      cbFormulaQty: begin NodeData.Data.BuildFormulaQtyValue   := strValue(Newtext);RefreshQty(node,nodeData);Sender.Refresh; end;
      cbFormulaQty1:begin NodeData.Data.BuildFormulaQtyValue1  := strValue(Newtext);RefreshQty(node,nodeData);Sender.Refresh; end;
      cbFormulaQty2:begin NodeData.Data.BuildFormulaQtyValue2  := strValue(Newtext);RefreshQty(node,nodeData);Sender.Refresh; end;
      cbFormulaQty3:begin NodeData.Data.BuildFormulaQtyValue3  := strValue(Newtext);RefreshQty(node,nodeData);Sender.Refresh; end;
      cbFormulaQty4:begin NodeData.Data.BuildFormulaQtyValue4  := strValue(Newtext);RefreshQty(node,nodeData);Sender.Refresh; end;
      cbFormulaQty5:begin NodeData.Data.BuildFormulaQtyValue5  := strValue(Newtext);RefreshQty(node,nodeData);Sender.Refresh; end;

      coFormulaQty: begin NodeData.Data.OrderformulaQtyValue   := strValue(Newtext);RefreshQty(node,nodeData);Sender.Refresh; end;
      coFormulaQty1:begin NodeData.Data.OrderformulaQtyValue1  := strValue(Newtext);RefreshQty(node,nodeData);Sender.Refresh; end;
      coFormulaQty2:begin NodeData.Data.OrderformulaQtyValue2  := strValue(Newtext);RefreshQty(node,nodeData);Sender.Refresh; end;
      coFormulaQty3:begin NodeData.Data.OrderformulaQtyValue3  := strValue(Newtext);RefreshQty(node,nodeData);Sender.Refresh; end;
      coFormulaQty4:begin NodeData.Data.OrderformulaQtyValue4  := strValue(Newtext);RefreshQty(node,nodeData);Sender.Refresh; end;
      coFormulaQty5:begin NodeData.Data.OrderformulaQtyValue5  := strValue(Newtext);RefreshQty(node,nodeData);Sender.Refresh; end;

      cStockQty: begin
        if not(SameValue(NodeData.Data.FromStockUOMQty , strValue(Newtext))) then begin
          NodeData.Data.FromStockUOMQty := strValue(Newtext);
          RefreshQtys(Node);
          Sender.Refresh;
        end;
        end;
      cbuildQty: begin
        if not(sameValue(NodeData.Data.ManufactureUOMQty , strValue(Newtext))) then begin
          NodeData.Data.ManufactureUOMQty := strValue(Newtext);
          RefreshQtys(Node);
          Sender.Refresh;
        end;
        end;
      cOrderqty: begin
        if not(SameValue(NodeData.Data.OnOrderUOMQty , strValue(Newtext))) then begin
          fd:=strValue(Newtext);
          try
            NodeData.Data.OnOrderUOMQty := fd;
            RefreshQtys(Node);
            Sender.Refresh;
          finally
            if NodeData.Data.OnOrderUOMQty <> fd then
              if (NodeData.Data is TSalesLineProcTree) and (TSalesLineProcTree(NodeData.Data).SmartOrderID<> 0) then
                   s:='You cannot order More than the Qty required for the build from here. '+NL+
                      'Please change the quantity in the smart order #' + inttostr(TSalesLineProcTree(NodeData.Data).SmartOrderID) +' if more to be ordered.'
              else s:= 'You cannot order More than the Qty required for the build from here. '+NL+
                      'Saving this will make a smart order and please change the quantity in the smart order if more to be ordered.';
              s:= s + NL+NL+'Please note that Changing these Quantities and saving the tree will recreate the Smart order and all changes made to the Smart order will be lost';
              MessageDlgXP_vista(s, mtInformation, [mbok], 0);

          end;
          end;
        end;
      cQtyColumn: begin
          if (NewText <> '') and not(Samevalue(NodeData.Data.TreePartUOMQuantity ,StrToFloatDef(NewText, 0))) then begin
            NodeData.Data.TreePartUOMQuantity { Quantity } := StrToFloatDef(NewText, 0);
            if NodeData.Data.TreePartUOMQuantity = 0 then begin
              NodeData.Data.QtyPer := 0;
            end
            else NodeData.Data.QtyPer := 1 / NodeData.Data.TreePartUOMQuantity;
            CalcPrice(TProcTreeNode(NodeData.Data.RootNode));
            RefreshQtys(Node);
            Sender.Refresh;
            CheckForLinkedSubs(NodeData.Data,true);
          end;
        end;
      cQtyPercolumn: begin
        if not(SameValue(NodeData.Data.QtyPer , StrToFloatDef(NewText, 0))) then begin
          NodeData.Data.QtyPer := StrToFloatDef(NewText, 0);
          if NodeData.Data.QtyPer = 0 then begin
            NodeData.Data.TreePartUOMQuantity := 0;
            CheckForLinkedSubs(NodeData.Data,true);
          end
          else begin
            NodeData.Data.TreePartUOMQuantity := 1 / NodeData.Data.QtyPer;
            CheckForLinkedSubs(NodeData.Data,true);
          end;
          CalcPrice(TProcTreeNode(NodeData.Data.RootNode));
          NodeData.Captions[cQtyColumn] := FormatFloat('##########0.##########', NodeData.Data.TreePartUOMQuantity  ); // FloaTtoStr(NodeData.Data.Quantity) ;
          NodeData.Captions[cQtyPercolumn] := FormatFloat('##########0.##########', NodeData.Data.QtyPer); // FloaTtoStr(NodeData.Data.QtyPer);
          Sender.Refresh;
        end;
        end;
      cSubBOMProcessOrder: begin
         NodeData.Captions[cSubBOMProcessOrder] := cSubBOMProcessOrderText[NodeData.Data.SubBOMProcessOrderCode];
      end;
    end;
  except
    on E: Exception do begin
      LogD('TframeTree.vstProcessPartNewText - Exception: ' + E.Message);
      raise;
    end;
  end;
  Finally
      CheckForCostnPricechange;
   end;
end;

procedure TframeTree.CheckForCostnPricechange;
begin
  if Assigned(fdoCheckForCostnPricechange) then
    fdoCheckForCostnPricechange;
end;

procedure TframeTree.CheckForLinkedSubs(aNode: TProcTreeNode; IsQuantityChange: boolean);
var
  SubList: TStringList;
  s: string;

  procedure CheckNode(aTreeNode: TProcTreeNode);
  begin
    if aTreeNode.InheritFromID > 0 then begin
      SubList.Add(aTreeNode.Caption);
      aTreeNode.InheritFromID := 0;
      aTreeNode.InheritFromEditVersion := 0;
    end;
    if Assigned(aTreeNode.Owner) and (aTreeNode.Owner is TProcTreeNode) then
     CheckNode(TProcTreeNode(aTreeNode.Owner));
  end;

  function SubListStr: string;
  var
    x: integer;
  begin
    result := '';
    for x := 0 to SubList.Count -1 do  begin
      if x > 0 then result := result + #13#10;
      result := result + SubList[x];
    end;
  end;

begin
//  exit;
  if not aNode.IsTemplate then exit;

  { user is allowed to change quantity of top level item .. }
  if (aNode.InheritFromID > 0) and IsQuantityChange then exit;


  SubList := TStringList.Create;
  try
    CheckNode(aNode);
    if SubList.Count > 0 then begin
      s :=
        'The following Sub-Assemblie(s) will no longer be linked to this Product:' + #13#10 + #13#10 +
        SubListStr + #13#10 + #13#10 +
        'This means that any changes made to these Sub-Assemblies in isolation will no longer be reflected in this Products Manufacturing Tree';

      CommonLib.MessageDlgXP_Vista(s,mtInformation,[mbOk],0);
    end;

  finally
    SubList.Free;
  end;

end;

procedure TframeTree.vstProcessPartEditing(const Sender: TBaseVirtualTree; const Node: PVirtualNode; const Column: TColumnIndex; var Allowed: Boolean);
begin
  Allowed := True;
end;

procedure TframeTree.vstProcessPartCreateEditor(const Sender: TBaseVirtualTree; const Node: PVirtualNode; const Column: TColumnIndex; out EditLink: IVTEditLink);
begin
  try
    FVTEditControl := TVTFrameEditControl.Create;
    FVTEditControl.ControlType := cTreeFrameColumnControls[Column];

    case FVTEditControl.ControlType of
      ectEdit: begin
          FVTEditControl.Edit.Parent := Sender;

          if (Column = cPartNameColumn) or (Column = cInfoColumn) or (Column = cQtycolumn)   then FVTEditControl.Edit.OnDblClick := HandleDblClick
          else if ((Column = cStockQty)    or (Column = cBuildQty)   ) and  (FTreeMode <> tmTemplate)  then FVTEditControl.Edit.OnDblClick := HandleDblClick
          else FVTEditControl.Edit.OnDblClick := nil;
          if DoopenProductList and (Column = cPartNameColumn) then begin
             HandleDblClick(FVTEditControl.Edit);
             vstProcessPart.SetFocus;
             vstProcessPart.FocusedColumn := cQtyColumn;
             vstProcessPart.EditNode(Node, cQtyColumn);
          end;
        end;

      ectComboBox: begin
          FVTEditControl.ComboBox.Parent := Sender;
          FVTEditControl.CustomEditHandle := ShowPopupForm;
        end;

      ectDatePicker: begin
          FVTEditControl.DateTimePicker.Parent := Sender;
        end;

      ectButton: begin
          FVTEditControl.Button.Parent := Sender;
          FVTEditControl.Button.Caption := '...';
          FVTEditControl.Button.Style := bsModern;
          FVTEditControl.Button.Color := clWhite;
          FVTEditControl.Button.HotTrackColor := clBtnShadow;
          FVTEditControl.Button.SlowDecease := True;
          FVTEditControl.Button.DisableTransparent := True;
          FVTEditControl.Button.OnClick := HandleButtonClick;
        end;
    end;

    EditLink := FVTEditControl;
  except
    on E: Exception do begin
      LogD('TframeTree.vstProcessPartCreateEditor - Exception: ' + E.Message);
      raise;
    end;
  end;
end;
procedure TframeTree.UnSelectNode(aNode: PVirtualNode);
var
  x:Integer;
  ChildNode: PVirtualNode;
begin
   vstProcessPart.Selected[aNode] := False;
   ChildNode := aNode.FirstChild;
    for x := 0 to aNode.ChildCount - 1 do begin
      UnSelectNode(Childnode);
      ChildNode := ChildNode.NextSibling;
    end;
end;

procedure TframeTree.ChecknAddFormulaRelatedProducts(aParentNode: PVirtualNode;newNode: PVirtualNode);
var
    qry: TERPQuery;
    NewNodeData: PNodeData;


    Procedure AddFormulaRelatedProduct;
    var
      FormulaRelatedProductNode: PVirtualNode;
      NodeData : PNodedata;
    begin
       NodeData := vstProcessPart.GetNodeData(aParentNode);
       FCurrentNode:=aParentNode;
       UnSelectNode(vstProcessPart.RootNode.FirstChild);
       vstProcessPart.Selected[aParentNode] := True;
       AddBranch(NodeData, FormulaRelatedProductNode);

       FCurrentNode:= FormulaRelatedProductNode;
       // vstProcessPart.EditNode(newNode, cPartNameColumn);
       OnSelectProduct(fVTEditControl , vstProcessPart,
                        Qry.Fieldbyname('ProductID').asinteger,
                        Qry.Fieldbyname('Productname').asString,
                        Qry.Fieldbyname('Description').asString,
                        NodeData , FormulaRelatedProductNode);
    end;
begin
     NewNodeData := vstProcessPart.GetNodeData(newNode);
     if NewNodeData.data.Formulaid <> 0 then begin
          qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
          try
            Qry.sql.text := 'Select R.*, p.Description from  tblfeformularelatedproducts R inner join tblparts p on R.ProductID = p.PARTSID where R.FormulaID = ' + inttostr(NewNodeData.data.Formulaid) +' and R.Active ="T"';
            Qry.open;
            if Qry.recordcount >0 then begin
              Qry.first;
              While Qry.EOF = False do begin

                AddFormulaRelatedProduct;
                Qry.Next;
              end;
            end;
          finally
            DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
          end;

     end;
end;

procedure TframeTree.AddProduct1Click(Sender: TObject);
var
  NodeData: PNodeData;
  newNode: PVirtualNode;
  aParentNode:PVirtualNode;
begin
  aParentNode := vstProcessPart.GetFirstSelected;
  AddBranch(NodeData, newNode);
  vstProcessPart.SetFocus;
  vstProcessPart.FocusedColumn := cPartNameColumn;
  FCurrentNode:= newnode;
  DoopenProductList:=true;
  try
    vstProcessPart.EditNode(newNode, cPartNameColumn);
    if Assigned(NodeData.data.parentnode) then
    ChecknAddFormulaRelatedProducts(aParentNode , newNode);
  finally
    DoopenProductList:=False;
  end;
  if NodeData.data.parentnode.children.count >0 then begin
    if NodeData.data.parentnode.TreePricechanged then
      NodeData.data.parentnode.TreePricechanged  := False;
      CalcPrice(TProcTreeNode(NodeData.Data.RootNode));
      vstProcessPart.Refresh;
  end;
end;


procedure TframeTree.miAddBranchClick(Sender: TObject);
var
  NodeData: PNodeData;
  newNode: PVirtualNode;
begin
  AddBranch(NodeData,newNode);
  if NodeData.data.parentnode.children.count >0 then begin
    if NodeData.data.parentnode.TreePricechanged then
      NodeData.data.parentnode.TreePricechanged  := False;
      CalcPrice(TProcTreeNode(NodeData.Data.RootNode));
      vstProcessPart.Refresh;
  end;
end;

procedure TframeTree.AddBranch(var NodeData: PNodeData; var newNode: PVirtualNode);
begin
  try
    newNode := vstProcessPart.AddChild(vstProcessPart.GetFirstSelected);
    vstProcessPart.Expanded[vstProcessPart.GetFirstSelected] := True;
    vstProcessPart.Selected[newNode] := True;
    NodeData := vstProcessPart.GetNodeData(newNode);
    NodeData.Data.TreePartUOMMultiplier :=1;
    if Assigned(NodeData.data.parentnode) then begin
      NodeData.Data.Quantity := NodeData.data.parentnode.ManufactureQty;
      NodeData.Data.TreePartUOMTotalQty := NodeData.data.parentnode.ManufactureUOMQty;
    end else begin
      NodeData.Data.Quantity := 1;
      NodeData.Data.TreePartUOMTotalQty := 1;
    end;
    NodeData.Captions[cQtyPercolumn] := FormatFloat('##########0.##########', 1);
    NodeData.Captions[cQtyColumn] := FormatFloat('##########0.##########', 1);
    NodeData.Captions[cQtyPerCoupon] := FormatFloat('##########0.##########', 1);
    NodeData.Captions[cRAtePercoupon] := FormatFloat('##########0.##########', 1);
    CheckForLinkedSubs(NodeData.Data);
  except
    on E: Exception do begin
      LogD('TframeTree.miAddBranchClick - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TframeTree.miInsertClick(Sender: TObject);
var
  newNode: PVirtualNode;
begin
  try
    if TreeReadonly then exit;

    if vstProcessPart.GetFirstSelected = vstProcessPart.RootNode.FirstChild then Exit;

    newNode := vstProcessPart.InsertNode(vstProcessPart.GetFirstSelected, amInsertAfter);
    vstProcessPart.Selected[newNode] := True;
  except
    on E: Exception do begin
      LogD('TframeTree.miInsertClick - Exception: ' + E.Message);
      raise;
    end;
  end;
end;
procedure TframeTree.DeleteTree;
var
  Node: PVirtualNode;
  NodeData: PNodeData;
begin
    if RootNodeData.children.count =0 then exit;
    OTFPartIDs :='';
    OTFPartIDscount:=0;
    While vstProcessPart.RootNode.FirstChild.childcount>0 do  begin
      Node:=vstProcessPart.RootNode.FirstChild.FirstChild;
      NodeData:= vstProcessPart.GetNodeData(Node);

      if OTFPartIDs <> '' then OTFPartIDs := OTFPartIDs +',';
      OTFPartIDs := OTFPartIDs +inttostr(NodeData.Data.PartsId);
      OTFPartIDscount:= OTFPartIDscount+1;
      DeleteNode(Node);
    end;
    CalcPrice(self.RootNodeData);
end;

Procedure TframeTree.DeleteNode(Node: PVirtualNode);
var
  ParentNodeData:PNodeData;
  NodeData: PNodeData;
  fdQty:double;
begin
        NodeData := vstProcessPart.GetNodeData(Node);
        CheckOptions(Node);
        ParentNodeData := vstProcessPart.GetNodeData(Node.Parent);
        CheckForLinkedSubs(NodeData.Data);
        NodeData.Data.Delete;
        NodeData.Data.Free;
        vstProcessPart.DeleteNode(Node);
        ParentNodeData.Data.Price := 0;
        ParentNodeData.Data.Price := 0;
        ParentNodeData.Data.productunitcost := 0;
        ParentNodeData.Data.productunitPrice := 0;
        if ParentNodeData.Data.Children.Count =0 then begin
          fdQty:= ParentNodeData.Data.TreePartUOMQuantity;
          ParentNodeData.Data.TreePartUOMQuantity  := 0;
          ParentNodeData.Data.TreePartUOMQuantity := fdQty;
        end;
end;

procedure TframeTree.miDeleteClick(Sender: TObject);
var
  Node: PVirtualNode;
  DeleteNodes: Boolean;
begin
  try
    vstProcessPart.CancelEditNode;
    Node := vstProcessPart.GetFirstSelected;
    if node = vstProcessPart.RootNode.FirstChild then Exit;


      DeleteNodes := True;

      if Node.ChildCount > 0 then begin
        if CommonLib.MessageDlgXP_Vista('This item has branches which will also be deleted. Continue?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then DeleteNodes := False;
      end;

      if DeleteNodes then begin
        Deletenode(Node);
      end;
      if Node = vstProcessPart.RootNode.FirstChild then CommonLib.MessageDlgXP_Vista('The first item cannot be deleted.', mtWarning, [mbOk], 0)
      else begin
        CalcPrice(self.RootNodeData);
      end;
      self.vstProcessPart.Refresh;

  except
    on E: Exception do begin
      LogD('TframeTree.miDeleteClick - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TframeTree.WMStartEditing(var Msg: TMessage);
var
  Node: PVirtualNode;
begin
  try
    Node := Pointer(Msg.WParam);

    if Assigned(Node) then vstProcessPart.EditNode(Node, Msg.lParam);
  except
    on E: Exception do begin
      LogD('TframeTree.WMStartEditing - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TframeTree.vstProcessPartDragOver(const Sender: TBaseVirtualTree; const Source: TObject; const Shift: TShiftState; const State: TDragState; const Pt: TPoint; const Mode: TDropMode;
  var Effect: Integer; var Accept: Boolean);
begin
  if (not self.TreeReadOnly) then Accept := True
  else Accept := False;
end;

procedure TframeTree.vstProcessPartDrawText(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  const Text: string; const CellRect: TRect; var DefaultDraw: Boolean);
var
  NodeData: PNodeData;
begin
  NodeData := vstProcessPart.GetNodeData(Node);
    if (column = cUnitPriceColumn) and  NodeData.Data.TreePricechanged then begin
      TargetCanvas.Font.Color := clRed;
    end else begin
      TargetCanvas.Font.Color := clblack;
    end;
end;

procedure TframeTree.vstProcessPartDragDrop(const Sender: TBaseVirtualTree; const Source: TObject; const DataObject: IDataObject; const Formats: TFormatArray; const Shift: TShiftState;
  const Pt: TPoint; var Effect: Integer; const Mode: TDropMode);
var
  index: Integer;
  ChildIndex: Integer;
  Nodes: TNodeArray;
  NodeData: PNodeData;
  AttachMode: TVTNodeAttachMode;
  TmpNode: TProcTreeNode;
  ChildNode: PVirtualNode;
  DropSuccess: Boolean;
  ExpandNode: Boolean;
  ParentNodeData:PNodeData;
  fdQty:Double;
begin
  try
    Nodes := Sender.GetSortedSelection(True);

      if Nodes[0] <> Sender.DropTargetNode then begin
        ParentNodeData := Sender.GetNodeData(Nodes[0].Parent);

        if Sender.HasAsParent(Sender.DropTargetNode, Nodes[0]) then CommonLib.MessageDlgXP_Vista('Target cannot be a child branch.', mtWarning, [mbOk], 0)

          // else if ((PNodeData(Sender.GetNodeData(Node)).Data.PartsId > 0) then
        else begin
          DropSuccess := False;

          case Mode of
            dmAbove: begin
                AttachMode := amInsertBefore;

                if Sender.DropTargetNode <> Sender.RootNode.FirstChild then DropSuccess := True;
              end;

            dmOnNode: begin
                AttachMode := amAddChildLast;
                DropSuccess := True;
              end;

            dmBelow: begin
                AttachMode := amInsertAfter;

                if Sender.DropTargetNode <> Sender.RootNode.FirstChild then DropSuccess := True;
              end;

          else AttachMode := amNowhere;
          end;


        if DropSuccess and (Effect = DROPEFFECT_MOVE) then begin
          for index := 0 to high(Nodes) do begin
            CheckOptions(Nodes[index]);
            NodeData := Sender.GetNodeData(Nodes[index]);
            TmpNode := NodeData.Data;
            TProcTreeNode(TmpNode.Owner).Children.Remove(TmpNode);
            ExpandNode := (Sender.DropTargetNode.ChildCount = 0) or Sender.Expanded[Sender.DropTargetNode];
            DisplayCheckBoxes(Nodes[index], False, False);
            Sender.MoveTo(Nodes[index], Sender.DropTargetNode, AttachMode, False);
            NodeData := Sender.GetNodeData(Sender.DropTargetNode);

            if AttachMode = amAddChildLast then begin
              Sender.Expanded[Sender.DropTargetNode] := ExpandNode;
              NodeData.Data.Children.Add(TmpNode);
            end else begin
              ChildIndex := 0;
              ChildNode := Sender.DropTargetNode.Parent.FirstChild;

              while Assigned(ChildNode) and (ChildNode <> Nodes[index]) do begin
                ChildNode := ChildNode.NextSibling;
                Inc(ChildIndex);
              end;

              TProcTreeNode(NodeData.Data.Owner).Children.Insert(ChildIndex, TmpNode);
            end;
          end;
          if ParentNodeData.Data.Children.Count =0 then begin
            fdQty:= ParentNodeData.Data.TreePartUOMQuantity;
            ParentNodeData.Data.TreePartUOMQuantity  := 0;
            ParentNodeData.Data.TreePartUOMQuantity := fdQty;
          end;
          CalcPrice(self.RootNodeData);
          self.vstProcessPart.Refresh;
        end;
      end;
    end;
  except
    on E: Exception do begin
      LogD('TframeTree.vstProcessDragDrop - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TframeTree.vstProcessPartMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  try
    FMouseButton := Button;
    FCurrentNode := vstProcessPart.GetNodeAt(X, Y);

    if Button = mbRight then begin
      vstProcessPart.Selected[FCurrentNode] := True;

      if (not Assigned(FCurrentNode))  or (TreeReadOnly) then begin
        miAddBranch.Enabled := False;
        miInsert.Enabled := False;
        miDelete.Enabled := False;
      end else begin
        miAddBranch.Enabled := True;

        if FCurrentNode = vstProcessPart.RootNode.FirstChild then begin
          miInsert.Enabled := False;
          miDelete.Enabled := False;
        end else begin
          miInsert.Enabled := True;
          miDelete.Enabled := True;
        end;
      end;
    end;
    Application.ProcessMessages;
  except
    on E: Exception do begin
      LogD('TframeTree.vstProcessPartMouseDown - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TframeTree.vstProcessPartColumnClick(Sender: TBaseVirtualTree; Column: TColumnIndex; Shift: TShiftState);
var
  index: Integer;
  CheckBoxColumn: Boolean;
begin
  try
    CheckBoxColumn := False;

    for index := 0 to cMaxCheckBoxes - 1 do begin
      if Column = cCheckBoxColumns[index] then CheckBoxColumn := True;
    end;
    if Assigned(FCurrentNode) and (Column >= 0) and (not CheckBoxColumn) and (FMouseButton = mbLeft) then
      if (FCurrentNode = vstProcessPart.RootNode.FirstChild) and (Column = 0) then
      else  PostMessage(Handle, WM_STARTEDITING, Integer(FCurrentNode), Column);
  except
    on E: Exception do begin
      LogD('TframeTree.vstProcessPartColumnClick - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TframeTree.vstProcessPartAfterCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; CellRect: TRect);
var
  NodeData: PNodeData;
  ParentNodeData: PNodeData;
  DisplayRect: TRect;
  MidPoint: Integer;
  CheckBoxIndex: Integer;
  //ShowCheckBox: Boolean;
Procedure showcheckBox(CheckboxIndex: Integer; Isrootnode:Boolean);
var
  fbShowCheckBox:Boolean;
begin
  if  ((CheckboxIndex in [cZeroWhenLessthan1index , cRoundtoNextNumberindex , cRoundtoPrevNumberindex,cIgnoreItemCommentsIndex] ) and  (Isrootnode)) or
      ((CheckboxIndex = cMakecoupnsIndex) or not(Isrootnode)) then begin
            fbShowCheckBox := False;
            TargetCanvas.FillRect(CellRect);
            DisplayRect := Sender.GetDisplayRect(Node, Column, False, True);
            DisplayRect.Top := DisplayRect.Top + cDisplayRectOffset;
            DisplayRect.Bottom := DisplayRect.Bottom - cDisplayRectOffset;
            MidPoint := ((DisplayRect.Right - DisplayRect.Left) div 2) + DisplayRect.Left;
            DisplayRect.Left := MidPoint - cHalfCheckBoxWidth;
            DisplayRect.Right := MidPoint + cHalfCheckBoxWidth;
            NodeData := Sender.GetNodeData(Node);
            NodeData.CheckBoxes[CheckBoxIndex].BoundsRect := DisplayRect;
            NodeData.CheckBoxes[CheckBoxIndex].Enabled := not TreeReadOnly;

            if CheckBoxIndex = cAddToSaleIndex then begin
              if (NodeData.Data.InputType = itOption) and (NodeData.Data.Children.Count > 0) and (TProcTreeNode(NodeData.Data.Children[0]).PartsID > 0) then fbShowCheckBox := True
              else if (NodeData.Data.PartsID > 0) and Assigned(Node.Parent) then begin
                ParentNodeData := Sender.GetNodeData(Node.Parent);

                if Assigned(ParentNodeData) and (ParentNodeData.Data.InputType <> itOption) then fbShowCheckBox := True;
              end;
            end else if (CheckBoxIndex = cHideOnPrintIndex) and (not NodeData.Data.AddToSale) then begin
              fbShowCheckBox := False;
            end else if (checkboxindex = cMakecoupnsIndex) then begin
              fbShowCheckBox := True;
            end else if (checkboxindex = cZeroWhenLessthan1Index) then begin
              fbShowCheckBox := True;
            end else if (checkboxindex = cRoundtoNextNumberIndex) then begin
              fbShowCheckBox := True;
            end else if (checkboxindex = cRoundtoPrevNumberIndex) then begin
              fbShowCheckBox := True;
            end else if (checkboxindex = cIgnoreItemCommentsIndex) then begin
              NodeData.CheckBoxes[CheckBoxIndex].Enabled := NodeData.CheckBoxes[CheckBoxIndex].Enabled and
                                    ( ((TreeMode =  tmTemplate) and Appenv.Companyprefs.UpdateProductDescriptionFromTreeInfo) or
                                      ((TreeMode <> tmTemplate) and Appenv.Companyprefs.UpdateSalesDescriptionFromTreeInfo  ));
              fbShowCheckBox := NodeData.CheckBoxes[CheckBoxIndex].Enabled;
            end else begin
              fbShowCheckBox := True;
            end;

            if fbShowCheckBox then NodeData.CheckBoxes[CheckBoxIndex].Show
            else NodeData.CheckBoxes[CheckBoxIndex].Hide;
  end;
end;
begin
  try
    NodeData := Sender.GetNodeData(Node);
{-->}if (Column = cPriceMatrix) then begin
      TargetCanvas.Font.Assign(vstProcessPart.Font);
      DrawText(TargetCanvas.Handle, PChar(cEllipsisText), -1, CellRect, DT_SINGLELINE or DT_VCENTER or DT_CENTER);
     end;
{-->}if (Column = cProcessStepsColumn) and (NodeData.Captions[Column] = '') and (not NodeData.Data.IsOptionItem) then begin
      TargetCanvas.Font.Assign(vstProcessPart.Font);
      DrawText(TargetCanvas.Handle, PChar(cEllipsisText), -1, CellRect, DT_SINGLELINE or DT_VCENTER or DT_CENTER);
     end;
{-->}if (Node <> vstProcessPart.RootNode.FirstChild) or (Column = cIgnoreItemCommentsIndex) then begin
{-->}  if Column = cDetailsColumn then begin

          if NodeData.Data.InputType = itCustom then begin
            TargetCanvas.Font.Assign(vstProcessPart.Font);
            DrawText(TargetCanvas.Handle, PChar(cEllipsisText), -1, CellRect, DT_SINGLELINE or DT_VCENTER or DT_CENTER);
          end;
{-->}  end else begin
          CheckBoxIndex := GetCheckBoxIndex(Column);

          if CheckBoxIndex >= 0 then begin
            showCheckBox(CheckBoxIndex , False);
          end;
       end;
    end;
    if (Column = cMakecoupons) then
      showcheckBox(cMakecoupnsIndex , Node = vstProcessPart.RootNode.FirstChild );
    if (Column = cIgnoreItemComments) then
      showcheckBox(cIgnoreItemCommentsIndex , Node = vstProcessPart.RootNode.FirstChild );

  except
    on E: Exception do begin
      LogD('TframeTree.vstProcessPartAfterCellPaint - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

function TframeTree.GetCheckBoxIndex(const Column: Integer): Integer;
var
  index: Integer;
begin
  try
    index := 0;

    while (index < cMaxCheckBoxes) and (cCheckBoxColumns[index] <> Column) do Inc(index);

    if index < cMaxCheckBoxes then Result := index
    else Result := -1;
  except
    on E: Exception do begin
      LogD('TframeTree.GetCheckBoxIndex - Exception: ' + E.Message);
      raise;
    end;
  end;
end;
Function TframeTree.ProductformulaEntry(Node: PVirtualNode;var NodeData: PNodeData):Boolean ;
var
  TreeProductSepc : TfmTreeProductSepc;
  fRootNodeData: PNodeData;
begin
  REsult := false;
  if not(NodeData.data is TProcTreeNode) then exit;
  if TProcTreeNode(NodeData.data).ProducthasformulaEntry = False then exit;
  TreeProductSepc := TfmTreeProductSepc.create(self);
  try
         if vstProcessPart.Header.Columns.ClickIndex = cQtyColumn then TreeProductSepc.FormulaQtytype := fqtTotal
    else if vstProcessPart.Header.Columns.ClickIndex = cStockQty   then TreeProductSepc.FormulaQtytype := fqtFromStock
    else if vstProcessPart.Header.Columns.ClickIndex = cbuildQty   then TreeProductSepc.FormulaQtytype := fqtBuild
    else if vstProcessPart.Header.Columns.ClickIndex = cOrderqty   then TreeProductSepc.FormulaQtytype := fqtOnOrder
    else if vstProcessPart.Header.Columns.ClickIndex = cPartNameColumn   then TreeProductSepc.FormulaQtytype := fqtTotal
    else TreeProductSepc.FormulaQtytype := fqtTotal;

    TreeProductSepc.NodeData := Nodedata;
    TreeProductSepc.Color := Self.Color;
    TreeProductSepc.IsTemplateTree := TreeMode =  tmTemplate;
    TreeProductSepc.Formstyle := fsStayontop;
    TreeProductSepc.onMultiSelectProduct := fbonMultiSelectProduct;
    if TreeProductSepc.Showmodal = mrok then begin
      NodeData.Captions[cQtyColumn] := floattoStrF(NodeData.data.Quantity , ffGeneral, 15,2);
      NodeData.Captions[cStockQty] := floattoStrF(NodeData.data.FromStockUOMQty , ffGeneral, 15,2);
      NodeData.Captions[cInfoColumn] := NodeData.data.Info;
      Try
        if Node = vstProcessPart.RootNode.FirstChild.FirstChild then begin
          fRootNodeData := vstProcessPart.GetNodeData(vstProcessPart.RootNode.FirstChild);
          fRootNodeData.Captions[cInfoColumn] :=NodeData.Captions[cInfoColumn];
          fRootNodeData.Data.info :=NodeData.Captions[cInfoColumn];
        end;
      Except
        // kill the exception
      End;
      Result := TRue;
    end;

  finally
    freeandNil(TreeProductSepc);
  end;
end;
procedure TframeTree.initFormulaQtysfromFirstnode(NodeData: PNodeData);
begin
  if not Assigned(RootNodeData) then exit;
  if RootNodeData = Nodedata.data then exit;
  initFormulaQtysfromFirstnodeCallback(RootNodeData, NodeData);

end;
Function TframeTree.initFormulaQtysfromFirstnodeCallback(ParentNodeData: TProcTreeNode; NodeData: PNodeData ):Boolean;
var
  index :Integer;
  ChildNode: TProcTreeNode;
  initFormuladone :boolean;
begin
  REsult := False;
  initFormuladone := False;
  if Parentnodedata = NodeData.Data then exit;

  for index := 0 to ParentNodeData.Children.Count - 1 do begin
      if initFormuladone  then exit;
      ChildNode := TProcTreeNode(ParentNodeData.Children[index]);
               if ChildNode.children.count >0 then begin initFormuladone := initFormulaQtysfromFirstnodeCallback(ChildNode, NodeData);
               if initFormuladone then exit;
      end else if NodeData.Data = childNode   then begin Result := True; Exit;
      end else if (ChildNode.PartsId <> 0) and (ChildNode.ProductHasformula) then begin
          NodeData.Data.FormulaQtyValue1 :=ChildNode.FormulaQtyValue1;
          NodeData.Data.FormulaQtyValue2 :=ChildNode.FormulaQtyValue2;
          NodeData.Data.FormulaQtyValue3 :=ChildNode.FormulaQtyValue3;
          NodeData.Data.FormulaQtyValue4 :=ChildNode.FormulaQtyValue4;
          NodeData.Data.FormulaQtyValue5 :=ChildNode.FormulaQtyValue5;
          NodeData.Data.FormulaQtyValue  :=ChildNode.FormulaQtyValue;
          Nodedata.Data.Quantity:=ChildNode.Quantity;
          Nodedata.Data.TotalQty:=ChildNode.TotalQty;
          REsult := true;
          Exit;
      end;
  end;
end;

procedure TframeTree.HandleDblClick(Sender: TObject);
var
  Node: PVirtualNode;
  NodeData: PNodeData;
  PartID: Integer;
  PartName: string;
  PartDescription: string;
  form: TBaseInputGUI;
  //fbenabled: Boolean;
begin
  // LogD('TframeTree.HandleDblClick',lbBegin);
  //fbenabled := self.Enabled;

    try
      Node := FCurrentNode;

      if (( (Sender is TMaskEdit) or (Sender is TVirtualStringTree)) and (Node <> vstProcessPart.RootNode.FirstChild) and
              ((vstProcessPart.Header.Columns.ClickIndex = cPartNameColumn) or
               (vstProcessPart.Header.Columns.ClickIndex = cInfoColumn) or
               (vstProcessPart.Header.Columns.ClickIndex = cqtyColumn) or
                (vstProcessPart.Header.Columns.ClickIndex = cStockQty) or
                ((vstProcessPart.Header.Columns.ClickIndex = cbuildQty) and (Node.ChildCount>0) )  )) then begin

        NodeData := vstProcessPart.GetNodeData(Node);
        if (vstProcessPart.Header.Columns.ClickIndex = cInfoColumn) then begin
          dlgInfo.Lines.Text := NodeData.Data.Info;
          if dlgInfo.Execute then begin
            NodeData.Data.Info := dlgInfo.Lines.Text;
            if (Sender is TMaskEdit) then TMaskEdit(Sender).Text := NodeData.Data.Info;
            NodeData.Captions[cInfoColumn] := NodeData.Data.Info;
          end;
          exit;
        end;

        if TreeReadOnly then exit;

        if ((TreeMode =  tmTemplate) and (vstProcessPart.Header.Columns.ClickIndex = cQtyColumn)) or
           ((TreeMode <> tmTemplate) and ((vstProcessPart.Header.Columns.ClickIndex = cStockQty ) or
           ((vstProcessPart.Header.Columns.ClickIndex = cbuildQty) and (Node.ChildCount>0) ) ) ) then begin
          if (NodeData.data.partsId <> 0)  then
              if ProductformulaEntry(Node, NodeData ) then begin

                  if sender is TMaskEdit then
                       if (vstProcessPart.Header.Columns.ClickIndex  = cQtyColumn) then TMaskEdit(Sender).Text := NodeData.Captions[cQtyColumn]
                  else if (vstProcessPart.Header.Columns.ClickIndex  = cStockQty)  then TMaskEdit(Sender).Text := NodeData.Captions[cStockQty]
                  else if (vstProcessPart.Header.Columns.ClickIndex  = cbuildQty)  then TMaskEdit(Sender).Text := NodeData.Captions[cbuildQty];
//                ChangeNode :=True;
              end else begin
                MessageDlgXP_vista('Product ' + Quotedstr(NodeData.data.Caption)+' Doesn''t have any Formula', mtInformation, [mbOK], 0);
              end;
          Exit;
        end;

        if GetUserSelectProduct(PartID, PartName, PartDescription) then begin

            OnSelectProduct(fVTEditControl , Sender, PartId, Partname, PartDescription, nodedata , node);
        end;

      end
      else begin
        { all other colums }
        NodeData := vstProcessPart.GetNodeData(Node);
        if NodeData = nil then exit;
        if NodeData.Data.PartsId > 0 then begin

          form := TBaseInputGUI(CommonLib.GetComponentByClassName('TfrmParts',false));
          if Assigned(form) then begin
            try
              form.KeyID := NodeData.Data.PartsId;
              form.ShowModal;
            finally
              form.Free;
            end;
          end;

        end;
      end;
      HideException := True;
    except
      on E: Exception do begin
        LogD('TframeTree.HandleDblClick - Exception: ' + E.Message);
        raise;
      end;
    end;

end;
procedure TframeTree.showInmsgform(const Msgcaption , MsgText , Msg1 , Msg2 , fieldnames,displaywidths :String);
begin
    InitMsgParams;
    PopupMsgParams.Msgcaption := Msgcaption;
    PopupMsgParams.MsgTExtForGridDelim := NL;
    PopupMsgParams.MsgTExtForGrid :=  MsgText;
    PopupMsgParams.displayLabels:= fieldnames;
    PopupMsgParams.displayWidths:= displaywidths;
    PopupMsgParams.Custombuttons :='"Cancel"' ;
    PopupMsgParams.Msg1:=Msg1;
    PopupMsgParams.Msg2 := Msg2;
    PopupMsgParams.MsgColor := Self.Color;
    TfmMessageWithList.MsgDlg;
end;

procedure TframeTree.lblcostIncLabourDblClick(Sender: TObject);
begin
  showInmsgform('Cost with Labour Details',
                Trim(RootNodeData.CostIncLabourDetails),
                'Cost with Labour Details',
                lblcostIncLabour.caption ,
                Quotedstr('Caption')+','+Quotedstr('UOM')+','+Quotedstr('Total Qty')+','+Quotedstr('Total Cost')+','+Quotedstr('Labour')+','+Quotedstr('Cost With Labour'),
                ',,,,,120');
end;

procedure TframeTree.lblTotalCostDblClick(Sender: TObject);
begin
  showInmsgform('Cost Details',
                Trim(RootNodeData.CostDetails),
                'Cost Details',
                lblTotalCost.caption ,
                Quotedstr('Caption')+','+Quotedstr('UOM')+','+Quotedstr('Total Qty')+','+Quotedstr('Total Cost'),
                '');
end;

procedure TframeTree.lblTotalPriceDblClick(Sender: TObject);
begin
  showInmsgform('Price Details',
                Trim(RootNodeData.PriceDetails),
                'Price Details',
                lblTotalPrice.caption ,
                Quotedstr('Caption')+','+Quotedstr('UOM')+','+Quotedstr('Total Qty')+','+Quotedstr('Total Price')+','+Quotedstr('Labour')+','+Quotedstr('Price With Labour'),
                ',,,,,120');
end;

procedure TframeTree.lblTotalQtyDblClick(Sender: TObject);
begin
  showInmsgform('Total Quantity Details',
                Trim(RootNodeData.TotalQtyDetails),
                'Total Quantity Details',
                lblTotalQty.caption ,
                Quotedstr('Caption')+','+Quotedstr('Quantity'),
                '');
end;

procedure TframeTree.HandleCheckBoxClick(Sender: TObject);
var
  Node: PVirtualNode;
  NodeData: PNodeData;
begin
  try
    if (Sender is TCheckBox) and (not FAppSettingCheckBox) then begin
      Node := Ptr(TCheckBox(Sender).Tag);
      NodeData := vstProcessPart.GetNodeData(Node);
      vstProcessPart.EndEditNode;

      if Assigned(NodeData) then begin
        if Sender = NodeData.CheckBoxes[cAddToSaleIndex] then begin
          if ProcTreeHasProcesses(NodeData.Data) and TCheckBox(Sender).Checked then begin
            CommonLib.MessageDlgXP_Vista('A manufactured item with process steps ' + 'can not use the "show on sale" option.', mtInformation, [mbOk], 0);
            TCheckBox(Sender).Checked := False;
          end;
          NodeData.Data.AddToSale := TCheckBox(Sender).Checked;
          if NodeData.Data.AddToSale then NodeData.CheckBoxes[cHideOnPrintIndex].Show
          else NodeData.CheckBoxes[cHideOnPrintIndex].Hide;
        end else if Sender = NodeData.CheckBoxes[cHideOnPrintIndex] then begin
          NodeData.Data.HideOnPrint := TCheckBox(Sender).Checked;
        end else if Sender = NodeData.CheckBoxes[cMakecoupnsIndex] then begin
          NodeData.Data.MakeCoupons := TCheckBox(Sender).Checked;
        end else if Sender = NodeData.CheckBoxes[cZeroWhenLessthan1index] then begin
          NodeData.Data.ZeroWhenLessthan1 := TCheckBox(Sender).Checked;
        end else if Sender = NodeData.CheckBoxes[cRoundtoNextNumberindex] then begin
          NodeData.Data.RoundtoNextNumber := TCheckBox(Sender).Checked;
        end else if Sender = NodeData.CheckBoxes[cRoundtoPrevNumberindex] then begin
          NodeData.Data.RoundtoPrevNumber := TCheckBox(Sender).Checked;
        end else if Sender = NodeData.CheckBoxes[cIgnoreItemCommentsIndex] then begin
          NodeData.Data.IgnoreItemCommentsforDescription := TCheckBox(Sender).Checked;
        end;
      end;
    end;
  except
    on E: Exception do begin
      LogD('TframeTree.HandleCheckBoxClick - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TframeTree.ShowPartsPriceMatrix(NodeData: PNodeData);
var
  entrynValueRef: string;
  entrynValue: string;
  fdprice: double;
begin
  if NodeData.Data.IsRoot then exit;

  if NodeData.Data.PartsID = 0 then begin
    MessageDlgXP_Vista('Price Matrix is only for Product Items.', mtInformation, [mbOk], 0);
    exit;
  end;
  if not ParthasPriceMatrix(NodeData.Data.PartsID) then begin
    MessageDlgXP_Vista('Price Matrix is not Defined for this Product.', mtInformation, [mbOk], 0);
    exit;
  end;

  entrynValueRef := NodeData.Data.MatrixRef;
  if NodeData.Data.MatrixDesc <> '' then entrynValue := NodeData.Data.Description;
  TfmpartsPriceMatrixInput.PriceMAtrix(self, entrynValueRef, entrynValue, fdprice, NodeData.Data.PartsID, fTransConnection);
  // NodeData.Captions[cPriceMatrix]:= entrynValueRef;
  NodeData.Captions[cPartDescColumn] := entrynValue;
  // NodeData.Data.Price := fdPrice;
  NodeData.Data.MatrixDesc := entrynValue;
  NodeData.Data.MatrixRef := entrynValueRef;
  NodeData.Data.Description := entrynValue;
  NodeData.Data.matrixprice := fdprice;
  CalcPrice(TProcTreeNode(NodeData.Data.RootNode));
end;

procedure TframeTree.HandleButtonClick(Sender: TObject);
var
  Form: TfmProcTreeProcessStepEdit;
  Node: PVirtualNode;
  NodeData: PNodeData;
begin
  try
    if Sender is TDNMSpeedButton then begin
      Node := PVirtualNode(TDNMSpeedButton(Sender).Tag);
      NodeData := vstProcessPart.GetNodeData(Node);

      if Assigned(NodeData) then begin
        if FVTEditControl.FColumn = cProcessStepsColumn then begin
          if (NodeData.Data.PartsID>0) and (nodedata.data.parentID<>0) then begin
            (*MessageDlgXP_Vista('This is a product node, cannot have process steps with it. Please create a subnode to add the product in it and process step on the subnode', mtWarning, [mbOK], 0);
            exit;*)
          end;
          Form := TfmProcTreeProcessStepEdit(GetComponentByClassName('TfmProcTreeProcessStepEdit'));

          if Assigned(Form) then begin
            Form.TransConnection := NodeData.Data.Storer.Connection;
            Form.ProcessTreeNode := NodeData.Data;
            Form.lblSteps.Caption := NodeData.Captions[cPartNameColumn] + ' ' + Form.lblSteps.Caption;
            SendMessage(Form.Handle, TX_PerformStartup, 0, 0);

            if Form.ShowModal = mrOK then begin
              CheckForLinkedSubs(NodeData.Data);

              NodeData.Captions[cProcessStepsColumn] := NodeData.Data.ProcessStepDescList;
              NodeData.Captions[cProcessStepExtraInfo] := NodeData.Data.ProcessStepExtraInfoList;

              if ProcTreeHasProcesses(TProcTreeNode(NodeData.Data.RootNode)) then begin
                if TreeHasAddToSaleNodes(TProcTreeNode(NodeData.Data.RootNode)) then begin
                  CommonLib.MessageDlgXP_Vista('A manufactured item with process steps ' + 'can not use the "show on sale" option, this will be removed.', mtInformation, [mbOk], 0);
                  ClearAllAddToSale(TProcTreeNode(NodeData.Data.RootNode));
                end;
              end else begin
              end;
              CalcPrice(TProcTreeNode(NodeData.Data.RootNode));
              vstProcessPart.Refresh;
            end;

            Form.Release;
          end;
        end
        else if FVTEditControl.FColumn = cPriceMatrix then begin
          ShowPartsPriceMatrix(NodeData);
        end
        else if FVTEditControl.FColumn = cDetailsColumn then begin
          if NodeData.Data.CustomInputClass = '' then CommonLib.MessageDlgXP_Vista('You Must Choose Custom Input.', mtInformation, [mbOk], 0)
          else ShowPopupForm(NodeData.Data.CustomInputClass, NodeData.Data);
        end;
      end;
    end;
  except
    on E: Exception do begin
      LogD('TframeTree.HandleButtonClick - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TframeTree.SaveTree;
var
  Node: PVirtualNode;
  NodeData: PNodeData;
begin
  try
    Node := vstProcessPart.RootNode.FirstChild;
    NodeData := vstProcessPart.GetNodeData(Node);
    NodeData.Data.Save;
    NodeData.Data.Logit(True);
  except
    on E: Exception do begin
      LogD('TframeTree.SaveTree - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TframeTree.SetTreeMode(const Value: TTreeMode);
begin
  try
    FTreeMode := Value;
    DisplayForMode;
  except
    on E: Exception do begin
      LogD('TframeTree.SetTreeMode - Exception: ' + E.Message);
      raise;
    end;
  end;
end;


Procedure TframeTree.showFormulacolumns(const ForTemplate :Boolean; isSalesOrder:Boolean);
begin


  with vstProcessPart.Header do begin
      {Dene : Formula Qty fields are not visible for Build qty and Order Qty in all modes. ie: Product card, SAles order , Quote, Invoice}
      Columns[cFormulaQty].Options  := Columns[cFormulaQty].Options - [coVisible] ;
      Columns[cbFormulaQty].Options  := Columns[cbFormulaQty].Options - [coVisible];
      Columns[cbFormulaQty1].Options := Columns[cbFormulaQty1].Options- [coVisible];
      Columns[cbFormulaQty2].Options := Columns[cbFormulaQty2].Options - [coVisible];
      Columns[cbFormulaQty3].Options := Columns[cbFormulaQty3].Options - [coVisible];
      Columns[cbFormulaQty4].Options := Columns[cbFormulaQty4].Options - [coVisible];
      Columns[cbFormulaQty5].Options := Columns[cbFormulaQty5].Options - [coVisible];


      Columns[coFormulaQty].Options  := Columns[coFormulaQty].Options  - [coVisible];
      Columns[coFormulaQty1].Options := Columns[coFormulaQty1].Options - [coVisible];
      Columns[coFormulaQty2].Options := Columns[coFormulaQty2].Options - [coVisible];
      Columns[coFormulaQty3].Options := Columns[coFormulaQty3].Options - [coVisible];
      Columns[coFormulaQty4].Options := Columns[coFormulaQty4].Options - [coVisible];
      Columns[coFormulaQty5].Options := Columns[coFormulaQty5].Options - [coVisible];
      Columns[cMakeCoupons].Options  := Columns[cMakeCoupons].Options - [coVisible];

    vstProcessPart.Header.Height := 70;
    if ForTemplate then begin
        Columns[cFormulaQty1].Options := Columns[cFormulaQty1].Options - [coVisible];
        Columns[cFormulaQty2].Options := Columns[cFormulaQty2].Options - [coVisible];
        Columns[cFormulaQty3].Options := Columns[cFormulaQty3].Options - [coVisible];
        Columns[cFormulaQty4].Options := Columns[cFormulaQty4].Options - [coVisible];
        Columns[cFormulaQty5].Options := Columns[cFormulaQty5].Options - [coVisible];

      if Appenv.Companyprefs.FeFieldVisible and (chkHideFormulacolumns.Checked = False) then begin
        if Appenv.CompanyPrefs.Fe1Visible  then Columns[cFormulaQty1].Options  := Columns[cFormulaQty1].Options + [coVisible] else Columns[cFormulaQty1].Options  := Columns[cFormulaQty1].Options - [coVisible];
        if Appenv.CompanyPrefs.Fe2Visible  then Columns[cFormulaQty2].Options  := Columns[cFormulaQty2].Options + [coVisible] else Columns[cFormulaQty2].Options  := Columns[cFormulaQty2].Options - [coVisible];
        if Appenv.CompanyPrefs.Fe3Visible  then Columns[cFormulaQty3].Options  := Columns[cFormulaQty3].Options + [coVisible] else Columns[cFormulaQty3].Options  := Columns[cFormulaQty3].Options - [coVisible];
        if Appenv.CompanyPrefs.Fe4Visible  then Columns[cFormulaQty4].Options  := Columns[cFormulaQty4].Options + [coVisible] else Columns[cFormulaQty4].Options  := Columns[cFormulaQty4].Options - [coVisible];
        if Appenv.CompanyPrefs.Fe5Visible  then Columns[cFormulaQty5].Options  := Columns[cFormulaQty5].Options + [coVisible] else Columns[cFormulaQty5].Options  := Columns[cFormulaQty5].Options - [coVisible];
      end else begin
        Columns[cFormulaQty1].Options := Columns[cFormulaQty1].Options - [coVisible];
        Columns[cFormulaQty2].Options := Columns[cFormulaQty2].Options - [coVisible];
        Columns[cFormulaQty3].Options := Columns[cFormulaQty3].Options - [coVisible];
        Columns[cFormulaQty4].Options := Columns[cFormulaQty4].Options - [coVisible];
        Columns[cFormulaQty5].Options := Columns[cFormulaQty5].Options - [coVisible];
      end;
    end else if issalesorder then begin
      if Appenv.Companyprefs.FeFieldVisible and (chkHideFormulacolumns.Checked =False)  then begin
        if Appenv.CompanyPrefs.Fe1Visible  then Columns[cFormulaQty1].Options := Columns[cFormulaQty1].Options + [coVisible] else  Columns[cFormulaQty1].Options := Columns[cFormulaQty1].Options - [coVisible];
        if Appenv.CompanyPrefs.Fe2Visible  then Columns[cFormulaQty2].Options := Columns[cFormulaQty2].Options + [coVisible] else  Columns[cFormulaQty2].Options := Columns[cFormulaQty2].Options - [coVisible];
        if Appenv.CompanyPrefs.Fe3Visible  then Columns[cFormulaQty3].Options := Columns[cFormulaQty3].Options + [coVisible] else  Columns[cFormulaQty3].Options := Columns[cFormulaQty3].Options - [coVisible];
        if Appenv.CompanyPrefs.Fe4Visible  then Columns[cFormulaQty4].Options := Columns[cFormulaQty4].Options + [coVisible] else  Columns[cFormulaQty4].Options := Columns[cFormulaQty4].Options - [coVisible];
        if Appenv.CompanyPrefs.Fe5Visible  then Columns[cFormulaQty5].Options := Columns[cFormulaQty5].Options + [coVisible] else  Columns[cFormulaQty5].Options := Columns[cFormulaQty5].Options - [coVisible];
      end else begin
        Columns[cFormulaQty1].Options := Columns[cFormulaQty1].Options - [coVisible];
        Columns[cFormulaQty2].Options := Columns[cFormulaQty2].Options - [coVisible];
        Columns[cFormulaQty3].Options := Columns[cFormulaQty3].Options - [coVisible];
        Columns[cFormulaQty4].Options := Columns[cFormulaQty4].Options - [coVisible];
        Columns[cFormulaQty5].Options := Columns[cFormulaQty5].Options - [coVisible];
      end;
      Columns[cMakeCoupons].Options  := Columns[cMakeCoupons].Options + [coVisible];
    end else begin
    {quote and invoice should not have the fromstock/tobuild/to order quantities}
      Columns[cFormulaQty].Options  := Columns[cFormulaQty].Options  - [coVisible];
      Columns[cFormulaQty1].Options := Columns[cFormulaQty1].Options - [coVisible];
      Columns[cFormulaQty2].Options := Columns[cFormulaQty2].Options - [coVisible];
      Columns[cFormulaQty3].Options := Columns[cFormulaQty3].Options - [coVisible];
      Columns[cFormulaQty4].Options := Columns[cFormulaQty4].Options - [coVisible];
      Columns[cFormulaQty5].Options := Columns[cFormulaQty5].Options - [coVisible];
    end;
  end;

  if Appenv.Companyprefs.FeFieldVisible then begin
     with vstProcessPart.Header do begin
      if ForTemplate then begin
        Columns[cQtyColumn].Color   :=  AppEnv.companyPrefs.QtySoldcolour;
        Columns[cFormulaQty].Color  :=  AppEnv.companyPrefs.QtySoldcolour;
        Columns[cFormulaQty1].Color :=  AppEnv.companyPrefs.QtySoldcolour;
        Columns[cFormulaQty2].Color :=  AppEnv.companyPrefs.QtySoldcolour;
        Columns[cFormulaQty3].Color :=  AppEnv.companyPrefs.QtySoldcolour;
        Columns[cFormulaQty4].Color :=  AppEnv.companyPrefs.QtySoldcolour;
        Columns[cFormulaQty5].Color :=  AppEnv.companyPrefs.QtySoldcolour;
      end else begin
        Columns[cstockqty].Color    :=  AppEnv.companyPrefs.QtySoldcolour;
        Columns[cFormulaQty].Color  :=  AppEnv.companyPrefs.QtySoldcolour;
        Columns[cFormulaQty1].Color :=  AppEnv.companyPrefs.QtySoldcolour;
        Columns[cFormulaQty2].Color :=  AppEnv.companyPrefs.QtySoldcolour;
        Columns[cFormulaQty3].Color :=  AppEnv.companyPrefs.QtySoldcolour;
        Columns[cFormulaQty4].Color :=  AppEnv.companyPrefs.QtySoldcolour;
        Columns[cFormulaQty5].Color :=  AppEnv.companyPrefs.QtySoldcolour;


        Columns[cbuildQty].Color  :=  AppEnv.companyPrefs.QtySoldcolour;
        Columns[cbFormulaQty].Color  :=  AppEnv.companyPrefs.QtySoldcolour;
        Columns[cbFormulaQty1].Color :=  AppEnv.companyPrefs.QtySoldcolour;
        Columns[cbFormulaQty2].Color :=  AppEnv.companyPrefs.QtySoldcolour;
        Columns[cbFormulaQty3].Color :=  AppEnv.companyPrefs.QtySoldcolour;
        Columns[cbFormulaQty4].Color :=  AppEnv.companyPrefs.QtySoldcolour;
        Columns[cbFormulaQty5].Color :=  AppEnv.companyPrefs.QtySoldcolour;

        Columns[cOrderqty].Color     :=  AppEnv.companyPrefs.QtyShippedColour;
        Columns[coFormulaQty].Color  :=  AppEnv.companyPrefs.QtyShippedColour;
        Columns[coFormulaQty1].Color :=  AppEnv.companyPrefs.QtyShippedColour;
        Columns[coFormulaQty2].Color :=  AppEnv.companyPrefs.QtyShippedColour;
        Columns[coFormulaQty3].Color :=  AppEnv.companyPrefs.QtyShippedColour;
        Columns[coFormulaQty4].Color :=  AppEnv.companyPrefs.QtyShippedColour;
        Columns[coFormulaQty5].Color :=  AppEnv.companyPrefs.QtyShippedColour;
      end;
     end;
  end;

end;

procedure TframeTree.DisplayForMode;
var
  Visible: Boolean;
  NodeList: TList;
begin
  try
    //chkHideFormulacolumns.Visible := False;
    vstProcessPart.BeginUpdate;
    NodeList := TList.Create;

    try
      GetExpandedList(vstProcessPart.RootNode, NodeList);
      vstProcessPart.EndEditNode;

      //
      // A full collapse is done before switching modes due to a bug in
      // TVirtualStringTree.
      //
      vstProcessPart.FullCollapse(vstProcessPart.RootNode.FirstChild);

      if FTreeMode = tmTemplate then begin
        if FProcessTreeID > 0 then begin
          DisplayCheckBoxes(vstProcessPart.RootNode, True, True);
          DisplayRequiredNodes(vstProcessPart.RootNode, Visible);
        end;
        with vstProcessPart.Header do begin
        if ( ((TreeMode =  tmTemplate) and Appenv.Companyprefs.UpdateProductDescriptionFromTreeInfo) or
             ((TreeMode <> tmTemplate) and Appenv.Companyprefs.UpdateSalesDescriptionFromTreeInfo  )) then
          //if TreeMode =  tmTemplate then
               Columns[cIgnoreItemComments].Options            := Columns[cOrderQty].Options + [coVisible]
          else Columns[cIgnoreItemComments].Options            := Columns[cOrderQty].Options - [coVisible];

          chkHideQtyPercolumnClick(chkHideQtyPercolumn);
          Columns[cInputTypeColumn].Options     := Columns[cInputTypeColumn].Options + [coVisible];
          Columns[cCustomInputColumn].Options   := Columns[cCustomInputColumn].Options + [coVisible];
          Columns[cAvgCostColumn].Options       := Columns[cAvgCostColumn].Options + [coVisible];
          Columns[cCostColumn].Options          := Columns[cCostColumn].Options + [coVisible];
          Columns[cPriceColumn].Options         := Columns[cPriceColumn].Options + [coVisible];
          Columns[cUnitPriceColumn].Options     := Columns[cUnitPriceColumn].Options + [coVisible];
          Columns[cUOM].Options                 := Columns[cUOM].Options + [coVisible];
          Columns[cLabourPriceColumn].Options   := Columns[cLabourPriceColumn].Options + [coVisible];
          Columns[cAddToSaleColumn].Options     := Columns[cAddToSaleColumn].Options + [coVisible];
          Columns[cHideOnPrintColumn].Options   := Columns[cHideOnPrintColumn].Options + [coVisible];
          Columns[cProcessStepsColumn].Options  := Columns[cProcessStepsColumn].Options + [coVisible];
          Columns[cProcessStepExtraInfo].Options := Columns[cProcessStepExtraInfo].Options + [coVisible];
          // Columns[cPriceMatrix].Options      := Columns[cPriceMatrix].Options + [coVisible];
          Columns[cDetailsColumn].Options       := Columns[cDetailsColumn].Options + [coVisible];
          Columns[cSourceColumn].Options        := Columns[cSourceColumn].Options - [coVisible];
          Columns[cStockQty].Options            := Columns[cStockQty].Options - [coVisible];
          Columns[cbuildQty].Options            := Columns[cbuildQty].Options - [coVisible];
          Columns[cOrderQty].Options            := Columns[cOrderQty].Options - [coVisible];
          Columns[cSubBOMProcessOrder].Options  := Columns[cSubBOMProcessOrder].Options + [coVisible];
          showFormulacolumns(True, False);
        end;
      end else begin
        if FProcessTreeID > 0 then begin
          DisplayCheckBoxes(vstProcessPart.RootNode, True, False);
          DisplayRequiredNodes(vstProcessPart.RootNode, Visible);
        end;
        with vstProcessPart.Header do begin
          Columns[cQtyPercolumn].Options        := Columns[cQtyPercolumn].Options - [coVisible];
          Columns[cInputTypeColumn].Options     := Columns[cInputTypeColumn].Options + [coVisible];
          Columns[cOptionColumn].Options        := Columns[cOptionColumn].Options + [coVisible];
          Columns[cCustomInputColumn].Options   := Columns[cCustomInputColumn].Options - [coVisible];
          Columns[cAvgCostColumn].Options       := Columns[cAvgCostColumn].Options - [coVisible];
          if not devmode then Columns[cCostColumn].Options          := Columns[cCostColumn].Options - [coVisible] else Columns[cCostColumn].Options          := Columns[cCostColumn].Options + [coVisible];
          Columns[cPriceColumn].Options         := Columns[cPriceColumn].Options + [coVisible];
          Columns[cUnitPriceColumn].Options     := Columns[cUnitPriceColumn].Options + [coVisible];
          Columns[cUOM].Options                 := Columns[cUOM].Options + [coVisible];
          Columns[cLabourPriceColumn].Options   := Columns[cLabourPriceColumn].Options + [coVisible];
          Columns[cAddToSaleColumn].Options     := Columns[cAddToSaleColumn].Options - [coVisible];
          Columns[cHideOnPrintColumn].Options   := Columns[cHideOnPrintColumn].Options - [coVisible];
          Columns[cProcessStepsColumn].Options  := Columns[cProcessStepsColumn].Options + [coVisible];
          Columns[cProcessStepExtraInfo].Options := Columns[cProcessStepExtraInfo].Options + [coVisible];
          // Columns[cPriceMatrix].Options      := Columns[cPriceMatrix].Options - [coVisible];
          Columns[cDetailsColumn].Options       := Columns[cDetailsColumn].Options + [coVisible];
          Columns[cSourceColumn].Options        := Columns[cSourceColumn].Options - [coVisible];
          if Assigned(TreeNodeRoot) and (TreeNodeRoot.MasterType = mtSalesOrder) then begin
            Columns[cStockQty].Options := Columns[cStockQty].Options + [coVisible];
            Columns[cbuildQty].Options := Columns[cbuildQty].Options + [coVisible];
            Columns[cOrderQty].Options := Columns[cOrderQty].Options + [coVisible];
            showFormulacolumns(False, True);
          end else begin
            Columns[cStockQty].Options := Columns[cStockQty].Options - [coVisible];
            Columns[cbuildQty].Options := Columns[cbuildQty].Options - [coVisible];
            Columns[cOrderQty].Options := Columns[cOrderQty].Options - [coVisible];
            showFormulacolumns(False, False);
          end;
          Columns[cSubBOMProcessOrder].Options  := Columns[cSubBOMProcessOrder].Options + [coVisible];
        end;
      end;
      Setcolumnwidths;
      if Appenv.Companyprefs.FeFieldVisible then
        chkHideFormulacolumnsClick(chkHideFormulacolumns);
      if FProcessTreeID > 0 then ExpandList(NodeList);
    finally
      vstProcessPart.EndUpdate;
      FreeandNil(NodeList);
    end;
  except
    on E: Exception do begin
      LogD('TframeTree.DisplayForMode - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TframeTree.Setcolumnwidths;
begin
with vstProcessPart.Header do begin

  Columns[cPartNameColumn].Width      :=160;//100;
  Columns[cQtyPercolumn].Width        :=45;
  Columns[cPartDescColumn].Width      :=125;

  Columns[cFormulaQty].Width          :=50;//70;
  Columns[cFormulaQty1].Width         :=50;//70;
  Columns[cFormulaQty2].Width         :=50;//70;
  Columns[cFormulaQty3].Width         :=50;//70;
  Columns[cFormulaQty4].Width         :=50;//70;
  Columns[cFormulaQty5].Width         :=50;//70;

  Columns[cQtyColumn].Width           :=40;
  Columns[cStockQty].Width            :=50;//80;
  Columns[cbFormulaQty].Width         :=50;//70;
  Columns[cbFormulaQty1].Width        :=50;//70;
  Columns[cbFormulaQty2].Width        :=50;//70;
  Columns[cbFormulaQty3].Width        :=50;//70;
  Columns[cbFormulaQty4].Width        :=50;//70;
  Columns[cbFormulaQty5].Width        :=50;//70;
  Columns[cbuildQty].Width            :=50;//80;
  Columns[coFormulaQty].Width         :=50;//70;
  Columns[coFormulaQty1].Width        :=50;//70;
  Columns[coFormulaQty2].Width        :=50;//70;
  Columns[coFormulaQty3].Width        :=50;//70;
  Columns[coFormulaQty4].Width        :=50;//70;
  Columns[coFormulaQty5].Width        :=50;//70;
  Columns[cOrderqty].Width            :=50;//80;
  Columns[cUOM].Width                 :=80;
  Columns[cOptionColumn].Width        :=100;
  Columns[cAvgCostColumn].Width       :=65;
  Columns[cCostColumn].Width          :=65;
  Columns[cLabourPriceColumn].Width   :=65;
  Columns[cUnitPriceColumn].Width     :=65;
  Columns[cPriceColumn].Width         :=65;
  Columns[cProcessStepsColumn].Width  :=100;
  Columns[cProcessStepExtraInfo].Width :=100;
  Columns[cInputTypeColumn].Width     :=50;
  Columns[cInfoColumn].Width          :=140;
  Columns[cPriceMatrix].Width         :=80;
  Columns[cAddToSaleColumn].Width     :=70;
  Columns[cHideOnPrintColumn].Width   :=70;
  Columns[cUOMQty].Width              :=70;
  Columns[cTotalQtyColumn].Width      :=70;
  Columns[cSourceColumn].Width        :=100;
  Columns[cDetailsColumn].Width       :=70;
  Columns[cCustomInputColumn].Width   :=100;
  Columns[cQtyPerCoupon].Width        :=100;
  Columns[cRAtePercoupon].Width       :=100;
  Columns[cMakeCoupons].Width         :=100;
  Columns[cZeroWhenLessthan1].Width   :=50;
  Columns[cRoundtoNextNumber].Width   :=50;
  Columns[cRoundtoPrevNumber].Width   :=50;
  Columns[cIgnoreItemComments].Width   :=100;
  Columns[cSubBOMProcessOrder].Width   :=250;

  Columns[cHalfCheckBoxWidth].Alignment := taCenter;
  Columns[cAddToSaleIndex].Alignment    := taCenter;
  Columns[cHideOnPrintIndex].Alignment  := taCenter;
  Columns[cZeroWhenLessthan1index].Alignment := taCenter;
  Columns[cRoundtoNextNumberindex].Alignment := taCenter;
  Columns[cRoundtoPrevNumberindex].Alignment := taCenter;
  Columns[cIgnoreItemCommentsIndex].Alignment := taCenter;
  //Columns[cMaxCheckBoxes].Alignment     := taCenter;
  Columns[cDisplayRectOffset].Alignment := taCenter;
  Columns[cPartNameColumn].Alignment    := taLeftJustify;
  Columns[cQtyPercolumn].Alignment      := taRightJustify;
  Columns[cPartDescColumn].Alignment    := taLeftJustify;
  Columns[cFormulaQty].Alignment        := taRightJustify;
  Columns[cFormulaQty1].Alignment       := taRightJustify;
  Columns[cFormulaQty2].Alignment       := taRightJustify;
  Columns[cFormulaQty3].Alignment       := taRightJustify;
  Columns[cFormulaQty4].Alignment       := taRightJustify;
  Columns[cFormulaQty5].Alignment       := taRightJustify;
  Columns[cQtyColumn].Alignment         := taRightJustify;
  Columns[cStockQty].Alignment          := taRightJustify;
  Columns[cbFormulaQty].Alignment       := taRightJustify;
  Columns[cbFormulaQty1].Alignment      := taRightJustify;
  Columns[cbFormulaQty2].Alignment      := taRightJustify;
  Columns[cbFormulaQty3].Alignment      := taRightJustify;
  Columns[cbFormulaQty4].Alignment      := taRightJustify;
  Columns[cbFormulaQty5].Alignment      := taRightJustify;
  Columns[cbuildQty].Alignment          := taRightJustify;
  Columns[coFormulaQty].Alignment       := taRightJustify;
  Columns[coFormulaQty1].Alignment      := taRightJustify;
  Columns[coFormulaQty2].Alignment      := taRightJustify;
  Columns[coFormulaQty3].Alignment      := taRightJustify;
  Columns[coFormulaQty4].Alignment      := taRightJustify;
  Columns[coFormulaQty5].Alignment      := taRightJustify;
  Columns[cOrderqty].Alignment          := taRightJustify;
  Columns[cUOM].Alignment               := taLeftJustify;
  Columns[cAvgCostColumn].Alignment     := taRightJustify;
  Columns[cCostColumn].Alignment        := taRightJustify;
  Columns[cLabourPriceColumn].Alignment := taRightJustify;
  Columns[cUnitPriceColumn].Alignment   := taRightJustify;
  Columns[cPriceColumn].Alignment       := taRightJustify;
  Columns[cProcessStepsColumn].Alignment:= taLeftJustify;
  Columns[cProcessStepExtraInfo].Alignment:= taLeftJustify;
  Columns[cInputTypeColumn].Alignment   := taLeftJustify;
  Columns[cOptionColumn].Alignment      := taLeftJustify;
  Columns[cInfoColumn].Alignment        := taLeftJustify;
  Columns[cPriceMatrix].Alignment       := taRightJustify;
  Columns[cAddToSaleColumn].Alignment   := taCenter;
  Columns[cHideOnPrintColumn].Alignment := taCenter;
  Columns[cUOMQty].Alignment            := taRightJustify;
  Columns[cTotalQtyColumn].Alignment    := taRightJustify;
  Columns[cSourceColumn].Alignment      := taLeftJustify;
  Columns[cDetailsColumn].Alignment     := taLeftJustify;
  Columns[cCustomInputColumn].Alignment := taLeftJustify;
  Columns[cQtyPerCoupon].Alignment      := taRightJustify;
  Columns[cRAtePercoupon].Alignment     := taRightJustify;
  Columns[cMakeCoupons].Alignment       := taCenter;
  Columns[cZeroWhenLessthan1].Alignment := taCenter;
  Columns[cRoundtoNextNumber].Alignment := taCenter;
  Columns[cRoundtoPrevNumber].Alignment := taCenter;
  Columns[cIgnoreItemComments].Alignment := taCenter;
  Columns[cSubBOMProcessOrder].Alignment := taLeftJustify;


end;
end;
procedure TframeTree.SetProcessTreeID(const Value: Integer);
var
  NodeData: PNodeData;
begin
  try
    if Value <> FProcessTreeID then begin
      FProcessTreeID := Value;

      if FProcessTreeID > 0 then begin
        if not Assigned(FTreeNodeRoot) then begin
          FTreeNodeRoot := TProcTreeNode.Create(nil);
          if Assigned(fTransConnection) then FTreeNodeRoot.Storer.Connection := fTransConnection;
          FTreeRootNodeAssigned := False;
        end
        else if ClearAndLoad then begin
          if not FTreeRootNodeAssigned then FreeandNil(FTreeNodeRoot);
          FTreeNodeRoot := TProcTreeNode.Create(nil);
          if Assigned(fTransConnection) then FTreeNodeRoot.Storer.Connection := fTransConnection;
          FTreeRootNodeAssigned := False;
        end;

        if FTreeNodeRoot.ProcTreeId <> FProcessTreeID then FTreeNodeRoot.ProcTreeId := FProcessTreeID;

        if ClearAndLoad then FTreeNodeRoot.LoadTree;
       // FTreeNodeRoot.logit(true);

        vstProcessPart.Clear;
        vstProcessPart.AddChild(vstProcessPart.RootNode);
        vstProcessPart.ReinitNode(vstProcessPart.RootNode.FirstChild, False);
        NodeData := vstProcessPart.GetNodeData(vstProcessPart.RootNode.FirstChild);
        NodeData.Data.Free;
        NodeData.Data := FTreeNodeRoot;
        BuildVisualTree(vstProcessPart.RootNode.FirstChild);
        vstProcessPart.FullExpand(vstProcessPart.RootNode.FirstChild);
      end;
    end;
  except
    on E: Exception do begin
      LogD('TframeTree.SetProcessTreeID - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TframeTree.RebuildVisualTree;
var
  NodeData: PNodeData;
begin
  try
    vstProcessPart.Clear;
    vstProcessPart.AddChild(vstProcessPart.RootNode);
    vstProcessPart.ReinitNode(vstProcessPart.RootNode.FirstChild, False);
    NodeData := vstProcessPart.GetNodeData(vstProcessPart.RootNode.FirstChild);
    NodeData.Data.Free;
    NodeData.Data := FTreeNodeRoot;
    BuildVisualTree(vstProcessPart.RootNode.FirstChild);
    DisplayForMode;
    vstProcessPart.FullExpand(vstProcessPart.RootNode.FirstChild);
  except
    on E: Exception do begin
      LogD('TframeTree.RebuildVisualTree - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TframeTree.ResetCaptions;
var
  ctr:Integer;
begin
    //clog('Loading tree captions');
    for ctr:= 0 to cMaxColumns-1 do  begin
      try
        vstProcessPart.Header.Columns[ctr].Text    :=  colnumtoName(ctr);
        vstProcessPart.Header.Columns[ctr].Options := vstProcessPart.Header.Columns[ctr].Options + [coWrapCaption];
        //Logtext(inttostr( ctr) +':' +  vstProcessPart.Header.Columns[ctr].Text );
      Except
        on E:Exception do begin
          //Logtext(inttostr( ctr) +'.Error:' + E.Message);
        end;
        //kill the exception if any
      end;
    end;
    //Logtext('Loaded');
end;

procedure TframeTree.SetTreeNodeRoot(const Value: TProcTreeNode);
begin
  try
    if Value <> FTreeNodeRoot then begin
      if not FTreeRootNodeAssigned then FreeandNil(FTreeNodeRoot);
      FTreeNodeRoot := Value;
      FTreeRootNodeAssigned := True;
    end;
  except
    on E: Exception do begin
      LogD('TframeTree.SetTreeNodeRoot - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TframeTree.BuildVisualTree(const VisualNode: PVirtualNode);

  procedure DoBuild(const VisualNode: PVirtualNode);
  var
    index: Integer;
    newNode: PVirtualNode;
    TreeNode: TProcTreeNode;
    ChildNode: TProcTreeNode;
    NodeData: PNodeData;
  begin
    // LogD('DoBuild',lbBegin);
    try
      try
        NodeData := vstProcessPart.GetNodeData(VisualNode);
        TreeNode := NodeData.Data;
        SetNodeDataFields(VisualNode);

        // LogD('DoBuild - Loop Start');
        for index := 0 to TreeNode.Children.Count - 1 do begin
          // LogD('DoBuild - Index: ' +IntToStr(Index) + ' of Count: '  + IntToStr(TreeNode.Children.Count));
          ChildNode := TProcTreeNode(TreeNode.Children[index]);
          newNode := vstProcessPart.AddChild(VisualNode);
          vstProcessPart.ReinitNode(newNode, False);
          NodeData := vstProcessPart.GetNodeData(newNode);
          NodeData.Data.Free;
          NodeData.Data := ChildNode;
          SetNodeDataFields(newNode);

          if (ChildNode.InputType <> itCustom) and (ChildNode.Children.Count > 0) then DoBuild(newNode);
        end;
        // LogD('DoBuild - Loop Done');
      except
        on E: Exception do begin
          LogD('DoBuild - Exception: ' + E.Message);
          raise;
        end;
      end;
    finally
      // LogD('',lbEnd);
    end;
  end;

begin
  try
    // LogD('TframeTree.BuildVisualTree',lbBegin);
    try
      FBuildingVisualTree := True;
      DoBuild(VisualNode);
      FBuildingVisualTree := False;
    finally
      // LogD('',lbEnd);
    end;
  except
    on E: Exception do begin
      LogD('TframeTree.BuildVisualTree - Exception: ' + E.Message);
      raise;
    end;
  end;
end;
procedure TframeTree.SetHighlightcolumnMsg(const Value :String);
begin
  TimerMsg(Value);
end;
procedure TframeTree.SetHighlightcolumn(const Value: Integer);
begin
    fiHighlightcolumn := Value;
  vstProcessPart.FocusedColumn :=Value;
  FCurrentNode := vstProcessPart.RootNode.FirstChild;
end;

procedure TframeTree.SetNodeDataFields(const Node: PVirtualNode);
var
  NodeData: PNodeData;
  ParentNode: PVirtualNode;
  ParentNodeData: PNodeData;
begin
  try
    // LogD('TframeTree.SetNodeDataFields',lbBegin);
    try
      FAppSettingCheckBox := True;
      NodeData := vstProcessPart.GetNodeData(Node);
      NodeData.Captions[cPartNameColumn] := NodeData.Data.Caption;
      NodeData.Captions[cPartDescColumn] := NodeData.Data.Description;
      NodeData.Captions[cInfoColumn] := NodeData.Data.Info;

      if Node <> vstProcessPart.RootNode.FirstChild then NodeData.Captions[cInputTypeColumn] := cInputTypeText[NodeData.Data.InputType];

      NodeData.Captions[cCustomInputColumn] := RegPopup.GetDisplayText(NodeData.Data.CustomInputClass);
      NodeData.Captions[cQtyColumn] := FormatFloat('##########0.##########', NodeData.Data.TreePartUOMQuantity  ); // FloatToStr(NodeData.Data.Quantity);
      NodeData.Captions[cQtyPercolumn] := FormatFloat('##########0.##########', NodeData.Data.QtyPer); // FloatToStr(NodeData.Data.Qtyper);

      NodeData.Captions[cStockQty]    := FormatFloat('##########0.##########', NodeData.Data.FromStockUOMQty  );
      NodeData.Captions[cbuildQty]    := FormatFloat('##########0.##########', NodeData.Data.ManufactureUOMQty  );
      NodeData.Captions[cOrderqty]    := FormatFloat('##########0.##########', NodeData.Data.OnOrderUOMQty  );
      NodeData.Captions[cUOMQty]      := FormatFloat('##########0.##########', NodeData.Data.QtyFor1UOMParent) + ' x ' + NodeData.Data.TreePartUOM + ' (' + FormatFloat('##########0.##########',NodeData.Data.TReePartUOMMultiplier) + ')';

      NodeData.CheckBoxes[cAddToSaleIndex].Checked := NodeData.Data.AddToSale;
      NodeData.CheckBoxes[cHideOnPrintIndex].Checked := NodeData.Data.HideOnPrint;
      NodeData.CheckBoxes[cMakecoupnsIndex].Checked := NodeData.Data.MakeCoupons;
      NodeData.CheckBoxes[cZeroWhenLessthan1index].Checked := NodeData.Data.ZeroWhenLessthan1;
      NodeData.CheckBoxes[cRoundtoNextNumberindex].Checked := NodeData.Data.RoundtoNextNumber;
      NodeData.CheckBoxes[cRoundtoPrevNumberindex].Checked := NodeData.Data.RoundtoPrevNumber;
      NodeData.CheckBoxes[cIgnoreItemCommentsIndex].Checked := NodeData.Data.IgnoreItemCommentsforDescription;

      FAppSettingCheckBox := False;

      if NodeData.Data.Selected then begin
        ParentNode := Node.Parent;

        if Assigned(ParentNode) then begin
          ParentNodeData := vstProcessPart.GetNodeData(ParentNode);

          if Assigned(ParentNodeData) then begin
            if ParentNodeData.Data.InputType = itOption then ParentNodeData.Captions[cOptionColumn] := NodeData.Captions[cPartNameColumn];
          end;
        end;
      end;

      NodeData.Captions[cSourceColumn] := PartSourceToStr(NodeData.Data.PartSource);

      NodeData.Captions[cProcessStepsColumn]  := NodeData.Data.ProcessStepDescList;
      NodeData.Captions[cProcessStepExtraInfo]:= NodeData.Data.ProcessStepExtraInfoList;
      NodeData.Captions[cQtyPerCoupon]        := FormatFloat('##########0.##########', NodeData.Data.QtyPerCoupon  );
      NodeData.Captions[cRAtePercoupon]       := FormatFloat('##########0.##########', NodeData.Data.RAtePercoupon  );
      NodeData.Captions[cSubBOMProcessOrder] := cSubBOMProcessOrderText[NodeData.Data.SubBOMProcessOrderCode];
      //if Node <> vstProcessPart.RootNode.FirstChild then
      if EnableSubBOMProcessOrder(Node , nodedata) then
        NodeData.Captions[cSubBOMProcessOrder] := cSubBOMProcessOrderText[NodeData.Data.SubBOMProcessOrderCode];
    finally
      // LogD('',lbEnd);
    end;
  except
    on E: Exception do begin
      LogD('TframeTree.SetNodeDataFields - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TframeTree.vstProcessPartCollapsed(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  try DisplayCheckBoxes(Sender.RootNode, True);
  except
    on E: Exception do begin
      LogD('TframeTree.vstProcessPartCollapsed - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TframeTree.DisplayCheckBoxes(const Node: PVirtualNode; Expanded: Boolean; const Visible: Boolean = False);
var
  ChildNode: PVirtualNode;

  procedure DoHide(const Node: PVirtualNode);
  var
    index: Integer;
    NodeData: PNodeData;
  begin
    NodeData := vstProcessPart.GetNodeData(Node);

    if Assigned(NodeData) then begin
      if (not Expanded) or ((TreeMode = tmInput) and (Node <> vstProcessPart.RootNode)) then
        for index := 0 to cMaxCheckBoxes - 1 do NodeData.CheckBoxes[index].Visible := Expanded and Visible;
      if (not Expanded) or (TreeMode = tmInput)  then
        NodeData.CheckBoxes[cIgnoreItemCommentsIndex].Visible := Expanded and Visible;

    end;
  end;

begin
  try
    DoHide(Node);

    ChildNode := Node.FirstChild;

    while Assigned(ChildNode) do begin
      Expanded := Expanded and vstProcessPart.Expanded[Node];

      if Assigned(ChildNode.FirstChild) then DisplayCheckBoxes(ChildNode, Expanded, Visible);

      if (not Expanded) or (TreeMode = tmInput) then DoHide(ChildNode);

      ChildNode := ChildNode.NextSibling;
    end;
  except
    on E: Exception do begin
      LogD('TframeTree.DisplayCheckBoxes - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TframeTree.DisplayRequiredNodes(const Node: PVirtualNode; out Visible: Boolean);
var
  ChildNode: PVirtualNode;
  NodeData: PNodeData;
  ParentNode: PNodeData;
  NodeVisible: Boolean;
begin
  try
    ChildNode := Node.FirstChild;
    NodeVisible := False;

    while Assigned(ChildNode) do begin
      Visible := False;
      NodeData := vstProcessPart.GetNodeData(ChildNode);

      if Assigned(ChildNode.FirstChild) then DisplayRequiredNodes(ChildNode, Visible);

      if (NodeData.Data.InputType <> itNone) or (ChildNode = vstProcessPart.RootNode.FirstChild) or (NodeData.Data.PartsID<> 0) then Visible := True;

      if not(Visible) then
        // if  (vstProcessPart.IsVisible[ChildNode.Parent]) then
        if NodeData.Data.PartsID <> 0 then begin
          ParentNode := vstProcessPart.GetNodeData(ChildNode.Parent);
          if (ParentNode.Data.InputType = itNone) or // standa alone product
            (ChildNode.Parent = vstProcessPart.RootNode.FirstChild) or // root node
            ((ParentNode.Data.InputType = itOption) and (NodeData.Data.Selected)) then // option product
            if ParthasPriceMatrix(NodeData.Data.PartsID) then Visible := True;
          // ParentNode := nil;
        end;

      NodeVisible := NodeVisible or Visible;
      if Visible or (FTreeMode = tmTemplate) then vstProcessPart.IsVisible[ChildNode] := True
      else vstProcessPart.IsVisible[ChildNode] := False;

      ChildNode := ChildNode.NextSibling;
    end;

    Visible := NodeVisible;
  except
    on E: Exception do begin
      LogD('TframeTree.DisplayRequiredNodes - Exception: ' + E.Message);
      raise;
    end;
  end;
end;


procedure TframeTree.ExpandList(const NodeList: TList);
var
  index: Integer;
begin
  try
    for index := 0 to NodeList.Count - 1 do vstProcessPart.Expanded[PVirtualNode(NodeList[index])] := True;
  except
    on E: Exception do begin
      LogD('TframeTree.ExpandList - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TframeTree.GetExpandedList(const Node: PVirtualNode; const NodeList: TList);
var
  ChildNode: PVirtualNode;
begin
  try
    ChildNode := Node.FirstChild;

    while Assigned(ChildNode) do begin
      if vstProcessPart.Expanded[ChildNode] then NodeList.Add(ChildNode);

      if Assigned(ChildNode.FirstChild) then GetExpandedList(ChildNode, NodeList);

      ChildNode := ChildNode.NextSibling;
    end;
  except
    on E: Exception do begin
      LogD('TframeTree.GetExpandedList - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TframeTree.SetRootNodeData(const ProcTreeNode: TProcTreeNode);
var
  NodeData: PNodeData;
begin
  try
    vstProcessPart.ReinitNode(vstProcessPart.RootNode.FirstChild, False);
    NodeData := vstProcessPart.GetNodeData(vstProcessPart.RootNode.FirstChild);

    if Assigned(NodeData) then begin
      NodeData.Data.Free;
      NodeData.Data := ProcTreeNode;
      NodeData.Captions[cPartNameColumn] := ProcTreeNode.Caption;
      NodeData.Captions[cPartDescColumn] := ProcTreeNode.Description;
      NodeData.Captions[cQtyColumn] := FormatFloat('##########0.##########', NodeData.Data.TreePartUOMQuantity  ); // FloatToStr(ProcTreeNode.Quantity);
      NodeData.Captions[cQtyPercolumn] := FormatFloat('##########0.##########', NodeData.Data.QtyPer); // FloatToStr(ProcTreeNode.QtyPer);
      NodeData.Captions[cQtyPerCoupon] := FormatFloat('##########0.##########', NodeData.Data.QtyPerCoupon  );
      NodeData.Captions[cRAtePercoupon] := FormatFloat('##########0.##########', NodeData.Data.RAtePercoupon  );
    end;
  except
    on E: Exception do begin
      LogD('TframeTree.SetRootNodeData - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

function TframeTree.GetRootNodeData: TProcTreeNode;
var
  NodeData: PNodeData;
begin
  try
    Result := nil;
    NodeData := vstProcessPart.GetNodeData(vstProcessPart.RootNode.FirstChild);
    if Assigned(NodeData) then Result := NodeData.Data;
  except
    on E: Exception do begin
      LogD('TframeTree.GetRootNodeData - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

function TframeTree.FindMatchingParent(const Node: PVirtualNode; const PartsID: Integer): Boolean;
var
  ParentNode: PVirtualNode;
  ParentNodeData: PNodeData;
  FoundMatch: Boolean;
begin
  Result := False;
  // LogD('TframeTree.FindMatchingParent',lbBegin);
  try
    try
      FoundMatch := False;
      ParentNode := Node.Parent;

      while Assigned(ParentNode) and (not FoundMatch) do begin
        ParentNodeData := vstProcessPart.GetNodeData(ParentNode);

        if Assigned(ParentNodeData) and (ParentNodeData.Data.PartsID = PartsID) then FoundMatch := True
        else ParentNode := ParentNode.Parent;
      end;

      Result := FoundMatch;
    except
      on E: Exception do begin
        LogD('TframeTree.FindMatchingPArent - Exception: ' + E.ClassName + ' ' + E.Message);
        raise;
      end;
    end;
  finally
    // LogD('',lbEnd);
  end;
end;

procedure TframeTree.CheckOptions(const Node: PVirtualNode);
var
  NodeData: PNodeData;
  ParentNodeData: PNodeData;
begin
  try
    NodeData := vstProcessPart.GetNodeData(Node);
    ParentNodeData := vstProcessPart.GetNodeData(Node.Parent);

    if Assigned(NodeData) and Assigned(ParentNodeData) then begin
      if (ParentNodeData.Data.InputType = itOption) and SysUtils.SameText(ParentNodeData.Captions[cOptionColumn], NodeData.Captions[cPartNameColumn]) then ParentNodeData.Captions[cOptionColumn] := '';
    end;
  except
    on E: Exception do begin
      LogD('TframeTree.CheckOptions - Exception: ' + E.Message);
      raise;
    end;
  end;
end;



procedure TframeTree.ShowPopupForm(const ClassStr: string; const TreeNode: TProcTreeNode);
var
  Form: TBaseProcTreeEditGUI;
begin
  try
    if ClassStr <> '' then begin
      Form := TBaseProcTreeEditGUI(GetComponentByClassName(ClassStr));

      if Assigned(Form) and Assigned(Form.NodePropLink) then begin
        try
          Form.NodePropLink.BaseTreeNode := TreeNode;
          SendMessage(Form.Handle, TX_PerformStartup, Handle, Longint(@FGenericStr));

          if Form.ShowModal = mrOK then TreeNode.Price := Form.NodePropLink.GetTotalCost;
          TreeNode.Quantity := 1;
        finally Form.Release;
        end;
      end;
    end;
  except
    on E: Exception do begin
      LogD('TframeTree.ShowPopupForm - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TframeTree.ShowPricecostCalc(CostnPriceCalc: TNotifyEvent; showCalcOption:boolean; Msg:String);
begin
   {Keep visible true and change the width as otherwise the label which has the right alignment goes to right most corner and the button appears in the middle }
   btnBOMcostnPriceCalc.visible := showCalcOption;
   btnBOMcostnPriceCalc.Enabled := True;
   if Assigned(CostnPriceCalc) then btnBOMcostnPriceCalc.Onclick := CostnPriceCalc;
   btnBOMcostnPriceCalc.hint := Msg+NL;
   btnBOMcostnPriceCalc.Showhint := true;
   btnBOMcostnPriceCalc.ParentshowHint := false;

end;

procedure TframeTree.vstProcessPartExit(Sender: TObject);
begin
  try
    if vstProcessPart = nil then exit;
    vstProcessPart.EndEditNode;
  except
    on E: Exception do begin
      LogD('TframeTree.vstProcessPartExit - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TframeTree.SetTreeReadOnly(const Value: Boolean);
begin
  try
    if Value then vstProcessPart.TreeOptions.MiscOptions := vstProcessPart.TreeOptions.MiscOptions + [toReadOnly]
    else vstProcessPart.TreeOptions.MiscOptions := vstProcessPart.TreeOptions.MiscOptions - [toReadOnly];
  except
    on E: Exception do begin
      LogD('TframeTree.SetTreeReadOnly - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

function TframeTree.GetTreeReadOnly: Boolean;
begin
  try Result := toReadOnly in vstProcessPart.TreeOptions.MiscOptions;
  except
    on E: Exception do begin
      LogD('TframeTree.GetTreeReadOnly - Exception: ' + E.Message);
      raise;
    end;
  end;
end;


procedure TframeTree.mnuInfofromSalesClick(Sender: TObject);
var
  Node: PVirtualNode;
  NodeData: PNodeData;
begin
  Node := vstProcessPart.GetFirstSelected;
  NodeData := vstProcessPart.GetNodeData(Node);
  TSalesLineProcTree(NodeData.Data).info := TSalesLineProcTree(NodeData.Data).Sales.Comments ;
  NodeData.Captions[cInfoColumn] := TSalesLineProcTree(NodeData.Data).info;
  SendKeys('{RIGHT}',True);
end;

procedure TframeTree.mnuInfoToSalesClick(Sender: TObject);
var
  Node: PVirtualNode;
  NodeData: PNodeData;
begin
  Node := vstProcessPart.GetFirstSelected;
  NodeData := vstProcessPart.GetNodeData(Node);

  TSalesLineProcTree(NodeData.Data).Sales.Comments := TSalesLineProcTree(NodeData.Data).info;
end;

procedure TframeTree.mnuRecalculatePricefromProductClick(Sender: TObject);
begin
  RootNodeData.InittoRecalculatePricefromProduct;
  CalcPrice(RootNodeData);
  self.vstProcessPart.Refresh;
end;
Function TframeTree.SaleReadonly:Boolean;
var
  Node: PVirtualNode;
  NodeData: PNodeData;
begin
    result := True;
    if (TreeNodeRoot.MasterType <> mtSalesOrder) then exit;

    Node:=vstProcessPart.RootNode.FirstChild;
    NodeData := vstProcessPart.GetNodeData(Node);
 result := (TSalesLineProcTree(NodeData.Data).Sales.AccessManager.accesslevel < 3);
end;
procedure TframeTree.mnuTreePopup(Sender: TObject);
var
  X: Integer;
begin
  try
    if assigned(TreeNodeRoot) then begin
      mnuInfosep.visible := TreeNodeRoot.MasterType = mtSalesOrder;

      mnuInfoToSales.visible := (TreeNodeRoot.MasterType = mtSalesOrder) ;
      mnuInfoToSales.Enabled := (TreeNodeRoot.MasterType = mtSalesOrder) and not(SaleReadonly);

      mnuInfofromSales.visible := (TreeNodeRoot.MasterType = mtSalesOrder);
      mnuInfofromSales.enabled := (TreeNodeRoot.MasterType = mtSalesOrder) and not(TreeReadOnly);
    end else begin
      mnuInfosep.visible := False;
      mnuInfoToSales.visible := False;
      mnuInfofromSales.visible := False;
    end;


    for X := 0 to TAdvPopupMenu(Sender).Items.Count - 1 do begin
      TAdvPopupMenu(Sender).Items[X].Enabled := (not TreeReadOnly) ;
      if TAdvPopupMenu(Sender).Items[X].Name = 'miInsert' then
        if vstProcessPart.GetFirstSelected<> nil then
          if vstProcessPart.GetFirstSelected.Parent <> nil then
            if vstProcessPart.GetFirstSelected.Parent.Parent <> nil then
              if vstProcessPart.GetFirstSelected.Parent.Parent.Parent <> nil then
                TAdvPopupMenu(Sender).Items[X].Enabled := Assigned(vstProcessPart.GetFirstSelected.Parent.Parent.Parent) and (TreeReadonly =False);
    end;
  except
    on E: Exception do begin
      LogD('TframeTree.mnuTreePopup - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TframeTree.mnutreeProductsAvgCostList1Click(Sender: TObject);
var
  Node: PVirtualNode;
  NodeData: PNodeData;
begin
    if RootNodeData.children.count =0 then exit;
    Node:=vstProcessPart.RootNode.FirstChild;
    NodeData := vstProcessPart.GetNodeData(Node);
    TTreeProductsAvgCostListGUI.TreeProductsAvgCostforaTree(NodeData.Data.ID);
end;

procedure TframeTree.pnlFooterDblClick(Sender: TObject);
begin
end;

{$WARNINGS OFF}


procedure TframeTree.ApplicationEvents1Exception(Sender: TObject; E: Exception);
begin
  if HideException and ((E is EAccessViolation) or (E is EAbstractError)) then begin // EAbstractError
    LogD('TframeTree.ApplicationEvents1Exception - Hiding Exception: ' + E.ClassName + ' ' + E.Message);
    ApplicationEvents1.CancelDispatch;
  end else begin
    LogD('TframeTree.ApplicationEvents1Exception - Exception: ' + E.ClassName + ' ' + E.Message);
    raise E;
  end;
end;

procedure TframeTree.btnBOMcostnPriceCalcClick(Sender: TObject);
begin

end;

{$WARNINGS ON}

procedure TframeTree.vstProcessPartAfterPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas);
begin
  // LogD('TframeTree.vstProcessPartAfterPaint');
  HideException := False;
end;

procedure TframeTree.vstProcessPartBeforeCellPaint(Sender: TBaseVirtualTree;TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
var
  NodeData: PNodeData;
begin
  NodeData := vstProcessPart.GetNodeData(Node);
    if (Highlightcolumn >=0) and (column = Highlightcolumn) and (Node <> vstProcessPart.RootNode.FirstChild) then begin
      TargetCanvas.Brush.Color := GridColhighLightGreen;
      TargetCanvas.Font.Color := clRed;
    end else if (column = cUnitPriceColumn) and  NodeData.Data.TreePricechanged then begin
      TargetCanvas.Brush.Color := $00C4FFC4;
    end else if Highlightcolumn <0 then begin
      TargetCanvas.Brush.Color := vstProcessPart.Header.Columns[column].Color;//clwhite;
    end else begin
      TargetCanvas.Brush.Color := clwhite;
    end;

    TargetCanvas.FillRect(CellRect);
end;

procedure TframeTree.setHideFormulacolumns(const Value: Boolean);
begin
  chkHideFormulacolumns.Checked:= Value;
end;

procedure TframeTree.setHideQtyPer(const Value: Boolean);
begin
  chkHideQtyPercolumn.Checked := Value;
end;

function TframeTree.getHideFormulacolumns: Boolean;
begin
  Result := chkHideFormulacolumns.Checked;
end;

function TframeTree.getHideQtyPer: Boolean;
begin
  Result := chkHideQtyPercolumn.Checked;
end;

procedure TframeTree.chkHideFormulacolumnsClick(Sender: TObject);
begin
  showFormulacolumns( FTreeMode = tmTemplate , Assigned(TreeNodeRoot) and (TreeNodeRoot.MasterType = mtSalesOrder) );
end;

procedure TframeTree.chkHideQtyPercolumnClick(Sender: TObject);
begin
  if chkHideQtyPercolumn.Checked then begin
    vstProcessPart.Header.Columns[cQtyPercolumn].Options := vstProcessPart.Header.Columns[cInputTypeColumn].Options - [coVisible];
    lblTotalQty.Left := 210;
    lblTotalCost.Left := 430;
    lblcostIncLabour.Left := 545;
    lblTotalPrice.Left := 720;
  end else begin
    vstProcessPart.Header.Columns[cQtyPercolumn].Options := vstProcessPart.Header.Columns[cInputTypeColumn].Options + [coVisible];
    lblTotalQty.Left := 250;
    lblTotalCost.Left := 470;
    lblcostIncLabour.Left := 585;
    lblTotalPrice.Left := 780;
  end;
end;

procedure TframeTree.ExplainSelectedNode;
var
  NodeData: PNodeData;
  Node: PVirtualNode;
begin
  Node := vstProcessPart.GetFirstSelected;
  if Node = nil then exit;
  NodeData := vstProcessPart.GetNodeData(Node);
  if NodeData = nil then exit;
  lblDetails.Caption := NodeData.Data.NodeDefinition;
end;

procedure TframeTree.vstProcessPartClick(Sender: TObject);
begin
  lblDetails.Caption := '';
  lblDetails.Refresh;
  ExplainSelectedNode;
  lblDetails.Refresh;
end;
Function colnumtoName(Const Value:Integer):String;
begin
       if Value = cPartNameColumn         then result := 'Product name'
  else if Value = cQtyPercolumn           then result := 'Qty Per'
  else if Value = cPartDescColumn         then result := 'Part Desc '
  else if Value = cQtyColumn              then result := 'Qty'
  else if Value = cStockQty               then result := 'Stock Qty'
  else if Value = cbuildQty               then result := 'Build Qty'
  else if Value = cFormulaQty             then Result := 'Formula Qty'
  else if Value = cFormulaQty1            then Result := Appenv.CompanyPrefs.Fe1Name
  else if Value = cFormulaQty2            then Result := Appenv.CompanyPrefs.Fe2Name
  else if Value = cFormulaQty3            then Result := Appenv.CompanyPrefs.Fe3Name
  else if Value = cFormulaQty4            then Result := Appenv.CompanyPrefs.Fe4Name
  else if Value = cFormulaQty5            then Result := Appenv.CompanyPrefs.Fe5Name
  else if Value = cbFormulaQty            then Result := 'To Build' + NL + 'Formula Qty'
  else if Value = cbFormulaQty1           then Result := 'To Build' + NL + Appenv.CompanyPrefs.Fe1Name
  else if Value = cbFormulaQty2           then Result := 'To Build' + NL + Appenv.CompanyPrefs.Fe2Name
  else if Value = cbFormulaQty3           then Result := 'To Build' + NL + Appenv.CompanyPrefs.Fe3Name
  else if Value = cbFormulaQty4           then Result := 'To Build' + NL + Appenv.CompanyPrefs.Fe4Name
  else if Value = cbFormulaQty5           then Result := 'To Build' + NL + Appenv.CompanyPrefs.Fe5Name
  else if Value = coFormulaQty            then Result := 'To Order' + NL + 'Formula Qty'
  else if Value = coFormulaQty1           then Result := 'To Order' + NL + Appenv.CompanyPrefs.Fe1Name
  else if Value = coFormulaQty2           then Result := 'To Order' + NL + Appenv.CompanyPrefs.Fe2Name
  else if Value = coFormulaQty3           then Result := 'To Order' + NL + Appenv.CompanyPrefs.Fe3Name
  else if Value = coFormulaQty4           then Result := 'To Order' + NL + Appenv.CompanyPrefs.Fe4Name
  else if Value = coFormulaQty5           then Result := 'To Order' + NL + Appenv.CompanyPrefs.Fe5Name
  else if Value = cOrderqty               then result := 'Order Qty '
  else if Value = cUOM                    then result := 'UOM'
  else if Value = cAvgCostColumn          then result := 'Avg Cost'
  else if Value = cCostColumn             then result := 'Cost'
  else if Value = cLabourPriceColumn      then result := 'Labour Price'
  else if Value = cUnitPriceColumn        then result := 'Unit Price'
  else if Value = cPriceColumn            then result := 'Total price'
  else if Value = cProcessStepsColumn     then result := 'Process step'
  else if Value = cProcessStepExtraInfo   then result := 'Process ExtraInfo'
  else if Value = cInputTypeColumn        then result := 'Input type'
  else if Value = cOptionColumn           then result := 'Option'
  else if Value = cInfoColumn             then result := 'Info'
  else if Value = cPriceMatrix            then result := 'Price Matrix'
  else if Value = cAddToSaleColumn        then result := 'Add to Sale'
  else if Value = cHideOnPrintColumn      then result := 'Hide on Print'
  else if Value = cUOMQty                 then result := 'Uom Qty'
  else if Value = cTotalQtyColumn         then result := 'Total Qty'
  else if Value = cSourceColumn           then result := 'Source'
  else if Value = cDetailsColumn          then result := 'Details'
  else if Value = cCustomInputColumn      then result := 'Custom input'
  else if Value = cQtyPerCoupon           then result := 'Qty / Coupon'
  else if Value = cRAtePercoupon          then result := 'Rate / coupon'
  else if Value = cMakeCoupons            then result := 'Make Coupons'
  else if Value = cZeroWhenLessthan1      then result := '0 when < 1'
  else if Value = cRoundtoNextNumber      then result := 'Round to Next'
  else if Value = cRoundtoPrevNumber      then result := 'Round to Previous'
  else if Value = cIgnoreItemComments      then result := 'Ignore Copy Info' + NL + 'to Desc'
  else if Value = cSubBOMProcessOrder      then result := 'Partial/Progress Build' + NL + 'Sub BOM Use Order'
  else result := '';
end;

function TVTFrameEditControl.BeginEdit: Boolean;
var
  NodeData: PNodeData;
  ParentNodeData: PNodeData;
  ControlEnabled: Boolean;
  ShowButton: Boolean;
begin
  try
    Result := not FStopping;
    if not result then exit;

    Result := DoBeginEdit;
    if not result then exit;

    if Result then begin
      case ControlType of
        ectEdit: begin
            FEdit.Show;
            FEdit.Width := TVirtualStringTree(ftree).Header.Columns[FColumn].width-2;
            ControlEnabled := True;
            NodeData := FTree.GetNodeData(FNode);
            ParentNodeData := FTree.GetNodeData(FNode.Parent);
            if fcolumn = cPartNameColumn then FEdit.Width := getcolumwidth(nodeData,FEdit.Width,ParentNodeData);

            if (fcolumn = cProcessStepExtraInfo)                                                                                                                                                                                                                                                                                                                                                        then ControlEnabled := False;
            if ControlEnabled then if ((NodeData.Data.PartsID > 0)        and (FColumn in [cPartNameColumn, cPartDescColumn]))                                                                                                                                                                                                                                                                          then ControlEnabled := False;
            if ControlEnabled then if ((NodeData.Data.PartsID = 0)        and (FColumn in [cFormulaQty,cbFormulaQty,cbFormulaQty1,cbFormulaQty2,cbFormulaQty3,cbFormulaQty4,cbFormulaQty5,coFormulaQty,coFormulaQty1,coFormulaQty2,coFormulaQty3,coFormulaQty4,coFormulaQty5]))                                                        then ControlEnabled := False;
            if ControlEnabled then if ((NodeData.Data.PartsID <> 0)       and (not(NodeData.Data.ProductHasformula))            and (FColumn in [cbFormulaQty,cbFormulaQty1,cbFormulaQty2,cbFormulaQty3,cbFormulaQty4,cbFormulaQty5,coFormulaQty,coFormulaQty1,coFormulaQty2,coFormulaQty3,coFormulaQty4,coFormulaQty5]))  then ControlEnabled := False;
            if ControlEnabled then if (FNode = FTree.RootNode.FirstChild) and (not(FColumn  in [cQtyPerCoupon,cRAtePercoupon,cMakeCoupons, cStockQty, cbuildQty,cbFormulaQty,cbFormulaQty1,cbFormulaQty2,cbFormulaQty3,cbFormulaQty4,cbFormulaQty5, cOrderqty ,coFormulaQty , coFormulaQty1,coFormulaQty2,coFormulaQty3,coFormulaQty4,coFormulaQty5, cinfocolumn]))                                                                                then ControlEnabled := False;
            if ControlEnabled then if ((NodeData.Data.IsOption)            or  (NodeData.Data.PartsID=0))                        and (FColumn  in [cStockQty, cbFormulaQty,cbFormulaQty1,cbFormulaQty2,cbFormulaQty3,cbFormulaQty4,cbFormulaQty5, cbuildQty, cOrderqty , coFormulaQty,coFormulaQty1,coFormulaQty2,coFormulaQty3,coFormulaQty4,coFormulaQty5])                                           then ControlEnabled := False;
            if ControlEnabled then if Assigned(ParentNodeData)            and (ParentNodeData.Data.InputType = itOption)        and (NodeData.data.Selected =False)  and (NodeData.data.MasterType <> mtProduct)                                                                                                                                                                                        then ControlEnabled := False;
            if ControlEnabled then if NodeData.Data.children.count = 0    then if FColumn  in [cbuildQty ,cbFormulaQty,cbFormulaQty1,cbFormulaQty2,cbFormulaQty3,cbFormulaQty4,cbFormulaQty5]                                                                                                                                                                                                           then ControlEnabled := False;
            if controlEnabled then if (FNode = FTree.RootNode.FirstChild) and  (FColumn  in [cStockQty, cbuildQty,cbFormulaQty,cbFormulaQty1,cbFormulaQty2,cbFormulaQty3,cbFormulaQty4,cbFormulaQty5, cOrderqty, coFormulaQty,coFormulaQty1,coFormulaQty2,coFormulaQty3,coFormulaQty4,coFormulaQty5]) and (NodeData.Data.isInternalOrder)                                                               then ControlEnabled := False;
            if ControlEnabled then if  fcolumn = cUnitPriceColumn    then if (NodeData.Data.PartsID <=0) or (NodeData.Data.children.count >0) then ControlEnabled := False;
            if ControlEnabled then if  fcolumn = cSubBOMProcessOrder then  ControlEnabled := EnableSubBOMProcessOrder(FNode , nodedata);

            if ControlEnabled then begin
              FEdit.Enabled := True;
              FEdit.SelectAll;
              SetControlFocus(FEdit);
            end
            else FEdit.Enabled := False;
          end;

        ectCheckBox: begin
            FCheckBox.Show;
            if FNode = FTree.RootNode.FirstChild then FCheckBox.Enabled := False
            else begin
              FCheckBox.Enabled := True;
              SetControlFocus(FCheckBox);
            end;
          end;

        ectComboBox: begin
            if (FColumn = cSourceColumn) and (TframeTree(FTree.Owner).TreeMode = tmTemplate) then FComboBox.Enabled := False;
            if (FColumn = cInputTypeColumn) and (TframeTree(FTree.Owner).TreeMode <> tmTemplate) then FComboBox.Enabled := False;

            if FComboBox.Enabled then begin
              FComboBox.Show;
              FComboBox.SelectAll;
              SetControlFocus(FComboBox);
            end;
          end;

        ectDatePicker: begin
            FDateTimePicker.Show;

            if FNode = FTree.RootNode.FirstChild then FDateTimePicker.Enabled := False
            else begin
              FDateTimePicker.Enabled := True;
              SetControlFocus(FDateTimePicker);
            end;
          end;

        ectButton: begin
            //ShowButton := True;
            NodeData := FTree.GetNodeData(FNode);
            if FColumn = cDetailsColumn then begin
              if Assigned(NodeData) and (NodeData.Data.InputType = itCustom) then ShowButton := True
              else ShowButton := False;
            end else ShowButton := True;
            FButton.Show;
            if ShowButton then begin
              FButton.Enabled := TRue;
              SetControlFocus(FButton);
            end else begin
              FButton.Enabled := False;
            end;
          end;
      end;
    end;
  except
    on E: Exception do begin
      LogD('TVTFrameEditControl.BeginEdit - Exception: ' + E.Message);
      raise;
    end;
  end;
end;
function TVTFrameEditControl.CancelEdit: Boolean;
begin
  result := DoCancelEdit;
end;
function TVTFrameEditControl.EnableSubBOMProcessOrder(Node: PVirtualNode;NodeData: PNodeData): Boolean;
begin
  result := False;
  if frameTree <> nil then
    result := frameTree.EnableSubBOMProcessOrder(node, nodedata);
end;

function TVTFrameEditControl.EndEdit: Boolean;
var
  NodeData: PNodeData;
begin
  try
    Result := not FStopping;

    if Result then begin
      try
        FStopping := True;

        case ControlType of
          ectEdit: begin
              NodeData := FTree.GetNodeData(FNode);
              //FTree.Text[FNode, FColumn] := FEdit.Text;
              if (FColumn = cQtyColumn) and Assigned(NodeData.Data.ParentNode) then begin
                if FEdit.Enabled then FTree.Text[FNode, FColumn] := FEdit.Text;
              end else
                FTree.Text[FNode, FColumn] := FEdit.Text;
              FEdit.Hide;
            end;

          ectCheckBox: begin
              if FCheckBox.Checked then FTree.Text[FNode, FColumn] := 'Yes'
              else FTree.Text[FNode, FColumn] := 'No';

              FCheckBox.Hide;
            end;

          ectComboBox: begin
              FTree.Text[FNode, FColumn] := FComboBox.Text;
              FComboBox.Hide;
            end;

          ectDatePicker: begin
              FTree.Text[FNode, FColumn] := DateToStr(FDateTimePicker.Date);
              FDateTimePicker.Hide;
            end;

          ectButton: begin
              FButton.Hide;
            end;
        end;
      finally FStopping := False;
      end;
    end;
  except
    on E: Exception do begin
      LogD('TVTEditControlBase.DoEndEdit - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

function TVTFrameEditControl.frameTree: TframeTree;
begin
  if Assigned(TVirtualStringTree(ftree).parent) and (TVirtualStringTree(ftree).parent is TframeTree) then
    result := TframeTree(TVirtualStringTree(ftree).parent)
  else   if Assigned(TVirtualStringTree(ftree).Owner) and (TVirtualStringTree(ftree).Owner is TframeTree) then
    result := TframeTree(TVirtualStringTree(ftree).Owner)
  else result := nil;
end;

function TVTFrameEditControl.GetBounds: TRect;
begin
  result := DoGetBounds;
end;
function TVTFrameEditControl.getEditcontrol(aColumn: TColumnIndex): TEditControlType;
begin
  Result := cTreeFrameColumnControls[aColumn];
end;


procedure TVTFrameEditControl.HandleComboBoxCloseUp(Sender: TObject);
var
  index: Integer;
  Text: string;
  InputType: TNodeInputType;
  Node: PVirtualNode;
  ChildNode: PVirtualNode;
  NodeData: PNodeData;
  Anychanged:Boolean;
begin
  inherited HandleComboBoxCloseUp(Sender);
  if (Sender is TComboBox) and (TComboBox(Sender).Items.Count > 0) then begin
    Node := Ptr(TComboBox(Sender).Tag);
    Text := TComboBox(Sender).Text;

    if Assigned(Node) then begin
      NodeData := FTree.GetNodeData(Node);
      try
        if FColumn = cSubBOMProcessOrder then begin
          NodeData.Data.SubBOMProcessOrderCode := GetSubBOMProcessOrdercODE(Text);
          NodeData.Data.SubBOMProcessOrder := GetSubBOMProcessOrder(Text);
        end;
        if FColumn = cInputTypeColumn then begin
          InputType := GetInputType(Text);

          if NodeData.Data.InputType = itOption then begin
            NodeData.Captions[cOptionColumn] := '';
            ChildNode := Node.FirstChild;
            for index := 0 to Node.ChildCount - 1 do begin
              NodeData := FTree.GetNodeData(ChildNode);
              NodeData.Data.Selected := False;
              ChildNode := ChildNode.NextSibling;
            end;

          end;

          NodeData := FTree.GetNodeData(Node);
          NodeData.Data.InputType := InputType;
          CalcPrice(TProcTreeNode(NodeData.Data.RootNode));

          self.FTree.Refresh;
          if NodeData.Data.InputType = itOption then begin
            NodeData.Captions[cInputTypeColumn] := cInputTypeText[NodeData.Data.InputType];
            FTree.SetFocus;
            FTree.FocusedColumn := cOptionColumn;
            FTree.EditNode(Node, cOptionColumn);
          end;

        end else begin
          case NodeData.Data.InputType of
            itOption: begin
                //ParentUOMQtyforSelection := NodeData.Data.TreePartUOMQuantity;
                ChildNode := Node.FirstChild;
                Anychanged:=False;
                for index := 0 to Node.ChildCount - 1 do begin
                  NodeData := FTree.GetNodeData(ChildNode);

                  if SysUtils.SameText(NodeData.Captions[cPartNameColumn], Text) then begin
                    if not (NodeData.Data.Selected) then begin
                          NodeData.Data.Selected := True;
                          if NodeData.Data.ProductHasFormula then begin
                            NodeData.Data.FormulaQtyValue:= 1;
                            if NodeData.Data.TreePartUOMQuantity <> 1 then NodeData.Data.FormulaQtyValue := 1/ NodeData.Data.TreePartUOMQuantity;
                          end else begin
                            NodeData.Data.Quantity := 1;
                          end;
                      Anychanged:=True;
                    end;
                  end else begin
                    if NodeData.Data.Selected then begin
                      NodeData.Data.Selected := False;
                      NodeData.Data.Quantity := 0;
                      if NodeData.Data.ProductHasFormula then
                        NodeData.Data.FormulaQtyValue:= 0;
                      Anychanged:=True;
                    end;
                  end;
                  REfreshQty(node, NodeData, false);
                  ChildNode := ChildNode.NextSibling;
                end;
                if Anychanged then begin
                  PNodeData(FTree.GetNodeData(Node)).Data.CalcQty;
                  CalcPrice(TProcTreeNode(NodeData.Data.RootNode));
                  self.FTree.Refresh;
                end;
              end;
            itCustom: begin
                NodeData := FTree.GetNodeData(Node);
                NodeData.Data.CustomInputClass := RegPopup.GetClassName(Text);
                NodeData.Captions[cCustomInputColumn] := Text;
                if NodeData.Data.CustomInputClass = '' then CommonLib.MessageDlgXP_Vista('You Must Choose Custom Input.', mtInformation, [mbOk], 0)
                else if Assigned(fCustomEditHandle) then fCustomEditHandle(NodeData.Data.CustomInputClass, NodeData.Data);
              end;
          end;
        end;
      except
        on E: Exception do begin
          { tempory fix to catch the exception that sometimes occures }
        end;
      end;
      try
        { Removed this represh as it was causing AV's when combo changed
          from stock to manufacture ... grid seems to refresh ok }
        // FTree.Refresh;
      except
        { tempory fix to catch refresh AV that sometimes occures
          after tree has been reloaded / rebuilt }
      end;
    end;
  end;
end;

function TVTFrameEditControl.PrepareEdit(Tree: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex): Boolean;
var
  index: Integer;
  InputIndex: TNodeInputType;
  SubBOMProcessOrderIndex: TSubBOMProcessOrderCode;
{$IFDEF COMPILER_22_UP}
  Text: string;
{$ELSE}
  Text: string;
{$ENDIF}
  NodeData: PNodeData;
  DisplayList: TStringList;
begin
  Result := DoPrepareEdit(Tree, Node, Column);
  if not result then exit;
  ControlType := Editcontrol[fColumn];
  case ControlType of
        ectEdit : begin
        end;
        ectComboBox: begin
            FTree.GetTextInfo(Node, Column, FComboBox.Font, FTextBounds, Text);
            case Column of
              cInputTypeColumn: begin
                  FComboBox.Clear;
                  FComboBox.Style := csDropDownList;
                  FComboBox.Tag := Integer(Node);
                  FComboBox.OnCloseUp := HandleComboBoxCloseUp;
                  FComboBox.Enabled := (Node <> FTree.RootNode.FirstChild);

                  if FComboBox.Enabled then begin
                    for InputIndex := low(TNodeInputType) to high(TNodeInputType) do FComboBox.Items.Add(cInputTypeText[InputIndex]);
                  end;
                end;

              cSubBOMProcessOrder: begin
                  NodeData := FTree.GetNodeData(Node);
                  FComboBox.Clear;
                  FComboBox.Style := csDropDownList;
                  FComboBox.Tag := Integer(Node);
                  FComboBox.OnCloseUp := HandleComboBoxCloseUp;
                  FComboBox.Enabled := EnableSubBOMProcessOrder(Node , nodedata);// (Node <> FTree.RootNode.FirstChild) and (NodeData.Data.PArtsID >0) and (NodeData.Data.children.count >0);

                  if FComboBox.Enabled then begin
                    for SubBOMProcessOrderIndex := low(TSubBOMProcessOrderCode) to high(TSubBOMProcessOrderCode) do FComboBox.Items.Add(cSubBOMProcessOrderText[SubBOMProcessOrderIndex]);
                  end;
                end;
              cCustomInputColumn: begin
                  NodeData := FTree.GetNodeData(Node);
                  FComboBox.Clear;
                  FComboBox.Style := csDropDownList;
                  FComboBox.Tag := Integer(Node);
                  FComboBox.OnCloseUp := HandleComboBoxCloseUp;
                  FComboBox.Enabled := (NodeData.Data.InputType = itCustom);

                  if FComboBox.Enabled then begin
                    DisplayList := RegPopup.GetDisplayList;

                    try FComboBox.Items.Assign(DisplayList);
                    finally FreeandNil(DisplayList);
                    end;
                  end;
                end;

              cOptionColumn: begin
                  NodeData := FTree.GetNodeData(Node);
                  FComboBox.Style := csDropDownList;
                  FComboBox.Tag := Integer(Node);
                  FComboBox.OnCloseUp := HandleComboBoxCloseUp;
                  FComboBox.Enabled := (NodeData.Data.InputType = itOption);
                  FComboBox.Clear;

                  if FComboBox.Enabled then begin
                    for index := 0 to NodeData.Data.Children.Count - 1 do FComboBox.Items.Add(TProcTreeNode(NodeData.Data.Children[index]).Caption);
                  end;
                end;

            end;

            FComboBox.ItemIndex := FComboBox.Items.IndexOf(Text);
          end;
        ectButton: begin
            if Column in [cProcessStepsColumn, cDetailsColumn, cPriceMatrix] then FButton.Tag := Integer(Node)
            else FButton.Tag := 0;
        end;
  end;
end;
procedure TVTFrameEditControl.ProcessMessage(var message: TMessage);
begin
  DoProcessMessage(Message);
end;
procedure TVTFrameEditControl.SetBounds(R: TRect);
begin
  DoSetBounds(R);
end;
function TVTFrameEditControl.getcolumwidth(nodeData:PNodeData;iWidth:Integer;ParentNodeData:PNodeData):Integer;
var
  iLevel:Integer;
begin
  iLevel:= nodeData.Data.Level;
  if iLevel =0 then
    if Assigned(ParentNodeData) then
      iLevel :=ParentNodeData.Data.Level+1;
  result :=iWidth - 18 - iLevel*20;
  if result <=0 then result:= 5;
end;

procedure TframeTree.TimerMsg(const Value: String;Secondstoshow: Integer; msgColor: TColor);
begin
  if Assigned(Owner) and (Owner is TBaseInputGUI) then
    TBaseInputGUI(Owner).TimerMsg(lblFooterMsg, Value, SecondsToshow, msgcolor);
end;

procedure TframeTree.OnSelectProduct(aVTEditControl: TVTFrameEditControl;Sender: TObject;PartId:Integer; Partname:String; PartDescription:String;  nodedata: PNodeData;Node: PVirtualNode);
var
  ChangeNode: Boolean;
  TreeID: Integer;
  sMatrixDesc: string;
  sMatrixRef: string;
  dMatrixPrice: double;
  TempNode: TProcTreeNode;
  fiTreePartUOMID: Integer;
  fsTreePartUOM: string;
  fdTreePartUOMMultiplier: double;
begin

          ChangeNode := True;
          TreeID := TreeRootIdForProductTemplate(PartID);

          if FindMatchingParent(Node, PartID) then begin
            ChangeNode := False;
            CommonLib.MessageDlgXP_Vista('A product cannot be added to a branch of the same product.', mtInformation, [mbOk], 0);
          end  else if nodedata.data.ProcessStepList.Count >0 then begin
            (*ChangeNode := False;
            CommonLib.MessageDlgXP_Vista('A product cannot have process steps.  Please delete the process steps before selecting the product', mtInformation, [mbOk], 0);*)
          end else begin
            if Node.ChildCount > 0 then begin
              if CommonLib.MessageDlgXP_Vista('This item has branches which will be deleted. Continue?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then ChangeNode := False
              else begin
                NodeData.Data.Delete;
                vstProcessPart.DeleteChildren(Node);
              end;
            end;
          end;

          if ChangeNode then begin
            if Assigned(NodeData.Data.Owner) and (NodeData.Data.Owner is TProcTreeNode) then
              CheckForLinkedSubs(TProcTreeNode(NodeData.Data.Owner));

            NodeData.Data.PartsID := PartID;
            NodeData.Data.Caption := PartName;
            NodeData.Data.Description := PartDescription;
            NodeData.Data.BuildLineno := ProductDefaultLineNo(PartID);

            NodeData.Data.TreePartUOMQuantity := 1;
            NodeData.Captions[cPartNameColumn] := PartName;
            NodeData.Captions[cPartDescColumn] := PartDescription;

            NodeData.Captions[cQtyColumn]    := FormatFloat('##########0.##########', NodeData.Data.TreePartUOMQuantity  );
            NodeData.Captions[cQtyPercolumn] := FormatFloat('##########0.##########', NodeData.Data.QtyPer);
            NodeData.Captions[cStockQty]     := FormatFloat('##########0.##########', NodeData.Data.FromStockUOMQty  );
            NodeData.Captions[cbuildQty]     := FormatFloat('##########0.##########', NodeData.Data.ManufactureUOMQty  );
            NodeData.Captions[cOrderqty]     := FormatFloat('##########0.##########', NodeData.Data.OnOrderUOMQty  );
            NodeData.Captions[cUOMQty]       := FormatFloat('##########0.##########', NodeData.Data.QtyFor1UOMParent) + ' x ' + NodeData.Data.TreePartUOM + ' (' + FormatFloat('##########0.##########',NodeData.Data.TReePartUOMMultiplier) + ')';
            NodeData.Captions[cQtyPerCoupon] := FormatFloat('##########0.##########', NodeData.Data.QtyPerCoupon  );
            NodeData.Captions[cRAtePercoupon]:= FormatFloat('##########0.##########', NodeData.Data.RAtePercoupon  );
            if not ChoosingOTFProduct then begin
                if (TreeID=0) and TProcTreeNode(NodeData.data).ProducthasformulaEntry then begin
                  initFormulaQtysfromFirstnode(NodeData);
                  if ProductformulaEntry(Node, NodeData) then begin
                        Nodedata.Data.OrderFormulaQtyValue1 := Nodedata.Data.FormulaQtyValue1;
                        Nodedata.Data.OrderFormulaQtyValue2 := Nodedata.Data.FormulaQtyValue2;
                        Nodedata.Data.OrderFormulaQtyValue3 := Nodedata.Data.FormulaQtyValue3;
                        Nodedata.Data.OrderFormulaQtyValue4 := Nodedata.Data.FormulaQtyValue4;
                        Nodedata.Data.OrderFormulaQtyValue5 := Nodedata.Data.FormulaQtyValue5;
                  end;
                end;
            end;

            if Appenv.Companyprefs.FeFieldVisible then begin
              NodeData.Captions[cFormulaQty1] :=FormatFloat('##########0.##########',NodeData.Data.FormulaQtyValue1);
              NodeData.Captions[cFormulaQty2] :=FormatFloat('##########0.##########',NodeData.Data.FormulaQtyValue2);
              NodeData.Captions[cFormulaQty3] :=FormatFloat('##########0.##########',NodeData.Data.FormulaQtyValue3);
              NodeData.Captions[cFormulaQty4] :=FormatFloat('##########0.##########',NodeData.Data.FormulaQtyValue4);
              NodeData.Captions[cFormulaQty5] :=FormatFloat('##########0.##########',NodeData.Data.FormulaQtyValue5);

            end;
            if ParthasPriceMatrix(PartID) then begin
              ReadSalesDefaultPriceMethod(PartID, sMatrixDesc, sMatrixRef, dMatrixPrice);
              NodeData.Data.MatrixRef := sMatrixRef;
              if sMatrixDesc <> '' then NodeData.Data.Description := sMatrixDesc;
              NodeData.Data.MatrixDesc := sMatrixDesc;
              NodeData.Data.matrixprice := dMatrixPrice;
            end;
            try
              if aVTEditControl <> nil then
                if aVTEditControl.FColumn = cPartNameColumn then
                  aVTEditControl.FEdit.Text := NodeData.Data.Caption;
            Except end;
            Try
              if assigned(NodeData.Data.ParentNode) then
                  CalcPrice(NodeData.Data.ParentNode);
              self.vstProcessPart.Refresh;
            Except end;
            Try

              if sender <> nil then
                if Sender is TMaskEdit then
                  TMaskEdit(Sender).Text := PartName;
            Except end;

            if TreeID > 0 then begin
              TempNode := TProcTreeNode.Create(nil);
              if Assigned(fTransConnection) then FTreeNodeRoot.Storer.Connection := fTransConnection;
              try
                TempNode.ProcTreeId := TreeID;
                TempNode.LoadTree;
                TempNode.ClearIds;

                fiTreePartUOMID := NodeData.Data.TreePartUOMID;
                fsTreePartUOM := NodeData.Data.TreePartUOM;
                fdTreePartUOMMultiplier := NodeData.Data.TReePartUOMMultiplier;
                NodeData.Data.Assign(TempNode);
                NodeData.Data.TreePartUOMID := fiTreePartUOMID;
                NodeData.Data.TreePartUOM := fsTreePartUOM;
                NodeData.Data.TReePartUOMMultiplier := fdTreePartUOMMultiplier;
                NodeData.Data.TreePartUOMQuantity := 1;
                NodeData.Data.Quantity := fdTreePartUOMMultiplier;

                if NodeData.Data.IsTemplate then begin
                  NodeData.Data.InheritFromID := TreeID; // TempNode.Id;
                  NodeData.Data.InheritFromEditVersion := TempNode.EditVersion;
                end;

                if TProcTreeNode(NodeData.data).ProducthasformulaEntry then begin
                  initFormulaQtysfromFirstnode(NodeData);
                  if ProductformulaEntry(Node, NodeData) then begin
                    Nodedata.Data.BuildFormulaQtyValue1 := Nodedata.Data.FormulaQtyValue1;
                    Nodedata.Data.BuildFormulaQtyValue2 := Nodedata.Data.FormulaQtyValue2;
                    Nodedata.Data.BuildFormulaQtyValue3 := Nodedata.Data.FormulaQtyValue3;
                    Nodedata.Data.BuildFormulaQtyValue4 := Nodedata.Data.FormulaQtyValue4;
                    Nodedata.Data.BuildFormulaQtyValue5 := Nodedata.Data.FormulaQtyValue5;

                    Nodedata.Data.OrderFormulaQtyValue1 := Nodedata.Data.FormulaQtyValue1;
                    Nodedata.Data.OrderFormulaQtyValue2 := Nodedata.Data.FormulaQtyValue2;
                    Nodedata.Data.OrderFormulaQtyValue3 := Nodedata.Data.FormulaQtyValue3;
                    Nodedata.Data.OrderFormulaQtyValue4 := Nodedata.Data.FormulaQtyValue4;
                    Nodedata.Data.OrderFormulaQtyValue5 := Nodedata.Data.FormulaQtyValue5;

                  end;
                end;

                if assigned(NodeData.Data.ParentNode) then
                  CalcPrice(NodeData.Data.ParentNode);

              finally TempNode.Free;
              end;
              BuildVisualTree(Node);
              vstProcessPart.FullExpand(Node);
            end else  if NodeData.Data.partsID>0 then begin
                    NodeData.Data.ProductUnitCost:=Round(TProduct.AvgCost(NodeData.Data.PartsId, NodeData.Data.Storer.Connection),GeneralRoundPlaces);
                    if math.IsZero(NodeData.Data.ProductUnitCost,0.000001) then
                      NodeData.Data.ProductUnitCost:= Round(TProduct.Cost(NodeData.Data.PartsId, NodeData.Data.Storer.Connection),GeneralRoundPlaces);

                     NodeData.Data.ProductUnitPrice := Round(TProduct.PriceForQty(NodeData.Data.PartsId, NodeData.Data.Quantity, NodeData.Data.Storer.Connection),GeneralRoundPlaces);
            end;
          end;
end;

procedure TframeTree.MultiSelectProduct;
begin
  OpenERPListFormultiselectModal('TProductListExpressGUI', initProductListExpress, onMultiSelectProduct);
end;

procedure TframeTree.initProductListExpress(Sender: TObject);
begin
  if Sender is TProductListExpressGUI then begin
    TProductListExpressGUI(Sender).FilterString := 'PartsId <> ' + inttostr(TSalesLineProcTree(vstProcessPart.RootNode).PartsId);
    TProductListExpressGUI(Sender).Selectrecordsfieldname :='PartsId';
    TProductListExpressGUI(Sender).SelectrecordsValues := OTFPartIDs;
    if OTFPartIDscount>0 then
      TProductListExpressGUI(Sender).ListtimerMsg ('On The Fly Product '+ Quotedstr(TreeNodeRoot.caption) + ' had ' + inttostr(OTFPartIDscount)+' Sub Items. They are all Highlighted.'+
      ' Please Choose "Select" to Select the Same Tree Items as in the Product Card.' ,TProductListExpressGUI(Sender).cmdPrint , 30);

    OTFPartIDs :='';
  end;
end;

procedure TframeTree.onMultiSelectProduct(Sender: TwwDbGrid);
begin
  fbonMultiSelectProduct := TRue;
  try
    BaseListLib.IterateselectedRecords(sender , DoMultiSelectProduct, true, mainform.height - 200);
  finally
    fbonMultiSelectProduct := False;
  end;
end;
procedure TframeTree.DoMultiSelectProduct(Qry :TERPQuery);
var
  NodeData: PNodeData;
  newNode: PVirtualNode;
  aPartsId:Integer;
  aPartname:String;
  aPartDescription:String;
begin
  try
    aPartsId:= Qry.fieldbyname('PARTSID').asInteger;
    aPartname:= Qry.fieldbyname('ProductName').asString;
    if Qry.findfield('SalesDescription')<> nil then aPartDescription:= Qry.fieldbyname('SalesDescription').asString
    else aPartDescription:= GetProductDescription (aPartsId);
  Except
    on E:Exception do begin
      Exit;
    end;
  end;

  if  (aPartsId=0) or ( aPartname = '') then Exit;

  vstProcessPart.Selected[vstProcessPart.Rootnode.FirstChild] := True;
  AddBranch(NodeData, newNode);
  OnSelectProduct(nil, nil, aPartsId,aPartname,aPartDescription, nodedata,newNode);
  vstProcessPart.Selected[newNode] := false;
end;

procedure TframeTree.dlgInfoUserButton1Click(Dialog: TwwMemoDlg; Memo: TMemo);
begin
  dlgInfoMemo := Memo;
  try
  OpenERPListFormSingleselectModal('TCommentsListGUI' , updatecomments);
  finally
    dlgInfoMemo := nil;
  end;
end;

procedure TframeTree.updatecomments(Sender: TwwDbGrid);
begin
  if dlgInfoMemo = nil then exit;
   logtext(dlgInfoMemo.Lines.Text);
   dlgInfoMemo.Lines.add(Sender.DataSource.DataSet.FieldByName('Comments').AsString);
   logtext(dlgInfoMemo.Lines.Text);
   Application.ProcessMessages;
end;
end.
