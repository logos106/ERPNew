unit BOMCostnPriceLib;

interface
    Procedure RecalculateBOMcostnPrice(ignoreifManuallyentered:Boolean);overload;
    Procedure RecalculateBOMcostnPrice(const PartsID, rootnodeId:Integer; updatePrice, UpdateCost :Boolean);overload;
implementation

uses CommonDbLib, BusObjProcess, BusObjStock, sysutils, ProgressDialog , Math, SystemLib;

procedure RecalculateBOMcostnPrice(const PartsID, rootnodeId: Integer; updatePrice, UpdateCost :Boolean);
var
  TempNode: TProcTreeNode;
begin
    if not (updatePrice) and not(UpdateCost) then exit;

    TempNode := TProcTreeNode.Create(nil);
    try
      TempNode.ProcTreeId := rootnodeId;
      TempNode.LoadTree;
      TempNode.ClearIds;
      TempNode.CalcPrice;
      With TProduct.CreateWithNewConn(nil) do try
        Load(PartsID);
        RecalculatingBOMcostnPrice:= True;
        if lock then
          try
            Connection.BeginTransaction;
            try

              if (not (Math.SameValue(TempNode.Cost ,BuyQty1Cost, 0.0000001))) then
                if UpdateCost then begin
                  BuyQty1Cost := TempNode.Cost;
                  BOMCostCalculatedFromTree := True;
                end;

              if (not (Math.SameValue(TempNode.Price,SellQty1Price, 0.0000001)))  then
                if updatePrice then begin
                  SellQty1Price := TempNode.Price;
                  BOMPriceCalculatedfromTree := True;
                end;

              PostDB;
              if Save then
                connection.CommitTransaction
              else
                Connection.RollbackTransaction;
            finally
              unlock;
            end;
        Except
          on E:Exception do begin
            Connection.RollbackTransaction;
          end;
        end;
      finally
        Free;
      end;
    finally
      FreeandNil(TempNode);
    end;
end;

procedure RecalculateBOMcostnPrice(ignoreifManuallyentered:Boolean);
var
  updatePrice, UpdateCost :Boolean;
begin
  With TempMyquery do try
    SQL.Add('select  P.PartsId, P.PartName, PT.ProcTreeId , P.BOMPriceCalculatedfromTree , P.BOMCostCalculatedFromTree from tblparts P inner join tblproctree PT on P.partsId = PT.MasterId and PT.MasterType = "mtProduct" and ifnull(PT.ParentId,0)=0');
    Open;
    if recordcount =0 then exit;
    First;
    DoshowProgressbar(REcordcount, 'Updating BOM Cost and Price');
    try
      While Eof = False do begin
          DoStepProgressbar(fieldbyname('Partname').AsString);
          updatePrice := (fieldbyname('BOMPriceCalculatedfromTree').asBoolean) or (ignoreifManuallyentered=False);
          UpdateCost :=  (fieldbyname('BOMCostCalculatedFromTree').asBoolean)  or (ignoreifManuallyentered=False);

          RecalculateBOMcostnPrice(Fieldbyname('PartsID').AsInteger ,
                                   Fieldbyname('ProcTreeId').AsInteger  ,
                                   updatePrice ,UpdateCost);
          Next;
      end;
    finally
      DoHideProgressbar;
    end;
  finally
    closenFree;
  end;
end;


end.

