unit GoogleAnalyticLib;

interface

uses BusObjBase;

    Procedure GArecordstoBeposted(Ids: String; TableName:String);
    function PostAll(Ids:String):Boolean;

implementation

uses  Classes, CommonDbLib, BusobjGoogleAnalytic_ERPlink, busobjExpenses, sysutils,
  AppEnvironment , Progressdialog, CommonLib, tcConst;

{ TGaPosting }
Procedure GArecordstoBeposted(Ids:String; TableName:String);
begin
  With Commondblib.TempMyScript do try
    SQL.Add('Drop table if Exists ' +tablename+';');
    SQL.Add('Create table ' +tablename  +
                      (*' Select ' +
                      ' GAcost.UId CostID, ' +
                      ' GAA.AccountName , ' +
                      ' GAP.Title , ' +
                      ' GAcost.Campaign , ' +
                      ' GAcost.Adword , ' +
                      ' GAcost.DateTime , ' +
                      ' GAcost.Cost , ' +
                      ' GAcost.CostPerTransaction, ' +
                      ' GAcost.costPerconversion , ' +
                      ' GAcostCheque.amountPosted , ' +
                      ' S.MediaType defaultsource, ' +
                      ' S.Account as AccountIDForPosting, ' +
                      ' COA.AccountName AccountForPosting, ' +
                      ' max(GAcostCheque.PurchaseOrderId ) PurchaseOrderId, ' +
                      ' max(GAcostCheque.PurchaseLineID) PurchaseLineID, ' +
                      ' DATEDIFF(GAcost.DtCostchecked , GAcost.DtcostUpdated) dayssinceupdatetolastcheck ' +
                      ' from ' +
                      ' tbltgaaccount GAA ' +
                      ' inner join tbltgaprofile GAP on GAA.uid = GAP.Ref_TGaAccount ' +
                      ' left join (tbltga_erp_source GAPs ' +
                      ' inner join tblsource S on GAPs.SourceID = S.MedTypeID ' +
                      ' inner join tblchartofaccounts COA on COA.AccountID = S.account) on GAP.UId = GAPs.ga_ProfileId and GAPs.isDefaultSource ="T" ' +
                      ' inner join  tbltgadataforcost GAcost on GAcost.ProfileId = GAP.ProfileId ' +
                      ' Left join tbltga_erp_Postings GAcostCheque on GAcost.UId = GAcostCheque.gacostId ' +
                      ' where GAcost.UId in (' + Ids+') ' +
                      ' group by GAcost.UId ' +
                      ' Order by  GAcost.DateTime, GAA.AccountName , GAP.Title , GAcost.Campaign , GAcost.Adword ;' );*)
                      ' Select ' +
                      ' GC.UId AS CostID, ' +
                      ' GA.AccountName  AS AccountName, ' +
                      ' GC.Campaign  AS Campaign, ' +
                      ' GC.Adword  AS Adword, ' +
                      ' GC.DateTime  AS DateTime, ' +
                      ' GC.Cost  AS Cost, ' +
                      ' GC.CostPerTransaction  AS CostPerTransaction, ' +
                      ' GC.costPerconversion   AS costPerconversion, ' +
                      ' GA.erpAccountName as AccountForPosting, ' +
                      ' Sum(GAcostCheque.amountPosted)  AS amountPosted, ' +
                      ' Sum(POL.totalLineAmountinc)  AS Billamount, ' +
                      ' max(GAcostCheque.PurchaseOrderId )  AS PurchaseOrderId, ' +
                      ' max(GAcostCheque.PurchaseLineID)  AS PurchaseLineID ' +
                      ' from tbltgadataforcost GC ' +
                      ' inner join tbltgacampaigns C on GC.CampaignID = C.CampaignID ' +
                      ' inner join tbltgaaccount GA on GA.AccountId = C.AccountID ' +
                      ' Left join tbltga_erp_Postings GAcostCheque on GC.UId = GAcostCheque.gacostId ' +
                      ' Left join tblpurchaselines POL on POL.PurchaseLineID =  GAcostCheque.PurchaseLineID ' +
                      ' where GC.UId in (' + Ids+') ' +
                      ' group by GC.UId ' +
                      ' Order by GC.DateTime desc, GC.Campaign , GC.Adword; ' );

    SQL.Add('ALTER TABLE '+tablename +' 	ADD COLUMN `id` INT NULL AUTO_INCREMENT , 	ADD PRIMARY KEY (`id`);');
    SQL.Add('Alter table ' + tablename + ' Add column done enum("T","F") default "F";');
    SQL.Add('update ' + tablename + ' set done  = "F";');
    SQL.Add('Alter table ' + tablename + ' Add column userlocked enum("T","F") default "F";');
    SQL.Add('update ' + tablename + ' set userlocked  = "F";');
    SQL.Add('Alter table ' + tablename + ' Add column TransLocked enum("T","F") default "F";');
    SQL.Add('update ' + tablename + ' set TransLocked  = "F";');
    Execute;
  finally
    Free;
  end;
end;

function PostAll(Ids: String): Boolean;
var
  GADataForCost :TGADataForCost;
  POID:Integer;
  tablename :String;
  billobj :TBill;
  st:TStringlist;
  Amt:Double;
  Conn : TMyDacDataConnection;
  Progress: TProgressDialog;

  Procedure GoogleCostbilled(BillLine:TBilllines;CostID :Integer;Amt:Double);
  begin
    With BillLine.GA_ERP_Posting do begin
      if count=0 then begin
        new;
        gacostId :=  CostID;
        amountPosted:= 0;
      end;
      amountPosted:=amountPosted+Amt;
      PostDb;
    end;
  end;
  Procedure LockBills;
  begin
      With GADataForCost.GetNewdataset('Select distinct PurchaseOrderId from '+tablename + ' where ifnull(PurchaseOrderID,0)<> 0 order by PurchaseOrderID ') do try
        if recordcount >0 then begin
          first;
          DoShowProgressbar(Recordcount , WAITMSG);
          try
            billobj :=TBill.Create(Conn);
            try
              billobj.Connection := Conn;
              While Eof = False do begin
                Billobj.Load(FieldByname('PurchaseOrderID').AsInteger);
                if Billobj.Count >0 then begin
                  if Billobj.AccessManager.AccessLevel<> 1 then st.Add('update ' +tablename +' set translocked ="T" where PurchaseOrderId = ' + inttostr(Billobj.ID)+';' )
                  else if not(Billobj.UserLock.Lock(Billobj.GetBusObjectTablename , Billobj.ID)) then st.Add('update ' +tablename +' set userlocked ="T" where PurchaseOrderId = ' + inttostr(Billobj.ID)+';' );
                end;
                DoStepProgressbar;
                Next;
              end;
              if st.Count >0 then
                CommonDbLib.ExecuteSQL(st.Text);
            finally
              FreeandNil(Billobj);
            end;
          Finally
            DoHideProgressbar;
          end;
        end;
      finally
        if active then close;
        Free;
      end;
  end;

  Procedure UpdateBills;
  begin
          With GADataForCost.GetNewdataset('Select * from '+tablename + ' where ifnull(PurchaseOrderID,0)<> 0 and userlocked ="F" and translocked ="F" order by PurchaseOrderID ') do try
              if recordcount > 0 then begin
                First;
                DoShowProgressbar(Recordcount , WAITMSG);
                try
                  While Eof = False do begin
                    POID := FieldByname('PurchaseOrderID').AsInteger;
                    billobj :=TBill.Create(conn);
                    try
                      billobj.Connection := Conn;
                      billobj.Load(poid);
                      billobj.connection.BeginNestedTransaction;
                      try
                        While (Eof=False) and (POID = FieldByname('PurchaseOrderID').AsInteger) do begin
                          Amt := Fieldbyname('Cost').AsFloat - Fieldbyname('amountPosted').AsFloat;
                          if (billobj.Lines.Locate(billobj.Lines.IDfieldname , fieldbyname('purchaselineID').AsInteger , [])) and (Billobj.Lines.AccountName = Fieldbyname('AccountForPosting').asString) then else begin
                            {this shouldn't happen}
                            billobj.Lines.New;
                            billobj.Lines.AccountName := Fieldbyname('AccountForPosting').asString;
                            billobj.Lines.ProductDescription := (*fieldbyname('Title').AsString +'.'+*)fieldbyname('Campaign').AsString +'.'+fieldbyname('adword').AsString +'.Dt:'+formatdatetime(FormatSettings.ShortDateFormat ,  fieldbyname('DateTime').asDatetime);
                            billobj.Lines.LineCostInc := 0;
                            billobj.Lines.postDB;
                          end;
                          billobj.Lines.LineCostInc := billobj.Lines.LineCostInc + Amt;
                          billobj.Lines.postDB;
                          GoogleCostBilled(Billobj.Lines, fieldbyname('CostID').AsInteger,Amt);
                          DoStepProgressbar;
                          Next;
                        end;
                        Billobj.DoCalcOrderTotals;
                        if Billobj.Save then begin
                          Billobj.Connection.CommitNestedTransaction;
                          Billobj.ExecuteSQL('update ' +tablename +' set Done = "T" where purchaseOrderId = ' +inttostr(Billobj.ID) );
                        end else begin
                          Billobj.Connection.RollbackNestedTransaction;
                        end;
                      Except
                        on E:Exception do begin
                          Billobj.Connection.RollbackNestedTransaction;
                        end;
                      end;
                    finally
                      Freeandnil(Billobj);
                    end;
                  end;
                finally
                   DoHideProgressbar;
                end;
              end;
            finally
              if active then close;
              Free;
            end;
      end;
Procedure CreateNewBill;
begin
            st.Clear;
            With GADataForCost.GetNewdataset('Select * from '+tablename + ' where (Done ="F" and translocked ="T") or (ifnull(PurchaseOrderId,0)=0)') do try
              if recordcount > 0 then begin
                First;
                DoShowProgressbar(Recordcount , WAITMSG);
                try
                  billobj :=TBill.Create(conn);
                  try
                    billobj.Connection := Conn;
                    billobj.Load(0);
                    billobj.connection.BeginNestedTransaction;
                    try
                      billobj.New;
                      billobj.SupplierName := appenv.companyprefs.SupplierforautoPostingGoogle;
                      billobj.postdb;
                      While Eof = False do begin
                        billobj.Lines.New;
                        billobj.Lines.ProductDescription := (*fieldbyname('Title').AsString +'.'+*)fieldbyname('Campaign').AsString +'.'+fieldbyname('adword').AsString +'.Dt:'+formatdatetime(FormatSettings.ShortDateFormat ,  fieldbyname('DateTime').asDatetime);
                        billobj.Lines.AccountName := Fieldbyname('AccountForPosting').asString;
                        Amt := Fieldbyname('Cost').AsFloat - Fieldbyname('amountPosted').AsFloat;
                        billobj.Lines.LinecostInc := Amt;
                        GoogleCostBilled(Billobj.Lines, fieldbyname('CostID').AsInteger,Amt);
                        billobj.Lines.postDB;
                        billobj.Lines.CalcLineTotals;
                        billobj.Lines.postDB;
                        st.Add(inttostr(fieldbyname('ID').AsInteger));
                        DoStepProgressbar;
                        Next;
                      end;
                      Billobj.DoCalcOrderTotals;
                      if Billobj.Save then begin
                          Billobj.Connection.CommitNestedTransaction;
                          Billobj.ExecuteSQL('update ' +tablename +' set Done = "T" where Id in ( ' +st.commaText +')' );
                      end else begin
                          Billobj.Connection.RollbackNestedTransaction;
                      end;
                    Except
                        on E:Exception do begin
                          Billobj.Connection.RollbackNestedTransaction;
                        end;
                    end;
                  finally
                      Freeandnil(Billobj);
                  end;
                finally
                   DoHideProgressbar;
                end;
              end;
            finally
              if active then close;
              Free;
            end;
end;
begin
  Progress := TProgressDialog.Create(nil);
  Try
    Progress.MinValue:= 1;
    result := False;
    if Ids= '' then exit;
    Conn := TMyDacDataConnection.Create(Nil);
    try
      Conn.Connection := GetNewMyDacConnection(conn);
      Conn.BeginTransaction;
      try
        st:= Tstringlist.Create;
        try
          GADataForCost := TGADataForCost.CreateWithNewConn(nil);
          try
            Tablename:= commondblib.GetUserTemporaryTableName('GaPosting');
            GArecordstoBeposted(Ids , Tablename);
            Lockbills;    {Lock the existing bills to update}
            UpdateBills;  {update the existing Bills}
            CreateNewBill;{Create new Bill}
          finally
            Freeandnil(GADataForCost);
          end;
        finally
          Freeandnil(st);
        end;
        Conn.CommitTransaction;
        Result:= True;
      Except
        on E:Exception do begin
           Conn.RollbackTransaction;
        end;
      end;
    finally
      Freeandnil(Conn);
    end;
  finally
    Freeandnil(Progress);
  end;
end;

end.

