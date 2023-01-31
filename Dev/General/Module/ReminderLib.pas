unit ReminderLib;

interface
uses MyAccess,ERPdbComponents , db;

Function PopulateReminders(var Tablename:String; FRomDate, ToDate :TDatetime ; EmployeeId :Integer;  FordateRange :Boolean = True; showAllREmidners :Boolean =False):String;

implementation

uses AppEnvironment, CommonDbLib, FastFuncs, BusObjApprovals, sysutils,
  ProgressDialog, tcDataUtils, MySQLConst, tcConst , DateUtils,
  EmployeeAccesses, BusObjPersonalPreference;

Function PopulateReminders(var Tablename:String;FRomDate, ToDate :TDatetime ; EmployeeId :Integer; FordateRange :Boolean = True; showAllREmidners :Boolean =False):String;
var
    Script :TERPScript;
    iHideDays :Integer;
    ApprovalReminders : TApprovalReminders;
    //tablename :String;


    Function  Datefilter(const fName:STring ; const Days :Integer; const isappt :Boolean = False):String;
    var
        strSQL:String;
    begin
        strSQL := '';

        if not FordateRange then begin {reminder days and reminder hide days}
            strSQL := strSQL + ' (DATE_ADD(' + fname + ', INTERVAL  ' + IntToStr(days) + ' DAY)>= ' + QuotedStr(FormatDatetime(MysqlDateFormat , FromDAte)) +')' +
                           ' AND (DATE_ADD(' + fname + ', INTERVAL  ' + IntToStr(days) + ' DAY) <= ' + QuotedStr(FormatDatetime(MysqlDateFormat , ToDate)) +')' ;
//            if iHideDays <> 0 then
//                strSQL := strSQL + ' and (Date_Add(' + fname + ', INTERVAL ' + IntToStr(iHideDays) + ' DAY)>= ' + QuotedStr(FormatDatetime(MysqlDateFormat , toDate)) +')';
        end;

        if FromDate <> 0 then begin
            { changed to apply date range to everything, not just appointments }
//            if isappt then begin
                if strSQL <> '' then strSQL := strSQL + ' AND ' ;
                strSQL := strSQL + fName + ' >= ' + QuotedStr(formatDateTime(MysqlDateFormat , FromDate));
//            end;
        end;

        if toDate <> 0 then begin
            if strSQL <> '' then strSQL := strSQL + ' AND ' ;
            strSQL := strSQL + fName + ' <= ' + QuotedStr(formatDateTime(MysqlDateFormat , Todate));
        end;

        if iHideDays <> 0 then begin
          if strSQL <> '' then strSQL := strSQL + ' AND (' ;
          strSQL := strSQL + ' (TO_DAYS(NOW()) - TO_DAYS('+fname+')) <= ' +IntToStr(iHideDays) +')';
        end;

        Result := strSQL;
    end;
    function EmployeeFilter(const fname :String):String;
    begin
        if EmployeeId <> 0 then
            Result := ' AND ' + Fname + '= ' + IntToStr(EmployeeID);
    end;
    Function InDays(Datefield:String ):String;
    begin
              REsult:=  'CASE WHEN TO_DAYS(' + Datefield +')     = TO_DAYS(NOW()) THEN "TODAY"'+
                        '     WHEN TO_DAYS(' + Datefield +')-1   = TO_DAYS(NOW()) THEN "TOMORROW"'+
                        '     WHEN TO_DAYS(' + Datefield +')     < TO_DAYS(NOW()) THEN CONCAT("OVERDUE! ", TO_DAYS(NOW()) - TO_DAYS(' + Datefield +'))'+
                        '     ELSE CONCAT("+ ",TO_DAYS(' + Datefield +') - TO_DAYS(NOW())) '+
                        ' END';

    end;
begin
    if Tablename = '' then tablename := CreateUserTemporaryTable('tmp_reminderlist');
    REsult := Tablename;
    Script := TERPScript.Create(nil);
    TRy
      ApprovalReminders := TApprovalReminders.Create(nil);
      try
        Script.Connection := CommonDbLib.GetSharedMyDacConnection;
        iHideDays := ReminderHideDays(AppEnv.Employee.EmployeeID);


        Script.SQL.Clear;
        Script.SQL.Add('truncate table '+tablename+';');

        if showAllREmidners or (AppEnv.Employee.APPAppearDays > 0)  then begin
{------}   Script.SQL.Add('INSERT HIGH_PRIORITY INTO ' + Tablename+
                          ' (typeno, Status, DueTime, CompanyLabel,Type, ID, Created, Due, Notes,Description, ClientID, Client, `In Days`, ProjectLineID, EmployeeID)'+
                          ' SELECT 1, A.Status, A.STARTTIME, "Client Details" , if(A.LocalApp="T" , "Go Live Apt" , "Appointment") as Type, '+
                          ' A.appointid,'+
                          ' A.CreationDate as Created,'+
                          ' A.AppDate as Due, A.Notes,'+
                          ' Concat_ws(" - ",TIME_FORMAT(A.STARTTIME,"%l:%i %p") ,  TIME_FORMAT(A.ENDTIME, "%l:%i %p") ) as  Description,'+
                          ' C.ClientID as ClientID, ifnull(C.Company, if(unavailable="T" , "Un-Available" , if(LocalApp="T" , "Go Live Apt" , "Local"))) as Client,'+
                          InDays('A.AppDate')+'  AS "In Days",' +
                          ' 0 As ProjectLineID,'+
                          ' A.TrainerID'+
                          ' FROM tblAppointments as A left join  tblClients as C on C.ClientID = A.CusID'+
                          ' Left join tblmarketingleadlines MLL on A.Globalref = MLL.ActionREf and MLL.Actiontype = ' + IntToStr(LeadActionAppointment) + ' and MLL.Done = "F"'+
                          ' WHERE A.Active = "T" and ifnull(A.Cancellation , "F") <>"T" '+
                          ' AND ifnull(Actual_start_time,0) =0'+
                          ' AND ' + Datefilter('A.AppDate' , AppEnv.Employee.APPAppearDays , true)+
                          ' AND A.AppDate >= ' + QuotedStr(formatDateTime(MysqlDateFormat , incday(Date , -2))) +
                          ' AND A.AppDate >= CURDATE()' +{ don't show appointments older than today }
                          EmployeeFilter('A.TrainerID')+';');
        end;
        if showAllREmidners or (AppEnv.Employee.EmployeeskillRenewalAppearDays > 0)  then begin
{------}   Script.SQL.Add('INSERT HIGH_PRIORITY INTO ' + Tablename+
                          ' (typeno, DueTime, CompanyLabel,Type, ID, Created, Due, Notes,Description, ClientID, Client, `In Days`, ProjectLineID, EmployeeID)'+
                          ' SELECT 2, ES.RenewalDate , "Skill Provider" , "Employee Skill Renewal" as Type,'+
                          ' ES.EmpSkillID,'+
                          ' ES.CompletedDate as Created,'+
                          ' ES.RenewalDate as Due,'+
                          ' ES.SkillName,'+
                          ' "" as  Description,'+
                          ' ES.ProviderID as ClientID,'+
                          ' ES.ProviderName as Client,'+
                          InDays('ES.Renewaldate')+'  AS "In Days",' +
                          ' 0 As ProjectLineID,'+
                          ' ES.EmployeeID'+
                          ' From tblemployees E'+
                          ' inner join tblemployeeskills ES on E.EmployeeID = ES.EmployeeID'+
                          ' WHERE E.active ="T" and ifnull(ES.RenewalDate,0)<>0'+
                          ' AND ' + Datefilter('ES.RenewalDate' , AppEnv.Employee.EmployeeskillRenewalAppearDays , true)+
                          EmployeeFilter('E.EmployeeId')+' ;');
        end;



        if showAllREmidners or (AppEnv.Employee.MarketingContactsAppearDays > 0)  then begin
{------}   Script.SQL.Add('INSERT HIGH_PRIORITY INTO ' + Tablename+
                          ' (typeno, Status, DueTime,CompanyLabel,Type, ID, Created, Due, Notes,Description, MarketingcontactID,ClientID, Client, `In Days`, ProjectLineID, EmployeeID)'+
                          ' SELECT 3,'+
                          ' ST.Name as Status, '+
                          ' F1.ActionDate,'+
                          ' "Client Details" ,  '+
                          ' "Marketing Contact FollowUp", '+
                          ' F1.Leadid, '+
                          ' F1.CreationDate,'+
                          ' F1.ActionDate, '+
                          ' CONCAT_WS(" - ", ifnull(F1.ResultTypeName,""), ifnull(F1.Notes,"")) as Notes,'+
                          ' "" as Description ,  '+
                          ' F2.MarketingcontactID, '+
                          ' C3.clientID, '+
                          ' C3.Company,'+
                          InDays('F1.ActionDate')+'  AS "In Days",' +
                          ' 0,'+
                          ' F1.EmployeeID'+
                          ' FROM tblmarketingleadlines as F1 INNER JOIN tblsimpletypes ST ON F1.ActionType=ST.Id, tblmarketingleads as F2, tblmarketingcontacts as C3'+
                          ' WHERE F1.IsLead <> "T" '+
                          ' and F1.LeadId = F2.LeadID '+
                          ' AND F1.Done <> "T" '+
                          ' AND (C3.ID = F2.MarketingcontactID AND ifnull(F1.ResultTypeName, "") <> "Appointment")'+
                          ' AND ' + Datefilter('F1.ActionDate' , AppEnv.Employee.MarketingContactsAppearDays)+
                          EmployeeFilter('F1.EmployeeID')+ ' ;');
        end;


        if showAllREmidners or (AppEnv.Employee.ServiceLogAprearDays > 0 )  then begin
{------}   Script.SQL.Add('INSERT HIGH_PRIORITY INTO ' + Tablename+
                          ' (typeno, DueTime,CompanyLabel,Type, ID, Created, Due, Notes,Description, MarketingcontactID,ClientID, Client, `In Days`, ProjectLineID, EmployeeID)'+
                          ' SELECT 4, '+
                          ' NextServiceDate,'+
                          ' "Asset Name" ,  '+
                          ' "Service Log", '+
                          ' ServiceID, '+
                          ' CreationDate,'+
                          ' NextServiceDate, '+
                          ' "", '+
                          ' AssetName as Description,'+
                          '  NULL, '+
                          ' NULL, '+
                          ' NULL,'+
                          InDays('Convert(NextServiceDate,DATE)')+'  AS "In Days",' +
                          '  0,'+
                          ' EmployeeID'+
                          ' FROM tblfixedassetservicelog '+
                          ' WHERE done ="F" and ' +Datefilter('Convert(NextServiceDate,DATE)' , AppEnv.Employee.ServiceLogAprearDays)+
                          EmployeeFilter('EmployeeID')+ ' ;');
        end;


        if showAllREmidners or (AppEnv.Employee.LeadsAppearDays > 0 )  then begin
{------}   Script.SQL.Add('INSERT HIGH_PRIORITY INTO ' + Tablename+
                          ' (typeno, Status, DueTime,CompanyLabel,Type, ID, Created, Due, Notes,Description, MarketingcontactID,ClientID, Client, `In Days`, ProjectLineID, EmployeeID)'+
                          ' SELECT 5, '+
                          ' S1.Name as Status, '+
                          ' F1.ActionDate,'+
                          ' "Client Details" ,  '+
                          ' "Lead FollowUp", '+
                          ' F1.LeadId, '+
                          ' F1.CreationDate,'+
                          ' F1.ActionDate, '+
                          ' CONCAT_WS(" - ", ifnull(F1.ResultTypeName,""), ifnull(F1.Notes,"")),'+
                          '  "" as Description,'+
                          '  C3.MarketingContactID, C1.clientID, C1.Company,'+
                          InDays('F1.ActionDate')+'  AS "In Days",' +
                          ' 0,'+
                          ' F1.EmployeeID'+
                          ' FROM tblMarketingleadlines as F1'+
                          ' Left join  tblsimpletypes as S1 on S1.Id = F1.ActionType'+
                          ' inner join  tblMarketingleads as C3 on C3.LeadID = F1.LeadID'+
                          ' inner join  tblmarketingcontacts as C1 on C1.ID = C3.MarketingContactID'+
                          ' WHERE F1.IsLead <> "F"'+
                          ' AND F1.Done <> "T"'+
                          EmployeeFilter('F1.EmployeeID')+
                          ' AND ' +Datefilter('F1.ActionDate' , AppEnv.Employee.LeadsAppearDays)+
                          ' AND not(Actiontype in (' +
                          IntToStr(LeadActionAppointment) +','+
                          IntToStr(LeadActionInvoice) +','+
                          IntToStr(LeadActionSalesOrder) +','+
                          IntToStr(LeadActionQuote) +'))'+ ' ;');
        end;
        if showAllREmidners or (AppEnv.Employee.GoodToReceiveReminderDays > 0 )  then begin
{------}   Script.SQL.Add('INSERT HIGH_PRIORITY INTO ' + Tablename+
                          ' (typeno, Type, ID, Created, Due, Description, ClientID, Client, `In Days`,EmployeeID)'+
                          ' SELECT 6, '+
                          ' "Back Orders To Receive" as type,'+
                          ' PO.purchaseOrderID,'+
                          ' PO.orderdate as Created,'+
                          ' ifnull(POL.ETADate, PO.ETADate) as Due,'+
                          ' concat(POL. UnitofMeasureBackorder  , " " ,  POL.UnitofMeasurePOLines , "(" , POL.UnitofMeasureMultiplier , ")  of " ,POL.Productname  ) as Description,'+
                          ' PO.clientID,'+
                          ' PO.SupplierName,'+
                          InDays('ifnull(POL.ETADate, PO.ETADate)')+'  AS "In Days",' +
                          ' PO.EmployeeID'+
                          ' FROM tblpurchaseOrders PO inner join tblPurchaseLines POL on PO.purchaseorderId = POL.purchaseOrderID'+
                          ' WHERE ifnull(Shipped,0)=0 and ifnull(Backorder,0)<> 0'+
                          EmployeeFilter('PO.EmployeeId')+
                          '  AND ' +Datefilter('ifnull(POL.ETADate, PO.ETADate)' , AppEnv.Employee.GoodToReceiveReminderDays)+ ' ;');
        end;
        if showAllREmidners or (AppEnv.Employee.ToDoAppearDays > 0 )   then begin
{------}   Script.SQL.Add('INSERT HIGH_PRIORITY INTO ' + Tablename+
                          ' (typeno, DueTime,CompanyLabel,Type, ID, Created, Due, Notes,Description, ClientID, Client, `In Days`, ProjectLineID, EmployeeID)'+
                          ' SELECT 7, '+
                          ' T.ToDoByDate,'+
                          ' "Employee Details" ,  '+
                          ' T.Type,'+
                          '  T.ToDoID, '+
                          ' T.CreatedDate,'+
                          ' T.ToDoByDate, '+
                          ' "" as Notes,'+
                          ' LEFT(T.Description, 255) as Description,'+
                          '  0, '+
                          ' concat_WS(" " , E.Title ,E.FirstName , E.MiddleName , E.LastName) as Client,'+
                          InDays('T.ToDoByDate')+'  AS "In Days",' +
                          ' 0,'+
                          ' T.EmployeeID'+
                          ' FROM tblToDo as T'+
                          ' Inner join tblemployees as E on T.EmployeeID = E.EmployeeId'+
                          ' WHERE (T.Type = "ToDo")  AND (T.Active ="T")  AND (T.Done <> "T" AND T.Completed <> "T") and (ShowReminder = "T")'+
                          EmployeeFilter('T.EmployeeID')+
                          '  AND ' +Datefilter('T.ToDoByDate' , AppEnv.Employee.ToDoAppearDays)+ ' ;');

{------}   Script.SQL.Add('INSERT HIGH_PRIORITY INTO ' + Tablename+
                          ' (typeno, DueTime,CompanyLabel,Type, ID, Created, Due, Notes,Description, ClientID, Client, `In Days`, ProjectLineID, EmployeeID)'+
                          ' SELECT 8, '+
                          ' T.ToDoByDate,'+
                          ' "Employee Details" ,'+
                          '  T.Type, '+
                          ' /*T.OtherID*/T.todoId, '+
                          ' T.CreatedDate,'+
                          ' T.ToDoByDate, '+
                          ' "" as Notes , '+
                          ' LEFT(T.Description, 255) as Description ,'+
                          '  0,'+
                          ' Concat_WS(" " , E.Title ,E.FirstName , E.MiddleName , E.LastName) ,'+
                          InDays('T.ToDoByDate')+'  AS "In Days",' +
                          ' 0,'+
                          ' T.EmployeeID'+
                          ' FROM tblToDo as T'+
                          ' Inner join tblemployees as E on T.EmployeeID = E.EmployeeId'+
                          ' WHERE  (T.Type <> "ToDo") AND (T.Active ="T")  AND (T.Done <> "T" AND T.Completed <> "T") and (ShowReminder = "T")'+
                          '  and not (type ="Support" and ifnull(OtherId,0) <>0) '+  // ignore the phone support todos as the phone support type(typeno = 25) shows it anyway
                          EmployeeFilter('T.EmployeeID')+
                          '  AND ' +Datefilter('T.ToDoByDate' , AppEnv.Employee.ToDoAppearDays)+ ' ;');
        end;

        if showAllREmidners or (AppEnv.Employee.EquipmentServiceAppearDays > 0 )   then begin
{------}   Script.SQL.Add('INSERT HIGH_PRIORITY INTO ' + Tablename+
                          ' (typeno, DueTime,CompanyLabel,Type, ID, Created, Due, Notes,Description, ClientID, Client, `In Days`, ProjectLineID, EmployeeID)'+
                          ' SELECT 9, '+
                          ' NextServiceDate,'+
                          ' "Client Details" , '+
                          ' L.ItemName as Equipment, '+
                          ' 0,'+
                          ' 0,'+
                          ' NextServiceDate,'+
                          ' "Service",'+
                          ' "" as Description , '+
                          ' L.ClientID,'+
                          ' C.Company as Client,'+
                          InDays('Convert(NextServiceDate,DATE)')+'  AS "In Days",' +
                          ' 0, 0'+
                          ' FROM tblequipmentservice as L, tblClients as C'+
                          ' WHERE  C.ClientID = L.ClientID'+
                          '  AND ' +Datefilter('Convert(NextServiceDate,DATE)' , AppEnv.Employee.EquipmentServiceAppearDays)+ ' ;');
        end;

        if showAllREmidners or (AppEnv.Employee.FixedAssetWarrantyAppearDays > 0 )   then begin
{------}   Script.SQL.Add('INSERT HIGH_PRIORITY INTO ' + Tablename+
                          ' (typeno, DueTime,CompanyLabel,Type, ID, Created, Due, Notes,Description, ClientID, Client, `In Days`, ProjectLineID, EmployeeID)'+
                          ' SELECT DISTINCT 10, '+
                          ' T.WarrantyExpiresDate,'+
                          ' " ", '+
                          ' "Fixed Asset Warranty due to Expire", '+
                          ' T.AssetID, '+
                          ' T.PurchDate,'+
                          ' T.WarrantyExpiresDate, '+
                          ' T.AssetName , '+
                          ' "" as Description, '+
                          ' 0, '+
                          ' " ",'+
                          InDays('T.WarrantyExpiresDate')+'  AS "In Days",' +
                          ' 0, 0'+
                          ' FROM tblfixedassets AS T'+
                          ' WHERE ' +Datefilter('T.WarrantyExpiresDate' , AppEnv.Employee.FixedAssetWarrantyAppearDays)+ ' ;');
        end;

        if showAllREmidners or (AppEnv.Employee.FixedAssetInsuranceAppearDays > 0 )   then begin
{------}   Script.SQL.Add('INSERT HIGH_PRIORITY INTO ' + Tablename+
                          ' (typeno, DueTime,CompanyLabel,Type, ID, Created, Due, Notes,Description, ClientID, Client, `In Days`, ProjectLineID, EmployeeID)'+
                          ' SELECT DISTINCT 11, T.InsuredUntil, " " , "Fixed Asset Insurance due to Expire", T.AssetID, T.PurchDate,'+
                          ' T.InsuredUntil, T.AssetName, "", 0, " ", '+
                          InDays('T.InsuredUntil')+'  AS "In Days",' +
                          ' 0, 0'+
                          ' FROM tblfixedassets AS T'+
                          ' WHERE ' +Datefilter('T.InsuredUntil' , AppEnv.Employee.FixedAssetInsuranceAppearDays)+ ' ;');
        end;

        if showAllREmidners or (AppEnv.Employee.OthContactAppearDays > 0  )  then begin
{------}   Script.SQL.Add('INSERT HIGH_PRIORITY INTO ' + Tablename+
                          ' (typeno, DueTime,CompanyLabel,Type, ID, Created, Due,Notes, Description, ClientID, Client, `In Days`, ProjectLineID, EmployeeID, ContactId, ContactName)'+
                          ' SELECT  12, '+
                          ' F.FollowUpDate,'+
                          ' "Client Details" , '+
                          ' "Repair FollowUp", '+
                          ' F.RepairID, '+
                          ' F.CreationDate,'+
                          ' F.FollowUpDate, '+
                          ' F.Notes, '+
                          ' F.Notes as Description, '+
                          ' C2.ClientID, C2.Company,'+
                          InDays('F.FollowUpDate')+'  AS "In Days",' +
                          ' 0,'+
                          ' F.EmployeeID, F.ContactId,'+
                          ' CASE WHEN F.ContactId=0 then ""'+
                          ' else (select Concat(c.ContactFirstName, " ", C.ContactSurName) from tblContacts C where C.ContactId=F.ContactId) end '+
                          ' FROM tblOtherFollowup as F, tblClients as C2'+
                          ' WHERE F.Done <> "T"  AND F.RepairID > 0 AND C2.ClientID = F.ClientID'+
                          EmployeeFilter('F.EmployeeID')+
                          ' AND ' +Datefilter('F.FollowUpDate' , AppEnv.Employee.OthContactAppearDays)+ ' ;');

{------}   Script.SQL.Add('INSERT HIGH_PRIORITY INTO ' + Tablename+
                          ' (typeno, DueTime,CompanyLabel,Type, ID, Created, Due, Notes,Description, ClientID, Client, `In Days`, ProjectLineID, EmployeeID, ContactId, ContactName)'+
                          ' SELECT  13, '+
                          ' F1.FollowUpDate,'+
                          ' "Client Details" , '+
                          ' "Other Contact FollowUp", '+
                          ' F1.FollowUpID, '+
                          ' F1.CreationDate,'+
                          ' F1.FollowUpDate, '+
                          ' F1.Notes, '+
                          ' F1.Notes as Description,  '+
                          ' C3.ClientID, C3.Company,'+
                          InDays('F1.FollowUpDate')+'  AS "In Days",' +
                          ' 0,'+
                          ' F1.EmployeeID, F1.ContactId,'+
                          ' CASE WHEN F1.ContactId=0 then ""'+
                          ' else (select Concat(c.ContactFirstName, " ", C.ContactSurName) from tblContacts C where C.ContactId=F1.ContactId) end '+
                          ' FROM tblOtherFollowup as F1, tblClients as C3'+
                          ' WHERE F1.OtherContactID > 0 AND F1.Done <> "T" '+
                          ' AND C3.ClientID = F1.ClientID AND F1.IsSupplier <> "T" AND IsCustomer <> "T"'+
                          EmployeeFilter('F1.EmployeeID')+
                          ' AND ' +Datefilter('F1.FollowUpDate' , AppEnv.Employee.OthContactAppearDays)+ ' ;');

{------}   Script.SQL.Add('INSERT HIGH_PRIORITY INTO ' + Tablename+
                          ' (typeno, DueTime,CompanyLabel,Type, ID, Created, Due, Notes,Description, ClientID, Client, `In Days`, ProjectLineID, EmployeeID, ContactId, ContactName)'+
                          ' SELECT  14, F1.FollowUpDate,"Client Details" , "Supplier FollowUp", F1.FollowUpID, F1.CreationDate,'+
                          ' F1.FollowUpDate, '+
                          ' F1.Notes, '+
                          ' F1.Notes as Description ,  '+
                          ' C3.ClientID, C3.Company,'+
                          InDays('F1.FollowUpDate')+'  AS "In Days",' +
                          ' 0, '+
                          ' F1.EmployeeID, ContactId,'+
                          ' CASE WHEN F1.ContactId=0 then ""'+
                          ' else (select Concat(c.ContactFirstName, " ", C.ContactSurName) from tblContacts C where C.ContactId=F1.ContactId) end '+
                          ' FROM tblOtherFollowup as F1, tblClients as C3'+
                          ' WHERE F1.Done <> "T"'+
                          ' AND C3.ClientID = F1.ClientID AND F1.IsSupplier = "T"'+
                          EmployeeFilter('F1.EmployeeID')+
                          ' AND ' +Datefilter('F1.FollowUpDate' , AppEnv.Employee.OthContactAppearDays)+ ' ;');

{------}   Script.SQL.Add('INSERT HIGH_PRIORITY INTO ' + Tablename+
                          ' (typeno, DueTime,CompanyLabel,Type, ID, Created, Due, Notes,Description, ClientID, Client, `In Days`, ProjectLineID, EmployeeID, ContactId, ContactName)'+
                          ' SELECT  IF(C3.IsJob = "T",15,16),F1.FollowUpDate,"Client Details" , IF(C3.IsJob = "T","Customer Job FollowUp","Customer FollowUp"), F1.FollowUpID, F1.CreationDate,'+
                          ' F1.FollowUpDate, '+
                          ' F1.Notes, '+
                          ' F1.Notes as Description,  '+
                          ' C3.ClientID, C3.Company,'+
                          InDays('F1.FollowUpDate')+'  AS "In Days",' +
                          ' 0,'+
                          ' F1.EmployeeID, F1.ContactId,'+
                          ' CASE WHEN F1.ContactId=0 then ""'+
                          ' else (select Concat(c.ContactFirstName, " ", C.ContactSurName) from tblContacts C where C.ContactId=F1.ContactId) end '+
                          ' FROM tblOtherFollowup as F1, tblClients as C3'+
                          ' WHERE F1.Done <> "T"'+
                          ' AND C3.ClientID = F1.ClientID AND F1.IsCustomer = "T"'+
                          EmployeeFilter('F1.EmployeeID')+
                          ' AND ' +Datefilter('F1.FollowUpDate' , AppEnv.Employee.OthContactAppearDays)+ ' ;');

            end;

        if showAllREmidners or (AppEnv.Employee.QuoteAppearDays > 0  )  then begin
{------}   Script.SQL.Add('INSERT HIGH_PRIORITY INTO ' + Tablename+
                          ' (typeno, Status, DueTime,CompanyLabel,Type, ID, Created, Due, Notes,Description, ClientID, Client, `In Days`, ProjectLineID, EmployeeID)'+
                          ' SELECT  17, S.QuoteStatus as Status,S.DueDate,"Client Details" , "Quote" AS Type, S.SaleID AS ID, S.SaleDate AS Created,'+
                          ' S.DueDate AS Due, '+
                          ' S.Memo ,'+
                          ' "" as Description,'+
                          '  S.ClientID AS ClientID, S.CustomerName AS Client,'+
                          InDays('S.DueDate')+'  AS "In Days",' +
                          ' 0 AS ProjectLineID,'+
                          ' S.EmployeeID'+
                          ' FROM tblSales as S'+
                          ' INNER JOIN tblSalesLines ON S.SaleID = tblSalesLines.SaleID'+
                          ' LEFT JOIN tblrelatedsales RS on RS.PreviousRef = S.Globalref'+
                          ' WHERE ifnull(RS.PreviousRef , "") = "" and  S.Converted <> "T" AND S.Deleted <> "T"  AND S.IsQuote = "T" and S.Isdone<> "T"'+
                          EmployeeFilter('S.EmployeeID')+
                          ' AND ' +Datefilter('S.DueDate' , AppEnv.Employee.QuoteAppearDays)+
                          ' AND tblSalesLines.Invoiced = "T"'+
                          ' GROUP By S.SaleID;');
        end;

        if showAllREmidners or (AppEnv.Employee.PendingSOAppearDays > 0  )  then begin
{------}   Script.SQL.Add('INSERT HIGH_PRIORITY INTO ' + Tablename+
                          ' (typeno, status, DueTime,CompanyLabel,Type, ID, Created, Due, Notes,Description, ClientID, Client, `In Days`, ProjectLineID, EmployeeID)'+
                          ' SELECT  18,S.QuoteStatus as Status, S.DueDate, '+
                          ' "Client Details" , '+
                          ' "SalesOrder" AS Type, S.SaleID AS ID, S.SaleDate AS Created,'+
                          ' S.DueDate AS Due, '+
                          ' S.Memo ,'+
                          ' "" as Description,  '+
                          ' S.ClientID AS ClientID, S.CustomerName AS Client,'+
                          InDays('S.DueDate')+'  AS "In Days",' +
                          ' 0 AS ProjectLineID,'+
                          ' S.EmployeeID'+
                          ' FROM tblSales as S'+
                          ' INNER JOIN tblSalesLines ON S.SaleID = tblSalesLines.SaleID'+
                          ' WHERE S.Deleted <> "T" AND S.isSalesOrder = "T"'+
                          ' AND S.converted <> "T"'+
                          EmployeeFilter('S.EmployeeID')+
                          ' AND ' +Datefilter('S.DueDate' , AppEnv.Employee.PendingSOAppearDays)+
                          ' GROUP By S.SaleID'+ ' ;');
        end;

        if showAllREmidners or (AppEnv.Employee.CustomerLoyaltyAppearDays > 0  )  then begin
{------}   Script.SQL.Add('INSERT HIGH_PRIORITY INTO ' + Tablename+
                          ' (typeno, DueTime,CompanyLabel,Type, ID, Created, Due, Notes,Description, ClientID, Client, `In Days`, ProjectLineID, EmployeeID)'+
                          ' SELECT 19, ' +
                          QuotedStr(FormatDateTime(MysqlDateFormat,AppEnv.CompanyPrefs.LoyaltyReminderDate))+', '+
                          ' "", "Loyalty" as Type, 0, 0,'+
                          QuotedStr(FormatDateTime(MysqlDateFormat,AppEnv.CompanyPrefs.LoyaltyReminderDate))+', '+
                          ' "Loyalty Mailout", '+
                          ' "" as Description ,'+
                          '  0, "",'+
                          InDays(QuotedStr(FormatDateTime(MysqlDateFormat,AppEnv.CompanyPrefs.LoyaltyReminderDate)))+'  AS "In Days",' +
                          ' 0, 0'+
                          ' FROM DUAL'+
                          '  Where ' + DAtefilter(QuotedStr(FormatDatetime(MysqlDateFormat , AppEnv.CompanyPrefs.LoyaltyReminderDate)) , AppEnv.CompanyPrefs.LoyaltyReminderRepeatDays)+ ' ;');
        end;

        if showAllREmidners or (AppEnv.CompanyPrefs.UseApprovalLevels and CanApproveTran()) then begin
{------}   Script.SQL.Add('INSERT HIGH_PRIORITY INTO ' + Tablename+
                          ' (typeno, DueTime,CompanyLabel,Type, ID, Created, Due, Notes,Description, ClientID, Client, `In Days`, ProjectLineID, EmployeeID)'+
                          ' SELECT  20, null, "Client Details" , ItemType as Type, PurchaseOrderID as ID, OrderDate as Created, NULL as Due,'+
                          ' concat_ws(" ","Approve ",t.ApprovalType," for payment") as Description,'+
                          ' "" , ClientID, Company as Client, "" as "In Days", 0 as ProjectLineID,0 '+
                          ApprovalReminders.GetSQLFromFromOnward(AppEnv.Employee.EmployeeID)+';');
        end;
        // ======== Messages =======
{------}   Script.SQL.Add('INSERT HIGH_PRIORITY INTO ' + Tablename+
                          ' (typeno, status, DueTime,CompanyLabel,Type, ID, Created, Due, Notes,ClientID, Client, `In Days`, ProjectLineID, EmployeeID)'+
                          ' SELECT'+
                          ' 21,if(M.Done = "T","Done","Not done") as Status , null,'+
                          ' "Client Details" ,'+
                          ' "Message" as Type,'+
                          ' M.MessagesID,'+
                          ' ML.DateAndTime as Created,'+
                          ' 0,'+
                          ' Concat(CONCAT_WS(" ","Details:",ML.Details) ,'+
                          ' if(ML.MessageType = "T", "Telephoned" , "Called-In") ," on " , ML.DateAndTime , "." ,'+
                          ' if(ML.Actiontype = "R", "Please Ring " , "Will Ring Back ") ,'+
                          ' if(ifnull(ML.ResponsedueOn,0) = 0 , "" , concat("On " ,ML.ResponsedueOn)),'+
                          ' if(ifnull(ML.ResponsedueTimeFrom,0) = 0 , "" , concat(" Between  " ,ML.ResponsedueTimeFrom)),'+
                          ' if(ifnull(ML.ResponsedueTimeTo,0) = 0 , "" , concat(" and " ,ML.ResponsedueTimeTo))'+
                          ' ) as Notes,'+
                          ' FromId as ClientID,'+
                          ' M.Company as Client,'+
                          ' "" as "In Days",'+
                          ' 0,'+
                          ' ML.employeeId'+
                          ' FROM tblMessages M inner join tblmessagelines ML on M.MessagesID = ML.MessagesID'+
                          ' WHERE ifnull(ML.Done,"F") = "F"'+
                          EmployeeFilter('ML.EmployeeID ')+ ' ;');

        // ======== Count of Sales where Payment is overdue and needs to apply surcharges =======
        if showAllREmidners or AppEnv.Employee.ShowOverduesalesReminders then begin
{------}   Script.SQL.Add('INSERT HIGH_PRIORITY INTO ' + Tablename+
                          ' (typeno, DueTime,CompanyLabel,Type, ID, Created, Due, Notes,Description, ClientID, Client, `In Days`, ProjectLineID, EmployeeID)'+
                          ' SELECT  22, CurDate(), "" , "Sales Overdue" as Type, 0 as ID, curdate() as Created, NULL as Due,'+
                          ' concat(OverdueSales.ctr, " Sales Overdue") as Description,'+
                          ' "" , 0, "" as Client, "" as "In Days", 0 as ProjectLineID,  '+inttostr(Appenv.Employee.employeeID) +
                          ' From (Select count(S.SaleID) as ctr From tblsales s '+
                          ' Left JOIN (tblsaleslines SL '+
                          ' INNER JOIN tblparts P on p.partsid = SL.productId and P.partname = '+ Quotedstr(PART_OVERDUE_SURCH) +') on S.saleId = SL.SaleId '+
                          ' where s.IsInvoice ="T" and ifnull(balance,0) <> 0 and (ifnull(Payment,0)=0 or ifnull(SL.salelineId,0)=0) and '+
                          ' ((S.duedate between "'+ FormatDateTime(MysqlDateFormat,(IncMonth(Date,-1)))+ '" and "'+FormatDateTime(MysqlDateFormat,(Date))+'" and '+ Floattostr(Appenv.CompanyPrefs.SurchargePercent1) +'<>0 )   or '+
                          '  (S.duedate between "'+ FormatDateTime(MysqlDateFormat,(IncMonth(Date,-2)))+ '" and "'+FormatDateTime(MysqlDateFormat,(IncMonth(Date,-1)))+'" and '+ Floattostr(Appenv.CompanyPrefs.SurchargePercent2) +'<>0)    or '+
                          '  (S.duedate between "'+ FormatDateTime(MysqlDateFormat,(IncMonth(Date,-3)))+ '" and "'+FormatDateTime(MysqlDateFormat,(IncMonth(Date,-2)))+'" and '+ Floattostr(Appenv.CompanyPrefs.SurchargePercent3) +'<>0) or '+
                          '  (S.duedate <       "'+ FormatDateTime(MysqlDateFormat,(IncMonth(Date,-3)))+ '" and '+ Floattostr(Appenv.CompanyPrefs.SurchargePercent4) +'<>0)) ) OverdueSales Where ctr>0;');
        end;

        if showAllREmidners or AppEnv.Employee.ShowFinishedProgressBuildReminder then begin
{------}   Script.SQL.Add('INSERT HIGH_PRIORITY INTO ' + Tablename+
                          ' (typeno, Status, DueTime,CompanyLabel,Type, ID, Created, Due, Notes,Description, ClientID, Client, `In Days`, ProjectLineID, EmployeeID)'+
                          ' Select  23 ,S.QuoteStatus as Status,S.DueDate,"Client Details" , "Finished Progress Build" AS Type, S.SaleID AS ID, S.SaleDate AS Created,'+
                          ' S.DueDate AS Due, '+
                          ' S.Memo ,'+
                          ' "" as Description,'+
                          '  S.ClientID AS ClientID, S.CustomerName AS Client , 0 ,0, S.EmployeeId'+
                          ' from'+
                          ' tblsales S'+
                          ' inner join tblsaleslines SL on s.saleId = Sl.saleId AND SL.Invoiced = "T"'+
                          ' inner join tblproctree pt on pt.masterId = sl.saleLineId and pt.masterType <> "mtProduct" and ifnull(ParentId,0) = 0 and ifnull(totalQty,0) -ifnull(Manufacturedqty,0) =0'+
                          ' Where S.IsSalesOrder ="T" and  S.converted ="F" and ifnull(SL.UnitofMeasureShipped ,0)>0;');
//                          EmployeeFilter('S.EmployeeID'));
        end;
        { Received Back Orders }
        if showAllREmidners or (AppEnv.Employee.ReceivedBOAppearDays > 0 )  then begin
{------}   Script.SQL.Add('INSERT HIGH_PRIORITY INTO ' + Tablename+
                          ' (typeno, Type, ID, Created, Due, Description, ClientID, Client, `In Days`, EmployeeID)'+
                          ' SELECT 24,'+
                          ' "Received Back Orders" as type,'+
                          ' SL.SaleID,'+
                          ' PO.orderdate as Created,'+
                          ' ifnull(POL.ETADate, PO.ETADate) as Due,'+
                          ' concat(POL. UnitofMeasureShipped  , " " ,  POL.UnitofMeasurePOLines , "(" , POL.UnitofMeasureMultiplier , ")  of " ,POL.Productname  ) as Description,'+
                          ' PO.clientID,'+
                          ' PO.SupplierName,'+
                          InDays('POL.ReceivedDate')+'  AS "In Days",' +
                          ' PO.EmployeeID'+
                          ' FROM tblpurchaseOrders PO inner join tblPurchaseLines POL on PO.purchaseorderId = POL.purchaseOrderID'+
                          ' inner join tblsaleslines SL on SL.SaleLineID = POL.SaleLineID and SL.QtySold <> 0 and SL.BackOrder <> 0'+
                          ' WHERE ifnull(POL.Shipped,0)>0 and ifnull(POL.Backorder,0)= 0 and ifNull(POL.CustomerJobID,0) > 0'+
                          EmployeeFilter('PO.EmployeeId')+
                          '  AND ' +Datefilter('POL.ReceivedDate' , AppEnv.Employee.GoodToReceiveReminderDays)+ ' ;');
        end;
        { Support }
{------}   Script.SQL.Add('INSERT HIGH_PRIORITY INTO ' + Tablename+
                          ' (typeno, Type, SupportType, ID, Created, Description, Notes, CompanyLabel, ClientID, Client, EmployeeId, `In Days` , DueTime)'+
                          ' select 25 as typeno,'+
                          ' "Support" as type,'+
                          ' SL.Type as SupportType,'+
                          ' SL.SupportLogId as ID,'+
                          ' Date(SL.DateCreated) as Created,'+
                          ' SL.Issue as Description,'+
                          ' SL.Solution as Notes,'+
                          ' SL.Company as CompanyLabel,'+
                          ' SL.ClientId as ClientId,'+
                          ' SL.Contact as Client,'+
                          ' SL.ToEmployeeID,'+
                          InDays('SL.DateCreated')+'  AS "In Days",' +
                          ' NOW() as Duetime'+
                          ' from tblPhoneSupportLog SL'+
                          ' where Finished <> "T"'+
                          EmployeeFilter('SL.ToEmployeeID')+ ' ;');
       { Reorder }
         if (EmployeeID > 0) and TPersonalPreferences.PropAsBool(EmployeeID, 'ShowReorder') then begin

{------}   Script.SQL.Add('INSERT HIGH_PRIORITY INTO ' + Tablename+
                          ' (typeno, Type, ID, Description, Created, EmployeeId)'+
                          'select 26 as typeno,'+
                          '"Reorder" as Type,'+
                          'RP.ProductId as ID,'+
                          'RP.Description as Description, '+
                          '"' + FormatDateTime(MySqlDateTimeFormat, Date) + '",' +
                          IntToStr(Appenv.Employee.EmployeeID) +
                          ' from(');
           Script.SQL.Add(' select T.ProductId, T.ProductName, T.DepartmentId, T.Department, T.InStock, T.Available,R.ReorderPoint,'+
                          ' concat("Product ",T.ProductName," for Dept ", T.Department,": Available ", Round(T.Available,2)," - time to reorder") as Description '+
                          ' from(select PQA.ProductId, P.PartName as ProductName, PQA.DepartmentId, C.ClassName as Department,'+
                          ' Round(IF(P.PartType = "INV",Round(Sum( if(PQA.TransType ="TSalesOrderInvoiceLines"  and PQA.Active ="F" , 0,'+
                          ' if(PQA.TransType ="TSalesOrderInvoiceLines"  and PQA.Active ="T" , ifnull(PQA.QTY,0),'+
                          ' if(PQA.Active ="F" and not (PQA.TransType in ("TPRocProgressIN","TPRocProgressOUT")) , 0,'+
                          ' if(PQA.TransType ="TSalesOrderLine" or ifnull(PQA.IsBO , "F") ="T",0,'+
                          ' if(PQA.TransType ="TPOSLaybyLines" and PQA.Reserved = "T" ,0 ,'+
                          ' if(PQA.TransType in ("TStockMovementLines")  and PQA.Active ="T"  and PQA.alloctype ="IN" , ifnull(PQA.QTY,0) ,'+
                          ' if(PQA.TransType in ("TStockMovementLines")  and PQA.Active ="T"  and PQA.alloctype ="OUT" , 0-ifnull(PQA.QTY,0) ,'+
                          ' if(PQA.TransType in ("THireLines")    and PQA.alloctype  ="OUT" and PQA.Active ="T" , 0-ifnull(PQA.QTY,0),'+
                          ' if(PQA.TransType in ("THireLinesIN")    and PQA.alloctype  ="IN" and PQA.Active ="T" , ifnull(PQA.QTY,0) ,'+
                          ' if(PQA.alloctype ="IN"  , ifnull(PQA.QTY,0), 0-ifnull(PQA.QTY,0)))))))))))),5),0.0),5)  as "InStock",'+
                          ' Round(IF(P.PartType = "INV",Round(Sum( if(PQA.TransType ="TSalesOrderInvoiceLines"  and PQA.Active ="F" , 0,'+
                          ' if(PQA.TransType ="TSalesOrderInvoiceLines"  and PQA.Active ="T" , ifnull(PQA.QTY,0),'+
                          ' if(PQA.Active ="F" and  PQA.alloctype  ="IN" and PQA.TransType in ("TProcProgressIn"), ifnull(PQA.QTY,0),'+
                          ' if(PQA.Active ="F" and  PQA.alloctype  ="IN" and PQA.TransType in ("TProcTreePart","TProcTreePartIN"), ifnull(PQA.QTY,0),'+
                          ' if((PQA.Active ="F") and  (not(PQA.TransType in ("TProcTreePart","TProcTreePartIN")) '+
                          ' OR ((PQA.TransType="TProcTreePart") and (PQA.alloctype  ="IN")) ), 0,'+
                          ' if(PQA.TransType  in ("TStockMovementLines")  and PQA.Active ="T"  and PQA.alloctype ="IN" , ifnull(PQA.QTY,0) ,'+
                          ' if(PQA.TransType  in ("TStockMovementLines")  and PQA.Active ="T"  and PQA.alloctype ="OUT" , 0-ifnull(PQA.QTY,0) ,'+
                          ' if(PQA.TransType  in ("THireLines")    and PQA.alloctype  ="OUT" and PQA.Active ="T" , 0-ifnull(PQA.QTY,0) ,'+
                          ' if(PQA.TransType  in ("THireLinesIN")    and PQA.alloctype  ="IN" and PQA.Active ="T" , ifnull(PQA.QTY,0) , '+
                          ' if( PQA.alloctype ="IN" and  ifnull(PQA.IsBO , "F")="F", ifnull(PQA.QTY,0),  '+
                          ' if(PQA.alloctype ="OUT" and (PQA.TransType<>"TSalesOrderLine" or ifnull(PQA.IsBO , "F")="F") ,0-ifnull(PQA.QTY,0),0)))))))))))),5),0.0) - Sum(if(PQA.Active ="F" , 0, '+
                          ' if(PQA.TransType="TSalesOrderLine" and ifnull(PQA.IsBO , "F") ="T",ifnull(PQA.QTY,0),0))),5)  as "Available"'+
                          ' from tblpqa pqa '+
                          ' inner join tblparts p on p.partsid=pqa.productid '+
                          ' left join tblClass C on C.ClassId=PQA.DepartmentId '+
                          ' group by pqa.departmentid, pqa.productid) T '+
                          ' left join tblReorderPoints R on R.ProductId=T.ProductId and R.ClassId = T.DepartmentId '+
                          ' where R.OrderMonth="' + FormatSettings.ShortMonthNames[MonthOf(Now)] + '" '+
                          ' and R.ReorderPoint > T.InStock) RP;');
         end;
        { Support Log Lines }
         if {(EmployeeID > 0) and} (AppEnv.Employee.SupportLogLinesAppearDays > 0) then begin
{------}   Script.SQL.Add('INSERT HIGH_PRIORITY INTO ' + Tablename+
                          ' (typeno, Type, SupportType, ID, Created, Description, Notes, CompanyLabel, ClientID, Client, EmployeeId, `In Days` , DueTime,ProjectLineID)'+
                          ' select 27 as typeno,'+
                          ' "Support-Comments" as type,'+
                          ' "Follow-Up" as SupportType,'+
                          ' SL.SupportLogId as ID,'+
                          ' Date(SLL.Date) as Created,'+
                          //' SL.Issue as Description,'+
                          ' SLL.Comments as Description,'+
                          //' SL.Solution as Notes,'+
                          ' null as Notes,'+
                          ' SL.Company as CompanyLabel,'+
                          ' SL.ClientId as ClientId,'+
                          ' SL.Contact as Client,'+
                          //' SL.ToEmployeeID,'+
                          ' SLL.AssignToID,'+
                          InDays('SLL.Date')+'  AS "In Days",' +
                          ' NOW() as Duetime ,SLL.ID as ProjectLineID '+
                          ' from tblPhoneSupportLog SL'+
                          ' inner join tblPhoneSupportLogLines SLL on SLL.SupportID = SL.SupportLogID'+
                          //' where Finished <> "T"'+
                          ' where SLL.Deleted <> "T"'+
                          EmployeeFilter('SLL.AssignToID')+ ' ;');
         end;
        if (showAllREmidners or (AppEnv.Employee.ERPLicenseRenewalAppearDays > 0 ))
            and (TableExists('Services.tclientconfig'))
            and (TableExists('Services.tcomputer'))
            and (TableExists('Services.tsoftwarelicence')) then begin
{------}   Script.SQL.Add('INSERT HIGH_PRIORITY INTO ' + Tablename+
                          ' (typeno, Type, ID, Created, Due, Description, ClientID, Client, `In Days`, EmployeeID)'+
                          ' select 27 as typeno,' +
                          ' "ERP License Expire" as Type, '+
                          ' tsoftwarelicence.id as ID,'+
                          ' tsoftwarelicence.startdate as Created,'+
                          ' tsoftwarelicence.expiredate as Due,'+
                          ' concat_ws(",",tcomputer.computername ,  tsoftwarelicence.status  , tsoftwarelicence.notes) as Description,' +
                          ' tclientconfig.id as ClientId,'+
                          ' tclientconfig.Name as ClientName,'+
                          InDays('tsoftwarelicence.expiredate')+'  AS "In Days",' +
                          inttostr(AppEnv.Employee.EmployeeID)+ '  as EmployeeID' +
                          ' from Services.tclientconfig' +
                          ' inner join  Services.tcomputer on tclientconfig.id = tcomputer.clientid' +
                          ' inner join Services.tsoftwarelicence on tcomputer.id = tsoftwarelicence.computerid' +
                          '  AND ' +Datefilter('tsoftwarelicence.expiredate' , AppEnv.Employee.ERPLicenseRenewalAppearDays)+
                          ' where Services.tclientconfig.active ="T";');
        end;

        DoShowProgressbar(3, WaitMSG);
        try
          DoStepProgressbar;
          Script.Execute;
          DoStepProgressbar;
        Finally
          DoHideProgressbar;
        end;
      finally
        FreeAndNil(ApprovalReminders);
      end;
    Finally

      Freeandnil(Script);
    end;
end;
end.




