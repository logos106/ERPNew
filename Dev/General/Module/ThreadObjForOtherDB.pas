unit ThreadObjForOtherDB;

interface

  uses
    Classes, JSONObject, forms;

  type
    TThreadObjForOtherDB = class(TThread)
    private
      fjsonInvoice: TJsonObject;
      fsIds       : String;
      fsErrMsgs   : String;
      fOwnerform  : TForm;
      fsServer    : String;
      fsDatabase  : String;
      fsUserName  : String;
    protected
      procedure DoExecute;Virtual;
      procedure Execute; override;
    Public
      Constructor create(aServer, aDatabase, aUser: String; ajsonInvoice: TJsonObject; aOwnerform: TForm); overload;
      Destructor Destroy; Override;
      Property IDs: String read fsIds write fsIds;
      Property ErrMsgs: String read fsErrMsgs write fsErrMsgs;
      Property Ownerform: TForm read fOwnerform write fOwnerform;
      Property Server: String read fsServer write fsServer;
      Property Database: String read fsDatabase write fsDatabase;
      Property UserName: String read fsUserName write fsUserName;

    end;
    TCrossStockTransferInvoice = class(TThreadObjForOtherDB)
    Protected
      procedure DoExecute;Override;
    Public
      Class Function CreateInvoice(aServer, aDatabase, aUser: String; jsonInvoice: TJsonObject; aOwnerform: TForm): String;
    end;



implementation

  uses AppEnvironment, BusObjSales, sysutils, busobjcompinfo, BusObjClient,
    BusObjBase, ERPdbComponents, CommonDbLib, tcConst, CommonLib, dialogs, ActiveX,
    ProgressDialog, LogThreadLib, LogMessageTypes;

Class Function TCrossStockTransferInvoice.CreateInvoice(aServer, aDatabase, aUser: String; jsonInvoice: TJsonObject; aOwnerform: TForm): String;
  var
    th: TThreadObjForOtherDB;
  begin
    //Logger.Log('Creating Invoice',ltBlank);
    th := TCrossStockTransferInvoice.create(aServer, aDatabase, aUser, jsonInvoice, aOwnerform);
    try
      try
        DoShowProgressbar(10, 'Cross Stock Transfer from : ' + aDatabase);
        try
          while (not th.Terminated) do begin
            Application.ProcessMessages;
            Sleep(500);
            DoStepProgressbar('');
          end;
        finally
          DoHideProgressbar;
        end;
      Except
        on E: Exception do begin
          MessageDlgXP_vista(E.message, mtWarning, [mbOK], 0);
        end;
      end;
      Result := th.IDs;
      if Result = '' then
        if Th.ErrMsgs <> '' then
          Result := Appenv.companyprefs.CrosscompanySalesForPOTypeDesc + ' Creation Failed : '+ Th.ErrMsgs;
    finally
      Freeandnil(th);
    end;
  end;
  { TThreadObjForOtherDB }

  constructor TThreadObjForOtherDB.create(aServer, aDatabase, aUser: String; ajsonInvoice: TJsonObject; aOwnerform: TForm);
  begin
    fOwnerform := nil;
    fsServer   := '';
    fsDatabase := '';
    fsUserName := '';
    fsIds      := '';
    fsErrMsgs  := '';
    try
      Ownerform    := aOwnerform;
      Server       := aServer;
      Database     := aDatabase;
      UserName     := aUser;
      fjsonInvoice := ajsonInvoice;
    Except
      on E: Exception do begin
        MessageDlgXP_vista(E.message, mtWarning, [mbOK], 0);
      end;
    end;

    FreeonTerminate := False;
    inherited create(False);
  end;

  procedure TThreadObjForOtherDB.Execute;
  begin
    Appenv.Appdb.AcceptBlankPassword := True;
    Appenv.Appdb.Server              := fsServer;
    Appenv.Appdb.Database            := fsDatabase;
    try
      Appenv.Appdb.ConnectUser(fsUserName, '');
    Except
      on E: Exception do begin
        MessageDlgXP_vista(E.message, mtWarning, [mbOK], 0);
        Exit;
      end;
    end;
    CoInitialize(nil);
    try
      DoExecute;
    finally
      CoUninitialize;
      Terminate;
    end;
  end;

  destructor TThreadObjForOtherDB.Destroy;
  begin
    inherited;
  end;

  procedure TThreadObjForOtherDB.DoExecute;
  begin
    //
  end;

{ TCrossStockTransferInvoice }


{ TCrossStockTransferInvoice }

procedure TCrossStockTransferInvoice.DoExecute;
  var
    i1, i2     : Integer;
    SalesObj   : TSales;//TInvoice;
    invj, Lines: TJsonObject;
    CompanyInfo: TCompanyInfo;
    CustomerID : Integer;
    Customer   : TCustomer;

    Procedure CreateSupplier(dbname: String);
    var
      DBConn: TERPConnection;
    begin
      CompanyInfo := TCompanyInfo.create(Ownerform);
      try
        CompanyInfo.Connection            := TMyDAcDataconnection.create(CompanyInfo);
        DBConn                            := GetNewMyDacConnection(CompanyInfo, dbname);
        CompanyInfo.Connection.Connection := DBConn;
        CompanyInfo.Load;

        CustomerID := 0;
        Customer   := TCustomer.CreateWithNewConn(Ownerform);
        try
          try
            Customer.silentMode := True;
            Customer.MakeClientFromCmpanyInfo(CompanyInfo, False, True, False);

            Customer.Connection.CommitTransaction;
            CustomerID := Customer.ID;
          Except
            on E: Exception do begin
              Customer.Connection.RollbackTransaction;
              Exit;
            end;
          end;
        finally
          Freeandnil(Customer);
        end;
      finally
        Freeandnil(DBConn);
        Freeandnil(CompanyInfo);
      end;
    end;
    Function NewSalesins:TSales;
    begin
      if Appenv.companyprefs.CrosscompanySalesForPOType ='I' then
        Result := TInvoice.CreateWithNewConn(Ownerform)
      else Result := TSalesOrder.CreateWithNewConn(Ownerform);
    end;

  begin
    inherited;
    try
      try
        fsIds     := '';
        fsErrMsgs := '';

        if fjsonInvoice.A['Invoices'].count = 0 then Exit;
        for i1 := 0 to fjsonInvoice.A['Invoices'].count - 1 do begin
          invj := fjsonInvoice.A['Invoices'].items[i1].AsObject;
          if (invj.A['Lines'].count > 0) and sametext(invj.S['Dbname'], Database) then begin
            try
              SalesObj := NewSalesins;//TInvoice.CreateWithNewConn(Ownerform);
              try
                SalesObj.Load(0);
                SalesObj.Connection.BeginTransaction;
                try
                  SalesObj.silentMode := True;
                  SalesObj.New;
                  if invj.B['SourceDBCustomer'] and (invj.S['SourceDBName'] <> '') then begin
                    CreateSupplier(invj.S['SourceDBName']);
                    SalesObj.CustomerID := CustomerID;
                  end
                  else begin
                    SalesObj.Customername := invj.S['CustomerName'];
                  end;
                  SalesObj.SaleDate          := invj.DT['SaleDate'];
                  SalesObj.saledatetime      := invj.DT['saledatetime'];
                  if trim(invj.S['SaleClassName']) <> '' then SalesObj.SaleClassName     := invj.S['SaleClassName'];
                  SalesObj.Comments          := invj.S['Comments'];
                  SalesObj.EmployeeLogonName := invj.S['EmployeeLogonName'];
                  SalesObj.PostDB;
                  for i2  := 0 to invj.A['Lines'].count - 1 do begin
                    Lines := invj.A['Lines'].items[i2].AsObject;
                    SalesObj.Lines.New;
                    SalesObj.Lines.Productname   := Lines.S['productname'];
                    SalesObj.Lines.UnitOfMeasure := Lines.S['UnitOfMeasure'];
                    SalesObj.Lines.UOMQtySold    := Lines.F['UOMQtySold'];
                    SalesObj.Lines.UOMQtyShipped := Lines.F['UOMQtyShipped'];
                    SalesObj.Lines.PostDB;
                  end;
                  if SalesObj.Save then begin
                    SalesObj.Connection.CommitTransaction;
                    if fsIds <> '' then fsIds := fsIds + ',';
                    fsIds                     := fsIds + inttostr(SalesObj.ID);
                  end
                  else begin
                    if fsErrMsgs <> '' then fsErrMsgs := fsErrMsgs + NL;
                    fsErrMsgs                         := SalesObj.ResultStatus.Messages;
                    SalesObj.Connection.RollbackTransaction;
                  end;
                Except
                  on E: Exception do begin
                    if fsErrMsgs <> '' then fsErrMsgs := fsErrMsgs + NL;
                    fsErrMsgs                         := SalesObj.ResultStatus.Messages + NL + E.message;
                    SalesObj.Connection.RollbackTransaction;
                  end;
                end;
              finally
                Freeandnil(SalesObj);
              end;

            Except
              on E: Exception do begin
                MessageDlgXP_vista(E.message, mtWarning, [mbOK], 0);
              end;
            end;
          end;
        end;
        Except
          on E:Exception do begin
            //Logger.Log('Error in SalesObj Creation:' +E.message,ltBlank);
          end;
        end;
      finally
        //Logger.Log('Done - SalesObj Creation',ltBlank);
      end;
end;

end.
