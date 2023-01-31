unit FrmChartofAccountsReportTree;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmChartOfAccountsTree, DB, ProgressDialog, MemDS, DBAccess,
  MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState, SelectionDialog,
  AppEvnts, Menus, ExtCtrls, VirtualTrees, StdCtrls, Shader, DNMSpeedButton,
  wwdbdatetimepicker, DNMPanel, ActiveX, BaseTreeView, VTEditControl , BusObjNDSBase,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, wwclearbuttongroup, wwradiogroup;

const
  WM_STARTEDITING = WM_USER + 101;


type

  TVTCOAReportTreeEditControl = class(TVTEditControlbase, IVTEditLink)
    Private
    Protected
      function getEditcontrol(aColumn: TColumnIndex): TEditControlType; Override;
    Public
      function BeginEdit  : Boolean; stdcall;
      function CancelEdit : Boolean; stdcall;
      function EndEdit    : Boolean; stdcall;
      function GetBounds  : TRect  ; stdcall;
      function PrepareEdit(Tree: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex): Boolean; stdcall;
      procedure ProcessMessage(var message: TMessage); stdcall;
      procedure SetBounds(R: TRect); stdcall;
  end;


  TFmChartofAccountsReportTree = class(TfmChartOfAccountsTree)
    qryAccAATAccountID: TIntegerField;
    qrySubAccAATAccountID: TIntegerField;
    btnSave: TDNMSpeedButton;
    qryAccShowinthereport: TWideStringField;
    qrySubAccShowinthereport: TWideStringField;
    qryAccreportCaption: TWideStringField;
    qrySubAccreportCaption: TWideStringField;
    mnuTree: TAdvPopupMenu;
    miAddBranch: TMenuItem;
    miDelete: TMenuItem;
    btnSelectAll: TDNMSpeedButton;
    btnUnSelectall: TDNMSpeedButton;
    Qryaccounts: TERPQuery;
    QryaccountsaccountId: TIntegerField;
    Qryaccountsaccountname: TWideStringField;
    qryAcccategory: TWideStringField;
    qryRootAcc: TERPQuery;
    qryRootAccAATAccountID: TIntegerField;
    qryRootAccAccountId: TIntegerField;
    qryRootAccAccountNumber: TWideStringField;
    qryRootAccAccountName: TWideStringField;
    qryRootAccBalance: TFloatField;
    qryRootAccActive: TWideStringField;
    qryRootAccLevel1: TWideStringField;
    qryRootAccLevel2: TWideStringField;
    qryRootAccLevel3: TWideStringField;
    qryRootAccLevel4: TWideStringField;
    qryRootAccTaxCode: TWideStringField;
    qryRootAccBSB: TWideStringField;
    qryRootAccBankAccountNumber: TWideStringField;
    qryRootAccDescription: TWideStringField;
    qryRootAccBankAccountName: TWideStringField;
    qryRootAccBankNumber: TWideStringField;
    qryRootAccTaxCodeDescription: TWideStringField;
    qryRootAccAccounttype: TWideStringField;
    qryRootAccShowinthereport: TWideStringField;
    qryRootAccreportCaption: TWideStringField;
    lblReportname: TLabel;
    qrySubAcccategory: TWideStringField;
    qryRootAcccategory: TWideStringField;
    procedure TreeDragAllowed(Sender: TBaseVirtualTree; Node: PVirtualNode;Column: TColumnIndex; var Allowed: Boolean);
    procedure TreeDragDrop(Sender: TBaseVirtualTree; Source: TObject;DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState;Pt: TPoint; var Effect: Integer; Mode: TDropMode);
    procedure TreeDragOver(Sender: TBaseVirtualTree; Source: TObject;Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode;var Effect: Integer; var Accept: Boolean);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TreeColumnClick(Sender: TBaseVirtualTree; Column: TColumnIndex;Shift: TShiftState);
    procedure TreeMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure TreeCreateEditor(Sender: TBaseVirtualTree; Node: PVirtualNode;Column: TColumnIndex; out EditLink: IVTEditLink);
    procedure TreeAfterCellPaint(Sender: TBaseVirtualTree;TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;CellRect: TRect);
    procedure TreeInitNode(Sender: TBaseVirtualTree; ParentNode,Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure TreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure TreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure TreeNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;Column: TColumnIndex; NewText: string);
    procedure miAddBranchClick(Sender: TObject);
    procedure miDeleteClick(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
    procedure btnUnSelectallClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qryAccBeforeOpen(DataSet: TDataSet);
    procedure qrySubAccBeforeOpen(DataSet: TDataSet);
    procedure TreeCollapsed(Sender: TBaseVirtualTree; Node: PVirtualNode);
  private
    FCurrentNode: PVirtualNode;
    FMouseButton: TMouseButton;
    FVTEditControl: TVTCOAReportTreeEditControl;
    FAppSettingCheckBox: Boolean;
    fScript :TERPScript;
    fiReportID: Integer;
    fiID:Integer;
    procedure HandleCheckBoxClick(Sender: TObject);
    procedure SaveNode(Parentnode, aNode: PVirtualnode);
    procedure SelectNode(Parentnode, aNode: PVirtualnode);
    procedure UnSelectNode(Parentnode, aNode: PVirtualnode);
    function ColIndextoName(const index: Integer): String;
    (*procedure Refreshcolumn(const Node: PVirtualNode;NodeData: PNodeRec; iIndex:Integer);*)
    procedure AddBranch(var NodeData: PNodeRec; var newNode: PVirtualNode);
    procedure WMStartEditing(var Msg: TMessage); message WM_STARTEDITING;
    procedure SetReportID(const Value: Integer);
    procedure DeselectAllchild(aNode: PVirtualNode);
    Procedure SelectAllParent(aNode:PVirtualNode);
    function accountID(const AccountName: String): Integer;
    function GetRootAccounts(const AccountName: string;
      const aParentNode: PVirtualNode): double;
    procedure DisplayCheckBoxes(const Node: PVirtualNode; Expanded: Boolean; const Visible: Boolean = False);
    function NewId: Integer;
  Protected
    Procedure ConfigureTree;Override;
    procedure RefreshNode(RecordRec: PNodeRec; qry: TERPQuery);Override;
    procedure InitTreenodesize; Override;
    function getColumnByname(Columnname: String): String;Override;
    procedure RefreshTree; override;
  public
    constructor Create(AOwner: TComponent); override;
    Property ReportID:Integer read fiReportID write SetReportID;
  end;


implementation

uses CommonLib, LogUtils, LogLib, SystemLib, DbSharedObjectsObj, CommonDbLib,
  AppEnvironment, tcConst;
const
  cCOATreecolumncount = 23;
  cReportCaption      = 19;
  cshowInthereport    = 20;
  cAATAccountID       = 21;
  cCategory           = 22;
  cHalfCheckBoxWidth = 8;
  cCOAReportTreeColumnControls: array [0 .. cCOATreecolumncount - 1] of TEditControlType =
      (              (*cName*)ectNone,
                (*cAccountNo*)ectNone,
              (*cTypeBalance*)ectNone,
                  (*cLevel1 *)ectNone,
                  (*cLevel2 *)ectNone,
                  (*cLevel3 *)ectNone,
                  (*cLevel4 *)ectNone,
              (*cAccBalance *)ectNone,
              (*cTotBalance *)ectNone,
                  (*cTaxCode*)ectNone,
      (*cTaxCodeDescription *)ectNone,
                      (*cBSB*)ectNone,
                (*cBankAccNo*)ectNone,
              (*cDescription*)ectNone,
          (*cBankAccountName*)ectNone,
              (*cBankNumber *)ectNone,
                  (*cActive *)ectNone,
              (*cAccountType*)ectNone,
                (*cSortOrder*)ectNone,
            (*cReportCaption*)ectEdit,
          (*cshowInthereport*)ectNone,
             (*cAATAccountID*)ectNone,
                 (*cCategory*)ectNone{,
                 (*cLevel1ID*)ectNone,
                 (*cLevel2ID*)ectNone,
                 (*cLevel3ID*)ectNone,
                 (*cLevel4ID*)ectNone});
  cCOAReportcheckboxes = 1;
  cshowInthereportCheckbox = 0;

{$R *.dfm}


procedure TFmChartofAccountsReportTree.DisplayCheckBoxes(const Node: PVirtualNode; Expanded: Boolean; const Visible: Boolean = False);
var
  ChildNode: PVirtualNode;

  procedure DoHide(const Node: PVirtualNode);
  var
    index: Integer;
    NodeData: PNodeRec;
  begin
    NodeData := TRee.GetNodeData(Node);

    if Assigned(NodeData) then begin
      try
        for index := 0 to cCOAReportcheckboxes - 1 do NodeData.CheckBoxes[index].Visible := Expanded and Visible;
      Except
      //
      end;
    end;
  end;

begin
  try
    if (not Expanded) then DoHide(Node);

    ChildNode := Node.FirstChild;

    while Assigned(ChildNode) do begin
      Expanded := Expanded and Tree.Expanded[Node];

      if Assigned(ChildNode.FirstChild) then DisplayCheckBoxes(ChildNode, Expanded, Visible);

      if (not Expanded) then DoHide(ChildNode);

      ChildNode := ChildNode.NextSibling;
    end;
  except
    on E: Exception do begin
      LogD('TframeTree.DisplayCheckBoxes - Exception: ' + E.Message);
      raise;
    end;
  end;
end;


procedure TFmChartofAccountsReportTree.SelectAllParent(aNode: PVirtualNode);
var
    pParent : PVirtualNode;
    ParentNodeData: PNodeRec;
begin
      pParent := anode.Parent;
      While Assigned(pParent) do begin
          ParentNodedata := Tree.GetNodeData(pParent);
          try
            ParentNodedata^.Data.CellData[cshowinthereport].Value :=checkboxTrueValue;
            ParentNodedata.checkboxes[cshowInthereportCheckbox].Checked := True;
          Except
          end;
          pParent := pParent.Parent;
      end;
end;

procedure TFmChartofAccountsReportTree.SelectNode(Parentnode, aNode: PVirtualnode);
var
  NodeData: PNodeRec;
begin
   NodeData := Tree.GetNodeData(aNode);
   NodeData^.Data.Celldata[cshowinthereport].Value := CheckBoxTrueValue;
   NodeData.CheckBoxes[cshowInthereportCheckbox].Checked   := True;
end;
procedure TFmChartofAccountsReportTree.UnSelectNode(Parentnode, aNode: PVirtualnode);
var
  NodeData: PNodeRec;
begin
   NodeData := Tree.GetNodeData(aNode);
   NodeData^.Data.Celldata[cshowinthereport].Value := CheckBoxFalseValue;
   NodeData.CheckBoxes[cshowInthereportCheckbox].Checked   := False;
end;
function TFmChartofAccountsReportTree.accountID(Const AccountName:String):Integer;
begin
  result :=0;
  if Qryaccounts.locate('accountname', accountname, []) then
    result := QryaccountsAccountID.asInteger;
end;
procedure TFmChartofAccountsReportTree.SaveNode(Parentnode, aNode: PVirtualnode);
var
  NodeData: PNodeRec;
  pParent: PVirtualNode;
  ParentNodeData: PNodeRec;
  s:String;
begin
   NodeData := Tree.GetNodeData(aNode);
   //if not (NodeData^.Data.Celldata[cshowinthereport].Value=checkboxTrueValue) then exit; // only save if the account is selected to show in the report
   s:= 'insert ignore into tblChartofAccountsReportTree  Set '+
                    ' AccountId       = ' + inttostr(NodeData^.Data.ID)                               +',' +
                    ' REportID        = ' + inttostr(ReportID)                                        +',' +
                    ' Category        = ' + quotedstr((*iif(IsAccTypeNode(NodeData) , 'AT' , 'COA')*)NodeData^.Data.Celldata[cCategory].Value)    +',' +
                    ' ReportCaption   = ' + quotedstr(iif(NodeData^.Data.Celldata[cReportCaption].Value='' , NodeData^.Data.Celldata[cName].Value, NodeData^.Data.Celldata[cReportCaption].Value))  +',' +
                    ' showinthereport = ' + quotedstr(iif(NodeData^.Data.Celldata[cshowinthereport].Value=checkboxTrueValue , 'T','F'))+',' +
                    ' Level1ID = ' + inttostr(AccountID(NodeData^.Data.Celldata[cLevel1].Value))                  +',' +
                    ' Level2ID = ' + inttostr(AccountID(NodeData^.Data.Celldata[cLevel2].Value))                  +',' +
                    ' Level3ID = ' + inttostr(AccountID(NodeData^.Data.Celldata[cLevel3].Value))                  +',' +
                    ' Level4ID = ' + inttostr(AccountID(NodeData^.Data.Celldata[cLevel4].Value))                  +',' +
                    ' SortOrder       = ' + inttostr(IterateNodeNo);
  pParent := aNode.Parent;
  if Assigned(pParent) then begin
    ParentNodedata := Tree.GetNodeData(pParent);
    if Assigned(ParentNodedata) then
      s:= s + ', ParentID = ' + inttostr(ParentNodedata^.Data.ID)+
            ', ParentCategory = ' + quotedstr((*iif(IsAccTypeNode(ParentNodeData) , 'AT' , 'COA')*)ParentNodedata^.Data.Celldata[cCategory].Value);
  end;
  s:= s+';';
  fScript.SQL.Add(s);
end;

procedure TFmChartofAccountsReportTree.SetReportID(const Value: Integer);
begin
  fiReportID := Value;
  QryAcc.ParamByName('ReportID').AsInteger := value;
  qrySubAcc.ParamByName('ReportID').AsInteger := value;
  lblReportname.Caption := 'Choose Accounts for Report ' +Quotedstr(AppEnv.AccessLevels.GetFormDescription(Value));
  lblReportname.visible := True;
end;

procedure TFmChartofAccountsReportTree.btnSaveClick(Sender: TObject);
begin
  inherited;
  fScript := DbSharedObj.GetScript(GetSharedMyDacConnection);
  try
    fScript.SQL.Clear;
    fScript.SQL.Add('Delete from  tblChartofAccountsReportTree where reportID = ' + inttostr(ReportID) +';');
    IterateTree(cname, SaveNode);
    clog(fScript.SQL.Text);
    fScript.Execute;
    Self.close;
  finally
    DbSharedObj.ReleaseObj(fScript);
  end;
end;

procedure TFmChartofAccountsReportTree.btnSelectAllClick(Sender: TObject);
begin
  inherited;
  IterateTree(cname, SelectNode);
end;

procedure TFmChartofAccountsReportTree.btnUnSelectallClick(Sender: TObject);
begin
  inherited;
  IterateTree(cname, unSelectNode);
end;

procedure TFmChartofAccountsReportTree.ConfigureTree;
begin
  inherited;
  AddColumn('Report Caption', vtString, 250);     // 19
  AddColumn('Show In the Report', vtString, 150); // 20
  AddColumn('Report AccountID', vtString, 50);    // 21
  AddColumn('Category', vtString, 50);    // 21
end;

constructor TFmChartofAccountsReportTree.Create(AOwner: TComponent);
begin
  inherited;
  FCurrentNode := nil;
  FMouseButton := mbLeft;
  FVTEditControl := nil;
  FAppSettingCheckBox := False;
end;

procedure TFmChartofAccountsReportTree.FormCreate(Sender: TObject);
begin
  inherited;
  fiID := 0;
  if devmode then Self.WindowState := wsMaximized;
  //Tree.TreeOptions.SelectionOptions := Tree.TreeOptions.SelectionOptions + [toFullRowSelect];
  With Tree.Header do begin
    Unhidecolumn(cName);Columns[cName].Alignment            := taLeftJustify;
    Unhidecolumn(cAccountNo);Columns[cAccountNo].Alignment  := taLeftJustify;
    Hidecolumn(cTypeBalance);
    if not devmode then begin
      Hidecolumn(cLevel1);
      Hidecolumn(cLevel2);
      Hidecolumn(cLevel3);
      Hidecolumn(cLevel4);
    end else begin
      Unhidecolumn(cLevel1);
      Unhidecolumn(cLevel2);
      Unhidecolumn(cLevel3);
      Unhidecolumn(cLevel4);
    end;
    Hidecolumn(cAccBalance);
    Hidecolumn(cTotBalance);
    Hidecolumn(cTaxCode);
    Hidecolumn(cTaxCodeDescription);
    Hidecolumn(cBSB);
    Hidecolumn(cBankAccNo);
    Hidecolumn(cDescription);
    Hidecolumn(cBankAccountName);
    Hidecolumn(cBankNumber);
    Hidecolumn(cActive);
    Hidecolumn(cAccountType);
    Hidecolumn(cSortOrder);
    Hidecolumn(cAATAccountID);
    Hidecolumn(cCategory);
    Hidecolumn(cshowInthereport);
    Hidecolumn(cshowinthereport);
    unHidecolumn(cReportCaption);
    unHidecolumn(cshowinthereport);
    Columns[cReportCaption].Alignment   := taLeftJustify;
    Columns[cshowinthereport].Alignment := taCenter;
    columns[cReportCaption].Options     := [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption];
    columns[cshowinthereport].Options   := [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption];
  end;
end;

procedure TFmChartofAccountsReportTree.FormShow(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  openQueries;
end;

function TFmChartofAccountsReportTree.getColumnByname(Columnname: String): String;
var
  Rec: PNodeRec;
begin
  REsult:= '';
  rec:= tree.Getnodedata(Tree.GetFirstSelected);
  if REc.Data.ByName[Columnname] <> nil then
    Result:= REc.Data.ByName[Columnname].asString;

end;

procedure TFmChartofAccountsReportTree.HandleCheckBoxClick(Sender: TObject);
var
  Node: PVirtualNode;
  NodeData: PNodeRec;
begin
  try
    Node:= nil;
    if (Sender is TCheckBox) and (not FAppSettingCheckBox) then begin
      Node := Ptr(TCheckBox(Sender).Tag);
      NodeData := Tree.GetNodeData(Node);
      Tree.EndEditNode;

      if Assigned(NodeData) then begin
        if Sender = NodeData.checkboxes[cshowInthereportCheckbox] then begin
          NodeData.Data.CellData[cshowInthereport].Value := iif(TCheckBox(Sender).Checked , CheckBoxTrueValue, CheckBoxFalseValue);
        end;
      end;
    end;

    if not(TCheckBox(Sender).Checked) then
      DeselectAllchild(Node)
    else SelectallParent(Node);

  except
    on E: Exception do begin
      LogD('TframeTree.HandleCheckBoxClick - Exception: ' + E.Message);
      raise;
    end;
  end;
end;
procedure TFmChartofAccountsReportTree.DeselectAllchild(aNode: PVirtualNode);
begin
  IterateTree(cname, aNode, unSelectNode);
end;
procedure TFmChartofAccountsReportTree.InitTreenodesize;
begin
  inherited;
    //Tree.NodeDataSize := SizeOf(PCOAReportTreeNodeRec);
end;


procedure TFmChartofAccountsReportTree.miAddBranchClick(Sender: TObject);
var
  NodeData: PNodeRec;
  newNode: PVirtualNode;
begin
  AddBranch(NodeData,newNode);
  Tree.Refresh;
end;
procedure TFmChartofAccountsReportTree.miDeleteClick(Sender: TObject);
var
  Node: PVirtualNode;
begin
  try
    Tree.CancelEditNode;
    Node := Tree.GetFirstSelected;
    if node = Tree.RootNode.FirstChild then Exit;

      if Node.ChildCount > 0 then
        if CommonLib.MessageDlgXP_Vista('This item has branches which will also be deleted. Continue?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;
        Tree.DeleteNode(Node);
      self.Tree.Refresh;
  except
    on E: Exception do begin
      LogD('TframeTree.miDeleteClick - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TFmChartofAccountsReportTree.qryAccBeforeOpen(DataSet: TDataSet);
begin
try
  inherited;
Except
  // kill the exception for regionid parameter
end;

end;

procedure TFmChartofAccountsReportTree.qrySubAccBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qrySubAcc.ParamByName('ReportID').AsInteger := ReportID;
end;
function TFmChartofAccountsReportTree.NewId:Integer;
var
  Qry:TERPQuery;
begin
  if fiID =0 then begin
      Qry := DbSharedObj.GetQuery(GetSharedMyDacConnection);
      try
        Qry.SQL.Clear;
        Qry.SQL.Add('Select Min(AccountID) AccountID from  tblChartofAccountsReportTree where reportID = ' + inttostr(ReportID) +';');
        Qry.Open;
        if Qry.FieldByName('AccountID').AsInteger >=0 then fiID := 0 else fiId :=Qry.FieldByName('AccountID').AsInteger;
        Qry.close;
      finally
        DbSharedObj.ReleaseObj(Qry);
      end;
  end;
  fiId := fiId -1 ;
  result := fiId;
end;
procedure TFmChartofAccountsReportTree.AddBranch(var NodeData: PNodeRec; var newNode: PVirtualNode);
var
  ParentNode: PVirtualNode;
  ParentNodeData: PNodeRec;
begin
  try
    ParentNode := Tree.GetFirstSelected;    ParentNodeData := Tree.GetNodeData(parentNode);

    newNode := Tree.AddChild(ParentNode);
    Tree.Expanded[Tree.GetFirstSelected] := True;
    //Tree.Selected[newNode] := True;
    NodeData := Tree.GetNodeData(newNode);
    REfreshnode(NodeData, nil);
    NodeData^.Data.CellData[cName].Value := '<New>';
    NodeData^.Data.CellData[cCategory].Value := 'BR';
    NodeData.Data.KeyStr := 'BR';
    NodeData^.Data.ID := NewId;


      NodeData^.Data.CellData[cLevel4].Value := ParentNodeData^.Data.CellData[cLevel4].Value;
      NodeData^.Data.CellData[cLevel3].Value := ParentNodeData^.Data.CellData[cLevel3].Value;
      NodeData^.Data.CellData[cLevel2].Value := ParentNodeData^.Data.CellData[cLevel2].Value;
      NodeData^.Data.CellData[cLevel1].Value := ParentNodeData^.Data.CellData[cLevel1].Value;

               if NodeData^.Data.CellData[cLevel1].Value = '' then begin NodeData^.Data.CellData[cLevel1].Value := NodeData^.Data.CellData[cName].Value;
      end else if NodeData^.Data.CellData[cLevel2].Value = '' then begin NodeData^.Data.CellData[cLevel2].Value := NodeData^.Data.CellData[cName].Value;
      end else if NodeData^.Data.CellData[cLevel3].Value = '' then begin NodeData^.Data.CellData[cLevel3].Value := NodeData^.Data.CellData[cName].Value;
      end else if NodeData^.Data.CellData[cLevel4].Value = '' then begin NodeData^.Data.CellData[cLevel4].Value := NodeData^.Data.CellData[cName].Value;
      end;

  except
    on E: Exception do begin
      LogD('TframeTree.miAddBranchClick - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

(*procedure TFmChartofAccountsReportTree.Refreshcolumn(const Node: PVirtualNode; NodeData: PNodeRec; iIndex: Integer);
begin
  NodeData.Captions[iIndex]  :=  NodeData^.Data.CellData[iIndex].Value;
end;*)

procedure TFmChartofAccountsReportTree.RefreshNode(RecordRec: PNodeRec;  qry: TERPQuery);
begin
  try
    inherited RefreshNode(RecordRec , Qry);
    if qry <> nil then begin
      RecordRec^.Data.CellData[cshowInthereport].Value         := Qry.FieldByName('Showinthereport').asString;
      RecordRec^.Data.CellData[creportCaption].Value           := iif(trim(Qry.FieldByName('reportCaption').asString) = '' , Qry.FieldByName('AccountName').asString , Qry.FieldByName('reportCaption').asString);
      RecordRec^.Data.CellData[cAATAccountID].Value            := qry.FieldByName('AATAccountID').AsString;
      RecordRec^.Data.CellData[cCategory].Value                := qry.FieldByName('Category').AsString;
    end else begin
      RecordRec^.Data.CellData[cshowInthereport].Value         := CheckBoxFalseValue;
      RecordRec^.Data.CellData[creportCaption].Value           := RecordRec^.Data.CellData[cName].Value;
      RecordRec^.Data.CellData[cAATAccountID].Value            := '0';
      RecordRec^.Data.CellData[cCategory].Value                := '';
    end;
Except
    on E: Exception do begin
      if devmode then
        MessageDlgXP_Vista('TFmChartofAccountsReportTree.RefreshNode - Exception: ' + E.Message, mtWarning, [mbOK], 0);
    end;
  end;
end;
function TFmChartofAccountsReportTree.GetRootAccounts(const AccountName: string; const aParentNode: PVirtualNode): double;
var
  Rec: PNodeRec;
  aNode: PVirtualNode;
begin
      REsult := 0;
      try
        closedb(qryRootAcc);
        qryRootAcc.ParamByName('Parent').AsString     := AccountName;
        qryRootAcc.ParamByName('ActiveStr').AsString  := GrpFilters.Items[grpFilters.ItemIndex];
        qryRootAcc.ParamByName('xRegionID').AsInteger := AppEnv.RegionalOptions.ID;
        qryRootAcc.ParamByName('ReportID').AsInteger := ReportID;
        qryRootAcc.open;
      Except
        on E:Exception do begin
          MessageDlgXP_Vista(e.message, mtWarning, [mbOK], 0);
        end;
      end;
      try
        if qryRootAcc.Recordcount =0 then exit;
        qryRootAcc.first;
        while not qryRootAcc.Eof do begin
              aNode:= Tree.AddChild(aParentNode);
              Rec := Tree.GetNodeData(aNode);
              RefreshNode(rec, qryRootAcc);
              REsult := GetSubAccounts(qryRootAcc.fieldbyname('accountNAme').asString, aNode);
              qryRootAcc.Next;
        end;
      finally
        closedb(qryRootAcc);
      end;
end;
procedure TFmChartofAccountsReportTree.RefreshTree;
var
  Rec: PNodeRec;
  aNode: PVirtualNode;
begin
      Tree.Clear;
      try
        qryAcc.ParamByName('ReportID').asInteger := ReportID;
        qryAcc.open;
      Except
        on E:Exception do begin
          MessageDlgXP_Vista(e.message, mtWarning, [mbOK], 0);
        end;
      end;
      DoShowProgressbar(qryAcc.recordcount+1, WAITMSG);
      try
        qryAcc.first;
        while not qryAcc.Eof do begin
            DoStepProgressbar(qryAcc.fieldbyname('accountNAme').asString);
            aNode:= Tree.AddChild(nil);
            Rec := Tree.GetNodeData(aNode);
            RefreshNode(rec, qryAcc);
            Rec^.Data.KeyStr := 'AccType:' + IntToStr(Rec^.Data.Id);  // a unique key for this node
            GetRootAccounts(qryAcc.fieldbyname('accountNAme').asString, aNode);
            qryAcc.Next;
        end;
      finally
        DoHideProgressbar;
      end;
end;

procedure TFmChartofAccountsReportTree.TreeAfterCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;Column: TColumnIndex; CellRect: TRect);
var
  DisplayRect: TRect;
  MidPoint: Integer;
  NodeData: PNodeRec;
begin
  inherited;
    if Column = cshowInthereport then begin
            NodeData := Sender.GetNodeData(Node);
            //if IsAccTypeNode(NodeData) then exit;
            TargetCanvas.FillRect(CellRect);
            DisplayRect := Sender.GetDisplayRect(Node, Column, False, True);
            DisplayRect.Top := DisplayRect.Top + cshowInthereportCheckbox;
            DisplayRect.Bottom := DisplayRect.Bottom - cshowInthereportCheckbox;
            MidPoint := ((DisplayRect.Right - DisplayRect.Left) div 2) + DisplayRect.Left;
            DisplayRect.Left := MidPoint - cHalfCheckBoxWidth;
            DisplayRect.Right := MidPoint + cHalfCheckBoxWidth;
            NodeData.checkboxes[cshowInthereportCheckbox].BoundsRect := DisplayRect;
            NodeData.checkboxes[cshowInthereportCheckbox].Enabled := true;
            //NodeData.checkboxes[cshowInthereportCheckbox].Visible := TRue;
            NodeData.checkboxes[cshowInthereportCheckbox].Show;
    end;
end;

procedure TFmChartofAccountsReportTree.TreeCollapsed(Sender: TBaseVirtualTree;Node: PVirtualNode);
begin
  inherited;
  try
    DisplayCheckBoxes(Sender.RootNode, True);
  except
    on E: Exception do begin
      LogD('TframeTree.vstProcessPartCollapsed - Exception: ' + E.Message);
      raise;
    end;
  end;

end;

procedure TFmChartofAccountsReportTree.TreeColumnClick(Sender: TBaseVirtualTree;  Column: TColumnIndex; Shift: TShiftState);
begin
  inherited;
  try
    if Column in [cshowInthereport , cReportCaption] then PostMessage(Handle, WM_STARTEDITING, Integer(FCurrentNode), Column);
  except
    on E: Exception do begin
      LogD('TframeTree.TreeColumnClick - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TFmChartofAccountsReportTree.TreeCreateEditor(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;out EditLink: IVTEditLink);
begin
  inherited;
  try
    FVTEditControl := TVTCOAReportTreeEditControl.Create;
    FVTEditControl.ControlType := cCOAReportTreeColumnControls[Column];

    case FVTEditControl.ControlType of
      ectEdit: begin
          FVTEditControl.Edit.Parent := Sender;
      end;
      ectComboBox: begin
          FVTEditControl.ComboBox.Parent := Sender;
      end;
      ectCheckbox : begin
          FVTEditControl.checkbox.Parent := Sender;
          FVTEditControl.checkbox.Show;
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
        end;
    end;
    EditLink := FVTEditControl;
  except
    on E: Exception do begin
      LogD('TframeTree.TreeCreateEditor - Exception: ' + E.Message);
      raise;
    end;
  end;

end;

procedure TFmChartofAccountsReportTree.TreeDragAllowed(Sender: TBaseVirtualTree;Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
var
  ParentNodeData, sourceNodeData: PNodeRec;
begin
  inherited;
  sourceNodeData := Tree.GetNodeData(Node);
  ParentNodedata := Tree.GetNodeData(Node.Parent);
       if not(Assigned(ParentNodedata)) and not(sametext(sourceNodeData^.Data.CellData[cCategory].Value , 'AT') ) then
        Allowed:= False
  else if Assigned(ParentNodedata) and sametext(sourceNodeData^.Data.CellData[cCategory].Value , 'AT')  then
        Allowed:= False
  //if sametext(sourceNodeData^.Data.CellData[cCategory].Value , 'AT') then Allowed:= False
  else
        Allowed:= True;
end;

procedure TFmChartofAccountsReportTree.TreeDragDrop(Sender: TBaseVirtualTree;Source: TObject; DataObject: IDataObject; Formats: TFormatArray;Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
  pParent, pSource, pTarget: PVirtualNode;
  attMode: TVTNodeAttachMode;
  ParentNodeData, sourceNodeData, targetNodeData: PNodeRec;
begin
  pSource := TVirtualStringTree(Source).FocusedNode;
  pTarget := Sender.DropTargetNode;


  case Mode of
    dmNowhere: attMode := amNoWhere;
    dmAbove: attMode := amInsertBefore;
    dmOnNode, dmBelow: attMode := amInsertAfter;
    else exit;
  end;

  Sender.MoveTo(pSource, pTarget, attMode, False);
  sourceNodeData := Tree.GetNodeData(pSource);

  sourceNodeData^.Data.CellData[cLevel4].Value := '';
  sourceNodeData^.Data.CellData[cLevel3].Value := '';
  sourceNodeData^.Data.CellData[cLevel2].Value := '';
  sourceNodeData^.Data.CellData[cLevel1].Value := '';
  sourceNodeData^.Data.CellData[cLevel1].Value := sourceNodeData^.Data.CellData[cName].Value;

  pParent := pSource.Parent;
  if Assigned(pParent) then begin
    ParentNodedata := Tree.GetNodeData(pParent);
    if Assigned(ParentNodedata) then begin
      TargetNodeData := Tree.GetNodeData(pTarget);

      if not(sametext(TargetNodeData^.Data.CellData[cLevel4].Value , TargetNodeData^.Data.CellData[cName].Value)) then begin sourceNodeData^.Data.CellData[cLevel4].Value := TargetNodeData^.Data.CellData[cLevel4].Value;end;
      if not(sametext(TargetNodeData^.Data.CellData[cLevel3].Value , TargetNodeData^.Data.CellData[cName].Value)) then begin sourceNodeData^.Data.CellData[cLevel3].Value := TargetNodeData^.Data.CellData[cLevel3].Value;end;
      if not(sametext(TargetNodeData^.Data.CellData[cLevel2].Value , TargetNodeData^.Data.CellData[cName].Value)) then begin sourceNodeData^.Data.CellData[cLevel2].Value := TargetNodeData^.Data.CellData[cLevel2].Value;end;
      if not(sametext(TargetNodeData^.Data.CellData[cLevel1].Value , TargetNodeData^.Data.CellData[cName].Value)) then begin sourceNodeData^.Data.CellData[cLevel1].Value := TargetNodeData^.Data.CellData[cLevel1].Value;end;

               if sourceNodeData^.Data.CellData[cLevel1].Value = '' then begin sourceNodeData^.Data.CellData[cLevel1].Value := sourceNodeData^.Data.CellData[cName].Value;
      end else if sourceNodeData^.Data.CellData[cLevel2].Value = '' then begin sourceNodeData^.Data.CellData[cLevel2].Value := sourceNodeData^.Data.CellData[cName].Value;
      end else if sourceNodeData^.Data.CellData[cLevel3].Value = '' then begin sourceNodeData^.Data.CellData[cLevel3].Value := sourceNodeData^.Data.CellData[cName].Value;
      end else if sourceNodeData^.Data.CellData[cLevel4].Value = '' then begin sourceNodeData^.Data.CellData[cLevel4].Value := sourceNodeData^.Data.CellData[cName].Value;
      end;

      {if dropped node is checked then check all its parents}
      if sourceNodeData.checkboxes[cshowInthereportCheckbox].Checked  then
        SelectAllParent(pSource);
    end;
  end;
  if (Effect = DROPEFFECT_MOVE) then begin
    DisplayCheckBoxes(pSource, False, False);
  end;

end;

procedure TFmChartofAccountsReportTree.TreeDragOver(Sender: TBaseVirtualTree;Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint;Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
begin
  inherited;
   Accept := (Source = Sender);
end;
procedure TFmChartofAccountsReportTree.TreeFreeNode(Sender: TBaseVirtualTree;  Node: PVirtualNode);
var
  index: Integer;
  NodeData: PNodeRec;
begin
  try
    NodeData := Sender.GetNodeData(Node);

    for index := 0 to cCOAReportcheckboxes-1 do NodeData.CheckBoxes[index].Free;

    Finalize(NodeData^);
  except
    on E: Exception do begin
      LogD('TframeTree.vstProcessPartFreeNode - Exception: ' + E.Message);
      raise;
    end;
  end;
end;
Function TFmChartofAccountsReportTree.ColIndextoName(const index:Integer):String;
begin
           if index = cName               Then Result := 'Account Name'
      else if index = cAccountNo          Then Result := 'Account NO'
      else if index = cTypeBalance        Then Result := 'Type Balance'
      else if index = cLevel1             Then Result := 'Level1'
      else if index = cLevel2             Then Result := 'Level2'
      else if index = cLevel3             Then Result := 'Level3'
      else if index = cLevel4             Then Result := 'Level4'
      else if index = cAccBalance         Then Result := 'Acc Balance'
      else if index = cTotBalance         Then Result := 'Total Balance'
      else if index = cTaxCode            Then Result := 'Tax Code'
      else if index = cTaxCodeDescription Then Result := 'Tax Desc'
      else if index = cBSB                Then Result := 'BSB'
      else if index = cBankAccNo          Then Result := 'back Acc No'
      else if index = cDescription        Then Result := 'Description'
      else if index = cBankAccountName    Then Result := 'Bacnk Acc Name'
      else if index = cBankNumber         Then Result := 'Bank Number'
      else if index = cActive             Then Result := 'Active'
      else if index = cAccountType        Then Result := 'Account Type'
      else if index = cSortOrder          Then Result := 'sort Order'
      else if index = cReportCaption      Then Result := 'Report Caption'
      else if index = cshowInthereport    Then Result := 'Show in the report'
      else if index = cAATAccountID       then Result := 'AAt AccountId'
      else Result := '';

end;
procedure TFmChartofAccountsReportTree.TreeGetText(Sender: TBaseVirtualTree;Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;var CellText: string);
var
  NodeData: PNodeRec;
begin
  if Column < 0 then Exit;
  inherited;
  if column = cShowinthereport then begin
    NodeData := Sender.GetNodeData(Node);
  end;
end;

procedure TFmChartofAccountsReportTree.TreeInitNode(Sender: TBaseVirtualTree;  ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  index: Integer;
  NodeData: PNodeRec;
  //ParentNodeData: PNodeRec;
begin
  try
    //ParentNode := nil;
    if (Sender is TVirtualStringTree) then begin
      NodeData := Sender.GetNodeData(Node);
      //ParentNodeData:= Sender.GetNodeData(ParentNode);

      if Assigned(NodeData) then begin
        //if IsAccTypeNode(NodeData) then exit;
        Setlength(NodeData.Captions, TVirtualStringTree(Sender).Header.Columns.Count);
        Setlength(NodeData.CheckBoxes, cCOAReportcheckboxes);

        for index := 0 to cCOAReportcheckboxes-1 do begin
          NodeData.CheckBoxes[index] := TCheckBox.Create(self);
          NodeData.CheckBoxes[index].Hide;
          NodeData.CheckBoxes[index].Tag := Integer(Node);
          NodeData.CheckBoxes[index].OnClick := HandleCheckBoxClick;
          NodeData.CheckBoxes[index].Parent := Sender;
        end;

        FAppSettingCheckBox := True;
        try
          NodeData.checkboxes[cshowInthereportCheckbox].Checked := NodeData^.Data.CellData[cshowinthereport].Value =CheckBoxTrueValue;
        Except
          //
        end;

        //NodeData.CheckBoxes[index].show;
        FAppSettingCheckBox := False;
      end;
    end;
  except
    on E: Exception do begin
      if devmode then
        MessageDlgXP_Vista('TframeTree.TreeInitNode - Exception: ' + E.Message, mtWarning, [mbOK], 0);
      raise;
    end;
  end;
end;

procedure TFmChartofAccountsReportTree.TreeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  try
    FMouseButton := Button;
    FCurrentNode := Tree.GetNodeAt(X, Y);

    if Button = mbRight then begin
      Tree.Selected[FCurrentNode] := True;
    end;
    Application.ProcessMessages;
  except
    on E: Exception do begin
      LogD('TframeTree.TreeMouseDown - Exception: ' + E.Message);
      raise;
    end;
  end;

end;

procedure TFmChartofAccountsReportTree.TreeNewText(Sender: TBaseVirtualTree;Node: PVirtualNode; Column: TColumnIndex; NewText: string);
var
  NodeData: PNodeRec;
begin
  inherited;
  try
    NodeData := Sender.GetNodeData(Node);
    NodeData.Captions[Column] := NewText;
    case Column of
      cReportCaption: begin
          NodeData^.Data.CellData[cReportCaption].Value := NewText;
        end;
      cshowInthereport: begin
          NodeData^.Data.CellData[cshowInthereport].Value := BooleanToStr(NodeData.checkboxes[cshowInthereportCheckbox].Checked);
        end;
    end;
  Except
    on E: Exception do begin
      LogD('TframeTree.vstProcessPartNewText - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

procedure TFmChartofAccountsReportTree.WMStartEditing(var Msg: TMessage);
var
  Node: PVirtualNode;
begin
  try
    Node := Pointer(Msg.WParam);

    if Assigned(Node) then Tree.EditNode(Node, Msg.lParam);
  except
    on E: Exception do begin
      LogD('TframeTree.WMStartEditing - Exception: ' + E.Message);
      raise;
    end;
  end;

end;


function TVTCOAReportTreeEditControl.getEditcontrol(aColumn: TColumnIndex): TEditControlType;
begin
    Result := cCOAReportTreeColumnControls[aColumn];
end;

function TVTCOAReportTreeEditControl.BeginEdit  : Boolean;
begin
    Result := not FStopping;
    if not result then exit;

    Result := DoBeginEdit;
    if not result then exit;

    if Result then begin
      case ControlType of
        ectEdit: begin
          FEdit.Show;
          if fcolumn = cReportCaption then begin
            FEdit.Enabled := True;
            FEdit.SelectAll;
            SetControlFocus(FEdit);
          end else begin
            FEdit.Enabled := False;
            SetControlFocus(FEdit);
          end;
        end;
        ectCheckBox: begin
          FCheckBox.Show;
          //if fcolumn = cshowInthereport then begin
            FCheckBox.Enabled := True;
            SetControlFocus(FCheckBox);
          //end;
        end;
      end;
    end;
end;

function TVTCOAReportTreeEditControl.CancelEdit : Boolean;
begin
  result := DoCancelEdit;
end;

function TVTCOAReportTreeEditControl.EndEdit    : Boolean;
(*var
  NodeData: PNodeRec;*)
begin
  try
    //NodeData := nil;
    Result := not FStopping;

    if Result then begin
      try
        FStopping := True;

        case ControlType of
          ectEdit: begin
              (*NodeData := FTree.GetNodeData(FNode);*)
              FTree.Text[FNode, FColumn] := FEdit.Text;
              FEdit.Hide;
          end;
        end;

      finally
        FStopping := False;
      end;
    end;
  except
    on E: Exception do begin
      LogD('TVTEditControlBase.DoEndEdit - Exception: ' + E.Message);
      raise;
    end;
  end;
end;

function TVTCOAReportTreeEditControl.GetBounds  : TRect  ;
begin
  result := DoGetBounds;
end;

function TVTCOAReportTreeEditControl.PrepareEdit(Tree: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex): Boolean;
begin
  result := DoPrepareEdit(Tree, node, column);
end;

procedure TVTCOAReportTreeEditControl.ProcessMessage(var message: TMessage);
begin
  DoProcessMessage(Message);
end;

procedure TVTCOAReportTreeEditControl.SetBounds(R: TRect);
begin
  DoSetBounds(R);
end;


initialization
  RegisterClassOnce(TFmChartofAccountsReportTree);

end.
