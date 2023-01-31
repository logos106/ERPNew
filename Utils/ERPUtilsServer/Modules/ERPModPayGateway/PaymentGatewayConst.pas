unit PaymentGatewayConst;

interface

const
  Gateway_Stripe = 'Stripe';
  Gateway_PaymentExpress = 'Payment Express';
  Gateway_Payeezy = 'Payeezy';
  Gateway_TransactionExpress = 'Transaction Express';


  { Payment Express transaction types (TxnType) }
  PX_TxnType_Auth =     'Auth';     {Authorise - amount is authorised no funds transferred.}
  PX_TxnType_Complete = 'Complete'; {Complete a previous authorisation - funds are transferred.}
  PX_TxnType_Purchase = 'Purchase'; {Purchase - Funds are transferred immediately.}
  PX_TxnType_Refund =   'Refund';   {Refund - Funds transferred immediately. Must be enabled as a special option.}
  PX_TxnTypeValidate =  'Validate'; {Validation Transaction (see documentation)}

  { Payeezy Types .. }
  PZ_TxnType_Purchase =                 '00';
  PZ_TxnType_PreAuthorization =         '01';
  PZ_TxnType_Refund =                   '04';
  PZ_TxnType_Void =                     '13';
  PZ_TxnType_TaggedPreAuthCompletion =  '32';
  PZ_TxnType_TaggedVoid =               '33';
  PZ_TxnType_TaggedRefund =             '34';

  { Transaction Express Types .. }
//  TX_TransType_AuthAndSettle = '1';


implementation

end.
