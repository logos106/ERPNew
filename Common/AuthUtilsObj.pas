unit AuthUtilsObj;

interface

type
  TAuthUtils = class
    class function AuthSystemKey: string;
    class function AuthSystemValue: string;

    class function AuthLicenceKey: string;
    class function AuthLicenceValue: string;
  end;


implementation

const
  Auth_System_Key = 'SystemAuth';
  Auth_System_Value = '{38E3939E-030A-4DA3-92FF-DCE234F22534}';

  Auth_Licence_Key = 'LicenceAuth';
  Auth_Licence_Value = '{332827A0-60FD-4420-9690-854E12D8BD05}';


{ TAuthUtils }

class function TAuthUtils.AuthLicenceKey: string;
begin
  result := Auth_Licence_Key;
end;

class function TAuthUtils.AuthLicenceValue: string;
begin
  result := Auth_Licence_Value;
end;

class function TAuthUtils.AuthSystemKey: string;
begin
  result := Auth_System_Key;
end;

class function TAuthUtils.AuthSystemValue: string;
begin
  result := Auth_System_Value;
end;

end.
