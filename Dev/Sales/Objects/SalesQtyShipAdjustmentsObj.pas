unit SalesQtyShipAdjustmentsObj;

interface

Uses
  JSONObject,Classes, busobjOrders, busobjsalebase , IntegerListObj , forms;

Type
  TSalesQtyShipAdjustmentsObj = Class(TComponent)
  Public
  End;

function CheckandShipFromOtherDepts(SaleSObj :TSalesbase; BOLineIDs:TIntegerList; var Msg:String; StockFromOtherClassId:Integer; UseStockFromOtherClassId:Boolean):Boolean;
Function CheckCrossStockCompanies(SaleSObj :TSalesbase; BOLineIDs:TIntegerList; var Msg:String; aOwnerform:Tform):Boolean;
//Procedure MakeInvoice(fpo :TPurchaseorder; comments :String);
Function MakeInvoice(JsonInvoices :TJSONObject; aOwnerform:Tform):String;

implementation

uses  ERPdbComponents, busobjstockTransferentry, PQALib, dateutils,
  ProductQtyLib, DbSharedObjectsObj, CommonDbLib, tcConst , sysutils,
  BusobjCrossStockCompanies, AppEnvironment, BusObjClient, BusObjBase,
  busobjcompinfo, BusObjSales , MySQLConst, tcDataUtils, LogLib,
  ThreadObjForOtherDB , LogThreadLib, LogMessageTypes;


Function  CheckandShipFromOtherDepts(SaleSObj :TSalesbase; BOLineIDs:TIntegerList; var Msg:String; StockFromOtherClassId:Integer; UseStockFromOtherClassId:Boolean):Boolean;
var
  fstocktransferEntry :TStockTransferEntry;

  Qry :TERPQuery;
  fdQty :Double;
  dt:TDateTime;
  fCrossDeptStockTransfer : String;
  TransferFromClassID :Integer;
  i:Integer;
begin
  REsult := True;
  dt:= incsecond(SaleSObj.saledatetime, -1);
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
      SaleSObj.lines.First;
      fCrossDeptStockTransfer := '';
      While SaleSObj.Lines.EOF = False do begin
          if SaleSObj.Lines.UOMQtyBackOrder >0 then begin
            if   BOLineIDs.Indexof(SaleSObj.Lines.ID) >=0 then begin

                Closedb(Qry);
                Qry.SQl.text := SQL4ProductQty(dt ,SaleSObj.Lines.UnitOfMeasure , tSummary , SaleSObj.Lines.productId,0,'',0, '', '','',tAvailable, '','', 0,True, True, true,true,true);
                Qry.open;
                if Qry.recordcount >0 then begin
                  for i := 1 to 2 do begin

                      if (i=1) and (UseStockFromOtherClassId=False) then continue;

                      Qry.first;
                      While Qry.EOF = False do begin
                        if (Qry.Fieldbyname('DepartmentID').asInteger <> SaleSObj.saleClassid) (*and
                          (Qry.Fieldbyname('DepartmentID').asInteger <> StockFromOtherClassId) *)then begin
                          if Qry.Fieldbyname('UOMQty').asFloat >0 then begin
                            if ((i=1) and  (UseStockFromOtherClassId = True ) AND (qry.fieldbyname('DepartmentId').asInteger =  DefaultstockClassId(qry.fieldbyname('PartsId').asInteger))) Or
                               ((i=2) and ((UseStockFromOtherClassId = False) OR  (qry.fieldbyname('DepartmentId').asInteger <> DefaultstockClassId(qry.fieldbyname('PartsId').asInteger))) and
                                          ((StockFromOtherClassId=0) OR (Qry.Fieldbyname('DepartmentID').asInteger = StockFromOtherClassId) ) )  then begin
                                  if SaleSObj.Lines.UOMQtyBackOrder > Qry.Fieldbyname('UOMQty').asFloat then  fdQty := Qry.Fieldbyname('UOMQty').asFloat  else fdQty := SaleSObj.Lines.UOMQtyBackOrder;
                                  if fdQty >0 then begin
                                    if fCrossDeptStockTransfer <> '' then fCrossDeptStockTransfer := fCrossDeptStockTransfer + ' union ';
                                    fCrossDeptStockTransfer := fCrossDeptStockTransfer + NL +
                                      'Select ' + Quotedstr(FormatDateTime(mysqldatetimeformat , dt)) +' as Dt,' +
                                                  inttostr(Qry.Fieldbyname('DepartmentID').asInteger) + ' as TransferFromClassID, '+
                                                  Quotedstr(SaleSObj.Lines.productname) +' as Productname ,'+
                                                  Quotedstr(SaleSObj.Lines.UnitOfMeasure) +' as UOM, ' +
                                                  inttostr(SaleSObj.saleClassid) +' as classidTo, '+
                                                  Floattostr(fdQty) +' as Qty';
                                    SaleSObj.Lines.UOMQtyShipped := SaleSObj.Lines.UOMQtyShipped + fdQty;
                                    SaleSObj.Lines.PostDB;
                                    if SaleSObj.Lines.UOMQtyBackOrder  <=0 then break;
                              end;
                            end; {has qty to move as per current BO Qty and qty available in the other depst}
                          end;{has extra Qty to transfer}
                        end; {not same dept as the sales dept}
                        Qry.Next;
                      end; {loop for qtys}
                      if SaleSObj.Lines.UOMQtyBackOrder  <=0 then break;
                  end;
                end; {if qtys qry has records}
            end; {Lines selcted for cross dept stock check}
          end; {line has bo Qty}
          SaleSObj.Lines.Next;
      end; {Loop for lines}
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;

  if fCrossDeptStockTransfer <> '' then begin
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
              fstocktransferEntry := nil;
              try
                  closedb(Qry);
                  Qry.SQL.Text := fCrossDeptStockTransfer;
                  Qry.SQL.add(' Order by   TransferFromClassID');
                  Opendb(Qry);
                  if Qry.recordcount > 0 then begin
                    Qry.First;
                    TransferFromClassID := 0;
                    While Qry.Eof = False do begin
                      if TransferFromClassID <> Qry.FieldByName('TransferFromClassID').AsInteger then begin
                          if fstocktransferEntry  <> nil then begin
                            if fstocktransferEntry.save and fstocktransferEntry.Process then begin
                              Msg := Msg + NL + 'Stock Transfer # ' + inttostr(fstocktransferEntry.ID);
                              fstocktransferEntry.Connection.CommitTransaction;
                              Logtext('Stock Transfer #' + inttostr(fstocktransferEntry.ID)+' processed and Committed');
                            end else begin
                              fstocktransferEntry.Connection.RollbackTransaction;
                            end;
                            FreeandNil(fstocktransferEntry);
                          end;
                          fstocktransferEntry := TStockTransferEntry.CreateWithNewConn(Nil);
                          fstocktransferEntry.Connection.beginTransaction;
                          fstocktransferEntry.CrossStockAdjustTransForinvoice := True;
                          fstocktransferEntry.Load(0);
                          fstocktransferEntry.New;
                          fstocktransferEntry.DateTransferred := dt;
                          fstocktransferEntry.TransferFromClassID :=Qry.Fieldbyname('TransferFromClassID').asInteger;
                          fstocktransferEntry.PostDB;
                          TransferFromClassID :=fstocktransferEntry.TransferFromClassID;
                          Logtext('New Stock Transfer #' + inttostr(fstocktransferEntry.ID)+',' + fstocktransferEntry.TransferFromClassName);
                      end;
                      fstocktransferEntry.Lines.New;
                      fstocktransferEntry.Lines.productname    := Qry.Fieldbyname('productname').AsString;
                      fstocktransferEntry.Lines.UnitOfMeasure  := Qry.Fieldbyname('uom').AsString;
                      fstocktransferEntry.Lines.classidTo      := Qry.Fieldbyname('classidTo').AsInteger;
                      fstocktransferEntry.Lines.UOMQty         := Qry.Fieldbyname('Qty').AsFloat;
                      fstocktransferEntry.Lines.PostDB;
                      Logtext('New Stock Transfer Line#' + inttostr(fstocktransferEntry.Lines.ID)+',' + fstocktransferEntry.Lines.productname+',' + FloatToStr(fstocktransferEntry.Lines.UOMQty )  );
                      Qry.Next;
                    end;

                    if (fstocktransferEntry  <> nil) and (fstocktransferEntry.Lines.count >0)  then begin
                      if fstocktransferEntry.save and fstocktransferEntry.Process then begin
                        Msg := Msg + NL + 'Stock Transfer # ' + inttostr(fstocktransferEntry.ID);
                        fstocktransferEntry.Connection.CommitTransaction;
                        Logtext('Stock Transfer #' + inttostr(fstocktransferEntry.ID)+' processed and Committed');
                      end else begin
                        fstocktransferEntry.Connection.RollbackTransaction;
                      end;
                      FreeandNil(fstocktransferEntry);
                    end;
                  end;
              finally
                FreeandNil(fstocktransferEntry);
              end;
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;
  end;

end;


Function CheckCrossStockCompanies(SaleSObj: TSalesbase; BOLineIDs: TIntegerList; var Msg: String; aOwnerform: Tform): Boolean;
var
  CrossStockCompanies   : TCrossStockCompanies;
    DBConForeignDB      : TERPConnection;
    MyDacConnForeignDB  : TMyDacDataConnection;
    Qry                 : TERPQuery;
    SupplierId          : Integer;
    dt                  : TDateTime;
    fPO                 : TPurchaseOrder;
    DepartmentId        : Integer;
    fdQty               : Double;
    fsSQL               : String;
    JsonInvoices        : TJSONObject;
    JsonInv, JsonInvLine: TJSONObject;
    JsonArrayInvoices   : TJsonArray;
    JsonArrayInvoiceLine: TJsonArray;
    ctr                 : Integer;

  Procedure CreateSupplier;
  var
    Supplier           : TSupplier;
    CompanyInfo        : TCompanyInfo;
  begin
    CompanyInfo := TCompanyInfo.Create(nil);
    try
      CompanyInfo.Connection := MyDacConnForeignDB;
      CompanyInfo.Load;

      SupplierId := 0;
      Supplier   := TSupplier.CreateWithNewConn(Nil);
      try
        try
          Supplier.silentMode := True;
          Supplier.MakeClientFromCmpanyInfo(CompanyInfo, False, True, False);

          Supplier.Connection.CommitTransaction;
          SupplierId := Supplier.ID;
          Logtext('Supplier  #' + inttostr(SupplierId));
        Except
          on E: Exception do begin
            Supplier.Connection.RollbackTransaction;
            exit;
          end;
        end;
      finally
        Freeandnil(Supplier);
      end;
    finally
      Freeandnil(CompanyInfo);
    end;
  end;
  Procedure SavenFreeInvoice(addnew: Boolean);
  begin
    if JsonInv <> nil then JsonArrayInvoices.add(JsonInv);
    if addnew then JsonInv := JO;
  end;
  Procedure SavenMakeNewInvoice(const POID:Integer);
  begin
    if Qry.Fieldbyname('DepartmentID').asInteger <> DepartmentId then begin
      SavenFreeInvoice(True);
      DepartmentId                := Qry.Fieldbyname('DepartmentID').asInteger;
      JsonInv.S['Dbname']            := CrossStockCompanies.dbname;
      JsonInv.S['SourceDBName']      := Appenv.AppDb.Database;
      JsonInv.B['SourceDBCustomer']  := True;
      JsonInv.S['CustomerName']      := Appenv.CompanyInfo.CompanyName;
      JsonInv.dt['SaleDate']         := incsecond(dt, -1);
      JsonInv.dt['saledatetime']     := incsecond(dt, -1);
      JsonInv.S['SaleClassName']     := Qry.Fieldbyname('Departmentname').asString;
      JsonInv.S['Comments']          := 'Cross Stock Transfer for ' + quotedstr(Appenv.CompanyInfo.CompanyName) + NL +
                                        '     -> ' +SaleSObj.XMLNodeName + '#' + inttostr(SaleSObj.ID)+NL +
                                        '     -> Purchase Order # ' + inttostr(POID);

      JsonInv.S['EmployeeLogonName'] := CrossStockCompanies.Logon_Name;
      ctr                            := 1;
      JsonArrayInvoiceLine           := JsonInv.A['Lines'];
    end;
  end;
  Procedure NewInvoiceLine;
  begin
    JsonInvLine                    := JO;
    JsonInvLine.S['productname']   := Qry.Fieldbyname('productname').asString;
    JsonInvLine.S['UnitOfMeasure'] := Qry.Fieldbyname('UnitOfMeasure').asString;
    JsonInvLine.F['UOMQtySold']    := Qry.Fieldbyname('Qty').AsFloat;
    JsonInvLine.F['UOMQtyShipped'] := Qry.Fieldbyname('Qty').AsFloat;
    JsonArrayInvoiceLine.add(JsonInvLine);
  end;
  Procedure NewPOLine;
  begin
    fPO.Lines.New;
    fPO.Lines.productname   := Qry.Fieldbyname('productname').asString;
    fPO.Lines.UnitOfMeasure := Qry.Fieldbyname('UnitOfMeasure').asString;
    fPO.Lines.UOMQtySold    := Qry.Fieldbyname('Qty').AsFloat;
    fPO.Lines.UOMQtyShipped := Qry.Fieldbyname('Qty').AsFloat;
    fPO.Lines.LineClassId   := Qry.Fieldbyname('poclassid').asInteger;
    fPO.Lines.PostDB;
    Logtext('New PO line #' + inttostr(fPO.Lines.ID) + ',' + fPO.Lines.productname + ',' + Floattostr(fPO.Lines.UOMQtyShipped));
  end;
  Procedure MakeNewPO;
  begin
    fPO.CrossStockAdjustTransForinvoice := True;
    fPO.Connection.BeginTransaction;
    fPO.Load(0);
    fPO.silentMode := True;
    fPO.New;
    fPO.SupplierId := SupplierId;
    fPO.OrderDate  := incsecond(dt, -1);
    fPO.PostDB;
    Logtext('New PO #' + inttostr(fPO.ID) + ',' + fPO.suppliername);
  end;

begin
  REsult              := False;
  CrossStockCompanies := TCrossStockCompanies.Create(SaleSObj);
  Try
    CrossStockCompanies.Connection := SaleSObj.Connection;
    CrossStockCompanies.Load;
    if CrossStockCompanies.count = 0 then exit;
    if (CrossStockCompanies.count = 1) and (sametext(CrossStockCompanies.dbname, Appenv.AppDb.Database)) then exit;
    CrossStockCompanies.First;
    dt := incsecond(SaleSObj.saledatetime, -1);
    while CrossStockCompanies.Eof = False do begin
      JsonInvoices := JO;
      try
        JsonInvoices.S['Dbname']                          := CrossStockCompanies.dbname;
        JsonInvoices.S['Logon_Name']                      := CrossStockCompanies.Logon_Name;
        JsonInvoices.B['CrossStockAdjustTransForinvoice'] := True;
        JsonArrayInvoices  := JsonInvoices.A['Invoices'];
        if not(sametext(CrossStockCompanies.dbname, Appenv.AppDb.Database)) then begin
          fsSQL              := '';
          MyDacConnForeignDB := TMyDacDataConnection.Create(Nil);
          try
            try
              if DBConForeignDB <> nil then Freeandnil(DBConForeignDB);
              DBConForeignDB           := GetNewMyDacConnection(CrossStockCompanies, CrossStockCompanies.dbname);
              MyDacConnForeignDB.Connection := DBConForeignDB;

              CreateSupplier;
              if SupplierId = 0 then exit;


              SaleSObj.Lines.First;

              While SaleSObj.Lines.Eof = False do begin

                if (BOLineIDs.Indexof(SaleSObj.Lines.ID) >= 0) and (SaleSObj.Lines.UOMQtyBackOrder > 0) then begin
                  Qry := DbSharedObjectsObj.DbSharedObj.GetQuery(DBConForeignDB);
                  try
                    Qry.SQl.text := SQL4ProductQty(dt, SaleSObj.Lines.UnitOfMeasure, tSummary,
                                    GetProduct(SaleSObj.Lines.productname, DBConForeignDB), 0, '', 0, '', '', '', tAvailable,
                                    '', '', 0, True, True, True, True, True) + ' Order by DepartmentId';
                    Qry.open;

                    if Qry.Recordcount > 0 then begin
                      Qry.First;

                      While Qry.Eof = False do begin

                        if (SaleSObj.Lines.UOMQtyBackOrder > 0) and (Qry.Fieldbyname('UOMQty').AsFloat > 0) then begin
                          if SaleSObj.Lines.UOMQtyBackOrder > Qry.Fieldbyname('UOMQty').AsFloat then fdQty := Qry.Fieldbyname('UOMQty').AsFloat
                          else fdQty                                                                       := SaleSObj.Lines.UOMQtyBackOrder;

                          if fdQty > 0 then begin

                            SaleSObj.Lines.UOMQtyShipped := SaleSObj.Lines.UOMQtyShipped + fdQty;  SaleSObj.saledatetime := dt;
                            SaleSObj.Lines.PostDB;
                            Logtext('Qty change ' + SaleSObj.Lines.productname + ':' + Floattostr(SaleSObj.Lines.UOMQtyShipped));
                            if fsSQL <> '' then fsSQL := fsSQL + ' union ';
                            fsSQL := fsSQL + 'Select ' +
                                        inttostr(Qry.Fieldbyname('DepartmentID').asInteger) + ' as DepartmentID, ' +
                                        Quotedstr(Qry.Fieldbyname('classname').asString)    + ' as Departmentname, ' +
                                        Quotedstr(SaleSObj.Lines.productname)               + ' as Productname ,' +
                                        Quotedstr(SaleSObj.Lines.UnitOfMeasure)             + ' as UnitOfMeasure ,' +
                                        Floattostr(fdQty)                                   + ' as qty ,' +
                                        Quotedstr(SaleSObj.SaleClassname)                   + ' as POClassname,' +
                                        inttostr(SaleSObj.SaleClassId)                      + ' as POClassID';
                            if SaleSObj.Lines.UOMQtyBackOrder <= 0 then break;
                          end;
                        end;
                        Qry.Next;
                      end;
                    end;
                  Finally
                    DbSharedObjectsObj.DbSharedObj.ReleaseObj(Qry);
                  end;
                end;
                SaleSObj.Lines.Next;
              end;

              Logtext('update Start');
              if fsSQL <> '' then begin
                Qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
                try
                  Qry.SQl.text := fsSQL + ' order by Departmentname';
                  Qry.open;
                  if Qry.Recordcount > 0 then begin
                    Qry.First;
                    DepartmentId := 0;
                    fPO          := TPurchaseOrder.CreateWithNewConn(nil);

                    try
                      MakeNewPO;

                      While Qry.Eof = False do begin
                        SavenMakeNewInvoice(fpo.ID);
                        NewInvoiceLine;
                        NewPOLine;
                        Qry.Next;

                      end;
                      SavenFreeInvoice(False);

                    Finally
                      if fPO.Lines.count > 0 then begin
                        fPO.Save;
                        try
                          fPO.Comments      := trim(fPO.Comments + Nl + fPO.suppliername + '.Invoice(s) #' + MakeInvoice(JsonInvoices, aOwnerform));
                          SaleSObj.Comments := trim(SaleSObj.Comments + Nl + fPO.Comments);
                          Msg               := trim(Msg + Nl + fPO.Comments);
                          SaleSObj.PostDB;
                        Except
                          on E: Exception do begin
                          end;
                        end;
                        fPO.PostDB;
                        fPO.Connection.CommitTransaction;
                      end;
                      Freeandnil(fPO);
                    end;
                  end;
                finally
                  DbSharedObjectsObj.DbSharedObj.ReleaseObj(Qry);
                end;
              end;
            Except
              on E: Exception do begin
                MyDacConnForeignDB.RollbackTransaction;
              end;
            end;
          finally
            Freeandnil(MyDacConnForeignDB);
          end;
        end;
      finally
          try if JsonInvoices <> nil then JsonInvoices.Clear;Except end;
          try if JsonInvoices <> nil then JsonInvoices.Free ;Except end;
          try if JsonInvLine    <> nil then JsonInvLine:= nil       ;Except end;
          try if JsonInv      <> nil then JsonInv:= nil        ;Except end;
        end;
      CrossStockCompanies.Next;
    end;
  Finally
    Freeandnil(DBConForeignDB);
    Freeandnil(CrossStockCompanies);
  End;
end;

Function MakeInvoice(JsonInvoices: TJSONObject; aOwnerform: Tform): String;
begin
  if JsonInvoices.A['Invoices'].count = 0 then exit;
  clog(JsonInvoices.asString);
  try
    REsult := TCrossStockTransferInvoice.CreateInvoice(Appenv.AppDb.Server, JsonInvoices.S['dbname'], JsonInvoices.S['Logon_Name'], JsonInvoices, aOwnerform); // this thread does the printing of flstReceipt
    if Result = '' then REsult := '(None)'
  except
    on E: Exception do begin
    end;
  end;
end;
end.
