unit MailMergePrintReportObj;

interface

uses
  EmailHTML,PrintTemplateObj,Classes,BusObjMailMerge,MyAccess,
  ERPdbComponents,FaxObj,IntegerListObj;

type
  TGroupRec = class(TObject)
  private
  public
    sGroup: string;
    sSend: Boolean;
    sTemplateName: string;
  end;

type
  TMailMergePrintReport = class;
  TMMEvent  = function(const Sender: TMailMergePrintReport; const EventType, Value: string):boolean of object;

  TMailMergePrintReport = class(TObject)
  private
    fOnMessageChange: TMMEvent;
    fSendMode                   :string;
    fGroupRecList               : TList;
    fEmailAddressList,fFileList :TStringList;
    fPrintTemplateObj           :TPrintTemplates;
    fFax                        :TFaxObj;
    fBusObjMM                   :TMailMerge;
    fEmailHTML                  :TEmailHTML;  
    fCustomersIDList            : TIntegerList;
    fSuppliersIDList            : TIntegerList;
    fEmployeesIDList            : TIntegerList;
    fOtherContactsIDList        : TIntegerList;
    fLoyaltyIDList              : TIntegerList;
    fMarketingIDList            : TIntegerList;
    fShippingIDList             : TIntegerList;
    fConnection                 : TERPConnection;
    fSubject                    : String;
    fDocumentsProcessed         : integer;
    fRecipientName              : String;
    fsStatusDescription: String;

    procedure SaveHistory(const ID:integer;const sGroup:string;const DateSent:TDateTime;const sDocument:string; const Success:Boolean);
    function GetTemplateSQL(const TemplateName: string): string;
    function GetEmailAddress(const sGroup:String; const GenericID:Integer):string;
    function GetFaxNumber(const sGroup:String;const GenericID:Integer):string;
    function GetTargetName(const sGroup:string;const GenericID:Integer):string;
    function ValidateData:Boolean;
    procedure DoFax(sGroup:String;Target:Integer;sTemplateName:String;tmpSQL:String);
    function GetMaxItemsToSend:integer;
    Function contactswithoutEmails(const sGroup:string;const IDList :TIntegerList):String;
  public
    constructor Create;
    destructor Destroy; override;
    property SendMode:string read fSendMode write fSendMode;
    property GroupRecList: TList read fGroupRecList write fGroupRecList;
    property CustomersIDList : TIntegerList read fCustomersIDList write fCustomersIDList;
    property SuppliersIDList : TIntegerList read fSuppliersIDList write fSuppliersIDList;
    property EmployeesIDList : TIntegerList read fEmployeesIDList write fEmployeesIDList;
    property OtherContactsIDList : TIntegerList read fOtherContactsIDList write fOtherContactsIDList;
    property LoyaltyIDList : TIntegerList read fLoyaltyIDList write fLoyaltyIDList;
    property MarketingIDList : TIntegerList read fMarketingIDList write fMarketingIDList;
    property ShippingIDList : TIntegerList read fShippingIDList write fShippingIDList;
    property Connection : TERPConnection read fConnection write fConnection;
    property Subject:string read fSubject write fSubject;
    property DocumentsProcessed:integer read fDocumentsProcessed write fDocumentsProcessed;
    Property RecipientName:string read fRecipientName write fRecipientName;
    function Execute:Boolean;
    property OnMessageChange: TMMEvent read fOnMessageChange write fOnMessageChange;
    property MaxItemsToSend: integer read GetMaxItemsToSend;
    Property StatusDescription :String REad fsStatusDescription Write fsStatusDescription;
  end;


implementation

uses
  SysUtils,DnMLib,systemlib,CommonDbLib,BusObjBase,AppEnvironment,tcDataUtils,Windows,
  FastFuncs;

constructor TMailMergePrintReport.Create;
begin
  Inherited;
  fGroupRecList         := TList.Create;
  fEmailAddressList     := TStringList.Create;
  fCustomersIDList      := TIntegerList.Create;
  fSuppliersIDList      := TIntegerList.Create;
  fEmployeesIDList      := TIntegerList.Create;
  fOtherContactsIDList  := TIntegerList.Create;
  fLoyaltyIDList        := TIntegerList.Create;
  fMarketingIDList      := TIntegerList.Create;
  fShippingIDList      := TIntegerList.Create;
  fFileList             := TStringList.Create;
  fPrintTemplateObj     := TPrintTemplates.Create;
  fFax                  := TFaxObj.Create;
  fEmailHTML            := TEmailHTML.Create;  
  fBusObjMM             := TMailMerge.Create(nil);
  fBusObjMM.Connection  := TMyDacDataConnection(Self.Connection); 
end;

destructor TMailMergePrintReport.Destroy;
begin
  while fGroupRecList.Count > 0 do begin
    TGroupRec(fGroupRecList[0]).Free;
    fGroupRecList.Delete(0);
  end;
  if Assigned(fGroupRecList) then FreeAndNil(fGroupRecList);
  if Assigned(fEmailAddressList) then FreeAndNil(fEmailAddressList);
  if Assigned(fCustomersIDList) then FreeAndNil(fCustomersIDList);
  if Assigned(fSuppliersIDList) then FreeAndNil(fSuppliersIDList);
  if Assigned(fEmployeesIDList) then FreeAndNil(fEmployeesIDList);
  if Assigned(fOtherContactsIDList) then FreeAndNil(fOtherContactsIDList);
  if Assigned(fLoyaltyIDList) then FreeAndNil(fLoyaltyIDList);
  if Assigned(fMarketingIDList) then FreeAndNil(fMarketingIDList);
  if Assigned(fShippingIDList) then FreeAndNil(fShippingIDList);
  if Assigned(fPrintTemplateObj) then FreeAndNil(fPrintTemplateObj);
  if Assigned(fFax) then FreeAndNil(fFax);
  if Assigned(fEmailHTML) then FreeAndNil(fEmailHTML);
  if Assigned(fBusObjMM) then FreeAndNil(fBusObjMM);
  inherited;
end;  

function TMailMergePrintReport.GetMaxItemsToSend:integer;
var
  iMaxItemsToSend,i:integer;
  sGroup:string;
begin
  iMaxItemsToSend := 0;

  for i := 0 to fGroupRecList.Count - 1 do begin
    sGroup := TGroupRec(Self.GroupRecList[i]).sGroup;
    if TGroupRec(Self.GroupRecList[i]).sSend = False then continue;

         if sGroup = 'Customers'          then iMaxItemsToSend := iMaxItemsToSend + Self.CustomersIDList.Count
    else if sGroup = 'Suppliers'          then iMaxItemsToSend := iMaxItemsToSend + Self.SuppliersIDList.Count
    else if sGroup = 'Employees'          then iMaxItemsToSend := iMaxItemsToSend + Self.EmployeesIDList.Count
    else if sGroup = 'OtherContacts'      then iMaxItemsToSend := iMaxItemsToSend + Self.OtherContactsIDList.Count
    else if sGroup = 'Loyalty'            then iMaxItemsToSend := iMaxItemsToSend + Self.OtherContactsIDList.Count
    else if sGroup = 'Marketing'          then iMaxItemsToSend := iMaxItemsToSend + Self.MarketingIDList.Count
    else if sGroup = 'Shippingcontainer'  then iMaxItemsToSend := iMaxItemsToSend + Self.ShippingIDList.Count;

  end;
  Result :=  iMaxItemsToSend;  
end;

Function TMailMergePrintReport.ValidateData:Boolean;
var
  NoAddressList:TStringList;
  
begin
  Result := True;
  NoAddressList := TStringList.Create;
  try
    if (Self.SendMode = 'email') and (Self.Subject = '') then begin
      Result := False;
      fOnMessageChange(self,'MissingSubject','Missing Email subject');
      exit;
    end;
    //check email addresses
    if Self.SendMode = 'email' then begin
      NoAddressList.Add(contactswithoutEmails('Customers'         ,CustomersIDList));
      NoAddressList.Add(contactswithoutEmails('Suppliers'         ,SuppliersIDList));
      NoAddressList.Add(contactswithoutEmails('OtherContacts'     ,OtherContactsIDList));
      NoAddressList.Add(contactswithoutEmails('Loyalty'           ,LoyaltyIDList));
      NoAddressList.Add(contactswithoutEmails('ShippingContainer' ,ShippingIDList));
      NoAddressList.Add(contactswithoutEmails('Employees'         ,EmployeesIDList));
      NoAddressList.Add(contactswithoutEmails('Marketing'         ,MarketingIDList));
     if NoAddressList.Count > 0 then begin
        if Assigned(fOnMessageChange) then begin
          if fOnMessageChange(self,'MissingEAddress',NoAddressList.Text) then Result := False;
        end;
      end;
    end;
  finally
    FreeAndNil(NoAddressList);
  end;
end;

Function TMailMergePrintReport.Execute:Boolean;
var
  i,j:integer;
  sGroup,sTemplateName:string;
  bSend,bSuccess:Boolean;
  TmpSQL,TempEmailAddress:string;
  IDList :TIntegerList;
  Procedure AddMsg(const Value:String);
  begin
     if fsStatusDescription <> '' then fsStatusDescription := fsStatusDescription + chr(13);
     fsStatusDescription := fsStatusDescription + IntToStr(fDocumentsProcessed) +'.  ' +Value;
  end;
  Procedure FileCreated; begin AddMsg(ExeDir + 'MailMergeFiles\' + sTemplateName + '_' + fRecipientName + '.PDF');end;
begin
  Result := False;
  fEmailAddressList.Clear;
  fPrintTemplateObj.ReportSQLSupplied := True;
  fBusObjMM.Load(0);
  fEmailHTML.Subject := Self.Subject;

  if not ValidateData then exit;
  fsStatusDescription := '';
  if Self.SendMode = 'email' then fsStatusDescription := 'Emailed :'
  else if Self.SendMode = 'file' then fsStatusDescription := 'File(s) created :'
  else if Self.SendMode = 'print' then fsStatusDescription := 'Printed.'
  else if Self.SendMode = 'fax' then fsStatusDescription := 'Faxed :';
  IdList := nil;
  for i := 0 to fGroupRecList.Count - 1 do begin
    sGroup              := TGroupRec(Self.GroupRecList[i]).sGroup;
    bSend               := TGroupRec(Self.GroupRecList[i]).sSend;
    sTemplateName       := TGroupRec(Self.GroupRecList[i]).sTemplateName;

    bSuccess := True;
    if (bSend = False) or (sTemplateName = '') then continue;

         if SameText(sGroup , 'Customers')          then IdList :=CustomersIDList
    else if SameText(sGroup , 'Suppliers')          then IdList :=SuppliersIDList
    else if SameText(sGroup , 'Employees')          then IdList :=EmployeesIDList
    else if SameText(sGroup , 'OtherContacts')      then IdList :=OtherContactsIDList
    else if SameText(sGroup , 'Loyalty')            then IdList :=OtherContactsIDList
    else if SameText(sGroup , 'Marketing')          then IdList :=MarketingIDList
    else if SameText(sGroup , 'Shippingcontainer')  then IdList :=ShippingIDList
    else continue;

    if IdList <> nil then
      for j := 0 to (IdList.Count - 1) do begin
        tmpSQL := GetTemplateSQL(sTemplateName);
        tmpSQL := ReplaceStr(tmpSQL, '0', IntToStr(IdList[j]));
        fDocumentsProcessed  := fDocumentsProcessed  + 1;
        if Self.SendMode = 'email' then begin
          TempEmailAddress := GetEmailAddress(sGroup,IdList[j]);
          if TempEmailAddress = '' then Continue;
          fPrintTemplateObj.PrintMailMerge(sTemplateName,tmpSQL,True,'HTML',fRecipientName);    //fDocumentsProcessed);
          if not fEmailHTML.Execute(TempEmailAddress) then bSuccess := False;
          DeleteFiles(ExeDir + '\MailMergeFiles\','*.htm');
          AddMsg(fRecipientName +' - ' +TempemailAddress);
        end else if Self.SendMode = 'file' then begin
          fRecipientName := tcDataUtils.GetRecipientName(sGroup,IdList[j]);
          fPrintTemplateObj.PrintMailMerge(sTemplateName,tmpSQL,True,'Pdf',fRecipientName);//     fDocumentsProcessed); //create txtfile
          FileCreated;
        end else if Self.SendMode = 'print' then begin
          fPrintTemplateObj.PrintTemplateReport(sTemplateName,tmpSQL,True,1);
        end else if Self.SendMode = 'fax' then begin
          DoFax(sGroup,IdList[j],sTemplateName,tmpSQL);
          Addmsg(GetTargetName(sGroup,IdList[j]) +' - ' + GetFaxNumber(sGroup,IdList[j]));
        end;
        SaveHistory(IdList[j],sGroup,Now,sTemplateName,bSuccess);
        fOnMessageChange(self,'StepProgress','step');
      end;
  end;
  Result := True;
end;

procedure TMailMergePrintReport.DoFax(sGroup:String;Target:Integer;sTemplateName:String;tmpSQL:String);
begin
  if GetFaxNumber(sGroup,Target) <> '' then begin
    fPrintTemplateObj.PrintMailMerge(sTemplateName,tmpSQL,True,'bmp',fRecipientName);//create bmpfile
    fFax.NoCoverSheet := True;
    fFax.AddToFaxSpool(AppEnv.Employee.EmployeeName,GetTargetName(sgroup,Target),GetFaxNumber(sGroup,Target), sGroup,
              ' ', '',ExeDir + 'MailMergeFiles\IMG0001.BMP', Now());

    SysUtils.DeleteFile(ExeDir + 'MailMergeFiles\IMG0001.BMP');
  end;
end;

procedure TMailMergePrintReport.SaveHistory(Const ID:integer;Const sGroup:string;Const DateSent:TDateTime;Const sDocument:string;Const Success:Boolean);
begin
  fBusObjMM.New;
  fBusObjMM.RecipientID := id;
  fBusObjMM.Group       := sGroup;
  fBusObjMM.DateSent    := DateSent;
  fBusObjMM.DocumentName := sDocument;
  fBusObjMM.Success     := Success;
  fBusObjMM.PostDb;
end;




function TMailMergePrintReport.GetTemplateSQL(const TemplateName: string): string;
var
  qryTemp: TERPQuery;
begin
  Result := '';

  qryTemp := TERPQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := GetSharedMyDacConnection;

  with qryTemp do
  begin
    try
      Sql.Add('SELECT sqlString FROM tblTemplates WHERE TemplName = ' + QuotedStr(TemplateName));
      Open;
      Result := FieldByName('sqlString').AsString;
    finally
      FreeAndNil(qryTemp);
    end;
  end;
end;


function TMailMergePrintReport.contactswithoutEmails(  const sGroup:string;const IDList: TIntegerList): String;
var
  strSQL:string;
begin
  result := '';
  if (IDList=Nil) or (IDList.count=0) then exit;

    if (sGroup = 'Customers') or (sGroup = 'Suppliers') or (sGroup = 'Shippingcontainer')
      or (sGroup = 'OtherContacts') or (sGroup = 'Loyalty') then begin
        strSQL:= 'select company as Name from tblclients where ifnull(Email,"") = "" and clientID in (' + IDList.CommaText +')';
    end else if sGroup = 'Employees' then begin
      strSQL:= 'select concat_WS(" " , FirstName , LsatName) as Name  from tblemployees where ifnull(Email,'') = '' and EmployeeID  in (' + IDList.CommaText +')';
    end else if sGroup = 'Marketing' then begin
      strSQL:= 'select company as Name from tblmarketingcontacts where ifnull(Email,'') = '' and Id  in (' + IDList.CommaText +')';
    end;
  if strSQL <> '' then
    With CommonDbLib.TempMyQuery do try
      SQL.add(strSQL);
      if recordcount = 0 then exit;
      First;
      while Eof = False do begin
          if result <> '' then result := result +',';
          Result := result + fieldByname('Name').asString;
          Next;
      end;
    finally
        if active then close;
        Free;
    end;
end;
function TMailMergePrintReport.GetEmailAddress(Const sGroup:String;Const GenericID:Integer):string;
var
  qry: TERPQuery;
begin
  Result := '';
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := GetSharedMyDacConnection;
    qry.SQL.Clear;
    if (sGroup = 'Customers') or (sGroup = 'Suppliers') or (sGroup = 'Shippingcontainer') or (sGroup = 'OtherContacts') or (sGroup = 'Loyalty') then begin
      qry.SQL.Add('SELECT email FROM tblclients           WHERE ClientID = '+IntToStr(GenericID));
    end else if sGroup = 'Employees' then begin
      qry.SQL.Add('SELECT email FROM tblemployees         WHERE employeeID = '+IntToStr(GenericID));
    end else if sGroup = 'Marketing' then begin
      qry.SQL.Add('SELECT Email FROM tblmarketingcontacts WHERE ID = '+IntToStr(GenericID));
    end;
    qry.Open;
    Result := qry.FieldByName('Email').asString;
  finally
    FreeAndNil(qry);
  end;
end;
function TMailMergePrintReport.GetFaxNumber(Const sGroup:String;Const GenericID:Integer):string;
var
  qry: TERPQuery;
begin
  Result := '';
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := GetSharedMyDacConnection;
    qry.SQL.Clear;
    if (sGroup = 'Customers') or (sGroup = 'Suppliers') or (sGroup = 'Shippingcontainer') or (sGroup = 'OtherContacts') or (sGroup = 'Loyalty') then begin
      qry.SQL.Add('SELECT FaxNumber FROM tblclients WHERE ClientID =' +IntToStr(GenericID));
    end else if sGroup = 'Employees' then begin
      qry.SQL.Add('SELECT FaxNumber FROM tblemployees WHERE employeeID = '+IntToStr(GenericID));
    end else if sGroup = 'Marketing' then begin
      qry.SQL.Add('SELECT FaxNumber FROM tblmarketingcontacts WHERE ID = '+IntToStr(GenericID));
    end;
    qry.Open;
    Result := qry.FieldByName('FaxNumber').asString;
  finally
    FreeAndNil(qry);
  end;
end;
function TMailMergePrintReport.GetTargetName(Const sGroup:String;Const GenericID:Integer):string;
var
  qry: TERPQuery;
begin
  Result := '';
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := GetSharedMyDacConnection;
    qry.SQL.Clear;
    if (sGroup = 'Customers') or (sGroup = 'Suppliers') or (sGroup = 'Shippingcontainer') or (sGroup = 'OtherContacts') or (sGroup = 'Loyalty') then begin
        qry.SQL.Add('SELECT concat_ws(" " , FirstName,LastName) as Name  FROM tblclients WHERE ClientID = '+IntToStr(GenericID));
    end else if sGroup = 'Employees' then begin
      qry.SQL.Add('SELECT concat_ws(" " , FirstName,LastName) as Name FROM tblemployees WHERE employeeID = '+IntToStr(GenericID));
    end else if sGroup = 'Marketing' then begin
      qry.SQL.Add('SELECT concat_ws(" " , FirstName,LastName) as Name FROM tblmarketingcontacts WHERE ID = '+IntToStr(GenericID));
    end;
    qry.Open;
    Result := qry.FieldByName('Name').asString;
  finally
    FreeAndNil(qry);
  end;
end;
end.
