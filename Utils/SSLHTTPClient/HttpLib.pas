unit HttpLib;

interface
(*const
  sha256RSA = 'sha256RSA';
function SHA256String:ansistring;*)

implementation


{function SHA256String: Ansistring;
begin
  result:= 'ECDHE-RSA-AES128-GCM-SHA256:'+
          'ECDHE-RSA-AES256-GCM-SHA384:'+
          'ECDHE-RSA-AES128-SHA256:'+
          'ECDHE-RSA-AES256-SHA384:'+
          'ECDHE-RSA-RC4-SHA:'+
          'ECDHE-RSA-AES128-SHA:'+
          'ECDHE-RSA-AES256-SHA:'+
          'ECDHE-RSA-DES-CBC3-SHA:'+
          'AES128-GCM-SHA256:'+
          'AES256-GCM-SHA384:'+
          'AES128-SHA256:'+
          'AES256-SHA256:'+
          'RC4-SHA:'+
          'AES128-SHA:'+
          'AES256-SHA:'+
          'DES-CBC3-SHA';
(*var
  st:TStringlist;
begin
  IdSSLOpenSSL.LoadOpenSSLLibrary;
  with TIdHashSHA256.Create do
    try
      st:= TStringlist.Create ;
      try
        st.loadFromfile('C:\Dev\ERP\Utils\ERPUtilsServer\EXE\VS1Cloud_IIS\6b0551171f77554b.pem');
        //Result := LowerCase( HashStringAsHex(sha256RSA) );
        //Result := LowerCase( HashStringAsHex(st.Text) );
        Result := LowerCase( HashStringAsHex(sha256RSA) );
      finally
        Freeandnil(st);
      end;
    finally
      Free;
    end;
  IdSSLOpenSSL.UnLoadOpenSSLLibrary;*)
end;}
end.
