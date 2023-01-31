unit GroupReorder;

{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 30/10/06  1.00.01 BJ   Initial version
 23/01/07  1.00.02 BJ   available qty of a product = instock - onbuild
}

interface

uses MyAccess;

Procedure PopulateGroupProducts(const Qry :TMyQuery; const fProductID, fClassId:Integer; const GroupQty :double;
          const GroupPARTSID :Integer; const fGroupID :Integer = 0; const BuildingProduct :Boolean = False ;
          const includeInstock :Boolean = True; const CreateBuildCall: Boolean = False);

Function  CreateTmpTable:String;
Procedure GroupProductAvailableQty(const Con :TCustomMyConnection; const TableName :STring);
Function  CreateSO(const Qry :TMyQuery; const SOCaption :STring = ''):Integer;

implementation

uses FastFuncs,classes, CommonDbLib, sysutils, busobjstock,Variants, 
  tcDataUtils, db, BusObjSmartOrder, BusObjBase, Dateutils, AppEnvironment;

Function CreateSO(const Qry :TMyQuery; const SOCaption :String = ''):Integer;
var
    SOObj:   TSmartOrder;
    sSOCaption :String;
begin
    REsult := 0;
    With Qry do begin
        Filtered := False;
        if Filter  <> '' then Filter := Filter  + ' and ';
        Filter := Filter  + ' ISGroup = "F"';
        Filtered := True;

        if SOCaption = '' then
          sSOCaption := 'Group reorder'
        else
          sSOCaption := SOCaption;

        if Recordcount = 0 then exit;
        SOObj := TSmartOrder.Create(nil);
        SOObj.connection := TMydacDataconnection.Create(SOObj);
        SOObj.Connection.Connection := GetNewMyDacConnection(SOObj);
        SOObj.connection.BeginTransaction;
        Try
            SOObj.New;
            SOObj.EmployeeId    := AppEnv.employee.EmployeeID;
            SOObj.CreationDate  := Dateof(Now) ;
            SOObj.SmartOrderdesc:= sSOCaption + '  (' + FormatDatetime('dd/mm/yyyy', DateOf(now)) +')';;
            SOObj.Done          := False;
            SOObj.PostDB;
            First;
            While Eof = False do begin
                if FieldByname('Qty').asFloat <> 0 then begin
                    if not SOObj.Lines.Dataset.Locate('PartsID;SupplierID;ClassId;UnitOfmeasureID' ,
                            VarArrayof([FieldByname('PartsID').asInteger ,FieldByname('SupplierID').asInteger, FieldByname('ClassID').asInteger,FieldByname('UnitOfMeasureID').asInteger ]) , []) then begin
                        SOObj.Lines.New;
                        SOObj.Lines.SmartOrderId             := SOObj.Id;
                        SOObj.Lines.PartsId                  := FieldByname('PartsID').asInteger;
                        SOObj.Lines.PartsName                := FieldByname('PartsName').asString;
                        SOObj.Lines.POdesc                   := FieldByname('PODesc').asString;
                        SOObj.Lines.Searchfilter             := SOObj.Lines.PartsName;
                        SOObj.Lines.SearchfilterCopy         := Soobj.Lines.PartsName;
                        SOObj.Lines.SupplierName             := FieldByname('SupplierName').asString;
                        SOObj.Lines.SupplierID               := FieldByname('SupplierID').asInteger;
                        SOObj.Lines.DeptName                 := FieldByname('ClassName').AsString;
                        SOObj.Lines.ClassId                  := FieldByname('ClassID').asInteger;
                        SOObj.Lines.UnitOfmeasure            := FieldByname('UnitOfMeasure').asString;
                        SOObj.Lines.UnitOfmeasureQty         := FieldByname('UnitofMeasureQty').asFloat;
                        SOObj.Lines.UnitOfmeasureMultiplier  := FieldByname('UnitOfmeasureMultiplier').asFloat;
                        SOObj.Lines.UnitOfMeasureID          := FieldByname('UnitOfMeasureID').asInteger;
                        SOObj.Lines.Qty                      := 0;
                        SOObj.Lines.UnitOfmeasureQty         := 0;
                        SOObj.Lines.LinePrice                := FieldByname('LinePrice').asFloat;
                        SOObj.Lines.CostEx                   := FieldByname('CostEx').asFloat;
                        SOObj.Lines.CostInc                  := FieldByname('CostInc').asFloat;
                        SOObj.Lines.LineTaxRate              := FieldByname('LineTaxRate').asFloat;
                    end;
                    SOObj.Lines.Qty                      := SOObj.Lines.Qty +FieldByname('Qty').asFloat;
                    //SOObj.Lines.UnitOfmeasureQty         := SOObj.Lines.UnitOfmeasureQty + FieldByname('UnitofMeasureQty').asFloat;
                    SOObj.Lines.PostDb;
                End;
                Next;
            end;
        Finally
            SOOBJ.Save;
            SOObj.connection.CommitTransaction;
            Result :=SOOBJ.ID;
            FreeandNil(SOOBJ);
        End;
    End;
end;
Procedure GroupProductAvailableQty(Const Con :TCustomMyConnection; Const TableName :STring);
var
    fPartsId :Integer;
    fClassId :Integer;
    fPrClass :TProductClass ;
    fdInstock :Double;
begin
        With tMyQuery.Create(nil) do try
            Connection := Con;

            SQL.add('update ' + Tablename +
                ' Set ReqQty = Qty ');
            Execute;
            SQL.clear;
            SQL.add('select * from ' + TableName + ' order by PartsID, CLassId' );
            open;
            First;
            fPrClass := TProductClass.Create(nil);
            Try
                while Eof = False do begin
                    fPartsId := FieldByname('PArtsID').asInteger;
                    fClassId := FieldByname('ClassId').asInteger;
                    fPrClass.LoadSelect('ProductID = ' + FastFuncs.IntToStr(fPArtsID) + ' and ClassID = ' + FastFuncs.IntToStr(fClassID));
                    fdinStock :=fPrClass.QtyInStock - (fPrClass.SalesorderQty + fPrClass.OnbuildQty + fPrClass.SOUnAllocatedQty);
                    {group products should take the BOqty as well as the build record is already created from the SO and invoice for Backorders as well}
                    if FieldByname('IsGroup').asBoolean then fdinStock :=fdinStock - (fPrClass.SOBOQty +fPrClass.InvoiceBOQty + fPrClass.SOUnAllocatedBOQty);
                    if fdinStock<0 then fdinStock := 0;
                    While (Eof = False) and
                        (fPartsId = FieldByname('PartsID').asInteger) and
                        (fClassId = FieldByname('ClassId').asInteger) do begin
                        if state <> dsEdit then Edit;
                        if fdInstock >= fieldByname('REqQty').asFloat then begin
                             FieldByname('InstockQty').AsFloat :=fieldByname('REqQty').asFloat;
                             fdInstock := fdInstock - fieldByname('REqQty').asFloat;
                        end else begin
                             FieldByname('InstockQty').AsFloat :=fdInstock;
                             fdInstock := 0;
                        end;
                       if state = dsEdit then Post;
                        Next;
                    End;
                end;
            finally
                freeandNil(fPrClass);
            end;
            SQL.clear;
            SQL.add('update ' + Tablename + ' Set Qty := ReqQty-InstockQty where IsGroup <> "T"');
             Execute;
            SQL.clear;
            SQL.add('update ' + Tablename + ' Set UnitofMeasureQty := Qty/UnitofMeasureMultiplier where IsGroup <> "T"');
             Execute;
        finally
            Free;
        End;
end;

Function    CreateTmpTable:String;
begin
    result := CreateUserTemporaryTable('tmp_GroupPartsReorder');
end;
Procedure PopulateGroupProducts(const  Qry :TMyQuery; const fProductID, fClassId:Integer; const GroupQty :double;
            const GroupPARTSID :Integer; const fGroupID :Integer = 0; const BuildingProduct :Boolean = False ;
            const includeInstock :Boolean = True; const CreateBuildCall: Boolean = False);
var
  fPr :TProduct;
  sfGroupID :Integer;
  sGroupQty :double;

    Function  updateProduct(const Product :TProduct; const Qty :double; const GroupPARTSID:Integer):Integer;
    begin
        if not Qry.locate('PARTSID;ClassID;UnitOfMeasureID;GroupID' , vararrayof([Product.ID,fClassId,Product.UOMPurchasesID,sfGroupID]) , []) then begin
            Qry.Append;
            Qry.FieldByname('GroupPARTSID').asInteger:=GroupPARTSID;
            Qry.FieldByname('PARTSID').asInteger     :=Product.ID;
            Qry.FieldByname('GroupID').asInteger     :=sfGroupID;
            Qry.FieldByname('PARTSNAME').asString    := Product.ProductName;
            Qry.FieldByname('PODesc').asString       := Product.PurchaseDescription;
            Qry.FieldByname('SupplierName').AsString := Product.PreferedSupplierName;
            Qry.FieldByname('SupplierID').AsInteger  := getSupplierID(Qry.FieldByname('SupplierName').AsString );
            Qry.FieldByname('ClassID').asInteger     := fCLassId;
            Qry.FieldByname('ClassName').asString    := GetClassName(fClassID);
            Qry.FieldByname('UnitofMeasure').asString:=Product.UOMPurchases;
            Qry.FieldByname('UnitOfMeasureID').asInteger :=Product.UOMPurchasesID;
            Qry.FieldByname('UnitofMeasureMultiplier').asFloat := tcDataUtils.getUnitMultiplier(Qry.FieldByname('UnitOfMeasureID').asInteger);
            Qry.FieldByname('Qty').asFloat := 0;
            Qry.FieldByname('UnitofMeasureQty').asFloat := 0;
        end else if Qry.State in [dsEdit,dsInsert] then else Qry.Edit;
        Qry.FieldByname('Qty').asFloat := Qry.FieldByname('Qty').asFloat + sGroupQty* Qty;
        //Qry.FieldByname('Qty').asFloat := Qry.FieldByname('Qty').asFloat + sGroupQty* Qty/Qry.FieldByname('UnitofMeasureMultiplier').asFloat;
        if Product.ProductType <> 'GRP' then begin
            Qry.FieldByname('LinePrice').asFloat :=Product.GetPriceForQty(Qry.FieldByname('Qty').asFloat);
            Qry.FieldByname('CostEx').asFloat :=Product.GetCostForQty(Qry.FieldByname('Qty').asFloat);
            Qry.FieldByname('CostInc').asFloat := Qry.FieldByname('CostEx').asFloat  + Qry.FieldByname('CostEx').asFloat * Product.TaxPurchase.Rate;
            Qry.FieldByname('LineTaxRate').asFloat := Product.TaxPurchase.Rate;
        end;
        Qry.FieldByname('ISGroup').asBoolean := (Product.ProductType = 'GRP') and (Product.GroupParts.count>0);
        if Qry.State in [dsEdit,dsInsert] then Qry.Post;
        REsult := Qry.FieldByname('AutoID').asInteger;
    end;
begin
    sfGroupID := fGroupID;
    sGroupQty := GroupQty;
    fPr := TProduct.Create(nil);
    Try
       fPr.Load(fProductID);

       if (CreateBuildCall = False) or (fPr.AutoBuildGroup = True) then begin
         if (fPr.ProductType <> 'GRP') or (fPr.GroupParts.count=0) then begin
           updateProduct(fPr, 1 , GroupPARTSID);
         end else begin

              sfGroupID:= updateProduct(fPr, 1 , GroupPARTSID);
              if includeInstock then
                  if fpr.productClass.dataset.Locate('ClassId' , fCLassID , []) then
                      if (fpr.productClass.QtyInStock  - (fpr.productClass.OnBuildQty+fpr.productClass.SOBOQty+ fpr.productClass.invoiceBOQty + fpr.productClass.SOunallocatedBOQty+fpr.productClass.SOunallocatedQty) > 0) and
                          (fpr.productClass.QtyInStock  - (fpr.productClass.OnBuildQty+fpr.productClass.SOBOQty+ fpr.productClass.invoiceBOQty + fpr.productClass.SOunallocatedBOQty+fpr.productClass.SOunallocatedQty) <sGroupQty) then
                          if not BuildingProduct then begin
                              sGroupQty := sGroupQty - (fpr.productClass.QtyInStock  - (fpr.productClass.OnBuildQty+fpr.productClass.SOBOQty+ fpr.productClass.invoiceBOQty + fpr.productClass.SOunallocatedBOQty+fpr.productClass.SOunallocatedQty));
                          End;


             if (sGroupQty > 0 ) and (fPr.GroupParts.count > 0) then begin
                 fPr.groupParts.Dataset.First;
                 While fPr.groupParts.Dataset.Eof = False do begin
                      if fPr.groupParts.Product.ProductType <> 'GRP' then begin
                           updateProduct(fPr.groupParts.Product , fPr.GroupParts.Qty, fPr.ID);
                      end else begin
                          PopulateGroupProducts(Qry, fPr.groupParts.Product.ID , fClassId ,
                              sGroupQty * fPr.groupParts.qty, fpr.ID, sfGroupID ,False, includeInstock, CreateBuildCall);
                      End;
                      fPr.groupParts.Dataset.Next;
                 end;
             end;
         End;
       end;  
    Finally
        FreeandNil(fPr);
    end;
end;
end.
