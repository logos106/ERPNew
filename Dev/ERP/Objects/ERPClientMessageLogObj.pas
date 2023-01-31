unit ERPClientMessageLogObj;

interface

uses
  MyAccess, Classes, TwilioApiObj;


type

  TTwilioProcessor = class
  private
    fOnProgress: TNotifyEvent;
    fLicenceDatabaseName: string;
    fConnection: TMyConnection;
    fLicenceConnection: TMyConnection;
    fProgressCaption: string;
    fProgressStep: string;
    fStepNo: integer;
    fStepCount: integer;
    fSMSChargeProductName: string;
    function GetLicenceConnection: TMyConnection;
    property LicenceConnection: TMyConnection read GetLicenceConnection;
    function MonthlyNumberCharge: double;
  public
    property Connection: TMyConnection read fConnection write fConnection;
    property LicenceDatabaseName: string read fLicenceDatabaseName write fLicenceDatabaseName;
    property ProgressCaption: string read fProgressCaption write fProgressCaption;
    property ProgressStep: string read fProgressStep write fProgressStep;
    property StepNo: integer read fStepNo;
    property StepCount: integer read fStepCount;
    constructor Create;
    destructor Destroy; override;
    procedure GetNewMessages;
    property OnProgress: TNotifyEvent read fOnProgress write fOnProgress;
    function GenerateSalesOrders(PriorToDate: TDate): boolean;
    property SMSChargeProductName: string read fSMSChargeProductName write fSMSChargeProductName;
  end;

procedure CheckCreateLog(Conn: TMyConnection);

implementation

uses
  MySQLUtils, DbConst, SMSConfigObj, SysUtils, DateTimeUtils, SMSUtils,
  JsonObject, BusObjSales, BusObjBase, CommonLib, Dialogs, BusObjAttachment;

procedure CheckCreateLog(Conn: TMyConnection);
var
  cmd: TMyCommand;
begin
  if not MySQLUtils.TableExists(Conn, 'tblERPClientMessageLog') then begin
    cmd := TMyCommand.Create(nil);
    try
      cmd.Connection := Conn;
      cmd.SQL.Add('CREATE TABLE `tblERPClientMessageLog` (');
      cmd.SQL.Add('Id INT(11) NOT NULL AUTO_INCREMENT,');
      cmd.SQL.Add('Name varchar(255) null default null,');
      cmd.SQL.Add('ERPClientName varchar(255) null default null,');
      cmd.SQL.Add('EntityRef varchar(255) null default null,');
      cmd.SQL.Add('Direction varchar(255) null default null,');
      cmd.SQL.Add('MessageType varchar(15) null default null,');
      cmd.SQL.Add('MessageId varchar(255) null default null,');
      cmd.SQL.Add('MessageFrom varchar(255) null default null,');
      cmd.SQL.Add('MessageTo varchar(255) null default null,');
      cmd.SQL.Add('MessageDate DATETIME NULL DEFAULT NULL,');
      cmd.SQL.Add('CurrencyCost double null default null,');
      cmd.SQL.Add('CurrencyPrice double null default null,');
      cmd.SQL.Add('CurrencyCode varchar(15) null default null,');
      cmd.SQL.Add('Price double null default null,');
      cmd.SQL.Add('ERPSaleID int(11) null default null,');
      cmd.SQL.Add('PRIMARY KEY (Id),');
      cmd.SQL.Add('INDEX NameIdx (Name),');
      cmd.SQL.Add('INDEX ERPClientNameIdx (ERPClientName),');
      cmd.SQL.Add('INDEX MessageIdIdx (MessageId),');
      cmd.SQL.Add('INDEX EntityRefIdx (EntityRef)');
      cmd.SQL.Add(')');
      cmd.SQL.Add('ENGINE=MyISAM;');
      cmd.Execute;
    finally
      cmd.Free;
    end;
  end;
end;


{ TTwilioProcessor }

constructor TTwilioProcessor.Create;
begin
  fLicenceDatabaseName := DbConst.SERVICES_DATABASE;
end;

destructor TTwilioProcessor.Destroy;
begin
  fLicenceConnection.Free;
  inherited;
end;

function TTwilioProcessor.GenerateSalesOrders(PriorToDate: TDate): boolean;
var
  qry, qry2: TMyQuery;
  CurrentClient: string;
  SO: TSalesOrder;
  Att: TAttachment;
  details: string;
  total: double;
  CurrentNumber: string;

  function Pad(str: string; aLen: integer): string;
  begin
    result := str;
    while Length(result) < aLen  do
      result := result + ' ';
  end;

  procedure AddCharge;
  var s: string;
  begin
    if not SameText(CurrentNumber, qry.FieldByName('Entityref').AsString)  then begin
      CurrentNumber := qry.FieldByName('Entityref').AsString;
      if details <> '' then
        details := details + #13#10;
      details := details + 'Charges for number: ' + CurrentNumber;
    end;
    qry.Edit;
    qry.FieldByName('Price').AsFloat := qry.FieldByName('CurrencyPrice').AsFloat;
    qry.FieldByName('ERPSaleId').AsInteger := SO.ID;
    qry.Post;
    total := total + qry.FieldByName('Price').AsFloat;
    s := FormatDAteTime('yyyy-mm-dd hh:nn:ss',qry.FieldByName('MessageDate').AsDateTime) + #9;
    if Pos('outbound',qry.FieldByName('Direction').AsString) > 0 then begin
      s := s + Pad('Send '+ qry.FieldByName('MessageType').AsString,13) + #9;
      s := s + Pad(qry.FieldByName('MessageTo').AsString,12) + #9;
    end
    else begin
      s := s + Pad('Receive '+ qry.FieldByName('MessageType').AsString,13) + #9;
      s := s + Pad(qry.FieldByName('MessageFrom').AsString,12) + #9;
    end;
    s:= s + FloatToStrF(qry.FieldByName('Price').AsFloat, ffCurrency,15,4);
    if details <> '' then
      details := details + #13#10;
    details := details + s;
  end;

begin
  Att:= nil;
  result := true;
  try
    CheckCreateLog(Connection);
    ProgressCaption := 'Generating new Sales Orders';
    ProgressStep := '';
    SO := nil;
    if self.SMSChargeProductName = '' then
      raise Exception.Create('No product defined to use for SMS invoicing');
    qry := TMyQuery.Create(nil);
    qry2 := TMyQuery.Create(nil);
    try
      qry.Connection := self.Connection;
      qry2.Connection := self.Connection;
      qry.SQL.Add('select * from tblERPClientMessageLog where');
      qry.SQL.Add('MessageDate < "'+FormatDateTime('yyyy-mm-dd',PriorToDate)+'"');
      qry.SQL.Add('and IfNull(ERPSaleId,0) = 0');
      qry.SQL.Add('and IfNull(ERPClientName,"") <> ""');
      qry.SQL.Add('order by ERPClientName, EntityRef, MessageDate');
      qry.Open;
      fStepCount := qry.RecordCount;
      while not qry.Eof do begin
        ProgressStep := 'Processing client: ' + qry.FieldByName('ERPClientName').AsString;
        fStepNo := qry.RecNo;
        if Assigned(fOnProgress) then
          fOnProgress(self);
        if not SameText(CurrentClient, qry.FieldByName('ERPClientName').AsString) then begin
          { new client }
          if not Assigned(SO) then begin
            SO := TSalesOrder.Create(nil);
            SO.Connection := TMyDacDataConnection.Create(SO);
            SO.Connection.Connection := Connection;
            Att := TAttachment.Create(SO);
            Att.Connection := SO.Connection;
          end
          else begin
            { update current sales order }
            SO.Lines.New;
            SO.Lines.ProductName := self.SMSChargeProductName;
            SO.Lines.Product_Description := 'Charges to ' + FormatDateTime('dd mmm yyyy',PriorToDate -1);
            SO.Lines.UOMQtySold := 1;
            SO.Lines.LinePrice := total;
            SO.Lines.UOMQtyShipped := 1;
//            SO.Lines.Product_Description_Memo := details;
            if not SO.Save then begin
              result := false;
              CommonLib.MessageDlgXP_Vista('Error while createing transaction for ' + SO.ClientName + #13#10 + #13#10 + SO.ResultStatus.Messages, mtWarning,[mbOk],0);
              exit;
            end;
            Att.New;
            Att.TableName := SO.TableName;
            Att.TableId := SO.ID;
            Att.AttachmentName := 'Call List.txt';
            Att.AttachmentText := details;
            if not Att.Save then begin
              result := false;
              CommonLib.MessageDlgXP_Vista('Error while createing transaction attachment for ' + SO.ClientName + #13#10 + #13#10 + Att.ResultStatus.Messages, mtWarning,[mbOk],0);
              exit;
            end;

          end;
          SO.New;
          SO.ClientName := qry.FieldByName('ERPClientName').AsString;
          CurrentClient := SO.ClientName;
          { add monthly charge line(s) }
          qry2.SQL.Clear;
          qry2.SQL.Add('select distinct EntityRef from tblERPClientMessageLog');
          qry2.SQL.Add('where IfNull(ERPClientName,"") = ' + QuotedStr(qry.FieldByName('ERPClientName').AsString));
          qry2.Open;
          try
            while not qry2.Eof do begin
              SO.Lines.New;
              SO.Lines.ProductName := self.SMSChargeProductName;
              SO.Lines.Product_Description := 'Monthly charge for number ' + qry2.FieldByName('EntityRef').AsString;
              SO.Lines.UOMQtySold := 1;
              SO.Lines.LinePrice := MonthlyNumberCharge;
              SO.Lines.UOMQtyShipped := 1;
              qry2.Next;
            end;
          finally
            qry2.Close;
          end;

          details := '';
          total := 0;
          AddCharge;
        end
        else begin
          { same client }
          AddCharge;
        end;
        qry.Next;
      end;
      if Assigned(SO) then begin
        { update current sales order }
        SO.Lines.New;
        SO.Lines.ProductName := self.SMSChargeProductName;
        SO.Lines.Product_Description := 'Charges to ' + FormatDateTime('dd mmm yyyy',PriorToDate -1);
        SO.Lines.UOMQtySold := 1;
        SO.Lines.LinePrice := total;
        SO.Lines.UOMQtyShipped := 1;
//        SO.Lines.Product_Description_Memo := details;
        if not SO.Save then begin
          result := false;
          CommonLib.MessageDlgXP_Vista('Error while createing transaction for ' + SO.ClientName + #13#10 + #13#10 + SO.ResultStatus.Messages, mtWarning,[mbOk],0);
          exit;
        end;
        Att.New;
        Att.TableName := SO.TableName;
        Att.TableId := SO.ID;
        Att.AttachmentName := 'Call List.txt';
        Att.AttachmentText := details;
        if not Att.Save then begin
          result := false;
          CommonLib.MessageDlgXP_Vista('Error while createing transaction attachment for ' + SO.ClientName + #13#10 + #13#10 + Att.ResultStatus.Messages, mtWarning,[mbOk],0);
          exit;
        end;
      end;
    finally
      qry.Free;
      qry2.Free;
      SO.Free;
    end;
  except
    on e: exception do begin
      result := false;
      CommonLib.MessageDlgXP_Vista('Error while createing transactions.' + #13#10 + #13#10 + e.Message, mtWarning,[mbOk],0);
    end;
  end;
end;

function TTwilioProcessor.GetLicenceConnection: TMyConnection;
begin
  if not Assigned(fLicenceConnection) then begin
    fLicenceConnection := TMyConnection.Create(nil);
    MySQLUtils.SetConnectionProps(fLicenceConnection,LicenceDatabaseName,Connection.Server);
  end;
  result := fLicenceConnection;
end;

procedure TTwilioProcessor.GetNewMessages;
var
  Twilio: TTwilioApi;
  list: TTwilioList;
  Config, SMSConfig: TSMSConfig;
  qry, qry2: TMyQuery;
  params: TStringList;
  json: TJsonObject;
  x: integer;
begin
  CheckCreateLog(Connection);
  ProgressCaption := 'Checking for new SMS Messages';
  ProgressStep := '';
  Twilio:= TTwilioApi.Create(nil);
  Config := TSMSConfig.Create;
  qry := TMyQuery.Create(nil);
  params:= TStringList.Create;
  try
    Config.Load(self.Connection);
    Twilio.Config := Config;
    qry.Connection := self.Connection;
    qry.SQL.Text := 'select Max(MessageDate) as MessageDate from tblERPClientMessageLog where MessageType = "SMS"';
    qry.Open;
    if qry.FieldByName('MessageDate').AsDateTime > 0 then
      Params.Add('DateSent>=' + FormatDateTime('yyyy-mm-dd',qry.FieldByName('MessageDate').AsDateTime -60));

    list:= Twilio.GetSMSList(params);
    fStepCount := list.Count;
    while not list.EOF do begin
      ProgressStep := 'Getting message ' + IntToStr(list.Pos+1) + ' of ' + IntToStr(list.Count);
      fStepNo := list.Pos + 1;
      if Assigned(fOnProgress) then
        fOnProgress(self);
      qry.Close;
      qry.SQL.Text := 'select * from tblERPClientMessageLog where MessageId = ' + QuotedStr(list.Data.S['sid']);
      qry.Open;
      if qry.IsEmpty then begin
        qry.Insert;
        qry.FieldByName('MessageID').AsString := list.Data.S['sid'];
        qry.FieldByName('Direction').AsString := list.Data.S['direction'];
        qry.FieldByName('MessageType').AsString := 'SMS';
        qry.FieldByName('MessageDate').AsDateTime := UTCToLocal(TTwilioApi.StrToUTC(list.Data.S['date_sent']));
        if SameText(list.Data.S['direction'],'inbound') then
          qry.FieldByName('EntityRef').AsString := list.Data.S['to']
        else
          qry.FieldByName('EntityRef').AsString := list.Data.S['from'];
        qry.FieldByName('MessageFrom').AsString := list.Data.S['from'];
        qry.FieldByName('MessageTo').AsString := list.Data.S['to'];
        qry.FieldByName('CurrencyCost').AsFloat := StrToFloat(list.Data.S['price']);
        qry.FieldByName('CurrencyCode').AsString := list.Data.S['price_unit'];
        if qry.FieldByName('CurrencyCode').AsString = '' then
          qry.FieldByName('CurrencyCode').AsString := SMSUtils.NumberCountryCode(qry.FieldByName('EntityRef').AsString, self.Connection);


        qry.Post;
      end;
      list.Next;
    end;
    { now voice calls }
    ProgressCaption := 'Checking for new Voice Messages';
    qry.Close;
    qry.SQL.Text := 'select Max(MessageDate) as MessageDate from tblERPClientMessageLog where MessageType = "Voice"';
    qry.Open;
    Params.Clear;
    if qry.FieldByName('MessageDate').AsDateTime > 0 then
      Params.Add('StartTime>=' + FormatDateTime('yyyy-mm-dd',qry.FieldByName('MessageDate').AsDateTime -60));

    list:= Twilio.GetCallList(params);
    fStepCount := list.Count;
    while not list.EOF do begin
      ProgressStep := 'Getting message ' + IntToStr(list.Pos+1) + ' of ' + IntToStr(list.Count);
      fStepNo := list.Pos + 1;
      if Assigned(fOnProgress) then
        fOnProgress(self);
      qry.Close;
      qry.SQL.Text := 'select * from tblERPClientMessageLog where MessageId = ' + QuotedStr(list.Data.S['sid']);
      qry.Open;
      if qry.IsEmpty then begin
        qry.Insert;
        qry.FieldByName('MessageID').AsString := list.Data.S['sid'];
        qry.FieldByName('Direction').AsString := list.Data.S['direction'];
        qry.FieldByName('MessageType').AsString := 'Voice';
        qry.FieldByName('MessageDate').AsDateTime := UTCToLocal(TTwilioApi.StrToUTC(list.Data.S['date_created']));
        if SameText(list.Data.S['direction'],'inbound') then
          qry.FieldByName('EntityRef').AsString := list.Data.S['to']
        else
          qry.FieldByName('EntityRef').AsString := list.Data.S['from'];
        qry.FieldByName('MessageFrom').AsString := list.Data.S['from'];
        qry.FieldByName('MessageTo').AsString := list.Data.S['to'];
        qry.FieldByName('CurrencyCost').AsFloat := StrToFloat(list.Data.S['price']);
        qry.FieldByName('CurrencyCode').AsString := list.Data.S['price_unit'];
        if qry.FieldByName('CurrencyCode').AsString = '' then
          qry.FieldByName('CurrencyCode').AsString := SMSUtils.NumberCountryCode(qry.FieldByName('EntityRef').AsString, self.Connection);


        qry.Post;
      end;

      list.Next;
    end;

    { now associate with erp clients }
    qry2:= TMyQuery.Create(nil);
    json := JO;
    SMSConfig := TSMSConfig.Create;
    try
      qry2.Connection := self.LicenceConnection;
//      qry2.SQL.Add('select tclientconfig.Name,');
//      qry2.SQL.Add('tclientconfig.ERPClientName,');
//      qry2.SQL.Add('tsoftwarelicence.datatext');
//      qry2.SQL.Add('from tclientconfig, tcomputer, tsoftwarelicence');
//      qry2.SQL.Add('where tclientconfig.id = tcomputer.clientid');
//      qry2.SQL.Add('and tcomputer.id = tsoftwarelicence.computerid');

      qry2.SQL.Add('SELECT c.Name, c.ERPClientName, lic.datatext');
      qry2.SQL.Add('FROM tclientconfig c');
      qry2.SQL.Add('INNER JOIN tcomputer comp ON comp.clientid = c.id');
      qry2.SQL.Add('INNER JOIN tsoftwarelicence lic ON lic.computerid = comp.id');
      qry2.SQL.Add('WHERE lic.concurrentusers > 0');

      qry2.Open;
      ProgressCaption := 'Checking Clients';
      fStepCount := qry2.RecordCount;
      while not qry2.Eof do begin
        ProgressStep := 'Processing client: ' + qry2.FieldByName('Name').AsString;
        fStepNo := qry2.RecNo;
        if Assigned(fOnProgress) then
          fOnProgress(self);
        json.AsString := qry2.FieldByName('datatext').AsString;
        for x := 0 to json.O['erpinfo'].Count - 1 do begin
          ProgressStep := 'Processing client: ' + qry2.FieldByName('Name').AsString + ' ' + json.O['erpinfo'].Items[x].Name;
          if Assigned(fOnProgress) then
            fOnProgress(self);
          if json.O['erpinfo'].Items[x].Value.AsObject.ObjectExists('SMSConfig') then begin
            SMSConfig.Assign(json.O['erpinfo'].Items[x].Value.AsObject.O['SMSConfig']);
            if SMSConfig.PhoneNumber <> '' then begin
              qry.Close;
              qry.SQL.Text := 'select * from tblERPClientMessageLog where EntityRef = ' +
                QuotedStr(SMSConfig.PhoneNumber) + ' and IfNull(Name,"") = ""';
              qry.Open;
              while not qry.Eof do begin
                ProgressStep := 'Processing client: ' + qry2.FieldByName('Name').AsString + ' ' +
                  json.O['erpinfo'].Items[x].Name + ' Msg ' + IntToStr(qry.RecNo + 1) + ' of ' + IntToStr(qry.RecordCount);
                if Assigned(fOnProgress) then
                  fOnProgress(self);

                qry.Edit;
                qry.FieldByName('Name').AsString := qry2.FieldByName('Name').AsString;
                qry.FieldByName('ERPClientName').AsString := qry2.FieldByName('ERPClientName').AsString;
                if Pos(Lowercase(qry.FieldByName('direction').AsString),'inbound') > 0 then
                  qry.FieldByName('CurrencyPrice').AsFloat := SMSConfig.PriceIn(qry.FieldByName('CurrencyCost').AsFloat)
                else
                  qry.FieldByName('CurrencyPrice').AsFloat := SMSConfig.PriceOut(qry.FieldByName('CurrencyCost').AsFloat);

                qry.Post;

                qry.Next;
              end;
            end;
          end;
        end;
        qry2.Next;
      end;
    finally
      qry2.Free;
      json.Free;
      SMSConfig.Free;
    end;
  finally
    Twilio.Free;
    Config.Free;
    qry.Free;
    params.Free;
  end;
end;

function TTwilioProcessor.MonthlyNumberCharge: double;
begin
  result := 6.0;
end;

end.
