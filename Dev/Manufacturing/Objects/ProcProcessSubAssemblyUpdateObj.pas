unit ProcProcessSubAssemblyUpdateObj;

interface

uses
  ERPDbComponents, Classes;

type
  TSubAssemblyUpdater = class(TObject)
  private
    qry: TERPQuery;
    fSubAssemblyProcTreeID: integer;
    fOnUpdate: TNotifyEvent;
    function GetSubAssemblyUsedCount: integer;
    procedure SetSubAssemblyProcTreeID(const Value: integer);
  public
    ErrMsg: string;
    constructor Create;
    destructor Destroy; override;
    property SubAssemblyProcTreeID: integer read fSubAssemblyProcTreeID write SetSubAssemblyProcTreeID;
    property SubAssemblyUsedCount: integer read GetSubAssemblyUsedCount;
    property OnUpdate: TNotifyEvent read fOnUpdate write fOnUpdate;
    procedure Execute;
  end;

implementation

uses
  CommonDbLib, SysUtils, BusObjProcess, BusObjStock;

{ TSubAssemblyUpdater }

constructor TSubAssemblyUpdater.Create;
begin
  qry := TERPQuery.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
end;

destructor TSubAssemblyUpdater.Destroy;
begin
  qry.Free;
  inherited;
end;

procedure TSubAssemblyUpdater.Execute;
var
  aTree: TProcTreeNode;
  Product: TProduct;
  UpdateCost: boolean;
  logctr:Integer;

  procedure CheckAndReplace(aNode: TProcTreeNode);
  var
    x: integer;
    TempNode: TProcTreeNode;
    UOMQty: double;
    CurrentInheritFromID,
    CurrentInheritFromEditVersion: integer;
  begin
    for x := 0 to aNode.Children.Count -1 do begin
      if TProcTreeNode(aNode.Children[x]).InheritFromID = fSubAssemblyProcTreeID then begin
        TempNode := TProcTreeNode.Create(nil);
        try
          TempNode.ProcTreeId := fSubAssemblyProcTreeID;
          TempNode.LoadTree;
          TempNode.ClearIds;
          { keep the quantity of this sub-assembly }
          UOMQty := TProcTreeNode(aNode.Children[x]).TreePartUOMQuantity;
          CurrentInheritFromID := TProcTreeNode(aNode.Children[x]).InheritFromID;
          CurrentInheritFromEditVersion := TProcTreeNode(aNode.Children[x]).InheritFromEditVersion;
          TProcTreeNode(aNode.Children[x]).Children.Clear;
          TProcTreeNode(aNode.Children[x]).ProcessStepList.Clear(true);
          TProcTreeNode(aNode.Children[x]).Assign(TempNode);
          TProcTreeNode(aNode.Children[x]).ClearAllCosts;
          TProcTreeNode(aNode.Children[x]).TreePartUOMQuantity := UOMQty;
          TProcTreeNode(aNode.Children[x]).InheritFromID := CurrentInheritFromID;
          TProcTreeNode(aNode.Children[x]).InheritFromEditVersion := CurrentInheritFromEditVersion;
        finally
          TempNode.Free;
        end;

      end
      else
        CheckAndReplace(TProcTreeNode(aNode.Children[x]));
    end;
  end;

begin
  if not qry.Active then exit;

    while not qry.Eof do begin
      try                                                           logctr:= 1;
        aTree := TProcTreeNode.Create(nil);                         logctr:= 2;
        Product := TProduct.CreateWithNewConn(nil);                 logctr:= 3;
        try
          try                                                    logctr:= 4;
                Product.SilentMode := true;                               logctr:= 5;
                ErrMsg := '';                                       logctr:= 6;
                aTree.Load(qry.FieldByName('TreeRootID').AsInteger);logctr:= 7;
                aTree.CalcPrice();                                  logctr:= 8;{binny - Loading th e tree in template mode will clear the cost and price as the totalqty is 0. recalculate it based on the tree}
                Product.Load(aTree.MasterId);                       logctr:= 9;
                UpdateCost := aTree.Cost = Product.BuyQty1Cost;     logctr:= 10;
                CheckAndReplace(aTree);                             logctr:= 11;
                aTree.CalcPrice();                                  logctr:= 12;
                aTree.Save;                                         logctr:= 13;
                if UpdateCost then begin                            logctr:= 14;
                  Product.BuyQty1Cost := aTree.Cost;                logctr:= 15;
                  Product.PostDb;                                   logctr:= 16;
                end;
          except
            on e: exception do begin
              ErrMsg := 'Unable to Update Manufactured Product: ' + aTree.Caption + ' Error: (' +inttostr(logctr)+')'+ e.Message;
            end;
          end;
        finally
          aTree.Free;                                               logctr:= 17;
          Product.Free;                                             logctr:= 18;
        end;
      except
        on e: exception do begin
          ErrMsg := 'Unable to Update Manufactured Product: ' + aTree.Caption + ' Error: (' +inttostr(logctr)+')'+ e.Message;
        end;
      end;
      qry.Next;
      if Assigned(fOnUpdate) then
        fOnUpdate(self);
    end;
end;

function TSubAssemblyUpdater.GetSubAssemblyUsedCount: integer;
begin
  result := 0;
  if qry.Active then
    result := qry.RecordCount;
end;

procedure TSubAssemblyUpdater.SetSubAssemblyProcTreeID(const Value: integer);
begin
  fSubAssemblyProcTreeID := Value;
  if qry.Active then qry.Close;
  qry.SQL.Text := 'select distinct TreeRootID from tblproctree where InheritFromID = ' + IntToStr(Value);
  qry.Open;
end;

end.
