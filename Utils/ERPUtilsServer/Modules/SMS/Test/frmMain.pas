unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfmMain = class(TForm)
    Button1: TButton;
    memLog: TMemo;
    Button2: TButton;
    edtTo: TEdit;
    edtMsg: TEdit;
    rgType: TRadioGroup;
    Button3: TButton;
    chkConfirm: TCheckBox;
    rgService: TRadioGroup;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

uses
  IdHTTP, XMLDoc, XMLIntf, IdURI, URILib, SMSMessageMediaObj, SMSObj,
  JsonObject, IdSSLOpenSSL, DateTimeUtils;

const
  Twilio_Account_SID = 'ACd86ec0a0dd42ad5c77aa3d1dc6706b9c';
  Twilio_Token = '18459f4a621799a444eb4c63c1e6ff07';
  Twilio_URL = 'https://api.twilio.com/';
  Twilio_Ver = '2010-04-01';
  Twilio_Number = '+12134555661';

{$R *.dfm}

procedure TfmMain.Button1Click(Sender: TObject);
var
  messageType: TSMSMessageType;
  sms: TSMSMsgMed;
  msg: string;
  Client: TIdHttp;
  obj: TJsonObject;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  stream: TStringStream;
  sl: TStringList;
begin
  if rgService.ItemIndex = 0 then begin
    if rgType.ItemIndex = 1 then messageType := mtVoice
    else messageType := mtSMS;
    sms:= TSMSMsgMed.Create;
    try
      sms.AccountUser := 'trueerp001';
      sms.AccountPassword := 'ib14789';
      if sms.SendMessage(edtTo.Text,edtMsg.Text,msg,messageType) then
        memLog.Lines.Add('Message sent Ok')
      else
        memLog.Lines.Add('Error: ' + msg);
    finally
      sms.Free;
    end;
  end
  else if rgService.ItemIndex = 1 then begin
    Client := TIdHttp.Create(nil);
    Client.Request.UserAgent := HTTPConst.TrueERPUserAgent;
    obj := JO;
    stream := TStringStream.Create;
    sl := TStringList.Create;
    try
      SSLHandler:= TIdSSLIOHandlerSocketOpenSSL.Create(client);
      client.IOHandler:= SSLHandler;
      client.Request.BasicAuthentication:= true;
      Client.Request.Username:= Twilio_Account_SID;
      Client.Request.Password:= Twilio_Token;
      Client.Request.ContentType := 'application/x-www-form-urlencoded';

      stream.WriteString('From=' + PercentEncode(Twilio_Number));
      stream.WriteString('&To=' + PercentEncode(edtTo.Text));
      stream.WriteString('&Body=' + PercentEncode(edtMsg.Text));

//      Client.Request.CustomHeaders.AddValue('Body',PercentEncode(edtMsg.Text));
//      Client.Request.CustomHeaders.AddValue('To',PercentEncode(edtTo.Text));
//      Client.Request.CustomHeaders.AddValue('From',PercentEncode(Twilio_Number));



//      obj.S['account_sid'] := Twilio_Account_SID;
//      obj.S['api_version'] := '2010-04-01';
//      obj.S['body'] := edtMsg.Text;
//      obj.S['num_segments'] := '1';
//      obj.S['num_media'] := '1';
//      obj.S['date_created'] := FormatDateTime('ddd, dd mmm yyyy hh:nn:ss +0000', NowUTC);
//      obj.Add('date_sent',valNull);
//      obj.S['date_updated'] := FormatDateTime('ddd, dd mmm yyyy hh:nn:ss +0000', NowUTC);
//      obj.S['direction'] := 'outbound-api';
//      obj.S['from'] := Twilio_Number;
//      obj.Add('price',valNull);
//      obj.S['sid'] := Twilio_Token;
//      obj.S['status'] := 'queued';
//      obj.S['to'] := edtTo.Text;
//      obj.S['uri'] := '/2010-04-01/Accounts/' + Twilio_Account_SID + '/Messages/' + Twilio_Token + '.json';
//      obj.SaveToStream(stream);
      stream.Position := 0;
      try
        msg := Client.Post(Twilio_URL + Twilio_Ver +'/Accounts/' + Twilio_Account_SID + '/Messages.json', stream);
      except
        on e: exception do begin
          memLog.Lines.Add(e.Message);
          exit;
        end;
      end;
      obj.AsString := msg;
      memLog.Lines.Add(obj.AsString);
    finally
      Client.Free;
      JO.Free;
      stream.Free;
      sl.Free;
      obj.Free;
    end;

  end;
end;

procedure TfmMain.Button2Click(Sender: TObject);
var
  sms: TSMSMsgMed;
  msg, ac: string;
begin
  sms:= TSMSMsgMed.Create;
  try
    sms.AccountUser := 'trueerp001';
    sms.AccountPassword := 'ib14789';
    if sms.CheckUser(msg,ac) then
      memLog.Lines.Add(ac)
    else
      memLog.Lines.Add(msg);
  finally
    sms.Free;
  end;
end;

procedure TfmMain.Button3Click(Sender: TObject);
var
  sms: TSMSMsgMed;
  msg: string;
  Client: TIdHttp;
  obj, obj2, info: TJsonObject;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  stream: TStringStream;
  fileStream: TFileStream;
  I, x: integer;
  s: string;
begin
  if rgService.ItemIndex = 0 then begin
    sms:= TSMSMsgMed.Create;
    info := JO;
    try
      sms.AccountUser := 'trueerp001';
      sms.AccountPassword := 'ib14789';
      if sms.CheckReplies(msg,info,100,chkConfirm.Checked) then
        memLog.Lines.Add(info.AsString)
      else
        memLog.Lines.Add(msg);
    finally
      sms.Free;
      info.Free;
    end;
  end
  else if rgService.ItemIndex = 1 then begin
    Client := TIdHttp.Create(nil);
    Client.Request.UserAgent := HTTPConst.TrueERPUserAgent;
    stream := TStringStream.Create;
    obj := JO;
    obj2 := JO;
    try
      SSLHandler:= TIdSSLIOHandlerSocketOpenSSL.Create(client);
      client.IOHandler:= SSLHandler;
      client.Request.BasicAuthentication:= true;
      Client.Request.Username:= Twilio_Account_SID;
      Client.Request.Password:= Twilio_Token;
      Client.Request.ContentType := 'application/json'; //x-www-form-urlencoded';

//      stream.WriteString('To=' + PercentEncode(Twilio_Number));

      stream.Position := 0;
      if rgType.ItemIndex = 0 then begin{sms}
        memLog.Lines.Add('SMS Messages:');
        Client.Get(Twilio_URL + Twilio_Ver +'/Accounts/' + Twilio_Account_SID + '/SMS/Messages.json?To='+ Twilio_Number, stream);
      end
      else begin
        memLog.Lines.Add('Calls:');
        Client.Get(Twilio_URL + Twilio_Ver +'/Accounts/' + Twilio_Account_SID + '/Calls.json', stream);
      end;
      stream.Position := 0;
      obj.ReadFromStream(stream);
      memLog.Lines.Add(obj.AsString);





      if rgType.ItemIndex = 1 then begin{ calls }
        for x := 0 to obj.A['calls'].Count -1 do begin
          s:= Client.Get(Twilio_URL + obj.A['calls'].Items[x].AsObject.O['subresource_uris'].S['recordings']);
          obj2.AsString:= s;
          memLog.Lines.Add(obj2.AsString);



        end;
//        memLog.Lines.Add('Recordings:');
//        stream.Clear;
//        Client.Get(Twilio_URL + '/Accounts/' + Twilio_Account_SID + '/Recordings.json', stream);
//        stream.Position := 0;
//        obj.ReadFromStream(stream);
//        memLog.Lines.Add(obj.AsString);
//        for I := 0 to obj.A['recordings'].Count -1 do begin
//          //stream.Clear;
//          fileStream := TFileStream.Create('c:\temp\' + obj.A['recordings'].Items[I].AsObject.S['sid'] + '.mp3',fmCreate);
//          try
//            memLog.Lines.Add('Downloading audio');
//            Client.Get(Twilio_URL + '/Accounts/' + Twilio_Account_SID + '/Recordings/' +obj.A['recordings'].Items[I].AsObject.S['sid']+'.mp3', fileStream);
//            //stream.Position := 0;
//            //obj2.ReadFromStream(stream);
//            //memLog.Lines.Add(obj2.AsString);
//            //memLog.Lines.Add(stream.DataString);
//            //memLog.Lines.Add('');
//          finally
//            fileStream.Free;
//          end;
//        end;



      end;

    finally
      Client.Free;
      Stream.Free;
      obj.Free;
      obj2.free;
    end;

  end;
end;

end.
