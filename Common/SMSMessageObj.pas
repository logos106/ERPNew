unit SMSMessageObj;

interface

uses
  JsonObject;

type

  TSMSMessage = class(TJsonObject)
  private
    function GetContent: string;
    function GetFormat: string;
    function GetInfo: string;
    function GetPhoneNumber: string;
    function GetReceiptId: string;
    function GetStatus: string;
    function GetTimeLocal: TDateTime;
    function Getuid: string;
    procedure SetContent(const Value: string);
    procedure SetFormat(const Value: string);
    procedure SetInfo(const Value: string);
    procedure SetPhoneNumber(const Value: string);
    procedure SetReceiptId(const Value: string);
    procedure SetStatus(const Value: string);
    procedure SetTimeLocal(const Value: TDateTime);
    procedure Setuid(const Value: string);
    function GetAsHtml: string;
  public
    property uid: string read Getuid write Setuid;
    property Content: string read GetContent write SetContent;
    property Format: string read GetFormat write SetFormat; { SMS or voice }
    property ReceiptId: string read GetReceiptId write SetReceiptId;
    property PhoneNumber: string read GetPhoneNumber write SetPhoneNumber;
    property TimeLocal: TDateTime read GetTimeLocal write SetTimeLocal;
    property Status: string read GetStatus write SetStatus; { Waiting, Sent, Send Failed, Received, Receive Fail }
    property Info: string read GetInfo write SetInfo;  { eg. error message }
    property AsHtml: string read GetAsHtml;
  end;


implementation

uses
  SysUtils;

{ TSMSMessage }

function TSMSMessage.GetAsHtml: string;

  function LocalTime: string;
  begin
    if Self.TimeLocal > 0 then
      result := DateTimeToStr(Self.TimeLocal)
    else
      result := '';
  end;

begin
  result:=
    '<html>' +
      '<head>' +
        '<style>' +
          'body {' +
            'font-family: Arial, "Helvetica Neue", Helvetica, sans-serif;' +
            'font-size:9px;' +
          '}' +
        '</style>' +
      '</head>' +
      '<body>' +

        '<table width="100%">' +
          '<tr>' +
            '<td>' +
              '<table>' +
                '<col width="70">' +
                '<col width="180">' +
                '<col width="70">' +
                '<col width="180">' +
                '<col width="70">' +
                '<col width="180">';
                if SameText(Format,'Voice') then
                  result := result + '<col width="180">';
                result := result +
                '<tr>' +
                  '<td style="font-weight:bold;">Time:</td><td>'+LocalTime+'</td>' +
                  '<td style="font-weight:bold;">Number:</td><td>'+Self.PhoneNumber+'</td>' +
                  '<td style="font-weight:bold;">Status:</td><td>'+Self.Status+'</td>';
                  if SameText(Format,'Voice') then
                    result := result +
                     '<td style="font-weight:bold;"><a href="' + uid + '">Play Message</a></td>';
                  result := result +
                '</tr>' +
              '</table>' +
            '</td>' +
          '</tr>' +
          '<tr>' +
            '<td>' +
              '<table>' +

                '<tr>' +
                  '<td style="font-weight:bold;">Message:</td>'+
                  '<td>' + Self.Content + '</td>'+
                '</tr>';

                if Self.Info <> '' then
                  result:= result +
                  '<tr>' +
                    '<td style="font-weight:bold;">Info:</td>'+
                    '<td>' + Self.Info + '</td>'+
                  '</tr>';

                result := result +

              '</table>' +
            '</td>' +
          '</tr>' +
        '</table>' +

      '</body>'+
    '</html>';

end;

function TSMSMessage.GetContent: string;
begin
  result := S['Content'];
end;

function TSMSMessage.GetFormat: string;
begin
  result := S['Format'];
end;

function TSMSMessage.GetInfo: string;
begin
  result := S['Info'];
end;

function TSMSMessage.GetPhoneNumber: string;
begin
  result := S['PhoneNumber'];
end;

function TSMSMessage.GetReceiptId: string;
begin
  result := S['ReceiptId'];
end;

function TSMSMessage.GetStatus: string;
begin
  result := S['Status'];
end;

function TSMSMessage.GetTimeLocal: TDateTime;
begin
  result := DT['TimeLocal'];
end;

function TSMSMessage.Getuid: string;
begin
  result := S['uid'];
end;

procedure TSMSMessage.SetContent(const Value: string);
begin
  S['Content'] := Value;
end;

procedure TSMSMessage.SetFormat(const Value: string);
begin
  S['Format'] := Value;
end;

procedure TSMSMessage.SetInfo(const Value: string);
begin
  S['Info'] := Value;
end;

procedure TSMSMessage.SetPhoneNumber(const Value: string);
begin
  S['PhoneNumber'] := Value;
end;

procedure TSMSMessage.SetReceiptId(const Value: string);
begin
  S['ReceiptId'] := Value;
end;

procedure TSMSMessage.SetStatus(const Value: string);
begin
  S['Status'] := Value;
end;

procedure TSMSMessage.SetTimeLocal(const Value: TDateTime);
begin
  DT['TimeLocal'] := Value;
end;

procedure TSMSMessage.Setuid(const Value: string);
begin
  S['uid'] := Value;
end;

end.
