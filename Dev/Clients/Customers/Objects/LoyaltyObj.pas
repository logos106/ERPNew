unit LoyaltyObj;

interface

uses
  DB, Classes, MyAccess,ERPdbComponents;


type
  TLoyalty = class(TObject)
  private
    dtMasterStartDate: TDateTime;
    sUserMailMergeTempName: string;
    procedure RecordClient(iClientID: integer);
    procedure CreateTempMailMergeTable;
    procedure CreateMergeFile;
    procedure FlagClient(const iClientID: integer; const sFieldName: string);
  public
    bAnyFound: boolean;
    constructor Create; virtual;
    destructor Destroy; override;
    procedure RecordSaleDaysClients;
    procedure RecordAppointDaysClients;
    procedure RecordAppointDaysContacts;
    procedure RecordAmountClients;
    procedure SetReminderDate;
  end;


implementation

uses
   CommonDbLib, DateUtils, SysUtils, AppEnvironment,
  FastFuncs, CommonLib;

resourcestring
  SqlSelect = 'SELECT Company, Title AS Title, FirstName AS First_Name, ' +
    'LastName AS Last_Name, Street AS Address, Street2 AS Stree2, ' + 'Suburb, State, Postcode, BillStreet AS Bill_Address, ' +
    'BillStreet2 AS Bill_Street_2, ' + 'BillSuburb AS Bill_Suburb, BillState AS Bill_State, BillPostcode AS Bill_Postcode, ' +
    'Phone, AltPhone AS Alt_Phone, Mobile, FaxNumber AS Fax, Email, ' +
    'PhoneSupportTill AS Phone_Support_Till, Contact1 AS Contact_1, ' +
    'Contact2 AS Contact_2, Contact1Phone AS Contact_1_Phone, Contact2Phone AS Contact_2_Phone,  ' +
    '"", "", "", "", "","", "", "", "", "","", "", "", "", "", ' + 'CreationDate AS Creation_Date, ' +
    'UpdateDate AS Update_Date, ClientNo AS Account_No, ABN, Feedback, Discount, SpecialDiscount AS Special_Discount, ' +
    'JobName AS Job_Name, IsJob AS Is_Job,RepName, Customer, Supplier, OtherContact, ' + 'Active';


  SqlColumnList = '(Company, Title, First_Name, Last_Name, Address, Stree2, Suburb, State, Postcode, ' +
    'Bill_Address, Bill_Street_2, Bill_Suburb, Bill_State, Bill_Postcode, Phone, Alt_Phone, ' +
    'Mobile, Fax, Email, Phone_Support_Till, Contact_1, Contact_2, Contact_1_Phone, ' + 'Contact_2_Phone, ' +
    'CFLabel1, CFLabel2, CFLabel3, CFLabel4, CFLabel5, ' + 'CFLabel6, CFLabel7, CFLabel8, CFLabel9, CFLabel10, ' +
    'CFLabel11, CFLabel12, CFLabel13, CFLabel14, CFLabel15, ' +
    'Creation_Date, Update_Date, Account_No, ABN, FeedBack, Discount, Special_Discount, ' +
    'Job_Name, Is_Job, RepName, Customer, Supplier, OtherContact, Active)';

  { TLoyalty }

constructor TLoyalty.Create;
begin
  inherited;
  bAnyFound := false;
  sUserMailMergeTempName := 'tmp_MailMerge_' + GetMachineIdentification(true, true, true, true);
  dtMasterStartDate := AppEnv.CompanyPrefs.LoyaltyStartDate;
  CreateTempMailMergeTable;
end;

procedure TLoyalty.CreateTempMailMergeTable;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try

    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('DROP TABLE IF EXISTS ' + sUserMailMergeTempName + ' ');
    qryTemp.Execute;

    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('CREATE TABLE ' + sUserMailMergeTempName + ' ( ');
    qryTemp.Sql.Add('`MailMergeID` int(10) NOT NULL auto_increment, ');
    qryTemp.Sql.Add('`Company` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`Title` varchar(10) default NULL, ');
    qryTemp.Sql.Add('`First_Name` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`Last_Name` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`Address` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`Stree2` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`Suburb` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`State` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`Postcode` varchar(4) default NULL, ');
    qryTemp.Sql.Add('`Bill_Address` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`Bill_Street_2` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`Bill_Suburb` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`Bill_State` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`Bill_Postcode` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`Phone` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`Alt_Phone` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`Mobile` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`Fax` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`Email` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`Phone_Support_Till` date default NULL, ');
    qryTemp.Sql.Add('`Contact_1` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`Contact_2` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`Contact_1_Phone` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`Contact_2_Phone` varchar(255) default NULL, ');

    qryTemp.Sql.Add('`CFLabel1` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`CFLabel2` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`CFLabel3` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`CFLabel4` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`CFLabel5` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`CFLabel6` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`CFLabel7` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`CFLabel8` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`CFLabel9` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`CFLabel10` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`CFLabel11` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`CFLabel12` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`CFLabel13` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`CFLabel14` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`CFLabel15` varchar(255) default NULL, ');

    qryTemp.Sql.Add('`Creation_Date` date default NULL, ');
    qryTemp.Sql.Add('`Update_Date` date default NULL, ');
    qryTemp.Sql.Add('`Account_No` varchar(255) default NULL,  ');
    qryTemp.Sql.Add('`ABN` varchar(15) default NULL, ');
    qryTemp.Sql.Add('`FeedBack` enum("T","F") default "F", ');
    qryTemp.Sql.Add('`Discount` Double(15,5) default NULL, ');
    qryTemp.Sql.Add('`Special_Discount` Double(15,5) default NULL, ');
    qryTemp.Sql.Add('`Job_Name` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`RepName` varchar(255) default NULL, ');
    qryTemp.Sql.Add('`Is_Job` enum("T","F") default "F", ');
    qryTemp.Sql.Add('`Customer` enum("T","F") default "F", ');
    qryTemp.Sql.Add('`Supplier` enum("T","F") default "F", ');
    qryTemp.Sql.Add('`OtherContact` enum("T","F") default "F", ');
    qryTemp.Sql.Add('`Active` enum("T","F") default "T", ');
    qryTemp.Sql.Add('`Filler` varchar(20) default NULL, ');
    qryTemp.Sql.Add('PRIMARY KEY  (`MailMergeID`) ');
    qryTemp.Sql.Add(') ENGINE=InnoDB; ');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;



destructor TLoyalty.Destroy;
begin
  inherited;
end;

procedure TLoyalty.FlagClient(const iClientID: integer; const sFieldName: string);
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('UPDATE tblClients SET ' + sFieldName + ' = :xDate ' +
      'WHERE ClientID = :xClientID');
    qry.ParamByName('xClientID').AsInteger := iClientID;
    qry.ParamByName('xDate').asDate     := Date;
    qry.Execute;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TLoyalty.RecordSaleDaysClients;
var
  qry: TERPQuery;
  qryClient: TERPQuery;
  qrySales: TERPQuery;
  dtLastRecorded, dtLastSale, dtThreshold: TDateTime;
begin
  qry := TERPQuery.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryClient := TERPQuery.Create(nil);
  qryClient.Connection := CommonDbLib.GetSharedMyDacConnection;
  qrySales := TERPQuery.Create(nil);
  qrySales.Connection := CommonDbLib.GetSharedMyDacConnection;

  dtThreshold := IncDay(Date(), - AppEnv.CompanyPrefs.LastSaleDays);

  try
    with qryClient do begin
      SQL.Clear;
      Sql.Add('SELECT ClientID, LoyaltyDateSaleDays');
      Sql.Add('FROM tblclients');
      Sql.Add('WHERE Customer="T" AND DontContact="F"');
      Open;
    end;

    qryClient.First;
    while not qryClient.Eof do begin
      if Empty(qryClient.FieldByName('LoyaltyDateSaleDays').AsString) then begin
        dtLastRecorded := AppEnv.CompanyPrefs.LoyaltyStartDate;
      end else begin
        if qryClient.FieldByName('LoyaltyDateSaleDays').AsDateTime < AppEnv.CompanyPrefs.LoyaltyStartDate then begin
          dtLastRecorded := AppEnv.CompanyPrefs.LoyaltyStartDate;
        end else begin
          dtLastRecorded := qryClient.FieldByName('LoyaltyDateSaleDays').AsDateTime;
        end;
      end;

      qrySales.Sql.Clear;
      qrySales.Sql.Add('SELECT SaleID, MAX(SaleDate) as LastSaleDate FROM tblSales');
      qrySales.Sql.Add('WHERE ClientID = :xClientID');
      qrySales.Sql.Add('GROUP BY ClientID');
      with qrySales do begin
        ParamByName('xClientID').AsInteger := qryClient.FieldByName('ClientID').AsInteger;
      end;
      qrySales.Open;
      if qrySales.RecordCount > 0 then begin
        dtLastSale := qrySales.FieldByName('LastSaleDate').AsDateTime;
      end else begin
        dtLastSale := 0;
      end;

      if (dtLastSale < dtThreshold) and
        (dtLastRecorded < dtThreshold) then begin
        RecordClient(qryClient.FieldByName('ClientID').AsInteger);
        FlagClient(qryClient.FieldByName('ClientID').AsInteger, 'LoyaltyDateSaleDays');
      end;
      qryClient.Next;
    end;
    CreateMergeFile;
  finally
    FreeAndNil(qry);
    FreeandNil(qryClient);
    FreeandNil(qrySales);
  end;
end;

procedure TLoyalty.RecordClient(iClientID: integer);
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qry.SQL.Clear;
    qry.Sql.Add('INSERT HIGH_PRIORITY INTO ' + sUserMailMergeTempName);
    qry.Sql.Add(SqlColumnList);
    qry.Sql.Add(SqlSelect);
    qry.Sql.Add('FROM tblclients WHERE ClientID = :xClientID');
    with qry do begin
      ParamByName('xClientID').AsInteger := iClientID;
    end;
    qry.Execute;
    bAnyFound := true;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TLoyalty.RecordAppointDaysClients;
var
  qry: TERPQuery;
  qryClient: TERPQuery;
  qryAppoints: TERPQuery;
  dtLastRecorded, dtLastAppoint, dtThreshold: TDateTime;
begin
  qry := TERPQuery.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryClient := TERPQuery.Create(nil);
  qryClient.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryAppoints := TERPQuery.Create(nil);
  qryAppoints.Connection := CommonDbLib.GetSharedMyDacConnection;

  dtThreshold := IncDay(Date(), - AppEnv.CompanyPrefs.LastAppointDays);

  try
    with qryClient do begin
      SQL.Clear;
      Sql.Add('SELECT ClientID, LoyaltyDateAppointDays');
      Sql.Add('FROM tblclients');
      Sql.Add('WHERE Customer="T" AND DontContact="F"');
      Open;
    end;

    qryClient.First;
    while not qryClient.Eof do begin
      if Empty(qryClient.FieldByName('LoyaltyDateAppointDays').AsString) then begin
        dtLastRecorded := AppEnv.CompanyPrefs.LoyaltyStartDate;
      end else begin
        if qryClient.FieldByName('LoyaltyDateAppointDays').AsDateTime < AppEnv.CompanyPrefs.LoyaltyStartDate then begin
          dtLastRecorded := AppEnv.CompanyPrefs.LoyaltyStartDate;
        end else begin
          dtLastRecorded := qryClient.FieldByName('LoyaltyDateAppointDays').AsDateTime;
        end;
      end;

      qryAppoints.Sql.Clear;
      qryAppoints.Sql.Add('SELECT AppointID, MAX(AppDate) as LastAppointDate FROM tblappointments');
      qryAppoints.Sql.Add('WHERE CusID = :xCusID');
      qryAppoints.Sql.Add('GROUP BY CusID');
      with qryAppoints do begin
        ParamByName('xCusID').AsInteger := qryClient.FieldByName('ClientID').AsInteger;
      end;
      qryAppoints.Open;
      if qryAppoints.RecordCount > 0 then begin
        dtLastAppoint := qryAppoints.FieldByName('LastAppointDate').AsDateTime;
      end else begin
        dtLastAppoint := 0;
      end;

      if (dtLastAppoint < dtThreshold) and
        (dtLastRecorded < dtThreshold) then begin
        RecordClient(qryClient.FieldByName('ClientID').AsInteger);
        FlagClient(qryClient.FieldByName('ClientID').AsInteger, 'LoyaltyDateAppointDays');
      end;
      qryClient.Next;
    end;
    CreateMergeFile;
  finally
    FreeAndNil(qry);
    FreeandNil(qryClient);
    FreeandNil(qryAppoints);
  end;
end;

procedure TLoyalty.RecordAppointDaysContacts;
var
  qry: TERPQuery;
  qryClient: TERPQuery;
  qryAppoints: TERPQuery;
  dtLastRecorded, dtLastAppoint, dtThreshold: TDateTime;
begin
  qry := TERPQuery.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryClient := TERPQuery.Create(nil);
  qryClient.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryAppoints := TERPQuery.Create(nil);
  qryAppoints.Connection := CommonDbLib.GetSharedMyDacConnection;

  dtThreshold := IncDay(Date(), - AppEnv.CompanyPrefs.LastContactDays);

  try
    with qryClient do begin
      SQL.Clear;
      Sql.Add('SELECT ClientID, LoyaltyDateAppointDays');
      Sql.Add('FROM tblclients');
      Sql.Add('WHERE OtherContact="T" AND DontContact="F"');
      Open;
    end;

    qryClient.First;
    while not qryClient.Eof do begin
      if Empty(qryClient.FieldByName('LoyaltyDateAppointDays').AsString) then begin
        dtLastRecorded := AppEnv.CompanyPrefs.LoyaltyStartDate;
      end else begin
        if qryClient.FieldByName('LoyaltyDateAppointDays').AsDateTime < AppEnv.CompanyPrefs.LoyaltyStartDate then begin
          dtLastRecorded := AppEnv.CompanyPrefs.LoyaltyStartDate;
        end else begin
          dtLastRecorded := qryClient.FieldByName('LoyaltyDateAppointDays').AsDateTime;
        end;
      end;

      qryAppoints.Sql.Clear;
      qryAppoints.Sql.Add('SELECT AppointID, MAX(AppDate) as LastAppointDate FROM tblappointments');
      qryAppoints.Sql.Add('WHERE CusID = :xCusID');
      qryAppoints.Sql.Add('GROUP BY CusID');
      with qryAppoints do begin
        ParamByName('xCusID').AsInteger := qryClient.FieldByName('ClientID').AsInteger;
      end;
      qryAppoints.Open;
      if qryAppoints.RecordCount > 0 then begin
        dtLastAppoint := qryAppoints.FieldByName('LastAppointDate').AsDateTime;
      end else begin
        dtLastAppoint := 0;
      end;

      if (dtLastAppoint < dtThreshold) and
        (dtLastRecorded < dtThreshold) then begin
        RecordClient(qryClient.FieldByName('ClientID').AsInteger);
        FlagClient(qryClient.FieldByName('ClientID').AsInteger, 'LoyaltyDateAppointDays');
      end;
      qryClient.Next;
    end;
    CreateMergeFile;
  finally
    FreeAndNil(qry);
    FreeandNil(qryClient);
    FreeandNil(qryAppoints);
  end;
end;

procedure TLoyalty.RecordAmountClients;
var
  qry: TERPQuery;
  qryClient: TERPQuery;
  qrySales: TERPQuery;
  dTotAmount: double;
  dtLastRecorded: TDateTime;
begin
  qry := TERPQuery.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryClient := TERPQuery.Create(nil);
  qryClient.Connection := CommonDbLib.GetSharedMyDacConnection;
  qrySales := TERPQuery.Create(nil);
  qrySales.Connection := CommonDbLib.GetSharedMyDacConnection;

  //dtThreshold := IncDay(Date(), -AppEnv.CompanyPrefs.LastSaleDays);

  try
    with qryClient do begin
      SQL.Clear;
      Sql.Add('SELECT ClientID, LoyaltyDateAmount');
      Sql.Add('FROM tblclients');
      Sql.Add('WHERE Customer="T" AND DontContact="F"');
      Open;
    end;

    qryClient.First;
    while not qryClient.Eof do begin
      if Empty(qryClient.FieldByName('LoyaltyDateAmount').AsString) then begin
        dtLastRecorded := AppEnv.CompanyPrefs.LoyaltyStartDate;
      end else begin
        if qryClient.FieldByName('LoyaltyDateAmount').AsDateTime < AppEnv.CompanyPrefs.LoyaltyStartDate then begin
          dtLastRecorded := AppEnv.CompanyPrefs.LoyaltyStartDate;
        end else begin
          dtLastRecorded := qryClient.FieldByName('LoyaltyDateAmount').AsDateTime;
        end;
      end;

      qrySales.Sql.Clear;
      qrySales.Sql.Add('SELECT SaleID, SUM(TotalAmountInc) as SumAmount FROM tblSales');
      qrySales.Sql.Add('WHERE ClientID = :xClientID AND SaleDate > :xSaleDate');
      qrySales.Sql.Add('GROUP BY ClientID');
      with qrySales do begin
        ParamByName('xClientID').AsInteger := qryClient.FieldByName('ClientID').AsInteger;
        ParamByName('xSaleDate').asDate := dtLastRecorded;
      end;

      qrySales.Open;
      if qrySales.RecordCount > 0 then begin
        dTotAmount := qrySales.FieldByName('SumAmount').AsFloat;
      end else begin
        dTotAmount := 0;
      end;

      if (dTotAmount > AppEnv.CompanyPrefs.SalesValue) then begin
        RecordClient(qryClient.FieldByName('ClientID').AsInteger);
        FlagClient(qryClient.FieldByName('ClientID').AsInteger, 'LoyaltyDateAmount');
      end;

      qryClient.Next;
    end;
    CreateMergeFile;
  finally
    FreeAndNil(qry);
    FreeandNil(qryClient);
    FreeandNil(qrySales);
  end;
end;

procedure TLoyalty.CreateMergeFile;
  // not actually used for any purpose at this stage
var
  qry: TERPQuery;
  sText: string;
  lstMerge: TStringList;
  j: integer;
begin
  lstMerge := TStringList.Create;
  qry := TERPQuery.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    lstMerge.Clear;

    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM ' + sUserMailMergeTempName + ';');
    qry.Open;
    qry.First;

    // create heading
    sText := '';
    for j := 0 to qry.FieldCount - 2 do begin
      sText := sText + '"' + qry.Fields[j].FieldName + '",';
    end;
    sText := sText + '"' + qry.Fields[qry.FieldCount - 1].FieldName + '"' + #13;
    lstMerge.Add(sText);

    // now a line for each record
    qry.First;
    while not qry.Eof do begin
      sText := '';
      for j := 0 to qry.FieldCount - 2 do begin
        sText := sText + '"' + Trim(qry.Fields[j].AsString) + '",';
(*
        // Add field to Email temp table incase we are emailing (is EmailMergeFlag set to 1 ?)
        if not(tblWordMerge.Fields[j].isnull) then begin
          qrytmpMailMerge.FieldbyName(tblWordMerge.Fields[j].FieldName).AsVariant :=
                                           Trim(tblWordMerge.Fields[j].AsVariant);
        end
*)
      end;
      sText := sText + '"' + Trim(qry.Fields[qry.FieldCount - 1].AsString) + '"' + #13;
      lstMerge.Add(sText);
      qry.Next;
    end;
//    lstMerge.SaveToFile('C:\ERP\tblAWordMerge.txt');  { Save the list }
  finally
    FreeandNil(lstMerge);
    FreeAndNil(qry);
  end;
end;

procedure TLoyalty.SetReminderDate;
var
  dtNext: TDateTime;
begin
  dtNext := AppEnv.CompanyPrefs.LoyaltyReminderDate;
  if AppEnv.CompanyPrefs.LoyaltyReminderRepeatDays <> 0 then begin
    while dtNext < IncDay(Date(), AppEnv.CompanyPrefs.LoyaltyReminderRepeatDays) do begin
      dtNext := IncDay(dtNext, AppEnv.CompanyPrefs.LoyaltyReminderRepeatDays);
    end;
  end else begin
    dtNext := IncDay(Date());
  end;

  AppEnv.CompanyPrefs.LoyaltyReminderDate := dtNext;

end;

end.





