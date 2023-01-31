unit SMSMessageMediaObj;

interface

uses
  SMSObj, XMLDoc, XMLIntf, IdHttp, JsonObject;

type
  TSMSMsgMed = class(TSMS)
  private
    function CreateMessageDoc(aMessageType: string): IXMLDocument;
    function DoRequest(XMLOut,XMLIn: IXMLDocument; var msg: string): boolean;
    function GetResponseNode(Doc: IXMLDocument; aPath: string; var msg: string): IXMLNode;
    function GetRequestNode(Doc: IXMLDocument; aPath: string): IXMLNode;
  public
    constructor Create;
    destructor Destroy; override;
    function CheckUser(var msg, UserInfo: string): boolean; override;
    function SendMessage(Recipient, TextMessage: string; var msg: string; MessageType: TSMSMessageType = mtSMS;
      RecipientID: integer = 0; MessageID: integer = 0; UTCScheduled: TDateTime = 0): boolean; override;
    function CheckReplies(var msg: string; var ReplyInfo: TJsonObject; MaxReplies: integer = 100; Confirm: boolean = false): boolean; override;
    function ConfirmReplies(ReceiptIdList: string; var msg: string): boolean; override;
  end;

implementation

uses
  SysUtils, MessageMediaConst, Classes, URILib, Variants,
  DateTimeUtils, HTTPConst;

{ TSMSMsgMed }

function TSMSMsgMed.CheckReplies(var msg: string; var ReplyInfo: TJsonObject; MaxReplies: integer = 100; Confirm: boolean = false): boolean;
var
  XMLOut, XMLIn: IXMLDocument;
  node, sub: IXMLNode;
  obj: TJsonObject;
  x: integer;
  sl: TStringList;

  function NodeAsStr(aNode: IXMLNode): string;
  begin
    if not VarIsNull(aNode.NodeValue) then
      result := aNode.NodeValue
    else
      result := '';
  end;

begin
  msg:= '';
  if not Assigned(ReplyInfo) then
    ReplyInfo := JO
  else
    ReplyInfo.Clear;

  XMLOut := CreateMessageDoc('checkReplies');
  XMLIn := TXMLDocument.Create(nil);
//  XMLIn.Options := XMLIn.Options - [doAttrNull];
  sl := TStringList.Create;
  try
    node := self.GetRequestNode(XMLOut,'checkReplies.requestBody.maximumReplies');
    node.NodeValue := IntToStr(MaxReplies);
    result := DoRequest(XMLOut, XMLIn, msg);
    if result then begin
      node := GetResponseNode(XMLIn,'checkRepliesResponse.result',msg);
      if Assigned(node) then begin
        if node.Attributes['returned'] > '0' then begin
          ReplyInfo.I['returned'] := node.Attributes['returned'];
          ReplyInfo.I['remaining'] := node.Attributes['remaining'];
          node:= GetResponseNode(XMLIn,'checkRepliesResponse.result.replies',msg);
          if Assigned(node) then begin
            for x:= 0 to node.ChildNodes.Count -1 do begin
              obj := JO;
              sub := node.ChildNodes.Nodes[x];
              obj.S['Format'] := sub.Attributes['format'];
              obj.I['uid'] := sub.Attributes['uid'];
              obj.S['ReceiptId'] := sub.Attributes['receiptId'];
              sl.Add(sub.Attributes['receiptId']);
              obj.S['PhoneNumber'] := NodeAsStr(sub.ChildNodes['origin']);
              //obj.S['received'] := NodeAsStr(sub.ChildNodes['received']);
              obj.DT['TimeLocal'] := ISO8601ToDateTime(NodeAsStr(sub.ChildNodes['received']));
              obj.S['Content'] := NodeAsStr(sub.ChildNodes['content']);
              ReplyInfo.A['replies'].Add(obj);
            end;
            if Confirm then begin
              result := self.ConfirmReplies(sl.CommaText,msg);
            end;
          end
          else
            exit;
        end;
      end;
    end;
  finally
    XMLIn := nil;
    XMLOut := nil;
    sl.Free;
  end;
end;

function TSMSMsgMed.CheckUser(var msg, UserInfo: string): boolean;
var
  XMLOut, XMLIn: IXMLDocument;
  node: IXMLNode;
begin
  msg:= '';
  UserInfo:= '';
  XMLOut := CreateMessageDoc('checkUser');
  XMLIn := TXMLDocument.Create(nil);
  XMLIn.Options := XMLIn.Options - [doAttrNull]; { will add attribute if not found }
  try
    result := DoRequest(XMLOut, XMLIn, msg);
    if result then begin
      node := GetResponseNode(XMLIn,'checkUserResponse.result.accountDetails',msg);
      if Assigned(node) then begin
        with TJsonObject.Create do begin
          S['type'] := node.Attributes['type'];
          S['creditLimit'] := node.Attributes['creditLimit'];
          S['creditRemaining'] := node.Attributes['creditRemaining'];
          UserInfo := AsString;
          Free;
        end;
      end;
    end;
  finally
    XMLIn := nil;
    XMLOut := nil;
  end;
end;

function TSMSMsgMed.ConfirmReplies(ReceiptIdList: string;
  var msg: string): boolean;
var
  XMLOut, XMLIn: IXMLDocument;
  node: IXMLNode;
  sl: TStringList;
  x: integer;
begin
  msg:= '';
  XMLOut := CreateMessageDoc('confirmReplies');
  XMLIn := TXMLDocument.Create(nil);
  XMLIn.Options := XMLIn.Options - [doAttrNull]; { will add attribute if not found }
  sl := TStringList.Create;
  try
    sl.CommaText := ReceiptIdList;
    node := self.GetRequestNode(XMLOut,'confirmReplies.requestBody.replies');
    for x := 0 to sl.Count -1 do
      node.AddChild('reply').Attributes['receiptId'] := sl[x];
    result := DoRequest(XMLOut, XMLIn, msg);
    if result then begin
      node := GetResponseNode(XMLIn,'confirmRepliesResponse.result',msg);
      if Assigned(node) then begin

      end;
    end;
  finally
    XMLIn := nil;
    XMLOut := nil;
    sl.Free;
  end;
end;

constructor TSMSMsgMed.Create;
begin
  inherited Create;
end;

function TSMSMsgMed.CreateMessageDoc(aMessageType: string): IXMLDocument;
var
  node, authNode: IXMLNode;
begin
  result:= TXMLDocument.Create(nil);
  result.Active := true;
//  result.Options := result.Options + [doNodeAutoIndent];
  result.Version := '1.0';
  result.Encoding := 'utf-8';
  node := result.AddChild(aMessageType,XMLNameSpace);
  authNode := node.AddChild('authentication');
  authNode.AddChild('userId').NodeValue := self.AccountUser;
  authNode.AddChild('password').NodeValue := self.AccountPassword;
end;

destructor TSMSMsgMed.Destroy;
begin
//  XMLDoc := nil;
  inherited;
end;

function TSMSMsgMed.DoRequest(XMLOut, XMLIn: IXMLDocument;
  var msg: string): boolean;
var
  s, XMLStr: string;
  stream: TStringStream;
  Client: TIdHttp;
  faultNode, errorNode: IXMLNode;
  errorCode: string;
begin
  result:= true;
  msg := '';
  stream := TStringStream.Create;
  Client := TIdHttp.Create(nil);
  try
    Client.Request.UserAgent := HTTPConst.TrueERPUserAgent;
    XMLOut.SaveToXML(XMLStr);
    stream.WriteString('XMLDATA=' + URILib.URLEncode(XMLStr));
    stream.Position := 0;
    Client.Request.ContentType := RequestContentType;
    try
      s:= Client.Post('http://'+APIURL,stream);
      if s <> '' then begin
        try
          XMLIn.LoadFromXML(s);
          faultNode := XMLIn.ChildNodes.FindNode('faultResponse');
          if Assigned(faultNode) then begin
            result := false;
            errorNode := faultNode.ChildNodes.FindNode('error');
            if Assigned(errorNode) then begin
              errorCode := errorNode.Attributes['code'];
              if SameText(errorCode,'authenticationFailed') then
                msg:= 'Authentication failed.'
              else if SameText(errorCode,'invalidDataFormat') then
                msg:= 'Invalid data format.'
              else if SameText(errorCode,'perDayMessageLimit') then
                msg:= 'Not enough daily message credits to fulfill the Send.'
              else if SameText(errorCode,'') then
                msg:= 'Empty message code returned from server.'
              else
                msg:= 'Unknown message code returned from server: "' + errorCode + '"';
            end
            else begin
              msg := 'Unknown error, no error information returned from server.';
            end;
          end;
        except
          on e: Exception do begin
            result:= false;
            msg := 'Error reading XML document returned from server: ' + e.Message;
          end;
        end;
      end
      else begin
        result:= false;
        msg := 'No responce received from server.';
      end;
    except
      on e: Exception do begin
        result:= false;
        msg:= e.Message;
      end;
    end;
  finally
    stream.Free;
    Client.Free;
  end;
end;

function TSMSMsgMed.GetRequestNode(Doc: IXMLDocument; aPath: string): IXMLNode;
var
  sl: TStringList;
  x: integer;
  node, subNode: IXMLNode;
begin
  node:= nil;
  sl := TStringList.Create;
  try
    sl.Delimiter := '.';
    sl.DelimitedText := aPath;
    for x:= 0 to sl.Count -1 do begin
      if x = 0 then begin
        node := Doc.ChildNodes.FindNode(sl[x]);
        if not Assigned(node) then begin
          node := Doc.AddChild(sl[x]);
        end;
      end
      else begin
        subNode := node.ChildNodes.FindNode(sl[x]);
        if not Assigned(subNode) then
          subNode := Node.AddChild(sl[x]);
        node := subNode
      end;
    end;
  finally
    sl.Free;
  end;
  if Assigned(node) then
    result := node;
end;

function TSMSMsgMed.GetResponseNode(Doc: IXMLDocument; aPath: string; var msg: string): IXMLNode;
var
  sl: TStringList;
  x: integer;
  node: IXMLNode;
begin
  node:= nil;
  sl := TStringList.Create;
  try
    sl.Delimiter := '.';
    sl.DelimitedText := aPath;
    for x:= 0 to sl.Count -1 do begin
      if x = 0 then node := Doc.ChildNodes.FindNode(sl[x])
      else node := node.ChildNodes.FindNode(sl[x]);
      if not Assigned(node) then begin
        result:= nil;
        msg := 'Element "' + sl[x] + '" not found in responce XML document.';
        exit;
      end;
    end;
  finally
    sl.Free;
  end;
  if Assigned(node) then
    result := node;
end;

function TSMSMsgMed.SendMessage(Recipient, TextMessage: string; var msg: string;
  MessageType: TSMSMessageType; RecipientID, MessageID: integer;
  UTCScheduled: TDateTime): boolean;
var
  XMLOut, XMLIn: IXMLDocument;
  node: IXMLNode;
begin
  msg:= '';
  XMLOut := CreateMessageDoc('sendMessages');
  XMLIn := TXMLDocument.Create(nil);
  XMLIn.Options := XMLIn.Options - [doAttrNull]; { will add attribute if not found }
  try
    node := GetRequestNode(XMLOut,'sendMessages.requestBody.messages.message');
    if MessageType = mtSMS then node.Attributes['format'] := 'SMS'
    else if MessageType = mtVoice then node.Attributes['format'] := 'voice';
    if MessageID > 0 then node.Attributes['sequenceNumber'] := IntToStr(MessageId);
    node := GetRequestNode(XMLOut,'sendMessages.requestBody.messages.message.recipients.recipient');
    if RecipientId > 0 then node.Attributes['uid'] := IntToStr(MessageID);
    node.NodeValue := Recipient;
    node := GetRequestNode(XMLOut,'sendMessages.requestBody.messages.message.content');
    node.NodeValue := TextMessage;
    if UTCScheduled > 0 then begin
      node := GetRequestNode(XMLOut,'sendMessages.requestBody.messages.message.scheduled');
      node.NodeValue := FormatDateTime('yyyy-mm-dd',UTCScheduled) + 'T' + FormatDateTime('hh:nn:ss',UTCScheduled) + 'z';
    end;
    result := DoRequest(XMLOut, XMLIn, msg);
    if result then begin
      node := GetResponseNode(XMLIn,'sendMessagesResponse.result',msg);
      if Assigned(node) then begin
        if node.Attributes['failed'] <> '0' then begin
          result:= false;
          msg := 'Message send failed.';
          { check to see if problem is credit }
          node:= GetResponseNode(XMLIn,'sendMessagesResponse.result.accountDetails',msg);
          if Assigned(node) then begin
            if node.Attributes['creditRemaining'] = '0' then
              msg:= msg + ' Zero credit remaining.';
          end;
        end;
      end;
    end;
  finally
    XMLIn := nil;
    XMLOut := nil;
  end;
end;

end.
