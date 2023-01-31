unit SMSCheckThreadTask;

interface

uses
  ServerModuleThreadTask, DBBackupObj;

type

  TSMSCheckType = (scSend, scReceive);
  TSMSCheckThreadTask = class(TServerModuleThreadTask)
  private
  protected
    procedure DoWork; override;
  public
    constructor Create; override;
  end;


implementation

uses
  ERPDbListObj, LogMessageTypes, ERPDbComponents, TwilioApiObj, SMSMessageObj,
  classes, SMSConfigObj, JsonObject, SharedAppUserListObj, ModuleConst, DB,
  SMSUtils, SysUtils, DateTimeUtils;

{ TSMSCheckThreadTask }

constructor TSMSCheckThreadTask.Create;
begin
  inherited Create;
  RemoveWhenComplete := true;
end;

procedure TSMSCheckThreadTask.DoWork;
var
  dbList: TERPDbList;
  qry, qry2: TERPQuery;
  msg: string;
  api: TTwilioApi;
  apiList, recordingList: TTwilioList;
  callList: TCallList;
  smsMsg: TSMSMessage;
  stream: TStream;
  SL: TStringList;
  SMSConfig: TSMSConfig;
  ContactID, CustomerId, SupplierId, EmployeeId, MarketingContactId: integer;
  json: TJsonObject;
  s: string;
  CheckType: TSMSCheckType;
begin
  try
    CheckType := TSMSCheckType(Params.I['CheckType']);
    if CheckType = scSend then begin
      Log('Starting SMS send check ...',ltDetail);
      self.StatusMessage := 'Starting Send Check';
    end
    else begin
      Log('Starting SMS receive check ...',ltDetail);
      self.StatusMessage := 'Starting Receive Check';
    end;
    dbList := TERPDbList.Create(MySQLServer);

    api := TTwilioApi.Create();
    api.OnLog := Log;
    smsMsg := TSMSMessage.Create;
    SMSConfig := TSMSConfig.Create;
    json := JO;
    try
     api.Config := SMSConfig;
     if dbList.First then begin
       qry := TERPQuery.Create(nil);
       qry2 := TERPQuery.Create(nil);
       try
         repeat
           if Terminated then begin
             Log(ClassName + ' terminated, aborting SMS check.',ltDetail);
             exit;
           end;

           if not TSharedAppUserList.ExAddUser(s,ERP_ADMIN_USER+'_SMS_Check',dbList.Connection.Database,MySQLServer,'','','',false,true) then begin
             Log('Could not check ' + dbList.Connection.Database + ' at this time: ' + s,ltWarning);
           end
           else begin
             try
               SMSConfig.Load(dbList.Connection);
               qry.Close;
               qry.Connection := dbList.Connection;
               qry2.Connection := dbList.Connection;
               { is this database using SMS .. }
               if SMSConfig.SMSEnabled then begin
//                 self.StatusMessage := 'Checking ' + dbList.Connection.Database;
                 if CheckType = scSend then begin
                   self.StatusMessage := 'Send Check: ' + dbList.Connection.Database;
                   qry.SQL.Text := 'select * from tblreference where Ref_type = "SMS" and Status = "Waiting"';
                   qry.Open;
                   while not qry.Eof do begin
                     { send message }
                     try
                       dbList.Connection.StartTransaction;
                       try
                         qry.Edit;
                         stream:= qry.CreateBlobStream(qry.FieldByName('ReferenceData'),bmReadWrite);
                         try
                           smsMsg.ReadFromStream(stream);
                           if api.SendSMS(smsMsg.PhoneNumber, smsMsg.Content, msg, json) then begin
                             try
                               if not (SameText(json.ValueByName['status'].AsString,'failed') or SameText(json.ValueByName['status'].AsString,'undelivered')) then begin
                                 smsMsg.Status := 'Sent';
                                 smsMsg.Info := 'Message Sent';
                                 smsMsg.uid := json.S['sid'];
                                 qry.FieldByName('Status').AsString:= 'Sent';
                                 if json.Exists('Price') and  (not json.ItemByName['price'].Value.IsTypeNull) then
                                   qry.FieldByName('Cost').AsFloat := api.Config.PriceOut(json.ItemByName['price'].Value.AsFloat)
                                 else
                                   qry.FieldByName('Cost').AsFloat := 0;
                                 qry.FieldByName('CurrencyCode').AsString := SMSUtils.NumberCurrencyCode(api.Config.PhoneNumber, dbLIst.Connection); //json.S['price_unit'];
                                 qry.FieldByName('MessageId').AsString := smsMsg.uid;
                                 smsMsg.TimeLocal := now;
                               end
                               else begin
                                 smsMsg.Status := 'Send Failed';
                                 smsMsg.Info := json.ValueByName['status'].AsString + ' ' + json.S['message'];
                                 qry.FieldByName('Status').AsString:= 'Send Failed';
                                 Log('Error sending SMS message for ' + dbList.Connection.Database + ' Global ref ' + qry.FieldByName('GlobalRef').AsString + ': ' + smsMsg.Info, ltError);
                               end;
                             except
                               on e: exception do begin
                                 smsMsg.Status := 'Send Failed';
                                 smsMsg.Info := msg;
                                 qry.FieldByName('Status').AsString:= 'Send Failed';
                                 Log('Error sending SMS message for ' + dbList.Connection.Database + ' Global ref ' + qry.FieldByName('GlobalRef').AsString + ': ' + e.Message, ltError);
                               end;
                             end;
                           end
                           else begin
                             smsMsg.Status := 'Send Failed';
                             smsMsg.Info := msg;
                             qry.FieldByName('Status').AsString:= 'Send Failed';
                           end;
                           smsMsg.TimeLocal := now;
                           qry.FieldByName('Ref_Date').AsDateTime:= now;
                           stream.Position := 0;
                           smsMsg.SaveToStream(stream);
                         finally
                           stream.Free;
                         end;
                         qry.Post;
                         dbList.Connection.Commit;
                       finally
                         if dbList.Connection.InTransaction then
                           dbList.Connection.Rollback;
                       end;
                     except
                       on e: exception do begin
                         if qry.State in [dsEdit, dsInsert] then
                           qry.Cancel;
                         if dbList.Connection.InTransaction then
                           dbList.Connection.Rollback;
                         Log('Error during SMS send check: ' + e.Message,ltError);
                       end;
                     end;

                     if Terminated then begin
                       Log(ClassName + ' terminated, aborting SMS check.',ltDetail);
                       exit;
                     end;
                     qry.Next;
                   end;
                 end
                 else if CheckType = scReceive then begin
                   if Trim(api.Config.PhoneNumber) = '' then
                     exit;
                   self.StatusMessage := 'Receive Check: ' + dbList.Connection.Database;

                   { check on server for new SMS messages }
                   SL:= TStringList.Create;
                   try
                     qry.Close;
                     qry.SQL.Text := 'select Max(Ref_Date) as LastDate from tblreference where Ref_Type = "SMS" and Status = "received"';
                     qry.Open;
                     SL.Add('To=' + api.Config.PhoneNumber);
                     if qry.FieldByName('LastDate').AsDateTime > 0 then
                       { go back a day to make sure no messages are missed }
                       SL.Add('DateSent>=' + FormatDateTime('yyyy-mm-dd',qry.FieldByName('LastDate').AsDateTime -1));
                     qry.Close;
                     apiList:= api.GetSMSList(SL);
                     try
                       while not apiList.EOF do begin

                         if Terminated then begin
                           Log(ClassName + ' terminated, aborting SMS check.',ltDetail);
                           exit;
                         end;

                         if not SameText(apiList.Data.S['direction'], 'inbound') then begin
                           apiList.Next;
                           continue;
                         end;

                         qry.Close;
                         qry.SQL.Text := 'select * from tblreference where Ref_Type = "SMS" and MessageID = ' + QuotedStr(apiList.Data.S['sid']);
                         qry.Open;
                         if qry.IsEmpty then begin
                           smsMsg.Clear;
                           qry.Insert;

                           smsMsg.TimeLocal := UTCToLocal(TTwilioApi.StrToUTC(apiList.Data.S['date_sent']));
                           smsMsg.uid := apiList.Data.S['sid'];
                           qry.FieldByName('Ref_Type').AsString := 'SMS';
                           qry.FieldByName('Ref_Date').AsDateTime := smsMsg.TimeLocal;
                           qry.FieldByName('Referencetxt').AsString := Copy(apiList.Data.S['body'],1,50);
                           qry.FieldByName('MessageId').AsString := smsMsg.uid;
                           qry.FieldByName('Status').AsString := apiList.Data.S['status'];
                           if apiList.Data.Exists('price') and (not callList.Data.ItemByName['price'].Value.IsTypeNull) then
                             qry.FieldByName('Cost').AsFloat := api.Config.PriceIn(apiList.Data.ItemByName['price'].Value.AsFloat)
                           else
                             qry.FieldByName('Cost').AsFloat := 0;
                           qry.FieldByName('CurrencyCode').AsString := apiList.Data.S['price_unit'];

                           smsMsg.Status := 'Received';
                           smsMsg.Content := apiList.Data.S['body'];
                           smsMsg.Format := 'SMS';
                           smsMsg.ReceiptId := apiList.Data.S['sid'];
                           smsMsg.PhoneNumber := apiList.Data.S['from'];

                           qry.FieldByName('MessageFrom').AsString := smsMsg.PhoneNumber;
                           stream:= qry.CreateBlobStream(qry.FieldByName('ReferenceData'),bmWrite);
                           try
                             smsMsg.SaveToStream(stream);
                           finally
                             stream.Free;
                           end;
                           if SMSUtils.PhoneNoToEntity(smsMsg.PhoneNumber, ContactID, CustomerId, SupplierId, EmployeeId, MarketingContactId, dbList.Connection) then begin
                             if ContactId > 0 then qry.FieldByName('ContactId').AsInteger := ContactId;
                             if CustomerId > 0 then qry.FieldByName('CusId').AsInteger := CustomerId;
                             if SupplierId > 0 then qry.FieldByName('SupId').AsInteger := SupplierId;
                             if EmployeeId > 0 then qry.FieldByName('EmployeeId').AsInteger := EmployeeId;
                             if MarketingContactId > 0 then qry.FieldByName('MarketingContactId').AsInteger := MarketingContactId;
                           end;

                           qry.Post;

                           qry.Edit;
                             qry.FieldByName('GlobalRef').AsString := dbList.SiteCode + IntToStr(qry.FieldByName('RefID').AsInteger);
                             qry.FieldByName('msUpdateSiteCode').AsString := dbList.SiteCode;
                           qry.Post;
                         end;

                         apiList.Next;
                       end;
                     finally
                       apiLIst.Free;
                     end;

                   finally
                     SL.Free;
                     qry.Close;
                   end;

                   { check on server for new Voice messages }
                   SL:= TStringList.Create;
                   try
                     qry.Close;
                     qry.SQL.Text := 'select Max(Ref_Date) as LastDate from tblreference where Ref_Type = "Voice" and Status = "received"';
                     qry.Open;
                     SL.Add('To=' + api.Config.PhoneNumber);
                     if qry.FieldByName('LastDate').AsDateTime > 0 then
                       { go back a day to make sure no messages are missed }
                       SL.Add('StartTime>=' + FormatDateTime('yyyy-mm-dd',qry.FieldByName('LastDate').AsDateTime -2));
                     qry.Close;
                     callList:= api.GetCallList(SL);
                     try
                       while not callList.EOF do begin

                         if Terminated then begin
                           Log(ClassName + ' terminated, aborting SMS check.',ltDetail);
                           exit;
                         end;

                         if (not SameText(callList.Data.S['direction'], 'inbound'))then begin
                           callList.Next;
                           continue;
                         end;

                         qry.Close;
                         qry.SQL.Text := 'select * from tblreference where Ref_Type = "Voice" and MessageID = ' + QuotedStr(callList.Data.S['sid']);
                         qry.Open;
                         if qry.IsEmpty then begin
                           smsMsg.Clear;
                           qry.Insert;

                           smsMsg.TimeLocal := UTCToLocal(TTwilioApi.StrToUTC(callList.Data.S['date_created']));
                           smsMsg.uid := callList.Data.S['sid'];
                           qry.FieldByName('Ref_Type').AsString := 'Voice';
                           qry.FieldByName('Ref_Date').AsDateTime := smsMsg.TimeLocal;
                           qry.FieldByName('Referencetxt').AsString := 'Voice call';
                           qry.FieldByName('MessageId').AsString := smsMsg.uid;
                           qry.FieldByName('Status').AsString := callList.Data.S['status'];
                           if callList.Data.Exists('price') and (not callList.Data.ItemByName['price'].Value.IsTypeNull) then
                             qry.FieldByName('Cost').AsFloat := api.Config.PriceIn(callList.Data.ItemByName['price'].Value.AsFloat)
                           else
                             qry.FieldByName('Cost').AsFloat := 0;
                           qry.FieldByName('CurrencyCode').AsString := callList.Data.S['price_unit'];

                           smsMsg.Status := 'Received';
                           smsMsg.Content := 'Voice call';
                           smsMsg.Format := 'Voice';
                           smsMsg.ReceiptId := callList.Data.S['sid'];
                           smsMsg.PhoneNumber := callList.Data.S['from'];

                           qry.FieldByName('MessageFrom').AsString := smsMsg.PhoneNumber;
                           stream:= qry.CreateBlobStream(qry.FieldByName('ReferenceData'),bmWrite);
                           try
                             smsMsg.SaveToStream(stream);
                           finally
                             stream.Free;
                           end;
                           if SMSUtils.PhoneNoToEntity(smsMsg.PhoneNumber, ContactID, CustomerId, SupplierId, EmployeeId, MarketingContactId, dbList.Connection) then begin
                             if ContactId > 0 then qry.FieldByName('ContactId').AsInteger := ContactId;
                             if CustomerId > 0 then qry.FieldByName('CusId').AsInteger := CustomerId;
                             if SupplierId > 0 then qry.FieldByName('SupId').AsInteger := SupplierId;
                             if EmployeeId > 0 then qry.FieldByName('EmployeeId').AsInteger := EmployeeId;
                             if MarketingContactId > 0 then qry.FieldByName('MarketingContactId').AsInteger := MarketingContactId;
                           end;

                           qry.Post;

                           qry.Edit;
                             qry.FieldByName('GlobalRef').AsString := dbList.SiteCode + IntToStr(qry.FieldByName('RefID').AsInteger);
                             qry.FieldByName('msUpdateSiteCode').AsString := dbList.SiteCode;
                           qry.Post;
                         end;

                         { check for recordings }
                         recordingList := callList.Recordings;
                         if Assigned(recordingList) then begin
                           while not recordingList.EOF do begin
                             qry2.Close;
                             qry2.SQL.Text := 'select * from tblVoiceMessage where MessageID = ' + QuotedStr(recordingList.Data.S['sid']);
                             qry2.Open;
                             if qry2.IsEmpty then begin
                               qry2.Insert;

                               qry2.FieldByName('MessageId').AsString := recordingList.Data.S['sid'];
                               qry2.FieldByName('CallMessageId').AsString := recordingList.Data.S['call_sid'];
                               qry2.FieldByName('DateCreated').AsDateTime := UTCToLocal(TTwilioApi.StrToUTC(recordingList.Data.S['date_created']));

                               stream:= qry2.CreateBlobStream(qry2.FieldByName('Data'),bmWrite);
                               try
                                 api.GetRecordingMP3(recordingList.Data.S['sid'],stream);
                               finally
                                 stream.Free;
                               end;
                               qry2.Post;

                               qry2.Edit;
                                 qry2.FieldByName('GlobalRef').AsString := dbList.SiteCode + IntToStr(qry2.FieldByName('ID').AsInteger);
                                 qry2.FieldByName('msUpdateSiteCode').AsString := dbList.SiteCode;
                               qry2.Post;
                               api.DeleteRecording(recordingList.Data.S['sid']);
                             end;
                             recordingList.Next;
                           end;
                         end;
                         callList.Next;
                       end;
                     finally
                       callList.Free;
                     end;
                   finally
                     SL.Free;
                     qry.Close;
                   end;

                 end;


               end;
               qry.Close;

             finally
               TSharedAppUserList.ExRemoveUser(ERP_ADMIN_USER+'_SMS_Check', MySQLServer, dbList.Connection.Database);
             end;

           end;
         until not dbList.Next;
       finally
         qry.Free;
         qry2.Free;
       end;
     end;
    finally
//      sms.Free;
      api.Free;
      dbList.Free;
      smsMsg.Free;
      SMSConfig.Free;
      json.Free;
      Log('Finished SMS check.',ltDetail);
//      self.StatusMessage := '';
    end;
  except
    on e: exception do begin
      Log('Error checking SMS: ' + e.Message,ltError);
    end;
  end;
end;

end.
