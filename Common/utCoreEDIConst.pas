unit utCoreEDIConst;

interface

const
{ common JSON name }
       Name_UserMessage = 'UserMessage';
       Name_APIMessage  = 'APIMessage';
       Name_ReturnCode  = 'ReturnCode';
       Name_AuthURL     = 'AuthURL';
       Name_Command     = 'Command';
       Name_CurrentTask = 'CurrentTask';

{ return codes }
      Return_Code_Ok              = 'Ok';
      Return_Code_Error           = 'Error';
      Return_Unknown_Type         = 'UnknownType';
      Return_Code_UserAuthRequired= 'UserAuthRequired';

{Misc}
      UserTokenifnotExpirein = 5;
      WalmartUserTokenifnotExpirein =2; //walmart token is only walid for 15 mnts


{EDI servicenames}
      Servicename_Magento     = 'Magento';
      Servicename_Quickbooks  = 'Quickbooks';
      Servicename_Walmart     = 'Walmart';
      Servicename_EDI         = 'EDI';
      Servicename_AvaTax      = 'AvaTax';
      Servicename_WooComm     = 'WooCommerce';
      Servicename_Route4Me    = 'Route4Me';
      Servicename_Sage        = 'Sage';


{Request command Paramss}
      GetData_Req_Type_SynchOrders    = 'Synch Orders';
      GetData_Req_Type_SynchProducts  = 'Synch Products';
      GetData_Req_Type_SynchCustomers = 'Synch Customers';
      SetData_Req_Type_UploadProduct  = 'Upload Products';


implementation

end.
