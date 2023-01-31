unit SalesForPOAutoCreate;

interface

Uses
  JSONObject,Classes, busobjsalebase , IntegerListObj , forms, busobjorders;

Function CreateSalesForPO(POObj :TPurchaseorder; LineID:Integer; ccfieldname:String; var Msg:String; aOwnerform:Tform):Boolean;
Function MakeInvoice(JsonInvoices: TJSONObject; aOwnerform: Tform): String;


implementation

uses  ERPdbComponents, busobjstockTransferentry, PQALib, dateutils,
  ProductQtyLib, DbSharedObjectsObj, CommonDbLib, tcConst , sysutils,
  BusobjCrossStockCompanies, AppEnvironment, BusObjClient, BusObjBase,
  busobjcompinfo, BusObjSales , MySQLConst, tcDataUtils, LogLib,
  ThreadObjForOtherDB , LogThreadLib, LogMessageTypes, CommonLib;



Function CreateSalesForPO(POObj :TPurchaseorder; LineID:Integer; ccfieldname:String; var Msg: String; aOwnerform: Tform): Boolean;
var
  CrossStockCompanies   : TCrossStockCompanies;
    DBConForeignDB      : TERPConnection;
    MyDacConnForeignDB  : TMyDacDataConnection;
    Qry                 : TERPQuery;
    dt                  : TDateTime;
//    fPO                 : TPurchaseOrder;
    DepartmentId        : Integer;
    fdQty               : Double;
    fsSQL               : String;
    JsonInvoices        : TJSONObject;
    JsonInv, JsonInvLine: TJSONObject;
    JsonArrayInvoices   : TJsonArray;
    JsonArrayInvoiceLine: TJsonArray;
    ctr                 : Integer;

    ignorenegativeqtyinCC:Boolean;
    fdtotalQty:Double;


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
      JsonInv.S['Comments']          := 'Cross Stock Transfer for ' + trim(Appenv.CompanyInfo.CompanyName) +
                                        '.' +POObj.XMLNodeName + '#' + inttostr(POObj.ID);

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
  Procedure LocateCC;
  var
    fiCCId: Integer;
  begin
    if pos(Instock_Qty_fieldname , ccfieldname)>0 then begin
      ccfieldname := replacestr(ccfieldname ,Instock_Qty_fieldname , '');
      if isinteger(ccfieldname) then fiCCId := strtoint(ccfieldname);
    end;
    if pos(Available_Qty_fieldname , ccfieldname)>0 then begin
      ccfieldname := replacestr(ccfieldname ,Available_Qty_fieldname , '');
      if isinteger(ccfieldname) then fiCCId := strtoint(ccfieldname);
    end;

    if fiCCId <0 then exit;
    if CrossStockCompanies.locate(CrossStockCompanies.idfieldname ,fiCCId, []) then begin
      CrossStockCompanies.filter := 'ID = ' + inttostr(CrossStockCompanies.ID);
      CrossStockCompanies.filtered := true;
      ignorenegativeqtyinCC := True;
    end;
  end;
  Procedure CheckforAvailableQtyfromCC;
  begin
      try
        Qry := DbSharedObjectsObj.DbSharedObj.GetQuery(DBConForeignDB);
        try
          Qry.SQl.text := SQL4ProductQty(dt, POObj.Lines.UnitOfMeasure, tSummary,
                        GetProduct(POObj.Lines.productname, DBConForeignDB), 0, '', 0, '', '', '', tAvailable,
                        '', '', 0, True, True, True, True, True) + ' Order by DepartmentId';
          Qry.open;
          if Qry.Recordcount > 0 then begin
            Qry.First;
            if fdtotalQty >0 then begin
              While Qry.Eof = False do begin
                if (fdtotalQty > 0) and (Qry.Fieldbyname('UOMQty').AsFloat > 0) then begin
                  if fdtotalQty> Qry.Fieldbyname('UOMQty').AsFloat then fdQty := Qry.Fieldbyname('UOMQty').AsFloat
                  else fdQty  := fdtotalQty;

                  if fdQty > 0 then begin
                    fdtotalQty:= fdtotalQty -fdQty;
                    if fsSQL <> '' then fsSQL := fsSQL + ' union ';
                    fsSQL := fsSQL + 'Select ' +
                            inttostr(Qry.Fieldbyname('DepartmentID').asInteger) + ' as DepartmentID, ' +
                            Quotedstr(Qry.Fieldbyname('classname').asString)    + ' as Departmentname, ' +
                            Quotedstr(POObj.Lines.productname)               + ' as Productname ,' +
                            Quotedstr(POObj.Lines.UnitOfMeasure)             + ' as UnitOfMeasure ,' +
                            Floattostr(fdQty)                                   + ' as qty ,' +
                            Quotedstr(POObj.Lines.LineClassName)                   + ' as POClassname,' +
                            inttostr(POObj.Lines.LineClassID)                      + ' as POClassID';
                    if fdtotalQty <= 0 then break;
                  end;
                end;
                Qry.Next;
              end;
            end;
          end;

          {if qty not available in any departemnt of the selectd class, sell it from the default class }
          if (fdtotalQty >0) and (ignorenegativeqtyinCC) then begin
            closedb(Qry);
            Qry.sql.Text := 'select C.classId, classname '+
                            ' from tblcolumnheadings CI inner join tblclass C on CI.defaultClass  = C.classname';
            opendb(Qry);
            if Qry.RecordCount >0 then begin
              if fsSQL <> '' then fsSQL := fsSQL + ' union ';
              fsSQL := fsSQL + 'Select ' +
                          inttostr(Qry.FieldByName('classid').AsInteger) + ' as DepartmentID, ' +
                          Quotedstr(Qry.FieldByName('classname').asString)    + ' as Departmentname, ' +
                          Quotedstr(POObj.Lines.productname)               + ' as Productname ,' +
                          Quotedstr(POObj.Lines.UnitOfMeasure)             + ' as UnitOfMeasure ,' +
                          Floattostr(fdtotalQty)                                   + ' as qty ,' +
                          Quotedstr(POObj.Lines.LineClassName)                   + ' as POClassname,' +
                          inttostr(POObj.Lines.LineClassID)                      + ' as POClassID';
            end;
          end;
        Finally
          DbSharedObjectsObj.DbSharedObj.ReleaseObj(Qry);
        end;
       {total Qty ordered}
       fdQty:=POObj.Lines.UOMQtysold - fdtotalQty;
      finally
        logtext(fsSQL);
      end;
  end;
  Procedure MakeJsonInvoice;
  begin
    if fsSQL = '' then exit;
    Qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
      Qry.SQl.text := fsSQL + ' order by Departmentname,DepartmentID';
      Qry.open;
      if Qry.Recordcount > 0 then begin
        Qry.First;
        try
          DepartmentId := -1;
          While Qry.Eof = False do begin
            logtext('recno :' + inttostr(Qry.recno));
            SavenMakeNewInvoice(POObj.ID);
            NewInvoiceLine;
            Qry.Next;
          end;
          SavenFreeInvoice(False);
        Finally
              logtext(JsonInvoices.asString);
              logtext('making ' + Appenv.companyprefs.CrosscompanySalesForPOTypeDesc);
              POObj.Comments      := trim(POObj.Comments +  ' ' +NL +
                                      Appenv.companyprefs.CrosscompanySalesForPOTypeDesc+ '(s) #' +
                                      MakeInvoice(JsonInvoices, aOwnerform))+ ' ' +NL+
                                      'are Created in '+ Quotedstr(JsonInvoices.S['Dbname'])  +  ' ' +NL+
                                      'for Product : ' + Quotedstr(POObj.Lines.productname) +'.' ;
              Msg               := trim(Msg +  ' ' +NL + POObj.Comments);
              logtext('Msg:'+Msg);
              POObj.PostDB;
        end;
      end;
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(Qry);
    end;
  end;
begin
  REsult              := False;
  ignorenegativeqtyinCC := False;
  JsonInvLine:= nil;
  JsonInv:= nil;
  DBConForeignDB := nil;
  CrossStockCompanies := TCrossStockCompanies.Create(POObj);
  Try
    CrossStockCompanies.Connection := POObj.Connection;
    CrossStockCompanies.Load;
    if CrossStockCompanies.count = 0 then exit;

      LocateCC;
      if (CrossStockCompanies.count = 1) and (sametext(CrossStockCompanies.dbname, Appenv.AppDb.Database)) then exit;
      CrossStockCompanies.First;
      dt := incsecond(Poobj.orderdate, 1);
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
{--------------}if POObj.Lines.Locate('PurchaselineID' , LineID , []) then begin
                  fdtotalQty :=POObj.Lines.UOMQtysold;
                  CheckForAvailableQtyfromCC;;
{--------------}end;
              Logtext('update Start');
              MakeJsonInvoice;
              REsult := True;
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
          try if JsonInvLine  <> nil then JsonInvLine:= nil ;Except end;
          try if JsonInv      <> nil then JsonInv:= nil     ;Except end;
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
  logtext(JsonInvoices.asString);
  try
    REsult := TCrossStockTransferInvoice.CreateInvoice(Appenv.AppDb.Server, JsonInvoices.S['dbname'], JsonInvoices.S['Logon_Name'], JsonInvoices, aOwnerform); // this thread does the printing of flstReceipt
    if Result = '' then REsult := '(None)'
  except
    on E: Exception do begin
    end;
  end;
end;

end.
