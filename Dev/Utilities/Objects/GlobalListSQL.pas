unit GlobalListSQL;

interface

uses
  classes, ReportBaseObj, Types, ErpDBComponents, ReportSQLBalanceSheet,
    UserLockObj;

type

  TGlobalListReport = class(TReportBase)
  private
    FMarketing: boolean;
    FEmployee: boolean;
    FCustomerContact: boolean;
    FJobContact: boolean;
    FCustomer: boolean;
    FJob: boolean;
    FSupplierContact: boolean;
    FSupplier: boolean;
    fActive: boolean;
    FMarketingContact: boolean;
    procedure SetCustomer(const Value: boolean);
    procedure SetCustomerContact(const Value: boolean);
    procedure SetEmployee(const Value: boolean);
    procedure SetJob(const Value: boolean);
    procedure SetJobContact(const Value: boolean);
    procedure SetMarketing(const Value: boolean);
    procedure SetMarketingContact(const Value: boolean);
    procedure SetSupplier(const Value: boolean);
    procedure SetSupplierContact(const Value: boolean);
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
  published
    property Active: boolean read fActive write fActive;
    property Job: boolean read FJob write SetJob;
    property JobContact: boolean read FJobContact write SetJobContact;
    property Customer: boolean read FCustomer write SetCustomer;
    property CustomerContact: boolean read FCustomerContact write SetCustomerContact;
    property Supplier: boolean read FSupplier write SetSupplier;
    property SupplierContact: boolean read FSupplierContact write SetSupplierContact;
    property Marketing: boolean read FMarketing write SetMarketing;
    property MarketingContact: boolean read FMarketingContact write SetMarketingContact;
    property Employee: boolean read FEmployee write SetEmployee;
  end;


implementation

{ TGlobalListReport }

constructor TGlobalListReport.Create;
begin
  inherited;
  FMarketing := true;
  FEmployee := true;
  FCustomerContact := true;
  FJobContact := true;
  FCustomer := true;
  FJob := true;
  FSupplierContact := true;
  FSupplier := true;
  fActive := true;
  FMarketingContact := true;
end;

destructor TGlobalListReport.Destroy;
begin

  inherited;
end;

function TGlobalListReport.PopulateReportSQL(SQL: TStrings;
  var msg: string): boolean;
begin
  inherited;
  msg := '';
  result := true;
  SQL.Clear;
  if Job then begin
    SQL.Add('select');
    SQL.Add('"Job" as ContactType,');
    SQL.Add('ClientID as ID,');
    SQL.Add('"F" as IsPrimary,');
    SQL.Add('Company,');
    SQL.Add('PrintName as CompanyPrintName,');
    SQL.Add('PrintName as Name,');
    SQL.Add('null as Title,');
    SQL.Add('null as FirstName,');
    SQL.Add('null as LastName,');
    SQL.Add('BillStreet as Street1,');
    SQL.Add('BillStreet2 as Street2,');
    SQL.Add('null as Street3,');
    SQL.Add('BillSuburb as City,');
    SQL.Add('BillState as State,');
    SQL.Add('BillPostcode as PostCode,');
    SQL.Add('BillCountry as Country,');
    SQL.Add('Phone,');
    SQL.Add('Mobile,');
    SQL.Add('Email,');
    SQL.Add('Active');
    SQL.Add('from tblclients');
    SQL.Add('where IsJob = "T"');
    if Active then
      SQL.Add('and Active = "T"');
  end;
  if JobContact then begin
    if SQL.Text <> '' then
      SQL.Add('union all');
    SQL.Add('select');
    SQL.Add('"JobContact" as ContactType,');
    SQL.Add('p.ContactID as ID,');
    SQL.Add('p.IsPrimarycontact as IsPrimary,');
    SQL.Add('c.Company,');
    SQL.Add('c.PrintName as CompanyPrintName,');
    SQL.Add('concat_ws(" ",p.ContactFirstName,p.ContactSurName) as Name,');
    SQL.Add('p.ContactTitle as Title,');
    SQL.Add('p.ContactFirstName as FirstName,');
    SQL.Add('p.ContactSurName as LastName,');
    SQL.Add('p.ContactAddress as Street1,');
    SQL.Add('p.ContactAddress2 as Street2,');
    SQL.Add('p.ContactAddress3 as Street3,');
    SQL.Add('p.ContactCity as City,');
    SQL.Add('p.ContactState as State,');
    SQL.Add('p.ContactPcode as PostCode,');
    SQL.Add('p.ContactCountry as Country,');
    SQL.Add('p.ContactPH as Phone,');
    SQL.Add('p.ContactMOB as Mobile,');
    SQL.Add('p.ContactEmail as Email,');
    SQL.Add('p.Active as Active');
    SQL.Add('from tblcontacts p');
    SQL.Add('inner join tblclients c on c.ClientID = p.ClientID');
    SQL.Add('where c.IsJob = "T"');
    SQL.Add('and not (IfNull(p.ContactFirstName,"") = "" and IfNull(p.ContactSurName,"") = "")');
    if Active then
      SQL.Add('and p.Active = "T"');
  end;
  if Customer then begin
    if SQL.Text <> '' then
      SQL.Add('union all');
    SQL.Add('select');
    SQL.Add('"Customer" as ContactType,');
    SQL.Add('ClientID as ID,');
    SQL.Add('"F" as IsPrimary,');
    SQL.Add('Company,');
    SQL.Add('PrintName as CompanyPrintName,');
    SQL.Add('PrintName as Name,');
    SQL.Add('null as Title,');
    SQL.Add('null as FirstName,');
    SQL.Add('null as LastName,');
    SQL.Add('BillStreet as Street1,');
    SQL.Add('BillStreet2 as Street2,');
    SQL.Add('null as Street3,');
    SQL.Add('BillSuburb as City,');
    SQL.Add('BillState as State,');
    SQL.Add('BillPostcode as PostCode,');
    SQL.Add('BillCountry as Country,');
    SQL.Add('Phone,');
    SQL.Add('Mobile,');
    SQL.Add('Email,');
    SQL.Add('Active');
    SQL.Add('from tblclients');
    SQL.Add('where Customer = "T"');
    if Active then
      SQL.Add('and Active = "T"');
  end;
  if CustomerContact then begin
    if SQL.Text <> '' then
      SQL.Add('union all');
    SQL.Add('select');
    SQL.Add('"CustomerContact" as ContactType,');
    SQL.Add('p.ContactID as ID,');
    SQL.Add('p.IsPrimarycontact as IsPrimary,');
    SQL.Add('c.Company,');
    SQL.Add('c.PrintName as CompanyPrintName,');
    SQL.Add('concat_ws(" ",p.ContactFirstName,p.ContactSurName) as Name,');
    SQL.Add('p.ContactTitle as Title,');
    SQL.Add('p.ContactFirstName as FirstName,');
    SQL.Add('p.ContactSurName as LastName,');
    SQL.Add('p.ContactAddress as Street1,');
    SQL.Add('p.ContactAddress2 as Street2,');
    SQL.Add('p.ContactAddress3 as Street3,');
    SQL.Add('p.ContactCity as City,');
    SQL.Add('p.ContactState as State,');
    SQL.Add('p.ContactPcode as PostCode,');
    SQL.Add('p.ContactCountry as Country,');
    SQL.Add('p.ContactPH as Phone,');
    SQL.Add('p.ContactMOB as Mobile,');
    SQL.Add('p.ContactEmail as Email,');
    SQL.Add('p.Active as Active');
    SQL.Add('from tblcontacts p');
    SQL.Add('inner join tblclients c on c.ClientID = p.ClientID');
    SQL.Add('where c.Customer = "T"');
    if Active then
      SQL.Add('and p.Active = "T"');
    SQL.Add('and not (IfNull(p.ContactFirstName,"") = "" and IfNull(p.ContactSurName,"") = "")');
  end;
  if Supplier then begin
    if SQL.Text <> '' then
      SQL.Add('union all');
    SQL.Add('select');
    SQL.Add('"Supplier" as ContactType,');
    SQL.Add('ClientID as ID,');
    SQL.Add('"F" as IsPrimary,');
    SQL.Add('Company,');
    SQL.Add('PrintName as CompanyPrintName,');
    SQL.Add('PrintName as Name,');
    SQL.Add('null as Title,');
    SQL.Add('null as FirstName,');
    SQL.Add('null as LastName,');
    SQL.Add('BillStreet as Street1,');
    SQL.Add('BillStreet2 as Street2,');
    SQL.Add('null as Street3,');
    SQL.Add('BillSuburb as City,');
    SQL.Add('BillState as State,');
    SQL.Add('BillPostcode as PostCode,');
    SQL.Add('BillCountry as Country,');
    SQL.Add('Phone,');
    SQL.Add('Mobile,');
    SQL.Add('Email,');
    SQL.Add('Active');
    SQL.Add('from tblclients');
    SQL.Add('where Supplier = "T"');
    if Active then
      SQL.Add('and Active = "T"');
  end;
  if CustomerContact then begin
    if SQL.Text <> '' then
      SQL.Add('union all');
    SQL.Add('select');
    SQL.Add('"SupplierContact" as ContactType,');
    SQL.Add('p.ContactID as ID,');
    SQL.Add('p.IsPrimarycontact as IsPrimary,');
    SQL.Add('c.Company,');
    SQL.Add('c.PrintName as CompanyPrintName,');
    SQL.Add('concat_ws(" ",p.ContactFirstName,p.ContactSurName) as Name,');
    SQL.Add('p.ContactTitle as Title,');
    SQL.Add('p.ContactFirstName as FirstName,');
    SQL.Add('p.ContactSurName as LastName,');
    SQL.Add('p.ContactAddress as Street1,');
    SQL.Add('p.ContactAddress2 as Street2,');
    SQL.Add('p.ContactAddress3 as Street3,');
    SQL.Add('p.ContactCity as City,');
    SQL.Add('p.ContactState as State,');
    SQL.Add('p.ContactPcode as PostCode,');
    SQL.Add('p.ContactCountry as Country,');
    SQL.Add('p.ContactPH as Phone,');
    SQL.Add('p.ContactMOB as Mobile,');
    SQL.Add('p.ContactEmail as Email,');
    SQL.Add('p.Active as Active');
    SQL.Add('from tblcontacts p');
    SQL.Add('inner join tblclients c on c.ClientID = p.ClientID');
    SQL.Add('where c.Supplier = "T"');
    SQL.Add('and not (IfNull(p.ContactFirstName,"") = "" and IfNull(p.ContactSurName,"") = "")');
    if Active then
      SQL.Add('and p.Active = "T"');
  end;

  if Supplier then begin
    if SQL.Text <> '' then
      SQL.Add('union all');
    SQL.Add('select');
    SQL.Add('"Marketing" as ContactType,');
    SQL.Add('ClientID as ID,');
    SQL.Add('"F" as IsPrimary,');
    SQL.Add('Company,');
    SQL.Add('PrintName as CompanyPrintName,');
    SQL.Add('PrintName as Name,');
    SQL.Add('null as Title,');
    SQL.Add('null as FirstName,');
    SQL.Add('null as LastName,');
    SQL.Add('BillStreet as Street1,');
    SQL.Add('BillStreet2 as Street2,');
    SQL.Add('null as Street3,');
    SQL.Add('BillSuburb as City,');
    SQL.Add('BillState as State,');
    SQL.Add('BillPostcode as PostCode,');
    SQL.Add('BillCountry as Country,');
    SQL.Add('Phone,');
    SQL.Add('Mobile,');
    SQL.Add('Email,');
    SQL.Add('Active');
    SQL.Add('from tblclients');
    SQL.Add('where OtherContact = "T"');
    if Active then
      SQL.Add('and Active = "T"');
  end;
  if CustomerContact then begin
    if SQL.Text <> '' then
      SQL.Add('union all');
    SQL.Add('select');
    SQL.Add('"MarketingContact" as ContactType,');
    SQL.Add('p.ContactID as ID,');
    SQL.Add('p.IsPrimarycontact as IsPrimary,');
    SQL.Add('c.Company,');
    SQL.Add('c.PrintName as CompanyPrintName,');
    SQL.Add('concat_ws(" ",p.ContactFirstName,p.ContactSurName) as Name,');
    SQL.Add('p.ContactTitle as Title,');
    SQL.Add('p.ContactFirstName as FirstName,');
    SQL.Add('p.ContactSurName as LastName,');
    SQL.Add('p.ContactAddress as Street1,');
    SQL.Add('p.ContactAddress2 as Street2,');
    SQL.Add('p.ContactAddress3 as Street3,');
    SQL.Add('p.ContactCity as City,');
    SQL.Add('p.ContactState as State,');
    SQL.Add('p.ContactPcode as PostCode,');
    SQL.Add('p.ContactCountry as Country,');
    SQL.Add('p.ContactPH as Phone,');
    SQL.Add('p.ContactMOB as Mobile,');
    SQL.Add('p.ContactEmail as Email,');
    SQL.Add('p.Active as Active');
    SQL.Add('from tblcontacts p');
    SQL.Add('inner join tblclients c on c.ClientID = p.ClientID');
    SQL.Add('where c.OtherContact = "T"');
    SQL.Add('and not (IfNull(p.ContactFirstName,"") = "" and IfNull(p.ContactSurName,"") = "")');
    if Active then
      SQL.Add('and p.Active = "T"');
  end;
  if Employee then begin
    if SQL.Text <> '' then
      SQL.Add('union all');
    SQL.Add('select');
    SQL.Add('"Employee" as ContactType,');
    SQL.Add('e.EmployeeID as ID,');
    SQL.Add('"F" as IsPrimary,');
    SQL.Add('null as Company,');
    SQL.Add('null as CompanyPrintName,');
    SQL.Add('e.EmployeeName as Name,');
    SQL.Add('e.Title as Title,');
    SQL.Add('e.FirstName as FirstName,');
    SQL.Add('e.LastName as LastName,');
    SQL.Add('e.Street as Street1,');
    SQL.Add('e.Street2 as Street2,');
    SQL.Add('e.Street3 as Street3,');
    SQL.Add('e.Suburb as Suburb,');
    SQL.Add('e.State as State,');
    SQL.Add('e.Postcode as PostCode,');
    SQL.Add('e.Country as Country,');
    SQL.Add('e.Phone as Phone,');
    SQL.Add('e.Mobile as Mobile,');
    SQL.Add('e.Email as Email,');
    SQL.Add('e.Active');
    SQL.Add('from tblemployees as e');
    if Active then
      SQL.Add('where e.Active = "T"');
  end;
  if SQL.Text <> '' then
    SQL.Add('Order by Name');
end;

procedure TGlobalListReport.SetCustomer(const Value: boolean);
begin
  FCustomer := Value;
end;

procedure TGlobalListReport.SetCustomerContact(const Value: boolean);
begin
  FCustomerContact := Value;
end;

procedure TGlobalListReport.SetEmployee(const Value: boolean);
begin
  FEmployee := Value;
end;

procedure TGlobalListReport.SetJob(const Value: boolean);
begin
  FJob := Value;
end;

procedure TGlobalListReport.SetJobContact(const Value: boolean);
begin
  FJobContact := Value;
end;

procedure TGlobalListReport.SetMarketing(const Value: boolean);
begin
  FMarketing := Value;
end;

procedure TGlobalListReport.SetMarketingContact(const Value: boolean);
begin
  FMarketingContact := Value;
end;

procedure TGlobalListReport.SetSupplier(const Value: boolean);
begin
  FSupplier := Value;
end;

procedure TGlobalListReport.SetSupplierContact(const Value: boolean);
begin
  FSupplierContact := Value;
end;

initialization
  RegisterClass(TGlobalListReport);

end.
