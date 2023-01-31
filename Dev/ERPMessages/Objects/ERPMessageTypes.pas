unit ERPMessageTypes;

interface

const
  ERPMESSAGE_TIP      = 'Tips';
  ERPMESSAGE_FEATURE  = 'Feature';
  ERPMESSAGE_Bug      = 'Bug';
  ERPMESSAGE_Popup    = 'Popup';
  ERPMESSAGE_Tablet   = 'Tablet';
  ERPMESSAGE_Website  = 'Website';

type

  TERPMessageType =(mtBug =1 , mtFeature =2 , mtWebsite=3, mtTablet=4,  mtPopup =5, mtTip = 6);

  Function ERPMessageTypeToStr(const Value : TERPMessageType):String;


implementation

Function ERPMessageTypeToStr(const Value : TERPMessageType):String;
begin
       if Value = mtBug       then result := ERPMESSAGE_Bug
  else if Value = mtFeature   then result := ERPMESSAGE_FEATURE
  else if Value = mtFeature   then result := ERPMESSAGE_Website
  else if Value = mtFeature   then result := ERPMESSAGE_Tablet
  else if Value = mtPopup     then result := ERPMESSAGE_Popup
  else if Value = mtTip       then result := ERPMESSAGE_TIP;
end;


end.
