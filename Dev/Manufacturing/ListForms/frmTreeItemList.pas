unit frmTreeItemList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseTreeView, Menus, AdvMenus, DataState, DB, DBAccess,
  MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, Shader, StdCtrls,
  wwdbdatetimepicker, VirtualTrees, DNMSpeedButton, ExtCtrls, DNMPanel,
  ImgList, MemDS, ProgressDialog;

type
  TfmTreeItemList = class(TBaseTreeViewGUI)
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdPrintClick(Sender: TObject);
  private
    SearchNodeId: string;
    SearchFoundNode: PVirtualNode;
    procedure SearchCallback(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: boolean);
  protected
    procedure RefreshTree; override;
  public
    { Public declarations }
  end;

var
  fmTreeItemList: TfmTreeItemList;

implementation

{$R *.dfm}

uses
  CommonDbLib, CommonLib, FastFuncs ;

{ TfmTreeItemList }

procedure TfmTreeItemList.RefreshTree;
var
  qry: TERPQuery;
  Node, RootNode, SaleNode, SaleLineNode, tempNode, itemNode: PVirtualNode;
  LastSaleId, LastSaleLineId: integer;
  Rec: PNodeRec;

  function GetParentNode(const aParentNodeId: integer): PVirtualNode;
  begin
    SearchFoundNode:= nil;
    SearchNodeId:= 'Item_' + IntToStr(aParentNodeId);
    Tree.IterateSubtree(Node,SearchCallback,nil);

    result:= SearchFoundNode;
  end;

begin
  inherited;
  Tree.Clear;
  qry:= CommonDbLib.TempMyQuery;
  try
    qry.SQL.Add('SELECT pt.Level, pt.Caption as ItemCaption,');
    qry.SQL.Add('pt.Description ItemDescription, pt.Quantity as ItemQty,');
    qry.SQL.Add('pt.TotalQty as ItemTotalQty, pt.Value,');
    qry.SQL.Add('pt.ProcTreeId as ItemId, pt.ParentId as ItemParentId,');
    qry.SQL.Add('pt.SaleLineId as ItemSaleLineId,');
    qry.SQL.Add('sl.SaleLineId, sl.ProductName as SaleLineProductName,');
    qry.SQL.Add('sl.Product_Description as SaleLineProductDescription,');
    qry.SQL.Add('sl.UnitOfMeasureQtySold as SaleLineQuantity,');
    qry.SQL.Add('sl.ShipDate as SaleLineShipDate,');
    qry.SQL.Add('s.SaleId, s.InvoiceDocNumber as SaleDocNumber,');
    qry.SQL.Add('s.CustomerName as SaleCustomerName, s.SaleDate, s.DueDate as SaleDueDate');
    qry.SQL.Add('FROM tblProcTree pt');
    qry.SQL.Add('JOIN tblSalesLines sl ON pt.MasterId = sl.SaleLineId AND pt.MasterType <> "mtProduct"');
    qry.SQL.Add('JOIN tblSales s ON sl.SaleId = s.SaleId');
    qry.SQL.Add('LEFT JOIN tblProcessPart pp ON pp.ProcTreeId = pt.ProcTreeId');
    qry.SQL.Add('LEFT JOIN tblProcTree pt2 ON pt.ParentId = pt2.ProcTreeId');
    qry.SQL.Add('WHERE (((pt2.InputType IS NULL OR pt2.InputType <> "itOption")) OR (pt2.InputType = "itOption" AND pt.Selected = "T"))');
    qry.SQL.Add('AND pt.TreeRootId NOT IN (SELECT tblProcTree.TreeRootId FROM tblProcTree, tblProcessPart WHERE  tblProcTree.ProcTreeId = tblProcessPart.ProcTreeId)');
    qry.SQL.Add('AND s.IsSalesOrder = "T" AND s.Converted = "F"');
    qry.SQL.Add('ORDER BY sl.SaleLineId, pt.TreeRootId, pt.SequenceDown;');
    qry.Open;
    LastSaleId:= 0;
    LastSaleLineId:= 0;

    RootNode:= Tree.AddChild(nil);
    Rec:= Tree.GetNodeData(RootNode);
    Rec^.Data:= TNodeData.Create(Self.Columns);
    Rec^.Data.CellData[0].Value := 'Sales';
    RootNode.States:= RootNode.States + [vsExpanded];
    SaleNode:= nil;

    while not qry.Eof do begin
      if LastSaleId <> qry.FieldByName('SaleId').AsInteger then begin
        SaleNode:= Tree.AddChild(RootNode);
        Rec:= Tree.GetNodeData(SaleNode);
        Rec^.Data:= TNodeData.Create(Self.Columns);
        Rec^.Data.CellData[0].Value:= qry.FieldByName('SaleCustomerName').AsString;
        Rec^.Data.CellData[1].Value:=qry.FieldByName('SaleDocNumber').AsString;
        Rec^.Data.CellData[2].Value:=
          FormatDateTime('dd/mm/yyyy', qry.FieldByName('SaleDueDate').AsDateTime);
        SaleNode.States:= SaleNode.States + [vsExpanded];

        LastSaleId:= qry.FieldByName('SaleId').AsInteger;
      end;
      if LastSaleLineId <> qry.FieldByName('SaleLineId').AsInteger then begin
        SaleLineNode:= Tree.AddChild(SaleNode);
        Rec:= Tree.GetNodeData(SaleLineNode);
        Rec^.Data:= TNodeData.Create(Self.Columns);
        Rec^.Data.CellData[0].Value:=
          qry.FieldByName('SaleLineProductName').AsString;
        Rec^.Data.CellData[2].Value:=
          FormatDateTime('dd/mm/yyyy', qry.FieldByName('SaleLineShipDate').AsDateTime);

        Node:= Tree.AddChild(SaleLineNode);
        Rec:= Tree.GetNodeData(Node);
        Rec^.Data:= TNodeData.Create(Self.Columns);
        Rec^.Data.KeyStr:= 'Item_' + qry.FieldByName('ItemId').AsString;
        Rec^.Data.CellData[0].Value:= qry.FieldByName('ItemCaption').AsString;
        Rec^.Data.CellData[3].Value:= qry.FieldByName('ItemQty').AsString;
        Rec^.Data.CellData[4].Value:= qry.FieldByName('ItemTotalQty').AsString;
        Rec^.Data.CellData[5].Value:= qry.FieldByName('Value').AsString;


        LastSaleLineId:= qry.FieldByName('SaleLineId').AsInteger;
      end
      else begin
        tempNode:= GetParentNode(qry.FieldByName('ItemParentId').asInteger);
        if Assigned(tempNode) then begin
          itemNode:= Tree.AddChild(tempNode);
          Rec:= Tree.GetNodeData(itemNode);
          Rec^.Data:= TNodeData.Create(Self.Columns);
          Rec^.Data.KeyStr:= 'Item_' + qry.FieldByName('ItemId').AsString;
          Rec^.Data.CellData[0].Value:= qry.FieldByName('ItemCaption').AsString;
          Rec^.Data.CellData[3].Value:= qry.FieldByName('ItemQty').AsString;
          Rec^.Data.CellData[4].Value:= qry.FieldByName('ItemTotalQty').AsString;
          Rec^.Data.CellData[5].Value:= qry.FieldByName('Value').AsString;
        end;
      end;

      qry.Next;
    end;
  finally
    qry.Free;
  end;
end;

procedure TfmTreeItemList.FormCreate(Sender: TObject);
begin
  Self.fbIgnoreAccessLevels := true;
  inherited;
  Tree.TreeOptions.SelectionOptions := Tree.TreeOptions.SelectionOptions + [toFullRowSelect];
  Self.Columns.HeaderColor := pnlTop.Color;
  AddColumn('Item', vtString, 400);
  AddColumn('Ref', vtString, 90);
  AddColumn('Due Date', vtString, 90);
  AddColumn('Qty', vtFloat, 90,taCenter);
  AddColumn('Total Qty', vtFloat, 90,taCenter);
  AddColumn('Value', vtString, 200);
  Columns.Header.Background := pnlTop.Color;
end;

procedure TfmTreeItemList.SearchCallback(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Data: Pointer; var Abort: boolean);
var
  Rec: PNodeRec;
begin
  Rec:= Tree.GetNodeData(Node);
  if Rec^.Data.KeyStr = SearchNodeId then begin
    SearchFoundNode:= Node;
    Abort:= true;
  end;
end;

procedure TfmTreeItemList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmTreeItemList.cmdPrintClick(Sender: TObject);
begin
//  inherited;
  self.PrintTemplateReport('Production Tree Item List','',false,1);
end;

initialization

  RegisterClassOnce(TfmTreeItemList);

end.
