unit ContactLib;

interface

uses Classes, TempTableUtils;

type
  Tcreatetemptable = procedure (strSQL:String; SQLcount:Integer) of object;

Function ContactList(const Tablename: String;
  createtemptable: Tcreatetemptable;
  TempFileNameList: TStringList;
  ExcludeInactiveContactFromMessages:Boolean =False): Boolean;
procedure doProgressbar(Sender: TObject; var SQL: string;      var Omit: Boolean);

implementation

uses SysUtils, CommonDbLib, Progressdialog, tcConst, AppEnvironment,
  CommonLib;

Function ContactList(const Tablename: String;
  createtemptable: Tcreatetemptable;
  TempFileNameList: TStringList;
  ExcludeInactiveContactFromMessages:Boolean =False): boolean;
var
  str:TStringList;
  fieldList, sql:String;
  tempFileName: String;
  tempTableName, TempMasterTablename: String;
//  tmpfilename: string;
//  tmpfileList:TStringlist;
  ctr:Integer;

  Procedure SQLAdd(const fStrSQL:String);
  begin
    str.Add(fstrSQL);
  end;

begin
  for ctr := 0 to TempFileNameList.count-1 do BEGIN
    AppEnv.UtilsClient.DeleteServerFile(TempFileNameList[ctr]);
  end;
  TempFileNameList.Clear;

  try
//  tmpfileList:=TStringlist.create;
    try
      Str:=TStringList.Create;
      try
//        SQLAdd('/*1:*/'+'/*Empty Table*/;');
//        SQLAdd('/*2:*/'+'truncate ' + tablename+';' );
        SQLAdd('/*3:*/'+'/*Customers / Suppliers*/;');
        fieldList:= 'GlobalRef,Type,ID,ParentClientID,Name,Balance,ContactName,Street,Street2,Street3,Suburb,State,Postcode,Country,'+
            'Phone,JobName,FaxNumber,Mobile,Email,Active,CreationDate,AccountNo,GracePeriod,StopCredit,ClientTypeID,RepID,TermsID,'+
            'BillStreet,BillStreet2,BillStreet3,BillSuburb,BillState,BillPostcode,BillCountry,CUSTFLD1,CUSTFLD2,CUSTFLD3,CUSTFLD4,CUSTFLD5,CUSTFLD6,'+
            'CUSTFLD7,CUSTFLD8,CUSTFLD9,CUSTFLD10,CUSTFLD11,CUSTFLD12,CUSTFLD13,CUSTFLD14,CUSTFLD15,CUSTDATE1,CUSTDATE2,CUSTDATE3,CallPriority,DefaultContactMethod';
        SQL:= ' SELECT C1.GlobalRef,'+
            'CASE'+
            '	 WHEN C1.IsJob = "T" THEN "Job"'+
            '  WHEN C1.Customer = "T" AND C1.Supplier = "T"  THEN "Customer / Supplier"'+
            '  WHEN C1.Customer = "T" THEN "Customer"'+
            '	 WHEN C1.OtherContact = "T" THEN "Prospect"'+
            '	 WHEN C1.Supplier = "T" THEN "Supplier"'+
            '	 ELSE "?"'+
            'END AS Type,'+
            'C1.ClientID AS ID,'+
            'C1.ParentClientID as ParentClientID,'+
            'If(InStr(C1.Company,"^") -1 >0,Left(C1.Company,InStr(C1.Company,"^")-1),C1.Company) AS Name,'+
            'C1.Balance as Balance,'+
            'space(100) as ContactName,'+
            'C1.Street as Street,'+
            'C1.Street2 as Street2,'+
            'C1.Street3 as Street3,'+
            'C1.Suburb as Suburb,'+
            'C1.State as State,'+
            'C1.Postcode as Postcode,'+
            'C1.Country as Country,'+
            'C1.Phone as Phone,'+
            'C1.JobName as JobName,'+
            'C1.FaxNumber AS FaxNumber,'+
            'C1.Mobile as Mobile,         '+
            'C1.Email as Email,'+
            'C1.Active as Active,'+
            'C1.CreationDate as CreationDate,'+
            'C1.ClientNo as AccountNo,'+
            'C1.GracePeriod AS GracePeriod,'+
            'C1.StopCredit as StopCredit,'+
            'C1.ClientTypeID as ClientTypeID,'+
            'C1.RepID as RepID,'+
            'C1.TermsID as TermsID,'+
            'C1.BillStreet AS BillStreet,'+
            'C1.BillStreet2 AS BillStreet2,'+
            'C1.BillStreet3 AS BillStreet3,'+
            'C1.BillSuburb AS BillSuburb,'+
            'C1.BillState AS BillState,'+
            'C1.BillPostcode AS BillPostcode,'+
            'C1.BillCountry AS BillCountry,'+
            'C1.CUSTFLD1 AS CUSTFLD1,'+
            'C1.CUSTFLD2 AS CUSTFLD2,'+
            'C1.CUSTFLD3 AS CUSTFLD3,'+
            'C1.CUSTFLD4 AS CUSTFLD4,'+
            'C1.CUSTFLD5 AS CUSTFLD5,'+
            'C1.CUSTFLD6 AS CUSTFLD6,'+
            'C1.CUSTFLD7 AS CUSTFLD7,'+
            'C1.CUSTFLD8 AS CUSTFLD8,'+
            'C1.CUSTFLD9 AS CUSTFLD9,'+
            'C1.CUSTFLD10 AS CUSTFLD10,'+
            'C1.CUSTFLD11 AS CUSTFLD11,'+
            'C1.CUSTFLD12 AS CUSTFLD12,'+
            'C1.CUSTFLD13 AS CUSTFLD13,'+
            'C1.CUSTFLD14 AS CUSTFLD14,'+
            'C1.CUSTFLD15 AS CUSTFLD15,'+
            'C1.CUSTDATE1 AS CUSTDATE1,'+
            'C1.CUSTDATE2 AS CUSTDATE2,'+
            'C1.CUSTDATE3 AS CUSTDATE3,'+
            'C1.CallPriority as CallPriority, C1.DefaultContactMethod'+
            ' FROM tblClients C1'+
            ' WHERE char_length(C1.Company) >0';
//        tempTablename:='tmp_globalList' +'tempcontactList1';
        tempTableName := TempTableUtils.UniqueTableName('GlobalList');
        tempFileName := TempTableUtils.UniqueTempFileName('GlobalList', GetSharedMyDacConnection);
//        SQLAdd('/*4:*/'+CommonDbLib.SQLforUserTemporaryTable('tmp_globalList',tempTablename , 'tempcontactList1','Myisam')+';') ;
//        SQLAdd('/*4:*/'+ TempTableUtils.SQLFromTemplateTable('tmp_GlobalList', tempTablename));

//        SQLAdd('/*5:*/'+CreateTemporaryTableusingfile('' , sql , FieldList ,tempTablename , tmpfilename));
        SQLAdd('/*5:*/'+SQLForLoadTableUsingTempFile('tmp_GlobalList', SQL, FieldList, TempTableName, TempFileName));

        SQLAdd('/*6:*/'+'insert into ' +tablename +'('+fieldList +') Select '+fieldList +' from '+tempTablename +';');
        SQLAdd('/*7:*/'+'Drop table if exists ' +tempTablename+';');

//        tmpfileList.add(tmpfilename);
        tempFileNameList.add(tempFileName);


        SQLAdd('/*8:*/'+'/*Primary contacts -customer*/;');
        SQL := ' inner join ' + tablename +' tmp on   tmp.ID = M.ClientId and M.IsPrimarycontact ="T"';
        if ExcludeInactiveContactFromMessages then sql:= sql +' and M.Active = "T"';
//        TempMasterTablename:= 'contactList1';
        TempMasterTablename:= TempTableUtils.UniqueTableName('GlobalList');
//        sql:= SQLfortemptable('tblcontacts','ClientId,ContactTitle,ContactFirstName,ContactSurName','' ,sql, TempMasterTablename,tmpfilename);
        tempFileName := TempTableUtils.UniqueTempFileName('GlobalList', GetSharedMyDacConnection);
        sql:= TempTableUtils.SQLForTempTable('tblcontacts','ClientId,ContactTitle,ContactFirstName,ContactSurName','' ,sql, TempMasterTablename,tempFileName, GetSharedMyDacConnection);
        SQLAdd('/*9:*/'+sql);
        sql:=  'update ' + tablename +' tmp inner join ' + TempMasterTablename +' C '+
            ' on tmp.ID = c.ClientId  ';
        sql:= sql + ' Set tmp.contactId = C.ContactId, Tmp.Contactname = TRIM(concat_WS(" " ,C.ContactTitle,  C.ContactFirstName, C.ContactSurName)) , '+
            ' Type = concat(type , "(Primary Contact)") where not(Type like "%(Primary Contact)");';
        SQLAdd('/*10:*/'+sql);
        SQLAdd('/*11:*/'+'Drop table if exists ' +TempMasterTablename+';');

//        tmpfileList.add(tmpfilename);
        TempFileNameList.add(tempFileName);

        SQLAdd('/*12:*/'+'/*Primary contacts -Supplier*/;');
        SQL := ' inner join ' + tablename +' tmp on   tmp.ID = M.ClientId and M.IsPrimarycontact ="T"';
        if ExcludeInactiveContactFromMessages then sql:= sql +' and M.Active = "T"';
//        TempMasterTablename:= 'contactList2';
        TempMasterTablename:= TempTableUtils.UniqueTableName('GlobalList');
//        sql:= SQLfortemptable('tblcontacts','ClientId,ContactTitle,ContactFirstName,ContactSurName','' ,sql, TempMasterTablename,tmpfilename);
        tempFileName := TempTableUtils.UniqueTempFileName('GlobalList', GetSharedMyDacConnection);
        sql:= TempTableUtils.SQLForTempTable('tblcontacts','ClientId,ContactTitle,ContactFirstName,ContactSurName','' ,sql, TempMasterTablename,tempFileName, GetSharedMyDacConnection);
        SQLAdd('/*13:*/'+sql);
        sql:= 'update ' + tablename +' tmp inner join ' + TempMasterTablename +' C '+
            ' on tmp.ID = c.ClientId  '+
            ' Set tmp.contactId = C.ContactId, Tmp.Contactname = TRIM(concat_WS(" " ,C.ContactTitle,  C.ContactFirstName, C.ContactSurName)) , '+
            ' Type = concat(type , "(Primary Contact)");';
        SQLAdd('/*14:*/'+sql);
        SQLAdd('/*15:*/'+'Drop table if exists ' +TempMasterTablename+';');

//        tmpfileList.add(tmpfilename);
        TempFileNameList.add(tempFileName);


        SQLAdd('/*16:*/'+'/*Customer/Supplier Contacts */;');
        Fieldlist := 'GlobalRef,Type,ID,ParentClientID,Name,Balance,ContactName,Street,Street2,Street3,Suburb,State,Postcode,Country,'+
                      'Phone,JobName,FaxNumber,Mobile,Email,Active,CreationDate,AccountNo,GracePeriod,StopCredit,ClientTypeID,RepID,TermsID,'+
                      'BillStreet,BillStreet2,BillStreet3,BillSuburb,BillState,BillPostcode,BillCountry,CUSTFLD1,CUSTFLD2,CUSTFLD3,CUSTFLD4,CUSTFLD5,CUSTFLD6,'+
                      'CUSTFLD7,CUSTFLD8,CUSTFLD9,CUSTFLD10,CUSTFLD11,CUSTFLD12,CUSTFLD13,CUSTFLD14,CUSTFLD15,CUSTDATE1,CUSTDATE2,CUSTDATE3,contactID,CallPriority,DefaultContactMethod';
        sql:= ' SELECT C1.GlobalRef,'+
                      'CASE'+
                      '	 WHEN C1.IsJob        = "T" THEN "Job(Contact)"'+
                      '  WHEN C1.Customer     = "T"  and C1.Supplier = "T" THEN "Customer / Supplier(Contact)"'+
                      '  WHEN C1.Customer     = "T" THEN "Customer(Contact)"'+
                      '	 WHEN C1.Supplier     = "T" THEN "Supplier(Contact)"'+
                      '	 WHEN C1.OtherContact = "T" THEN "Prospect(Contact)"'+
                      '	 WHEN C1.Supplier     = "T" THEN "Supplier(Contact)"'+
                      '	 ELSE "?"'+
                      'END AS Type,'+
                      'C1.ClientID AS ID,'+
                      'C1.ParentClientID as ParentClientID,'+
                      'If(InStr(C1.Company,"^") -1 >0,Left(C1.Company,InStr(C1.Company,"^")-1),C1.Company) AS Name,'+
                      'C1.Balance as Balance,'+
                      'TRIM(concat_WS(" " ,C.ContactTitle,  C.ContactFirstName, C.ContactSurName)) AS ContactName,'+
                      'C1.Street as Street,'+
                      'C1.Street2 as Street2,'+
                      'C1.Street3 as Street3,'+
                      'C1.Suburb as Suburb,'+
                      'C1.State as State,'+
                      'C1.Postcode as Postcode,'+
                      'C1.Country as Country,'+
                      'C1.Phone as Phone,'+
                      'C1.JobName as JobName,'+
                      'C1.FaxNumber AS FaxNumber,'+
                      'C1.Mobile as Mobile,         '+
                      (*'C1.Email as Email,'+*)
                      'if(ifnull(C.ContactEmail,"")="" ,C1.Email  ,C.ContactEmail) as Email,' +
                      'C1.Active as Active,'+
                      'C1.CreationDate as CreationDate,'+
                      'C1.ClientNo as AccountNo,'+
                      'C1.GracePeriod AS GracePeriod,'+
                      'C1.StopCredit as StopCredit,'+
                      'C1.ClientTypeID as ClientTypeID,'+
                      'C1.RepID as RepID,'+
                      'C1.TermsID as TermsID,'+
                      'C1.BillStreet AS BillStreet,'+
                      'C1.BillStreet2 AS BillStreet2,'+
                      'C1.BillStreet3 AS BillStreet3,'+
                      'C1.BillSuburb AS BillSuburb,'+
                      'C1.BillState AS BillState,'+
                      'C1.BillPostcode AS BillPostcode,'+
                      'C1.BillCountry AS BillCountry,'+
                      'C1.CUSTFLD1 AS CUSTFLD1,'+
                      'C1.CUSTFLD2 AS CUSTFLD2,'+
                      'C1.CUSTFLD3 AS CUSTFLD3,'+
                      'C1.CUSTFLD4 AS CUSTFLD4,'+
                      'C1.CUSTFLD5 AS CUSTFLD5,'+
                      'C1.CUSTFLD6 AS CUSTFLD6,'+
                      'C1.CUSTFLD7 AS CUSTFLD7,'+
                      'C1.CUSTFLD8 AS CUSTFLD8,'+
                      'C1.CUSTFLD9 AS CUSTFLD9,'+
                      'C1.CUSTFLD10 AS CUSTFLD10,'+
                      'C1.CUSTFLD11 AS CUSTFLD11,'+
                      'C1.CUSTFLD12 AS CUSTFLD12,'+
                      'C1.CUSTFLD13 AS CUSTFLD13,'+
                      'C1.CUSTFLD14 AS CUSTFLD14,'+
                      'C1.CUSTFLD15 AS CUSTFLD15,'+
                      'C1.CUSTDATE1 AS CUSTDATE1,'+
                      'C1.CUSTDATE2 AS CUSTDATE2,'+
                      'C1.CUSTDATE3 AS CUSTDATE3, c.contactID,C1.CallPriority,C1.DefaultContactMethod'+
                      ' FROM tblClients C1'+
                      ' Inner join tblcontacts C on IsPrimarycontact ="F"  ';
        if ExcludeInactiveContactFromMessages then sql:= sql +' and C.Active = "T"';
        sql:= sql +' and (C1.ClientId = c.ClientId or C1.ClientID = C.ClientId)  '+
                      ' WHERE char_length(C1.Company) >0';
//        tempTablename:='tmp_globalList' +'tempcontactList2';
        tempTableName := TempTableUtils.UniqueTableName('GlobalList');
        tempFileName := TempTableUtils.UniqueTempFileName('GlobalList', GetSharedMyDacConnection);
//        SQLAdd('/*17:*/'+CommonDbLib.SQLforUserTemporaryTable('tmp_globalList',tempTablename , 'tempcontactList2','Myisam')+';') ;

//        SQLAdd('/*18:*/'+CreateTemporaryTableusingfile('' , sql , FieldList ,tempTablename , tmpfilename));
        SQLAdd('/*18:*/'+SQLForLoadTableUsingTempFile('tmp_GlobalList', SQL, FieldList, TempTableName, TempFileName));

        SQLAdd('/*19:*/'+'insert into ' +tablename +'('+fieldList +') Select '+fieldList +' from '+tempTablename +';');
        SQLAdd('/*20:*/'+'Drop table if exists ' +tempTablename+';');

//        tmpfileList.add(tmpfilename);
        TempFileNameList.add(tempFileName);

        SQLAdd('/*21:*/'+'/*Jobs*/;');
        SQL := ' inner join ' + tablename +' tmp on   tmp.ID = M.clientId and M.ISJob ="T"';
//        TempMasterTablename:= 'contactList3';
        TempMasterTablename:= TempTableUtils.UniqueTableName('GlobalList');
//        sql:= SQLfortemptable('tblClients','StopCredit','' ,sql, TempMasterTablename,tmpfilename);
        tempFileName := TempTableUtils.UniqueTempFileName('GlobalList', GetSharedMyDacConnection);
        sql:= TempTableUtils.SQLForTempTable('tblClients','StopCredit','' ,sql, TempMasterTablename,tempFileName, GetSharedMyDacConnection);
        SQLAdd('/*22:*/'+sql);
        SQLAdd('/*23:*/'+'update ' + tablename +' tmp '+
                    'inner join '+ TempMasterTablename +' C on C.clientId = tmp.ID   '+
                    'set tmp.StopCredit = C.StopCredit;');
        SQLAdd('/*24:*/'+'Drop table if exists ' +TempMasterTablename+';');
//        tmpfileList.add(tmpfilename);
        tempFileNameList.add(tempFileName);
        SQLAdd('/*25:*/'+'/*Marketing Contacts*/;');
        FieldList := 'GlobalRef,Type,ID,ParentClientID,Name,Balance,ContactName,Street,Street2,Street3,Suburb,State,Postcode,Country,Phone,JobName,FaxNumber,Mobile,Email,Active,CreationDate,CallPriority,DefaultContactMethod';
        SQL:=                ' SELECT '+
                        'GlobalRef as Globalref,'+
                        '"Marketing Contact" AS Type ,'+
                        'ID as ID,'+
                        'ID as ParentClientID,'+
                        'COMPANY as Name,'+
                        '0.00 as Balalnce,'+
                        'if(MiddleName<>Space(1),TRIM(Concat_ws(Space(1),FirstName,MiddleName,LastName)),TRIM(Concat_ws(Space(1),FirstName,LastName))) as ContactName,'+
                        'Street as Street,'+
                        'Street2 as street2,'+
                        'Street3 as Street3,'+
                        'SUBURB as suburb,'+
                        'STATE as state,'+
                        'POSTCODE as postcode,'+
                        'Country as country,'+
                        'Phone as phone,'+
                        'space(1) as jobname,'+
                        'FaxNumber as Faxnumber,'+
                        'Mobile as mobile,'+
                        'Email as Email,'+
                        'Active as Ative,'+
                        'DateEntered as CreationDate , CallPriority,DefaultContactMethod'+
                        ' FROM'+
                        ' tblmarketingcontacts'+
                        ' where ClientID = 0';
//        tempTablename:='tmp_globalList' +'tempcontactList3';
        tempTableName := TempTableUtils.UniqueTableName('GlobalList');
        tempFileName := TempTableUtils.UniqueTempFileName('GlobalList', GetSharedMyDacConnection);
//        SQLAdd('/*26:*/'+CommonDbLib.SQLforUserTemporaryTable('tmp_globalList',tempTablename , 'tempcontactList3','Myisam')+';') ;
//        SQLAdd('/*27:*/'+CreateTemporaryTableusingfile('' , sql , FieldList ,tempTablename , tmpfilename));
        SQLAdd('/*27:*/'+SQLForLoadTableUsingTempFile('tmp_GlobalList', SQL, FieldList, TempTableName, TempFileName));
        SQLAdd('/*28:*/'+'insert into ' +tablename +'('+fieldList +') Select '+fieldList +' from '+tempTablename +';');
//        tmpfileList.add(tmpfilename);
        tempFileNameList.add(tempFileName);
        SQLAdd('/*29:*/'+'Drop table if exists ' +tempTablename+';');

        SQLAdd('/*30:*/'+'/*Marketing Contact Primary Contacts */;');

        SQL := ' inner join ' + tablename +' tmp on   tmp.ID = M.MarketingcontactID and M.IsPrimarycontact ="T"';

//        TempMasterTablename:= 'contactList4';
        TempMasterTablename:= TempTableUtils.UniqueTableName('GlobalList');
//        sql:= SQLfortemptable('tblmarketingcontactcontacts','MarketingcontactID, ContactTitle , ContactFirstName, ContactSurName','' ,sql, TempMasterTablename,tmpfilename);
        tempFileName := TempTableUtils.UniqueTempFileName('GlobalList', GetSharedMyDacConnection);
        sql:= TempTableUtils.SQLForTempTable('tblmarketingcontactcontacts','MarketingcontactID, ContactTitle , ContactFirstName, ContactSurName','' ,sql, TempMasterTablename,tempFileName, GetSharedMyDacConnection);
        SQLAdd('/*31:*/'+sql);
        SQLAdd('/*32:*/'+'update ' + tablename +' tmp inner join '+TempMasterTablename+' C '+
            ' on tmp.ID = c.MarketingcontactID and type = "Marketing Contact" '+
            ' Set tmp.contactId = C.ContactId, '+
            ' Tmp.Contactname = TRIM(concat_WS(" " ,C.ContactTitle,  C.ContactFirstName, C.ContactSurName)) , '+
            ' Type = concat(type , "(Primary Contact)") where tmp.type = "Marketing Contact";');

//        tmpfileList.add(tmpfilename);
        tempFileNameList.add(tempFileName);
        SQLAdd('/*33:*/'+'Drop table if exists ' +TempMasterTablename+';');


        SQLAdd('/*34:*/'+'/*Marketing Contact Contacts */;');
        fieldList:= 'GlobalRef,Type,ID,ParentClientID,Name,Balance,ContactName,Street,Street2,Street3,Suburb,State,Postcode,Country,'+
                      ' Phone,JobName,FaxNumber,Mobile,Email,Active,CreationDate,AccountNo,GracePeriod,StopCredit,ClientTypeID,RepID,TermsID,'+
                      ' BillStreet,BillStreet2,BillStreet3,BillSuburb,BillState,BillPostcode,BillCountry,CUSTFLD1,CUSTFLD2,CUSTFLD3,CUSTFLD4,CUSTFLD5,CUSTFLD6,'+
                      ' CUSTFLD7,CUSTFLD8,CUSTFLD9,CUSTFLD10,CUSTFLD11,CUSTFLD12,CUSTFLD13,CUSTFLD14,CUSTFLD15,CUSTDATE1,CUSTDATE2,CUSTDATE3,contactID,CallPriority,DefaultContactMethod';
        SQL:= ' SELECT MC.GlobalRef,"Marketing Contact(Contact)"  AS Type,MC.ID AS ID,'+
                      ' 0 as ParentClientID,MC.Company AS Name,'+
                      ' 0  as Balance,TRIM(concat_WS(" " ,MCC.ContactTitle,  MCC.ContactFirstName, MCC.ContactSurName)) AS ContactName,'+
                      ' MCC.ContactAddress as Street,MCC.ContactAddress2 as Street2,MCC.ContactAddress3 as Street3,'+
                      ' MCC.ContactCity as Suburb,MCC.ContactState as State,'+
                      ' MCC.ContactPcode as Postcode,MCC.ContactCountry as Country,MCC.ContactPH as Phone," " as JobName,MCC.ContactFax AS FaxNumber,'+
                      ' MCC.ContactMOB as Mobile,         if(ifnull(MCC.ContactEmail,"")="" ,MC.Email  ,MCC.ContactEmail) as Email,MCC.Active as Active,'+
                      ' MC.DateEntered as CreationDate,MC.ID as AccountNo,0  AS GracePeriod,"F" as StopCredit,'+
                      ' 0  as ClientTypeID,0 as RepID,0 as TermsID,MC.BillStreet AS BillStreet,MC.BillStreet2 AS BillStreet2,'+
                      ' MC.BillStreet3 AS BillStreet3,MC.BillSuburb AS BillSuburb,MC.BillState AS BillState,MC.BillPostcode AS BillPostcode,'+
                      ' MC.BillCountry AS BillCountry,MC.CUSTFLD1 AS CUSTFLD1,MC.CUSTFLD2 AS CUSTFLD2,MC.CUSTFLD3 AS CUSTFLD3,'+
                      ' MC.CUSTFLD4 AS CUSTFLD4,MC.CUSTFLD5 AS CUSTFLD5,MC.CUSTFLD6 AS CUSTFLD6,MC.CUSTFLD7 AS CUSTFLD7,'+
                      ' MC.CUSTFLD8 AS CUSTFLD8,MC.CUSTFLD9 AS CUSTFLD9,MC.CUSTFLD10 AS CUSTFLD10,MC.CUSTFLD11 AS CUSTFLD11,'+
                      ' MC.CUSTFLD12 AS CUSTFLD12,MC.CUSTFLD13 AS CUSTFLD13,MC.CUSTFLD14 AS CUSTFLD14,MC.CUSTFLD15 AS CUSTFLD15,'+
                      ' MC.CUSTDATE1 AS CUSTDATE1,MC.CUSTDATE2 AS CUSTDATE2,MC.CUSTDATE3 AS CUSTDATE3, MCC.contactID, MC.CallPriority,MC.DefaultContactMethod'+
                      ' FROM tblmarketingcontacts MC '+
                      ' Inner join tblmarketingcontactcontacts MCC on IsPrimarycontact ="F"  '+
                      ' and (MC.ID = MCC.MarketingcontactID)   WHERE char_length(MCC.Company) >0';
//        tempTablename:='tmp_globalList' +'tempcontactList4';
        tempTableName := TempTableUtils.UniqueTableName('GlobalList');
        tempFileName := TempTableUtils.UniqueTempFileName('GlobalList', GetSharedMyDacConnection);
//        SQLAdd('/*35:*/'+CommonDbLib.SQLforUserTemporaryTable('tmp_globalList',tempTablename , 'tempcontactList4','Myisam')+';') ;
//        SQLAdd('/*36:*/'+CreateTemporaryTableusingfile('' , sql , FieldList ,tempTablename , tmpfilename));
        SQLAdd('/*36:*/'+SQLForLoadTableUsingTempFile('tmp_GlobalList', SQL, FieldList, TempTableName, TempFileName));
        SQLAdd('/*37:*/'+'insert into ' +tablename +'('+fieldList +') Select '+fieldList +' from '+tempTablename +';');
//        tmpfileList.add(tmpfilename);
        tempFileNameList.add(tempFileName);
        SQLAdd('/*38:*/'+'Drop table if exists ' +tempTablename+';');

        fieldList:= 'GlobalRef,Type,ID,ParentClientID,Name,Balance,ContactName,Street,Street2,Street3,Suburb,State,Postcode,Country,'+
                      'Phone,JobName,FaxNumber,Mobile,Email,Active,CreationDate,CallPriority,DefaultContactMethod';
        SQL:= ' SELECT GlobalRef,'+
                      '"Employee" As Type,'+
                      'EmployeeID as ID,'+
                      'EmployeeID as ParentClientID,'+
                      'if(MiddleName<>Space(1),TRIM(Concat_ws(Space(1),FirstName,MiddleName,LastName)),TRIM(Concat_ws(Space(1),FirstName,LastName))) AS Name,'+
                      '0.00 As Balance,'+
                      'if(MiddleName<>Space(1),TRIM(Concat_ws(Space(1),FirstName,MiddleName,LastName)),TRIM(Concat_ws(Space(1),FirstName,LastName))) AS ContactName,'+
                      'Street as Street,'+
                      'Street2 as Street2,'+
                      'Street3 as Street3,'+
                      'Suburb as Suburb,'+
                      'State as State,'+
                      'Postcode as Postcode,'+
                      'Country as Country,'+
                      'Phone as Phone,'+
                      'Space(1) as JobName,'+
                      'FaxNumber AS FaxNumber,'+
                      'Mobile as Mobile,'+
                      'Email as Email,'+
                      'Active as Active,'+
                      'CreationDate as CreationDate, E.CallPriority,E.DefaultContactMethod'+
                      ' FROM tblEmployees  E '+
                      ' WHERE char_length(FirstName) >0';
//        tempTablename:='tmp_globalList' +'tempcontactList5';
        tempTableName := TempTableUtils.UniqueTableName('GlobalList');
        tempFileName := TempTableUtils.UniqueTempFileName('GlobalList', GetSharedMyDacConnection);
//        SQLAdd('/*39:*/'+CommonDbLib.SQLforUserTemporaryTable('tmp_globalList',tempTablename , 'tempcontactList5','Myisam')+';') ;
//        SQLAdd('/*40:*/'+CreateTemporaryTableusingfile('' , sql , FieldList ,tempTablename , tmpfilename));
        SQLAdd('/*36:*/'+SQLForLoadTableUsingTempFile('tmp_GlobalList', SQL, FieldList, TempTableName, TempFileName));
        SQLAdd('/*41:*/'+'insert into ' +tablename +'('+fieldList +') Select '+fieldList +' from '+tempTablename +';');
        SQLAdd('/*42:*/'+'Drop table if exists ' +tempTablename+';');
//        tmpfileList.add(tmpfilename);
        tempFileNameList.add(tempFileName);
        SQLAdd('/*43:*/'+'update ' + tablename +' tmp Set Type = Replace(type , "(Primary Contact)(Primary Contact)" , "(Primary Contact)");');

//        //delete the temp files before query to make sure is deleted
//        for ctr := 0 to tmpfileList.count-1 do BEGIN
//          AppEnv.UtilsClient.DeleteServerFiles(replaceStr(tmpfileList[ctr], '.tmp' , '*.tmp'));
//        END;

        createtemptable(str.text , str.count);
        REsult := True;
      finally
        FreeandNil(Str);
      End;
    finally
//      for ctr := 0 to tmpfileList.count-1 do BEGIN
//        AppEnv.UtilsClient.DeleteServerFiles(replaceStr(tmpfileList[ctr], '.tmp' , '*.tmp'));
//      END;
//      Freeandnil(tmpfileList);
    end;
  Except
      on E:Exception do begin
        Result := False;
      end;
  end;


//try
//  tmpfileList:=TStringlist.create;
//  try
//    Str:=TStringList.Create;
//    try
//      SQLAdd('/*1:*/'+'/*Empty Table*/;');
//      SQLAdd('/*2:*/'+'truncate ' + tablename+';' );
//      SQLAdd('/*3:*/'+'/*Customers / Suppliers*/;');
//      fieldList:= 'GlobalRef,Type,ID,ParentClientID,Name,Balance,ContactName,Street,Street2,Street3,Suburb,State,Postcode,Country,'+
//          'Phone,JobName,FaxNumber,Mobile,Email,Active,CreationDate,AccountNo,GracePeriod,StopCredit,ClientTypeID,RepID,TermsID,'+
//          'BillStreet,BillStreet2,BillStreet3,BillSuburb,BillState,BillPostcode,BillCountry,CUSTFLD1,CUSTFLD2,CUSTFLD3,CUSTFLD4,CUSTFLD5,CUSTFLD6,'+
//          'CUSTFLD7,CUSTFLD8,CUSTFLD9,CUSTFLD10,CUSTFLD11,CUSTFLD12,CUSTFLD13,CUSTFLD14,CUSTFLD15,CUSTDATE1,CUSTDATE2,CUSTDATE3,CallPriority,DefaultContactMethod';
//      SQL:= ' SELECT C1.GlobalRef,'+
//          'CASE'+
//          '	 WHEN C1.IsJob = "T" THEN "Job"'+
//          '  WHEN C1.Customer = "T" AND C1.Supplier = "T"  THEN "Customer / Supplier"'+
//          '  WHEN C1.Customer = "T" THEN "Customer"'+
//          '	 WHEN C1.OtherContact = "T" THEN "Prospect"'+
//          '	 WHEN C1.Supplier = "T" THEN "Supplier"'+
//          '	 ELSE "?"'+
//          'END AS Type,'+
//          'C1.ClientID AS ID,'+
//          'C1.ParentClientID as ParentClientID,'+
//          'If(InStr(C1.Company,"^") -1 >0,Left(C1.Company,InStr(C1.Company,"^")-1),C1.Company) AS Name,'+
//          'C1.Balance as Balance,'+
//          'space(100) as ContactName,'+
//          'C1.Street as Street,'+
//          'C1.Street2 as Street2,'+
//          'C1.Street3 as Street3,'+
//          'C1.Suburb as Suburb,'+
//          'C1.State as State,'+
//          'C1.Postcode as Postcode,'+
//          'C1.Country as Country,'+
//          'C1.Phone as Phone,'+
//          'C1.JobName as JobName,'+
//          'C1.FaxNumber AS FaxNumber,'+
//          'C1.Mobile as Mobile,         '+
//          'C1.Email as Email,'+
//          'C1.Active as Active,'+
//          'C1.CreationDate as CreationDate,'+
//          'C1.ClientNo as AccountNo,'+
//          'C1.GracePeriod AS GracePeriod,'+
//          'C1.StopCredit as StopCredit,'+
//          'C1.ClientTypeID as ClientTypeID,'+
//          'C1.RepID as RepID,'+
//          'C1.TermsID as TermsID,'+
//          'C1.BillStreet AS BillStreet,'+
//          'C1.BillStreet2 AS BillStreet2,'+
//          'C1.BillStreet3 AS BillStreet3,'+
//          'C1.BillSuburb AS BillSuburb,'+
//          'C1.BillState AS BillState,'+
//          'C1.BillPostcode AS BillPostcode,'+
//          'C1.BillCountry AS BillCountry,'+
//          'C1.CUSTFLD1 AS CUSTFLD1,'+
//          'C1.CUSTFLD2 AS CUSTFLD2,'+
//          'C1.CUSTFLD3 AS CUSTFLD3,'+
//          'C1.CUSTFLD4 AS CUSTFLD4,'+
//          'C1.CUSTFLD5 AS CUSTFLD5,'+
//          'C1.CUSTFLD6 AS CUSTFLD6,'+
//          'C1.CUSTFLD7 AS CUSTFLD7,'+
//          'C1.CUSTFLD8 AS CUSTFLD8,'+
//          'C1.CUSTFLD9 AS CUSTFLD9,'+
//          'C1.CUSTFLD10 AS CUSTFLD10,'+
//          'C1.CUSTFLD11 AS CUSTFLD11,'+
//          'C1.CUSTFLD12 AS CUSTFLD12,'+
//          'C1.CUSTFLD13 AS CUSTFLD13,'+
//          'C1.CUSTFLD14 AS CUSTFLD14,'+
//          'C1.CUSTFLD15 AS CUSTFLD15,'+
//          'C1.CUSTDATE1 AS CUSTDATE1,'+
//          'C1.CUSTDATE2 AS CUSTDATE2,'+
//          'C1.CUSTDATE3 AS CUSTDATE3,'+
//          'C1.CallPriority as CallPriority, C1.DefaultContactMethod'+
//          ' FROM tblClients C1'+
//          ' WHERE char_length(C1.Company) >0';
//      tempTablename:='tmp_globalList' +'tempcontactList1';
//      SQLAdd('/*4:*/'+CommonDbLib.SQLforUserTemporaryTable('tmp_globalList',tempTablename , 'tempcontactList1','Myisam')+';') ;
//
//      SQLAdd('/*5:*/'+CreateTemporaryTableusingfile('' , sql , FieldList ,tempTablename , tmpfilename));
//
//      SQLAdd('/*6:*/'+'insert into ' +tablename +'('+fieldList +') Select '+fieldList +' from '+tempTablename +';');
//      SQLAdd('/*7:*/'+'Drop table if exists ' +tempTablename+';');
//
//      tmpfileList.add(tmpfilename);
//
//
//      SQLAdd('/*8:*/'+'/*Primary contacts -customer*/;');
//      SQL := ' inner join ' + tablename +' tmp on   tmp.ID = M.ClientId and M.IsPrimarycontact ="T"';
//      if ExcludeInactiveContactFromMessages then sql:= sql +' and M.Active = "T"';
//      TempMasterTablename:= 'contactList1';
//      sql:= SQLfortemptable('tblcontacts','ClientId,ContactTitle,ContactFirstName,ContactSurName','' ,sql, TempMasterTablename,tmpfilename);
//      SQLAdd('/*9:*/'+sql);
//      sql:=  'update ' + tablename +' tmp inner join ' + TempMasterTablename +' C '+
//          ' on tmp.ID = c.ClientId  ';
//      sql:= sql + ' Set tmp.contactId = C.ContactId, Tmp.Contactname = TRIM(concat_WS(" " ,C.ContactTitle,  C.ContactFirstName, C.ContactSurName)) , '+
//          ' Type = concat(type , "(Primary Contact)") where not(Type like "%(Primary Contact)");';
//      SQLAdd('/*10:*/'+sql);
//      SQLAdd('/*11:*/'+'Drop table if exists ' +TempMasterTablename+';');
//
//      tmpfileList.add(tmpfilename);
//
//      SQLAdd('/*12:*/'+'/*Primary contacts -Supplier*/;');
//      SQL := ' inner join ' + tablename +' tmp on   tmp.ID = M.ClientId and M.IsPrimarycontact ="T"';
//      if ExcludeInactiveContactFromMessages then sql:= sql +' and M.Active = "T"';
//      TempMasterTablename:= 'contactList2';
//      sql:= SQLfortemptable('tblcontacts','ClientId,ContactTitle,ContactFirstName,ContactSurName','' ,sql, TempMasterTablename,tmpfilename);
//      SQLAdd('/*13:*/'+sql);
//      sql:= 'update ' + tablename +' tmp inner join ' + TempMasterTablename +' C '+
//          ' on tmp.ID = c.ClientId  '+
//          ' Set tmp.contactId = C.ContactId, Tmp.Contactname = TRIM(concat_WS(" " ,C.ContactTitle,  C.ContactFirstName, C.ContactSurName)) , '+
//          ' Type = concat(type , "(Primary Contact)");';
//      SQLAdd('/*14:*/'+sql);
//      SQLAdd('/*15:*/'+'Drop table if exists ' +TempMasterTablename+';');
//
//      tmpfileList.add(tmpfilename);
//
//
//      SQLAdd('/*16:*/'+'/*Customer/Supplier Contacts */;');
//      Fieldlist := 'GlobalRef,Type,ID,ParentClientID,Name,Balance,ContactName,Street,Street2,Street3,Suburb,State,Postcode,Country,'+
//                    'Phone,JobName,FaxNumber,Mobile,Email,Active,CreationDate,AccountNo,GracePeriod,StopCredit,ClientTypeID,RepID,TermsID,'+
//                    'BillStreet,BillStreet2,BillStreet3,BillSuburb,BillState,BillPostcode,BillCountry,CUSTFLD1,CUSTFLD2,CUSTFLD3,CUSTFLD4,CUSTFLD5,CUSTFLD6,'+
//                    'CUSTFLD7,CUSTFLD8,CUSTFLD9,CUSTFLD10,CUSTFLD11,CUSTFLD12,CUSTFLD13,CUSTFLD14,CUSTFLD15,CUSTDATE1,CUSTDATE2,CUSTDATE3,contactID,CallPriority,DefaultContactMethod';
//      sql:= ' SELECT C1.GlobalRef,'+
//                    'CASE'+
//                    '	 WHEN C1.IsJob        = "T" THEN "Job(Contact)"'+
//                    '  WHEN C1.Customer     = "T"  and C1.Supplier = "T" THEN "Customer / Supplier(Contact)"'+
//                    '  WHEN C1.Customer     = "T" THEN "Customer(Contact)"'+
//                    '	 WHEN C1.Supplier     = "T" THEN "Supplier(Contact)"'+
//                    '	 WHEN C1.OtherContact = "T" THEN "Prospect(Contact)"'+
//                    '	 WHEN C1.Supplier     = "T" THEN "Supplier(Contact)"'+
//                    '	 ELSE "?"'+
//                    'END AS Type,'+
//                    'C1.ClientID AS ID,'+
//                    'C1.ParentClientID as ParentClientID,'+
//                    'If(InStr(C1.Company,"^") -1 >0,Left(C1.Company,InStr(C1.Company,"^")-1),C1.Company) AS Name,'+
//                    'C1.Balance as Balance,'+
//                    'TRIM(concat_WS(" " ,C.ContactTitle,  C.ContactFirstName, C.ContactSurName)) AS ContactName,'+
//                    'C1.Street as Street,'+
//                    'C1.Street2 as Street2,'+
//                    'C1.Street3 as Street3,'+
//                    'C1.Suburb as Suburb,'+
//                    'C1.State as State,'+
//                    'C1.Postcode as Postcode,'+
//                    'C1.Country as Country,'+
//                    'C1.Phone as Phone,'+
//                    'C1.JobName as JobName,'+
//                    'C1.FaxNumber AS FaxNumber,'+
//                    'C1.Mobile as Mobile,         '+
//                    (*'C1.Email as Email,'+*)
//                    'if(ifnull(C.ContactEmail,"")="" ,C1.Email  ,C.ContactEmail) as Email,' +
//                    'C1.Active as Active,'+
//                    'C1.CreationDate as CreationDate,'+
//                    'C1.ClientNo as AccountNo,'+
//                    'C1.GracePeriod AS GracePeriod,'+
//                    'C1.StopCredit as StopCredit,'+
//                    'C1.ClientTypeID as ClientTypeID,'+
//                    'C1.RepID as RepID,'+
//                    'C1.TermsID as TermsID,'+
//                    'C1.BillStreet AS BillStreet,'+
//                    'C1.BillStreet2 AS BillStreet2,'+
//                    'C1.BillStreet3 AS BillStreet3,'+
//                    'C1.BillSuburb AS BillSuburb,'+
//                    'C1.BillState AS BillState,'+
//                    'C1.BillPostcode AS BillPostcode,'+
//                    'C1.BillCountry AS BillCountry,'+
//                    'C1.CUSTFLD1 AS CUSTFLD1,'+
//                    'C1.CUSTFLD2 AS CUSTFLD2,'+
//                    'C1.CUSTFLD3 AS CUSTFLD3,'+
//                    'C1.CUSTFLD4 AS CUSTFLD4,'+
//                    'C1.CUSTFLD5 AS CUSTFLD5,'+
//                    'C1.CUSTFLD6 AS CUSTFLD6,'+
//                    'C1.CUSTFLD7 AS CUSTFLD7,'+
//                    'C1.CUSTFLD8 AS CUSTFLD8,'+
//                    'C1.CUSTFLD9 AS CUSTFLD9,'+
//                    'C1.CUSTFLD10 AS CUSTFLD10,'+
//                    'C1.CUSTFLD11 AS CUSTFLD11,'+
//                    'C1.CUSTFLD12 AS CUSTFLD12,'+
//                    'C1.CUSTFLD13 AS CUSTFLD13,'+
//                    'C1.CUSTFLD14 AS CUSTFLD14,'+
//                    'C1.CUSTFLD15 AS CUSTFLD15,'+
//                    'C1.CUSTDATE1 AS CUSTDATE1,'+
//                    'C1.CUSTDATE2 AS CUSTDATE2,'+
//                    'C1.CUSTDATE3 AS CUSTDATE3, c.contactID,C1.CallPriority,C1.DefaultContactMethod'+
//                    ' FROM tblClients C1'+
//                    ' Inner join tblcontacts C on IsPrimarycontact ="F"  ';
//      if ExcludeInactiveContactFromMessages then sql:= sql +' and C.Active = "T"';
//      sql:= sql +' and (C1.ClientId = c.ClientId or C1.ClientID = C.ClientId)  '+
//                    ' WHERE char_length(C1.Company) >0';
//      tempTablename:='tmp_globalList' +'tempcontactList2';
//      SQLAdd('/*17:*/'+CommonDbLib.SQLforUserTemporaryTable('tmp_globalList',tempTablename , 'tempcontactList2','Myisam')+';') ;
//
//      SQLAdd('/*18:*/'+CreateTemporaryTableusingfile('' , sql , FieldList ,tempTablename , tmpfilename));
//
//      SQLAdd('/*19:*/'+'insert into ' +tablename +'('+fieldList +') Select '+fieldList +' from '+tempTablename +';');
//      SQLAdd('/*20:*/'+'Drop table if exists ' +tempTablename+';');
//
//      tmpfileList.add(tmpfilename);
//
//      SQLAdd('/*21:*/'+'/*Jobs*/;');
//      SQL := ' inner join ' + tablename +' tmp on   tmp.ID = M.clientId and M.ISJob ="T"';
//      TempMasterTablename:= 'contactList3';
//      sql:= SQLfortemptable('tblClients','StopCredit','' ,sql, TempMasterTablename,tmpfilename);
//      SQLAdd('/*22:*/'+sql);
//      SQLAdd('/*23:*/'+'update ' + tablename +' tmp '+
//                  'inner join '+ TempMasterTablename +' C on C.clientId = tmp.ID   '+
//                  'set tmp.StopCredit = C.StopCredit;');
//      SQLAdd('/*24:*/'+'Drop table if exists ' +TempMasterTablename+';');
//      tmpfileList.add(tmpfilename);
//      SQLAdd('/*25:*/'+'/*Marketing Contacts*/;');
//      FieldList := 'GlobalRef,Type,ID,ParentClientID,Name,Balance,ContactName,Street,Street2,Street3,Suburb,State,Postcode,Country,Phone,JobName,FaxNumber,Mobile,Email,Active,CreationDate,CallPriority,DefaultContactMethod';
//      SQL:=                ' SELECT '+
//                      'GlobalRef as Globalref,'+
//                      '"Marketing Contact" AS Type ,'+
//                      'ID as ID,'+
//                      'ID as ParentClientID,'+
//                      'COMPANY as Name,'+
//                      '0.00 as Balalnce,'+
//                      'if(MiddleName<>Space(1),TRIM(Concat_ws(Space(1),FirstName,MiddleName,LastName)),TRIM(Concat_ws(Space(1),FirstName,LastName))) as ContactName,'+
//                      'Street as Street,'+
//                      'Street2 as street2,'+
//                      'Street3 as Street3,'+
//                      'SUBURB as suburb,'+
//                      'STATE as state,'+
//                      'POSTCODE as postcode,'+
//                      'Country as country,'+
//                      'Phone as phone,'+
//                      'space(1) as jobname,'+
//                      'FaxNumber as Faxnumber,'+
//                      'Mobile as mobile,'+
//                      'Email as Email,'+
//                      'Active as Ative,'+
//                      'DateEntered as CreationDate , CallPriority,DefaultContactMethod'+
//                      ' FROM'+
//                      ' tblmarketingcontacts'+
//                      ' where ClientID = 0';
//      tempTablename:='tmp_globalList' +'tempcontactList3';
//      SQLAdd('/*26:*/'+CommonDbLib.SQLforUserTemporaryTable('tmp_globalList',tempTablename , 'tempcontactList3','Myisam')+';') ;
//      SQLAdd('/*27:*/'+CreateTemporaryTableusingfile('' , sql , FieldList ,tempTablename , tmpfilename));
//      SQLAdd('/*28:*/'+'insert into ' +tablename +'('+fieldList +') Select '+fieldList +' from '+tempTablename +';');
//      tmpfileList.add(tmpfilename);
//      SQLAdd('/*29:*/'+'Drop table if exists ' +tempTablename+';');
//
//
//
//
//      SQLAdd('/*30:*/'+'/*Marketing Contact Primary Contacts */;');
//
//
//      SQL := ' inner join ' + tablename +' tmp on   tmp.ID = M.MarketingcontactID and M.IsPrimarycontact ="T"';
//      TempMasterTablename:= 'contactList4';
//      sql:= SQLfortemptable('tblmarketingcontactcontacts','MarketingcontactID, ContactTitle , ContactFirstName, ContactSurName','' ,sql, TempMasterTablename,tmpfilename);
//      SQLAdd('/*31:*/'+sql);
//      SQLAdd('/*32:*/'+'update ' + tablename +' tmp inner join '+TempMasterTablename+' C '+
//          ' on tmp.ID = c.MarketingcontactID and type = "Marketing Contact" '+
//          ' Set tmp.contactId = C.ContactId, '+
//          ' Tmp.Contactname = TRIM(concat_WS(" " ,C.ContactTitle,  C.ContactFirstName, C.ContactSurName)) , '+
//          ' Type = concat(type , "(Primary Contact)") where tmp.type = "Marketing Contact";');
//
//      tmpfileList.add(tmpfilename);
//      SQLAdd('/*33:*/'+'Drop table if exists ' +TempMasterTablename+';');
//
//
//      SQLAdd('/*34:*/'+'/*Marketing Contact Contacts */;');
//      fieldList:= 'GlobalRef,Type,ID,ParentClientID,Name,Balance,ContactName,Street,Street2,Street3,Suburb,State,Postcode,Country,'+
//                    ' Phone,JobName,FaxNumber,Mobile,Email,Active,CreationDate,AccountNo,GracePeriod,StopCredit,ClientTypeID,RepID,TermsID,'+
//                    ' BillStreet,BillStreet2,BillStreet3,BillSuburb,BillState,BillPostcode,BillCountry,CUSTFLD1,CUSTFLD2,CUSTFLD3,CUSTFLD4,CUSTFLD5,CUSTFLD6,'+
//                    ' CUSTFLD7,CUSTFLD8,CUSTFLD9,CUSTFLD10,CUSTFLD11,CUSTFLD12,CUSTFLD13,CUSTFLD14,CUSTFLD15,CUSTDATE1,CUSTDATE2,CUSTDATE3,contactID,CallPriority,DefaultContactMethod';
//      SQL:= ' SELECT MC.GlobalRef,"Marketing Contact(Contact)"  AS Type,MC.ID AS ID,'+
//                    ' 0 as ParentClientID,MC.Company AS Name,'+
//                    ' 0  as Balance,TRIM(concat_WS(" " ,MCC.ContactTitle,  MCC.ContactFirstName, MCC.ContactSurName)) AS ContactName,'+
//                    ' MCC.ContactAddress as Street,MCC.ContactAddress2 as Street2,MCC.ContactAddress3 as Street3,'+
//                    ' MCC.ContactCity as Suburb,MCC.ContactState as State,'+
//                    ' MCC.ContactPcode as Postcode,MCC.ContactCountry as Country,MCC.ContactPH as Phone," " as JobName,MCC.ContactFax AS FaxNumber,'+
//                    ' MCC.ContactMOB as Mobile,         if(ifnull(MCC.ContactEmail,"")="" ,MC.Email  ,MCC.ContactEmail) as Email,MCC.Active as Active,'+
//                    ' MC.DateEntered as CreationDate,MC.ID as AccountNo,0  AS GracePeriod,"F" as StopCredit,'+
//                    ' 0  as ClientTypeID,0 as RepID,0 as TermsID,MC.BillStreet AS BillStreet,MC.BillStreet2 AS BillStreet2,'+
//                    ' MC.BillStreet3 AS BillStreet3,MC.BillSuburb AS BillSuburb,MC.BillState AS BillState,MC.BillPostcode AS BillPostcode,'+
//                    ' MC.BillCountry AS BillCountry,MC.CUSTFLD1 AS CUSTFLD1,MC.CUSTFLD2 AS CUSTFLD2,MC.CUSTFLD3 AS CUSTFLD3,'+
//                    ' MC.CUSTFLD4 AS CUSTFLD4,MC.CUSTFLD5 AS CUSTFLD5,MC.CUSTFLD6 AS CUSTFLD6,MC.CUSTFLD7 AS CUSTFLD7,'+
//                    ' MC.CUSTFLD8 AS CUSTFLD8,MC.CUSTFLD9 AS CUSTFLD9,MC.CUSTFLD10 AS CUSTFLD10,MC.CUSTFLD11 AS CUSTFLD11,'+
//                    ' MC.CUSTFLD12 AS CUSTFLD12,MC.CUSTFLD13 AS CUSTFLD13,MC.CUSTFLD14 AS CUSTFLD14,MC.CUSTFLD15 AS CUSTFLD15,'+
//                    ' MC.CUSTDATE1 AS CUSTDATE1,MC.CUSTDATE2 AS CUSTDATE2,MC.CUSTDATE3 AS CUSTDATE3, MCC.contactID, MC.CallPriority,MC.DefaultContactMethod'+
//                    ' FROM tblmarketingcontacts MC '+
//                    ' Inner join tblmarketingcontactcontacts MCC on IsPrimarycontact ="F"  '+
//                    ' and (MC.ID = MCC.MarketingcontactID)   WHERE char_length(MCC.Company) >0';
//      tempTablename:='tmp_globalList' +'tempcontactList4';
//      SQLAdd('/*35:*/'+CommonDbLib.SQLforUserTemporaryTable('tmp_globalList',tempTablename , 'tempcontactList4','Myisam')+';') ;
//      SQLAdd('/*36:*/'+CreateTemporaryTableusingfile('' , sql , FieldList ,tempTablename , tmpfilename));
//      SQLAdd('/*37:*/'+'insert into ' +tablename +'('+fieldList +') Select '+fieldList +' from '+tempTablename +';');
//      tmpfileList.add(tmpfilename);
//      SQLAdd('/*38:*/'+'Drop table if exists ' +tempTablename+';');
//
//      fieldList:= 'GlobalRef,Type,ID,ParentClientID,Name,Balance,ContactName,Street,Street2,Street3,Suburb,State,Postcode,Country,'+
//                    'Phone,JobName,FaxNumber,Mobile,Email,Active,CreationDate,CallPriority,DefaultContactMethod';
//      SQL:= ' SELECT GlobalRef,'+
//                    '"Employee" As Type,'+
//                    'EmployeeID as ID,'+
//                    'EmployeeID as ParentClientID,'+
//                    'if(MiddleName<>Space(1),TRIM(Concat_ws(Space(1),FirstName,MiddleName,LastName)),TRIM(Concat_ws(Space(1),FirstName,LastName))) AS Name,'+
//                    '0.00 As Balance,'+
//                    'if(MiddleName<>Space(1),TRIM(Concat_ws(Space(1),FirstName,MiddleName,LastName)),TRIM(Concat_ws(Space(1),FirstName,LastName))) AS ContactName,'+
//                    'Street as Street,'+
//                    'Street2 as Street2,'+
//                    'Street3 as Street3,'+
//                    'Suburb as Suburb,'+
//                    'State as State,'+
//                    'Postcode as Postcode,'+
//                    'Country as Country,'+
//                    'Phone as Phone,'+
//                    'Space(1) as JobName,'+
//                    'FaxNumber AS FaxNumber,'+
//                    'Mobile as Mobile,'+
//                    'Email as Email,'+
//                    'Active as Active,'+
//                    'CreationDate as CreationDate, E.CallPriority,E.DefaultContactMethod'+
//                    ' FROM tblEmployees  E '+
//                    ' WHERE char_length(FirstName) >0';
//      tempTablename:='tmp_globalList' +'tempcontactList5';
//      SQLAdd('/*39:*/'+CommonDbLib.SQLforUserTemporaryTable('tmp_globalList',tempTablename , 'tempcontactList5','Myisam')+';') ;
//      SQLAdd('/*40:*/'+CreateTemporaryTableusingfile('' , sql , FieldList ,tempTablename , tmpfilename));
//      SQLAdd('/*41:*/'+'insert into ' +tablename +'('+fieldList +') Select '+fieldList +' from '+tempTablename +';');
//      SQLAdd('/*42:*/'+'Drop table if exists ' +tempTablename+';');
//      tmpfileList.add(tmpfilename);
//      SQLAdd('/*43:*/'+'update ' + tablename +' tmp Set Type = Replace(type , "(Primary Contact)(Primary Contact)" , "(Primary Contact)");');
//
//      //delete the temp files before query to make sure is deleted
//      for ctr := 0 to tmpfileList.count-1 do BEGIN
//        AppEnv.UtilsClient.DeleteServerFiles(replaceStr(tmpfileList[ctr], '.tmp' , '*.tmp'));
//      END;
//
//      createtemptable(str.text , str.count);
//      REsult := True;
//    finally
//      FreeandNil(Str);
//    End;
//  finally
//    for ctr := 0 to tmpfileList.count-1 do BEGIN
//      AppEnv.UtilsClient.DeleteServerFiles(replaceStr(tmpfileList[ctr], '.tmp' , '*.tmp'));
//    END;
//    Freeandnil(tmpfileList);
//  end;
//Except
//    on E:Exception do begin
//      Result := False;
//    end;
//end;
end;
procedure doProgressbar(Sender: TObject; var SQL: string;      var Omit: Boolean);
begin
  DoStepProgressbar;
end;
end.
