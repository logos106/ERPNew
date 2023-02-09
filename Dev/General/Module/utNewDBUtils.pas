unit utNewDBUtils;

interface

uses
  MyAccess, WebAPILib,JSONObject, AppEnvironment, ERPDbComponents, ProgressDialog;

const
  VS1DBDefaultListTables : Array [1 .. 6 ] of Array[1..2] of String   =    (('tblchartofaccounts' ,'Accountname'),
                                                                            ('tblclients'         ,'Company'),
                                                                            ('tblparts'           ,'Partname'),
                                                                            ( 'tblpaymentmethods' ,'NAME'),
                                                                            ('tbltaxcodes'        ,'NAME'),
                                                                            ('tblterms'           , 'Terms'));
{UPDATE tblparts SET PublishOnVS1 ="T" WHERE parttype ="INV"
UPDATE tblchartofaccounts SET PublishOnVS1 ="T"
UPDATE tblclients SET PublishOnVS1 ="T"
UPDATE tblpaymentmethods SET PublishOnVS1 ="T"
UPDATE tbltaxcodes SET PublishOnVS1 ="T"  WHERE regionid = 1
UPDATE tblterms SET PublishOnVS1 ="T"
}
type

  TNewDbUtils = class
  private
  public
    class procedure SetNewCompanyDefaultValues(const sNewDBName, aNewRegionName: string;
      InitialiseAdminOnlyAccess, UpdateAccountsTaxCodes: boolean; conn: TMyConnection;aOnEvent:TEventProc; IsVS1Database:Boolean = False);
    Class Procedure InitCompInfo(conn:TMyConnection; aclientName:String;aOnEvent:TEventProc);
    Class Function  InitEmployee(conn:TMyConnection; fsVs1_RegJs:String;aOnEvent:TEventProc; DisableAdmin:Boolean = True;createuserifmissing:Boolean = true):Boolean;
    class Function PublishTablesOnVS1(conn: TMyConnection; aNewRegionName:String;PublishAll :Boolean =False):String;

    class function CopyTransactions(ANewDB: string; AOnEvent: TEventProc; ADlg: TprogressDialog = nil) : Boolean;
    class function CreateDummyProduct(ANewConn: TERPConnection; APName: string) : Integer;
    class function CreateDummyAccount(ANewConn: TERPConnection; AAName: string) : Boolean;
    class function CreateTxnObjects(ANewConn: TERPConnection; APID: Integer; APName, AAname: string; ADlg: TprogressDialog = nil) : Boolean;
    class function CopyPO(ANewConn: TERPConnection; AOldConn: TERPConnection; AQuery: TERPQuery; APID: Integer; APName: string) : Boolean;
    class function CopyBill(ANewConn: TERPConnection; AQuery: TERPQuery; AAName: string) : Boolean;
    class function CopyCredit(ANewConn: TERPConnection; AQuery: TERPQuery; AAName: string) : Boolean;
    class function CopyCheque(ANewConn: TERPConnection; AQuery: TERPQuery; AAName: string) : Boolean;
    class function CopyRA(ANewConn: TERPConnection; AQuery: TERPQuery; AAName: string) : Boolean;
    class function CopyInvoice(ANewConn: TERPConnection; AQuery: TERPQuery; APID: Integer; APName: string) : Boolean;
    class function CopySO(ANewConn: TERPConnection; AQuery: TERPQuery; APID: Integer; APName: string) : Boolean;
    class function CopyQuote(ANewConn: TERPConnection; AQuery: TERPQuery; APID: Integer; APName: string) : Boolean;
    class function CreateStockTake(ANewConn: TERPConnection;APID: Integer; APName: string) : Boolean;
  end;

implementation

uses
  sysutils, {AppEnvironment,} SQLsLib , BusObjEmployee,
  BusObjBase, dnmlib, utVS1Const, StoredProcedures,
  utCloudconst, LogLib, Classes, Dialogs, CommonLib, Controls,
  BusobjProduct, BusObjGLAccount, CommonDbLib, busobjOrders, busobjExpenses,
  BusObjSales, BusobjStockAdjustEntry, ProcessDataUtils, tcConst, DateUtils;

{ TNewDbUtils }

class procedure TNewDbUtils.InitCompInfo(conn: TMyConnection; aclientName: String; aOnEvent:TEventProc);
var
  qry: TERPQuery;
begin
  try
    if aclientName ='' then exit;
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := conn;
      qry.SQl.text := 'SELECT * FROM tblcompanyinformation ';
      qry.open;
      if qry.RecordCount = 0 then qry.Append else qry.Edit;
      qry.Fieldbyname('CompanyName').AsString := aclientName;
      qry.Post;
    finally
      qry.Free;
    end;
  except
    on E:Exception do begin
      AddEventdata(aOnEvent, 'initcompInfo.Error', 'Initialising the Company Infor - Error :' + E.message);
    end;
  end;
end;

class Function TNewDbUtils.InitEmployee(conn: TMyConnection; fsVs1_RegJs: String; aOnEvent: TEventProc; DisableAdmin: Boolean = True; createuserifmissing: Boolean = True): Boolean;
var
  Vs1_RegJs: TJsonObject;
  qry: TERPQuery;
  fiEmployeeId: Integer;
begin
  Result := False;
  Vs1_RegJs := JO(fsVs1_RegJs);
  try
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := conn;
      if DisableAdmin then begin
        qry.SQl.Text := 'SELECT * FROM tblemployees WHERE FirstName=' + QuotedStr('Admin') + ' AND LastName=' + QuotedStr('.');
        qry.Open;
        if qry.Recordcount > 0 then begin
          qry.Edit;
          qry.Fieldbyname('Active').AsBoolean := False;
          qry.Post;
        end;
      end;

      {create the default User }
      qry.Close;
      qry.SQl.Text := 'SELECT * FROM tblemployees WHERE FirstName=' + QuotedStr(ERP_VS1CLOUD_DEFAULT_USERFirstName) + ' AND LastName=' + quotedstr(ERP_VS1CLOUD_DEFAULT_USERLastName);
      qry.Open;
      if (qry.RecordCount = 0) and not(createuserifmissing) then Exit;

      if (qry.RecordCount = 0) and createuserifmissing then begin
         qry.Append;
         qry.fieldbyname('FirstName').AsString    := ERP_VS1CLOUD_DEFAULT_USERFirstName;
         qry.fieldbyname('LastName').AsString     := ERP_VS1CLOUD_DEFAULT_USERLastName;
         qry.fieldbyname('EmployeeName').AsString := Trim(qry.fieldbyname('FirstName').asString)+' '+trim(qry.fieldbyname('LastName').asString);
         qry.fieldbyname('Email').AsString        := ERP_VS1CLOUD_DEFAULT_USER;
         qry.fieldbyname('Sex').AsString          := 'F';
         qry.fieldbyname('DateStarted').AsDatetime:= Date;
         qry.fieldbyname('DOB').AsDatetime        := Date;
         qry.Post;
      end;
      fiEmployeeId := qry.fieldbyname('EmployeeID').AsInteger;

      {full access to cloud and Access levels in ERP}
      qry.Close;
      qry.SQL.clear;
      qry.SQL.add('SELECT * FROM tblpassword WHERE EmployeeId = ' + IntToStr(fiEmployeeId));
      qry.Open;
      if (qry.RecordCount = 0) and not(createuserifmissing) then Exit;

      if createuserifmissing then begin
        if (qry.recordcount =0)  then begin
          qry.Append;
          qry.FieldByname('EmployeeId').AsInteger :=  fiEmployeeId;
        end else Qry.Edit;
        qry.FieldByname('Logon_name').asString    := ERP_VS1CLOUD_DEFAULT_USER;
        qry.FieldByname('Logon_password').asString:= EnCrypt(ERP_VS1CLOUD_DEFAULT_TOKEN, 'z');
        qry.Post;
        qry.Close;
        qry.SQL.clear;
        qry.SQL.Add('INSERT IGNORE INTO tblemployeeformsaccess '+
                    ' (EmployeeId, FormID, Access)  '+
                    ' SELECT '+ inttostr(fiEmployeeId)+' AS EmployeeId, FormID, 1 AS Access FROM tblforms ' +
                    ' WHERE (tabgroup = 26 ' +
                    ' OR formname LIKE "TAccessLevelsGUI" ' +
                    ' OR formname LIKE "FnRunBatch" ' +
                    ' OR formname LIKe "FnAllowInvoiceStockToNegative" ' +
                    ' OR ifnull(BusinessObjectName,"") <> "") ' +
                    ' AND (not(ifnull(BusinessObjectName,"") like "TVS1_%"));' );
        {NO access for VS1 objects - this is only for VS1_cloud admin database }
        qry.SQL.Add('INSERT IGNORE INTO tblemployeeformsaccess '+
                    ' (EmployeeId, FormID, Access)  '+
                    ' SELECT ' + inttostr(fiEmployeeId)+' AS EmployeeId, FormID, 6 AS Access FROM  tblforms;' );
        qry.Execute;
      end else begin
        Result := (qry.FieldByname('Logon_name').AsString = ERP_VS1CLOUD_DEFAULT_USER) and
            (qry.FieldByname('Logon_password').AsString = EnCrypt(ERP_VS1CLOUD_DEFAULT_TOKEN, 'z'))
      end;
      if fsVs1_RegJs = '' then Exit;

      if not(Vs1_RegJs.Exists('MakingExtraDB')) or (Vs1_RegJs.B['MakingExtraDB'] = False) then begin
          if not(Vs1_RegJs.Exists(VS1_TAG_FirstName)) or (Vs1_RegJs.S[VS1_TAG_FirstName] = '') then Exit;
          qry.Close;
          qry.SQl.Text := 'SELECT * FROM tblemployees WHERE FirstName=' + quotedstr(Vs1_RegJs.S[VS1_TAG_FirstName]) + ' AND LastName=' + QuotedStr(Vs1_RegJs.S['LastName']);
          qry.open;
          if qry.RecordCount = 0 then begin
             qry.Append;
             qry.FieldByName('FirstName').AsString    := Vs1_RegJs.S[VS1_TAG_FirstName];
             qry.FieldByName('LastName').AsString     := Vs1_RegJs.S[VS1_TAG_LastName];
             qry.FieldByName('EmployeeName').AsString := trim(qry.fieldbyname('FirstName').asString)+' '+trim(qry.fieldbyname('LastName').asString);
             qry.FieldByName('Phone').AsString        := Vs1_RegJs.S[VS1_TAG_PhoneNumber];
             if Vs1_RegJs.Exists('IsSampleDB') and Vs1_RegJs.B['IsSampleDB'] then begin
                qry.FieldByName('Email').AsString        := Vs1_RegJs.S[VS1_TAG_CloudSampleDBUserName];
             end else begin
                qry.FieldByName('Email').AsString        := Vs1_RegJs.S[VS1_TAG_CloudUserName];
             end;
             qry.FieldByName('Sex').AsString          := Vs1_RegJs.S[VS1_TAG_Sex];
             qry.FieldByName('DateStarted').AsDatetime:= Vs1_RegJs.DT[VS1_TAG_DateStarted];
             qry.FieldByName('DOB').AsDatetime        := Vs1_RegJs.DT[VS1_TAG_DOB];
             qry.Post;
          end;
          Vs1_RegJs.I['VS1EmployeeId'] := qry.FieldByName('EmployeeID').asInteger;

          {full access to cloud and Access levels in ERP}
          qry.Close;
          qry.SQL.clear;
          qry.SQL.add('SELECT * FROM tblpassword where EmployeeId = '+ inttostr(Vs1_RegJs.I[VS1_TAG_VS1EmployeeId]));
          qry.Open;
          if qry.recordcount =0 then begin
            qry.Append;
            qry.FieldByname('EmployeeId').AsInteger :=  Vs1_RegJs.I[VS1_TAG_VS1EmployeeId];
          end else Qry.Edit;
          if Vs1_RegJs.Exists('IsSampleDB') and Vs1_RegJs.B['IsSampleDB'] then begin
            qry.FieldByname('Logon_name').asString    := Vs1_RegJs.S[VS1_TAG_CloudSampleDBUserName];
            qry.FieldByname('Logon_password').asString:= EnCrypt(Vs1_RegJs.S[VS1_TAG_CloudSampleDBPassword],'z');
          end else begin
            qry.FieldByname('Logon_name').asString    := Vs1_RegJs.S[VS1_TAG_CloudUserName];
            qry.FieldByname('Logon_password').asString:= EnCrypt(Vs1_RegJs.S[VS1_TAG_CloudPassword],'z');
          end;
          qry.Post;
          qry.Close;
          qry.SQL.clear;
          qry.SQL.add('INSERT IGNORE INTO tblemployeeformsaccess '+
                      ' (EmployeeId, FormID, Access)  '+
                      ' SELECT '+ inttostr(Vs1_RegJs.I[VS1_TAG_VS1EmployeeId])+' AS EmployeeId, FormID , 1 AS Access FROM  tblforms  '+
                      ' WHERE (tabgroup = 26  '+
                      ' OR formname LIKE "TAccessLevelsGUI"  '+
                      ' OR formname LIKE "FnRunBatch"  '+
                    ' OR formname LIKe "FnAllowInvoiceStockToNegative"  '+
                      ' OR ifnull(BusinessObjectName,"") <> "")  '+
                      ' AND (not(ifnull(BusinessObjectName,"") like "TVS1_%"));' );
          {NO access for VS1 objects - this is only for VS1_cloud admin database }
          qry.SQL.add('INSERT IGNORE INTO tblemployeeformsaccess '+
                      ' (EmployeeId, FormID, Access)  '+
                      ' SELECT '+ inttostr(Vs1_RegJs.I[VS1_TAG_VS1EmployeeId])+' AS EmployeeId, FormID , 6 AS Access FROM  tblforms  '+
                      ' WHERE ((ifnull(BusinessObjectName,"") like "TVS1_%"));' );

          {remove access for the following by default}
          qry.SQL.add('INSERT IGNORE INTO tblemployeeformsaccess '+
                      ' (EmployeeId, FormID, Access)  '+
                      ' SELECT '+ inttostr(Vs1_RegJs.I[VS1_TAG_VS1EmployeeId])+' AS EmployeeId, FormID , 6 AS Access FROM  tblforms  '+
                      ' WHERE formname= "FnApptLimittedAcces" or  '+
                            ' formname = "CanOnlySeeownAppointments" or  '+
                            ' formname = "FnLaunchApptnAllocation" or  '+
                            ' formname = "FnLaunchApptnAppointment";' );

          qry.SQL.add('UPDATE tblemployeeformsaccess SET Access =6 '+
                      '  WHERE EmployeeId = '+ inttostr(Vs1_RegJs.I[VS1_TAG_VS1EmployeeId])+
                      ' AND FormID in   ('+
                      ' SELECT FormID FROM  tblforms  '+
                      ' WHERE formname= "FnApptLimittedAcces" or  '+
                            ' formname = "CanOnlySeeownAppointments" or  '+
                            ' formname = "FnLaunchApptnAllocation" or  '+
                            ' formname = "FnLaunchApptnAppointment");' );

          qry.Execute;
      end;
    finally
        qry.Free;
    end;
  except
    on E: Exception do begin
      AddEventdata(aOnEvent, 'InitEmployee.Error', 'Creating USer Error :' + E.message);
    end;
  end;

end;

class Function TNewDbUtils.PublishTablesOnVS1(conn: TMyConnection; aNewRegionName: String;
                                               PublishAll: Boolean = False): String;
var
   ctr1, ctr2: Integer;
   allTables : TStringList;

   function NewVS1DBDefaultListFor(const tblname: String): String;
   begin
      Result := 'Select Keyvalue from tblnewvs1dbdefaults where Tablename =' + quotedstr(tblname) +
        ' and (RegionName ="All" or RegionName = ' + quotedstr(aNewRegionName) + ')';
   end;

   function GetAllTables: TStringList;
   var
      qry: TERPQuery;
      tables: TStringList;
      tableName : string;
   begin
      try

         qry := TERPQuery.Create(nil);
         tables := TStringList.Create;

         try
            qry.Connection := conn;
            qry.SQl.Text := 'SHOW TABLES';
            qry.Open;

            while not qry.EOF do
            begin

               tableName := qry.Fields[0].asString;

               if Copy(tableName, 0, 3) = 'tbl' then
                  tables.add(tableName);

               qry.Next;
            end;

            Result := tables;

         finally
            qry.Close;
            qry.Free;
         end;
      except
         on E: Exception do
         begin
      case CommonLib.MessageDlgXP_Vista('Getting tables - Error :',mtConfirmation,[mbYes,mbNo,mbCancel],0) of
        mrYes: ;
        mrNo:  ;
        mrCancel: exit;
      end;
         end;
      end;
   end;

   function FieldExists(table: string; field : string): Boolean;
   var
      qry: TERPQuery;
      Fields: TStringList;
      fieldName: string;
   begin
      try

         qry := TERPQuery.Create(nil);
         Fields := TStringList.Create;

         try
            qry.Connection := conn;

            qry.SQL.Add( 'SHOW COLUMNS FROM `' + table + '` LIKE "'+ field + '"');

            qry.Open;

               fieldName := qry.Fields[0].asString;

               if  fieldName = field then
               begin
                  result := true;

               end
               else
               begin
                  result := false;
               end;

         finally
            qry.Close;
            qry.Free;
         end;
      except
         on E: Exception do
         begin
//            AddEventdata(aOnEvent, 'initcompInfo.Error', 'Initialising the Company Info - Error :' +
//              E.message);
      case CommonLib.MessageDlgXP_Vista('Getting table fields - Error :',mtConfirmation,[mbYes,mbNo,mbCancel],0) of
        mrYes: ;
        mrNo:   ;
        mrCancel: exit;
      end;
         end;
      end;
   end;

begin
  Result := '';

  if PublishAll then begin
    if Assigned(conn) then begin
       allTables := GetAllTables;
    end;

    for ctr1 := 0 to allTables.Count - 1 do begin
      if FieldExists(allTables[ctr1], 'PublishOnVS1') then
        Result := Result + 'UPDATE ' + allTables[ctr1] + '  Set PublishOnVS1 = "T";';
    end;
  end else begin
    for ctr1 := low(VS1DBDefaultListTables) to high(VS1DBDefaultListTables) do begin
      if PublishAll then
        Result := Result + 'UPDATE ' + VS1DBDefaultListTables[ctr1, 1] + ' SET PublishOnVS1 = "T";'
      else begin
        Result := Result + 'UPDATE ' + VS1DBDefaultListTables[ctr1, 1] +
          '  SET PublishOnVS1 = "F";';
        Result := Result + 'UPDATE ' + VS1DBDefaultListTables[ctr1, 1] +
          '  SET PublishOnVS1 = "T" ' + ' WHERE ' + VS1DBDefaultListTables[ctr1, 2] + ' IN (' +
          NewVS1DBDefaultListFor(VS1DBDefaultListTables[ctr1, 1]) + ');';
      end;
    end;
  end;
end;

class procedure TNewDbUtils.SetNewCompanyDefaultValues(const sNewDBName,
  aNewRegionName: string; InitialiseAdminOnlyAccess, UpdateAccountsTaxCodes: Boolean;
  conn: TMyConnection; aOnEvent:TEventProc; IsVS1Database: Boolean = False);
var
  qry: TERPQuery;
  script: TERPScript;
  PurchaseTaxcodeDefault, SalesTaxcodeDefault: String;
  ForiegnExCode: String;
(*    function NewVS1DBDefaultListFor(const tblname:String):String;
    begin
        result := 'Select Keyvalue from tblnewvs1dbdefaults where Tablename ='+quotedstr(tblname)+' and (RegionName ="All" or RegionName = '+ quotedstr(aNewRegionName)+')';
    end;*)
begin
try
  AddEventdata(aOnEvent, 'Progress', 'SetNewCompanyDefaultValues');
  qry := TERPQuery.Create(nil);
  script := TERPScript.Create(nil);
  try
    qry.Connection:= conn;  //AddEventdata(aOnEvent,'Progress', 'SetNewCompanyDefaultValues-03');
    script.Connection:= conn;  //AddEventdata(aOnEvent,'Progress', 'SetNewCompanyDefaultValues-04');
    try CreateSPs(nil, conn);Except end;  //AddEventdata(aOnEvent,'Progress', 'SetNewCompanyDefaultValues-05');
      //AddEventdata(aOnEvent,'Progress', 'SetNewCompanyDefaultValues-1');
    qry.SQL.Text:= 'UPDATE tbldbpreferences set FieldValue = ' + QuotedStr(aNewRegionName) + ' where Name = "CompanyRegion" and PrefType = "ptCompany"';
      //AddEventdata(aOnEvent,'NewCompanyDefaultValues', 'DB Region: ' + aNewRegionName);
    qry.Execute;
      //AddEventdata(aOnEvent,'Progress', 'SetNewCompanyDefaultValues-2');

    qry.SQL.Text:=
      'select ro.TaxCodePurchaseInc from tblregionaloptions ro ' +
      'where ro.Region = (select p.fieldvalue from tbldbpreferences p ' +
      'where p.name = "CompanyRegion")';
      //AddEventdata(aOnEvent,'NewCompanyDefaultValues', 'Check Tax Codes of Region- Purchase');
    qry.Open;
      //AddEventdata(aOnEvent,'Progress', 'SetNewCompanyDefaultValues-3');
    PurchaseTaxcodeDefault:= qry.FieldByName('TaxCodePurchaseInc').AsString;
      //AddEventdata(aOnEvent,'Progress', 'SetNewCompanyDefaultValues-4');
    qry.Close;
    qry.SQL.Text:=
      'select ro.TaxCodeSalesInc from tblregionaloptions ro ' +
      'where ro.Region = (select p.fieldvalue from tbldbpreferences p ' +
      'where p.name = "CompanyRegion")';
      //AddEventdata(aOnEvent,'NewCompanyDefaultValues', 'Check Tax Codes of Region- Sales');
    qry.Open;
      //AddEventdata(aOnEvent,'Progress', 'SetNewCompanyDefaultValues-5');
    SalesTaxcodeDefault:= qry.FieldByName('TaxCodeSalesInc').AsString;

    qry.Close;
    qry.SQL.Text:= 'select * from tbldbpreferences where name = ' +
      QuotedStr('DefaultPurchaseTaxCode');
      //AddEventdata(aOnEvent,'NewCompanyDefaultValues', 'Tax Codes Defaults- Purchase');
    qry.Open;
      //AddEventdata(aOnEvent,'Progress', 'SetNewCompanyDefaultValues-6');

      //AddEventdata(aOnEvent,'NewCompanyDefaultValues', 'Init Default Purchase TaxCode');
    if qry.IsEmpty then begin
      qry.Insert;
      qry.FieldByName('PrefType').AsString:= 'ptCompany';
      qry.FieldByName('Name').AsString:= 'DefaultPurchaseTaxCode';
      qry.FieldByName('FieldType').AsString:= 'ftString';
      qry.FieldByName('FieldSize').AsInteger:= 100;
    end
    else
      qry.Edit;
      //AddEventdata(aOnEvent,'Progress', 'SetNewCompanyDefaultValues-7');
    qry.FieldByName('FieldValue').AsString:= PurchaseTaxcodeDefault;
    qry.Post;


    AddEventdata(aOnEvent,'NewCompanyDefaultValues', 'Init Default Sales TaxCode');
    qry.Close;
    qry.SQL.Text:= 'select * from tbldbpreferences where name = ' +
      QuotedStr('DefaultSalesTaxCode');
    qry.Open;
    if qry.IsEmpty then begin
      qry.Insert;
      qry.FieldByName('PrefType').AsString:= 'ptCompany';
      qry.FieldByName('Name').AsString:= 'DefaultSalesTaxCode';
      qry.FieldByName('FieldType').AsString:= 'ftString';
      qry.FieldByName('FieldSize').AsInteger:= 100;
    end
    else
      qry.Edit;
    qry.FieldByName('FieldValue').AsString:= SalesTaxcodeDefault;
    qry.Post;

    qry.Close;

    AddEventdata(aOnEvent,'NewCompanyDefaultValues', 'Foreign Exchange');
    qry.SQL.Text:=
      'select ro.ForeignExDefault from tblregionaloptions ro ' +
      'where ro.Region = (select p.fieldvalue from tbldbpreferences p ' +
      'where p.name = "CompanyRegion")';
    qry.Open;

    ForiegnExCode := qry.FieldByName('ForeignExDefault').AsString;

    qry.Close;


    { now update the products with correct tax codes for new region }

    AddEventdata(aOnEvent,'NewCompanyDefaultValues', 'Regional Options');
    script.SQL.Add(SLNameUpdateSQL(aNewRegionName, ''));
    script.SQL.Add('update ignore tblcurrencyconversion set Active = "F", BuyRate = 0, SellRate = 0;');
    script.SQL.Add('update ignore tblcurrencyconversion set Active = "T", BuyRate = 1, SellRate = 1 ' + ' where Code = ' + QuotedStr(ForiegnExCode)+';');
    script.SQL.Add('insert ignore into tblproductclasses '+
                    ' (ProductId, ProductName, Classid, Classname)  '+
                    ' select P.PARTSID, P.PARTNAME , C.ClassID, C.ClassName  '+
                    ' from tblparts P, tblclass C  '+
                    ' where C.ClassName in (Select DefaultClass from tblcolumnheadings);');

    {update product's default tax codes with the region's taxcode if thats differnet }
    script.SQL.Add('UPDATE tblparts  '+
                    ' SET PURCHTAXCODE =(SELECT TaxCodePurchaseInc  FROM tblregionaloptions WHERE  region IN (SELECT Fieldvalue FROM tbldbpreferences WHERE NAME LIKE "%Region%"))  '+
                    ' WHERE NOT (PURCHTAXCODE IN (SELECT Name FROM tbltaxcodes WHERE regionid IN (SELECT regionid FROM tblregionaloptions WHERE  region IN (SELECT Fieldvalue FROM tbldbpreferences WHERE NAME LIKE "%Region%")))) ;');
    script.SQL.Add('UPDATE tblparts  '+
                    ' SET TAXCODE      =(SELECT TaxCodesalesInc     FROM tblregionaloptions WHERE  region IN (SELECT Fieldvalue FROM tbldbpreferences WHERE NAME LIKE "%Region%"))  '+
                    ' WHERE NOT (TAXCODE      IN (SELECT Name FROM tbltaxcodes WHERE regionid IN (SELECT regionid FROM tblregionaloptions WHERE  region IN (SELECT Fieldvalue FROM tbldbpreferences WHERE NAME LIKE "%Region%")))) ;');


    try
      script.Execute;
      AddEventdata(aOnEvent,'NewCompanyDefaultValues', 'Regional Options ... Done');
    Except
      on E:Exception do begin
        AddEventdata(aOnEvent,TAG_ResponseError, 'Error in Setting Default Values in the New DB :' + E.message);
      end;
    end;

    if InitialiseAdminOnlyAccess then begin
      { Employee Admin has full access }
      AddEventdata(aOnEvent,'NewCompanyDefaultValues', 'User Access');
      script.SQL.Clear;
      script.SQL.Add('truncate tblemployeeformsaccess;');
      script.SQL.Add('insert into tblemployeeformsaccess (EmployeeID , FormID , access) '+
                ' Select (Select EmployeeId from tblemployees where  tblemployees.FirstName ="Admin") ,  '+
                ' formID , 1  from tblForms where  tblForms.AccessLevels ="T";');
      try
        script.Execute;
      Except
        on E:Exception do begin
          AddEventdata(aOnEvent,TAG_ResponseError, 'Error in Setting User Access in New DB :' +E.message);
        end;
      end;
    end;


//    if not SameText(aNewRegionName, 'Australia') then begin
//      if (aNewRegionName = appEnv.CompanyPrefs.CompanyRegion ) AND (AppEnv.CompanyPrefs.CopyCOA or AppEnv.CompanyPrefs.CopyProducts) then
//        // tblChartOfAccounts data is copied from the current databse only, not from erpnewdb
//      else begin
//        { Need to update chart of accounts to correct taxcode }
//        script.SQL.Clear;
//        script.SQL.Add('drop table if exists tmp_taxxref;');
//        script.SQL.Add('create table tmp_taxxref (au_taxcode varchar(255), taxcode varchar(255))ENGINE=MEMORY;');
//        script.SQL.Add('insert into tmp_taxxref (au_taxcode, taxcode) values ((select TaxCodeSalesInc     from tblregionaloptions where region = "Australia" limit 1), (select TaxCodeSalesInc    from tblregionaloptions where region = '+QuotedStr(aNewRegionName)+' limit 1));');
//        script.SQL.Add('insert into tmp_taxxref (au_taxcode, taxcode) values ((select TaxCodeSalesEx      from tblregionaloptions where region = "Australia" limit 1), (select TaxCodeSalesEx     from tblregionaloptions where region = '+QuotedStr(aNewRegionName)+' limit 1));');
//        script.SQL.Add('insert into tmp_taxxref (au_taxcode, taxcode) values ((select TaxCodePurchaseInc  from tblregionaloptions where region = "Australia" limit 1), (select TaxCodePurchaseInc from tblregionaloptions where region = '+QuotedStr(aNewRegionName)+' limit 1));');
//        script.SQL.Add('insert into tmp_taxxref (au_taxcode, taxcode) values ((select TaxCodePurchaseEx   from tblregionaloptions where region = "Australia" limit 1), (select TaxCodePurchaseEx  from tblregionaloptions where region = '+QuotedStr(aNewRegionName)+' limit 1));');
//        script.SQL.Add('insert into tmp_taxxref (au_taxcode, taxcode) values ((select TaxCodeNoTax        from tblregionaloptions where region = "Australia" limit 1), (select TaxCodeNoTax from tblregionaloptions where region = '+QuotedStr(aNewRegionName)+' limit 1));');
//        script.SQL.Add('UPDATE tblChartOfAccounts set TaxCode = (Select taxcode from tmp_taxxref where au_taxcode = tblChartOfAccounts.TaxCode limit 1) where IfNull(tblChartOfAccounts.TaxCode,"") <> "";');
//        script.SQL.Add('drop table if exists tmp_taxxref;');
//        script.Execute;
//      end;
//    end;

    if UpdateAccountsTaxCodes then  begin
      { Need to update chart of accounts to correct taxcode }
      AddEventdata(aOnEvent,'NewCompanyDefaultValues', 'Default Accounts Tax Codes');
      script.SQL.Clear;
      script.SQL.Add('drop table if exists tmp_taxxref;');
      script.SQL.Add('create table tmp_taxxref (ID INT(11) NOT NULL AUTO_INCREMENT, au_taxcode varchar(255), taxcode varchar(255), PRIMARY KEY (ID))ENGINE=InnoDB;');
      script.SQL.Add('insert into tmp_taxxref (au_taxcode, taxcode) values ((select TaxCodeSalesInc     from tblregionaloptions where region = "Australia" limit 1), (select TaxCodeSalesInc    from tblregionaloptions where region = '+QuotedStr(aNewRegionName)+' limit 1));');
      script.SQL.Add('insert into tmp_taxxref (au_taxcode, taxcode) values ((select TaxCodeSalesEx      from tblregionaloptions where region = "Australia" limit 1), (select TaxCodeSalesEx     from tblregionaloptions where region = '+QuotedStr(aNewRegionName)+' limit 1));');
      script.SQL.Add('insert into tmp_taxxref (au_taxcode, taxcode) values ((select TaxCodePurchaseInc  from tblregionaloptions where region = "Australia" limit 1), (select TaxCodePurchaseInc from tblregionaloptions where region = '+QuotedStr(aNewRegionName)+' limit 1));');
      script.SQL.Add('insert into tmp_taxxref (au_taxcode, taxcode) values ((select TaxCodePurchaseEx   from tblregionaloptions where region = "Australia" limit 1), (select TaxCodePurchaseEx  from tblregionaloptions where region = '+QuotedStr(aNewRegionName)+' limit 1));');
      script.SQL.Add('insert into tmp_taxxref (au_taxcode, taxcode) values ((select TaxCodeNoTax        from tblregionaloptions where region = "Australia" limit 1), (select TaxCodeNoTax from tblregionaloptions where region = '+QuotedStr(aNewRegionName)+' limit 1));');
      script.SQL.Add('UPDATE tblChartOfAccounts set TaxCode = (Select taxcode from tmp_taxxref where au_taxcode = tblChartOfAccounts.TaxCode limit 1) where IfNull(tblChartOfAccounts.TaxCode,"") <> "";');
      script.SQL.Add('drop table if exists tmp_taxxref;');
      try
        script.Execute;
      Except
        on E:Exception do begin
          AddEventdata(aOnEvent,TAG_ResponseError, 'Error in Setting Default Accounts Tax Codes:' +E.message);
        end;
      end;
    end;

    if IsVS1Database then begin
      AddEventdata(aOnEvent, 'NewCompanyDefaultValues', 'Init VS1 Database Defaults');

      script.SQL.Clear;
      script.SQL.add(TNewDbUtils.PublishTablesOnVS1(nil, aNewRegionName));
      {tblchartofaccounts}
      (*script.SQL.add('UPDATE tblchartofaccounts Set PublishOnVS1 ="F";');
      script.SQL.add('UPDATE tblchartofaccounts Set PublishOnVS1 ="T" '+
                            ' Where Accountname in ('+ NewVS1DBDefaultListFor('tblchartofaccounts') +');');
      {tblclients}
      script.SQL.add('UPDATE tblclients Set PublishOnVS1 ="F";');
      script.SQL.add('UPDATE tblclients Set PublishOnVS1 ="T" '+
                            ' Where Company in ('+ NewVS1DBDefaultListFor('tblclients') +');');
      {tblparts}
      script.SQL.add('UPDATE tblparts Set PublishOnVS1 ="F";');
      script.SQL.add('UPDATE tblparts Set PublishOnVS1 ="T" '+
                            ' Where Partname in ('+ NewVS1DBDefaultListFor('tblparts') +');');

      {tblpaymentmethods}
      script.SQL.add('UPDATE tblpaymentmethods Set PublishOnVS1 ="F";');
      script.SQL.add('UPDATE tblpaymentmethods Set PublishOnVS1 ="T" '+
                            ' Where NAME in ('+ NewVS1DBDefaultListFor('tblpaymentmethods') +');');
      {tbltaxcodes}
      script.SQL.add('UPDATE tbltaxcodes Set PublishOnVS1 ="F";');
      script.SQL.add('UPDATE tbltaxcodes Set PublishOnVS1 ="T" '+
                            ' Where NAME in ('+ NewVS1DBDefaultListFor('tbltaxcodes') +');');
      {tblterms}
      script.SQL.add('UPDATE tblterms Set PublishOnVS1 ="F";');
      script.SQL.add('UPDATE tblterms Set PublishOnVS1 ="T" '+
                            ' Where Terms in ('+ NewVS1DBDefaultListFor('tblterms') +');');*)
      {DB Preferences}
      script.SQL.add('UPDATE tbldbpreferences set FieldValue ="T" where Name = "BackupAfterRestart";');
      script.SQL.add('UPDATE tbldbpreferences set FieldValue ="T" where Name = "UseBatchTransactions";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue ="T" where name = "UseAlphaNumericBarcodes";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue ="T" where name = "FnRunBatch";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue ="F" where name = "GoogleAnalyticsEnabled";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue ="F" where name = "UseGoogleAnalytics";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue ="F" where name = "EnableWalmart";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue ="F" where name = "CreditCheckSO";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue ="F" where name = "CreditCheckInv";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue ="F" where name = "CreditCheckRepair";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue ="F" where name = "CreditCheckRepair";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue ="F" where name = "CreditCheckPO";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue =	0	 where name = "APPAppearDays";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue =	0	 where name = "QuoteAppearDays";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue =	0	 where name = "ToDoAppearDays";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue =	0	 where name = "PendingSOAppearDays";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue =	0	 where name = "EquipmentServiceAppearDays";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue =	0	 where name = "ERPLicenseRenewalAppearDays";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue =	0	 where name = "OthContactAppearDays";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue =	0	 where name = "MemTransAppearDays";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue =	0	 where name = "CustomerLoyaltyAppearDays";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue =	0	 where name = "ContactLoyaltyAppearDays";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue =	0	 where name = "EmployeeskillRenewalAppearDays";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue =	0	 where name = "ReceivedBOAppearDays";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue =	0	 where name = "FixedAssetInsuranceExpiresAppearDays";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue =	0	 where name = "FixedAssetWarrantyExpiresAppearDays";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue =	0	 where name = "MarketingContactsAppearDays";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue =	0	 where name = "LeadsAppearDays";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue =	0	 where name = "ServiceLogAprearDays";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue =	0	 where name = "GoodToReceiveReminderDays";');
      script.SQL.add('UPDATE tblDBPreferences '+
                      ' Set FieldValue =(SELECT distinct tblChartofAccounts.accountname '+
                                        ' FROM tblchartofaccounts  '+
                                        ' WHERE IsHeader = "F" '+
                                        ' AND Active = "T" '+
                                        ' AND  tblChartofAccounts.accountname="BANK" ) '+
                      ' where name = "DefaultCustPaymentAccount";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue ="F" where name = "POSRestrictRefund";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue ="F" where name = "AutoAppendBatchNumber";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue ="T" where name = "CanRemoveSupplierInvoiceNoInPO";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue ="F" where name = "EnforceCustomerFirstAndLastName";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue ="F" where name = "IncludeUnInvoicedSOtoGL";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue ="F" where name = "RestrictRefund";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue ="F" where name = "PhoneNumberFormatting";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue ="F" where name = "CustomerABNFormating";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue ="F" where name = "PostcodeFormatting";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue ="F" where name = "BankAccFormatting";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue ="F" where name = "EnforcesupplierFirstName";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue ="F" where name = "PaymentsAddToEFT";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue ="F" where name = "ConfirmBeforeInvoiceStockToNegative";');
      script.SQL.add('UPDATE tblDBPreferences Set FieldValue ="T" where name = "UseBankStatements";');
      script.SQL.add('UPDATE tblDBPreferences SET FieldValue = 1  WHERE name = "MaxDiscountPercentage";'); { Wang }
      script.SQL.add('UPDATE tblpersonalpreferences SET MaxDiscountPercentage = 1;');
      script.SQL.add('UPDATE tbldbpreferences set FieldValue = "F" where Name = "CountSOBOInAvailable";');
      try
        AddEventdata(aOnEvent,'NewCompanyDefaultValues', 'Init VS1 Database Preferences . . .');
        script.Execute;
        script.SQL.Clear;
        AddEventdata(aOnEvent,'NewCompanyDefaultValues', 'Init VS1 Database Preferences . . . Done');
      Except
        on E:Exception do begin
          AddEventdata(aOnEvent,TAG_ResponseError, 'Error in Init VS1 Database Preferences :' +E.message);
        end;
      end;

      {terms}
      script.SQL.add('INSERT IGNORE INTO tblterms  SET Terms = "Due on Receipt",' +
                                                      'TermsAmount = 0, ' +
                                                      'EOM =  "F", ' +
                                                      'EOMPlus="F", ' +
                                                      'Days =  "T", ' +
                                                      'PP=  "F",' +
                                                      'Active = "T", ' +
                                                      'Description = "Due at the time of recieving the invoice", '+
                                                      'Required = "F", ' +
                                                      'EarlyPaymentDiscount=0,' +
                                                      'EarlyPaymentDays=0,' +
                                                      'ProgressPaymenttype = "M", ' +
                                                      'ProgressPaymentfirstPayonSaleDate="T", ' +
                                                      'IsSalesDefault = "T", ' +      {Wang}
                                                      'IsPurchaseDefault = "T", ' +
                                                      'PublishOnVS1="T" ' +
                                                      'ON DUPLICATE KEY update PublishOnVS1="T";');
      try
        AddEventdata(aOnEvent,'NewCompanyDefaultValues', 'Init VS1 Database Terms . . .');
        script.Execute;
        script.SQL.Clear;
        AddEventdata(aOnEvent,'NewCompanyDefaultValues', 'Init VS1 Database Terms . . . Done');
      Except
        on E:Exception do begin
          AddEventdata(aOnEvent,TAG_ResponseError, 'Error in Init VS1 Database Terms :' +E.message);
        end;
      end;

      {Account type for VS1}
      script.SQL.add('UPDATE tblacctypedesc Set OriginalDesc ="Bank", AccDesc ="Bank"  where OriginalDesc = "Cheque or Saving" and AccType = "BANK";');

      {Make Default Class}
      script.SQL.add('truncate tblclass ;');
      script.SQL.add('INSERT IGNORE INTO tblclass Set ClassName =' + quotedstr(VS1_DEFAULT_CLASS)+' , Description =' + quotedstr(VS1_DEFAULT_CLASS)+' , AutoCreateSmartOrders="F", AutoCreateRepairs="F" , Active="T";');
      script.SQL.add('UPDATE tblColumnHeadings Set DefaultClass =  ' + quotedstr(VS1_DEFAULT_CLASS)+';');
      script.SQL.Add ('UPDATE tblproductclasses Set ClassName=' + quotedstr(VS1_DEFAULT_CLASS)+','+
                          'ClassID = (SELECT tblClass.ClassID FROM tblClass WHERE tblClass.ClassName = ' + quotedstr(VS1_DEFAULT_CLASS)+');');
      script.SQL.Add ('UPDATE tblEmployees set DefaultClassName =' + quotedstr(VS1_DEFAULT_CLASS)+','+
                      'DefaultClassID = (SELECT tblClass.ClassID FROM tblClass WHERE tblClass.ClassName = ' + quotedstr(VS1_DEFAULT_CLASS)+');');
      script.SQL.Add('delete from tblproductclasses  where classId not in (select Classid from tblclass); ');
      script.SQL.Add('delete from tblpartsclasspreferences  where classId not in (select Classid from tblclass); ');

      {Adding tblForms records for TureERP Mobile Wang}
      script.SQL.Add('INSERT IGNORE INTO tblForms (FormName, Description, TabGroup, IsForm, AccessLevels, SkinsGroup) ' +
                      'VALUES ("FnCloudCustPayments", "Customer Payment", 26, "F", "T", "Payments"); ');
      script.SQL.Add('INSERT IGNORE INTO tblForms (FormName, Description, TabGroup, IsForm, AccessLevels, SkinsGroup) ' +
                      'VALUES ("FnCloudSuppPayments", "Supplier Payment", 26, "F", "T", "Payments"); ');
      script.SQL.Add('INSERT IGNORE INTO tblForms (FormName, Description, TabGroup, IsForm, AccessLevels, SkinsGroup) ' +
                      'VALUES ("FnCloudStatements", "Statements", 26, "F", "T", "Payments"); ');
      script.SQL.Add('INSERT IGNORE INTO tblForms (FormName, Description, TabGroup, IsForm, AccessLevels, SkinsGroup) ' +
                      'VALUES ("FnCloudJournalEntry", "Journal Entries", 26, "F", "T", "Accounts"); ');
      script.SQL.Add('INSERT IGNORE INTO tblForms (FormName, Description, TabGroup, IsForm, AccessLevels, SkinsGroup) ' +
                      'VALUES ("FnCloudPayroll", "Payroll", 26, "F", "T", "Payroll"); ');
      script.SQL.Add('INSERT IGNORE INTO tblForms (FormName, Description, TabGroup, IsForm, AccessLevels, SkinsGroup) ' +
                      'VALUES ("FnCloudCreateNew", "Create a New Appointment", 26, "F", "T", "Appointments"); ');
      try
        AddEventdata(aOnEvent,'NewCompanyDefaultValues', 'Init VS1 Database Access Levels . . .');
        script.Execute;
        script.SQL.Clear;
        AddEventdata(aOnEvent,'NewCompanyDefaultValues', 'Init VS1 Database Access Levels . . . Done');
      Except
        on E:Exception do begin
          AddEventdata(aOnEvent,TAG_ResponseError, 'Error in Init VS1 Database Access Levels :' +E.message);
        end;
      end;


      {delete ERPFIX Tables from the new db}
      if qry.active then qry.close;
      qry.SQL.Text := ' Show tables like "erpfix%"';
      qry.Open;
      if qry.recordcount >0 then begin
        qry.first;
        While qry.EOF = False do begin
          if trim(qry.Fields[0].asString)<> '' then begin
            script.SQL.add('Drop table if exists `' +trim(qry.Fields[0].asString)+'`;');
          end;
          qry.Next;
        end;
      end;
      if qry.active then qry.close;
      try
        AddEventdata(aOnEvent,'NewCompanyDefaultValues', 'Delete Temporary Tables . . .');
        script.Execute;
        AddEventdata(aOnEvent,'NewCompanyDefaultValues', 'Delete Temporary Tables . . . Done');
      Except
        on E:Exception do begin
          AddEventdata(aOnEvent,TAG_ResponseError, 'Error in Delete Temporary Tables :' +E.message);
        end;
      end;
    end else begin
      AddEventdata(aOnEvent,'NewCompanyDefaultValues', 'Not VS1 Database');
    end;

  finally
    qry.Free;
    script.Free;
  end;
Except
  on E:Exception do begin
    AddEventdata(aOnEvent,TAG_ResponseError, ' Error in Setting Default Values in the New DB :' + E.message);
  end;
end;

end;

class function TNewDbUtils.CopyTransactions(ANewDB: string; AOnEvent: TEventProc; ADlg: TprogressDialog) : Boolean;
var
  TempQuery: TERPQuery;
  NewConn: TERPConnection;
  ProductID: Integer;
  ProductName: string;
  AccountName: string;
  CD: TDateTime;
  CDAP: TDateTime;
  CDAR: TDateTime;
begin
  Result := False;

  NewConn := TERPConnection.Create(nil);
  try
    // Connect to the new created database
    NewConn.Server := AppEnv.AppDb.Server;
    NewConn.Database := ANewDB;
    NewConn.Username := AppEnv.AppDb.Connection.Username;
    NewConn.Password := AppEnv.AppDb.Connection.Password;
    NewConn.Port     := AppEnv.AppDb.Connection.Port;
    NewConn.Connect;

    // Create a dummy product
    ProductName := PART_DUMMYPRODUCT;
    ProductID := CreateDummyProduct(NewConn, ProductName);

    // Create a dummy account
    AccountName := ACNT_DUMMYACCOUNT;
    CreateDummyAccount(NewConn, AccountName);

    CD := AppEnv.CompanyPrefs.ClosingDate;
    CDAP := AppEnv.CompanyPrefs.ClosingDateAP;
    CDAR := AppEnv.CompanyPrefs.ClosingDateAR;

    // Set closing date 20 years ahead
    AppEnv.CompanyPrefs.ClosingDate := IncYear(CD, -20);
    AppEnv.CompanyPrefs.ClosingDateAP := IncYear(CDAP, -20);
    AppEnv.CompanyPrefs.ClosingDateAR := IncYear(CDAR, -20);

    // Copy transaction objects
    CreateTxnObjects(NewConn, ProductID, ProductName, AccountName, ADlg);

    // Set back closing date
    AppEnv.CompanyPrefs.ClosingDate := CD;
    AppEnv.CompanyPrefs.ClosingDateAP := CDAP;
    AppEnv.CompanyPrefs.ClosingDateAR := CDAR;

    // Do stock take
    CreateStockTake(NewConn, ProductID, ProductName);

    NewConn.Disconnect;

    Result := True;
  finally
    NewConn.Free;
  end;

end;

class function TNewDbUtils.CreateDummyProduct(ANewConn: TERPConnection; APName: string) : Integer;
var
  SDesc: string;
  IQty: Integer;
  STaxCode: string;
  DummyProduct: TProductSimple;
  IProductID: Integer;
begin
  // Create a dummy product
  SDesc := 'For Copying Outstanding Transactions From';
  IQty := 1;
  STaxCode := 'ST';

  IProductID := 0;

  DummyProduct := TProductSimple.CreateWithNewConn(nil, ANewConn);
  try
    with DummyProduct do begin
      LoadSelect('Partname=' + QuotedStr(APName));
      if Count = 0 then begin
        New;
        ProductName := APName;;
        ProductPrintName := APName;
        ProductDescription := SDesc;
        SalesDescription := SDesc;
        PurchaseDescription := SDesc;
        BuyQTY1 := IQty;
        SellQTY1 := IQty;
        TaxcodeSales := STaxCode;
        PostDb;
      end;
    end;

    IProductID := DummyProduct.ID;
  finally
    DummyProduct.Free;
  end;

  Result := IProductID;
end;

class function TNewDbUtils.CreateDummyAccount(ANewConn: TERPConnection; AAName: string) : Boolean;
var
  SDesc: string;
  DummyAccount: TAccount;
begin
  DummyAccount := TAccount.CreateWithNewConn(nil, ANewConn);
  try
    with DummyAccount do begin
      LoadSelect('AccountName=' + QuotedStr(AAName));
      if Count = 0 then begin
        New;
        AccountName := AAName;
        Level1 := AAName;
        AccountTypeName := 'Exp';
        Description := SDesc;
        Balance := 0.0;
        PostDb;
      end;
    end;

  finally
    DummyAccount.Free;
  end;
end;

class function TNewDbUtils.CreateTxnObjects(ANewConn: TERPConnection; APID: Integer; APName, AAname: string; ADlg: TprogressDialog = nil) : Boolean;
var
  OldConn: TERPConnection;
  TempQuery: TERPQuery;
  TransType: string;
  Kind: array of string;
  Val1: array of Double;
  Val2: array of Double;
  Val3: array of Double;
  Val4: array of TDateTime;
  Count, K, JJ: Integer;
begin
  OldConn := CommonDbLib.GetSharedMyDacConnection;
  if not OldConn.Connected then
      OldConn.Connect;

  TempQuery := TERPQuery.Create(nil);
  try
    TempQuery.Connection := OldConn;

    // Purchase orders, bills, credits, ...
    TempQuery.SQL.Add('SELECT Balance, ClientID, TotalTax, TotalAmount, TotalAmountInc, OrderDate,');
    TempQuery.SQL.Add('IF(IsPO="T", "Purchase", IF(IsBill="T", "Bill", IF(IsCredit="T", "Credit", IF(IsCheque="T", "Cheque", IF(IsRA="T", "RA", "Other"))))) AS Kind');
    TempQuery.SQL.Add('FROM tblpurchaseorders WHERE Paid="F" AND Deleted="F" AND PurchaseOrderNumber IS NOT NULL');

    TempQuery.Open;
    TempQuery.First;
    Count := 0;
    while not TempQuery.EOF do begin
      TransType := TempQuery.FieldByName('Kind').AsString;
      if TransType = 'Purchase' then
        CopyPO(ANewConn, OldConn, TempQuery, APID, APName);

      if TransType = 'Bill' then
        CopyBill(ANewConn, TempQuery, AAName);

      if TransType = 'Credit' then
        CopyCredit(ANewConn, TempQuery, AAName);

      if TransType = 'Cheque' then
        CopyCheque(ANewConn, TempQuery, AAName);

      if TransType = 'RA' then
        CopyRA(ANewConn, TempQuery, AAName);

      TempQuery.Next;
    end;

    if ADlg <> nil then begin
      ADlg.Value := 30;
    end;

    // Invoices, Sales order, Quote
    TempQuery.Close;
    TempQuery.SQL.Clear;
    TempQuery.SQL.Add('SELECT s.TotalAmount, s.TotalAmountInc, s.TotalTax, SaleDate, ');
    TempQuery.SQL.Add('IF(s.IsInvoice="T", "Invoice", IF(s.IsSalesOrder="T" AND s.Converted="F", "SO", IF(s.IsQuote="T", "Quote", "Other"))) AS Kind');
    TempQuery.SQL.Add('FROM tblsales s');
    TempQuery.SQL.Add('WHERE s.Paid="F" AND s.Deleted="F"');

    TempQuery.Open;
    TempQuery.First;
    while not TempQuery.EOF do begin
      TransType := TempQuery.FieldByName('Kind').AsString;
      if TransType = 'Invoice' then begin
        CopyInvoice(ANewConn, TempQuery, APID, APName);
      end;

      if TransType = 'SO' then
        CopySO(ANewConn, TempQuery, APID, APName);

      if TransType = 'Quote' then
        CopyQuote(ANewConn, TempQuery, APID, APName);

      TempQuery.Next;
    end;

    if ADlg <> nil then begin
      ADlg.Value := 90;
    end;

  finally
    AppEnv.AppDb.Connection.Disconnect;
  end;
end;

class function TNewDbUtils.CopyPO(ANewConn: TERPConnection; AOldConn: TERPConnection; AQuery: TERPQuery; APID: Integer; APName: string) : Boolean;
var
  PO: TPurchaseOrder;
begin
  PO := TPurchaseOrder.CreateWithNewConn(nil, ANewConn);
  try
    PO.Load(0);
    PO.CrossStockAdjustTransForinvoice := True;
    PO.New;
    PO.SilentMode := True;
    PO.IgnoreAccesslevel := True;
    PO.SupplierID := 4; //AQuery.FieldByName('ClientID').AsInteger;
//    PO.SupplierName := AQuery.FieldByName('SupplierName').AsString;
//    PO.ClientPrintName := AQuery.FieldByName('ClientPrintName').AsString;

    PO.Lines.New;
    PO.Lines.LookupsUseConnection := True;
    PO.Lines.SilentMode := True;
    PO.Lines.Connection := TMyDacDataConnection.Create(PO.Lines);
    TMyDacDataConnection(PO.Lines.Connection).MyDacConnection := ANewConn;
    PO.Lines.ProductID := APID;
    PO.Lines.ProductName := APName;
    PO.Lines.ProductPrintName := APName;
    PO.Lines.QtySold := 1;
    PO.Lines.QtyShipped := 1;
    PO.Lines.LineCost := AQuery.FieldByName('TotalAmountInc').AsFloat;

    PO.TotalBalance := AQuery.FieldByName('TotalAmountInc').AsFloat;
    PO.TotalAmount := AQuery.FieldByName('TotalAmount').AsFloat;
    PO.TotalAmountInc := AQuery.FieldByName('TotalAmountInc').AsFloat;
    PO.TotalTax := AQuery.FieldByName('TotalTax').AsFloat;
    PO.OrderDate := AQuery.FieldByName('OrderDate').AsDateTime;

    PO.Lines.PostDb;
    PO.PostDb;

    PO.Connection.BeginTransaction;
    PO.Save;
    PO.Connection.CommitTransaction;

  finally
    PO.Free;
  end;
end;

class function TNewDbUtils.CopyBill(ANewConn: TERPConnection; AQuery: TERPQuery; AAName: string) : Boolean;
var
  Bill: TBill;
begin
  Bill := TBill.CreateWithNewConn(nil, ANewConn);
  try
    Bill.CrossStockAdjustTransForinvoice := True;
    Bill.New;
    Bill.SilentMode := True;
    Bill.Connection.Connection := ANewConn;
    Bill.IgnoreAccesslevel := True;
    Bill.SupplierId := 4; //AQuery.FieldByName('ClientID').AsInteger;
//    Bill.SupplierName := AQuery.FieldByName('SupplierName').AsString;
//    Bill.ClientPrintName := AQuery.FieldByName('ClientPrintName').AsString;

    Bill.Lines.New;
    Bill.Lines.SilentMode := True;
    Bill.Lines.AccountName := AAName;
    Bill.Lines.QtySold := 1;
    Bill.Lines.QtyShipped := 1;
    Bill.Lines.LineCost := AQuery.FieldByName('TotalAmountInc').AsFloat;

    Bill.TotalBalance := AQuery.FieldByName('TotalAmountInc').AsFloat;
    Bill.TotalAmount := AQuery.FieldByName('TotalAmount').AsFloat;
    Bill.TotalAmountInc := Bill.TotalBalance;
    Bill.TotalTax := AQuery.FieldByName('TotalTax').AsFloat;
    Bill.BillTotal := Bill.TotalAmountInc;
    Bill.OrderDate := AQuery.FieldByName('OrderDate').AsDateTime;

    Bill.Lines.PostDb;
    Bill.PostDb;

    Bill.Connection.BeginTransaction;
    Bill.Save;
    Bill.Connection.CommitTransaction;

  finally
    Bill.Free;
  end;
end;

class function TNewDbUtils.CopyCredit(ANewConn: TERPConnection; AQuery: TERPQuery; AAName: string) : Boolean;
var
  Credit: TCredit;
begin
  Credit := TCredit.CreateWithNewConn(nil, ANewConn);
  try
    Credit.CrossStockAdjustTransForinvoice := True;
    Credit.New;
    Credit.SilentMode := True;
    Credit.Connection.Connection := ANewConn;
    Credit.IgnoreAccesslevel := True;
    Credit.SupplierId := 4; //AQuery.FieldByName('ClientID').AsInteger;
//    Credit.SupplierName := AQuery.FieldByName('SupplierName').AsString;
//    Credit.ClientPrintName := AQuery.FieldByName('ClientPrintName').AsString;

    Credit.Lines.New;
    Credit.Lines.SilentMode := True;
    Credit.Lines.AccountName := AAName;
    Credit.Lines.QtySold := 1;
    Credit.Lines.QtyShipped := 1;
    Credit.Lines.LineCost := AQuery.FieldByName('TotalAmountInc').AsFloat;

    Credit.TotalBalance := AQuery.FieldByName('TotalAmountInc').AsFloat;
    Credit.TotalAmount := AQuery.FieldByName('TotalAmount').AsFloat;
    Credit.TotalAmountInc := Credit.TotalBalance;
    Credit.TotalTax := AQuery.FieldByName('TotalTax').AsFloat;
    Credit.OrderDate := AQuery.FieldByName('OrderDate').AsDateTime;

    Credit.Lines.PostDb;
    Credit.PostDb;

    Credit.Connection.BeginTransaction;
    Credit.Save;
    Credit.Connection.CommitTransaction;

  finally
    Credit.Free;
  end;
end;

class function TNewDbUtils.CopyCheque(ANewConn: TERPConnection; AQuery: TERPQuery; AAName: string) : Boolean;
var
  Cheque: TCheque;
begin
  Cheque := TCheque.CreateWithNewConn(nil, ANewConn);
  try
    Cheque.CrossStockAdjustTransForinvoice := True;
    Cheque.New;
    Cheque.SilentMode := True;
    Cheque.Connection.Connection := ANewConn;
    Cheque.IgnoreAccesslevel := True;
    Cheque.SupplierId := 4; //AQuery.FieldByName('ClientID').AsInteger;
//    Cheque.SupplierName := AQuery.FieldByName('SupplierName').AsString;
//    Cheque.ClientPrintName := AQuery.FieldByName('ClientPrintName').AsString;

    Cheque.Lines.New;
    Cheque.Lines.SilentMode := True;
    Cheque.Lines.AccountName := AAName;
    Cheque.Lines.QtySold := 1;
    Cheque.Lines.QtyShipped := 1;
    Cheque.Lines.LineCost := AQuery.FieldByName('TotalAmountInc').AsFloat;

    Cheque.TotalBalance := AQuery.FieldByName('TotalAmountInc').AsFloat;
    Cheque.TotalAmount := AQuery.FieldByName('TotalAmount').AsFloat;
    Cheque.TotalAmountInc := Cheque.TotalBalance;
    Cheque.TotalTax := AQuery.FieldByName('TotalTax').AsFloat;
    Cheque.OrderDate := AQuery.FieldByName('OrderDate').AsDateTime;

    Cheque.Lines.PostDb;
    Cheque.PostDb;

    Cheque.Connection.BeginTransaction;
    Cheque.Save;
    Cheque.Connection.CommitTransaction;

  finally
    Cheque.Free;
  end;
end;

class function TNewDbUtils.CopyRA(ANewConn: TERPConnection; AQuery: TERPQuery; AAName: string) : Boolean;
var
  RA: TReturnAuthority;
begin
  RA := TReturnAuthority.CreateWithNewConn(nil, ANewConn);
  try
    RA.CrossStockAdjustTransForinvoice := True;
    RA.New;
    RA.SilentMode := True;
    RA.Connection.Connection := ANewConn;
    RA.IgnoreAccesslevel := True;
    RA.SupplierId := 4; //AQuery.FieldByName('ClientID').AsInteger;
//    RA.SupplierName := AQuery.FieldByName('SupplierName').AsString;
//    RA.ClientPrintName := AQuery.FieldByName('ClientPrintName').AsString;

    RA.Lines.New;
    RA.Lines.SilentMode := True;
    RA.Lines.AccountName := AAName;
    RA.Lines.QtySold := 1;
    RA.Lines.QtyShipped := 1;
    RA.Lines.LineCost := AQuery.FieldByName('TotalAmountInc').AsFloat;

    RA.TotalBalance := AQuery.FieldByName('TotalAmountInc').AsFloat;
    RA.TotalAmount := AQuery.FieldByName('TotalAmount').AsFloat;
    RA.TotalAmountInc := RA.TotalBalance;
    RA.TotalTax := AQuery.FieldByName('TotalTax').AsFloat;
    RA.OrderDate := AQuery.FieldByName('OrderDate').AsDateTime;

    RA.Lines.PostDb;
    RA.PostDb;

    RA.Connection.BeginTransaction;
    RA.Save;
    RA.Connection.CommitTransaction;

  finally
    RA.Free;
  end;
end;

// Invoices
class function TNewDbUtils.CopyInvoice(ANewConn: TERPConnection; AQuery: TERPQuery; APID: Integer; APName: string) : Boolean;
var
  Invoice: TInvoice;
begin
  Invoice := TInvoice.CreateWithNewConn(nil, ANewConn);
  try
    Invoice.CrossStockAdjustTransForinvoice := True;
    Invoice.New;
    Invoice.SilentMode := True;
    Invoice.IgnoreAccesslevel := True;
    Invoice.ClientID := 4; //AQuery.FieldByName('ClientID').AsInteger;
//    Invoice.ClientName := AQuery.FieldByName('ClientName').AsString;
//    Invoice.ClientPrintName := AQuery.FieldByName('ClientPrintName').AsString;

    Invoice.Lines.New;
    Invoice.Lines.SilentMode := True;
    Invoice.Lines.LookupsUseConnection := True;
    Invoice.Lines.ProductID := APID;
    Invoice.Lines.ProductName := APName;
    Invoice.Lines.ProductPrintName := APName;
    Invoice.Lines.QtySold := 1;
    Invoice.Lines.QtyShipped := 1;
    Invoice.Lines.LinePrice := AQuery.FieldByName('TotalAmountInc').AsFloat;

    Invoice.TotalAmount := AQuery.FieldByName('TotalAmount').AsFloat;
    Invoice.TotalAmountInc := AQuery.FieldByName('TotalAmountInc').AsFloat;
    Invoice.TotalTax := AQuery.FieldByName('TotalTax').AsFloat;
    Invoice.SaleDate := AQuery.FieldByName('SaleDate').AsDateTime;

    Invoice.Lines.PostDb;
    Invoice.PostDb;

    Invoice.Connection.BeginTransaction;
    Invoice.Save;
    Invoice.Connection.CommitTransaction;

  finally
    Invoice.Free;
  end;
end;

class function TNewDbUtils.CopySO(ANewConn: TERPConnection; AQuery: TERPQuery; APID: Integer; APName: string) : Boolean;
var
  SO: TSalesOrder;
begin
  SO := TSalesOrder.CreateWithNewConn(nil, ANewConn);
  try
    SO.CrossStockAdjustTransForinvoice := True;
    SO.New;
    SO.SilentMode := True;
    SO.IgnoreAccesslevel := True;
    SO.ClientID := 4; //AQuery.FieldByName('ClientID').AsInteger;
//    SO.ClientName := AQuery.FieldByName('ClientName').AsString;
//    SO.ClientName := AQuery.FieldByName('ClientPrintName').AsString;

    SO.Lines.New;
    SO.Lines.SilentMode := True;
    SO.Lines.LookupsUseConnection := True;
    SO.Lines.ProductID := APID;
    SO.Lines.ProductName := APName;
    SO.Lines.ProductPrintName := APName;
    SO.Lines.QtySold := 1;
    SO.Lines.QtyShipped := 1;
    SO.Lines.LinePrice := AQuery.FieldByName('TotalAmountInc').AsFloat;

    SO.Converted := False;
    SO.TotalAmount := AQuery.FieldByName('TotalAmount').AsFloat;
    SO.TotalAmountInc := AQuery.FieldByName('TotalAmountInc').AsFloat;
    SO.TotalTax := AQuery.FieldByName('TotalTax').AsFloat;
    SO.SaleDate := AQuery.FieldByName('SaleDate').AsDateTime;
    SO.Lines.PostDb;
    SO.PostDb;

    SO.Connection.BeginTransaction;
    SO.Save;
    SO.Connection.CommitTransaction;

  finally
    SO.Free;
  end;
end;

class function TNewDbUtils.CopyQuote(ANewConn: TERPConnection; AQuery: TERPQuery; APID: Integer; APName: string) : Boolean;
var
  Quote: TQuote;
begin
  Quote := TQuote.CreateWithNewConn(nil, ANewConn);
  try
    Quote.CrossStockAdjustTransForinvoice := True;
    Quote.New;
    Quote.SilentMode := True;
    Quote.IgnoreAccesslevel := True;
    Quote.ClientID := 4; //AQuery.FieldByName('ClientID').AsInteger;
//    Quote.ClientName := AQuery.FieldByName('ClientName').AsString;
//    Quote.ClientPrintName := AQuery.FieldByName('ClientPrintName').AsString;

    Quote.Lines.New;
    Quote.Lines.SilentMode := True;
    Quote.Lines.LookupsUseConnection := True;
    Quote.Lines.ProductID := APID;
    Quote.Lines.ProductName := APName;
    Quote.Lines.ProductPrintName := APName;
    Quote.Lines.QtySold := 1;
    Quote.Lines.QtyShipped := 1;
    Quote.Lines.LinePrice := AQuery.FieldByName('TotalAmountInc').AsFloat;

    Quote.TotalAmount := AQuery.FieldByName('TotalAmount').AsFloat;
    Quote.TotalAmountInc := AQuery.FieldByName('TotalAmountInc').AsFloat;
    Quote.TotalTax := AQuery.FieldByName('TotalTax').AsFloat;
    Quote.SaleDate := AQuery.FieldByName('SaleDate').AsDateTime;

    Quote.Lines.PostDb;
    Quote.PostDb;

    Quote.Connection.BeginTransaction;
    Quote.Save;
    Quote.Connection.CommitTransaction;

  finally
    Quote.Free;
  end;
end;

class function TNewDbUtils.CreateStockTake(ANewConn: TERPConnection;APID: Integer; APName: string) : Boolean;
var
  StockAdjust: TStockAdjustEntry;
  AdjDate: TDateTime;
  CurDB, CurUser, CurPass: string;
begin
  CurDB := AppEnv.AppDb.Database;
  CurUser := AppEnv.AppDb.UserName;
  CurPass := AppEnv.AppDb.UserPass;

  AdjDate := Now;
  StockAdjust:= TStockAdjustEntry.create(Nil);
  try
    StockAdjust.connection := TMyDacDataConnection.create(StockAdjust);
    with StockAdjust do begin
      Connection.Connection := ANewConn;
      ClearContainerListOnNew := True;
      Load(0);
      New;
      AdjustmentDate := AdjDate;
      PostDB;

      Lines.New;

      try
        // Need to switch connection
        AppEnv.AppDb.Connection.Disconnect;
        AppEnv.AppDb.Database := ANewConn.Database;
        AppEnv.AppDb.ConnectUser('Admin', 'Admin');

        Lines.ProductID := APID;
        Lines.ProductName := APName;
      finally
        AppEnv.AppDb.Connection.Disconnect;
        AppEnv.AppDb.Database := CurDB;
        AppEnv.AppDb.ConnectUser(CurUser, CurPass);
      end;

      Lines.ProductPrintName := APName;
      Lines.InStockQty := 1;
      Lines.InStockUOMQty := 1;
      Lines.PostDB;

      Connection.BeginTransaction;
      Save;
      Connection.CommitTransaction;
    end;

  finally
    StockAdjust.Free;
  end;
end;

end.

