unit WebUtils;

interface

  function WhatsMyIP: string;

implementation

uses
  IdHttp, sysutils, HTTPConst;
// 'www.whatismyip.com/automation/n09230945.asp'

function WhatsMyIP: string;
var
  client: TIdHTTP;
begin
  result:= '';
  client := TIdHTTP.Create(nil);
  try
    client.Request.UserAgent := HTTPConst.TrueERPUserAgent;
    try
      result := client.Get('http://www.trueerp.com/whatsmyip.php');
    except

    end;
    result := Trim(result);
  finally
    client.Free;
  end;
end;

end.
