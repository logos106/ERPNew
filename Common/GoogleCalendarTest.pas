unit GoogleCalendarTest;

interface

  function TestGoogleCalendar(emailAddress: string; var Auth: string; var RefreshToken: string): boolean;

implementation

uses
  sysutils, Vista_MessageDlg, dialogs, ibgGCalendar, GoogleAuth;

function CheckGoogleEmailFormat(email: string): boolean;
begin
  result := true;
  if Trim(email) = '' then begin
    result := false;
    Vista_MessageDlg.MessageDlgXP_Vista('The Google Email Address is blank',mtInformation,[mbOk],0);
    exit;
  end;
  if Pos('@',email) = 0 then result := false
  else if Pos('.',email) = 0 then result := false;
  if not result then
    Vista_MessageDlg.MessageDlgXP_Vista('The Google Email Address format is not correct, this should be somthing like yourName@gmail.com',mtInformation,[mbOk],0);
end;



function TestGoogleCalendar(emailAddress: string; var Auth: string; var RefreshToken: string): boolean;
var
  IsAuthOk: boolean;

  function EmailExists(var authOk: boolean): boolean;
  var
    cal: TibgGCalendar;
    x: integer;
    found : boolean;
  begin
    result := true;
    authOk := true;
    cal := TibgGCalendar.Create(nil);
    try
      cal.Authorization := Auth;
      try
        cal.ListCalendars;
      except
        on e: exception do begin
          result := false;
          authOk := false;
          exit;
//          if Pos('Invalid Credentials',e.Message) > 0 then begin
//            authOk := false;
//          end;
        end;
      end;

      found := false;
      for x := 0 to cal.CalendarCount -1 do begin
        cal.CalendarIndex := x;
        if SameText(cal.CalendarID, emailAddress) then begin
          found := true;
          break;
        end;
      end;
      if not found then
        result := false;
    finally
      cal.Free;
    end;
  end;

begin
  result := false;
  if not CheckGoogleEmailFormat(emailAddress) then exit;
  if Auth <> '' then begin
    if not EmailExists(IsAuthOk) then begin
      if not IsAuthOk then begin
        if RefreshToken <> '' then begin
          Auth := GetAuthorization(RefreshToken);
          if Auth <> '' then begin
            if not EmailExists(IsAuthOk) then begin
              if not (IsAuthOk) then begin
                Vista_MessageDlg.MessageDlgXP_Vista('Google authorization of this account failed.',mtWarning,[mbOk],0);
                exit;
              end
              else begin
                Vista_MessageDlg.MessageDlgXP_Vista('The email address provided (' + emailAddress + ') does not belong to the Google account that was authorized.',mtWarning,[mbOk],0);
                exit;
              end;
            end;
          end;
        end
        else begin
          { we don't have a refresh token }
          Vista_MessageDlg.MessageDlgXP_Vista('An Internet Window will now be Opened so that Your Google Account can be Authorized.',mtInformation,[mbOk],0);
          Auth := '';
          Auth := GetAuthorization(RefreshToken);
          if Auth <> '' then begin
            if not EmailExists(IsAuthOk) then begin
              if not IsAuthOk then
                Vista_MessageDlg.MessageDlgXP_Vista('Google authorization of this account failed.',mtWarning,[mbOk],0)
              else
                Vista_MessageDlg.MessageDlgXP_Vista('The email address provided (' + emailAddress + ') does not belong to the Google account that was Authorized.',mtWarning,[mbOk],0);
              exit;
            end
            else begin
              { ok }
//              Vista_MessageDlg.MessageDlgXP_Vista('Google Authorization / connection is OK.',mtWarning,[mbOk],0)
            end;
          end
          else begin
            Vista_MessageDlg.MessageDlgXP_Vista('Google authorization of this account failed.',mtWarning,[mbOk],0);
            exit;
          end;
        end;

      end
      else begin
        { auth was ok }
//        Vista_MessageDlg.MessageDlgXP_Vista('Google Authorization / connection is OK.',mtWarning,[mbOk],0)
      end;

    end;
  end
  else begin
    { we dont have auth yet }
    Vista_MessageDlg.MessageDlgXP_Vista('An Internet Window will now be Opened so that Your Google Account can be Authorized.',mtInformation,[mbOk],0);
    RefreshToken := '';
    Auth := GetAuthorization(RefreshToken);
    if Auth <> '' then begin
      if not EmailExists(IsAuthOk) then begin
        if not IsAuthOk then
          Vista_MessageDlg.MessageDlgXP_Vista('Google authorization of this account failed.',mtWarning,[mbOk],0)
        else
          Vista_MessageDlg.MessageDlgXP_Vista('The email address provided (' + emailAddress + ') does not belong to the Google account that was Authorized.',mtWarning,[mbOk],0);
        exit;
      end
      else begin
        { ok }
//        Vista_MessageDlg.MessageDlgXP_Vista('Google Authorization / connection is OK.',mtWarning,[mbOk],0)
      end;
    end
    else begin
      Vista_MessageDlg.MessageDlgXP_Vista('Google authorization of this account failed.',mtWarning,[mbOk],0);
      exit;
    end;
  end;
  Vista_MessageDlg.MessageDlgXP_Vista('Google authorization / connection is OK.',mtWarning,[mbOk],0);;
  result := true;
end;


end.
