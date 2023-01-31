unit SolidWorksLib;

interface

uses
  BusObjStock;

type
  TSolidWorksImport = class(TObject)
  private
    fCreateProductIfNotExists: boolean;
    function IsGUI: boolean;
    procedure DoError(const msg: string);
    function MakeProduct(Prod: TProduct; aProductName: string; aDesc: string; var msg: string): boolean;
  public
    constructor Create;
    destructor Destroy; override;
    function DoImportSolidWorksBOM(const aFileName: string; var ProductId: integer): boolean;
    class function ImportSolidWorksBOM(const aFileName: string; var ProductId: integer; aCreateProductIfNotExists: boolean = false): boolean;
    property CreateProductIfNotExists: boolean read fCreateProductIfNotExists write fCreateProductIfNotExists;
  end;

implementation

uses
  XMLDoc, XMLIntf, forms, SysUtils, CommonLib, Dialogs, XMLHelperUtils,
  BusObjProcess, BusObjNDSBase, BusObjProcessPartNDS, BusObjProcessStep,
  Controls;


const
  SW_PartName = 'Number';
  SW_Qty = 'Quantity';
  SW_Desc = 'Filename';

{ TSolidWorksImport }

constructor TSolidWorksImport.Create;
begin
  fCreateProductIfNotExists := true;
end;

destructor TSolidWorksImport.Destroy;
begin

  inherited;
end;

procedure TSolidWorksImport.DoError(const msg: string);
begin
  if IsGUI then
    CommonLib.MessageDlgXP_Vista(msg, mtWarning, [mbOk],0)
  else
    raise Exception.Create(msg);
end;

function TSolidWorksImport.DoImportSolidWorksBOM(const aFileName: string; var ProductId: integer): boolean;
var
  doc: IXMLDocument;
  node: IXMLNode;
  Product, SubProduct: TProduct;
  ProductName: string;
  msg: string;
  TreeNode: TProductProcTree;
  ProcessPart: TProcessPartNDS;

  function BuildTree(ParentTreeNode: TProcTreeNode; aNode: IXMLNode): boolean;
  var
    SubComponentNode, SubNode: IXMLNode;
    i: integer;
    SubTreeNode: TProcTreeNode;
    msg: string;
  begin
    result := true;
    SubComponentNode := aNode.ChildNodes.FindNode('Subcomponents');
    if Assigned(SubComponentNode) then begin
      for i := 0 to SubComponentNode.ChildNodes.Count -1 do begin
        SubNode := SubComponentNode.ChildNodes[i];
        SubProduct.LoadSelect('PartName = ' + QuotedStr(GetNodeVal(SubNode,'Number')));
        if SubProduct.Count = 0 then begin
          if CreateProductIfNotExists then begin
            if not MakeProduct(SubProduct,GetNodeVal(SubNode,'Number'),GetNodeVal(SubNode,'Filename'),msg) then begin
              result := false;
              DoError(msg);
              exit;
            end;
          end
          else begin
            result := false;
            DoError('ERP Product does not exist (' + GetNodeVal(SubNode,'Number') + ')');
            exit;
          end;
        end;
        SubTreeNode := TProcTreeNode.Create(nil);
        SubTreeNode.MasterType := mtProduct;
        SubTreeNode.IsTemplate := true;
        SubTreeNode.PartsId := SubProduct.ID;
        SubTreeNode.MasterId := Product.ID;
        SubTreeNode.Quantity := StrToFloat(GetNodeVal(SubNode,'Quantity'));
        ParentTreeNode.Children.Add(SubTreeNode);
        if not BuildTree(SubTreeNode,SubNode) then begin
          result := false;
          exit;
        end;
      end;
    end;
  end;

begin
  result := false;
  doc := TXMLDocument.Create(nil);
  try
    try
    doc.LoadFromFile(aFileName);
    doc.Active:= true;
    except
      on e: exception do begin
        if IsGUI then begin
          CommonLib.MessageDlgXP_Vista('Error reading XML File: ' + e.Message, mtWarning, [mbOk],0);
          exit;
        end
        else
          raise;
      end;
    end;
    node := Doc.ChildNodes.FindNode('BOM');
    if not Assigned(node) then begin
      DoError('<BOM> Node is missing from the BOM file');
      exit;
    end;
    node := node.ChildNodes.FindNode('Component');
    if not Assigned(node) then begin
      DoError('<Component> Node is missing from the BOM file');
      exit;
    end;
    ProductName := GetNodeVal(Node,'Number');
    if Trim(ProductName) = '' then begin
      DoError('Componet Number is missing from the BOM file');
      Product.Connection.RollbackTransaction;
      exit;
    end;

    Product := TProduct.CreateWithNewConn(nil);
    SubProduct := TProduct.Create(nil);
    try
      Product.SilentMode := true;
      SubProduct.Connection := Product.Connection;
      Product.Connection.BeginTransaction;
      Product.LoadSelect('PartName = ' + QuotedStr(ProductName));
      if Product.Count = 0 then begin
        if CreateProductIfNotExists then begin
          if not MakeProduct(Product, ProductName, GetNodeVal(node,'Filename'),msg) then begin
            DoError(msg);
            Product.Connection.RollbackTransaction;
            exit;
          end;
        end
        else begin
          DoError('ERP Product not found for '+ ProductName);
          Product.Connection.RollbackTransaction;
          exit;
        end;
      end;
      ProductId := Product.ID;
      if Product.Lock then begin
        try
          TreeNode := TProductProcTree(Product.Container.ItemByClass(TProductProcTree));
          if Assigned(TreeNode) then begin
            if IsGUI then begin
              if TreeNode.Children.Count > 0 then begin
                if CommonLib.MessageDlgXP_Vista('There is an existing BOM Tree for this Product, ' +
                  'are you sure you want to delete this Tree and Import a new one?', mtConfirmation, [mbYes,mbNo],0) = mrNo then
                 exit;
              end;
            end;
            TreeNode.DeleteNoCheck;
            TreeNode.SaveNoCheck;
            TreeNode.Children.Clear;
            TreeNode.ProcessStepList.Clear(true);
            TreeNode.MasterType := mtProduct;
            TreeNode.IsTemplate := true;
            TreeNode.PartsId := Product.ID;
            TreeNode.MasterId := Product.ID;
            TreeNode.Quantity := StrToFloat(GetNodeVal(node,'Quantity'));
            //TreeNode.ProcessStepList.
            ProcessPart := TreeNode.ProcessStepList.AddProcessPart;
            ProcessPart.ProcessStepID := TProcessStep.IdForDescription('Assembly');
            ProcessPart.ProcessStepSeq := 10;
            ProcessPart.Duration := 30 * 60;
            if not BuildTree(TreeNode,node) then begin
              Product.Connection.RollbackTransaction;
              exit;
            end;
            TreeNode.CalcQty;
            TreeNode.CalcCost();
            TreeNode.CalcPrice();
            TreeNode.BuildDetails;
            if not TreeNode.Save then begin
              DoError(TreeNode.ResultStatus.Messages);
              Product.Connection.RollbackTransaction;
              exit;
            end;
          end;
        finally
          Product.UnLock;
        end;
      end
      else begin
        DoError('Could not lock product: ' + Product.UserLock.LockMessage);
        Product.Connection.RollbackTransaction;
        exit;
      end;
      Product.Connection.CommitTransaction;
      if IsGUI then
        CommonLib.MessageDlgXP_Vista('Import complete.', mtInformation, [mbOk],0);
      result := true;
    finally
      Product.Free;
      SubProduct.Free;
    end;
  finally
    doc := nil;
  end;

end;

class function TSolidWorksImport.ImportSolidWorksBOM(const aFileName: string;
  var ProductId: integer; aCreateProductIfNotExists: boolean): boolean;
begin
  with TSolidWorksImport.Create do begin
    CreateProductIfNotExists := aCreateProductIfNotExists;
    result := DoImportSolidWorksBOM(aFileName,ProductId);
    Free;
  end;
end;

function TSolidWorksImport.IsGUI: boolean;
begin
  result := Assigned(Application.MainForm);
end;

function TSolidWorksImport.MakeProduct(Prod: TProduct; aProductName,
  aDesc: string; var msg: string): boolean;
begin
  if Trim(aProductName) = '' then begin
    result := false;
    msg := 'Missing Product Name';
    exit;
  end;
  Prod.New;
  Prod.ProductType := 'INV';
  Prod.ProductName := aProductName;
  Prod.PurchaseDescription := aDesc;
  Prod.SalesDescription := aDesc;
  result := Prod.Save;
  if not result then
    msg := 'Could not create new Product (' + aProductName + '): ' +Prod.ResultStatus.Messages;
end;

end.
